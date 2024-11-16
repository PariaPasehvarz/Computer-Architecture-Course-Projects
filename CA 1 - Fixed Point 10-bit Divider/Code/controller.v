module div_CU (
    input clk,
    input start,
    input dvz,
    input gT,
    input CO_CNT,
    input ovf,
    output reg busy,
    output reg ld_a,
    output reg ld_b,
    output reg rst,
    output reg valid,
    output reg loading_done,
    output reg shift,
    output reg count_enable
);

parameter IDLE = 3'b000;
parameter LOADING = 3'b001;
parameter CHECK_DIVISOR = 3'b010;
parameter DIVIDE = 3'b011;
parameter SUB = 3'b100;
parameter SHIFT_LEFT = 3'b101;
parameter DONE = 3'b110;

reg [2:0] state, next_state;


always @(posedge clk) begin
    next_state = state;
    {busy, ld_a, ld_b, rst, valid,shift,count_enable} = 0;
    case (state)
        IDLE: begin
            if (start) begin
                ld_a <= 1;
                ld_b <= 1;
                next_state = LOADING;
            end else begin
                next_state = IDLE;
            end
        end

        LOADING: begin
	       loading_done <= 1;
            busy <= 1;
            rst <= 1;
            next_state = CHECK_DIVISOR;
        end

        CHECK_DIVISOR: begin
            if (dvz) begin
                next_state = IDLE;
                busy <= 0;
            end else begin
                next_state = DIVIDE;
                busy <= 1;
            end
        end

        DIVIDE: begin
            if (ovf) begin
                next_state = IDLE;
            end
            else
            if(CO_CNT) begin
                count_enable<=0;
                valid <= 1;
                next_state=DONE;
            end
            else begin
                count_enable<=1;
                busy <= 1;
                if (gT) begin 
                    next_state = SUB;
                end else begin
                    next_state = SHIFT_LEFT;
                    shift<=1;
                end
            end
        end

        SUB: begin
            busy <= 1;
            next_state = SHIFT_LEFT;
            shift<=1;
        end

        SHIFT_LEFT: begin
            busy <= 1;
            next_state = DIVIDE;
        end

        DONE: begin
            busy <= 1;
            next_state = IDLE;
        end

        default: next_state = IDLE;
    endcase

    state <= next_state;
end

endmodule
