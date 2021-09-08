# P4Parser-IEC-60870-5-104
A P4 parser for deep packet inspection of IEC-60870-5-104 protocol.

# IEC 60870 5-104 frame format
Every IEC-104 packet, a so-called Application Protocol Data Unit (APDU) contains a header called Application Protocol Control Information (APCI). APCI starts with a start byte with value 0x68 followed by the 8-bit length of APDU and four 8-bit control fields
(CF). APDU contains an APCI or an APCI with ASDU. Generally, the length of APCI is 6
bytes.
<p align="center">
<img src="https://github.com/mandanaGh/P4Parser-IEC-60870-5-104/blob/main/images/Screenshot%202021-09-08%20at%2013.40.38.png" width="600"></p>
The frame format is determined by the two last bits of the first control field (CF1). The standard defines three frame format. 

<b>S-frames</b> (for numbered supervisory functions) and <b>U-frames</b> (for unnumbered control functions) are built from only the APCI. <b>I-frames</b> (used for information transfer), consist additionally of Application Service Data Units (ASDUs). ASDUs determine what kind of function (the so-called Type ID) they carry. They can contain up to 127 Information Objects (IOs), referring to different addresses on the RTU that is being controlled. The below figure shows the format of ASDUs.
<p align="center">
<img src="https://github.com/mandanaGh/P4Parser-IEC-60870-5-104/blob/main/images/Screenshot%202021-09-08%20at%2014.04.08.png" width="350"></p>

# Standard IEC 60870-5-104 ASDU - Typeids 

M_SP_NA_1  1      /* single-point information 																*/

M_DP_NA_1  3      /* double-point information 																*/

M_ST_NA_1  5      /* step position information 																*/

M_BO_NA_1  7      /* bitstring of 32 bits 																	*/

M_ME_NA_1  9      /* measured value, normalized value 														*/

#define M_ME_NB_1  11     /* measured value, scaled value 															*/
#define M_ME_NC_1  13     /* measured value, short floating point number 											*/
#define M_IT_NA_1  15     /* integrated totals 																		*/
#define M_PS_NA_1  20     /* packed single-point information with status change detection 							*/
#define M_ME_ND_1  21     /* measured value, normalized value without quality descriptor 							*/
#define M_SP_TB_1  30     /* single-point information with time tag CP56Time2a 										*/
#define M_DP_TB_1  31     /* double-point information with time tag CP56Time2a 										*/
#define M_ST_TB_1  32     /* step position information with time tag CP56Time2a 									*/
#define M_BO_TB_1  33     /* bitstring of 32 bit with time tag CP56Time2a 											*/
#define M_ME_TD_1  34     /* measured value, normalized value with time tag CP56Time2a 								*/
#define M_ME_TE_1  35     /* measured value, scaled value with time tag CP56Time2a 									*/
#define M_ME_TF_1  36     /* measured value, short floating point number with time tag CP56Time2a 					*/
#define M_IT_TB_1  37     /* integrated totals with time tag CP56Time2a 											*/
#define M_EP_TD_1  38     /* event of protection equipment with time tag CP56Time2a 								*/
#define M_EP_TE_1  39     /* packed start events of protection equipment with time tag CP56Time2a 					*/
#define M_EP_TF_1  40     /* packed output circuit information of protection equipment with time tag CP56Time2a 	*/
#define C_SC_NA_1  45     /* single command 																		*/
#define C_DC_NA_1  46     /* double command 																		*/
#define C_RC_NA_1  47     /* regulating step command 																*/
#define C_SE_NA_1  48     /* set point command, normalized value 													*/
#define C_SE_NB_1  49     /* set point command, scaled value 														*/
#define C_SE_NC_1  50     /* set point command, short floating point number 										*/
#define C_BO_NA_1  51     /* bitstring of 32 bits 																	*/
#define C_SC_TA_1  58     /* single command with time tag CP56Time2a 												*/
#define C_DC_TA_1  59     /* double command with time tag CP56Time2a 												*/
#define C_RC_TA_1  60     /* regulating step command with time tag CP56Time2a 										*/
#define C_SE_TA_1  61     /* set point command, normalized value with time tag CP56Time2a 							*/
#define C_SE_TB_1  62     /* set point command, scaled value with time tag CP56Time2a 								*/
#define C_SE_TC_1  63     /* set point command, short floating-point number with time tag CP56Time2a 				*/
#define C_BO_TA_1  64     /* bitstring of 32 bits with time tag CP56Time2a 											*/
#define M_EI_NA_1  70     /* end of initialization 																	*/
#define C_IC_NA_1  100    /* interrogation command 																	*/
#define C_CI_NA_1  101    /* counter interrogation command 															*/
#define C_RD_NA_1  102    /* read command 																			*/
#define C_CS_NA_1  103    /* clock synchronization command 															*/
#define C_RP_NA_1  105    /* reset process command 																	*/
#define C_TS_TA_1  107    /* test command with time tag CP56Time2a 													*/
#define P_ME_NA_1  110    /* parameter of measured value, normalized value 											*/
#define P_ME_NB_1  111    /* parameter of measured value, scaled value 												*/
#define P_ME_NC_1  112    /* parameter of measured value, short floating-point number 								*/
#define P_AC_NA_1  113    /* parameter activation 																	*/
#define F_FR_NA_1  120    /* file ready 																			*/
#define F_SR_NA_1  121    /* section ready 																			*/
#define F_SC_NA_1  122    /* call directory, select file, call file, call section 									*/
#define F_LS_NA_1  123    /* last section, last segment 															*/
#define F_AF_NA_1  124    /* ack file, ack section 																	*/
#define F_SG_NA_1  125    /* segment 																				*/
#define F_DR_TA_1  126    /* directory 																				*/
#define F_SC_NB_1  127 	  /* Query Log - Request archive file 	
