RPMComplianceInt
================

RPM: BSA compliance job integration

Remark: This is working only on RLM Unix server

The following files need to be install on the RLM server in the following directory: 
/opt/bmc/BRLM/server/webapps/ROOT/automation automation folder needs to be created
  done.jpg
  eng0.jpg
  eng1.jpg
  eng2.jpg
  rem_button.jpg
  button.clode_window.gif
  runscript.jsp
  waitrun.jsp
  remediate.sh
  
change the right of the files to 770

Back up /opt/bmc/BRLM/../Baa_execute_job_against.rb and replace it.
Import in BRPM library the automation script. If already there and used, replace the Baa_execute_job_against code by the
one in the file using BRPM automation editor.
