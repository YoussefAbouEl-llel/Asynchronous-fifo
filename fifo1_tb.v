module fifo1_tb;
  reg [7:0] wdata;
  reg winc, wclk, wrst_n;
  reg rinc, rclk, rrst_n;
  wire [7:0] rdata;
  wire wfull, rempty;

  fifo1 uut (
    .rdata(rdata),
    .wfull(wfull),
    .rempty(rempty),
    .wdata(wdata),
    .winc(winc), .wclk(wclk), .wrst_n(wrst_n),
    .rinc(rinc), .rclk(rclk), .rrst_n(rrst_n)
  );

  initial begin
    // Initialize signals
    wclk = 0; wrst_n = 1; rinc = 0; rclk = 0; rrst_n = 1;
    wdata = 8'h00; winc = 0;

    // Reset the FIFO
    #5 wrst_n = 0; rrst_n = 0;
    #5 wrst_n = 1; rrst_n = 1;

    // Write data into FIFO
    repeat (10) begin
      #10 wdata = $random; winc = 1; 
      #10 winc = 0;
    end

    // Read data from FIFO
    repeat (10) begin
      #10 rinc = 1; 
      #10 rinc = 0;
    end

    // Finish simulation
    #40 $finish;
  end

  always #5 wclk = ~wclk; // Clock generation for write clock
  always #7 rclk = ~rclk; // Clock generation for read clock
  endmodule