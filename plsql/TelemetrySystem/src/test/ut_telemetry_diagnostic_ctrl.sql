CREATE OR REPLACE PACKAGE ut_telemetry_diagnostic_ctrl IS
   -- %suite(ut_telemetry_diagnostic_ctrl)
   -- %suitepath(TelemetrySystem)

   -- %test(check_transmission should send a diagnostic message and receive a status message response)
   PROCEDURE ct_send_diag_and_rcv_status;
END ut_telemetry_diagnostic_ctrl;
/

CREATE OR REPLACE PACKAGE BODY ut_telemetry_diagnostic_ctrl IS
   PROCEDURE ct_send_diag_and_rcv_status IS
   BEGIN
      NULL;
   END ct_send_diag_and_rcv_status;
END ut_telemetry_diagnostic_ctrl;
/