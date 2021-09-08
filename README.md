# P4Parser-IEC-60870-5-104
A P4-based packet parser for IEC-60870-5-104 protocol.

# Overview
Every IEC-104 packet, a so-called Application Protocol Data Unit (APDU), contains a header called Application Protocol Control Information (APCI). S-frames (for numbered supervisory functions) and U-frames (for unnumbered control functions) are built from only the APCI. I-frames (used for information transfer), consist additionally of Application Service Data Units (ASDUs). ASDUs determine what kind of function (the so-called Type ID) they carry. They can contain up to 127 Information Objects (IOs), referring to different addresses on the RTU that is being controlled.
