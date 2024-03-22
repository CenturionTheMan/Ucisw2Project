<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1(7:0)" />
        <signal name="XLXN_2" />
        <signal name="RS232_RxD" />
        <signal name="RS232_TxD" />
        <signal name="Clk_50MHz" />
        <signal name="PS2_Clk" />
        <signal name="PS2_Data" />
        <signal name="BTN_SOUTH" />
        <signal name="XLXN_23" />
        <signal name="XLXN_24" />
        <signal name="XLXN_25" />
        <signal name="XLXN_26" />
        <signal name="XLXN_27" />
        <signal name="XLXN_28" />
        <signal name="XLXN_37" />
        <signal name="XLXN_38" />
        <signal name="XLXN_41" />
        <port polarity="Input" name="RS232_RxD" />
        <port polarity="Output" name="RS232_TxD" />
        <port polarity="Input" name="Clk_50MHz" />
        <port polarity="Input" name="PS2_Clk" />
        <port polarity="Input" name="PS2_Data" />
        <port polarity="Input" name="BTN_SOUTH" />
        <blockdef name="RS232">
            <timestamp>2008-9-23T11:16:18</timestamp>
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="320" y1="-288" y2="-288" x1="384" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="256" x="64" y="-320" height="384" />
        </blockdef>
        <blockdef name="PS2_Rx_Module">
            <timestamp>2024-3-21T11:21:19</timestamp>
            <rect width="304" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <rect width="64" x="368" y="-44" height="24" />
            <line x2="432" y1="-32" y2="-32" x1="368" />
        </blockdef>
        <block symbolname="PS2_Rx_Module" name="XLXI_2">
            <blockpin signalname="Clk_50MHz" name="CLK" />
            <blockpin signalname="BTN_SOUTH" name="RESET" />
            <blockpin signalname="PS2_Clk" name="PS2_CLK" />
            <blockpin signalname="PS2_Data" name="PS2_DATA" />
            <blockpin signalname="XLXN_2" name="DATA_READY" />
            <blockpin signalname="XLXN_1(7:0)" name="DATA_OUT(7:0)" />
        </block>
        <block symbolname="RS232" name="XLXI_1">
            <blockpin signalname="Clk_50MHz" name="Clk_50MHz" />
            <blockpin signalname="BTN_SOUTH" name="Reset" />
            <blockpin signalname="RS232_RxD" name="RS232_RxD" />
            <blockpin signalname="XLXN_2" name="TxStart" />
            <blockpin signalname="XLXN_1(7:0)" name="TxDI(7:0)" />
            <blockpin name="TxBusy" />
            <blockpin name="RxRdy" />
            <blockpin signalname="RS232_TxD" name="RS232_TxD" />
            <blockpin name="RxDO(7:0)" />
            <blockpin signalname="Clk_50MHz" name="Clk_Sys" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2112" y="1408" name="XLXI_1" orien="R0">
        </instance>
        <branch name="RS232_RxD">
            <wire x2="2528" y1="1120" y2="1120" x1="2496" />
        </branch>
        <iomarker fontsize="28" x="2528" y="1120" name="RS232_RxD" orien="R0" />
        <branch name="RS232_TxD">
            <wire x2="2528" y1="1184" y2="1184" x1="2496" />
        </branch>
        <iomarker fontsize="28" x="2528" y="1184" name="RS232_TxD" orien="R0" />
        <iomarker fontsize="28" x="320" y="1344" name="PS2_Clk" orien="R180" />
        <iomarker fontsize="28" x="336" y="1408" name="PS2_Data" orien="R180" />
        <iomarker fontsize="28" x="384" y="1472" name="BTN_SOUTH" orien="R180" />
        <branch name="XLXN_1(7:0)">
            <wire x2="2096" y1="832" y2="832" x1="1008" />
            <wire x2="2096" y1="832" y2="1184" x1="2096" />
            <wire x2="2112" y1="1184" y2="1184" x1="2096" />
        </branch>
        <branch name="PS2_Data">
            <wire x2="464" y1="1408" y2="1408" x1="336" />
            <wire x2="464" y1="832" y2="1408" x1="464" />
            <wire x2="576" y1="832" y2="832" x1="464" />
        </branch>
        <iomarker fontsize="28" x="240" y="1264" name="Clk_50MHz" orien="R180" />
        <branch name="Clk_50MHz">
            <wire x2="304" y1="1264" y2="1264" x1="240" />
            <wire x2="1632" y1="1264" y2="1264" x1="304" />
            <wire x2="1632" y1="1264" y2="1376" x1="1632" />
            <wire x2="1632" y1="1376" y2="1440" x1="1632" />
            <wire x2="2112" y1="1440" y2="1440" x1="1632" />
            <wire x2="2112" y1="1376" y2="1376" x1="1632" />
            <wire x2="304" y1="640" y2="1264" x1="304" />
            <wire x2="576" y1="640" y2="640" x1="304" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1968" y1="640" y2="640" x1="1008" />
            <wire x2="1968" y1="640" y2="1248" x1="1968" />
            <wire x2="2112" y1="1248" y2="1248" x1="1968" />
        </branch>
        <branch name="PS2_Clk">
            <wire x2="448" y1="1344" y2="1344" x1="320" />
            <wire x2="448" y1="768" y2="1344" x1="448" />
            <wire x2="576" y1="768" y2="768" x1="448" />
        </branch>
        <branch name="BTN_SOUTH">
            <wire x2="528" y1="1472" y2="1472" x1="384" />
            <wire x2="1968" y1="1472" y2="1472" x1="528" />
            <wire x2="576" y1="704" y2="704" x1="528" />
            <wire x2="528" y1="704" y2="1472" x1="528" />
            <wire x2="2112" y1="1312" y2="1312" x1="1968" />
            <wire x2="1968" y1="1312" y2="1472" x1="1968" />
        </branch>
        <instance x="576" y="864" name="XLXI_2" orien="R0">
        </instance>
    </sheet>
</drawing>