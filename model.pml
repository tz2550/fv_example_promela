// Define named constants for the states
mtype = { HS_Idle, 
          HS_GPM_Store, HS_GPS_Check, HS_GPB_Sent, HS_GPD_Sent, HS_GPQ_Check, HS_GPA_Quit_Sent,
          HS_GPJ_Check, HS_GPA_Join_Sent, HS_GPA_Invalid_Sent, HS_GPC_Check, HS_GPA_Sent, HS_GPR_Check, HS_GPL_Sent, 
          HS_GPE_Sent, HS_ACK_Reset, HS_REG_Check, HS_REG_Check2, HS_DUP_Sent, HS_UPD_Sent, HS_FIN_Sent, 
          HS2_GPM_Store, HS2_GPS_Check, HS2_GPB_Sent, HS2_GPD_Sent, HS2_GPQ_Check, HS2_GPA_Quit_Sent,HS2_GPJ_Check, 
          HS2_GPA_Join_Sent, HS2_GPA_Invalid_Sent, HS2_GPC_Check, HS2_GPA_Sent, HS2_GPR_Check, HS2_GPL_Sent, 
          HS2_GPE_Sent, HS2_ACK_Reset, HS2_REG_Check, HS2_REG_Check2, HS2_DUP_Sent, HS2_UPD_Sent, HS2_FIN_Sent, 
          SC_Idle, SC_GPS_Sent, SC_GPQ_Sent, SC_DEREG_Check, SC_GPR_Sent, SC_GPC_Sent, SC_DEREG_Sent, SC_GPJ_Sent, 
          HC_UPD_Parse, HC_FIN_Parse, SC_exit, SC_GPM_Sent, SC_GPM_View, SC_MSG_Sent, SC_MSG_View,
          SC2_Idle, SC2_GPS_Sent, SC2_GPQ_Sent, SC2_DEREG_Check, SC2_GPR_Sent, SC2_GPC_Sent, SC2_DEREG_Sent, SC2_GPJ_Sent, 
          HC2_UPD_Parse, HC2_FIN_Parse, SC2_exit, SC2_GPM_Sent, SC2_GPM_View, SC2_MSG_Sent, SC2_MSG_View};

// State variables
mtype HS_current = HS_Idle;
mtype SC_current = SC_Idle;
mtype SC2_current = SC2_Idle;

// Checker Variables
bool hs_idle = 0;

bool is_exit = 0;
bool sc_idle = 0;
bool SC_timer_resolved = 0;

bool is_exit2 = 0;
bool sc2_idle = 0;
bool SC2_timer_resolved = 0;

// State Transitions Variable
bool server_broadcast = 0;

bool gp = 0;                        // Group mode indicator
bool HS_ACK_Sent = 0;
bool SC_timeout = 0;                // Timeout indicator
int  SC_timer = 0;

bool gp2 = 0;                        // Group mode indicator
bool HS2_ACK_Sent2 = 0;
bool SC2_timeout = 0;                // Timeout indicator
int  SC2_timer = 0;


// Messages Sent to Clients
bool GPD_in_HC_buffer = 0;
bool GPB_in_HC_buffer = 0;
bool GPA_in_HC_buffer = 0;
bool GPA_isQuit = 0;
bool GPA_isJoin = 0;
bool GPA_isInvalid = 0;
bool GPL_in_HC_buffer = 0;
bool GPE_in_HC_buffer = 0;
bool DUP_in_HC_buffer = 0;
bool UPD_in_HC_buffer = 0;
bool FIN_in_HC_buffer = 0;
bool GPM_in_HC_buffer = 0;
bool GPM_brodcast_done = 0;
bool MSG_in_SC_buffer = 0;

bool GPD_in_HC2_buffer = 0;
bool GPB_in_HC2_buffer = 0;
bool GPA_in_HC2_buffer = 0;
bool GPA_isQuit2 = 0;
bool GPA_isJoin2 = 0;
bool GPA_isInvalid2 = 0;
bool GPL_in_HC2_buffer = 0;
bool GPE_in_HC2_buffer = 0;
bool DUP_in_HC2_buffer = 0;
bool UPD_in_HC2_buffer = 0;
bool FIN_in_HC2_buffer = 0;
bool GPM_in_HC2_buffer = 0;
bool MSG_in_SC2_buffer = 0;

// Messages Sent to Servers
bool GPQ_in_HS_buffer = 0;
bool GPS_in_HS_buffer = 0;
bool GPJ_in_HS_buffer = 0;
bool GPC_in_HS_buffer = 0;
bool GPR_in_HS_buffer = 0;
bool GPM_in_HS_buffer = 0;
bool DEREG_in_HS_buffer = 0;

bool GPQ_in_HS2_buffer = 0;
bool GPS_in_HS2_buffer = 0;
bool GPJ_in_HS2_buffer = 0;
bool GPC_in_HS2_buffer = 0;
bool GPR_in_HS2_buffer = 0;
bool GPM_in_HS2_buffer = 0;
bool DEREG_in_HS2_buffer = 0;

// First state machine
proctype HS_StateMachine() {
    do
        // Master Entry of State Machine
        :: (HS_current == HS_Idle) ->
            hs_idle = 0;
            if
            :: (GPM_in_HS_buffer == 1) ->
                GPM_in_HS_buffer = 0;
                HS_current = HS_GPM_Store;
            :: (GPS_in_HS_buffer == 1) ->
                GPS_in_HS_buffer = 0;
                HS_current = HS_GPS_Check;
            :: (GPQ_in_HS_buffer == 1) ->
                GPQ_in_HS_buffer = 0;
                HS_current = HS_GPQ_Check;
            :: (GPJ_in_HS_buffer == 1) ->
                GPJ_in_HS_buffer = 0;
                HS_current = HS_GPJ_Check;
            :: (GPC_in_HS_buffer == 1) ->
                GPC_in_HS_buffer = 0;
                HS_current = HS_GPC_Check;
            :: (GPR_in_HS_buffer == 1) ->
                GPR_in_HS_buffer = 0;
                HS_current = HS_GPR_Check;
            :: (DEREG_in_HS_buffer == 1) ->
                DEREG_in_HS_buffer = 0;
                HS_current = HS_REG_Check;
            :: (GPM_in_HS2_buffer == 1) ->
                GPM_in_HS2_buffer = 0;
                HS_current = HS2_GPM_Store;
            :: (GPS_in_HS2_buffer == 1) ->
                GPS_in_HS2_buffer = 0;
                HS_current = HS2_GPS_Check;
            :: (GPQ_in_HS2_buffer == 1) ->
                GPQ_in_HS2_buffer = 0;
                HS_current = HS2_GPQ_Check;
            :: (GPJ_in_HS2_buffer == 1) ->
                GPJ_in_HS2_buffer = 0;
                HS_current = HS2_GPJ_Check;
            :: (GPC_in_HS2_buffer == 1) ->
                GPC_in_HS2_buffer = 0;
                HS_current = HS2_GPC_Check;
            :: (GPR_in_HS2_buffer == 1) ->
                GPR_in_HS2_buffer = 0;
                HS_current = HS2_GPR_Check;
            :: (DEREG_in_HS2_buffer == 1) ->
                DEREG_in_HS2_buffer = 0;
                HS_current = HS2_REG_Check;
            fi
        // GPM
        :: (HS_current == HS_GPM_Store) -> 
            server_broadcast = 1;
            GPM_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPS
        :: (HS_current == HS_GPS_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;
            :: HS_current = HS_GPB_Sent; 
            :: HS_current = HS_GPD_Sent; 
            fi;
        :: (HS_current == HS_GPB_Sent) -> 
            GPB_in_HC_buffer = 1; 
            HS_current = HS_GPD_Sent;
        :: (HS_current == HS_GPD_Sent) ->
            GPD_in_HC_buffer = 1;
            hs_idle = 1; 
            HS_current = HS_Idle;
        // GPQ
        :: (HS_current == HS_GPQ_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;     
            :: HS_current = HS_GPA_Quit_Sent;
            fi;
        :: (HS_current == HS_GPA_Quit_Sent) ->
            GPA_isQuit = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPJ
        :: (HS_current == HS_GPJ_Check) -> 
            if
            :: HS_current = HS_GPA_Invalid_Sent;    
            :: HS_current = HS_GPA_Join_Sent;
            fi;
        :: (HS_current == HS_GPA_Join_Sent) ->
            GPA_isJoin = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        :: (HS_current == HS_GPA_Invalid_Sent) ->
            GPA_isInvalid = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPC
        :: (HS_current == HS_GPC_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;     
            :: HS_current = HS_GPA_Sent;
            fi;
        :: (HS_current == HS_GPA_Sent) ->
            GPA_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPR
        :: (HS_current == HS_GPR_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;
            :: HS_current = HS_GPL_Sent; 
            :: HS_current = HS_GPE_Sent; 
            fi;
        :: (HS_current == HS_GPL_Sent) -> 
            GPL_in_HC_buffer = 1;
            HS_current = HS_GPE_Sent;
        :: (HS_current == HS_GPE_Sent) -> 
            GPE_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // REG
        :: (HS_current == HS_REG_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;
            :: HS_current = HS_REG_Check2;
            fi;
        :: (HS_current == HS_REG_Check2) -> 
            if
            :: HS_current = HS_DUP_Sent;
            :: HS_ACK_Sent = 1;
               HS_current = HS_UPD_Sent;
            fi;
        :: (HS_current == HS_UPD_Sent) ->
            UPD_in_HC_buffer = 1;
            HS_current = HS_FIN_Sent;
        :: (HS_current == HS_FIN_Sent) -> 
            FIN_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        :: (HS_current == HS_DUP_Sent) -> 
            DUP_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        :: (HS_current == HS2_GPM_Store) -> 
            server_broadcast = 1;
            GPM_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPS
        :: (HS_current == HS2_GPS_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;
            :: HS_current = HS2_GPB_Sent; 
            :: HS_current = HS2_GPD_Sent; 
            fi;
        :: (HS_current == HS2_GPB_Sent) -> 
            GPB_in_HC_buffer = 1; 
            HS_current = HS2_GPD_Sent;
        :: (HS_current == HS2_GPD_Sent) ->
            GPD_in_HC_buffer = 1;
            hs_idle = 1; 
            HS_current = HS_Idle;
        // GPQ
        :: (HS_current == HS2_GPQ_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;     
            :: HS_current = HS2_GPA_Quit_Sent;
            fi;
        :: (HS_current == HS2_GPA_Quit_Sent) ->
            GPA_isQuit = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPJ
        :: (HS_current == HS2_GPJ_Check) -> 
            if
            :: HS_current = HS2_GPA_Invalid_Sent;    
            :: HS_current = HS2_GPA_Join_Sent;
            fi;
        :: (HS_current == HS2_GPA_Join_Sent) ->
            GPA_isJoin = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        :: (HS_current == HS2_GPA_Invalid_Sent) ->
            GPA_isInvalid = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPC
        :: (HS_current == HS2_GPC_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;     
            :: HS_current = HS2_GPA_Sent;
            fi;
        :: (HS_current == HS2_GPA_Sent) ->
            GPA_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // GPR
        :: (HS_current == HS2_GPR_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;
            :: HS_current = HS2_GPL_Sent; 
            :: HS_current = HS2_GPE_Sent; 
            fi;
        :: (HS_current == HS2_GPL_Sent) -> 
            GPL_in_HC_buffer = 1;
            HS_current = HS2_GPE_Sent;
        :: (HS_current == HS2_GPE_Sent) -> 
            GPE_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        // REG
        :: (HS_current == HS2_REG_Check) -> 
            if
            :: hs_idle = 1;
               HS_current = HS_Idle;
            :: HS_current = HS2_REG_Check2;
            fi;
        :: (HS_current == HS2_REG_Check2) -> 
            if
            :: HS_current = HS2_DUP_Sent;
            :: HS2_ACK_Sent2 = 1;
               HS_current = HS2_UPD_Sent;
            fi;
        :: (HS_current == HS2_UPD_Sent) ->
            UPD_in_HC_buffer = 1;
            HS_current = HS2_FIN_Sent;
        :: (HS_current == HS2_FIN_Sent) -> 
            FIN_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
        :: (HS_current == HS2_DUP_Sent) -> 
            DUP_in_HC_buffer = 1;
            hs_idle = 1;
            HS_current = HS_Idle;
    od;
}

// First Client
proctype SC_StateMachine()
{
    do
        :: (SC_current == SC_Idle) ->
            sc_idle = 0;
            SC_timer_resolved = 0;
            if
            :: (gp == 1) ->
                if
                :: (GPM_in_HC_buffer == 1) -> SC_current = SC_GPM_View;
                :: SC_current = SC_GPS_Sent;
                :: SC_current = SC_GPQ_Sent;
                :: SC_current = SC_DEREG_Check;
                :: SC_current = SC_GPM_Sent;
                :: SC_current = SC_exit;
                fi;
            :: (gp == 0) ->
                if
                :: (MSG_in_SC_buffer == 1) -> SC_current = SC_MSG_View;
                :: SC_current = SC_DEREG_Check;
                :: SC_current = SC_GPR_Sent;
                :: SC_current = SC_GPC_Sent;
                :: SC_current = SC_GPJ_Sent;
                :: SC_current = SC_MSG_Sent;
                :: SC_current = SC_exit;
                fi;
            fi
        // Dereg
        :: (SC_current == SC_DEREG_Check) -> 
            if
            :: SC_current = SC_exit;
            :: SC_current = SC_DEREG_Sent;
            fi;
        :: (SC_current == SC_DEREG_Sent) ->
            DEREG_in_HS_buffer = 1;
            if
            :: (SC_timeout == 1) ->
                SC_timeout = 0;
                SC_current = SC_exit;
            :: (SC_timer < 5) ->
                SC_timer = SC_timer + 1;    // ACK Timeout
                if
                :: (SC_timer == 5) ->
                    SC_timeout = 1;
                    SC_timer = 0;
                fi;
                SC_current = SC_DEREG_Sent;
            :: (HS_ACK_Sent == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                HS_ACK_Sent = 0;
                SC_current = SC_exit;
            fi;
        // GPQ
        :: (SC_current == SC_GPQ_Sent) -> 
            GPQ_in_HS_buffer = 1;
            if
            :: (SC_timeout == 1) ->
                SC_timeout = 0;
                SC_current = SC_exit;
            :: (SC_timer < 5) ->
                SC_timer = SC_timer + 1;    // ACK Timeout
                if
                :: (SC_timer == 5) ->
                    SC_timeout = 1;
                    SC_timer = 0;
                fi;
                SC_current = SC_GPQ_Sent;
            :: (GPA_isQuit == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPA_isQuit = 0;
                gp = 0;
                sc_idle = 1;
                SC_current = SC_Idle;
            fi;
        // GPS
        :: (SC_current == SC_GPS_Sent) -> 
            GPS_in_HS_buffer = 1;
            if
            :: (SC_timeout == 1) ->
                SC_timeout = 0;
                SC_current = SC_exit;
            :: (SC_timer < 5) ->
                SC_timer = SC_timer + 1;    // ACK Timeout
                if
                :: (SC_timer == 5) ->
                    SC_timeout = 1;
                    SC_timer = 0;
                fi;
                SC_current = SC_GPS_Sent;
            :: (GPB_in_HC_buffer == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPB_in_HC_buffer = 0;
                SC_current = SC_GPS_Sent;
            :: (GPD_in_HC_buffer == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPD_in_HC_buffer = 0;
                sc_idle = 1;
                SC_current = SC_Idle;
            fi;
        // GPJ
        :: (SC_current == SC_GPJ_Sent) -> 
            GPJ_in_HS_buffer = 1;
            if
            :: (SC_timeout == 1) ->
                SC_timeout = 0;
                SC_current = SC_exit;
            :: (SC_timer < 5) ->
                SC_timer = SC_timer + 1;    // ACK Timeout
                if
                :: (SC_timer == 5) ->
                    SC_timeout = 1;
                    SC_timer = 0;
                fi;
                SC_current = SC_GPJ_Sent;
            :: (GPA_isJoin == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPA_isJoin = 0;
                gp = 1;
                sc_idle = 1;
                SC_current = SC_Idle;
            :: (GPA_isInvalid == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPA_isInvalid = 0;
                gp = 0;
                sc_idle = 1;
                SC_current = SC_Idle;
            fi;
        // GPC
        :: (SC_current == SC_GPC_Sent) -> 
            GPC_in_HS_buffer = 1;
            if
            :: (SC_timeout == 1) ->
                SC_timeout = 0;
                SC_current = SC_exit;
            :: (SC_timer < 5) ->
                SC_timer = SC_timer + 1;    // ACK Timeout
                if
                :: (SC_timer == 5) ->
                    SC_timeout = 1;
                    SC_timer = 0;
                fi;
                SC_current = SC_GPC_Sent;
            :: (GPA_in_HC_buffer == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPA_in_HC_buffer = 0;
                sc_idle = 1;
                SC_current = SC_Idle;
            fi;
        // GPR
        :: (SC_current == SC_GPR_Sent) -> 
            GPR_in_HS_buffer = 1;
            if
            :: (SC_timeout == 1) ->
                SC_timeout = 0;
                SC_current = SC_exit;
            :: (SC_timer < 5) ->
                SC_timer = SC_timer + 1;    // ACK Timeout
                if
                :: (SC_timer == 5) ->
                    SC_timeout = 1;
                    SC_timer = 0;
                fi;
                SC_current = SC_GPR_Sent;
            :: (GPL_in_HC_buffer == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPL_in_HC_buffer = 0;
                SC_current = SC_GPR_Sent;
            :: (GPE_in_HC_buffer == 1) ->
                SC_timer_resolved = 1;
                SC_timer = 0;
                GPE_in_HC_buffer = 0;
                sc_idle = 1;
                SC_current = SC_Idle;
            fi;
        // GPM
        :: (SC_current == SC_GPM_Sent) -> 
            GPM_in_HS_buffer = 1;
            sc_idle = 1;
            SC_current = SC_Idle;
        :: (SC_current == SC_GPM_View) -> 
            GPM_in_HS_buffer = 0;
            sc_idle = 1;
            SC_current = SC_Idle;
        // MSG
        :: (SC_current == SC_MSG_Sent) -> 
            MSG_in_SC2_buffer = 1;
            if
            :: (SC_timeout == 1) ->
                SC_timeout = 0;
                SC_current = SC_exit;
            :: (SC_timer < 5) ->
                SC_timer = SC_timer + 1;    // ACK Timeout
                if
                :: (SC_timer == 5) ->
                    SC_timeout = 1;
                    SC_timer = 0;
                fi;
                SC_current = SC_MSG_Sent;
            :: (HS2_ACK_Sent2 == 1) -> // Recv ACK
                HS2_ACK_Sent2 = 0;
                SC_timer_resolved = 1;
                SC_timer = 0;
                sc_idle = 1;
                SC_current = SC_Idle;
            fi;
        :: (SC_current == SC_MSG_View) ->
            MSG_in_SC_buffer = 0;
            HS_ACK_Sent = 1;
            sc_idle = 1;
            SC_current = SC_Idle;
        // Exit
        :: (SC_current == SC_exit) -> 
            is_exit = 1;
            break;
    od;
}

// Second Client
proctype SC2_StateMachine()
{
    do
        :: (SC2_current == SC2_Idle) ->
            sc2_idle = 0;
            SC2_timer_resolved = 0;
            if
            :: (gp2 == 1) ->
                if
                :: (GPM_in_HC2_buffer == 1) -> SC2_current = SC2_GPM_View;
                :: SC2_current = SC2_GPS_Sent;
                :: SC2_current = SC2_GPQ_Sent;
                :: SC2_current = SC2_DEREG_Check;
                :: SC2_current = SC2_GPM_Sent;
                :: SC2_current = SC2_exit;
                fi;
            :: (gp2 == 0) ->
                if
                :: (MSG_in_SC2_buffer == 1) -> SC2_current = SC2_MSG_View;
                :: SC2_current = SC2_DEREG_Check;
                :: SC2_current = SC2_GPR_Sent;
                :: SC2_current = SC2_GPC_Sent;
                :: SC2_current = SC2_GPJ_Sent;
                :: SC2_current = SC2_MSG_Sent;
                :: SC2_current = SC2_exit;
                fi;
            fi
        // Dereg
        :: (SC2_current == SC2_DEREG_Check) -> 
            if
            :: SC2_current = SC2_exit;
            :: SC2_current = SC2_DEREG_Sent;
            fi;
        :: (SC2_current == SC2_DEREG_Sent) ->
            DEREG_in_HS2_buffer = 1;
            if
            :: (SC2_timeout == 1) ->
                SC2_timeout = 0;
                SC2_current = SC2_exit;
            :: (SC2_timer < 5) ->
                SC2_timer = SC2_timer + 1;    // ACK Timeout
                if
                :: (SC2_timer == 5) ->
                    SC2_timeout = 1;
                    SC2_timer = 0;
                fi;
                SC2_current = SC2_DEREG_Sent;
            :: (HS2_ACK_Sent2 == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                HS2_ACK_Sent2 = 0;
                SC2_current = SC2_exit;
            fi;
        // GPQ
        :: (SC2_current == SC2_GPQ_Sent) -> 
            GPQ_in_HS2_buffer = 1;
            if
            :: (SC2_timeout == 1) ->
                SC2_timeout = 0;
                SC2_current = SC2_exit;
            :: (SC2_timer < 5) ->
                SC2_timer = SC2_timer + 1;    // ACK Timeout
                if
                :: (SC2_timer == 5) ->
                    SC2_timeout = 1;
                    SC2_timer = 0;
                fi;
                SC2_current = SC2_GPQ_Sent;
            :: (GPA_isQuit2 == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPA_isQuit2 = 0;
                gp2 = 0;
                sc2_idle = 1;
                SC2_current = SC2_Idle;
            fi;
        // GPS
        :: (SC2_current == SC2_GPS_Sent) -> 
            GPS_in_HS2_buffer = 1;
            if
            :: (SC2_timeout == 1) ->
                SC2_timeout = 0;
                SC2_current = SC2_exit;
            :: (SC2_timer < 5) ->
                SC2_timer = SC2_timer + 1;    // ACK Timeout
                if
                :: (SC2_timer == 5) ->
                    SC2_timeout = 1;
                    SC2_timer = 0;
                fi;
                SC2_current = SC2_GPS_Sent;
            :: (GPB_in_HC2_buffer == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPB_in_HC2_buffer = 0;
                SC2_current = SC2_GPS_Sent;
            :: (GPD_in_HC2_buffer == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPD_in_HC2_buffer = 0;
                sc2_idle = 1;
                SC2_current = SC2_Idle;
            fi;
        // GPJ
        :: (SC2_current == SC2_GPJ_Sent) -> 
            GPJ_in_HS2_buffer = 1;
            if
            :: (SC2_timeout == 1) ->
                SC2_timeout = 0;
                SC2_current = SC2_exit;
            :: (SC2_timer < 5) ->
                SC2_timer = SC2_timer + 1;    // ACK Timeout
                if
                :: (SC2_timer == 5) ->
                    SC2_timeout = 1;
                    SC2_timer = 0;
                fi;
                SC2_current = SC2_GPJ_Sent;
            :: (GPA_isJoin2 == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPA_isJoin2 = 0;
                gp2 = 1;
                sc2_idle = 1;
                SC2_current = SC2_Idle;
            :: (GPA_isInvalid2 == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPA_isInvalid2 = 0;
                gp2 = 0;
                sc2_idle = 1;
                SC2_current = SC2_Idle;
            fi;
        // GPC
        :: (SC2_current == SC2_GPC_Sent) -> 
            GPC_in_HS2_buffer = 1;
            if
            :: (SC2_timeout == 1) ->
                SC2_timeout = 0;
                SC2_current = SC2_exit;
            :: (SC2_timer < 5) ->
                SC2_timer = SC2_timer + 1;    // ACK Timeout
                if
                :: (SC2_timer == 5) ->
                    SC2_timeout = 1;
                    SC2_timer = 0;
                fi;
                SC2_current = SC2_GPC_Sent;
            :: (GPA_in_HC2_buffer == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPA_in_HC2_buffer = 0;
                sc2_idle = 1;
                SC2_current = SC2_Idle;
            fi;
        // GPR
        :: (SC2_current == SC2_GPR_Sent) -> 
            GPR_in_HS2_buffer = 1;
            if
            :: (SC2_timeout == 1) ->
                SC2_timeout = 0;
                SC2_current = SC2_exit;
            :: (SC2_timer < 5) ->
                SC2_timer = SC2_timer + 1;    // ACK Timeout
                if
                :: (SC2_timer == 5) ->
                    SC2_timeout = 1;
                    SC2_timer = 0;
                fi;
                SC2_current = SC2_GPR_Sent;
            :: (GPL_in_HC2_buffer == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPL_in_HC2_buffer = 0;
                SC2_current = SC2_GPR_Sent;
            :: (GPE_in_HC2_buffer == 1) ->
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                GPE_in_HC2_buffer = 0;
                sc2_idle = 1;
                SC2_current = SC2_Idle;
            fi;
        // GPM
        :: (SC2_current == SC2_GPM_Sent) -> 
            GPM_in_HS2_buffer = 1;
            sc2_idle = 1;
            SC2_current = SC2_Idle;
        :: (SC2_current == SC2_GPM_View) -> 
            GPM_in_HS2_buffer = 0;
            sc2_idle = 1;
            SC2_current = SC2_Idle;
        // MSG
        :: (SC2_current == SC2_MSG_Sent) -> 
            MSG_in_SC_buffer = 1;
            if
            :: (SC2_timeout == 1) ->
                SC2_timeout = 0;
                SC2_current = SC2_exit;
            :: (SC2_timer < 5) ->
                SC2_timer = SC2_timer + 1;    // ACK Timeout
                if
                :: (SC2_timer == 5) ->
                    SC2_timeout = 1;
                    SC2_timer = 0;
                fi;
                SC2_current = SC2_MSG_Sent;
            :: (HS_ACK_Sent == 1) -> // Recv ACK
                HS_ACK_Sent = 0;
                SC2_timer_resolved = 1;
                SC2_timer = 0;
                sc2_idle = 1;
                SC2_current = SC2_Idle;
            fi;
        :: (SC2_current == SC2_MSG_View) ->
            MSG_in_SC2_buffer = 0;
            HS2_ACK_Sent2 = 1;
            sc2_idle = 1;
            SC2_current = SC2_Idle;
        // Exit
        :: (SC2_current == SC2_exit) -> 
            is_exit2 = 1;
            break;
    od;
}

// General Safety Properties
ltl p0 { ([] <>(hs_idle)) && ([] <>(sc_idle || is_exit)) && ([] <>(sc2_idle || is_exit2))}    // No infinite loops that will not go back to idle state (or exit the program)
ltl p1 { [] <>((hs_idle) && (sc_idle || is_exit) && (sc2_idle || is_exit2))}                  // All systems must be idle simultaneously at some time

// ACK Interactions
ltl q1 { [] ((SC_timer) -> ([] <> (SC_timer_resolved || SC_timeout)))}             // If timer is triggered, either timer is resolved or timeout occurs
ltl q2 { [] ((SC_timer) -> ([] (!sc_idle U (SC_timer_resolved || SC_timeout))))}   // If timer is triggered, it must resolves within the sub-routine

// Client-Server Interactions
ltl q3 { [] ((SC_current != SC_GPM_View) U (gp)) }                                 // One can not read group message until at group mode
ltl q4 { [] (!GPA_isInvalid) -> [](!gp U GPA_isJoin) }                             // If server returned invalid group Id, client will not be in group mode in all cases until it sents valid group ID again and server responds
ltl q5 { [] ((SC_timer) <-> (<> (SC_timeout)))}                                    // Triggered timer can cause timeout, and timeout can only be caused by timers

// Client-Client Interactions
ltl q6 { [] ((SC_current != SC_MSG_View) U (!gp)) }                                // One can not read private message until at private mode
ltl q7 { [] ((SC_current == SC_MSG_Sent) -> ([] <> (SC2_current == SC2_MSG_View)))}      // If a Private Message is sent from client to another, the another will eventually see it in all cases (assume no channel loss)

//ltl q7 { (SC_current == SC_MSG_Sent) -> ([] <>(SC2_current == SC2_MSG_View))}           // If a Private Message is sent from client to another, the another will eventually see it in all cases (assume no channel loss)

init 
{
    run HS_StateMachine();
    run SC_StateMachine();
    run SC2_StateMachine();
}