library verilog;
use verilog.vl_types.all;
entity UA is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        start           : in     vl_logic;
        ID_out          : in     vl_logic_vector(2 downto 0);
        Dado1           : in     vl_logic_vector(15 downto 0);
        Dado2           : in     vl_logic_vector(15 downto 0);
        op              : in     vl_logic_vector(2 downto 0);
        Resultado       : out    vl_logic_vector(18 downto 0);
        confirmacao     : out    vl_logic;
        busy            : out    vl_logic
    );
end UA;
