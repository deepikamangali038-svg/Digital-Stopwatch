`timescale 1ns/1ps

module digital_stopwatch_tb;

    reg clk;
    reg reset;
    reg start_stop;

    wire [3:0] minutes_tens;
    wire [3:0] minutes_units;
    wire [3:0] seconds_tens;
    wire [3:0] seconds_units;

    digital_stopwatch DUT (
        .clk(clk),
        .reset(reset),
        .start_stop(start_stop),
        .minutes_tens(minutes_tens),
        .minutes_units(minutes_units),
        .seconds_tens(seconds_tens),
        .seconds_units(seconds_units)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    // Start/stop button
    task press_start_stop;
        begin
            @(negedge clk);
            start_stop = 1'b1;

            @(negedge clk);
            start_stop = 1'b0;
        end
    endtask

    // Display stopwatch time
    task display_time;
        begin
            $display(
                "TIME = %0d%0d:%0d%0d",
                minutes_tens,
                minutes_units,
                seconds_tens,
                seconds_units
            );
        end
    endtask

    initial begin

        clk = 1'b0;
        reset = 1'b1;
        start_stop = 1'b0;

        $display("========================================");
        $display("       DIGITAL STOPWATCH TESTBENCH");
        $display("========================================");

        // Reset
        #10;
        reset = 1'b0;

        display_time;

        // Start stopwatch
        $display("");
        $display("Starting stopwatch...");
        press_start_stop;

        // Run for 15 clock cycles
        repeat (15) begin
            @(posedge clk);
        end

        #1;
        display_time;

        // Stop stopwatch
        $display("");
        $display("Stopping stopwatch...");
        press_start_stop;

        repeat (5) begin
            @(posedge clk);
        end

        #1;
        display_time;

        // Start again
        $display("");
        $display("Starting stopwatch again...");
        press_start_stop;

        repeat (10) begin
            @(posedge clk);
        end

        #1;
        display_time;

        // Reset
        $display("");
        $display("Resetting stopwatch...");

        reset = 1'b1;
        #10;
        reset = 1'b0;

        #1;
        display_time;

        $display("");
        $display("========================================");
        $display("       ALL TESTS COMPLETED");
        $display("========================================");

        #10;
        $finish;

    end

endmodule
