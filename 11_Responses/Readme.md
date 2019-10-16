Response Actions
=================================== 
<span style="color:red">**Only available in the Enterprise Edition of the PolyLogyx ESP.** </span>

PolyLogyx platform provides the security administrator abilities to take certain controlled actions in response to the detection of an intrusion, or attempt of one. These actions can allow the admininstrator to:

a) Delete a file from the endpoint

b) Terminate a process on the endpoint

c) Push a host firewall rule on the endpoint for containment, or limit, the network access

The response actions are available on Windows endpoints only. 

Perform these steps to take a response.
1. Access the web interface for the server.
2. Navigate to SOC Operations > Response. 

   ![response_menu](https://github.com/preetpoly/test/blob/pooja/response_menu.png)
3. Click Add Response. The Send Response to Agent page is displayed. 
   On thid page, you can delete a file, terminate a process, or isolate an endpoint from the network.
   
   1. To delete a file, set the Target value to file, specify the full file name in the input text box, with the optional MD5 hash of the file, and the target endpoint.
   
   ![target_file](https://github.com/preetpoly/test/blob/pooja/target_file.png)
   
   2. To terminate a process, set the Target value to process, specify the PID (process ID) and target endpoint.
   
   ![target_process](https://github.com/preetpoly/test/blob/pooja/target_process.png)
   
   3. To isolate an endpoint using Windows Host Firewall interface, set the Target value to network and specify the other values. For details on the other values, see this [page](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc722141(v=ws.10)).
   
   ![target_network](https://github.com/preetpoly/test/blob/pooja/target_network.png)
   
 4. Click Add to apply the changes.
 
    The response is created and listed on the Reponses page. 
 5. Review the response status to verify if the corresponding action was taken.  
 
 |										|																							|
|:---									|													   								    ---:|
|[Previous << Using Recon Data](../10_Using_Recon_Data/Readme.md)  | [Next >> Tables](../12_Tables/Readme.md)|
