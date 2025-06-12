import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock

@cocotb.test()
async def test_alu_operations(dut):
    """Test all operations in the ALU"""
    clock = Clock(dut.clk, 10, units="ns")  # If clk is present
    cocotb.start_soon(clock.start())

    test_vectors = [
        (0, 0xAAAA5555, 0x5555AAAA, 0xFFFFFFFF, 0),
        (1, 0xAAAA5555, 0x5555AAAA, 0x00000000, 1),
        (2, 0xFFFFFFFF, 0x0F0F0F0F, 0xF0F0F0F0, 0),
        (3, 0x00000000, 0x00000000, 0xFFFFFFFF, 0),
        (4, 0xAAAAAAAA, 0x00000000, 0x55555555, 0),
        (5, 0xAAAA0000, 0x0000AAAA, 0xAAAAAAAA, 0),
        (6, 1, 1, 2, 0),  # Addition
        (7, 5, 3, 2, 0),  # Subtraction
        (8, 1 << 4, 2, 1 << 6, 0),  # Shift left
        (9, 128, 2, 32, 0),  # Shift right
        (10, 10, 10, 0, 1),  # Comparison
        (11, 0x80000000, 1, 0x00000001, 0),  # Left rotate
        (12, 0x00000001, 1, 0x80000000, 0)   # Right rotate
    ]


    for alu_control, a_val, b_val, expected_y, expected_zero in test_vectors:
        dut.a.value = a_val
        dut.b.value = b_val
        dut.alu_control.value = alu_control

        await RisingEdge(dut.clk)
        await RisingEdge(dut.clk)  # Wait 1 cycle

        assert dut.y.value == expected_y, f"Failed on op {alu_control}: y = {dut.y.value}, expected {expected_y}"
        assert dut.zero_flag.value == expected_zero, f"Zero flag incorrect on op {alu_control}"
