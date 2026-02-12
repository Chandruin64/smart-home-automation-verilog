module smart_home_automation_tb();
  reg clk,rst,ok_google;
  reg [3:0] mode;
  wire LIGHT,FAN,AC,HEATER,WASHING_MACHINE,WATER_ALARM;
  integer i;
  reg [5:0] state;
  
  // DUT instantiation
  smart_home_automation DUT(.clk(clk),.rst(rst),.ok_google(ok_google),.mode(mode),.LIGHT(LIGHT),.FAN(FAN),.AC(AC),.HEATER(HEATER),.WASHING_MACHINE(WASHING_MACHINE),.WATER_ALARM(WATER_ALARM));
  
  // Time Period Duration
  parameter Cycle = 100,
  Thold = 5,
  Tsetup = 5;
  
  // Reset Task
  task rst_dut();
    begin
      rst = 1'b1;
      ok_google = 1'b1;
      mode = 4'd4;
      @(posedge clk);
      #(Thold);
      if((LIGHT == 0) && (FAN == 0) && (AC == 0) && (HEATER == 0) && (WASHING_MACHINE == 0) && (WATER_ALARM == 0))
        $display("Reset is working perfectly");
      else begin
        $display("Reset is not working");
        $display("Error at time:%d",$time);
        $stop();
      end
      #(Cycle-Thold-Tsetup);
    end
  endtask
  
  // Stimulus task
  task stimulus(input a,input [3:0] b);
    begin
      rst = 1'b0;
      ok_google = a;
      mode = b;
      @(posedge clk);
      #(Thold);
      if(((((mode == 0) && (LIGHT == 1)) || ((mode == 1) && (LIGHT == 0)) || ((mode == 2) && (FAN == 1)) || ((mode == 3) && (FAN == 0)) || ((mode == 4) && (AC == 1)) || ((mode == 5) && (AC == 0)) || ((mode == 6) && (HEATER == 1)) || ((mode == 7) && (HEATER == 0)) || ((mode == 8) && (WASHING_MACHINE == 1)) || ((mode == 9) && (WASHING_MACHINE == 0)) || ((mode == 10) && (WATER_ALARM == 1)) || ((mode == 11) && (WATER_ALARM == 0))) && ok_google) || (ok_google && ((state[0] == LIGHT) && (state[1] == FAN) && (state[2] == AC) && (state[3] == HEATER) && (state[4] == WASHING_MACHINE) && (state[5] == WATER_ALARM)))) begin
        $display("Input mode is working perfectly");
        state[0] = LIGHT;
        state[1] = FAN;
        state[2] = AC;
        state[3] = HEATER;
        state[4] = WASHING_MACHINE;
        state[5] = WATER_ALARM;
      end
      else if((!ok_google) && (state[0] == LIGHT) && (state[1] == FAN) && (state[2] == AC) && (state[3] == HEATER) && (state[4] == WASHING_MACHINE) && (state[5] == WATER_ALARM))
        $display("Input mode is working perfectly");
      else begin
        $display("Input mode is not working");
        $display("Error at time:%d",$time);
        $stop();
      end
      #(Cycle-Thold-Tsetup);
    end
  endtask
  
  // Clock generation
  always begin
    #(Cycle/2);
    clk = ~clk;
  end
  
  // Initialization task
  task initialize();
    begin
      clk = 1'b0;
      rst = 1'b0;
      mode = 4'd0;
      state = 6'd0;
    end
  endtask
  
  // Assigning values to DUT module 
  initial begin
    initialize();
    rst_dut();
    for(i=0;i<16;i=i+1)
      stimulus(1,i);
    stimulus(0,0);
    #20 $finish();
  end
  
  // Output Monitoring
  initial 
    $monitor("At %d, Clock:%b, Reset:%b, Ok Google:%b, Mode:%d, LIGHT:%b, FAN:%b, AC:%b, HEATER:%b, WASHING_MACHINE:%b,WATER_ALARM:%b",$time,clk,rst,ok_google,mode,LIGHT,FAN,AC,HEATER,WASHING_MACHINE,WATER_ALARM);
    
endmodule
