#!/bin/bash
user="BLAdmin"
password="password"
{
  read dbkey
  read runId
} </opt/bmc/BRLM/server/webapps/ROOT/automation/param.txt

soapcmd="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:log=\"http://bladelogic.com/webservices/skeleton/login\">
    <soapenv:Body>
        <log:loginUsingUserCredential>
            <log:userName>${user}</log:userName>
            <log:password>${password}</log:password>
            <log:authenticationType>SRP</log:authenticationType>
        </log:loginUsingUserCredential>
    </soapenv:Body>
</soapenv:Envelope>
"
sessId=`curl -s -k -H "Content-Type: text/xml" -H 'SOAPAction: "https://bl-appserver:9843/services/LoginService"' -d "$soapcmd" -X POST https://bl-appserver:9843/services/LoginService?wsdl|grep returnSessionId|sed -e 's/.*<ns2:returnSessionId>//' -e 's/<\/ns2.*//'`
soapcmd="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ins0=\"http://bladelogic.com/webservices/framework/xsd\" xmlns:ass=\"http://bladelogic.com/webservices/skeleton/assumerole\">
    <soapenv:Header>
        <ins0:sessionId>$sessId</ins0:sessionId>
    </soapenv:Header>
    <soapenv:Body>
        <ass:assumeRole>
            <ass:roleName>BLAdmins</ass:roleName>
        </ass:assumeRole>
    </soapenv:Body>
</soapenv:Envelope>
"
result=`curl -s -k -H "Content-Type: text/xml" -H 'SOAPAction: "https://bl-appserver:9843/services/AssumeRoleService"' -d "$soapcmd" -X POST https://bl-appserver:9843/services/AssumeRoleService?wsdl`

soapcmd="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://bladelogic.com/webservices/framework/xsd\" xmlns:clit=\"http://bladelogic.com/webservices/skeleton/clitunnel\">
    <soapenv:Header>
        <xsd:sessionId>$sessId</xsd:sessionId>
    </soapenv:Header>
    <soapenv:Body>
        <clit:executeCommandByParamList>
            <clit:nameSpace>ComplianceJob</clit:nameSpace>
            <clit:commandName>createRemediationJobFromComplianceResultByRule</clit:commandName>
            <clit:commandArguments>sync</clit:commandArguments>
            <clit:commandArguments>/Remediation</clit:commandArguments>
            <clit:commandArguments>/Remediation packages</clit:commandArguments>
            <clit:commandArguments>${dbkey}</clit:commandArguments>
            <clit:commandArguments>${runId}</clit:commandArguments>
            <clit:commandArguments></clit:commandArguments>
            <clit:commandArguments></clit:commandArguments>
            <clit:commandArguments></clit:commandArguments>
            <clit:commandArguments></clit:commandArguments>
            <clit:commandArguments></clit:commandArguments>
            <clit:commandArguments>false</clit:commandArguments>
            <clit:commandArguments>true</clit:commandArguments>
        </clit:executeCommandByParamList>
    </soapenv:Body>
</soapenv:Envelope>
"
dbkey=`curl -s -k -H "Content-Type: text/xml" -H 'SOAPAction: "https://bl-appserver:9843/services/CLITunnelService"' -d "$soapcmd" -X POST https://bl-appserver:9843/services/CLITunnelService?wsdl|grep 'ns5:returnValue'|sed -e 's/.*<ns5:returnValue.*>DBKey/DBKey/' -e 's/<\/ns5:returnValue>.*//'`

soapcmd="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://bladelogic.com/webservices/framework/xsd\" xmlns:clit=\"http://bladelogic.com/webservices/skeleton/clitunnel\">
    <soapenv:Header>
        <xsd:sessionId>$sessId</xsd:sessionId>
    </soapenv:Header>
    <soapenv:Body>
        <clit:executeCommandByParamList>
            <clit:nameSpace>DeployJob</clit:nameSpace>
            <clit:commandName>executeJobAndWait</clit:commandName>
            <clit:commandArguments>${dbkey}</clit:commandArguments>
        </clit:executeCommandByParamList>
    </soapenv:Body>
</soapenv:Envelope>
"
result=`curl -s -k -H "Content-Type: text/xml" -H 'SOAPAction: "https://bl-appserver:9843/services/CLITunnelService"' -d "$soapcmd" -X POST https://bl-appserver:9843/services/CLITunnelService?wsdl`
