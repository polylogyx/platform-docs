Using REST APIs
===============

PolyLogyx REST API allows developers to use a programming language of their
choice to integrate with the headless PolyLogyx server. The REST APIs provide
the means to configure and query the data from the fleet manager. The APIs also
allow an openc2 orchestrator to get visibility into endpoint data and
activities, which can then be used to craft an openc2 action.

All payloads are exchanged over REST and use the JSON schema.

REST Based API
------------------

-   Makes use of standard HTTP verbs like GET, POST, and DELETE.

-   Uses standard HTTP error responses to describe errors

-   Authentication provided using access token in the HTTP Authorization header

-   Requests and responses are in JSON format.

Versioning
----------

The PolyLogyx API is a versioned API. We reserve the right to add new
parameters, properties, or resources to the API without advance notice. These
updates are considered non-breaking and the compatibility rules below should be
followed to ensure your application does not break.

Breaking changes such as removing or renaming an attribute will be released as a
new version of the API. PolyLogyx will provide a migration path for new versions
of APIs and will communicate timelines for end-of-life when deprecating APIs. Do
not consume any API unless it is formally documented. All undocumented endpoints
should be considered private, subject to change without notice, and not covered
by any agreements.

The API version is currently v0.

All API requests must use the https scheme.

Base URL
--------

API calls are made to a URL to identify the location from which the data is
accessed. You must replace the placeholders \<server IP\> and \<port\> with
actual details for your PolyLogyx server. The Base URL follows this template:
https://\<server\>:\<port\>/services/api/v0/

Authentication
--------------

The PolyLogyx API requires all requests to present a valid access token
(x-access-token) specified in the HTTP Authorization header for every
HTTP request. If the access token key is missing or invalid, a 401 unauthorized response
code is returned.

The access token has the privileges associated with an administrator account
and does not automatically expire. 

Transport Security
------------------

HTTP over TLS v1.2 is enforced for all API calls. Any non-secure calls will be
rejected by the server.

Client Request Context
----------------------

PolyLogyx will derive client request context directly from the HTTP request
headers and client TCP socket. Request context is used to evaluate policies and
provide client information for troubleshooting and auditing purposes.

-   User Agent - PolyLogyx supports the standard User-Agent HTTP header to
    identify the client application. Always send a User-Agent string to uniquely
    identify your client application and version such as SOC Application/1.1.

-   IP Address - The IP address of your application will be automatically used
    as the client IP address for your request.

Pagination
----------

Requests that return a list of resources may support paging. Pagination is based
on a cursor and not on page number.

Errors
------

All requests on success will return a 200 status if there is content to return
or a 204 status if there is no content to return. HTTP response codes are used
to indicate API errors.

| Code | Description                                                         |
|------|---------------------------------------------------------------------|
| 400  | Malformed or bad JSON Request                                       |
| 401  | API access without or invalid access token                          |
| 404  | Resource not found                                                  |
| 422  | Request can be parsed. But, has invalid content                     |
| 429  | Too many requests. Server has encountered rate limits               |
| 200  | Success                                                             |
| 201  | Created. Returns after a successful POST when a resource is created |
| 500  | Internal server error                                               |
| 503  | Service currently unavailable                                       |

Login
-----------------

### Fetch access token using username and password

Use the admin login username and password to get an access token


```
URL: https://<Base URL>/login
 
Request Type: POST

Example Request
 
 {
   "username":"foo",
   "password":"foo"
 } 

Response:
{
  "x-access-token":
  "eyJhbGciOiJIUzUxMiIsImlhdCI6MTU2NzY3MjcyMCwiZXhwIjoxNTY3NjczMzIwfQ.eyJpZCI6MX0.7jklhAly5ZO6xr1t0Y2ahkZvEEMnrescGK9nszqFhMAProwbjOHaiRO3tBS5I2g dmVSqKqBHynveAFbmor7TA"
 }


```
Fetching Node Details
-----------------

### Fetch Details for all Managed Nodes

Lists all endpoint nodes managed by the PolyLogyx server and their properties.

```
URL: https://<Base URL>/nodes
 
Request Type: GET
Response: A JSON Array of nodes and their properties.  
 
Example Response

 {
 	"status": "success",
 	"message": "nodes data fetched successfully",
 	"data": [
 		{
 		"id": 4,
 		"host_identifier": "D8FC0C20-7D9A-11E7-9483-54E1AD6C8228",
 		"node_info": {
 			"computer_name": "DESKTOP-QIRBS33",
 			"hardware_model": "80XL",
 			"hardware_serial": "PF0UFSFS",
 			"hardware_vendor": "LENOVO",
 			"physical_memory": "8458571776",
 			"cpu_physical_cores": "2"
 			},
		"os_info": {
 			"name": "Microsoft Windows Server 2019 Datacenter",
 			"build": "17763",
 			"major": "10",
 			"minor": "0",
 			"patch": "",
 			"version": "10.0.17763",
 			"codename": "Server Datacenter (full installation)",
 			"platform": "windows",
 			"platform_like": "windows"
 			}
 		"network_info": {
			"mac_address": "0a:00:27:00:00:06"
 			},
 		"node_key": "c6a054a5-ccac-42f2-b631-d1ba2fc59d8a",
 		"last_checkin": "2019-04-08T06:32:27.355782",
 		"enrolled_on": "2019-02-18T07:32:32.003949",
 		"tags": [
 			{
 			"id": 1,
 			"value": "foo"
 			}
 			]
 		}
	]
 }

```

### Fetch Details for Specific Managed Node

Lists information and properties for a specific managed endpoint based on
host_identifier.

``` 
URL: https://<Base URL>/nodes/<host_identifier>
 
Request Type: GET
Response: A node with its properties.  
 
Example Response
 
{
 	"status": "success",
 	"message": "Successfully fetched the node info",
 	"data": {
 		"id": 4,
 		"host_identifier": "D8FC0C20-7D9A-11E7-9483-54E1AD6C8228",
 		"node_info": {
 			"computer_name": "DESKTOP-QIRBS33",
 			"hardware_model": "80XL",
 			"hardware_serial": "PF0UFSFS",
 			"hardware_vendor": "LENOVO",
 			"physical_memory": "8458571776",
 			"cpu_physical_cores": "2"
 			},
		"os_info": {
 			"name": "Microsoft Windows Server 2019 Datacenter",
 			"build": "17763",
 			"major": "10",
 			"minor": "0",
 			"patch": "",
 			"version": "10.0.17763",
 			"codename": "Server Datacenter (full installation)",
 			"platform": "windows",
 			"platform_like": "windows"
 			}
 		"network_info": {
			"mac_address": "0a:00:27:00:00:06"
 			},
 		"node_key": "c6a054a5-ccac-42f2-b631-d1ba2fc59d8a",
 		"last_checkin": "2019-04-08T06:32:27.355782",
 		"enrolled_on": "2019-02-18T07:32:32.003949",
 		"tags": [
 			{
 			"id": 1,
 			"value": "foo"
 			}
 			]
 		}
 }

```

Managing Configs
-----------------

### Get Schema Info for all OSQuery Tables 

List all the OSQuery table schemas supported by the server.

``` 
URL: https://<Base URL> /schema
Request Type: GET
 
Example Response
 
{
  "data": {
    "account_policy_data": "CREATE TABLE account_policy_data (uid BIGINT, creation_time DOUBLE, failed_login_count BIGINT, failed_login_timestamp DOUBLE, password_last_set_time DOUBLE)",
    "win_dns_events": "CREATE TABLE win_dns_events(event_type TEXT,eid TEXT, domain_name TEXT, pid TEXT, remote_address TEXT, remote_port BIGINT, time BIGINT, utc_time TEXT)",
    "win_dns_response_events": "CREATE TABLE win_dns_response_events( event_type TEXT,eid TEXT, domain_name TEXT,resolved_ip TEXT, pid BIGINT, remote_address TEXT, remote_port INTEGER , time BIGINT, utc_time TEXT  )",
    "win_epp_table": "CREATE TABLE win_epp_table(product_type TEXT, product_name TEXT,product_state TEXT, product_signatures TEXT)",
    "win_file_events": "CREATE TABLE win_file_events(action TEXT, eid TEXT,target_path TEXT, md5 TEXT ,hashed BIGINT,uid TEXT, time BIGINT,utc_time TEXT, pe_file TEXT , pid BIGINT)",
    "win_http_events": "CREATE TABLE win_http_events(event_type TEXT, eid TEXT, pid TEXT, url TEXT, remote_address TEXT, remote_port BIGINT, time BIGINT,utc_time TEXT)",
    "win_image_load_events": "CREATE TABLE win_image_load_events(eid TEXT, pid BIGINT,uid TEXT,  image_path TEXT, sign_info TEXT, trust_info TEXT, time BIGINT, utc_time      TEXT, num_of_certs BIGINT, cert_type         TEXT, version TEXT, pubkey TEXT, pubkey_length TEXT, pubkey_signhash_algo         TEXT, issuer_name TEXT, subject_name TEXT, serial_number TEXT, signature_algo     TEXT, subject_dn TEXT, issuer_dn TEXT)",
    "win_msr": "CREATE TABLE win_msr(turbo_disabled INTEGER , turbo_ratio_limt INTEGER ,platform_info INTEGER, perf_status INTEGER ,perf_ctl INTEGER,feature_control INTEGER, rapl_power_limit INTEGER ,rapl_energy_status INTEGER, rapl_power_units INTEGER )",
    "win_obfuscated_ps": "CREATE TABLE win_obfuscated_ps(script_id TEXT, time_created TEXT, obfuscated_state TEXT, obfuscated_score TEXT)",
    "win_pefile_events": "CREATE TABLE win_pefile_events(action TEXT, eid TEXT,target_path TEXT, md5 TEXT ,hashed BIGINT,uid TEXT, pid BIGINT, time BIGINT,utc_time TEXT )",
    "win_process_events": "CREATE TABLE win_process_events(action TEXT, eid TEXT,pid BIGINT, path TEXT ,cmdline TEXT,parent BIGINT, parent_path TEXT,owner_uid TEXT, time BIGINT, utc_time TEXT  )",
    "win_process_handles": "CREATE TABLE win_process_handles(pid BIGINT, handle_type TEXT, object_name TEXT, access_mask BIGINT)",
    "win_process_open_events": "CREATE TABLE win_process_open_events(action TEXT, eid TEXT,src_pid BIGINT,target_pid BIGINT, src_path TEXT ,target_path TEXT,owner_uid TEXT, time BIGINT, utc_time TEXT  )",
    "win_registry_events": "CREATE TABLE win_registry_events(action TEXT, eid TEXT,key_name TEXT, new_key_name TEXT,value_data TEXT, value_type TEXT, owner_uid TEXT, time BIGINT, utc_time TEXT)",
    "win_remote_thread_events": "CREATE TABLE win_remote_thread_events( eid TEXT,src_pid BIGINT,target_pid BIGINT, src_path TEXT ,target_path TEXT,owner_uid TEXT, time BIGINT, utc_time TEXT  )",
    "win_removable_media_events": "CREATE TABLE win_removable_media_events(removable_media_event_type TEXT, eid TEXT,uid TEXT,time BIGINT, utc_time TEXT,pid BIGINT)",
    "win_socket_events": "CREATE TABLE win_socket_events(event_type TEXT, eid TEXT, action TEXT, utc_time TEXT,time BIGINT, pid BIGINT, family TEXT, protocol INTEGER, local_address TEXT, remote_address TEXT, local_port INTEGER,remote_port INTEGER)",
    "win_yara_events": "CREATE TABLE win_yara_events(target_path TEXT, category TEXT, action TEXT, matches TEXT, count INTEGER, eid TEXT)",
    "windows_crashes": "CREATE TABLE windows_crashes (datetime TEXT, module TEXT, path TEXT, pid BIGINT, tid BIGINT, version TEXT, process_uptime BIGINT, stack_trace TEXT, exception_code TEXT, exception_message TEXT, exception_address TEXT, registers TEXT, command_line TEXT, current_directory TEXT, username TEXT, machine_name TEXT, major_version INTEGER, minor_version INTEGER, build_number INTEGER, type TEXT, crash_path TEXT)"
  },
  "message": "Successfully fetched the schema",
  "status": "success"
}
```

### Get Schema info for Specific OSQuery Table from Server

List the OSQuery table schemas for a specific table from the server.

```
URL: https://<Base URL> /schema/<table_name>
Request Type: GET
 
Example Response
 
{
	"data": "CREATE TABLE win_file_events(action TEXT, eid TEXT,target_path TEXT, md5 TEXT ,hashed BIGINT,uid TEXT, time BIGINT,utc_time TEXT, pe_file TEXT , pid BIGINT)",
	"message": "Successfully received table schema",
	"status": "success"
}

```
### Get All Available Configs from Server

Lists all available configs that can be applied to managed nodes based on their platform.

```
URL: https://<Base URL>/configs
 
Request Type: GET
Response: List all the configs available. 
 
Example Response
 
 {
 	"status": "success",
 	"message": "Successfully fetched the configs",
 	"data": {
 		"windows": {
 			"queries": {
 				"win_remote_thread_events": {
 					"id": 124,
 					"query": "select * from win_remote_thread_events;",
 					"interval": 90,
 					"platform": "windows",
 					"version": null,
 					"description": "Remote Thread Events",
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
					"status": true
 					},
 				"powershell_events": {
 					"id": 125,
 					"query": "select * from powershell_events;",
 					"interval": 300,
 					"platform": "windows",
 					"version": null,
 					"description": "Power Shell Events",
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 					}
 				},
 			"filters": {
 				"feature_vectors": {
 					"character_frequencies": []
 					},
 				"win_include_paths": {
 					"all_files": [
 						"*"
 						]
 					},
				"plgx_event_filters": {
 					"win_file_events": {
 						"target_path": {
 							"exclude": {
 								"values": [
 									"C:\\Windows\\system32\\DriverStore\\Temp\\*",
 									"C:\\Windows\\system32\\wbem\\Performance*"
 									]
 							},
 							"include": {
 								"values": [
 									"*\\Start Menu*",
									"*\\Startup\\*"
 									]
 							}
 						},
 					}
 				}
 			}
 		},
 		"linux": {
 			"queries": {
 				"process_events": {
 					"id": 1,
 					"query": "SELECT auid, cmdline, ctime, cwd, egid, euid, gid, parent, path, pid, time, uid,eid FROM process_events WHERE path NOT IN ('/bin/sed', '/usr/bin/tr', '/bin/gawk', '/bin/date', '/bin/mktemp', '/usr/bin/dirname', '/usr/bin/head', '/usr/bin/jq', '/bin/cut', '/bin/uname', '/bin/basename') and cmdline NOT LIKE '%_key%' AND cmdline NOT LIKE '%secret%';",
 					"interval": 10,
 					"platform": "linux",
 					"version": null,
 					"description": null,
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				},
 				"osquery_info": {
 					"id": 31,
 					"query": "SELECT * FROM osquery_info;",
 					"interval": 86400,
 					"platform": "linux",
 					"version": null,
 					"description": "Information about the running osquery configuration",
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				}
 			},
 			"filters": {
 				"events": {
 					"disable_subscribers": [
						"user_events"
 					]
 				},
 				"file_paths": {
 					"binaries": [
 						"/usr/bin/%%",
 						"/usr/sbin/%%"
 					]
 				}
 			}
		},
 		"darwin": {
 			"queries": {
 				"authorized_keys": {
 					"id": 45,
 					"query": "SELECT * FROM users JOIN authorized_keys USING (uid);",
 					"interval": 28800,
 					"platform": "darwin",
 					"version": null,
 					"description": "List authorized_keys for each user on the system",
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				},
 				"wireless_networks": {
 					"id": 94,
 					"query": "SELECT ssid, network_name, security_type, last_connected, captive_portal, possibly_hidden, roaming, roaming_profile FROM wifi_networks;",
 					"interval": 28800,
 					"platform": "darwin",
 					"version": null,
					"description": "OS X known/remembered Wi-Fi networks list.",
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				}
 			},
 			"filters": {
 				"file_paths": {
 					"binaries": [
 						"/usr/bin/%%"
 						"/opt/sbin/%%"
 					],
					"configuration": [
 						"/etc/%%"
 					]
 				}
 			}
 		}
 	}
 }

```
### Get Details for Specific Config from Server

Each configuration available at the server is identified by the platform. Use
this API to fetch information for a specific config based on its platform.

```
URL: https://<Base URL>/configs/<platform>
 
Request Type: GET
 
Example Response
 
 {
 	"status": "success",
 	"message": "Successfully fetched the config",
 	"data": {
 		"linux": {
 			"queries": {
 				"process_events": {
 					"id": 1,
 					"query": "SELECT auid, cmdline, ctime, cwd, egid, euid, gid, parent, path, pid, time, uid,eid FROM process_events WHERE path NOT IN ('/bin/sed', '/usr/bin/tr', '/bin/gawk', '/bin/date', '/bin/mktemp', '/usr/bin/dirname', '/usr/bin/head', '/usr/bin/jq', '/bin/cut', '/bin/uname', '/bin/basename') and cmdline NOT LIKE '%_key%' AND cmdline NOT LIKE '%secret%';",
 					"interval": 10,
 					"platform": "linux",
 					"version": null,
 					"description": null,
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				},
 				"osquery_info": {
 					"id": 31,
 					"query": "SELECT * FROM osquery_info;",
 					"interval": 86400,
 					"platform": "linux",
 					"version": null,
 					"description": "Information about the running osquery configuration",
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				}
 			},
 			"filters": {
 				"events": {
 					"disable_subscribers": [
						"user_events"
 					]
 				},
 				"file_paths": {
 					"binaries": [
 						"/usr/bin/%%",
 						"/usr/sbin/%%"
 					]
 				}
 			}
		}
 	}
 }

```

### Update a Config on the Server 

Use this API to modify information for a specific config based on its Platform.

```
URL: https://<Base URL>/configs/<platform>
 
Request Type: POST
 
Example Request
 
 {
 	"platform": "linux",
 	“arch”:”x86_64”,
 	"queries": {
 		"process_events": {
 			"interval": 10,
 			"platform": "linux",
 			"status": true
 		},
 		"osquery_info": {
 			"interval": 86400,
 			"platform": "linux",
 			"status": true
 		}
 	},
 	"filters": {
 		"events": {
 			"disable_subscribers": [
 				"user_events"
 			]
 		},
 		"file_paths": {
 			"binaries": [
 				"/usr/bin/%%",
 				"/usr/sbin/%%",
 				"/bin/%%",
 				"/sbin/%%",
 				"/usr/local/bin/%%",
 				"/usr/local/sbin/%%"
 			]
 		}
 	}
 }

Response

 {
 	"status": "success",
 	"message": "Successfully updated the config",
 	"data": {
 		"linux": {
 			"queries": {
 				"process_events": {
 					"id": 1,
 					"query": "SELECT auid, cmdline, ctime, cwd, egid, euid, gid, parent, path, pid, time, uid,eid FROM process_events WHERE path NOT IN ('/bin/sed', '/usr/bin/tr', '/bin/gawk', '/bin/date', '/bin/mktemp', '/usr/bin/dirname', '/usr/bin/head', '/usr/bin/jq', '/bin/cut', '/bin/uname', '/bin/basename') and cmdline NOT LIKE '%_key%' AND cmdline NOT LIKE '%secret%';",
 					"interval": 10,
 					"platform": "linux",
 					"version": null,
 					"description": null,
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				},
 				"osquery_info": {
 					"id": 31,
 					"query": "SELECT * FROM osquery_info;",
 					"interval": 86400,
 					"platform": "linux",
 					"version": null,
 					"description": "Information about the running osquery configuration",
 					"value": null,
 					"removed": false,
 					"shard": null,
 					"snapshot": false,
 					"status": true
 				}
 			},
 			"filters": {
 				"events": {
 					"disable_subscribers": [
						"user_events"
 					]
 				},
 				"file_paths": {
 					"binaries": [
 						"/usr/bin/%%",
 						"/usr/sbin/%%"
 					]
 				}
 			}
		}
 	}
 }

```

Managing Queries
-----------------

### Run a Live Query

Define and run a live query on one or more nodes.

```
URL: https://<Base URL> /distributed/add
Request Type: POST
 
Example Request
{
 		"query": "select * from system_info;",
 		"tags": "demo,foo",
 		"nodes": "6357CE4F-5C62-4F4C-B2D6-CAC567BD6113,D8FC0C20-7D9A-11E7-9483-54E1AD6C8228"
}
 
Response
 
{
    	"status": "success",
    	"message": "Successfully send the distributed query",
    	“query_id": "1"
}

```

### Define a Scheduled Query

Define and assign a scheduled query.

```
URL: https://<Base URL> /queries/add
Request Type: POST
 
Example Request
 {
 	"name": "running_process_query",
 	"query": "select * from processes;",
 	"interval": 5,
 	"platform": "windows",
 	"version": "2.9.0",
 	"description": "Processes",
 	"value": "Processes",
 	"tags":"finance,sales"
}

Response

 {
     "data": 104,
     "message": "Successfully created the query",
     "status": "success"
 }

```

### List all Defined Queries

List all queries defined on the server. 

```
URL: https://<Base URL> /queries
Request Type: GET
 
Response

 {
 	"status": "success",
 	"message": "successfully fecthed the queries info",
 	"data": [
 		{
 		"id": 1,
 		"name": "win_file_events",
 		"sql": "select * from win_file_events;",
 		"interval": 13,
 		"platform": "windows",
 		"version": "2.9.0",
 		"description": "Windows File Events",
 		"value": "File Events",
 		"snapshot": true,
 		"shard": null,
 		"packs": [
 			"all-events-pack"
 			]
 		}
 	]
 }

```

### List a Specific Query
List a specific query defined on the server based on its ID.

```
URL: https://<Base URL> /queries/<query_id>
Request Type: GET
 
Response

 {
 	"status": "success",
 	"message": "successfully fecthed the query info for the id given",
 	"data":{
 		"id": 1,
 		"name": "win_file_events",
 		"sql": "select * from win_file_events;",
 		"interval": 13,
 		"platform": "windows",
 		"version": "2.9.0",
 		"description": "Windows File Events",
 		"value": "File Events",
 		"snapshot": true,
 		"shard": null,
 		"packs": [
 			"all-events-pack"
 			]
 	}
 }

```
### List all Packs
Use this API to list all defined packs on the server. 

```
URL: https://<Base URL> /packs
Request Type: GET
 
Response

{
  "data": [
    {
      "discovery": [],
      "id": 1,
      "name": "all-query-pack",
      "platform": null,
      "queries": {
        "win_dns_events": {
          "description": "Windows DNS Events",
          "id": 8,
          "interval": 60,
          "platform": "windows",
          "query": "select * from win_dns_events;",
          "removed": true,
          "shard": null,
          "tags": [],
          "value": "Dns events",
          "version": "2.9.0"
        }
      },
      "shard": null,
      "tags": [],
      "version": null
    }
  ],
  "status": "success",
  "message": "Successfully received the packs"
}

```

### List a Specific Pack
Get details for a specific query pack defined on the server based on its ID.
```
URL: https://<Base URL> /packs/<pack_id>
Request Type: GET
 
Response

{
	"data": {
		"discovery": [],
		"id": 1,
		"name": "pack_1",
		"platform": null,
		"queries": {
			"win_yara_events": {
				"description": "YARA scan result events",
				"id": 4,
				"interval": 5,
				"platform": "windows",
				"query": "select * from win_yara_events;",
				"removed": true,
				"shard": 100,
				"tags": [],
				"value": "scan results",
				"version": "2.9.0"
			}
		},
		"shard": null,
		"tags": [],
		"version": null
	},
	"message": "Successfully fetched the pack",
	"status": "success"
}

```
### Define a Pack
A group of scheduled queries is known as a pack. Use this API to define a new pack.
```
URL: https://<Base URL> /packs/add
Request Type: POST
 
Example Request

 {
 	"name": "process_query_pack",
 	"queries": {
 		"win_file_events": {
 		"query": "select * from processes;",
 		"interval": 5,
 		"platform": "windows",
 		"version": "2.9.0",
 		"description": "Processes",
 		"value": "Processes"
 		}
 	},
	"tags":"finance,sales"
 }

Response

 {
    "message": "Imported query pack process_query_pack",
    "status": "success"
 }

```
Managing Tags
-----------------

### Get all Tags

Get details for all tags defined on the server.

```
URL: https://<Base URL> /tags
Request Type: GET
 
Example Response
 {
 	"data": [
 		"finance",
        "sales"
    ],
    "message": "Successfully received the tags",
    "status": "success"
 }

```

### Add Tags
Tags are a mechanism to logically group or associate elements such as nodes, packs, and so on. Add one or more tags.
```
URL: https://<Base URL> /tags/add
Request Type: POST
 
Example Request
{
"tags":"finance,sales"
}
 
Response
 {
    "message": "Successfully added the tags",
    "status": "success"
 }

```
### Modify Tags for a Node
Add or remove tags for a node.
```
URL: https://<Base URL> /nodes/tag/edit
Request Type: POST
 
Example Request
 {
 	"host_identifier":"77858CB1-6C24-584F-A28A-E054093C8924",
 	"add_tags":"finance,sales",
 	"remove_tags":"demo,foo"
 }

Response
 {
    "message": "Successfully modified the tag(s)",
    "status": "success"
 }

```
### Modify Tags for a Query
Add or remove tags on a query.
```
URL: https://<Base URL> /queries/tag/edit
Request Type: POST
 
Example Request
 {
 	"query_id":1,
 	"add_tags":"finance,sales",
 	"remove_tags":"demo,foo"
 }

Response
 {
    "message": "Successfully modified the tag(s)",
    "status": "success"
 }

```
### Modify Tags on a Pack
Add and remove tags on a pack.
```
URL: https://<Base URL> /packs/tag/edit
Request Type: POST
 
Example Request
 {
 	"pack_id":1,
 	"add_tags":"finance,sales",
 	"remove_tags":"demo"
 }

Response
 {
    "message": "Successfully modified the tag(s)",
    "status": "success"
 }

```
Monitoring and Viewing Fleet Activity
-------------------------------------

### View Scheduled Query Results for a Node

Get all the data coming from a scheduled query for a specific endpoint node.
This query will retrieve all the results that match from the PolyLogyx server
database.

```
URL: https://<Base URL >/nodes/schedule_query/results
Request Type: POST
 
Example Request:
 {
 	"host_identifier": "<host_identifier>",
 	"query": "win_file_events",
 	"start": 0,
 	"limit": 2
 }
 
Example Response:
 
 {
     	"status": "success",
     	"message": "Successfully received node schedule query results",
     	"data": [
              	{
                	"name": "win_file_events",
                    "timestamp": "2018-07-24T07:09:38",
                    "node_id": 6,
                    "action": "added",
                    "id": 948,
                    "columns": {
                    	"uid": "poly-win10\\test",
                        "pid": "4",
                        "hashed": "1",
                        "target_path": "C:\\Users\\test\\AppData\\Local\\Packages\\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\\Settings\\settings.dat",
                        "pe_file": "NO",
                        "eid": "0A253E4E-6996-11E8-BF2C-000D3A01FCC1",
                        "time": "1528295378",
                        "action": "WRITE",
                        "utc_time": "Wed Jun  6 14:29:38 2018 UTC",
                        "md5": "6eea00c4dd37725e90c027a60f3ce1a6"
                        }
              	},
              	{
                    "name": "win_file_events",
                    "timestamp": "2018-07-24T07:09:38",
                    "node_id": 6,
                    "action": "added",
                    "id": 949,
                    "columns": {
                        "uid": "poly-win10\\test",
                        "pid": "4",
                        "hashed": "1",
                        "target_path": "C:\\Users\\test\\AppData\\Local\\Packages\\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\\Settings\\settings.dat.LOG1",
                        "pe_file": "NO",
                        "eid": "0A253E4F-6996-11E8-BF2C-000D3A01FCC1",
                        "time": "1528295378",
                        "action": "WRITE",
                        "utc_time": "Wed Jun  6 14:29:38 2018 UTC",
                        "md5": "a8546005d1e59626d25c8884a1176a27"
                    }
              	}
     	]
}

```

### View Live Query Results 
Live query results are streamed over a websocket. You can use any websocket client. Query results will expire, if not retrieved in 10 minutes.

```
URL: wss://<IP_ADDRESS:PORT>/distributed/result
Send the query id as a message after connect
```
Managing Rules for Alerts
-------------------------------------

### List all the Rules

List all rules defined for alerts on the server.

```
URL: https://<Base URL> /rules
Request Type: GET

Response
{
	"data": [
		{
			"alerters": [
				"email",
				"debug"
			],
			"conditions": {
				"condition": "AND",
				"rules": [
					{
						"field": "column",
						"id": "column",
						"input": "text",
						"operator": "column_contains",
						"type": "string",
						"value": [
							"domain_name",
							"89.com"
						]
					}
				],
				"valid": true
			},
			"description": "Adult websites test",
			"id": 1,
			"name": "Adult websites test",
			"status": "ACTIVE",
			"updated_at": "Tue, 31 Jul 2018 12:31:43 GMT"
		}
	],
	"message": "Successfully received the alert rules",
	"status": "success"
}

```
### List a Specific Rule
List a specific rule defined on the server based on its ID.

```
URL: https://<Base URL> /rules/<rule_id>
Request Type: GET
 
Response
{
	"data": {
		"alerters": [
			"email",
			"debug"
		],
		"conditions": {
			"condition": "AND",
			"rules": [
				{
					"field": "column",
					"id": "column",
					"input": "text",
					"operator": "column_contains",
					"type": "string",
					"value": [
						"domain_name",
						"89.com"
					]
				}
			],
			"valid": true
		},
		"description": "Adult websites test",
		"id": 1,
		"name": "Adult websites test",
		"status": "ACTIVE",
		"updated_at": "Tue, 31 Jul 2018 12:31:43 GMT"
	},
	"message": "Successfully fetched the rule",
	"status": "success"
}

```
### Add a Rule
Define a rule to for a new alert.

```
URL: https://<Base URL> /rules/add
Request Type: POST
 
Example request:
{
  "alerters": [
    "email","splunk"
  ],
	"name":"Adult website test",
"description":"Rule for finding adult websites",
  "conditions": {
    "condition": "AND",
  
  "rules": [
    {
      "id": "column",
      "type": "string",
      "field": "column",
      "input": "text",
      "value": [
        "issuer_name",
        "Polylogyx.com(Test)"
      ],
      "operator": "column_contains"
    }
  ],
  "valid": true
}

}

Response

{
	"data": 2,
	"message": "Successfully configured the rule",
	"status": "success"
}

```

### Modify a Rule
Update an existing rule.

```
URL: https://<Base URL> /rules/<rule_id>
Request Type: POST

Example request:

{
  "alerters": [
    "email",
    "debug"
  ],
  "conditions": {
    "condition": "AND",
    "rules": [
      {
        "field": "column",
        "id": "column",
        "input": "text",
        "operator": "column_contains",
        "type": "string",
        "value": [
          "domain_names",
          "89.com"
        ]
      }
    ],
    "valid": true
  },
  "description": "Adult websites test",
  "name": "Adult websites test",
  "status": "ACTIVE"
}

Response:
{
	"data": {
		"alerters": [
			"email",
			"debug"
		],
		"conditions": {
			"condition": "AND",
			"rules": [
				{
					"field": "column",
					"id": "column",
					"input": "text",
					"operator": "column_contains",
					"type": "string",
					"value": [
						"domain_names",
						"89.com"
					]
				}
			],
			"valid": true
		},
		"description": "Adult websites test",
		"id": 1,
		"name": "Adult websites test",
		"status": "ACTIVE",
		"updated_at": "Wed, 01 Aug 2018 15:15:10 GMT"
	},
	"message": "Successfully modified the rule",
	"status": "success"
}

```

### List Alerts
List alerts based on node, query_name, and rule_id.

```
URL: https://<Base URL> /alerts
Request Type: POST
 
Example Request:

 {
	"host_identifier":"77858CB1-6C24-584F-A28A-E054093C8924",
	"query_name":"processes",
	"rule_id":3
 }

Response
{
  "data": [
    {
      "created_at": "Tue, 31 Jul 2018 14:19:30 GMT",
      "id": 1,
      "message": {
        "cmdline": "/sbin/launchd",
        "cwd": "/",
        "egid": "0",
        "euid": "0",
        "gid": "0",
        "name": "launchd",
        "nice": "0",
        "on_disk": "1",
        "parent": "0",
        "path": "/sbin/launchd",
        "pgroup": "1",
        "pid": "1",
        "resident_size": "6078464",
        "root": "",
        "sgid": "0",
        "start_time": "0",
        "state": "R",
        "suid": "0",
        "system_time": "105116",
        "threads": "4",
        "total_size": "17092608",
        "uid": "0",
        "user_time": "10908",
        "wired_size": "0"
      },
      "node_id": 1,
      "query_name": "processes",
      "rule_id": 3,
      "sql": null
    }
  ],
  "message": "Successfully received the alerts",
  "status": "success"
}

```

### Configure email sender and recipients for alerts

```
URL: https://<Base URL> /email/configure
Request Type: POST
 
Example request:
{
  "emalRecipients": "janedoe@abccomp.com,charliedoe@xyzcomp.com",
  "email": "johndoe@xyzcomp.com",
  "smtpAddress": "smtp2.gmail.com",
  "password": "a",
  "smtpPort": 445
}

Response
{
	"data": {
		"email": "johndoe@xyzcomp.com",
		"emailRecipients": "janedoe@abccomp.com,charliedoe@xyzcomp.com",
		"emails": "jimdoe@abccorp.com",
		"password": "YQ==\n",
		"smtpAddress": "smtp2.gmail.com",
		"smtpPort": 445
	},
	"message": "Successfully updated the details",
	"status": "success"
}

```

### Carves

List all the carve sessions. Host identifier is optional.
```
URL: https://<Base URL> /carves
Request Type: POST
 
Example Request:

{
	"host_identifier":"77858CB1-6C24-584F-A28A-E054093C8924"
	
}

Response

{
	"data": [
		{
			"archive": "2N1P2UNDY6cd0877fa-36e4-41ff-926a-ff2a22673dc3.tar",
			"block_count": 1,
			"carve_guid": "cd0877fa-36e4-41ff-926a-ff2a22673dc3",
			"carve_size": 5632,
			"created_at": "2018-07-24 07:50:05",
			"id": 10,
			"node_id": 1,
			"session_id": "2N1P2UNDY6"
		}
	],
	"message": "Successfully fetched the carves",
	"status": "success"
}

```

### Hunt on managing nodes

Searches throughout the managing nodes for the file hashes provided through text file.
```
URL: https://<Base URL> /hunt-upload
Request Type: POST

Example Request:

 Content-Type: multipart/form-data
 {
 	“file”: “hunt file object”,
 	“type”:”md5”
 }

Response

 {
 	“status”: “success”,
 	“message”:”successfully fetched the data through the hunt file uploaded”,
 	“data”:{
 		“EC2300D6-B0D5-F9A6-1237-6553106EC525”: {
 			“query_name”:”win_file_events”
 			“count”:4
			},
 		“EC241E83-BDC2-CAFC-BF9F-28C22B37A7F0”: {
 			“query_name”:”win_process_events”
 			“count”:6
			}
 		}
 }

Example Request:

 Content-Type: multipart/form-data
 {
 	“file”: “hunt file object”,
 	“type”:”md5”,
 	"host_identifier":“EC2300D6-B0D5-F9A6-1237-6553106EC525”,
 	"query_name":"win_file_events",
	"start":0,
 	"limit":10
 }

Response

 {
	"status": "success",
 	"message": "successfully fetched the data through the hunt file uploaded",
 	"data": [
 		{
		"eid": "04030A02-0BB2-4AD3-BCBE-317A03B8FFFF",
 		"md5": "b3215c06647bc550406a9c8ccc378756",
 		"pid": "5904",
 		"uid": "BUILTIN\\Administrators",
 		"time": "1564493377",
 		"action": "FILE_WRITE",
 		"hashed": "1",
 		"sha256":"c0de104c1e68625629646025d15a6129a2b4b6496",
 		"pe_file": "NO",
 		"utc_time": "Tue Jul 30 13:29:37 2019 UTC",
 		"target_path": "C:\\Users\\Administrator\\Downloads\\test\\5MB.zip",
 		"process_guid": "3D62F1B7-B2BC-11E9-824A-9313D46ED9F3",
 		"process_name": "C:\\Windows\\explorer.exe"
		}
	]
 }

```

### Search on managing node's activity

Searches throughout the managing node's recent activity.
```
URL: https://<Base URL> /search
Request Type: POST

Example Request:

{
	"conditions":{
 		"condition": "OR",
 		"rules": [
 			{
 			"id": "name",
 			"field": "name",
 			"type": "string",
 			"input": "text",
 			"operator": "contains",
 			"value": "EC2"
 			},
 			{
 			"id": "name",
 			"field": "name",
 			"type": "string",
 			"input": "text",
 			"operator": "equal",
 			"value": "pc"
 			}
 		],
 	"valid": true
	}
}

Response

 {
 	“status”: “success”,
 	“message”:”successfully fetched the data through the payload given”,
 	“data”:{
 		“EC2300D6-B0D5-F9A6-1237-6553106EC525”: {
 			“query_name”:”win_file_events”
 			“count”:4
			},
 		“EC241E83-BDC2-CAFC-BF9F-28C22B37A7F0”: {
 			“query_name”:”win_process_events”
 			“count”:6
			}
 		}
 }

Example Request:

 {
	"conditions":{
 		"condition": "OR",
 		"rules": [
 			{
 			"id": "name",
 			"field": "name",
 			"type": "string",
 			"input": "text",
 			"operator": "contains",
 			"value": "EC2"
 			},
 			{
 			"id": "name",
 			"field": "name",
 			"type": "string",
 			"input": "text",
 			"operator": "equal",
 			"value": "pc"
 			}
 		],
 	"valid": true
	},
 	"host_identifier":“EC2300D6-B0D5-F9A6-1237-6553106EC525”,
 	"query_name":"win_file_events",
	"start":0,
 	"limit":10
 }

Response

 {
	"status": "success",
 	"message": "successfully fetched the data through the payload given",
 	"data": [
 		{
		"eid": "04030A02-0BB2-4AD3-BCBE-317A03B8FFFF",
 		"md5": "b3215c06647bc550406a9c8ccc378756",
 		"pid": "5904",
 		"uid": "BUILTIN\\Administrators",
 		"time": "1564493377",
 		"action": "FILE_WRITE",
 		"hashed": "1",
 		"sha256":"c0de104c1e68625629646025d15a6129a2b4b6496",
 		"pe_file": "NO",
 		"utc_time": "Tue Jul 30 13:29:37 2019 UTC",
 		"target_path": "C:\\Users\\Administrator\\Downloads\\test\\5MB.zip",
 		"process_guid": "3D62F1B7-B2BC-11E9-824A-9313D46ED9F3",
 		"process_name": "C:\\Windows\\explorer.exe"
		}
	]
 }


```


[Previous << Tables](../12_Tables/Readme.md)  
