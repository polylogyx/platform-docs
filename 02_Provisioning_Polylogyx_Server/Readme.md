Provisioning the PolyLogyx Server 
===================================

The PolyLogyx server is a headless server platform that is flexible and allows
you to effectively manage and control data. Here are the features the PolyLogyx
server offers:

-   Agent and policy management

-   Data forwarding and management

-   OpenC2-based out-of-band command and control

-   Incident response, including proactive threat hunting and remediation

This chapter includes these topics:

-   [Before you Begin](#before-you-begin)

-   [Installing the PolyLogyx Server](#installing-the-polylogyx-server)

-   [Uninstalling the Server](#uninstalling-the-server)

-   [Upgrading the Server](#upgrading-the-server)

-   [Troubleshooting Server Installation
    Issues](#troubleshooting-server-installation-issues)

<br>Before you Begin
--------------------

Before you begin installation of the PolyLogyx server, ensure you read the
following information.

-   Server installation is supported only on the Ubuntu platform version 16.04 (or later) .

-   Recommended configuration for the PoC (supports 10-25 clients)

    -   250 GB of free space

    -   Quad Core processor


    -   16 GB RAM (Use 64 GB RAM if number of suppoerted clients > 500)

-   Contact PolyLogyx to procure the following:

    -   Server Docker image (plgx_docker.zip)

    -   Clean-up script (docker-cleanup.sh)

-   Docker and Docker Compose are required to install the PolyLogyx server.

| Component      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Docker (18.03.1-CE)         | Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. To get started with Docker, review the information on their [website](https://docs.docker.com/install/overview/). Review instructions for [Docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce) or [Docker EE](https://docs.docker.com/install/linux/docker-ee/ubuntu/) to install Docker on Ubuntu. |
| Docker Compose (1.21.1 or later) | Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration. To install Docker Compose, complete the [prerequisites](https://docs.docker.com/compose/install/#prerequisites) and then perform [installation](https://docs.docker.com/compose/install/#install-compose). 


Installing the PolyLogyx Server
-------------------------------

After you install Docker and Docker Compose, you can install the PolyLogyx
server.

1.  Clean-up existing Docker images and containers using the docker-cleanup.sh
    file.
    
    ```~/Downloads\$ sh ./docker-cleanup.sh```

**Note:** This will clean **all** the images and containers.

2.  Unzip the plgx_docker.zip file on the local server.
    ```(Md5: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)
    ~/Downloads$ ls
    plgx_docker.zip
    ~/Downloads$ unzip plgx_docker.zip 
    Archive:  plgx_docker.zip
    inflating: plgx_docker/server.crt 
    <snip>
    inflating: plgx_docker/Doorman/doorman/plugins/alerters/debug.pyc  
    ~/Downloads$ ls
    plgx_docker  plgx_docker.zip```
3.  Switch to the folder where the installer is placed.

    ```~/Downloads\$ cd plgx_docker/```
4.  Enter the certificate-generate.sh script to generate certificates for
    osquery.  
    ```~/Downloads/plgx_docker$ sh ./certificate-generate.sh <IP address>```
    ```x.x.x.x
    Generating a 2048 bit RSA private key
    .........................................................................................+++
    .........................+++
    writing new private key to 'nginx/private.key'
    ``` 
            
    In the syntax, \<IP address\> is the IP address of the system on which on to host the PolyLogyx server. This will generate 
    the certificate for osquery (used for provisioning clients) and place the certificate in the plgx_docker folder.

5.  Modify and save the docker-compose.yaml file.

    1.  Edit the following configuration parameters in the file. In the syntax, replace the values in angle brackets with required values.
    ```
    ENROLL_SECRET=<secret value>
    POLYLOGYX_USER=<user login name> 
    POLYLOGYX_PASSWORD=<login password> 
    *RSYSLOG_FORWARDING=true
    *LOGSTASH_FORWARDING=true
    VT_API_KEY=<VirusTotal Api Key> 
    IBMxForceKey=<IBMxForce Key> 
    IBMxForcePass=<IBMxForce Pass>
    APPLY_DEFAULT_POLICY=true|false  
    PURGE_DATA_DURATION=<number of days>  
    THREAT_INTEL_LOOKUP_FREQUENCY=<number of minutes> 
     ```   
| Parameter      | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|ENROLL_SECRET
    | Specifies the enrollment shared secret that is used for authentication.     |
|POLYLOGYX_USER 
   | Refers to the user login name for the PolyLogyx server.   |
|POLYLOGYX_PASSWORD 
     | Indicates to the password for the PolyLogyx server user.  |
|*RSYSLOG_FORWARDING=true
   |   |
|*LOGSTASH_FORWARDING=true
   |   |
|VT_API_KEY=<VirusTotal Api Key> 
   |   |
|IBMxForceKey=<IBMxForce Key> 
    |   |
|IBMxForcePass=<IBMxForce Pass>
    |   |
|APPLY_DEFAULT_POLICY=true|false
    |   |
|PURGE_DATA_DURATION=<number of days>
    |   |
|THREAT_INTEL_LOOKUP_FREQUENCY          
    |   |
    
    3. Ensure all the ports specified in the YAML file are open and accessible
    4. Save the file.
6.  Run the following command to start Docker compose.

    ```docker-compose up```
    
    Typically, this takes approximately 10-15 minutes. The following lines appear on
    the screen when Docker starts:
    ````Starting plgx_docker_rabbit1_1  ... done
        Starting plgx_docker_postgres_1 ... done
        Starting plgx_docker_vasp_1     ... done
        Attaching to plgx_docker_rabbit1_1, plgx_docker_postgres_1, plgx_docker_vasp_1
        .
        .
        .
        API key is : <API_KEY>
        Server is up and running```
        
7.  Log on to server using following URL using the latest version of Chrome or
    Firefox browser.
    
    ```https://<ip address>:5000/manage```

    In the syntax, `<IP address>` is the IP address of the system on which the
    PolyLogyx server is hosted. This is the IP address you specified in step 4.

8.  Ignore the SSL warning, if any.

9.  Log on to the server using the credentials provided above at step 5a.

10.  Provision the clients. For more information, see [Provisioning the PolyLogyx
    Client for Endpoints](#provisioning-the-polylogyx-client-for-endpoints).

Uninstalling the Server 
------------------------

To uninstall the PolyLogyx server, run the following command to clean-up
existing Docker images and containers.

```~/Downloads\$ sh ./docker-cleanup.sh```

**Note:** This will clean **all** the images and containers.

Upgrading the Server
--------------------

Upgrading the PolyLogyx server is manual process. Complete these steps to perform an upgrade:

1. Back up the certificate.crt and private.key files stored in the nginx directory in the installation
directory. 
2. Back up the postgres-data folder from the existing installation directory. 
3. Uninstall the installed version. For more
information, see [Uninstalling the Server](#uninstalling-the-server).
4. Install the latest version of the server. When installing, instead of performing step 4:

    1. Copy the certificate.crt and private.key files you backed up to the nginx directory. 
    
    2. Set –tls_hostname=<IP_ADDRESS>:9000 for both the resources/osquery.flags and resources/osquery_linux.flags files.
    
    3. Copy the backed up postgres-data folder you backed up to the new installation directory.
    
   For more information, see [Installing the PolyLogyx Server](#installing-the-polylogyx-server).

|										|																							|
|:---									|													   								    ---:|
|[Previous << Architecture Overview](../01_Architecture/Readme.md)  | [Next >> Provisioning the PolyLogyx Client](../03_Provisioning_Polylogyx_Client/Readme.md)|
