{attribute 'qualified_only'}
{attribute 'strict'}
TYPE E_MachineState :
(
    IDLE := 0,
    STARTING := 10,
    TRANSPORT := 20,
    FILLING := 30,
    DISCHARGE := 40,
    COMPLETE := 50,
    STOPPED := 60,
    FAULT := 90
);
END_TYPE
