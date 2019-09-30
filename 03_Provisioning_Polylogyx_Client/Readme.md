Provisioning the PolyLogyx Client for Endpoints
================================================

The PolyLogyx client that is a part of the PolyLogyx endpoint platform,
leverages osquery, a multi-platform operating system monitoring and
instrumentation framework. Here are the features the PolyLogyx client offers:

-   Compliance (PCI, HIPAA)

-   Digital forensics

-   Asset and inventory use cases

-   Vulnerability management

-   Host intrusion detection

-   Performance and operational troubleshooting

Typically, deploying osquery and running it across your fleet can be a daunting and complicated task, because of its large configuration surface and option.  To simplify the deployment of PolyLogyx osquery based agent, the platform is shipped with a Client Provisioning Tool (CPT) that wraps all the necessary configuration and makes the client provisioning process extremely simplified. 

This chapter includes these topics:

-   [Installing the PolyLogyx Client](#installing-the-polylogyx-client)

-   [Uninstalling Client](#uninstalling-the-client)

-   [Upgrading the Client](#upgrading-the-client)

-   [Troubleshooting Client Installation
    Issues](#troubleshooting-client-installation-issues)

Installing the PolyLogyx Client 
--------------------------------

Installing the PolyLogyx client involves these steps:

1.  Complete the needed prerequisites. See [Before you
    Begin](#before-you-begin-1) for more information.

2.  Deploy the client. See [Deploying the PolyLogyx
    Client](#deploying-the-polylogyx-client) for more information.

3.  Verify if the installation was successful. See [Verifying Client
    Installation](#verifying-client-installation) for more information.

### Before you Begin

Before you begin installation, ensure you complete the following prerequisites.

-   Procure the needed software by requesting the access from the [PolyLogyx
    site](https://polylogyx.com/downloads).

-   Provision a PolyLogyx server using a docker image. For more information, see
    [Provisioning the PolyLogyx Server](#getting-started).

-   Ensure you have working knowledge of osquery. If not, please read about
    [osquery](https://osquery.io/).

-   Make sure the endpoints meet the following system requirements.

    -   Support 64-bit architecture

    -   Windows 7 or later operating system installed as specified [here](https://github.com/polylogyx/osq-ext-bin)

    -   Do not have these installed:

        -   osquery

        -   older version of PolyLogyx client

    -   Do not have host-based firewalls or other security tools that might
        interfere with a remote installation

    -   Allow outbound TCP traffic on port 9000

### Deploying the PolyLogyx Client

Use the PolyLogyx Client Provisioning Tool (CPT) utility to deploy the PolyLogyx
client on endpoints. After you identify endpoints on which to deploy the client,
push the CPT utility and public key file to the endpoints using any standard
mechanism, such as SCCM.

Initiate a remote session and run the installation command remotely (using
PSEXEC or WMIC command line utilities) with administrative privileges.

Here is the syntax to execute the installation command.

```plgx_cpt.exe -p -i <ip address> | -h <hostname> -k <server's public key file> [-v <osquery version>] [-o <download directory>]```

Here is the syntax description.

| Parameter | Description                                                                                                                                                                                  |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \-p  | Signifies the option for provisioning the client                                                                                                                          |
| \-i or -h | Specify one of the following. This is a required parameter. -i represents the IP address of the PolyLogyx management server (x.x.x.x format). -h represents the fully qualified domain name to the management server in the format a.b.c. You don’t need to https.                                                                                                                              |
| \-k       | Indicates the full path to the server public key file. This is a required parameter.                                                                                                         |
| \-v       | Represents the osquery version to be installed. Currently, only version 3.2.6 is supported. This is an optional parameter. If you do not specify a version, the latest version is installed. |
| \-o       | Indicates the location at which to download. The default value is c:\\plgx-temp\\. This is an optional parameter.                                                                            |

Here is an example of a remote command execution using PSEXEC.

```psexec \\101.101.1.101 -u Administrator cmd /c dir C:\Users\Administrator\plgx_cpt.exe -p -i 11.111.111.11 -k c:\certificate.crt```

The installation begins and the CPT utility brings the required artefacts on the
endpoints. After installation is complete, the Osquery 3.2.4 and PolyLogyx
extensions are deployed and the osqueryd service starts. Also, CPT is installed as a Windows service and it acts as a watcher for osqueryd service starts. If the osqueryd service stops, the CPT service restarts it. The following output is
displayed if the command is successful.

```
Downloading Files needed for install. Depending on your network connection, it might take some time. Please wait..
Osquery successfully installed.
Configuring client..Please wait..
Service stopped successfully
Osquery stopped
Client configuration..Ready to go in 5 seconds..
Service start pending...
Service started successfully.
CPT Service installed successfully
Service start pending...
Service started successfully.
=== PolyLogyx osquery client installed Successfully ===
```


### Verifying Client Installation 

After you deploy the PolyLogyx client, complete these steps to verify the
installation. When the PolyLogyx client is installed successfully, the following
processes start:

1.  osqueryd service

2.  vast service

3.  vastnw service

4.  Plgx_win_extension.exe process

Installation is not successful if any of these fail to start.

Follow these steps to check if the required processes are running.

1.  Open a command window with administrative privileges.

2.  Run the following command to check the state of software stack, including
    osquery, PolyLogyx Extension and associated services.

```plgx_cpt.exe –c```

The command output lists the current state of the osqueryd, vast, and vastnw
services.
```osqueryd service up and running
===================================================
||           Query Execution Output              ||
===================================================
name : plgx_win_extension
path : \\.\pipe\osquery.em.3694
sdk_version : 1.0.0
type : extension
uuid : 3694
version : 1.0.0

===================================================
||          Query Execution Finished             ||
===================================================

vast service up and running
vastnw service up and running  
```

1.  Review the output to verify if the required services are running.

2.  Check if the plgx_win_extension.exe process is running.

3.  Open Task Manager.

4.  Switch to the Details tab.

5.  Locate the entry for the plgx_win_extension.exe process.

6.  Verify that process status is set to Running.

    ![process](https://github.com/preetpoly/test/blob/master/process.png)

Uninstalling the Client
-----------------------

Follow these steps to uninstall the PolyLogyx client.

1.  Open a command window with administrative privileges.

2.  Close any open instances of the osqueryd, vast, and vastnw services.

3.  Run the uninstall command.

    Here is the syntax to execute the installation command.

```plgx_cpt.exe -u {\<d\> full-uninstall \| \<s\> shallow-uninstall}```

The -u parameter is used to uninstall the agent and cannot be combined with any
other options. With the –u option, you must use one of these options:

| Option | Description                                                                                                                           |
|--------|---------------------------------------------------------------------------------------------------------------------------------------|
| s    | Used with the –u parameter for shallow uninstall. This option only uninstalls the software and does not delete associated data files. |
| d    | Used with the –u parameter for deep uninstall. This option removes all traces of the agent, including data files.                     |

Here are command examples.

The following output is displayed if the `plgx_cpt.exe -u d` command is successful. 
``` uninstall_osq, will remove everything osquery , db and all folders
Stopping services. Please wait for a few second. As they say, Patience is a Virtue
Services stopped successfully !!
Uninstalling Polylogxy osquery client successful. Removing all the services..
Service stopped successfully
Removing files..
```   

The following output is displayed if the `plgx_cpt.exe -u s` command is successful.
``` uninstall_osq_shallow, will only uninstall osquery but keep database untouched
Detected existing installation of osquery..
Service stopped successfully
Uninstalling osquery successful
Service stopped successfully
Trying to remove C:\ProgramData\osquery\plgx_win_extension.ext.exe
```                                                                                                                                                                                                                                                                              

Upgrading the Client 
---------------------

Follow these steps to upgrade the PolyLogyx client.

1.  Open a command window with administrative privileges.

2.  Run the upgrade command.

    Here is the syntax to execute the upgrade command.

```plgx_cpt.exe -p -i <ip address> | -h <hostname> -k <server's public key file> [-g {<f> <update flagsfile>} | {<x> <update extension binary alone>} | {<a> <update osquery full>} | {<o> <update osquery only without extension>} | {<c> <update cpt>]}```

The -g parameter is used to upgrade the agent and cannot be combined with any
other options. With the –g option, you must use one of these options:

| Parameter | Description                                                                                                                                                                                  |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| f       | Upgrades only the osquery.flags file.                                                                                                                                    |
| x       | Upgrades only the plgx_win_extension.ext.exe.                                                                                                         |
| a       | Upgrades osquery (flags file and osqueryd.exe file) and the PolyLogyx extension (plgx_win_extension.ext.exe).                                                                                                              |
| o       | Upgrades only the osquery (osqueryd.exe) file.   |
| c       | Upgrades the plgx_cpt.exe file.                                                                            |

The following output is displayed if the `plgx_cpt.exe -g a` command is successful. 
```
Server URL: server.yourorg.com
Trying to upgrade osquery in full mode including extension bins..Please wait..
Service stopped successfully
Osquery stopped
Service stopped successfully
Service stopped successfully
Osquery is alreday installed, Uninstalling it in shallow mode
Detected existing installation of osquery..
Service is already stopped.
Uninstalling osquery successful
Service stopped successfully
Service stopped successfully
Service is already stopped.
Trying to remove C:\ProgramData\osquery\plgx_win_extension.ext.exe
Downloading Files needed for install. Depending on your network connection, it might take some time. Please wait..
Osquery successfully installed.
Configuring client..Please wait..
Service stopped successfully
Osquery stopped
Client configuration..Ready to go in 5 seconds..
Service start pending...
Service started successfully.
CPT Service installed successfully
Service start pending...
Service started successfully.
=== PolyLogyx osquery client installed Successfully ===
```

Troubleshooting Client Installation Issues
------------------------------------------

This section examines the common errors and their resolution.

To resolve general osquery-related issues, review their [slack
channel](https://osquery-slack.herokuapp.com/).

### Incorrect server details

The following error mesaage is displayed when you run a command with incorrect
server details, such as IP address or host name.

``` Downloading Files needed for install. Depending on your network connection, it might take some time. Please wait..
Transfer failed for [c:\plgx-temp\osquery.flags] , Error Code: 7 (Couldn't connect to server)
Downloading files from Server failed
```

**Resolution**: To resolve this issue, execute the command with correct server
details.

### Insufficient privileges

The following error message is displayed when you run a command without
administrative privileges or sufficient arguments.

``` ##########################################
## Insufficient Privileges ###############
## Need Administrator privileges to run CPT#
##########################################
```

**Resolution**: To resolve this issue, execute the command with administrative
privileges and sufficient arguments.

### Incorrect certificate file name or path

If you execute the command to install the PolyLogyx client with an incorrect
certificate path, the following error is displayed.

``` Failed to open Server's public key file c:\Users\user1\certificate.crt , Error: 2
Failed to read server's public key from input file [c]
```
**Resolution**: To resolve this error, execute the command with the correct
path.

### Invalid certificate

If you execute the command to install the PolyLogyx client with administrative
privileges but with an invalid certificate, the following error is displayed.

``` Downloading Files needed for install. Depending on your network connection, it might take some time. Please wait..
Transfer failed for [c:\plgx-temp\osquery.msi] , Error Code: 60 (Peer certificate cannot be authenticated with given CA certificates)
Downloading files from Server failed
=== Failed to configure  ===
```

**Resolution**: To resolve this error, execute the command with a valid
certificate.

### Failed to configure Osquery

If you try to install the PolyLogyx client when osquery already installed, the
following error message is displayed.

``` Osquery is already installed, please uninstall before proceeding. Using plgx_cpt.exe -u <d/s> option```

**Resolution**: Follow these steps to resolve the issue:

1.  If osquery is already installed, use tool with -u option to uninstall
    osquery. For more information, see [Uninstalling the
    Client](#uninstalling-the-client).

2.  Execute the command to install the PolyLogyx client with administrative
    rights and a valid certificate. For more information, see [Deploying the
    PolyLogyx Client](#deploying-the-polylogyx-client).

	
|										|																							|
|:---									|													   								    ---:|
|[Previous << Provisioning the PolyLogyx Server](../02_Provisioning_Polylogyx_Server/Readme.md)  | [Next >> Configuring the client](../04_PolyLogyx_Client_Configurations/Readme.md)|
