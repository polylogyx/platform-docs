PolyLogyx Endpoint Platform - Endpoint Monitoring at scale
===========================================================

The PolyLogyx Endpoint Visibility and Control Platform is a sophisticated, flexible and extensible endpoint monitoring and response platform. It can be deployed in cloud or on-prem with equal ease. It provides endpoint monitoring and visibility, threat detection and incident response for Security Operating Centres (SOCs). 

The Polylogyx platform is available in two variants, Enterprise Edition and Community Edition. All topics in this guide apply to the Enterprise Edition. Notes in the guide indicate topics that do not apply to the Community Edition. To request a trial copy of the platform, please email to open@polylogyx.com. You can access the Community Edition version at https://github.com/polylogyx/plgx-esp.

Intended Audience 
------------------

This guide is designed for security analysts and Security Operations Center
(SOC) teams who manage and maintain enterprise security. To use this guide
effectively, you should be familiar with Microsoft Windows and Ubuntu operating
systems.

Features 
---------

Built using the form factor of [osquery](https://osquery.io/) agent that is extended using [PolyLogx Extension](https://github.com/polylogyx/osq-ext-bin), at a high-level the PolyLogyx platform provides these features.

### Monitoring and visibility

Allows you to view and monitor endpoint-related information. You will always 
be informed of what is occurring at all times on all managed endpoints. It helps
you to meet your compliance needs and get real-time insight into network activity.

In addition to standard osquery events, you can also get information about these
events:

-   File actions (create, delete, timestomp, modify, and PE)

-   Registry operations (create and modify)

-   Process activities (open, create, terminate, map, and open handles)

-   Network events (socket, DNS request and response, HTTP, TLS credentials)

-   Removable media events

-   MSR values

-   EPP status (endpoint protection)

-   Image load (DLl, process, and drivers) events

-   Remote thread creation

-   YARA scan results

-   Memory forensics

-   File Acquistion

For more information on the type of information, see https://github.com/polylogyx/osq-ext-bin.

### Intrusion detection

To allow detection of malicious activities, PolyLogyx offers:

-   Alerting – You can set up various [detection rules](https://github.com/polylogyx/DetectionRules) to define alerts to stay updated on
    pertinent activities. After you set up a rule for an event, you receive an
    email when the event occurs, allowing you to take immediate action. You could also forward the alert to a SIEM for additional co-relation.

-   Threat intelligence – You can connect with various threat intel sources,
    such as [Virus Total](https://www.virustotal.com/gui/home/upload), [Alien Vault OTX](https://otx.alienvault.com/) and [IBM xForce](https://exchange.xforce.ibmcloud.com/).

-   Queries

    -   *Query packs* (such as the queries based on the MITRE attack framework)
        are provisioned during installation. These SQL-based *scheduled queries*
        run at regular intervals to fetch data stored on the endpoints. These
        queries serve as a starting point and can be configured to fetch data
        meaningful for your setup.

    -   *Live queries* that you can run to fetch specific information at a point
        in time. You can define the query and run it to see results.

### Response

To respond to a malicious activity, you can perform one or all of these
activities:

-   File deletion

-   Process kill

-   Network isolation


[Next >> Architecture Overview](01_Architecture/Readme.md)
