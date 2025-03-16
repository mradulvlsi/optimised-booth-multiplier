module wallace_tree_multiplier (
  input signed [15:0] A,
  input signed [15:0] B,
  output signed [31:0] Product
);

  wire signed [33:0] pp0, pp1, pp2, pp3, pp4, pp5;
  
  // Booth Encoder Instance
  booths_encoder booth_enc (
    .A(A), 
    .B(B), 
    .pp0(pp0), 
    .pp1(pp1), 
    .pp2(pp2), 
    .pp3(pp3), 
    .pp4(pp4), 
    .pp5(pp5)
  );

  wire signed [33:0] sum1, sum2, sum3, sum4, sum5;
  wire signed [33:0] carry1, carry2, carry3, carry4, carry5;

  // First Reduction Stage
  full_adder_34bit FA1 (pp0, pp1, pp2, sum1, carry1);
  full_adder_34bit FA2 (pp3, pp4, pp5, sum2, carry2);

  // Second Reduction Stage
  full_adder_34bit FA3 (sum1, carry1 << 1, sum2, sum3, carry3);
  
  // Third Reduction Stage
  full_adder_34bit FA4 (carry2 << 1, sum3, carry3 << 1, sum4, carry4);

  // Final Stage Addition
  assign Product = sum4 + (carry4 << 1);

endmodule
