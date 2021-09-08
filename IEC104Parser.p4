#include <core.p4>
#include <v1model.p4>
#include "defines.p4"
#include "headers.p4"


error {
    IPv4IncorrectVersion,
    IPv4OptionsNotSupported
}

parser ParserImpl(packet_in packet,
                out headers_t hdr,
                inout metadata_t meta,
                inout standard_metadata_t standard_meta)
{

    state start {
        packet.extract(hdr.ethernet);
        transition select(hdr.ethernet.ether_type) {
            0x0800:  parse_ipv4;
            default: accept;
        }
    }

    state parse_ipv4 {
        packet.extract(hdr.ipv4);
        verify(hdr.ipv4.version == 4w4, error.IPv4IncorrectVersion);
        verify(hdr.ipv4.ihl == 4w5, error.IPv4OptionsNotSupported);
        transition parse_tcp;
    }

    state parse_tcp {
        packet.extract(hdr.tcp);
        transition parse_apci_frametype;
    }

    state parse_apci_frametype {
        packet.extract(hdr.apci_frametype);
        //initialization
        meta.iec104_type_I = false;
        meta.iec104_type_S = false;
        meta.iec104_type_U = false;

        meta.frame_type = hdr.apci_frametype.octet_1[1:0];
        if (meta.frame_type == 0x3){ //U-Format
            meta.iec104_type_U = true;
        } else if (meta.frame_type == 0x1){ // S-Format
            meta.iec104_type_S = true;
        } else if (meta.frame_type == 0x0 || meta.frame_type == 0x2){ // I-Format
            meta.iec104_type_I = true;
        }
        if (meta.iec104_type_U){
            if (hdr.apci_frametype.octet_1 == U_STARTDT_ACT){
                meta.startdt_act = true;
            } else if (hdr.apci_frametype.octet_1 == U_STARTDT_CON){
                meta.startdt_con = true;
            } else if (hdr.apci_frametype.octet_1 == U_STOPDT_ACT){
                meta.stopdt_act = true;
            } else if (hdr.apci_frametype.octet_1 == U_STOPDT_CON){
                meta.stopdt_con = true;
            } else if (hdr.apci_frametype.octet_1 == U_TESTFR_ACT){
                meta.testfr_act = true;
            } else if (hdr.apci_frametype.octet_1 == U_TESTFR_CON){
                meta.testfr_con = true;
            } else {
                meta.new_attack = true; //  Wrong U-packet
            }
        }
        transition select (meta.iec104_type_U){
            true: accept;  //U-format packet
            default: parse_apci_sequenceNums;
        }
    }

    state parse_apci_sequenceNums {
        packet.extract(hdr.apci_sequenceNums);
        // Calculating send and receive sequence numbers
        meta.receive_sq = hdr.apci_sequenceNums.octet_4 ++ hdr.apci_sequenceNums.octet_3[7:1];
        if (meta.iec104_type_I) { // the packet is in I-format and sending sequence number should be calculated.
            meta.send_sq = hdr.apci_sequenceNums.octet_2 ++ hdr.apci_frametype.octet_1[7:1];
        }
        transition select (meta.iec104_type_S){
            true: accept;  // S-format packet
            default: parse_asdu_header; // I-format packet
        }
    }

    state parse_asdu_header {
        packet.extract(hdr.asdu_header);

        // getting the length of ASDU typeId
        bit<8> id = hdr.asdu_header.typeid;

        if (id == TYPEID_102.val || id == TYPEID_125.val){
            meta.length_info_elements = TYPEID_102.len;
        }
        else if (id == TYPEID_1.val || id == TYPEID_3.val || id == TYPEID_45.val || id == TYPEID_46.val || id == TYPEID_47.val || id == TYPEID_70.val || id == TYPEID_100.val || id == TYPEID_101.val || id == TYPEID_105.val || id == TYPEID_113.val){
            meta.length_info_elements = TYPEID_1.len;         // Length of information object elements is 1 byte.
        }
        else if (id == TYPEID_5.val || id == TYPEID_21.val){
            meta.length_info_elements = TYPEID_5.len;         // Length of information object elements is 2 bytes.
        }
        else if (id == TYPEID_9.val || id == TYPEID_11.val || id == TYPEID_48.val || id == TYPEID_49.val || id == TYPEID_110.val || id == TYPEID_111.val){
            meta.length_info_elements = TYPEID_9.len;         // Length of information object elements is 3 bytes.
        }
        else if (id == TYPEID_51.val || id == TYPEID_122.val || id == TYPEID_124.val){
            meta.length_info_elements = TYPEID_51.len;        // Length of information object elements is 4 bytes.
        }
        else if (id == TYPEID_7.val || id == TYPEID_13.val || id == TYPEID_15.val || id == TYPEID_20.val || id == TYPEID_50.val || id == TYPEID_112.val || id == TYPEID_123.val){
            meta.length_info_elements = TYPEID_7.len;         // Length of information object elements is 5 bytes.
        }
        else if (id == TYPEID_120.val){
            meta.length_info_elements = TYPEID_120.len;       // Length of information object elements is 6 bytes.
        }
        else if (id == TYPEID_103.val || id == TYPEID_121.val){
            meta.length_info_elements = TYPEID_103.len;       // Length of information object elements is 7 bytes.
        }
        else if (id == TYPEID_30.val || id == TYPEID_31.val || id == TYPEID_58.val || id == TYPEID_59.val || id == TYPEID_60.val){
            meta.length_info_elements = TYPEID_30.len;        // Length of information object elements is 8 bytes.
        }
        else if (id == TYPEID_32.val || id == TYPEID_107.val){
            meta.length_info_elements = TYPEID_32.len;        // Length of information object elements is 9 bytes.
        }
        else if (id == TYPEID_34.val || id == TYPEID_35.val || id == TYPEID_38.val || id == TYPEID_61.val || id == TYPEID_62.val){
            meta.length_info_elements = TYPEID_34.len;        // Length of information object elements is 10 bytes.
        }
        else if (id == TYPEID_39.val || id == TYPEID_40.val || id == TYPEID_64.val){
            meta.length_info_elements = TYPEID_39.len;        // Length of information object elements is 11 bytes.
        }
        else if (id == TYPEID_33.val || id == TYPEID_36.val || id == TYPEID_37.val || id == TYPEID_63.val){
            meta.length_info_elements = TYPEID_33.len;        // Length of information object elements is 12 bytes.
        }
        else if (id == TYPEID_126.val){
            meta.length_info_elements = TYPEID_126.len;       // Length of information object elements is 13 bytes.
        }
        else if (id == TYPEID_127.val){
            meta.length_info_elements = TYPEID_127.len;       // Length of information object elements is 16 bytes.
        }


        meta.temp_counter = hdr.asdu_header.numIx;
        transition select (meta.temp_counter){
            0: accept;
            default: parse_asdu_objectInfo;
        }
    }

    state parse_asdu_objectInfo {

        if (hdr.asdu_header.sq == 0x0){
            packet.extract(hdr.asdu_objectInfo.next, (bit<32>)(meta.length_info_elements * 8));
            meta.temp_counter = meta.temp_counter - 1;
        }
        else if (hdr.asdu_header.sq == 0x1){
            // Information object length = APDU_length - APDU_control_fields(4 bytes) - ASDU_header(6 bytes) - IOA (3 bytes) = APDU_length - 13 bytes.
            packet.extract(hdr.asdu_objectInfo.next, (bit<32>)((hdr.apci_frametype.apdu_len - 13) * 8));
            meta.temp_counter = 0;
        }
        transition select (meta.temp_counter){
            0: accept;
            default: parse_asdu_objectInfo;
        }
    }
}

/*********************************************************************************************************/

control ingress(inout headers_t hdr,
                  inout metadata_t meta,
                  inout standard_metadata_t standard_metadata)
{

    apply {

        /*if (hdr.asdu_header.isValid() && meta.iec104_type_I == true)
        {
            standard_metadata.egress_spec = 1;
        }*/
        /*if (meta.send_sq == 15w9 || meta.receive_sq == 15w32)
        {
            standard_metadata.egress_spec = 1;
        }*/
        /*if (hdr.asdu_header.isValid() && hdr.asdu_header.typeid == 8w103)
        {
            standard_metadata.egress_spec = 1;
        }*/
        /*if (hdr.asdu_header.isValid() && meta.length_info_elements == 1)
        {
            myReg.write(0, hdr.asdu_objectInfo[1].ioa);
            standard_metadata.egress_spec = 1;
        }*/

        /*if (hdr.asdu_header.isValid() && (hdr.asdu_header.addr[7:0] ++ hdr.asdu_header.addr[15:8]) == 1)
        {
            standard_metadata.egress_spec = 1;
        }*/
        bit<24> ioa_0 = hdr.asdu_objectInfo[0].ioa[7:0] ++ hdr.asdu_objectInfo[0].ioa[15:8] ++ hdr.asdu_objectInfo[0].ioa[23:16];
        bit<24> ioa_1 = hdr.asdu_objectInfo[1].ioa[7:0] ++ hdr.asdu_objectInfo[1].ioa[15:8] ++ hdr.asdu_objectInfo[1].ioa[23:16];
        bit<24> ioa_4 = hdr.asdu_objectInfo[4].ioa[7:0] ++ hdr.asdu_objectInfo[4].ioa[15:8] ++ hdr.asdu_objectInfo[4].ioa[23:16];

        if (hdr.asdu_objectInfo[0].isValid() && ioa_0 == 24w1773327 && ioa_1 == 24w1642255 && ioa_4 == 24w1052431)
        {
            standard_metadata.egress_spec = 1;
        }

        /*hash(meta.index, HashAlgorithm.csum16, (bit<16>)0, {

                hdr.ipv4.src_addr,
                hdr.ipv4.dst_addr,
                hdr.ipv4.protocol,
                hdr.tcp.srcPort,
                hdr.tcp.dstPort
        } , (bit<32>)16);

        myReg.read(meta.reg_val, 0);

        if (hdr.asdu_header.isValid() && (hdr.asdu_header.typeid == meta.reg_val))
        {
            myReg.write(0, 0x2D);
            standard_metadata.egress_spec = 1;
        } else {return;}*/
    }

}

control egress(inout headers_t hdr,
                 inout metadata_t meta,
                 inout standard_metadata_t standard_metadata)
{
    apply { }
}

control DeparserImpl(packet_out packet,
                   in headers_t hdr)
{
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.ipv4);
        packet.emit(hdr.tcp);
        packet.emit(hdr.apci_frametype);
        packet.emit(hdr.apci_sequenceNums);
        packet.emit(hdr.asdu_header);
        packet.emit(hdr.asdu_objectInfo);
    }
}

control verifyChecksum(inout headers_t hdr,
                         inout metadata_t meta)
{
    apply { }
}

control computeChecksum(inout headers_t hdr,
                          inout metadata_t meta)
{
    apply { }
}

V1Switch(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;
