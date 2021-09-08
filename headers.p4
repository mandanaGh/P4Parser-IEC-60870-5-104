
typedef bit<48> EthernetAddress;
typedef bit<32> IPv4Address;

header ethernet_t {
    EthernetAddress dst_addr;
    EthernetAddress src_addr;
    bit<16>         ether_type;
}

header ipv4_t {
    bit<4>      version;
    bit<4>      ihl;
    bit<8>      diffserv;
    bit<16>     total_len;
    bit<16>     identification;
    bit<3>      flags;
    bit<13>     frag_offset;
    bit<8>      ttl;
    bit<8>      protocol;
    bit<16>     hdr_checksum;
    IPv4Address src_addr;
    IPv4Address dst_addr;
}

header tcp_t {
    bit<16> srcPort;
    bit<16> dstPort;
    bit<32> seqNo;
    bit<32> ackNo;
    bit<4> dataOffset;
    bit<3> res;
    bit<3> ecn;
    bit<6> ctrl;
    bit<16> window;
    bit<16> checksum;
    bit<16> urgentPtr;
    //bit<96> options;
}

// IEC 60870-5-104 frame type
header apci_frametype_t {
    bit<8>      start;          /* START */
    bit<8>      apdu_len;       /* Length of APDU */
    bit<8>      octet_1;      /*  In the case of U-frame, this field contains U-frame functions for activation and confirmation mechanism of TESTFR, STOPDT, and STARTDT.
                                  In the case of I-frame, this field represents Send sequence number, LSB*/
}

//IEC 60870-5-104 sequence numbers
header apci_sequenceNums_t {
    bit<8>      octet_2;        /* Send sequence number, MSB (sendMSB) */
    bit<8>      octet_3;        /* Receive sequence number, LSB (receiveLSB)*/
    bit<8>      octet_4;        /* Receive sequence number, MSB (receiveMSB)*/
}

//IEC 60870-5-104 data unit identifier
header asdu_header_t {
    bit<8>    typeid;   /* Type identification */
    bit<1>    sq;       /* Structure qualifier */
    bit<7>    numIx;    /* Number of objects or elements */
    bit<1>    test;     /* Test bit */
    bit<1>    posNeg;   /* Positive or Negative bit */
    bit<6>    causeTx;  /* Cause of transmission */
    bit<8>    oa;       /* Originator address */
    bit<16>   addr;     /* ASDU addres fields */
}

//IEC 60870-5-104 information objects
header asdu_objectInfo_t {
    bit<24>   ioa;      /* Information objects address fields */
    varbit<200>      info_element; //the size should be adjusted according to the configuration
}


struct headers_t {
    ethernet_t ethernet;
    ipv4_t     ipv4;
    tcp_t      tcp;
    apci_frametype_t     apci_frametype;
    apci_sequenceNums_t  apci_sequenceNums;
    asdu_header_t        asdu_header;
    asdu_objectInfo_t[MAX_INFO_OBJECTS]   asdu_objectInfo;
}

struct metadata_t {
    bit<2>      frame_type;      // I_frame = 0x0 or 0x2;   S_frame = 0x1;      U_frame = 0x3;
    bit<15>     send_sq;         //15-bits send sequence number
    bit<15>     receive_sq;      //15-bits receive sequence number
    bit<8>      reg_val;
    bit<16>     index;
    bit<7>      temp_counter;
    bit<8>      length_info_elements;

    bool        iec104_type_I;
    bool        iec104_type_S;
    bool        iec104_type_U;
    bool        testfr_act;
    bool        testfr_con;
    bool        startdt_act;
    bool        startdt_con;
    bool        stopdt_act;
    bool        stopdt_con;
    bool        new_attack;
}


struct asdu_types{
    bit<8>      val;     /* asdu_typeId */
    bit<8>      len;     /* asdu_typeId_length */
}

const asdu_types TYPEID_1 =  {  M_SP_NA_1,	 1 };
const asdu_types TYPEID_3 =	 {  M_DP_NA_1,	 1 };
const asdu_types TYPEID_5 =	 {  M_ST_NA_1,	 2 };
const asdu_types TYPEID_7 =	 {  M_BO_NA_1,	 5 };
const asdu_types TYPEID_9 =	 {  M_ME_NA_1,	 3 };
const asdu_types TYPEID_11 =  {  M_ME_NB_1,	 3 };
const asdu_types TYPEID_13 =  {  M_ME_NC_1,	 5 };
const asdu_types TYPEID_15 =  {  M_IT_NA_1,	 5 };
const asdu_types TYPEID_20 =  {  M_PS_NA_1,	 5 };
const asdu_types TYPEID_21 =  {  M_ME_ND_1,	 2 };
const asdu_types TYPEID_30 =  {  M_SP_TB_1,	 8 };
const asdu_types TYPEID_31 =  {  M_DP_TB_1,	 8 };
const asdu_types TYPEID_32 =  {  M_ST_TB_1,	 9 };
const asdu_types TYPEID_33 =  {  M_BO_TB_1,	12 };
const asdu_types TYPEID_34 =  {  M_ME_TD_1,	10 };
const asdu_types TYPEID_35 =  {  M_ME_TE_1,	10 };
const asdu_types TYPEID_36 =  {  M_ME_TF_1,	12 };
const asdu_types TYPEID_37 =  {  M_IT_TB_1,	12 };
const asdu_types TYPEID_38 =  {  M_EP_TD_1,	10 };
const asdu_types TYPEID_39 =  {  M_EP_TE_1,	11 };
const asdu_types TYPEID_40 =  {  M_EP_TF_1,	11 };
const asdu_types TYPEID_45 =  {  C_SC_NA_1,	 1 };
const asdu_types TYPEID_46 =  {  C_DC_NA_1,	 1 };
const asdu_types TYPEID_47 =  {  C_RC_NA_1,	 1 };
const asdu_types TYPEID_48 =  {  C_SE_NA_1,	 3 };
const asdu_types TYPEID_49 =  {  C_SE_NB_1,	 3 };
const asdu_types TYPEID_50 =  {  C_SE_NC_1,	 5 };
const asdu_types TYPEID_51 =  {  C_BO_NA_1,	 4 };
const asdu_types TYPEID_58 =  {  C_SC_TA_1,	 8 };
const asdu_types TYPEID_59 =  {  C_DC_TA_1,	 8 };
const asdu_types TYPEID_60 =  {  C_RC_TA_1,	 8 };
const asdu_types TYPEID_61 =  {  C_SE_TA_1,	10 };
const asdu_types TYPEID_62 =  {  C_SE_TB_1,	10 };
const asdu_types TYPEID_63 =  {  C_SE_TC_1,	12 };
const asdu_types TYPEID_64 =  {  C_BO_TA_1,	11 };
const asdu_types TYPEID_70 =  {  M_EI_NA_1,	 1 };
const asdu_types TYPEID_100 =  {  C_IC_NA_1,	 1 };
const asdu_types TYPEID_101 =  {  C_CI_NA_1,	 1 };
const asdu_types TYPEID_102 =  {  C_RD_NA_1,	 0 };
const asdu_types TYPEID_103 =  {  C_CS_NA_1,	 7 };
const asdu_types TYPEID_105 =  {  C_RP_NA_1,	 1 };
const asdu_types TYPEID_107 =  {  C_TS_TA_1,	 9 };
const asdu_types TYPEID_110 =  {  P_ME_NA_1,	 3 };
const asdu_types TYPEID_111 =  {  P_ME_NB_1,	 3 };
const asdu_types TYPEID_112 =  {  P_ME_NC_1,	 5 };
const asdu_types TYPEID_113 =  {  P_AC_NA_1,	 1 };
const asdu_types TYPEID_120 =  {  F_FR_NA_1,	 6 };
const asdu_types TYPEID_121 =  {  F_SR_NA_1,	 7 };
const asdu_types TYPEID_122 =  {  F_SC_NA_1,	 4 };
const asdu_types TYPEID_123 =  {  F_LS_NA_1,	 5 };
const asdu_types TYPEID_124 =  {  F_AF_NA_1,	 4 };
const asdu_types TYPEID_125 =  {  F_SG_NA_1,	 0 };
const asdu_types TYPEID_126 =  {  F_DR_TA_1,	13 };
const asdu_types TYPEID_127 =  {  F_SC_NB_1,	16 };



//register<bit<24>>(1) myReg;
