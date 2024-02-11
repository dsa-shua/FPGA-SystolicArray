<h1>32x32 Systolic Array RTL + Firmware Project</h1>

<h3>[Project Currently Under Development]</h3>

> Update

<p>
  Currently, the hardware is complete while the software (firmware) is on its early version. Current implementation
  provides corret results for test matrix multiplications. 
  <br><br>
  For now, the firmware code includes only the backbone of the planned finished code. I have included an interrupt 
  signal to be sent from the PL to PS after finishing matrix multiplication (23 clock cycles) and/or loading registers (8 clock cycles). 
</p>


<h5>
  Data Sheets:
</h5>

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




