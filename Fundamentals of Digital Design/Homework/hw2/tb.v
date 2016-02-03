#! c:/iverilog-x86/bin/vvp
:ivl_version "10.0 (stable)" "(v10_0)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "system";
:vpi_module "vhdl_sys";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_02841928 .scope module, "EightBitMagComp_tb" "EightBitMagComp_tb" 2 23;
 .timescale 0 0;
v0287ba60_0 .var "a", 7 0;
v0287ba08_0 .var "b", 7 0;
v0287bd20_0 .net "eq", 0 0, L_0287ec48;  1 drivers
v0287bcc8_0 .net "gt", 0 0, L_0287ee88;  1 drivers
v0287b9b0_0 .net "lt", 0 0, L_0287eb28;  1 drivers
S_0094beb0 .scope module, "eightBitMagComp" "EightBitMagComp" 2 27, 2 11 0, S_02841928;
 .timescale 0 0;
    .port_info 0 /INPUT 8 "a"
    .port_info 1 /INPUT 8 "b"
    .port_info 2 /OUTPUT 1 "eq"
    .port_info 3 /OUTPUT 1 "lt"
    .port_info 4 /OUTPUT 1 "gt"
L_0287ec48 .functor AND 1, L_02840ed8, L_028407d0, C4<1>, C4<1>;
L_0287ef60 .functor AND 1, L_02840ed8, L_028407d0, C4<1>, C4<1>;
L_0287f398 .functor AND 1, L_0287ef60, L_028408f0, C4<1>, C4<1>;
L_0287ee88 .functor OR 1, L_02840818, L_0287f398, C4<0>, C4<0>;
L_0287ec90 .functor NOT 1, L_0287ec48, C4<0>, C4<0>, C4<0>;
L_0287eff0 .functor NOT 1, L_0287ee88, C4<0>, C4<0>, C4<0>;
L_0287eb28 .functor AND 1, L_0287ec90, L_0287eff0, C4<1>, C4<1>;
v0287b0c0_0 .net *"_s10", 0 0, L_0287ef60;  1 drivers
v0287b748_0 .net *"_s12", 0 0, L_0287f398;  1 drivers
v0287b010_0 .net *"_s16", 0 0, L_0287ec90;  1 drivers
v0287b3d8_0 .net *"_s18", 0 0, L_0287eff0;  1 drivers
v0287b430_0 .net "a", 7 0, v0287ba60_0;  1 drivers
v0287b698_0 .net "b", 7 0, v0287ba08_0;  1 drivers
v0287b850_0 .net "eq", 0 0, L_0287ec48;  alias, 1 drivers
v0287b488_0 .net "gt", 0 0, L_0287ee88;  alias, 1 drivers
v0287aeb0_0 .net "lt", 0 0, L_0287eb28;  alias, 1 drivers
v0287af08_0 .net "tempEQ1", 0 0, L_02840ed8;  1 drivers
v0287b4e0_0 .net "tempEQ2", 0 0, L_028407d0;  1 drivers
v0287b6f0_0 .net "tempGT1", 0 0, L_02840818;  1 drivers
v0287afb8_0 .net "tempGT2", 0 0, L_028408f0;  1 drivers
v0287bc70_0 .net "tempLT1", 0 0, L_02840a10;  1 drivers
v0287b958_0 .net "tempLT2", 0 0, L_028408a8;  1 drivers
L_0287ccd8 .part v0287ba60_0, 4, 4;
L_0287d258 .part v0287ba08_0, 4, 4;
L_0287cbd0 .part v0287ba60_0, 0, 4;
L_0287d728 .part v0287ba08_0, 0, 4;
S_0094bf80 .scope module, "first4BitMagComp" "FourBitMagComp" 2 15, 2 1 0, S_0094beb0;
 .timescale 0 0;
    .port_info 0 /INPUT 4 "a"
    .port_info 1 /INPUT 4 "b"
    .port_info 2 /OUTPUT 1 "eq"
    .port_info 3 /OUTPUT 1 "lt"
    .port_info 4 /OUTPUT 1 "gt"
L_028413e8 .functor XNOR 4, L_0287ccd8, L_0287d258, C4<0000>, C4<0000>;
L_02840e90 .functor AND 1, L_0287b8a8, L_0287bab8, C4<1>, C4<1>;
L_02841358 .functor AND 1, L_02840e90, L_0287bc18, C4<1>, C4<1>;
L_02840ed8 .functor AND 1, L_02841358, L_0287b900, C4<1>, C4<1>;
L_02841280 .functor NOT 1, L_0287bb10, C4<0>, C4<0>, C4<0>;
L_02840f20 .functor AND 1, L_02841280, L_0287bb68, C4<1>, C4<1>;
L_02840fb0 .functor NOT 1, L_0287cd88, C4<0>, C4<0>, C4<0>;
L_02841118 .functor AND 1, L_0287bbc0, L_02840fb0, C4<1>, C4<1>;
L_028412c8 .functor AND 1, L_02841118, L_0287d2b0, C4<1>, C4<1>;
L_02841310 .functor OR 1, L_02840f20, L_028412c8, C4<0>, C4<0>;
L_02840f68 .functor AND 1, L_0287cde0, L_0287d0a0, C4<1>, C4<1>;
L_02841160 .functor NOT 1, L_0287cc28, C4<0>, C4<0>, C4<0>;
L_02840ff8 .functor AND 1, L_02840f68, L_02841160, C4<1>, C4<1>;
L_02841088 .functor AND 1, L_02840ff8, L_0287cac8, C4<1>, C4<1>;
L_02841238 .functor OR 1, L_02841310, L_02841088, C4<0>, C4<0>;
L_028411a8 .functor AND 1, L_0287ce38, L_0287cf98, C4<1>, C4<1>;
L_02840548 .functor AND 1, L_028411a8, L_0287d048, C4<1>, C4<1>;
L_02840c08 .functor NOT 1, L_0287cc80, C4<0>, C4<0>, C4<0>;
L_02840590 .functor AND 1, L_02840548, L_02840c08, C4<1>, C4<1>;
L_02840d70 .functor AND 1, L_02840590, L_0287ce90, C4<1>, C4<1>;
L_02840a10 .functor OR 1, L_02841238, L_02840d70, C4<0>, C4<0>;
L_02840c50 .functor NOT 1, L_02840ed8, C4<0>, C4<0>, C4<0>;
L_02840938 .functor NOT 1, L_02840a10, C4<0>, C4<0>, C4<0>;
L_02840818 .functor AND 1, L_02840c50, L_02840938, C4<1>, C4<1>;
v0283baf0_0 .net *"_s10", 0 0, L_02841358;  1 drivers
v0283bdb0_0 .net *"_s13", 0 0, L_0287b900;  1 drivers
v0283bb48_0 .net *"_s17", 0 0, L_0287bb10;  1 drivers
v0283bbf8_0 .net *"_s18", 0 0, L_02841280;  1 drivers
v0283be08_0 .net *"_s21", 0 0, L_0287bb68;  1 drivers
v0283bf10_0 .net *"_s22", 0 0, L_02840f20;  1 drivers
v0283be60_0 .net *"_s25", 0 0, L_0287bbc0;  1 drivers
v0283bc50_0 .net *"_s27", 0 0, L_0287cd88;  1 drivers
v0283b570_0 .net *"_s28", 0 0, L_02840fb0;  1 drivers
v0283c3e0_0 .net *"_s3", 0 0, L_0287b8a8;  1 drivers
v0283c2d8_0 .net *"_s30", 0 0, L_02841118;  1 drivers
v0283c120_0 .net *"_s33", 0 0, L_0287d2b0;  1 drivers
v0283c490_0 .net *"_s34", 0 0, L_028412c8;  1 drivers
v0283c178_0 .net *"_s36", 0 0, L_02841310;  1 drivers
v0283c018_0 .net *"_s39", 0 0, L_0287cde0;  1 drivers
v0283c1d0_0 .net *"_s41", 0 0, L_0287d0a0;  1 drivers
v0283c438_0 .net *"_s42", 0 0, L_02840f68;  1 drivers
v0283c0c8_0 .net *"_s45", 0 0, L_0287cc28;  1 drivers
v0283c330_0 .net *"_s46", 0 0, L_02841160;  1 drivers
v0283c228_0 .net *"_s48", 0 0, L_02840ff8;  1 drivers
v0283c388_0 .net *"_s5", 0 0, L_0287bab8;  1 drivers
v0283c280_0 .net *"_s51", 0 0, L_0287cac8;  1 drivers
v0283c070_0 .net *"_s52", 0 0, L_02841088;  1 drivers
v02879cb0_0 .net *"_s54", 0 0, L_02841238;  1 drivers
v02879a48_0 .net *"_s57", 0 0, L_0287ce38;  1 drivers
v02879db8_0 .net *"_s59", 0 0, L_0287cf98;  1 drivers
v02879e68_0 .net *"_s6", 0 0, L_02840e90;  1 drivers
v02879d08_0 .net *"_s60", 0 0, L_028411a8;  1 drivers
v0287a338_0 .net *"_s63", 0 0, L_0287d048;  1 drivers
v02879ec0_0 .net *"_s64", 0 0, L_02840548;  1 drivers
v02879f18_0 .net *"_s67", 0 0, L_0287cc80;  1 drivers
v02879f70_0 .net *"_s68", 0 0, L_02840c08;  1 drivers
v0287a128_0 .net *"_s70", 0 0, L_02840590;  1 drivers
v0287a1d8_0 .net *"_s73", 0 0, L_0287ce90;  1 drivers
v0287a390_0 .net *"_s74", 0 0, L_02840d70;  1 drivers
v028799f0_0 .net *"_s78", 0 0, L_02840c50;  1 drivers
v02879c58_0 .net *"_s80", 0 0, L_02840938;  1 drivers
v0287a2e0_0 .net *"_s9", 0 0, L_0287bc18;  1 drivers
v02879d60_0 .net "a", 3 0, L_0287ccd8;  1 drivers
v02879b50_0 .net "b", 3 0, L_0287d258;  1 drivers
v02879e10_0 .net "eq", 0 0, L_02840ed8;  alias, 1 drivers
v0287a230_0 .net "gt", 0 0, L_02840818;  alias, 1 drivers
v0287a3e8_0 .net "lt", 0 0, L_02840a10;  alias, 1 drivers
v0287a440_0 .net "x", 3 0, L_028413e8;  1 drivers
L_0287b8a8 .part L_028413e8, 3, 1;
L_0287bab8 .part L_028413e8, 2, 1;
L_0287bc18 .part L_028413e8, 1, 1;
L_0287b900 .part L_028413e8, 0, 1;
L_0287bb10 .part L_0287ccd8, 3, 1;
L_0287bb68 .part L_0287d258, 3, 1;
L_0287bbc0 .part L_028413e8, 3, 1;
L_0287cd88 .part L_0287ccd8, 2, 1;
L_0287d2b0 .part L_0287d258, 2, 1;
L_0287cde0 .part L_028413e8, 3, 1;
L_0287d0a0 .part L_028413e8, 2, 1;
L_0287cc28 .part L_0287ccd8, 1, 1;
L_0287cac8 .part L_0287d258, 1, 1;
L_0287ce38 .part L_028413e8, 3, 1;
L_0287cf98 .part L_028413e8, 2, 1;
L_0287d048 .part L_028413e8, 1, 1;
L_0287cc80 .part L_0287ccd8, 0, 1;
L_0287ce90 .part L_0287d258, 0, 1;
S_028433b8 .scope module, "second4BitMagComp" "FourBitMagComp" 2 16, 2 1 0, S_0094beb0;
 .timescale 0 0;
    .port_info 0 /INPUT 4 "a"
    .port_info 1 /INPUT 4 "b"
    .port_info 2 /OUTPUT 1 "eq"
    .port_info 3 /OUTPUT 1 "lt"
    .port_info 4 /OUTPUT 1 "gt"
L_02840c98 .functor XNOR 4, L_0287cbd0, L_0287d728, C4<0000>, C4<0000>;
L_028409c8 .functor AND 1, L_0287cd30, L_0287c9c0, C4<1>, C4<1>;
L_02840ce0 .functor AND 1, L_028409c8, L_0287cee8, C4<1>, C4<1>;
L_028407d0 .functor AND 1, L_02840ce0, L_0287cff0, C4<1>, C4<1>;
L_02840d28 .functor NOT 1, L_0287cf40, C4<0>, C4<0>, C4<0>;
L_02840aa0 .functor AND 1, L_02840d28, L_0287d1a8, C4<1>, C4<1>;
L_02840bc0 .functor NOT 1, L_0287d0f8, C4<0>, C4<0>, C4<0>;
L_02840b30 .functor AND 1, L_0287d308, L_02840bc0, C4<1>, C4<1>;
L_02840980 .functor AND 1, L_02840b30, L_0287d410, C4<1>, C4<1>;
L_02840db8 .functor OR 1, L_02840aa0, L_02840980, C4<0>, C4<0>;
L_028405d8 .functor AND 1, L_0287d150, L_0287d200, C4<1>, C4<1>;
L_02840b78 .functor NOT 1, L_0287d360, C4<0>, C4<0>, C4<0>;
L_02840e00 .functor AND 1, L_028405d8, L_02840b78, C4<1>, C4<1>;
L_02840860 .functor AND 1, L_02840e00, L_0287d3b8, C4<1>, C4<1>;
L_02840a58 .functor OR 1, L_02840db8, L_02840860, C4<0>, C4<0>;
L_02840620 .functor AND 1, L_0287d468, L_0287ca18, C4<1>, C4<1>;
L_02840ae8 .functor AND 1, L_02840620, L_0287ca70, C4<1>, C4<1>;
L_02840668 .functor NOT 1, L_0287cb20, C4<0>, C4<0>, C4<0>;
L_028406b0 .functor AND 1, L_02840ae8, L_02840668, C4<1>, C4<1>;
L_028406f8 .functor AND 1, L_028406b0, L_0287cb78, C4<1>, C4<1>;
L_028408a8 .functor OR 1, L_02840a58, L_028406f8, C4<0>, C4<0>;
L_02840740 .functor NOT 1, L_028407d0, C4<0>, C4<0>, C4<0>;
L_02840788 .functor NOT 1, L_028408a8, C4<0>, C4<0>, C4<0>;
L_028408f0 .functor AND 1, L_02840740, L_02840788, C4<1>, C4<1>;
v02879998_0 .net *"_s10", 0 0, L_02840ce0;  1 drivers
v02879aa0_0 .net *"_s13", 0 0, L_0287cff0;  1 drivers
v0287a020_0 .net *"_s17", 0 0, L_0287cf40;  1 drivers
v02879af8_0 .net *"_s18", 0 0, L_02840d28;  1 drivers
v02879ba8_0 .net *"_s21", 0 0, L_0287d1a8;  1 drivers
v02879c00_0 .net *"_s22", 0 0, L_02840aa0;  1 drivers
v02879fc8_0 .net *"_s25", 0 0, L_0287d308;  1 drivers
v0287a078_0 .net *"_s27", 0 0, L_0287d0f8;  1 drivers
v0287a0d0_0 .net *"_s28", 0 0, L_02840bc0;  1 drivers
v0287a180_0 .net *"_s3", 0 0, L_0287cd30;  1 drivers
v0287a288_0 .net *"_s30", 0 0, L_02840b30;  1 drivers
v0287a700_0 .net *"_s33", 0 0, L_0287d410;  1 drivers
v0287a758_0 .net *"_s34", 0 0, L_02840980;  1 drivers
v0287a5f8_0 .net *"_s36", 0 0, L_02840db8;  1 drivers
v0287a7b0_0 .net *"_s39", 0 0, L_0287d150;  1 drivers
v0287a808_0 .net *"_s41", 0 0, L_0287d200;  1 drivers
v0287a860_0 .net *"_s42", 0 0, L_028405d8;  1 drivers
v0287a498_0 .net *"_s45", 0 0, L_0287d360;  1 drivers
v0287a5a0_0 .net *"_s46", 0 0, L_02840b78;  1 drivers
v0287a6a8_0 .net *"_s48", 0 0, L_02840e00;  1 drivers
v0287a548_0 .net *"_s5", 0 0, L_0287c9c0;  1 drivers
v0287a650_0 .net *"_s51", 0 0, L_0287d3b8;  1 drivers
v0287a8b8_0 .net *"_s52", 0 0, L_02840860;  1 drivers
v0287a910_0 .net *"_s54", 0 0, L_02840a58;  1 drivers
v0287a4f0_0 .net *"_s57", 0 0, L_0287d468;  1 drivers
v0287b380_0 .net *"_s59", 0 0, L_0287ca18;  1 drivers
v0287af60_0 .net *"_s6", 0 0, L_028409c8;  1 drivers
v0287b170_0 .net *"_s60", 0 0, L_02840620;  1 drivers
v0287ada8_0 .net *"_s63", 0 0, L_0287ca70;  1 drivers
v0287b7f8_0 .net *"_s64", 0 0, L_02840ae8;  1 drivers
v0287b2d0_0 .net *"_s67", 0 0, L_0287cb20;  1 drivers
v0287b538_0 .net *"_s68", 0 0, L_02840668;  1 drivers
v0287ae00_0 .net *"_s70", 0 0, L_028406b0;  1 drivers
v0287b5e8_0 .net *"_s73", 0 0, L_0287cb78;  1 drivers
v0287b7a0_0 .net *"_s74", 0 0, L_028406f8;  1 drivers
v0287b118_0 .net *"_s78", 0 0, L_02840740;  1 drivers
v0287b640_0 .net *"_s80", 0 0, L_02840788;  1 drivers
v0287ae58_0 .net *"_s9", 0 0, L_0287cee8;  1 drivers
v0287b590_0 .net "a", 3 0, L_0287cbd0;  1 drivers
v0287b278_0 .net "b", 3 0, L_0287d728;  1 drivers
v0287b1c8_0 .net "eq", 0 0, L_028407d0;  alias, 1 drivers
v0287b068_0 .net "gt", 0 0, L_028408f0;  alias, 1 drivers
v0287b220_0 .net "lt", 0 0, L_028408a8;  alias, 1 drivers
v0287b328_0 .net "x", 3 0, L_02840c98;  1 drivers
L_0287cd30 .part L_02840c98, 3, 1;
L_0287c9c0 .part L_02840c98, 2, 1;
L_0287cee8 .part L_02840c98, 1, 1;
L_0287cff0 .part L_02840c98, 0, 1;
L_0287cf40 .part L_0287cbd0, 3, 1;
L_0287d1a8 .part L_0287d728, 3, 1;
L_0287d308 .part L_02840c98, 3, 1;
L_0287d0f8 .part L_0287cbd0, 2, 1;
L_0287d410 .part L_0287d728, 2, 1;
L_0287d150 .part L_02840c98, 3, 1;
L_0287d200 .part L_02840c98, 2, 1;
L_0287d360 .part L_0287cbd0, 1, 1;
L_0287d3b8 .part L_0287d728, 1, 1;
L_0287d468 .part L_02840c98, 3, 1;
L_0287ca18 .part L_02840c98, 2, 1;
L_0287ca70 .part L_02840c98, 1, 1;
L_0287cb20 .part L_0287cbd0, 0, 1;
L_0287cb78 .part L_0287d728, 0, 1;
    .scope S_02841928;
T_0 ;
    %vpi_call 2 29 "$monitor", "%d a=%d, b=%d -> eq=%b, lt=%b, gt=%b", $time, v0287ba60_0, v0287ba08_0, v0287bd20_0, v0287b9b0_0, v0287bcc8_0 {0 0 0};
    %delay 10, 0;
    %pushi/vec4 10, 0, 8;
    %store/vec4 v0287ba60_0, 0, 8;
    %pushi/vec4 9, 0, 8;
    %store/vec4 v0287ba08_0, 0, 8;
    %delay 10, 0;
    %vpi_call 2 32 "$finish" {0 0 0};
    %end;
    .thread T_0;
# The file index is used to find the file name in the following table.
:file_names 3;
    "N/A";
    "<interactive>";
    "8bitMagComp.v";
