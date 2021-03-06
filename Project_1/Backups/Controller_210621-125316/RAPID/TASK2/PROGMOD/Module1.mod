MODULE Module1
    CONST robtarget Target_10:=[[522.042382181,-3008.048094512,610.098981374],[-0.000000043,0,1,0],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20_3:=[[277.627422004,-2441.512520097,270.776520169],[-0.000000043,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[277.627422004,-2441.512520097,175.506],[-0.000000043,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30_3:=[[585.355422004,-3103.098520097,313.30740081],[-0.000000043,0,1,0],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30:=[[585.355422004,-3103.098520097,60.976],[-0.000000043,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_40:=[[522.042411786,-3008.048094512,610.098996275],[-0.000000026,0,1,0],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_50_3:=[[389.108422004,-3536.821520097,180.358861693],[-0.000000026,0,1,0],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_50:=[[416.296422039,-3536.821520097,11.999998586],[-0.000000026,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_60_3:=[[584.108422004,-3103.821520097,161.326993339],[-0.000000026,0,1,0],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_60:=[[584.108422004,-3103.821520097,93],[-0.000000026,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    VAR num actual_state;
    
    PROC main()
        TEST actual_state
        CASE 0:
            ! If sensor detect object, stop conveyor
            IF DI_CONV_SENS = 1 THEN
                SetDO DO_MOVER, 0;
                actual_state := 1;
            ENDIF
        CASE 1:
            ! Add init tab to box
            Path_10;
            actual_state := 2;
        CASE 2:
            ! Finally close the box
            Path_Close_Box;
            actual_state := 100;
        CASE 100:

        ENDTEST
        
    ENDPROC
    PROC Path_10()
        MoveL Target_10,v300,z100,smc_gripper\WObj:=wobj0;
        MoveL Target_20_3,v300,z100,smc_gripper\WObj:=wobj0;
        MoveL Target_20,v300,fine,smc_gripper\WObj:=wobj0;
        WaitTime 0.5;
        ! ATTACH
        PulseDO DO_ATT_FINISH;
        WaitTime 0.5;
        MoveL Target_20_3,v300,z100,smc_gripper\WObj:=wobj0;
        MoveL Target_30_3,v300,z100,smc_gripper\WObj:=wobj0;
        MoveL Target_30,v300,fine,smc_gripper\WObj:=wobj0;
        WaitTime 0.5;
        ! DETACH
        PulseDO DO_DET_FINISH;
        WaitTime 0.5;
        MoveL Target_30_3,v300,z100,smc_gripper\WObj:=wobj0;
        MoveL Target_10,v300,z100,smc_gripper\WObj:=wobj0;
    ENDPROC
    PROC Path_Close_Box()
        MoveL Target_40,v300,z100,smc_gripper\WObj:=Close_Box;
        MoveL Target_50_3,v300,z100,smc_gripper\WObj:=Close_Box;
        MoveL Target_50,v300,fine,smc_gripper\WObj:=Close_Box;
        WaitTime 0.5;
        ! ATTACH
        PulseDO DO_ATT_CLOSE_BOX;
        WaitTime 0.5;
        MoveL Target_50_3,v300,z100,smc_gripper\WObj:=Close_Box;
        MoveL Target_60_3,v300,z100,smc_gripper\WObj:=Close_Box;
        MoveL Target_60,v300,fine,smc_gripper\WObj:=Close_Box;
        WaitTime 0.5;
        ! DETACH
        PulseDO DO_DET_CLOSE_BOX;
        WaitTime 0.5;
        MoveL Target_40,v300,z100,smc_gripper\WObj:=Close_Box;
    ENDPROC
ENDMODULE