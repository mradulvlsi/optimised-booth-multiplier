module booths_encoder(	
  input signed [15:0] A,
  input signed [15:0] B,
  output reg signed [33:0] pp0, pp1, pp2, pp3, pp4, pp5
);

  reg [18:0] Q;  
  integer i;
  reg [3:0] booth_comb;
  reg signed [16:0] A_x_1, A_x2;
  reg signed [17:0] A_x4, A_x3, A_x_3, A_x_2;
  reg signed [18:0] A_x_4, pp;
  
  always @(*) begin
      A_x_1 = ~A + 1;
      A_x2 = A << 1; 
      A_x3 = A_x2 + A;
      A_x4 = A_x2 << 1;
      A_x_2 = A_x_1 << 1;
      A_x_3 = ~A_x3 + 1;
      A_x_4 = A_x_2 << 1;
      
      Q = { {2{B[15]}}, B[15:0], 1'b0 };
      booth_comb = 4'b0000;

      for (i = 0; i < 16; i = i + 3) begin
        booth_comb = {Q[i+3], Q[i+2], Q[i+1], Q[i]};
        
        case (booth_comb)
          4'b0000, 4'b1111: pp = 19'b0; 
          4'b0001, 4'b0010: pp = {{3{A[15]}}, A};  
          4'b0011, 4'b0100: pp = {{2{A_x2[16]}}, A_x2}; 
          4'b0101, 4'b0110: pp = {{1{A_x3[17]}}, A_x3 };
          4'b0111: pp = {{1{A_x4[17]}}, A_x4 };
          4'b1000: pp = A_x_4;
          4'b1001, 4'b1010: pp = {{1{A_x_3[17]}}, A_x_3 };
          4'b1011, 4'b1100: pp = {{1{A_x_2[17]}}, A_x_2};
          4'b1101, 4'b1110: pp = {{2{A_x_1[16]}}, A_x_1};
        endcase
            
        case (i)
          0: pp0 = { {15{pp[18]}}, pp[18:0] };
          3: pp1 = { {12{pp[18]}}, pp[18:0], 3'b0 };
          6: pp2 = { {9{pp[18]}}, pp[18:0], 6'b0 };
          9: pp3 = { {6{pp[18]}}, pp[18:0], 9'b0 };
          12: pp4 = { {3{pp[18]}}, pp[18:0], 12'b0 };
          15: pp5 = { pp[18:0], 15'b0 };
        endcase
      end
  end
  
endmodule
