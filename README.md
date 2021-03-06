# P4Parser-IEC-60870-5-104
A P4 parser for deep packet inspection of IEC-60870-5-104 protocol.

## IEC 60870 5-104 frame format
Every IEC-104 packet, a so-called Application Protocol Data Unit (APDU) contains a header called Application Protocol Control Information (APCI). APCI starts with a start byte with value 0x68 followed by the 8-bit length of APDU and four 8-bit control fields
(CF). APDU contains an APCI or an APCI with ASDU. Generally, the length of APCI is 6
bytes.
<p align="center">
<img src="https://github.com/mandanaGh/P4Parser-IEC-60870-5-104/blob/main/images/Screenshot%202021-09-08%20at%2013.40.38.png" width="600"></p>
The frame format is determined by the two last bits of the first control field (CF1). The standard defines three frame format. 

<b>S-frames</b> (for numbered supervisory functions) and <b>U-frames</b> (for unnumbered control functions) are built from only the APCI. <b>I-frames</b> (used for information transfer), consist additionally of Application Service Data Units (ASDUs). ASDUs determine what kind of function (the so-called Type ID) they carry. They can contain up to 127 Information Objects (IOs), referring to different addresses on the RTU that is being controlled. The below figure shows the format of ASDUs.
<p align="center">
<img src="https://github.com/mandanaGh/P4Parser-IEC-60870-5-104/blob/main/images/Screenshot%202021-09-08%20at%2014.04.08.png" width="350"></p>

## How to use the code
The IEC104Parser.p4 should be compiled and executed in bmv2 target.

Tested on bmv2 with target simple_switch.
