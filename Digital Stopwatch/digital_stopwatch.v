module digital_stopwatch (
    input        clk,
    input        reset,
    input        start_stop,
    output reg [3:0] minutes_tens,
    output reg [3:0] minutes_units,
    output reg [3:0] seconds_tens,
    output reg [3:0] seconds_units
);

    reg running;

    // Start/Stop control
    always @(posedge clk or posedge reset) begin
        if (reset)
            running <= 1'b0;
        else if (start_stop)
            running <= ~running;
    end

    // Stopwatch counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            minutes_tens  <= 4'd0;
            minutes_units <= 4'd0;
            seconds_tens  <= 4'd0;
            seconds_units <= 4'd0;
        end
        else if (running) begin

            // Seconds units
            if (seconds_units == 4'd9) begin
                seconds_units <= 4'd0;

                // Seconds tens
                if (seconds_tens == 4'd5) begin
                    seconds_tens <= 4'd0;

                    // Minutes units
                    if (minutes_units == 4'd9) begin
                        minutes_units <= 4'd0;

                        // Minutes tens
                        if (minutes_tens == 4'd5)
                            minutes_tens <= 4'd0;
                        else
                            minutes_tens <= minutes_tens + 1'b1;

                    end
                    else begin
                        minutes_units <= minutes_units + 1'b1;
                    end

                end
                else begin
                    seconds_tens <= seconds_tens + 1'b1;
                end

            end
            else begin
                seconds_units <= seconds_units + 1'b1;
            end

        end
    end

endmodule
