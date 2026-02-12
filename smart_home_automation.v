module smart_home_automation (
    input         clk,
    input         rst,
    input         ok_google,
    input  [3:0]  mode,
    output        LIGHT,
    output        FAN,
    output        AC,
    output        HEATER,
    output        WASHING_MACHINE,
    output        WATER_ALARM
);

    // Bit-wise state register
    // [0] LIGHT, [1] FAN, [2] AC, [3] HEATER, [4] WASHING_MACHINE, [5] WATER_ALARM
    reg [5:0] state;

    // Mode encoding
    localparam LIGHT_ON             = 4'd0,
               LIGHT_OFF            = 4'd1,
               FAN_ON               = 4'd2,
               FAN_OFF              = 4'd3,
               AC_ON                = 4'd4,
               AC_OFF               = 4'd5,
               HEATER_ON            = 4'd6,
               HEATER_OFF           = 4'd7,
               WASHING_MACHINE_ON   = 4'd8,
               WASHING_MACHINE_OFF  = 4'd9,
               WATER_ALARM_ON       = 4'd10,
               WATER_ALARM_OFF      = 4'd11;

    // Sequential control logic
    always @(posedge clk) begin
        if (rst) begin
            state <= 6'b0;
        end else if (ok_google) begin
            case (mode)
                LIGHT_ON            : state[0] <= 1'b1;
                LIGHT_OFF           : state[0] <= 1'b0;
                FAN_ON              : state[1] <= 1'b1;
                FAN_OFF             : state[1] <= 1'b0;
                AC_ON               : state[2] <= 1'b1;
                AC_OFF              : state[2] <= 1'b0;
                HEATER_ON           : state[3] <= 1'b1;
                HEATER_OFF          : state[3] <= 1'b0;
                WASHING_MACHINE_ON  : state[4] <= 1'b1;
                WASHING_MACHINE_OFF : state[4] <= 1'b0;
                WATER_ALARM_ON      : state[5] <= 1'b1;
                WATER_ALARM_OFF     : state[5] <= 1'b0;
                default             : state <= state;
            endcase
        end
    end

    // Output mapping
    assign {WATER_ALARM, WASHING_MACHINE, HEATER, AC, FAN, LIGHT} = state;

endmodule
