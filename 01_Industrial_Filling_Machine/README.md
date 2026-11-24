# Industrial Filling Machine

## Project Overview
Automated bottle filling machine developed using CODESYS V3.5 and Structured Text (ST).

## Technologies
- CODESYS V3.5 SP22
- IEC 61131-3
- Structured Text (ST)
- Function Blocks (FB)
- State Machine (ENUM, CASE OF)
- TON Timers and R_TRIG
- HMI Visualization
- PLC Simulation

## Features
- Conveyor motor control
- Automatic bottle filling sequence
- Bottle detection and counting
- Valve control
- Start, Stop and Reset
- Machine state monitoring
- Simulated emergency command

## Software Architecture
- PLC_PRG
- FB_FillingMachine
- E_MachineState
- HMI_FillingMachine

## Development Roadmap
- Alarm Management
- Sensor Timeout Diagnostics
- OPC UA Communication
- Python Integration
- AI-assisted Fault Diagnostics

## Project Status
Version 0.1.0 - Under Development

Basic production sequence successfully simulated.
Emergency command requires further validation and debugging.

PackML-inspired simulation project, not a certified industrial safety system.
