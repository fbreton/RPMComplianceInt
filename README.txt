RPMComplianceInt
================

RPM: BSA compliance job integration

Remark: This is working only on RLM Unix server
=======

Installation:
=============
The following files need to be install on the RLM server in the following directory: 
<RLM Install directory>/server/webapps/ROOT/automation automation folder needs to be created
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
Open runscript.jsp to change line 8: String cmd="/opt/bmc/BRLM/server/webapps/ROOT/automation/remediate.sh"; for the path to be inline with your environment

Back up <RLM Install directory>/releases/4.3.0/RPM/WEB-INF/lib/script_support/LIBRARY/automation/BMC Application Automation 8.2/baa_execute_job_against.rb 
and replace it. Import in BRPM library the automation script. 
If already there and used, replace the Baa_execute_job_against code by the one in the file using BRPM automation editor.

This code need the following prerequisites in BSA to be used:
	"Depot -> Remediation packages" folder and "Jobs -> Remediation" folder need to exists
	

Improvments to be done:
=======================
1. Not have hardcoded the BSA Job and Depot folder name used for remediation.
2. Be able to manage more than one compliance job at the same time: Generate temp file storing Job DBKey and Job run id with name 
associated with req/step and not with a fixe hardcoded name.
