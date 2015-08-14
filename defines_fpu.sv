////////////////////////////////////////////////////////////////////////////////
// Company:        IIS @ ETHZ - Federal Institute of Technology               //
//                                                                            //
// Engineers:      Lukas Mueller -- lukasmue@student.ethz.ch                  //
//                                                                            //
// Additional contributions by:                                               //
//                                                                            //
//                                                                            //
//                                                                            //
// Create Date:    08/10/2014                                                 // 
// Design Name:    FPU                                                        // 
// Module Name:    defines.sv                                                 //
// Project Name:   Private FPU                                                //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    Defines for the FPU                                        //
//                                                                            //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`define RM_NEAREST   2'h0
`define RM_TRUNC     2'h1
`define RM_PLUSINF   2'h2
`define RM_MINUSINF  2'h3

`define FP_OP_ADD    4'h0
`define FP_OP_SUB    4'h1
`define FP_OP_MUL    4'h2
`define FP_OP_DIV    4'h3
`define FP_OP_ITOF   4'h4
`define FP_OP_FTOI   4'h5