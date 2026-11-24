PROGRAM PLC_PRG
VAR
    Start : BOOL;
    Stop : BOOL;
    Reset : BOOL;
    Emergency : BOOL;
    BottleSensor : BOOL;

    Motor : BOOL;
    Valve : BOOL;
    Fault : BOOL;
    BottleCount : UINT;
    MachineState : E_MachineState;

    FillingMachine : FB_FillingMachine;
    StateText : STRING(30);
END_VAR

// Machine Controller
FillingMachine(
    Start := Start,
    Stop := Stop,
    Reset := Reset,
    Emergency := Emergency,
    BottleSensor := BottleSensor
);

// Output Mapping
Motor := FillingMachine.Motor;
Valve := FillingMachine.Valve;
Fault := FillingMachine.Fault;
BottleCount := FillingMachine.BottleCount;
MachineState := FillingMachine.State;

// HMI State Display
CASE MachineState OF

    E_MachineState.IDLE:
        StateText := 'IDLE';

    E_MachineState.STARTING:
        StateText := 'STARTING';

    E_MachineState.TRANSPORT:
        StateText := 'TRANSPORT';

    E_MachineState.FILLING:
        StateText := 'FILLING';

    E_MachineState.DISCHARGE:
        StateText := 'DISCHARGE';

    E_MachineState.COMPLETE:
        StateText := 'COMPLETE';

    E_MachineState.STOPPED:
        StateText := 'STOPPED';

    E_MachineState.FAULT:
        StateText := 'FAULT';

END_CASE;
