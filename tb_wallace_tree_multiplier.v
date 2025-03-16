`timescale 1ns/1ps

module tb_wallace_tree_multiplier;
  reg signed [15:0] A, B;
  wire signed [31:0] Product;
  
  // Instantiate Wallace Tree Multiplier
  wallace_tree_multiplier uut (
    .A(A),
    .B(B),
    .Product(Product)
  );

  initial begin
    $dumpfile("wallace_tree_multiplier.vcd");
    $dumpvars(0, tb_wallace_tree_multiplier);
    
    // Test Cases
    A = 16'd12; B = 16'd10; #10;
    $display("A = %d, B = %d, Product = %d", A, B, Product);

    A = -16'd8; B = 16'd5; #10;
    $display("A = %d, B = %d, Product = %d", A, B, Product);

    A = 16'd7; B = -16'd3; #10;
    $display("A = %d, B = %d, Product = %d", A, B, Product);

    A = -16'd6; B = -16'd4; #10;
    $display("A = %d, B = %d, Product = %d", A, B, Product);

    A = 16'd0; B = 16'd15; #10;
    $display("A = %d, B = %d, Product = %d", A, B, Product);

    A = 16'd32767; B = 16'd1; #10;
    $display("A = %d, B = %d, Product = %d", A, B, Product);

    $finish;
  end
  
endmodule
