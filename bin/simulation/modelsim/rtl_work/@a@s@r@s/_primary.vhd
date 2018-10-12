library verilog;
use verilog.vl_types.all;
entity ASRS is
    port(
        ID_in           : in     vl_logic_vector(2 downto 0);
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        start           : in     vl_logic;
        busy            : out    vl_logic;
        Valor1          : out    vl_logic_vector(15 downto 0);
        Valor2          : out    vl_logic_vector(15 downto 0);
        OP              : out    vl_logic_vector(2 downto 0);
        despacho        : out    vl_logic;
        ID_out          : out    vl_logic_vector(2 downto 0);
        confirma        : in     vl_logic;
        CDB             : in     vl_logic_vector(18 downto 0);
        IRout           : in     vl_logic_vector(15 downto 0);
        depR0           : in     vl_logic_vector(2 downto 0);
        dataR0          : in     vl_logic_vector(15 downto 0);
        depR1           : in     vl_logic_vector(2 downto 0);
        dataR1          : in     vl_logic_vector(15 downto 0)
    );
end ASRS;
