module full_adder_34bit (
  input signed [33:0] A,
  input signed [33:0] B,
  input signed [33:0] C,
  output signed [33:0] Sum,
  output signed [33:0] Carry
);

  assign Sum = A ^ B ^ C;    
  assign Carry = (A & B) | (B & C) | (A & C);  

endmodule
