Response Actions
=================================== 
<span style="color:red">*Only available in the Enterprise Edition of the PolyLogyx ESP.* </span>
<font color='red'>Only available in the Enterprise Edition of the PolyLogyx ESP.</font>

PolyLogyx platform provides the security administrator abilities to take certain controlled actions in response to the detection of an intrusion, or attempt of one. These actions can allow the admininstrator to:

a) Delete a file from the endpoint

b) Terminate a process on the endpoint

c) Push a host firewall rule on the endpoint for containment, or limit, the network access

The response actions are available on Windows endpoints only. 

Perform these steps to respond to an alert:
1. Access the web interface for the server.
2. Navigate to SOC Operations > Response. 

   ![response_menu](https://github.com/preetpoly/test/blob/pooja/response_menu.png)
3. Click Add Response. The Send Response to Agent page is displayed. 
   To respond to an alert, you can delete a file, terminate a process, or isolate an endpoint from the network.
   
   ![send_response](https://github.com/preetpoly/test/blob/pooja/send_response.png)
   1. To delete a file, specify the full file name in the input text box, with the optional MD5 hash of the file, and the target endpoint.
   2. To terminate a process, specify the PID (process ID) and target endpoint.
   3. To isolate an endpoint and contain the endpoint, by pushing down a rule to filter the network traffic permitted to enter the computer from the network, and also control what network traffic the computer is allowed to send to the network. On the endpoint, this capability is implemented by leveraging the Windows Host Firewall interface. For details on the internals of Windows Firewall, please visit: https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc722141(v=ws.10)
   
4. Specify the details for the response and click Add.
