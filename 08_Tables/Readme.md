Tables
======

The PolyLogyx Endpoint Platform leverages osquery that enables PolyLogyx to
expose the endpoint node as a relational database in the form of SQL tables.
These tables represent a breadth of system information, including running
processes, installed applications, hardware properties, and network connections.
As a result, you can run simple SQL queries to simple gain visibility for a
*point in time* view of the endpoint node.

PolyLogyx has extended and optimized osquery to support detection and response
use cases by adding new tables (see below). Where required, the tables are real
time (evented) in nature to ensure all activity is captured for analysis and
investigation.

For more information on the tables, see:

-   [PolyLogyx Tables](#polylogyx-tables)

-   [osquery Tables](#osquery-tables)

PolyLogyx Tables
----------------

Here are the PolyLogyx tables that allow real time activity monitoring
(evented).

-   [win_dns_events](#win_dns_events-table)

-   [win_dns_response_events](#win_dns_response_events-table)

-   [win_epp_table](#win_epp_table-table)

-   [win_file_events](#win_file_events-table)

-   [win_file_timestomp_events](#win_file_timestomp_events-table)

-   [win_http_events](#win_http_events-table)

-   [win_image_load_events](#win_image_load_events-table)

-   [win_image_load_process_map](#win_image_load_process_map-table)

-   [win_msr](#win_msr-table)

-   [win_obfuscated_ps](#win_obfuscated_ps-table)

-   [win_pefile_events](#win_pefile_events-table)

-   [win_process_events](#win_process_events-table)

-   [win_process_handles](#win_process_handles-table)

-   [win_process_open_events](#win_process_open_events-table)

-   [win_registry_events](#win_registry_events-table)

-   [win_remote_thread_events](#win_remote_thread_events-table)

-   [win_removable_media_events](#win_removable_media_events-table)

-   [win_socket_events](#win_socket_events-table)

-   [win_yara_events](#win_yara_events-table)

### win_dns_events Table

Captures the DNS look up details.

| Column          | Type    | Description                                      |
|-----------------|---------|--------------------------------------------------|
| action          | TEXT    | DNS lookup                                       |
| eid             | TEXT    | Unique event identifier                          |
| event_type      | TEXT    | DNS request                                      |
| domain_name     | TEXT    | Domain name to be looked up                      |
| pid             | INTEGER | Process identifier of process making DNS request |
| request_type    | INTEGER | Request Type                                     |
| request_class   | INTEGER | Request Class                                    |
| remote_addresss | TEXT    | IP address to which the look up request is sent  |
| remote_port     | INTEGER | Remote port                                      |
| time            | INTEGER | Time stamp of the event in unix format           |     
| utc_time        | TEXT    | Time stamp of the event in UTC                   |

### win_dns_response_events Table

Captures the DNS response events and can assist in mapping the DNS look up to
the source process based on IP address in the
[win_socket_events](#win_socket_events-table) table.

| Column          | Type    | Description                                              |
|-----------------|---------|----------------------------------------------------------|
| action          | TEXT    | DNS response                                             |
| eid             | TEXT    | Unique event identifier                                  |
| event_type      | TEXT    | DNS response                                             |
| domain_name     | TEXT    | Domain name to be looked up                              |
| request_type    | INTEGER | Response Type                                            |
| request_class   | INTEGER | Response Class                                           |
| resolved_ip     | TEXT    | Resolved IP address                                      |
| pid             | INTEGER | Process identifier of the process making the DNS request |
| remote_address  | TEXT    | Remote Address                                           |
| remote_port     | INTEGER | Remote port                                              |
| time            | INTEGER | Time stamp of the event in unix format                   |
| utc_time        | TEXT    | Time stamp of the event in UTC                           |

### win_epp_table Table

Stores name, type, state, and status of signatures of endpoint security products
deployed on the endpoint.

| Column             | Type | Description                       |
|--------------------|------|-----------------------------------|
| product_type       | TEXT | Endpoint Product Type             |
| product_name       | TEXT | Endpoint Product Name             |
| product_state      | TEXT | Endpoint Product State (On/Off)   |
| product_signatures | TEXT | Endpoint Product Signatures State |

### win_file_events Table

Captures file creation, deletion, and modification events based on the
configuration.

| Column       | Type    | Description                                |
|--------------|---------|--------------------------------------------|
| action       | TEXT    | Create, delete, or write events            |
| eid          | TEXT    | Unique event identifier                    |
| target_path  | TEXT    | Complete file path                         |
| md5          | TEXT    | MD5 hash of file contents, if available    |
| sha256       | TEXT    | SHA256 hash of file contents, if available |
| hashed       | INTEGER | Hash available or not                      |
| uid          | TEXT    | User name of file owner                    |
| time         | INTEGER | Time stamp of the event in unix format     |
| utc_time     | TEXT    | Time stamp of the event in UTC             |
| pe_file      | TEXT    | True, if file is an executable binary file |
| pid          | INTEGER | Process identifier                         |
| process_guid | TEXT    | Process Guid                               |
| process_name | TEXT    | Name of the process                        |

### win_file_timestomp_events Table

Stores information on Windows file timestomp events.

| Column        | Type    | Description                                |
|---------------|---------|--------------------------------------------|
| action        | TEXT    | Create, write or delete events             |
| eid           | TEXT    | Unique event identifier                    |
| pid           | INTEGER | Process identifier                         |
| target_path   | TEXT    | Full file path                             |
| process_guid  | TEXT    | Process Guid                               |
| process_name  | TEXT    | Process name                               |
| old_timestamp | TEXT    | Old file timestamp                         |
| new_timestamp | TEXT    | New file timestamp                         |
| md5           | TEXT    | MD5 hash of file contents, if available    |
| hashed        | INTEGER | Hash available or not                      |
| pe_file       | TEXT    | True, if file is an executable binary file |
| uid           | TEXT    | User name of file owner                    |
| time          | INTEGER | Time stamp of the event in unix format     |
| utc_time      | TEXT    | Time stamp of the event in UTC             |

### win_http_events Table

Captures the http requests and targets details.

| Column               | Type    | Description                            |
|----------------------|---------|----------------------------------------|
| event_type           | TEXT    | Http Events                            |
| eid                  | INTEGER | Unique Event identifier                |
| pid                  | TEXT    | Windows provided process id            |
| process_guid         | TEXT    | Process Guid                           |
| process_name         | TEXT    | Process Name                           |
| url                  | TEXT    | Http Url being visited                 |
| remote_address       | TEXT    | Remote Address                         |
| remote_port          | INTEGER | Remote Port                            |
| time                 | INTEGER | Time stamp of the event in unix format |
| utc_time             | TEXT    | Time stamp of the event in UTC         |

### win_image_load_events Table

Captures the load of binary executable files and their certificate information.

| Column               | Type    | Description                                      |
|----------------------|---------|--------------------------------------------------|
| eid                  | TEXT    | Unique event identifier                          |
| pid                  | INTEGER | Process identifier of the originating process    |
| md5                  | TEXT    | Process Guid                                     |
| image_path           | TEXT    | Path of the image being loaded                   |
| uid                  | TEXT    | User name of file owner                          |
| time                 | INTEGER | Time stamp of the event in unix format           |
| utc_time             | TEXT    | Time stamp of the event in UTC                   |
| sign_info            | TEXT    | File is signed or unsigned                       |
| trust_info           | TEXT    | File is trusted or untrusted                     |
| num_of_certs         | INTEGER | Number of certificates associated with the image |
| cert_type            | TEXT    | Catalog or embedded                              |
| version              | TEXT    | Version                                          |
| pubkey               | TEXT    | Public key of the certificate                    |
| pubkey_length        | TEXT    | Public Key Length                                |
| pubkey_signhash_algo | TEXT    | Public Key Signing Hash Algo                     |
| issuer_name          | TEXT    | Issuer name                                      |
| subject_name         | TEXT    | Subject name                                     |
| serial_number        | TEXT    | Serial number                                    |
| signature_algo       | TEXT    | Algorithm to sign the certificate                |
| subject_dn           | TEXT    | Subject domain                                   |
| issuer_dn            | TEXT    | Issuer domain                                    |

### win_image_load_process_map Table

| Column               | Type    | Description                            |
|----------------------|---------|----------------------------------------|
| pid                  | INTEGER | Process ID of the originating process  |
| process_guid         | TEXT    | Process Guid                           |
| image_path           | TEXT    | Path of the Image being loaded         |
| image_size           | TEXT    | Size of the Image being loaded         |
| md5                  | TEXT    | MD5 the Image being loaded             |
| image_memory_mode    | TEXT    | User mode/kernel mode                  |
| image_base           | TEXT    | Base address of the Image being loaded |
| time                 | INTEGER | Time stamp of the event in unix format |
| utc_time             | TEXT    | Time stamp of the event in UTC         |

### win_msr Table

Stores
[details](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3b-part-2-manual.pdf)
on MSR, their properties and values.

| Column             | Type    | Description                                        |
|--------------------|---------|----------------------------------------------------|
| turbo_disabled     | INTEGER | CPU properties from MSR (MSR_IA32_MISC_ENABLE)     |
| turbo_ratio_limit  | INTEGER | CPU properties from MSR (MSR_TURBO_RATIO_LIMIT)    |
| platform_info      | INTEGER | CPU properties from MSR (MSR_PLATFORM_INFO)        |
| perf_status        | INTEGER | CPU properties from MSR (MSR_IA32_PERF_STATUS)     |
| perf_ctl           | INTEGER | CPU properties from MSR (MSR_IA32_PERF_CTL)        |
| feature_control    | INTEGER | CPU properties from MSR (MSR_IA32_FEATURE_CONTROL) |
| rapl_power_limit   | INTEGER | CPU properties from MSR (MSR_PKG_POWER_LIMIT)      |
| rapl_energy_status | INTEGER | CPU properties from MSR (MSR_PKG_ENERGY_STATUS)    |
| rapl_power_units   | INTEGER | CPU properties from MSR (MSR_RAPL_POWER_UNIT)      |

### win_obfuscated_ps Table

Powershell based attacks can be *fileless*. Many of these attacks obfuscate
powershell scripts and allow them evade detection. These scripts get logged in
Windows Event Viewer. PolyLogyx uses intelligence and statistics to analyze the
script logs to determine their obfuscation.

| Column           | Type | Description                                            |
|------------------|------|--------------------------------------------------------|
| script_id        | TEXT | Script identifier as recorded in the Windows event log |
| time_created     | TEXT | Timestamp                                              |
| obfuscated_state | TEXT | Obfuscated or Un-obfuscated                            |
| obfuscated_score | TEXT | Numerical value to measure the degree of obfuscation   |

### win_pefile_events Table

Captures the creation, deletion, modification of executable files.

| Column       | Type    | Description                             |
|--------------|---------|-----------------------------------------|
| action       | TEXT    | Create, delete, or modify event         |
| eid          | TEXT    | Unique event identifier                 |
| target_path  | TEXT    | Complete file path                      |
| md5          | INTEGER | MD5 hash of file contents, if available |
| hashed       | INTEGER | Hash available or not                   |
| uid          | TEXT    | User identifier                         |
| pid          | INTEGER | Windows provided Process identifier     |
| process_guid | TEXT    | Process Guid                            |
| process_name | TEXT    | Name of the process                     |
| time         | INTEGER | Time stamp of the event in unix format  |
| utc_time     | TEXT    | Time stamp of the event in UTC          |

### win_process_events Table

Captures the creation and termination of processes.

| Column              | Type    | Description                                               |
|---------------------|---------|-----------------------------------------------------------|
| action              | TEXT    | Created or terminated event                               |
| eid                 | TEXT    | Unique event identifier                                   |
| pid                 | INTEGER | Windows provided Process identifier                       |
| process_guid        | TEXT    | Process Guid                                              |
| path                | TEXT    | Path of the process executable                            |
| cmdline             | TEXT    | Command line at process start                             |
| parent_pid          | INTEGER | Windows provided Process identifier of the parent process |
| parent_process_guid | TEXT    | Parent Process Guid                                       |
| parent_path         | TEXT    | Path to parent process executable                         |
| owner_uid           | TEXT    | Process owners’ user identifier                           |
| time                | INTEGER | Time stamp of the event in unix format                    |
| utc_time            | TEXT    | Time stamp of the event in UTC                            |

### win_process_handles Table

Stores the open handles for processed across the system (including the system
privileged processes).

| Column       | Type    | Description                         |
|--------------|---------|-------------------------------------|
| pid          | INTEGER | Process identifier                  |
| process_guid | TEXT    | Process Guid                        |
| handle_type  | TEXT    | Name of Type of handle              |
| object_name  | TEXT    | Name of the object                  |
| access_mask  | INTEGER | Access mask at the time of creation |

### win_process_open_events Table

Captures the events when a process opens another process with the intent to read
or write into the remote process’ virtual memory (VM_READ\|VM_WRITE).

| Column              | Type    | Description                                             |
|---------------------|---------|---------------------------------------------------------|
| action              | TEXT    | Process open event                                      |
| eid                 | TEXT    | Unique event identifier                                 |
| src_pid             | INTEGER | Windows provided Process identifier of source process   |
| src_process_guid    | TEXT    | Src Process Guid                                        |
| target_pid          | INTEGER | Windows provided Process identifier of target process   |
| target_process_guid | TEXT    | Target Process Guid                                     |
| src_path            | TEXT    | Full path to source process executable                  |
| target_path         | TEXT    | Full path to target process executable                  |
| granted_access      | TEXT    | Granted access                                          |
| owner_uid           | TEXT    | Source process owner’s user identifier                  |
| time                | INTEGER | Time stamp of the event in unix format                  |
| utc_time            | TEXT    | Time stamp of the event in UTC                          |

### win_registry_events Table

Captures the creation, deletion, and modification of registry keys and values.

| Column          | Type    | Description                                                        |
|-----------------|---------|--------------------------------------------------------------------|
| action          | TEXT    | Type of action performed on registry (create, read, write, or set) |
| eid             | TEXT    | Unique event identifier                                            |
| pid             | INTEGER | Process identifier of the originating process                      |
| process_guid    | TEXT    | Process Guid                                                       |
| process_name    | TEXT    | Name of the process                                                |
| target_name     | TEXT    | Name of the registry key being changed                             |
| target_new_name | TEXT    | New name of registry key if it is renamed                          |
| value_type      | TEXT    | Registry type being added                                          |
| value_data      | TEXT    | Registry value being added                                         |
| owner_uid       | TEXT    | User name                                                          |
| time            | BIGINT  | Time stamp of the event in unix format                             |
| utc_time        | TEXT    | Time stamp of the event in UTC                                     |

### win_remote_thread_events Table

Captures the remote thread creations.

| Column              | Type    | Description                                                 |
|---------------------|---------|-------------------------------------------------------------|
| eid                 | TEXT    | Unique event identifier                                     |
| src_pid             | INTEGER | Windows provided Process identifier of source process       |
| src_process_guid    | TEXT    | Src_process_guid                                            |
| target_pid          | INTEGER | Windows provided Process identifier of target process       |
| target_process_guid | TEXT    | Target Process Guid                                         |
| src_path            | TEXT    | Full path to source process executable                      |
| target_path         | TEXT    | Full path to target process executable                      |
| function_name       | TEXT    | Entry function in the target process                        |
| module_name         | TEXT    | Module Name containing entry function in the target process |
| owner_uid           | TEXT    | Source process owner’s user identifier                      |
| time                | INTEGER | Time stamp of the event in unix format                      |
| utc_time            | TEXT    | Time stamp of the event in UTC                              |

### win_removable_media_events Table

Captures the insertion of a removable media.

| Column                     | Type    | Description                               |
|----------------------------|---------|-------------------------------------------|
| eid                        | TEXT    | Unique event identifier                   |
| removable_media_event_type | TEXT    | Removable Media Events                   |
| uid                        | TEXT    | User name of file owner                   |
| pid                        | INTEGER | Windows provided process id               |
| time                       | INTEGER | Time stamp of the event in unix format    |
| utc_time                   | TEXT    | Time stamp of the event in UTC            |

### win_socket_events Table

Captures socket operations, such as accept, listen, and close.

| Column         | Type    | Description                                   |
|----------------|---------|-----------------------------------------------|
| eid            | TEXT    | Unique event identifier                       |
| event_type     | TEXT    | Socket connection event                       |
| action         | TEXT    | Socket operation (accept, connect, or close)  |
| time           | INTEGER | Time stamp of the event in unix format        |
| utc_time       | TEXT    | Time stamp of the event in UTC                |
| pid            | INTEGER | Process identifier of the originating process |
| process_guid   | TEXT    | Process Guid                                  |
| process_name   | TEXT    | Process name                                  |
| family         | TEXT    | Socket address family (e.g. AF_NET)           |
| protocol       | INTEGER | Protocol using IP layer                       |
| local_address  | TEXT    | Local IP address (source)                     |
| remote_address | TEXT    | Remote IP address (destination)               |
| local_port     | INTEGER | Local port number for connection              |
| remote_port    | INTEGER | Remote port number                            |

### win_yara_events Table

Captures the yara matches based on input rules.

| Column      | Type    | Description                              |
|-------------|---------|------------------------------------------|
| eid         | TEXT    | Unique event identifier                  |
| target_path | TEXT    | Full path to be scanned                  |
| category    | TEXT    | File group                               |
| action      | INTEGER | File system action (created or modified) |
| matches     | TEXT    | List of matched yara signatures          |
| count       | INTEGER | Number of rules that matched             |

osquery Tables
--------------

This release of the PolyLogyx Endpoint Platform embeds osquery v3.2.6. PolyLogyx
will make a concerted effort to ensure that we leverage the latest, stable
version of osquery. For more information on base osquery tables and schema,
refer to <https://osquery.io/schema/>*.*
