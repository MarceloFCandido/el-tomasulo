library verilog;
use verilog.vl_types.all;
entity tomasulim is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        adc             : in     vl_logic;
        rtr             : in     vl_logic;
        IRin            : in     vl_logic
    );
end tomasulim;
