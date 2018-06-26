// Copyright 2017, 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////
// Company:        IIS @ ETHZ - Federal Institute of Technology               //
//                                                                            //
// Engineers:      Lukas Mueller -- lukasmue@student.ethz.ch                  //
//                 Thomas Gautschi -- gauthoma@student.ethz.ch                //
//                                                                            //
// Additional contributions by:                                               //
//                 Torbjørn Viem Ness -- torbjovn@stud.ntnu.no                //
//                                                                            //
//                                                                            //
// Create Date:    26/10/2014                                                 //
// Design Name:    FPU                                                        //
// Module Name:    riscv_fpu.sv                                               //
// Project Name:   Private FPU                                                //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    Floating point unit with input and ouput registers         //
//                                                                            //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
//                15/05/2018                                                  //
//                Pass package parameters as default args instead of using    //
//                them directly, improves compatibility with tools like       //  
//                Synopsys Spyglass and DC (GitHub #7) - Torbjørn Viem Ness   //
//                                                                            //
//                26/06/2018                                                  //
//                Updated ready and valid signals to be set like in the larger//
//                fpu_private variant - Torbjørn Viem Ness                    //
////////////////////////////////////////////////////////////////////////////////

import fpu_defs::*;

module riscv_fpu
#(
   parameter C_OP  = fpu_defs::C_OP,
   parameter C_RM  = fpu_defs::C_RM,
   parameter C_CMD = fpu_defs::C_CMD
)
  (
   //Clock and reset
   input logic             clk,
   input logic             rst_n,

   //Input Operands
   input logic [C_OP-1:0]  operand_a_i,
   input logic [C_OP-1:0]  operand_b_i,
   input logic [C_RM-1:0]  rounding_mode_i,    //Rounding Mode
   input logic [C_CMD-1:0] operator_i,
   input logic             enable_i,

   input logic             stall_i, // Currently does nothing, the fpu_core module is single-cycle anyway. Left in order to not break depending modules

   output logic [C_OP-1:0] result_o,
   //Output-Flags
   output logic            fpu_ready_o,   // high if fpu is ready
   output logic            result_valid_o // result is valid
   );
   
   assign fpu_ready_o = (!enable_i || result_valid_o);

   /////////////////////////////////////////////////////////////////////////////
   // FPU_core                                                                //
   /////////////////////////////////////////////////////////////////////////////

  fpu_core fpcore
     (
      .Clk_CI        ( clk              ),
      .Rst_RBI       ( rst_n            ),
      .Enable_SI     ( enable_i         ),

      .Operand_a_DI  ( operand_a_i      ),
      .Operand_b_DI  ( operand_b_i      ),
      .RM_SI         ( rounding_mode_i  ),
      .OP_SI         ( operator_i       ),

      .Result_DO     ( result_o         ),
      .Valid_SO      ( result_valid_o   ),

      .OF_SO         (                  ),
      .UF_SO         (                  ),
      .Zero_SO       (                  ),
      .IX_SO         (                  ),
      .IV_SO         (                  ),
      .Inf_SO        (                  )
      );

endmodule // fpu
