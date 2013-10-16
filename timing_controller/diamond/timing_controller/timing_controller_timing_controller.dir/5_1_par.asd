[ActiveSupport PAR]
; Global primary clocks
GLOBAL_PRIMARY_USED = 1;
; Global primary clock #0
GLOBAL_PRIMARY_0_SIGNALNAME = clk_i_c;
GLOBAL_PRIMARY_0_DRIVERTYPE = OSC;
GLOBAL_PRIMARY_0_LOADNUM = 221;
; # of global secondary clocks
GLOBAL_SECONDARY_USED = 4;
; Global secondary clock #0
GLOBAL_SECONDARY_0_SIGNALNAME = lm8_inst/uart/u_txmitt/tx_state[0];
GLOBAL_SECONDARY_0_DRIVERTYPE = SLICE;
GLOBAL_SECONDARY_0_LOADNUM = 14;
GLOBAL_SECONDARY_0_SIGTYPE = CE;
; Global secondary clock #1
GLOBAL_SECONDARY_1_SIGNALNAME = lm8_inst/LM8/rst_n;
GLOBAL_SECONDARY_1_DRIVERTYPE = SLICE;
GLOBAL_SECONDARY_1_LOADNUM = 66;
GLOBAL_SECONDARY_1_SIGTYPE = RST;
; Global secondary clock #2
GLOBAL_SECONDARY_2_SIGNALNAME = pat_gen/N_125;
GLOBAL_SECONDARY_2_DRIVERTYPE = SLICE;
GLOBAL_SECONDARY_2_LOADNUM = 8;
GLOBAL_SECONDARY_2_SIGTYPE = CLK;
; Global secondary clock #3
GLOBAL_SECONDARY_3_SIGNALNAME = rst_i;
GLOBAL_SECONDARY_3_DRIVERTYPE = SLICE;
GLOBAL_SECONDARY_3_LOADNUM = 16;
GLOBAL_SECONDARY_3_SIGTYPE = RST;
; I/O Bank 0 Usage
BANK_0_USED = 5;
BANK_0_AVAIL = 28;
BANK_0_VCCIO = 2.5V;
BANK_0_VREF1 = NA;
; I/O Bank 1 Usage
BANK_1_USED = 9;
BANK_1_AVAIL = 29;
BANK_1_VCCIO = 3.3V;
BANK_1_VREF1 = NA;
; I/O Bank 2 Usage
BANK_2_USED = 16;
BANK_2_AVAIL = 29;
BANK_2_VCCIO = 3.3V;
BANK_2_VREF1 = NA;
; I/O Bank 3 Usage
BANK_3_USED = 1;
BANK_3_AVAIL = 9;
BANK_3_VCCIO = 2.5V;
BANK_3_VREF1 = NA;
; I/O Bank 4 Usage
BANK_4_USED = 0;
BANK_4_AVAIL = 10;
BANK_4_VCCIO = NA;
BANK_4_VREF1 = NA;
; I/O Bank 5 Usage
BANK_5_USED = 0;
BANK_5_AVAIL = 10;
BANK_5_VCCIO = NA;
BANK_5_VREF1 = NA;
