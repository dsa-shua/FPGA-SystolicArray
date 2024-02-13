<h1>32x32 Systolic Array RTL + Firmware Project</h1>

<h3>[Project Currently Under Development]</h3>

> Update

<p>
  Currently, the hardware is complete while the software (firmware) is on its early version. Current implementation
  provides corret results for test matrix multiplications. 
  <br><br>
  For now, the firmware code includes only the backbone of the planned finished code. I have included an interrupt 
  signal to be sent from the PL to PS after finishing matrix multiplication (23 clock cycles) and/or loading registers (8 clock cycles) but
  had not yet included it on the firmware. I'll do it as soon as possible. :)
  <br><br>
  Note: Github Repo would not be updated for every edit on files but only for major updates only. 
  Next update would be the completed version of the systolic array software and hardware.
</p>

<br><br>

---

<h4>Source Files</h4>

> [RTL Hardware Code](https://github.com/dsa-shua/32x32-SystolicArray/tree/main/systolic-array-hardware)

> [Software Code](https://github.com/dsa-shua/32x32-SystolicArray/tree/main/systolic-array-software)

---

  
<h4>
  Data Sheets:
</h4>

> Block Diagram
<p align="center">
  <img src="systolic-array-hardware/block-diagram.png">
</p>


> Floor Planning
<p align="center">
  <img src="systolic-array-hardware/floorplanning.png">
</p>


> Power Summary

<p align="center">
  <img src="systolic-array-hardware/power-summary.png">
</p>


> Timing Summary

<p align="center">
  <img src="systolic-array-hardware/timing-summary.png">
</p>


> Utilization Summary

<p align="center">
  <img src="systolic-array-hardware/utilization-summary.png">
</p>




---

<h4>
  FPGA Used: Xilinx PNYQ-Z2 FPGA 
</h4>

<p align="center">
  <img src="/pynq-fpga.png">
</p>

[Coupang (쿠팡) Product Link](https://www.coupang.com/vp/products/6695901022?itemId=15490388486&vendorItemId=82709739509&q=zynq&itemsCount=36&searchId=17f7af577cbd49099de4d26aae7b8046&rank=0&isAddedCart=)

[Amazon Product Link](https://www.amazon.com/Sparkle-Exclusive-Cortex-A9-Protection-Accessories/dp/B0C9HBJ5JB/ref=sr_1_13?crid=2CPY2OYQHVPN4&keywords=xilinx&qid=1707630187&sprefix=xili%2Caps%2C273&sr=8-13)

[Xilinx Website Link](https://www.xilinx.com/support/university/xup-boards/XUPPYNQ-Z2.html)

