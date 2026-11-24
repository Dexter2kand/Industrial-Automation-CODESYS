FUNCTION_BLOCK FB_FillingMachine
VAR_INPUT
    Start : BOOL;
    Stop : BOOL;
    Reset : BOOL;
    Emergency : BOOL;
    BottleSensor : BOOL;
END_VAR

VAR_OUTPUT
    Motor : BOOL;
    Valve : BOOL;
    Fault : BOOL;
    State : E_MachineState := E_MachineState.IDLE;
    BottleCount : UINT;
END_VAR

VAR
    StartTimer : TON;
    FillTimer : TON;
    DischargeTimer : TON;
    StartTrigger : R_TRIG;
END_VAR

// Rising edge detection
StartTrigger(CLK := Start);

// Machine timers
StartTimer(
    IN := State = E_MachineState.STARTING,
    PT := T#1S
);

FillTimer(
    IN := State = E_MachineState.FILLING,
    PT := T#5S
);

DischargeTimer(
    IN := State = E_MachineState.DISCHARGE,
    PT := T#2S
);

// Stop and fault priority
IF Emergency THEN
    State := E_MachineState.FAULT;
ELSIF Stop AND State <> E_MachineState.FAULT THEN
    State := E_MachineState.STOPPED;
END_IF;

// Default outputs
Motor := FALSE;
Valve := FALSE;
Fault := FALSE;

// State Machine
CASE State OF

    E_MachineState.IDLE:
        IF StartTrigger.Q THEN
            State := E_MachineState.STARTING;
        END_IF;

    E_MachineState.STARTING:
        IF StartTimer.Q THEN
            State := E_MachineState.TRANSPORT;
        END_IF;

    E_MachineState.TRANSPORT:
        Motor := TRUE;

        IF BottleSensor THEN
            State := E_MachineState.FILLING;
        END_IF;

    E_MachineState.FILLING:
        Valve := TRUE;

        IF FillTimer.Q THEN
            State := E_MachineState.DISCHARGE;
        END_IF;

    E_MachineState.DISCHARGE:
        Motor := TRUE;

        IF DischargeTimer.Q THEN
            BottleCount := BottleCount + 1;
            State := E_MachineState.COMPLETE;
        END_IF;

    E_MachineState.COMPLETE:
        State := E_MachineState.IDLE;

    E_MachineState.STOPPED:
        IF Reset AND NOT Stop THEN
            State := E_MachineState.IDLE;
        END_IF;

    E_MachineState.FAULT:
        Fault := TRUE;

        IF Reset AND NOT Emergency AND NOT Stop THEN
            State := E_MachineState.IDLE;
        END_IF;

END_CASE;
