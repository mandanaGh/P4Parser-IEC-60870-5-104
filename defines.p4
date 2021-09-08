
/*U (Unnumbered) constants **********************************************************************************************/
#define U_STARTDT_ACT 		0x07     /* start data transfer activation 													*/
#define U_STARTDT_CON	 	0x0B     /* start data transfer confirmation												*/
#define U_STOPDT_ACT 		0x13     /* stop data transfer activation 													*/
#define U_STOPDT_CON	 	0x23     /* stop data transfer confirmation 												*/
#define U_TESTFR_ACT 		0x43     /* test frame activation 															*/
#define U_TESTFR_CON	 	0x83     /* test frame confirmation 														*/

/* APCI types */
#define I_TYPE		0x00
#define S_TYPE		0x01
#define U_TYPE		0x03

#define MAX_INFO_OBJECTS 20

/*ASDU types (TypeId) ***********************************************************************************************/
#define M_SP_NA_1  1      /* single-point information 																*/
#define M_DP_NA_1  3      /* double-point information 																*/
#define M_ST_NA_1  5      /* step position information 																*/
#define M_BO_NA_1  7      /* bitstring of 32 bits 																	*/
#define M_ME_NA_1  9      /* measured value, normalized value 														*/
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
#define F_SC_NB_1  127 	  /* Query Log - Request archive file 														*/
