`default_nettype none

module tt_um_sumador4b (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


sumador_4b sum(
    .clk(clk),   
    .rst(!rst_n),
    .a_in(ui_in[3:0]), //4 bit
    .b_in(ui_in[7:4]), //4 bit
    .cin_in(1'b0),
    .sum_out(uo_out[3:0]),
    .cout_out(uo_out[4])
);

wire _unused = &{ena, uio_in, 1'b0};

assign uo_out[7:5] = 3'b0;
assign uio_out = 8'bz;
assign uio_oe = 8'b0;

endmodule