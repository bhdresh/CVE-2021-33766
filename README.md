## POC Exploit CVE-2021-33766 (ProxyToken)

POC Exploit for CVE-2021-33766 (ProxyToken) is a handy shell script which provides pentesters and security researchers a quick and effective way to test Microsoft Exchange ProxyToken vulnerability. 

### Disclaimer

This program is for Educational purpose ONLY. Do not use it without permission. The usual disclaimer applies, especially the fact that me (bhdresh) is not liable for any damages caused by direct or indirect use of the information or functionality provided by these programs. The author or any Internet provider bears NO responsibility for content or misuse of these programs or any derivatives thereof. By using this program you accept the fact that any damage (dataloss, system crash, system compromise, etc.) caused by the use of these programs is not bhdresh's responsibility.

Finally, this is a personal development, please respect its philosophy and don't use it for bad things!

### Licence
CC BY 4.0 licence - https://creativecommons.org/licenses/by/4.0/

### Command line arguments:

    # ./proxytoken.sh -m <Mode> -s <Exchange Server IP>  -t <Target Email Address> -v <Victim Email Address>
    
          -m <inboxrule | check | newcheck>
            - check = Check if Exchange server is vulnerable or not (Require valid target user)
            - newcheck = Check if Exchange server is vulnerable or not without any target user
            - inboxrule = Create an inbox rule in the victim's mailbox to redirect emails to the target email address. 
          -s <Exchange Server IP/Domain> 
          -t <Target Email Address>
          -v <Victim Email Address>

### POC Video

https://vimeo.com/595583399
    
### Reference

https://www.zerodayinitiative.com/blog/2021/8/30/proxytoken-an-authentication-bypass-in-microsoft-exchange-server

### Bug, issues, feature requests

Obviously, I am not a fulltime developer so expect some hiccups

Please report bugs, issues through https://github.com/bhdresh/CVE-2021-33766-ProxyToken/issues
