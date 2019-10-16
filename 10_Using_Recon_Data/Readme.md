Understanding Recon Data
=================

As the name suggests, recon refers to preliminary research or analysis. After
the PolyLogyx client is provisioned and the connection to the PolyLogyx server
is established, you can run recon queries to pull relevant information for
each node. To run the queries, navigate to the Nodes page, select a host, and click Run recon. 

For each configured node, these queries fetch detailed data. The
fetched data provides insight and visibility on these aspects.

| Parameter                       | Description         |                                                                                                                                                                                                                                                                                           
|---------------------------------|-------------------- |
| Application compatibility shims | Application compatibility shims enable you to fake aspects of the environment for a given application and allow fixing of issues that an application might encounter on a new version of Windows. Malwares leverage shim data bases (SDBs) as a persistence mechanism. Lists the SDBs on your system. |
| Application hashes              | Lists the hash information for applications on your system. |                                                                                                                                                                                                                                   
| Certificates                    | Digital certificates are used to establish the identity and trust level of software programs. Lists the various digital certificates installed on your system. |                                                                                                                                  
| Chrome extensions               | Lists the Chrome extensions installed on your system.    |                                                                                                                                                                                                                                             
| Drivers                         | Lists the various device drivers installed on your system.     |                                                                                                                                                                                                                                    
| etc hosts                       | The hosts file is used by an operating system to resolve a computer (or an internet domain) to an address. Lists the entries in the hosts file of your system. |                                                                                                                                       
| Internet Explorer extensions    | Lists the Internet Explorer extensions installed on your system.    |                                                                                                                                                                                                                                   
| Kernel info                     | Lists the kernel details for your system.      |                                                                                                                                                                                                                                                        
| Kva speculative info            | Provides the presence (or absence) of mitigations for Spectre and Meltdown vulnerabilities.   |                                                                                                                                                                                                         
| Patches                         | Lists the updates or patches installed on your system.   |                                                                                                                                                                                                                                              
| Scheduled tasks                 | scheduled_tasks (or cron jobs) are programs run by the task scheduler component of an operating system to run specified jobs at regular intervals. Malware can sometimes abuse this feature of an operating system. Provides the various scheduled tasks configured on your system.                   |
| Startup items                   | Lists applications are automatically started with the launch of your system. Malwares can install themselves as a start_up item on a system to gain persistence. |                                                                                                                                       
| Time                            | Provides the system time stamp in Unix and UTC formats. The timestamp represents the time at which the agent starts after installation or reboot. |                                                                                                                                                    
| Windows epp table               | Lists the status of the Anti-Virus solutions on your system.    |                                                                                                                                                                                                                                      
| Windows programs                | Lists the Windows programs installed or running on your system. |                                                                                                                                                                                                                                     
| Windows services                | A Windows service is a program that operates in the background and is often loaded automatically on start-up. Lists the services running on your system.  |                                                                                                                      

 |										|																							|
|:---									|													   								    ---:|
|[Previous << Carves](../09_Carves/Readme.md)  | [Next >> Responses](../11_Responses/Readme.md)|
