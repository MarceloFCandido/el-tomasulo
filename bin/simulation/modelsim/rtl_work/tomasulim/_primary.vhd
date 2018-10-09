library verilog;
use verilog.vl_types.all;
entity tomasulim is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        adc             : in     vl_logic;
        rtr             : in     vl_logic;
        IRin            : in     vl_logic;
        wren            : in     vl_logic;
        numW            : in     vl_logic_vector(2 downto 0);
        depW            : in     vl_logic_vector(2 downto 0);
        dataW           : in     vl_logic_vector(15 downto 0);
        numR0           : in     vl_logic_vector(2 downto 0);
        numR1           : in     vl_logic_vector(2 downto 0)
    );
end tomasulim;
