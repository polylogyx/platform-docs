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

The API version is currently v1.

All API requests must use the https scheme.

BASE_URL
--------

API calls are made to a URL to identify the location from which the data is
accessed. You must replace the placeholders \<server IP\> and \<port\> with
actual details for your PolyLogyx server. The BASE_URL follows this template:
https://\<server\>:\<port\>/services/api/v1/

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


### Get a file from downloads path
**URL:** https://<BASE_URL>/downloads/<path: filename>
**Request type:** GET
```
  https://<BASE_URL>/downloads/certificate.crt -- to download the PolyLogyx server certificate
  https://<BASE_URL>/downloads/windows/plgx_cpt.exe -- to download the windows Client Provisioning Tool
  https://<BASE_URL>/downloads/linux/x64/plgx_cpt -- to download the Linux Client Provisioning Tool
  https://<BASE_URL>/downloads/plgx_cpt.sh -- to download the Mac installer
```

User's Section:
---------------

### Fetch auth token using username and password
Use username and password to get an auth token, which is to access the PolyLogyx platform UI.
**URL:** https://<BASE_URL>/login
**Request Type:** POST
**Example Request Format:**
```
{
	"username":"foo",
	"password":"foo"
}
```
**Response:** Returns JSON array of auth token.
**Example Response Format:**
```
{
	"x-access-token":
	"eyJhbGciOiJIUzUxMiIsImlhdCI6MTU2NzY3MjcyMCwiZXhwIjoxNTY3NjczMzIwfQ.eyJpZCI6MX0.7jklhAly5ZO6xr1t0Y2ahkZvEEMnrescGK9nszqFhMAProwbjOHaiRO3tBS5I2gdmVSqKqBHynveAFbmor7TA"
}
```

### Logout from the PolyLogyx Server session
Invalidates the platform user session by restricting the authentication of auth token.
**URL:** https://<BASE_URL>/logout
**Request Type:** POST
**Response:** Returns JSON array of status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "user logged out successfully"
}
```

### Change user's password
Changes password of the current user using current password.
**URL:** https://<BASE_URL>/changepw
**Request Type:** POST
Example Payload Format
```
{
	"old_password":"foobar",
	"new_password":"foo",
	"confirm_new_password":"foo"
} 
```
**Response:** Returns JSON array of status and message.
**Example Response Format:**
```
{
	"status":"success",
	"message":"password is updated successfully"
}
```

### View PolyLogyx Server Options
Lists Options used by PolyLogyx Server.
**URL:** https://<BASE_URL>/options
**Request Type:** GET
**Response:** Returns JSON array of status,message and data.
**Example Response Format:**
```
{
	"status": "success",
	"message": “options are updated successfully“,
	"data": {
		"custom_plgx_EnableLogging": "true",
		"custom_plgx_LogFileName": "C:\\ProgramData\\plgx_win_extension\\plgx-agent.log",
		"custom_plgx_LogLevel": "1",
		"custom_plgx_LogModeQuiet": "0",
		"custom_plgx_ServerPort": "443",
		"custom_plgx_enable_respserver": "true",
		"schedule_splay_percent": 10
	}
}
```

### Update/Add PolyLogyx Server Options
Add or Update Options used by PolyLogyx Server.
**URL:** https://<BASE_URL>/options/add
**Request Type:** POST
**Example Request Format:**
```
{
	"option":{
		"custom_plgx_EnableLogging": "true",
		"custom_plgx_LogFileName": "C:\\ProgramData\\plgx_win_extension\\plgx-agent.log",
		"custom_plgx_LogLevel": "1",
		"custom_plgx_LogModeQuiet": "0",
		"custom_plgx_ServerPort": "443",
		"custom_plgx_enable_respserver": "true",
		"schedule_splay_percent": 10
	}
}
```
**Response:** Returns JSON array of status,message and data.
**Example Response Format:**
```
{
	"status": "success",
	"message": “options are updated successfully“,
	"data": {
		"custom_plgx_EnableLogging": "true",
		"custom_plgx_LogFileName": "C:\\ProgramData\\plgx_win_extension\\plgx-agent.log",
		"custom_plgx_LogLevel": "1",
		"custom_plgx_LogModeQuiet": "0",
		"custom_plgx_ServerPort": "443",
		"custom_plgx_enable_respserver": "true",
		"schedule_splay_percent": 10
	}
}
```

### View Threat Intel Keys
Lists Threat Intel API keys used by PolyLogyx Server.
**URL:** https://<BASE_URL>/management/apikeys
**Request Type:** GET
**Response:** Returns JSON array of status,message and data.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Threat Intel keys are fetched successfully",
	"data": {
		"ibmxforce": {
			"key": "304020f8-99fd-4a17-9e72-80033278810a",
			"pass": "6710f119-9966-4d94-a7ad-9f98e62373c8"
				},
		"virustotal": {
				"key":"69f922502ee0ea958fa0ead2979257bd084fa012c283ef9540176ce857ac6f2c"
				}
			}
}
```

### Add/Update Threat Intel Keys
Updates Threat Intel API keys used by PolyLogyx Server.
**URL:** https://<BASE_URL>/management/apikeys
**Request Type:** POST
**Example Request Format:**
```
{
	"IBMxForceKey":"304020f8-99fd-4a17-9e72-80033278810a",
	"IBMxForcePass":"6710f119-9966-4d94-a7ad-9f98e62373c8",
	"vt_key":"69f922502ee0ea958fa0ead2979257bd084fa012c283ef9540176ce857ac6f2c",
	"otx_key":"69f922502ee0ea958fa0ead2979257bd084fa012c"
}
```
**Response:** Returns JSON array of status,message and data.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Threat Intel keys are updated successfully",
	"data": {
		"ibmxforce": {
			"key": "304020f8-99fd-4a17-9e72-80033278810a",
			"pass": "6710f119-9966-4d94-a7ad-9f98e62373c8"
				},
		"virustotal": {
				"key":"69f922502ee0ea958fa0ead2979257bd084fa012c283ef9540176ce857ac6f2c"
				}
			}
}
```

### View email sender and recipients used by PolyLogyx platform
Lists the email configuration used by PolyLogyx platform user to send emails for alerts.
**URL:** https://<BASE_URL>/email/configure
**Request Type:** GET
**Response:** Returns JSON array of status,message and data.
Example Response
```
{
	"data": {
		"email": "johndoe@xyzcomp.com",
		"emailRecipients": "janedoe@abccomp.com,charliedoe@xyzcomp.com",
		"emails": "jimdoe@abccorp.com",
		"password": "YQ==\n",
		"smtpAddress": "smtp2.gmail.com",
		"smtpPort": 445
	},
	"message": "Successfully fetched the details",
	"status": "success"
}
```

### Configure email sender and recipients for alerts
Updates the email configuration used by PolyLogyx platform user to send emails for alerts.
**URL:** https://<BASE_URL>/email/configure
**Request Type:** POST
**Example Request Format:**
```
{
	"emalRecipients": "janedoe@abccomp.com,charliedoe@xyzcomp.com",
	"email": "johndoe@xyzcomp.com",
	"smtpAddress": "smtp2.gmail.com",
	"password": "a",
	"smtpPort": 445
}
```
**Response:** Returns JSON array of status,message and data.
**Example Response Format:**
```
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

### Test email sender and recipients
Tests the email configuration, which is going to be used by PolyLogyx platform user before updating.
**URL:** https://<BASE_URL>/email/test
**Request Type:** POST
**Example Request Format:**
```
{
	"emalRecipients": "janedoe@abccomp.com,charliedoe@xyzcomp.com",
	"email": "johndoe@xyzcomp.com",
	"smtpAddress": "smtp2.gmail.com",
	"password": "a",
	"smtpPort": 445
}
```
**Response:** Returns JSON array of status,message and data.
**Example Response Format:**
```
{
	"data": {
		"email": "johndoe@xyzcomp.com",
		"emailRecipients": "janedoe@abccomp.com,charliedoe@xyzcomp.com",
		"emails": "jimdoe@abccorp.com",
		"password": "YQ==\n",
		"smtpAddress": "smtp2.gmail.com",
		"smtpPort": 445
	},
	"message": "A test email is sent successfully",
	"status": "success"
}
```

### View data purge duration
Returns the data purge duration set for which result log, alerts and status logs should be deleted.
**URL:** https://<BASE_URL>/purge/update
**Request Type:** GET
**Response:** Returns JSON array of data, status and message
**Example Response Format:**
```
{
	"status": "success",
	"message": “Purge data present duration is fetched successfully “,
	“data”:7
}
```

### Update data purge duration
Updates the data purge duration for which result log, alerts and status logs should be deleted.
**URL:** https://<BASE_URL>/purge/update
**Request Type:** POST
**Example Request Format:**
```
{
	“days”: 2
}
```
**Required Payload Arguments:** days
**Response:** Returns JSON array of status and message
**Example Response Format:**
```
{
	"status": "success",
	"message": “Purge data duration is changed successfully“,
}
```

### Get Dashboard data
Get the data required for POLYLOGYX platform for dashboard.
**URL:** https://<BASE_URL>/dashboard
**Request Type:** GET
**Example Response Format:**
```
{
	"status": "success",
	"message": "Data is fetched successfully",
	"data": {
		"alert_data": {
			"top_five": {
			"rule": [
				{
					"rule_name": "Executable used by PlugX in Uncommon Location",
					"count": 4609
				},
				{
					"rule_name": "test_rule",
					"count": 13
				},
				{
					"rule_name": "Service Stop",
					"count": 2
				}
			],
			"hosts": [
				{
					"host_identifier": "EC2CD1A0-140B-9331-7A60-CFFCE29D2E71",
					"count": 4629
				}
			],
			"query": [
				{
					"query_name": "Test_query",
					"count": 4609
				},
				{
					"query_name": "win_file_events",
					"count": 14
				},
				{
					"query_name": "win_image_load_events",
					"count": 4
				},
				{
					"query_name": "win_process_events",
					"count": 2
				}
			]
			},
			"source": {
				"ioc": {
					"INFO": 0,
					"LOW": 0,
					"WARNING": 0,
					"CRITICAL": 0,
					"TOTAL": 0
				},
				"rule": {
					"INFO": 13,
					"LOW": 0,
					"WARNING": 0,
					"CRITICAL": 4611,
					"TOTAL": 4624
				},
				"virustotal": {
					"INFO": 0,
					"LOW": 5,
					"WARNING": 0,
					"CRITICAL": 0,
					"TOTAL": 5
				},
				"ibmxforce": {
					"INFO": 0,
					"LOW": 0,
					"WARNING": 0,
					"CRITICAL": 0,
					"TOTAL": 0
				},
				"alienvault": {
					"INFO": 0,
					"LOW": 0,
					"WARNING": 0,
					"CRITICAL": 0,
					"TOTAL": 0
				}
			}
		},
		"distribution_and_status": {
			"hosts_platform_count": [
				{
					"os_name": "ubuntu",
					"count": 1
				},
				{
					"os_name": "windows",
					"count": 1
				}
			],
			"hosts_status_count": {
				"online": 2,
				"offline": 0
			}
		}
	}
}
```

Host's Section:
---------------

### Export hosts information
Returns a response of a csv file with all hosts information.
**URL:** https://<BASE_URL>/hosts/export
**Request Type:** GET
**Response:** Returns a csv file.

### View all hosts
Lists all hosts managed by POLYLOGYX platform for the filters applied.
**URL:** https://<BASE_URL>/hosts
**Request Type:** POST
**Example Response Format:**
```
{
	"status":false,
	"platform":"windows",
	“searchterm”:”EC2”,
	"start":0,
	"limit":10,
	“enabled”:true
}
```
**Filters Description:**
```
	status – true – to get all active hosts
	status – false – to get all inactive hosts
	platform – to filter the results with platform
	enabled – true – to get all non-removed hosts
	enabled – false – to get all removed hosts
```
**Response:** Returns JSON array of hosts and their properties.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the nodes details",
	"data": {
	"results": [
		{
			"id": 2,
			"display_name": "EC2AMAZ-2RJ1BIF",
			"host_identifier": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
			"os_info": {
				"name": "Microsoft Windows Server 2019 Datacenter",
				"build": "17763",
				"major": "10",
				"minor": "0",
				"patch": "",
				"version": "10.0.17763",
				"codename": "Server Datacenter (full installation)",
				"platform": "windows",
				"install_date": "20190613115936.000000+000",
				"platform_like": "windows"
			},
			"tags": [
				"zdsd"
			],
			"last_ip": "15.206.168.222",
			"is_active": false
		}
	],
	"count": 3,
	"total_count": 3
	}
}
```

### View a host
Lists a node info managed by the POLYLOGYX platform and its properties.
**URL:** https://<BASE_URL>/hosts/<string:host_identifier> 
	https://<BASE_URL>/hosts/<int:node_id>
**Request Type:** GET
**Response:** Returns a JSON array of status, data and message. 
**Example Response Format:**
```
{
	"status": "success",
	"message": "Node details is fetched successfully",
	"data": {
		"id": 1,
		"host_identifier": "EC2306BC-DCF7-A1F9-3ADE-CED9B00D49FB",
		"node_key": "6b38482b-2526-4b3a-bc1c-b5166dc7f57f",
		"last_ip": "13.234.136.159",
		"os_info": {
			"name": "Ubuntu",
			"build": "",
			"major": "18",
			"minor": "4",
			"patch": "0",
			"version": "18.04.2 LTS (Bionic Beaver)",
			"codename": "bionic",
			"platform": "ubuntu",
			"platform_like": "debian"
		},
		"node_info": {
			"computer_name": "ip-172-31-30-15",
			"hardware_model": "HVM domU",
			"hardware_serial": "ec2306bc-dcf7-a1f9-3ade-ced9b00d49fb",
			"hardware_vendor": "Xen",
			"physical_memory": "8362713088",
			"cpu_physical_cores": "2"
		},
		"network_info": [
			{
			"mac": "02:4b:07:36:bd:fc",
			"mask": "255.255.240.0",
			"address": "172.31.30.15",
			"enabled": "",
			"description": "",
			"manufacturer": "",
			"connection_id": "",
			"connection_status": ""
			}
		],
		"last_checkin": "2020-06-24T05:02:59.956558",
		"enrolled_on": "2020-06-20T15:45:37.870494",
		"last_status": "2020-06-24T05:02:58.337353",
		"last_result": "2020-06-24T05:02:58.337353",
		"last_config": "2020-06-24T04:59:27.771166",
		"last_query_read": "2020-06-24T05:02:59.963197",
		"last_query_write": "2020-06-23T17:43:30.837109"
	}
}
```

### View hosts distribution count
Get count of hosts based on status and platform.
**URL:** https://<BASE_URL>/hosts/count
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully fetched the nodes status count",
	"data": {
		"windows": {
			"online": 0,
			"offline": 2
		},
		"linux": {
			"online": 0,
			"offline": 1
		},
		"darwin": {
			"online": 0,
			"offline": 0
		}
	}
}
```

### View status logs
Returns status logs of a host for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/status_logs
**Request Type:** POST
**Example Request Format:**
```
{
	“host_identifier”: “EC2306BC-DCF7-A1F9-3ADE-CED9B00D49FB”,
	“node_id”:1,
	“start”:0,
	“limit”:10,
	“searchterm”:””
}
```
**Required Payload Arguments:** host_identifier / node_id
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully fetched the node's status logs",
	"data": {
		"results": [
			{
				"line": 922,
				"message": "The chrome_extensions table returns data based on the current user by default, consider JOINing against the users table",
				"severity": 1,
				"filename": "virtual_table.cpp",
				"created": "2020-06-21T00:59:32.768726",
				"version": "4.0.2"
			}
		],
		"count": 197,
		"total_count": 197
	}
}
```

### View additional config
Returns additional config of a host for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/additional_config
**Request Type:** POST
**Example Request Format:**
```
{
	“host_identifier”: “EC2306BC-DCF7-A1F9-3ADE-CED9B00D49FB”,
	“node_id”:1
}
```
**Required Payload Arguments:** host_identifier / node_id
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully fetched additional config of the node for the host identifier passed",
	"data": {
		"queries": [],
		"packs": [],
		"tags": [
			"test"
		]
	}
}
```

### View full config
Returns full config of a host for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/config
**Request Type:** POST
**Example Request Format:**
```
{
	“host_identifier”: “EC2306BC-DCF7-A1F9-3ADE-CED9B00D49FB”,
	“node_id”:1
}
```
**Required Payload Arguments:** host_identifier / node_id
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully fetched full config of the node for the host identifier passed",
	"data": {
		"options": {
			"disable_watchdog": true,
			"logger_tls_compress": true,
			"host_identifier": "uuid",
			"custom_plgx_enable_respserver": "true",
			"custom_plgx_EnableAgentRestart": "false"
		},
		"file_paths": {},
		"queries": {
			"win_process_events": {
				"id": 125,
				"query": "select * from win_process_events_optimized;",
				"interval": 30,
				"description": "Windows Process Events",
				"status": true
			},
			"win_file_events": {
				"id": 126,
				"query": "select * from win_file_events_optimized;",
				"interval": 180,
				"description": "File Integrity Monitoring",
				"status": true
			}
		},
		"packs": [],
		"filters": {}
	}
}
```

### View count of result log
Returns result log count of a host for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/recent_activity/count
**Request Type:** POST
**Example Request Format:**
```
{
	“host_identifier”: “EC2306BC-DCF7-A1F9-3ADE-CED9B00D49FB”,
	“node_id”:1
}
```
**Required Payload Arguments:** host_identifier / node_id
**Response:** Returns a JSON array data, status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully fetched the count of schedule query results count of host identifier passed",
	"data": [
		{
			"name": "certificates",
			"count": 514
		},
		{
			"name": "drivers",
			"count": 41
		}
	]
}
```

### View result log
Returns result log data of a host for a query for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/recent_activity
**Request Type:** POST
**Example Request Format:**
```
{
	“host_identifier”: “EC2306BC-DCF7-A1F9-3ADE-CED9B00D49FB”,
	“node_id”:1,
	“query_name”:”certificates”,
	“start”:0,
	“limit”:2,
	“searchterm”:””
}
```
**Required Payload Arguments:** host_identifier / node_id, query_name, start and limit
**Response:** Returns a response json containing data, status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully fetched the schedule query results of host identifier passed",
	"data": {
	"count": 514,
	"total_count": 514,
	"results": [
		{
			"timestamp": "06/20/2020 18/05/15",
			"action": "added",
			"columns": {
				"path": "LocalMachine\\Windows Live ID Token Issuer",
				"issuer": "Token Signing Public Key",
				"common_name": "Token Signing Public Key",
				"self_signed": "1",
				"not_valid_after": "1530479437"
			}
		},
		{
			"timestamp": "06/20/2020 18/05/15",
			"action": "added",
			"columns": {
				"path": "LocalMachine\\Windows Live ID Token Issuer",
				"issuer": "Token Signing Public Key",
				"common_name": "Token Signing Public Key",
				"self_signed": "1",
				"not_valid_after": "1620506455"
			}
		}
	]
	}
}
```

### View list of tags of a host
Returns list of tags of a host for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/<string:host_identifier>/tags
	https://<BASE_URL>/hosts/<int:node_id>/tags
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully fetched the tags of host",
	"data": [
		"test"
	]
}
```

### Create tags to a host
Creates tags to a host.
**URL:** https://<BASE_URL>/hosts/<string:host_identifier>/tags
	https://<BASE_URL>/hosts/<int:node_id>/tags
**Request Type:** POST
**Example Request Format:** 
```
{
	“tag": "test”
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully created tags to host"
}
```

### Remove tags from a host
Remove tags of a host for the host identifier given.
**URL:** https://<BASE_URL>/hosts/<string:host_identifier>/tags
	https://<BASE_URL>/hosts/<int:node_id>/tags
**Request Type:** DELETE
**Example Request Format:**
```
{
	“tag”: “simple”
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully removed tags from host"
}
```

### Search export
Exports the search results of a host into csv file.
**URL:** https://<BASE_URL>/hosts/search/export
**Request Type:** POST
**Example Request Format:** 
```
{
	"conditions": {
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
	“host_identifier”:”EC241E83-BDC2-CAFC-BF9F-28C22B37A7F0”,
	“query_name”:”win_file_events”
}
```
**Required Payload Arguments:** conditions, host_identifier and query_name.
**Response:** Returns a CSV file.


### Hunt through file upload
Hunt on Result Log through the file of indicators uploaded.
**URL:** https://<BASE_URL>/hunt-upload
**Request Type:** POST
Example Payload Format 1:
```
{
	“file”: “hunt file object to add the alerts”,
	“type”:”md5”
}
```
**Required Payload Arguments:** file and type
**Response:** Returns JSON array of status,message and data.
**Example Response Format:** 1:
```
{
	"status": "success",
	"message": "Successfully fetched the results through the hunt",
	"data": [
		{
			"hostname": "EC2AMAZ-2RJ1BIF",
			"host_identifier": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
			"queries": [
				{
					"query_name": "osquery_info",
					"count": 1
				}
			]
		}
	]
}
```
Example Payload Format 2:
```
{
	“file”: “hunt file object to add the alerts”,
	“type”:”md5”,
	“host_identifier”:”EC2300D6-B0D5-F9A6-1237-6553106EC525”, 
	“query_name”:”win_file_events”, 
	“start”:2, 
	“limit”:10
}
```
**Required Payload Arguments:** file, type, host_identifier, query_name, start and limit
**Example Response Format:** 2:
```
{
	"status": "success",
	"message": "Successfully fetched the results through the hunt",
	"data": {
		"count": 1,
		"results": [
			{
				"pid": "4752",
				"uuid": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
				"version": "4.0.2",
				"watcher": "-1",
				"extensions": "active",
				"start_time": "1592672947",
				"config_hash": "71f4969da7d79f6b2cbeb64d02e04b17bd8815e7",
				"instance_id": "78a850bf-844e-426a-8cc6-a66d3975a2ba",
				"build_distro": "10",
				"config_valid": "1",
				"build_platform": "windows"
			}
		]
	}
}
```

### Hunt through list of indicators
Hunt on Result Log through the list of indicators provided.
**URL:** https://<BASE_URL>/indicators/hunt
**Request Type:** POST
Example Payload Format 1:
```
{
	“indicators”: “275a71899f7db9d1663fc695ec2fe2a2c4538, 275a71899fdjsaddb9d1663fc695ec2fe2a2c453fsgs”,
	“type”:”md5”
}
```
**Required Payload Arguments:** type and indicators
**Response:** Returns JSON array of status,message and data.
**Example Response Format:** 1:
```
{
	"status": "success",
	"message": "Successfully fetched the results through the hunt",
	"data": [
		{
			"hostname": "EC2AMAZ-2RJ1BIF",
			"host_identifier": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
			"queries": [
				{
					"query_name": "osquery_info",
					"count": 1
				}
			]
		}
	]
}
```
Example Payload Format 2:
```
{
	“indicators”: “hunt file object to add the alerts”,
	“type”:”md5”,
	“host_identifier”:”EC2300D6-B0D5-F9A6-1237-6553106EC525”, 
	“query_name”:”win_file_events”, 
	“start”:2, 
	“limit”:10
}
```
**Required Payload Arguments:** indicators, type, host_identifier, query_name, start and limit
**Example Response Format:** 2:
```
{
	"status": "success",
	"message": "Successfully fetched the results through the hunt",
	"data": {
		"count": 1,
		"results": [
			{
				"pid": "4752",
				"uuid": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
				"version": "4.0.2",
				"watcher": "-1",
				"extensions": "active",
				"start_time": "1592672947",
				"config_hash": "71f4969da7d79f6b2cbeb64d02e04b17bd8815e7",
				"instance_id": "78a850bf-844e-426a-8cc6-a66d3975a2ba",
				"build_distro": "10",
				"config_valid": "1",
				"build_platform": "windows"
			}
		]
	}
}
```

### Export Hunt results
Export the hunt results to a csv file.
**URL:** https://<BASE_URL>/hunt-upload/export
**Request Type:** POST
**Example Request Format:**
```
{
	“file”: “hunt file object to add the alerts”,
	“type”:”md5”,
	“host_identifier”:”EC2300D6-B0D5-F9A6-1237-6553106EC525”, 
	“query_name”:”win_file_events”
}
```
**Required Payload Arguments:** file, type, host_identifier, query_name
**Response:** Returns a CSV file.
**Example Response Format:** A CSV file object with hunt results.

### Search in result log:
Searches for results in Result Log for the conditions given.
**URL:** https://<BASE_URL>/search
**Request Type:** POST
**Response:** Returns JSON array of status,message and data.
Example Payload Format 1:
```
{
	"conditions": {
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
```
**Required Payload Arguments:** conditions
**Example Response Format:** 1:
```
{
	"status": "success",
	"message": "Successfully fetched the results through the payload given",
	"data": [
		{
			"hostname": "EC2AMAZ-2RJ1BIF",
			"host_identifier": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
			"queries": [
				{
					"query_name": "osquery_info",
					"count": 1
				}
			]
		}
	]
}
```
Example Payload Format 2:
```
{
	"conditions": {
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
	“host_identifier”:”EC241E83-BDC2-CAFC-BF9F-28C22B37A7F0”, "query_name":"per_query_perf", 
	"start":2, 
	"limit":2
}
```
**Required Payload Arguments:** conditions, host_identifier, query_name, start and limit
**Example Response Format:** 2:
```
{
	"status": "success",
	"message": "Successfully fetched the results through the payload given",
	"data": {
		"count": 1,
		"results": [
			{
				"pid": "4752",
				"uuid": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
				"version": "4.0.2",
				"watcher": "-1",
				"extensions": "active",
				"start_time": "1592672947",
				"config_hash": "71f4969da7d79f6b2cbeb64d02e04b17bd8815e7",
				"instance_id": "78a850bf-844e-426a-8cc6-a66d3975a2ba",
				"build_distro": "10",
				"config_valid": "1",
				"build_platform": "windows"
			}
		]
	}
}
```

### Delete recent query result
Deletes the query result for some recent days for the number given.
**URL:** https://<BASE_URL>/queryresult/delete
**Request Type:** POST
**Example Request Format:**
```
{
	“days_of_data”: 2
}
```
**Required Payload Arguments:** days_of_data
**Response:** Returns JSON array of data, status and message
**Example Response Format:**
```
{
	"status": "success",
	"message": “Query result data is deleted successfully “,
	“data”:7
}
```

### Export schedule query results
Returns a response of a csv file object with schedule query results.
**URL:** https://<BASE_URL>/schedule_query/export
**Request Type:** POST
**Example Request Format:**
```
{
	“query_name”: “win_registry_events”,
	“host_identifier”:”EC259C26-B72F-553F-A2B3-FD9517DAE7D2”
}
```
**Required Payload Arguments:** query_name and host_identifier
**Response:** Returns a csv file

### Delete a host permanently
Delete a host permanently for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/<string:host_identifier>/delete
	https://<BASE_URL>/hosts/<int:node_id>/delete
**Request Type:** DELETE
**Response:** Returns a JSON array of status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully deleted the host"
}
```

### Remove a host
Remove a host from the platform for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/<string:host_identifier>/delete
	https://<BASE_URL>/hosts/<int:node_id>/delete
**Request Type:** PUT
**Response:** Returns a JSON array of status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully removed the host"
}
```

### Enable a host
Enable a host for the host identifier or node id given.
**URL:** https://<BASE_URL>/hosts/<string:host_identifier>/enable
	https://<BASE_URL>/hosts/<int:node_id>/enable
**Request Type:** PUT
**Response:** Returns a JSON array of status and message.
**Example Response Format:** 
```
{
	"status": "success",
	"message": "Successfully enabled the host"
}
```

Tag's Section:
--------------

### View list of all tags
Returns list of all tags.
**URL:** https://<BASE_URL>/tags
**Request Type:** GET
**Example Request Format:**
```
{
	“searchterm”:“test”,
	“start”:0,
	“limit”:10
}
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the tags info",
	"data": {
		"count": 7,
		"total_count": 7,
		"results": [
			{
				"value": "test67",
				"nodes": [],
				"packs": [],
				"queries": [],
				"file_paths": []
			},
			{
				"value": "test",
				"nodes": [],
				"packs": [
					"all-events-pack"
				],
				"queries": [
					"App_disabledExceptionChainValidation"
				],
				"file_paths": []
			}
		]
	}
}
```

### Add a tag
Adds a tag.
**URL:** https://<BASE_URL>/tags/add
**Request Type:** POST
**Example Request Format:**
```
{
	“tag": "test”
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
	“status”: “success”,
	“message”: “Tag is added successfully”,
}
```

### Delete a tag
Deletes a tag.
**URL:** https://<BASE_URL>/tags/delete
**Request Type:** POST
**Example Request Format:**
```
{
	“tag": "test”
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
	“status”: “success”,
	“message”: “Tag is deleted successfully”,
}
```

### View all hosts, packs, queries of a tag
Get list of all hosts, packs and queries of a tag.
**URL:** https://<BASE_URL>/tags/tagged
**Request Type:** POST
**Example Request Format:**
```
{
	“tags": "test”
}
```
**Required Payload Arguments:** tags
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "All hosts, queries, packs for the tag provided!",
	"data": {
		"hosts": [
			{
				"id": 3,
				"display_name": "EC2AMAZ-2RJ1BIF",
				"host_identifier": "EC2CE2E2-3D74-1248-2FA9-23F2E960ED42",
				"os_info": {
					"name": "windows"
				},
				"tags": [
					"test"
				],
				"last_ip": "15.206.168.222",
				"is_active": false
			}
		],
		"packs": [
			{
				"id": 1,
				"name": "all-events-pack",
				"platform": null,
				"version": null,
				"description": null,
				"shard": null,
				"category": "General",
				"tags": [
					"test"
				],
				"queries": []
			}
		]
		"queries": [
			{
				"id": 2,
				"name": "win_process_events",
				"sql": "select * from win_process_events;",
				"interval": 38,
				"platform": "windows",
				"version": "2.9.0",
				"description": "Windows Process Events",
				"value": "Process Events",
				"snapshot": false,
				"shard": null,
				"tags": [],
				"packs": [
					"all-events-pack"
				]
			}
		]
	}
}
```

Carve's Section:
----------------

### View all carves
Lists all carves.
**URL:** https://<BASE_URL>/carves
**Request Type:** POST
**Example Request Format:**
```
{
	"host_identifier":"77858CB1-6C24-584F-A28A-E054093C8924",
	“start”:0,
	“limit”:10
}
```
**Filters Description:**
```
  host_identifier – pass value to this argument to filter the records by a host
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the Carves data",
	"data": {
		"count": 1,
		"results": [
			{
				"id": 1,
				"node_id": 2,
				"session_id": "793OF12PEQ",
				"carve_guid": "3ecdb82c-5d6f-4c0f-b532-bdcb2588894d",
				"carve_size": 34766848,
				"block_size": 300000,
				"block_count": 116,
				"archive": "793OF12PEQ3ecdb82c-5d6f-4c0f-b532-bdcb2588894d.tar",
				"status": "COMPLETED",
				"created_at": "2020-06-29T10:41:41.532733",
				"hostname": "EC2AMAZ-5FTJV7B"
			}
		]
	}
}
```

### Download a carve
Returns a file object of Carves.
**URL:** https://<BASE_URL>/carves/download/<string:session_id>
**Request Type:** GET
**Response:** Returns a file.

### Delete a carve
Deletes a carve.
**URL:** https://<BASE_URL>/carves/delete
**Request Type:** POST
**Example Response Format:**
```
{
	“session_id”:” 793OF12PEQ”
}
```
**Required Payload Arguments:** session_id
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
	“status”:”success”,
	“message”:”Carve is deleted successfully”
}
```

YARA's Section:
---------------

### View YARA files list
Returns list of yara file names.
**URL:** https://<BASE_URL>/yara
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the yara files “, 
	“data”: [“data.txt”,” sample.txt”]
}
```

### Upload YARA file
Uploads a yara file to the POLYLOGYX server.
**URL:** https://<BASE_URL>/yara/add
**Request Type:** POST
**Example Request Format:**
```
{
	“file”:”a yara file object here”
}
```
**Required Payload Arguments:** file
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully uploaded the file"
}
```

### View content of YARA file
Returns the content of the yara file.
**URL:** https://<BASE_URL>/yara/view
**Request Type:** POST
**Example Request Format:**
```
{
	“file_name”:”eicar.yara”
}
```
**Required Payload Arguments:** file_name
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the yara file content!",
	"data": 
	"rule eicar_av_test {\n    /*\n       Per standard, match only if entire file is EICAR string plus optional trailing whitespace.\n       The raw EICAR string to be matched is:\n       X5O!P%@AP[4\\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*\n    */\n\n    meta:\n        description = \"This is a standard AV test, intended to verify that BinaryAlert is working correctly.\"\n        author = \"Austin Byers | Airbnb CSIRT\"\n        reference = \"http://www.eicar.org/86-0-Intended-use.html\"\n\n    strings:\n        $eicar_regex = /^X5O!P%@AP\\[4\\\\PZX54\\(P\\^\\)7CC\\)7\\}\\$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!\\$H\\+H\\*\\s*$/\n\n    condition:\n        all of them\n}\n\nrule eicar_substring_test {\n    /*\n       More generic - match just the embedded EICAR string (e.g. in packed executables, PDFs, etc)\n    */\n\n    meta:\n        description = \"Standard AV test, checking for an EICAR substring\"\n        author = \"Austin Byers | Airbnb CSIRT\"\n\n    strings:\n        $eicar_substring = \"$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!\"\n\n    condition:\n        all of them\n}"
}
```

### Delete a YARA file
Deletes a yara file for the name given.
**URL:** https://<BASE_URL>/yara/delete
**Request Type:** POST
**Example Request Format:**
```
{
	“file_name”:”eicar.yara”
}
```
**Required Payload Arguments:** file_name
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "File with the given file name is deleted successfully"
}
```

IOC's Section:
--------------

### View IOCs
Returns existing IOCs.
**URL:** https://<BASE_URL>/iocs
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the iocs",
	"data": {
		"test-intel_ipv4": {
			"type": "remote_address",
			"severity": "WARNING",
			"intel_type": "self",
			"values": "3.30.1.15,3.30.1.16"
		},
		"test-intel_domain_name": {
			"type": "domain_name",
			"severity": "WARNING",
			"intel_type": "self",
			"values": "unknown.com,slackabc.com"
		},
		"test-intel_md5": {
			"type": "md5",
			"severity": "INFO",
			"intel_type": "self",
			"values": "3h8dk0sksm0,9sd772ndd80"
		}
	}
}
```

### Update IOCs
Update iocs json.
**URL:** https://<BASE_URL>/iocs/add
**Request Type:** POST
**Example Request Format:**
```
{
	"data": {
		"test-intel_ipv4": {
			"type": "remote_address",
			"severity": "WARNING",
			"intel_type": "self",
			"values": "3.30.1.15,3.30.1.16"
		},
		"test-intel_domain_name": {
			"type": "domain_name",
			"severity": "WARNING",
			"intel_type": "self",
			"values": "unknown.com,slackabc.com"
		},
		"test-intel_md5": {
			"type": "md5",
			"severity": "INFO",
			"intel_type": "self",
			"values": "3h8dk0sksm0,9sd772ndd80"
		}
	}
}
```
**Required Payload Arguments:** data
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully updated the intel data “
}
```

OS Query Schema's Section:
--------------------------

### View OSQuery schema
Returns all OSQuery tables schema.
**URL:** https://<BASE_URL>/schema
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the schema",
	"data": {
		"account_policy_data": "CREATE TABLE account_policy_data (uid BIGINT, creation_time DOUBLE, failed_login_count BIGINT, failed_login_timestamp DOUBLE, password_last_set_time DOUBLE)",
		"acpi_tables": "CREATE TABLE acpi_tables (name TEXT, size INTEGER, md5 TEXT)",
	}
}
```

### View one OSQuery table’s schema
Returns an OSQuery table schema for the table name given.
**URL:** https://<BASE_URL>/schema/<string:table>
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the table schema",
	"data": {
	"account_policy_data": "CREATE TABLE account_policy_data (uid BIGINT, creation_time DOUBLE, failed_login_count BIGINT, failed_login_timestamp DOUBLE, password_last_set_time DOUBLE)"
	}
}
```

Rule's Section:
---------------

### View all rules
Returns all rules.
**URL:** https://<BASE_URL>/rules
**Request Type:** POST
**Example Request Format:**
```
{
	“start”:0,
	“limit”:1,
	“searchterm”:””
}
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
	"status": "success",
	"message": "Successfully fetched the rules info",
	"data": {
	"count": 147,
	"total_count": 147,
	"results": [
		{
		"id": 147,
		"alerters": [
			"debug"
		],
		"conditions": {
			"rules": [
			{
				"id": "action",
				"type": "string",
				"field": "action",
				"input": "text",
				"value": "test",
				"operator": "equal"
			}
			],
			"valid": true,
			"condition": "AND"
		},
		"description": "tesing",
		"name": "test123",
		"severity": "INFO",
		"status": "ACTIVE",
		"updated_at": "2020-06-30T07:46:00.265400",
		"type": "MITRE",
		"tactics": [
			"defense-evasion"
		],
		"technique_id": "T1070"
		}
	]
	}
}
```

### View a rule
Returns a rule info for the id given.
**URL:** https://<BASE_URL>/rules/<int:rule_id>
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the rules info",
  "data": {
    "id": 147,
    "alerters": [
      "debug"
    ],
    "conditions": {
      "rules": [
        {
          "id": "action",
          "type": "string",
          "field": "action",
          "input": "text",
          "value": "test",
          "operator": "equal"
        }
      ],
      "valid": true,
      "condition": "AND"
    },
    "description": "tesing",
    "name": "test123",
    "severity": "INFO",
    "status": "ACTIVE",
    "updated_at": "2020-06-30T07:46:00.265400",
    "type": "MITRE",
    "tactics": [
      "defense-evasion"
    ],
    "technique_id": "T1070"
  }
}
```

### Modify a rule
Edits and Returns a rule info for the id, data given.
**URL:** https://<BASE_URL>/rules/<int:rule_id>
**Request Type:** POST
**Example Request Format:**
```
{
  "alerters": "debug,email”,
  "conditions": {
    "rules": [
      {
        "id": "action",
        "type": "string",
        "field": "action",
        "input": "text",
        "value": "test",
        "operator": "equal"
      }
    ],
    "valid": true,
    "condition": "AND"
  },
  "description": "tesing",
  "name": "test123",
  "severity": "INFO",
  "status": "ACTIVE",
  "updated_at": "2020-06-30T07:46:00.265400",
  "type": "MITRE",
  "tactics": "defense-evasion",
  "technique_id": "T1070, T1005"
}
```
**Required Payload Arguments:** name and conditions
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully modified the rules info",
  "data": {
    "id": 147,
    "alerters": [
      "debug"
    ],
    "conditions": {
      "rules": [
        {
          "id": "action",
          "type": "string",
          "field": "action",
          "input": "text",
          "value": "test",
          "operator": "equal"
        }
      ],
      "valid": true,
      "condition": "AND"
    },
    "description": "tesing",
    "name": "test123",
    "severity": "INFO",
    "status": "ACTIVE",
    "updated_at": "2020-06-30T07:46:00.265400",
    "type": "MITRE",
    "tactics": [
      "defense-evasion"
    ],
    "technique_id": "T1070"
  }
}
```

### Add a rule
Adds a rule for the data given.
**URL:** https://<BASE_URL>/rules/add
**Request Type:** POST
**Example Request Format:**
```
{
  "alerters": "debug,email”,
  "conditions": {
    "rules": [
      {
        "id": "action",
        "type": "string",
        "field": "action",
        "input": "text",
        "value": "test",
        "operator": "equal"
      }
    ],
    "valid": true,
    "condition": "AND"
  },
  "description": "tesing",
  "name": "test123",
  "severity": "INFO",
  "status": "ACTIVE",
  "updated_at": "2020-06-30T07:46:00.265400",
  "type": "MITRE",
  "tactics": "defense-evasion",
  "technique_id": "T1070, T1005"
}
```
**Required Payload Arguments:** name and conditions
**Response:** Returns a JSON array of rule_id, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Rule is added successfully “,
  “rule_id”: 2
}
```

### Get tactics for technique ids
Returns tactics for the technique ids given.
**URL:** https://<BASE_URL>/rules/tactics
**Request Type:** POST
**Example Request Format:**
```
{
  “technique_ids”:” T1005, T1004”
}
```
**Required Payload Arguments:** technique_ids
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Tactics are fetched successfully from technique ids",
  "data": {
    "tactics": [
      "collection"
    ],
    "description": "\nSensitive data can be collected from local system sources, such as the file system or databases of information residing on the system prior to Exfiltration.\n\nAdversaries will often search the file system on computers they have compromised to find files of interest. They may do this using a [Command-Line Interface](https://attack.mitre.org/techniques/T1059), such as [cmd](https://attack.mitre.org/software/S0106), which has functionality to interact with the file system to gather information. Some adversaries may also use [Automated Collection](https://attack.mitre.org/techniques/T1119) on the local system.\n"
  }
}
```

Query's Section:
----------------

### View all queries
Returns all queries.
**URL:** https://<BASE_URL>/queries
**Request Type:** POST
**Example Request Format:**
```
{
  "start":0,
  "limit":1,
  “searchterm”:””
}
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the queries info!",
  "data": {
    "count": 103,
    "total_count": 103,
    "results": [
      {
        "id": 78,
        "name": "AppCompat",
        "sql": "select * from registry where key='HKEY_LOCAL_MACHINE\\SOFTWARE\\%Microsoft\\Windows NT\\CurrentVersion\\AppCompatFlags\\Layers'",
        "interval": 86400,
        "platform": null,
        "version": null,
        "description": "Check Applications opted in for DEP",
        "value": null,
        "snapshot": true,
        "shard": null,
        "tags": [],
        "packs": [
          "windows-hardening"
        ]
      }
    ]
  }
}
```

### View all packed queries
Returns all packed queries.
**URL:** https://<BASE_URL>/queries/packed
**Request Type:** POST
**Example Request Format:**
```
{
  "start":0,
  "limit":1,
  “searchterm”:””
}
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the packed queries info",
  "data": {
    "count": 103,
    “total_count”:103,
    "results": [
      {
        "id": 78,
        "name": "AppCompat",
        "sql": "select * from registry where key='HKEY_LOCAL_MACHINE\\SOFTWARE\\%Microsoft\\Windows NT\\CurrentVersion\\AppCompatFlags\\Layers'",
        "interval": 86400,
        "platform": null,
        "version": null,
        "description": "Check Applications opted in for DEP",
        "value": null,
        "snapshot": true,
        "shard": null,
        "tags": [],
        "packs": [
          "windows-hardening"
        ]
      }
    ]
  }
}
```

### View a query
Returns a query info for the id given.
**URL:** https://<BASE_URL>/queries/<int:query_id>
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the query info for the given id",
  "data": {
    "id": 78,
    "name": "AppCompat",
    "sql": "select * from registry where key='HKEY_LOCAL_MACHINE\\SOFTWARE\\%Microsoft\\Windows NT\\CurrentVersion\\AppCompatFlags\\Layers'",
    "interval": 86400,
    "platform": null,
    "version": null,
    "description": "Check Applications opted in for DEP",
    "value": null,
    "snapshot": true,
    "shard": null,
    "tags": [],
    "packs": [
      "windows-hardening"
    ]
  }
}
```

### Add a query
Adds a query for the data given.
**URL:** https://<BASE_URL>/queries/add
**Request Type:** POST
**Example Request Format:**
```
{
  "name": "running_process_query", 
  "query": "select * from processes;", 
  "interval": 5, 
  "platform": "windows", 
  "version": "2.9.0",
  "snapshot": "true",
  "description": "Processes", 
  "value": "Processes”, 
  "tags":"finance,sales" 
}
```
**Required Payload Arguments:** name, query and interval
**Response:** Returns a JSON array of query_id, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Successfully added the query for the data given”,
  “query_id”: 2
}
```

### Modify a query
Edits a query for the id given.
**URL:** https://<BASE_URL>/queries/<int:query_id>
**Request Type:** POST
**Example Request Format:**
```
{
  "name": "running_process_query", 
  "query": "select * from processes;", 
  "interval": 5, 
  "platform": "windows", 
  "version": "2.9.0",
  "snapshot": "true",
  "description": "Processes", 
  "value": "Processes”, 
  "tags":"finance,sales" 
}
```
**Required Payload Arguments:** name, query and interval
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully edited the query info for the given id",
  "data": {
    "id": 78,
    "name": "AppCompat",
    "sql": "select * from registry where key='HKEY_LOCAL_MACHINE\\SOFTWARE\\%Microsoft\\Windows NT\\CurrentVersion\\AppCompatFlags\\Layers'",
    "interval": 86400,
    "platform": "all",
    "version": null,
    "description": "Check Applications opted in for DEP",
    "value": null,
    "snapshot": true,
    "shard": null
  }
}
```

### View tags of a query
Modifies tags for a query for id given.
**URL:** https://<BASE_URL>/queries/<int:query_id/tags
**Request Type:** GET
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the tags of query",
  "data": [
    "test"
  ]
}
```

### Add tags to a query
Adds tags to a query for id given.
**URL:** https://<BASE_URL>/queries/<int:query_id>/tags
**Request Type:** POST
**Example Request Format:**
```
{ 
  “tag":"finance" 
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Successfully created the tag(s) to queries”
}
```

### Delete tags from a query
Removes tags of a query for id given.
**URL:** https://<BASE_URL>/queries/<int:query_id>/tags
**Request Type:** DELETE
**Example Request Format:**
```
{ 
  “tag":"finance" 
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully removed tags from query"
}
```

### Delete a query
Delete a query for id given.
**URL:** https://<BASE_URL>/queries/<int:query_id>/delete
  https://<BASE_URL>/queries/<string:query_name>/delete
**Request Type:** DELETE
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Successfully deleted the query”
}
```

Pack's Section:
---------------

### View all packs
Returns all Packs.
**URL:** https://<BASE_URL>/packs
**Request Type:** POST
**Example Request Format:**
```
{
  “start”:0,
  “limit”:1,
  “searchterm”:””
}
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "successfully fetched the packs info",
  "data": {
    "count": 12,
    “total_count”:12,
    "results": [
      {
        "id": 12,
        "name": "windows-hardening",
        "platform": null,
        "version": null,
        "description": null,
        "shard": null,
        "category": "General",
        "tags": [],
        "queries": [
          {
            "id": 82,
            "name": "PolicyScopeMachine",
            "sql": "select * from registry where key='HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Safer\\CodeIdentifiers\\PolicyScope'",
            "interval": 86400,
            "platform": null,
            "version": null,
            "description": "Check Software Restriction Policies state",
            "value": null,
            "snapshot": true,
            "shard": null,
            "tags": [],
            "packs": [
              "windows-hardening"
            ]
          }
        ]
      }
    ]
  }
}
```

### View a pack
Returns a pack for the id given.
**URL:** https://<BASE_URL>/packs/<int:pack_id>
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "successfully fetched the packs info",
  "data": {
    "id": 12,
    "name": "windows-hardening",
    "platform": null,
    "version": null,
    "description": null,
    "shard": null,
    "category": "General",
    "tags": [],
    "queries": [
      {
        "id": 82,
        "name": "PolicyScopeMachine",
        "sql": "select * from registry where key='HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Safer\\CodeIdentifiers\\PolicyScope'",
        "interval": 86400,
        "platform": null,
        "version": null,
        "description": "Check Software Restriction Policies state",
        "value": null,
        "snapshot": true,
        "shard": null,
        "tags": [],
        "packs": [
          "windows-hardening"
        ]
      }
    ]
  }
}
```

### Add a pack
Adds a pack for the data given.
**URL:** https://<BASE_URL>/packs/add
**Request Type:** POST
**Example Request Format:**
```
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
  "tags": "finance, sales",
  “category": "General”
}
```
**Required Payload Arguments:** name, queries
**Response:** Returns a JSON array of pack_id, status and message.
**Example Response Format:**
```
{
  “status": "success”,
  “message": "Imported query pack and pack is added successfully”,
  “pack_id”:2
}
```

### View tags of a pack
Lists tags for a pack for id given.
**URL:** https://<BASE_URL>/packs/<int:pack_id/tags
  https://<BASE_URL>/packs/<string:pack_name>/tags
**Request Type:** GET
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the tags of pack",
  "data": [
    "test"
  ]
}
```

### Add tags to a pack
Adds tags to a pack for id given.
**URL:** https://<BASE_URL>/packs/<int:pack_id>/tags
  https://<BASE_URL>/packs/<string:pack_name>/tags
**Request Type:** POST
**Example Request Format:**
```
{ 
  “tag": "finance" 
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Successfully created the tag(s) to packs”
}
```

### Delete tags from a pack
Removes tags of a pack for id given.
**URL:** https://<BASE_URL>/packs/<int:pack_id>/tags
  https://<BASE_URL>/packs/<string:pack_name>/tags
**Request Type:** DELETE
**Example Request Format:**
```
{ 
  “tag": "finance" 
}
```
**Required Payload Arguments:** tag
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully removed tags from pack"
}
```

### Delete a pack
Delete a pack for id given.
**URL:** https://<BASE_URL>/packs/<int:pack_id>/delete
  https://<BASE_URL>/packs/<string:pack_name>/delete
**Request Type:** DELETE
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Successfully deleted the pack”
}
```

### Upload a pack
Adds pack through a file upload
**URL:** https://<BASE_URL>/packs/upload
**Request Type:** POST
**Example Request Format:**
```
{
  “file”: “A JSON file object with json content same as /packs/add but without pack name”,
  “category”: “General”
}
```
**Required Payload Arguments:** file and category
**Response:** Returns a JSON array of pack id, status and message.
**Example Response Format:**
```
{
  “status": "success”,
  “message": "pack uploaded successfully”,
  “pack_id”:2
}
```

Config's Section:
-----------------

### View all configs
Returns all configs.
**URL:** https://<BASE_URL>/configs/all
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the configs",
  "data": {
    "linux": {
      "x86_64": {
        "0": {
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
            "socket_events": {
              "id": 2,
              "query": "SELECT action, auid, family, local_address, local_port, path, pid, remote_address, remote_port, success, time,eid FROM socket_events WHERE success=1 AND path NOT IN ('/usr/bin/hostname') AND remote_address NOT IN ('127.0.0.1', '169.254.169.254', '', '0000:0000:0000:0000:0000:0000:0000:0001', ':1', '0000:0000:0000:0000:0000:ffff:7f00:0001', 'unknown', '0.0.0.0', '0000:0000:0000:0000:0000:0000:0000:0000');",
              "interval": 10,
              "platform": "linux",
              "version": null,
              "description": null,
              "value": null,
              "removed": false,
              "shard": null,
              "snapshot": false,
              "status": true
            }
          },
          "status": true,
          "filters": {
            "events": {
              "disable_subscribers": [
                "user_events"
              ]
            },
            "file_paths": {
              "binaries": [
                "/usr/local/sbin/%%"
              ],
              "configuration": [
                "/etc/passwd"
              ]
            }
          }
        }
      }
    },
    "windows": {
      "x86_64": {
        "1": {
          "queries": {
            "win_epp_table": {
              "id": 110,
              "query": "select * from win_epp_table;",
              "interval": 360,
              "platform": "windows",
              "version": null,
              "description": "Endpoint Products Status",
              "value": null,
              "removed": false,
              "shard": null,
              "snapshot": false,
              "status": true
            },
            "win_image_load_events": {
              "id": 111,
              "query": "select * from win_image_load_events_optimized;",
              "interval": 180,
              "platform": "windows",
              "version": null,
              "description": "Extensions in the Chrome browser",
              "value": null,
              "removed": false,
              "shard": null,
              "snapshot": false,
              "status": true
            }
          },
          "status": false,
          "filters": {
            "plgx_event_filters": {
              "win_ssl_events": {
                "process_name": {
                  "exclude": {
                    "values": [
                      "*\\plgx_cpt.exe"
                    ]
                  }
                }
              }
            }
          }
        },
        "2": {
          "queries": {
            "win_remote_thread_events": {
              "id": 153,
              "query": "select * from win_remote_thread_events_optimized;",
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
              "id": 154,
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
          "status": true,
          "filters": {
            "feature_vectors": {
              "character_frequencies": [
                0
              ]
            },
            "win_include_paths": {
              "all_files": [
                "*"
              ]
            },
            "plgx_event_filters": {
              "win_ssl_events": {
                "process_name": {
                  "exclude": {
                    "values": [
                      "*\\Program Files\\plgx_osquery\\plgx_osqueryd.exe"                    ]
                  }
                }
              }
            }
          }
        }
      },
      "x86": {
        "0": {
          "queries": {
            "appcompat_shims": {
              "id": 155,
              "query": "SELECT * FROM appcompat_shims WHERE description!='EMET_Database' AND executable NOT IN ('setuphost.exe','setupprep.exe','iisexpress.exe');",
              "interval": 3600,
              "platform": "windows",
              "version": null,
              "description": "Appcompat shims (.sdb files) installed on Windows hosts.",
              "value": null,
              "removed": false,
              "shard": null,
              "snapshot": false,
              "status": true
            },
            "certificates": {
              "id": 156,
              "query": "SELECT * FROM certificates WHERE path!='Other People';",
              "interval": 3600,
              "platform": "windows",
              "version": null,
              "description": "List all certificates in the trust store",
              "value": null,
              "removed": false,
              "shard": null,
              "snapshot": false,
              "status": true
            }
          },
          "status": true,
          "filters": {}
        }
      }
    },
    "darwin": {
      "x86_64": {
        "0": {
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
            "boot_efi_hash": {
              "id": 46,
              "query": "SELECT path, md5 FROM hash WHERE path='/System/Library/CoreServices/boot.efi';",
              "interval": 28800,
              "platform": "darwin",
              "version": null,
              "description": "MD5 hash of boot.efi",
              "value": null,
              "removed": false,
              "shard": null,
              "snapshot": false,
              "status": true
            }
          },
          "status": true,
          "filters": {
            "file_paths": {
              "binaries": [
                "/usr/bin/%%"
              ],
              "configuration": [
                "/etc/%%"
              ]
            }
          }
        }
      }
    }
  }
}
```

### View a config
Returns config of a specific platform.
**URL:** https://<BASE_URL>/configs/view
**Request Type:** POST
**Example Response Format:**
```
{
  “platform”:”linux”,
  “arch”:”x86_64”
}
```
**Required Payload Arguments:** platform and arch
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Config is fetched successfully for the platform given",
  "data": {
    "queries": {
      "process_events": {
        "status": true,
        "interval": 10
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
          "/usr/bin/%%"
        ]
      }
    },
    "type": "default"
  }
}
```

### Modify a config
Modifies config of a platform for the name given.
**URL:** https://<BASE_URL>/configs/update
**Request Type:** POST
**Example Request Format:**
```
{
  "platform": "linux",
  “arch”:”x86_64”,
  “type”:”default”,
  "queries": {
    "process_events": {
      "interval": 10,
      "status": true
    },
    "osquery_info": {
      "interval": 86400,
      "status": true
    }
  },
  "filters": {}
}
```
**Required Payload Arguments:** platform, arch, type, queries and filters
**Response:** Returns a JSON array of config, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Config is edited successfully for the platform given”,
  “config”: {
    "platform": "linux",
    "queries": {
      "process_events": {
        "interval": 10,
        "status": true
      },
      "osquery_info": {
        "interval": 86400,
        "status": true
      }
    },
    "filters": {},
    "type": "default"
  }
}
```

### Toggle the config
Toggles the config in between shallow and deep.
**URL:** https://<BASE_URL>/configs/toggle
**Request Type:** PUT
**Example Request Format:**
```
{
  "platform": windows",
  "arch":"x86_64",
  "type": "shallow”
}
```
**Required Payload Arguments:** platform, arch and type
**Response:** Returns a JSON array of status and message.
**Example Response Format:**
```
{
  “status": "success”,
  “message”: “Default config for the platform and arch given is changed successfully"
}
```

Alert's Section:
----------------

### View alerts source distribution
Returns all alerts count for all the sources.
**URL:** https://<BASE_URL>/alerts/count_by_source
**Request Type:** GET
**Example Request Format:**
```
{
  "resolved": false
}
```
**Filters Description:**
```
  resolved – true to get only resolved alerts count / false to get non-resolved alerts count
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Data is fetched successfully",
  "data": {
    "alert_source": [
      {
        "name": "virustotal",
        "count": 0
      },
      {
        "name": "rule",
        "count": 93833
      },
      {
        "name": "ibmxforce",
        "count": 3
      },
      {
        "name": "alienvault",
        "count": 0
      },
      {
        "name": "ioc",
        "count": 21
      }
    ]
  }
}
```

### View all alerts
Returns all alerts for the filters applied.
**URL:** https://<BASE_URL>/alerts
**Request Type:** POST
**Example Request Format:**
```
{
  "source":"rule",
  "resolved":false,
  "start":0,
  “limit”:1,
  “searchterm”:””,
  “event_ids”: [],
  “duration”:”3”,
  “date”: "2020-8-5",
  “type”:”2”
}
```
**Required Payload Arguments:** source
**Filters Description:**
```
  source – alert’s source to get the alerts only for
  resolved – true to get only resolved alerts / false to get non-resolved alerts
  event_ids – event ids to filter the alerts for
  duration – to get recent alerts by(month/week/day)
  date – end date for the duration to be calculated by
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Data is fetched successfully",
  "data": {
    "count": 93833,
    "total_count": 93833,
    "results": [
      {
        "id": 93855,
        "node_id": 4,
        "rule_id": 146,
        "severity": "INFO",
        "rule": {
          "name": "test_process_without_default_query",
          "id": 146
        },
        "created_at": "2020-08-04 17:01:13.458996",
        "type": "rule",
        "source": "rule",
        "status": "OPEN",
        "alerted_entry": {
          "eid": "241E415E-9F35-42DA-9F20-0D3F03F8FFFF",
          "pid": "5704",
          "path": "C:\\Windows\\System32\\wbem\\WmiPrvSE.exe",
          "time": "1596557041",
          "action": "PROC_TERMINATE",
          "cmdline": "C:\\Windows\\system32\\wbem\\wmiprvse.exe",
          "utc_time": "Tue Aug  4 16:04:01 2020 UTC",
          "owner_uid": "NT AUTHORITY\\NETWORK SERVICE",
          "parent_pid": "700",
          "parent_path": "C:\\Windows\\System32\\svchost.exe",
          "process_guid": "58E0F736-D62C-11EA-8283-02F7A50E7DFE",
          "parent_process_guid": "58E0F62F-D62C-11EA-8283-02F7A50E7DFE"
        },
        "hostname": "EC2AMAZ-H7M54UV"
      },
      {
        "id": 93854,
        "node_id": 4,
        "rule_id": 146,
        "severity": "INFO",
        "rule": {
          "name": "test_process_without_default_query",
          "id": 146
        },
        "created_at": "2020-08-04 17:01:13.448373",
        "type": "rule",
        "source": "rule",
        "status": "OPEN",
        "alerted_entry": {
          "eid": "74A4627E-AE27-4A1F-9DAC-2E6303F8FFFF",
          "pid": "5348",
          "path": "C:\\Windows\\WinSxS\\amd64_microsoft-windows-servicingstack_31bf3856ad364e35_10.0.17763.850_none_7e18264b4d00f498\\TiWorker.exe",
          "time": "1596556952",
          "action": "PROC_CREATE",
          "cmdline": "C:\\Windows\\winsxs\\amd64_microsoft-windows-servicingstack_31bf3856ad364e35_10.0.17763.850_none_7e18264b4d00f498\\TiWorker.exe -Embedding",
          "utc_time": "Tue Aug  4 16:02:32 2020 UTC",
          "owner_uid": "NT AUTHORITY\\SYSTEM",
          "parent_pid": "700",
          "parent_path": "C:\\Windows\\System32\\svchost.exe",
          "process_guid": "58E0F73A-D62C-11EA-8283-02F7A50E7DFE",
          "parent_process_guid": "58E0F62F-D62C-11EA-8283-02F7A50E7DFE"
        },
        "hostname": "EC2AMAZ-H7M54UV"
      }
    ]
  }
}
```

### View an alert
Returns an alert data.
**URL:** https://<BASE_URL>/alerts/<int:alert_id>
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the Alerts data",
  "data": {
    "query_name": "win_dns_events",
    "message": {
      "eid": "22682106-0532-4AA9-AEA6-6E6931000000",
      "pid": "1144",
      "time": "1596551122",
      "action": "DNS_LOOKUP",
      "utc_time": "Tue Aug  4 14:25:22 2020 UTC",
      "event_type": "DNS",
      "domain_name": ".www.google.com",
      "remote_port": "53",
      "request_type": "1",
      "request_class": "1",
      "remote_address": "172.31.0.2"
    },
    "node_id": 4,
    "rule_id": null,
    "severity": "WARNING",
    "created_at": "2020-08-04 15:36:49.651175",
    "type": "Threat Intel",
    "source": "ioc",
    "recon_queries": {},
    "status": "OPEN",
    "source_data": {},
    "hostname": "EC2AMAZ-H7M54UV",
    "platform": "windows"
  }
}
```

### Resolve/Unresolve an alert
Resolve/Unresolve an alert.
**URL:** https://<BASE_URL> /alerts/<int:alert_id>
**Request Type:** PUT
**Example Request Format:**
```
{
  “resolve": true
}
```
**Filters Description:**
```
  resolve – true to resolve / false to unresolve
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Alert status is changed successfully"
}
```

### Export alerts
Exports alerts data.
**URL:** https://<BASE_URL>/alert_source/export
**Request Type:** POST
**Example Request Format:**
```
{
  “source": "rule”
}
```
**Required Payload Arguments:** source
**Response:** Returns a csv file.

Alert's Investigate Section: -- Available only for Enterprise Edition
--------------------------------------------------------------------

### View graph data
Returns alerts graph data.
**URL:** https://<BASE_URL>/alerts/graph
**Request Type:** GET
**Example Request Format:**
```
{
  "source":"rule",
  “duration”:"3",
  “date”:”2020-8-5”,
  “type”:”2”
}
```
**Required Payload Arguments:** source
**Filters Description:**
```
  source – alert’s source to get the alerts only for
  duration – to get recent alerts by(month/week/day)
  date – end date for the duration to be calculated by
```
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Data is fetched successfully",
  "data": [
    {
      "start": 1596560473458.996,
      "content": "",
      "event_id": 93855,
      "className": ""
    },
    {
      "start": 1596560473448.373,
      "content": "",
      "event_id": 93854,
      "className": ""
    }
  ]
}
```

### View alerted events
Returns events related to the alert.
**URL:** https://<BASE_URL>/alerts/<int:alert_id>/events
**Request Type:** GET
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully fetched the Alert's events data",
  "data": {
    "schedule_query_data_list_obj": [
      {
        "name": "win_dns_events",
        "data": [
          {
            "eid": "15A348E7-AAD4-4099-8A53-F25532000000",
            "pid": "1144",
            "time": "1596551139",
            "action": "DNS_LOOKUP",
            "utc_time": "Tue Aug  4 14:25:39 2020 UTC",
            "event_type": "DNS",
            "domain_name": ".www.gstatic.com",
            "remote_port": "53",
            "request_type": "1",
            "request_class": "1",
            "remote_address": "172.31.0.2",
            "date": "Tue Aug  4 14:25:39 2020 UTC"
          },
          {
            "eid": "579D64E5-8A48-4F87-83BB-F87B32000000",
            "pid": "1144",
            "time": "1596551139",
            "action": "DNS_LOOKUP",
            "utc_time": "Tue Aug  4 14:25:39 2020 UTC",
            "event_type": "DNS",
            "domain_name": ".www.gstatic.com",
            "remote_port": "53",
            "request_type": "1",
            "request_class": "1",
            "remote_address": "172.31.0.2",
            "date": "Tue Aug  4 14:25:39 2020 UTC"
          }
        ]
      }
    ],
    "system_state_data_list": [
      "etc_hosts",
      "drivers",
      "kernel_info",
      "users",
      "scheduled_tasks",
      "uptime",
      "osquery_info",
      "os_version",
      "patches",
      "certificates"
    ]
}
}
```

### Get alerts data for process analysis
Returns alerts data for process analysis.
**URL:** https://<BASE_URL>/alerts/process
**Request Type:** POST
**Example Request Format:**
```
{
  "process_guid": "58E0F736-D62C-11EA-8283-02F7A50E7DFE",
  "alert_id": "93855",
  "node_id": 4
}
```
**Required Payload Arguments:** process_guid and node_id
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Data is fetched successfully",
  "data": {
    "name": "svchost.exe",
    "path": "C:\\Windows\\System32\\svchost.exe",
    "all_children": [
      {
        "action": "PROC_CREATE",
        "count": 4,
        "color": "blue",
        "node_type": "action",
        "children": [
          {
            "color": "red",
            "name": "child",
            "data": {
              "eid": "44A8FC8A-2223-455B-89ED-BE1503F8FFFF",
              "pid": "2156",
              "path": "C:\\Windows\\System32\\taskhostw.exe",
              "time": "1596551290",
              "action": "PROC_CREATE",
              "cmdline": "taskhostw.exe NGCKeyPregen",
              "utc_time": "Tue Aug  4 14:28:10 2020 UTC",
              "owner_uid": "NT AUTHORITY\\SYSTEM",
              "parent_pid": "1032",
              "parent_path": "C:\\Windows\\System32\\svchost.exe",
              "process_guid": "58E0F688-D62C-11EA-8283-02F7A50E7DFE",
              "parent_process_guid": "58E0F638-D62C-11EA-8283-02F7A50E7DFE"
            }
          }
        ],
        "last_time": "1596558693",
        "all_children": [
          {
            "color": "red",
            "name": "child",
            "data": {
              "eid": "44A8FC8A-2223-455B-89ED-BE1503F8FFFF",
              "pid": "2156",
              "path": "C:\\Windows\\System32\\taskhostw.exe",
              "time": "1596551290",
              "action": "PROC_CREATE",
              "cmdline": "taskhostw.exe NGCKeyPregen",
              "utc_time": "Tue Aug  4 14:28:10 2020 UTC",
              "owner_uid": "NT AUTHORITY\\SYSTEM",
              "parent_pid": "1032",
              "parent_path": "C:\\Windows\\System32\\svchost.exe",
              "process_guid": "58E0F688-D62C-11EA-8283-02F7A50E7DFE",
              "parent_process_guid": "58E0F638-D62C-11EA-8283-02F7A50E7DFE"
            }
          }
        ],
        "name": "PROC_CREATE",
        "fetched": true,
        "process_guid": "58E0F638-D62C-11EA-8283-02F7A50E7DFE"
      }
    ],
    "node_type": "root",
    "data": {
      "process_guid": "58E0F638-D62C-11EA-8283-02F7A50E7DFE",
      "path": "C:\\Windows\\System32\\svchost.exe"
    }
  }
}
```

### Get alerts data for process child analysis
Returns alerts data for process child analysis.
**URL:** https://<BASE_URL>/alerts/process/child
**Request Type:** POST
**Example Request Format:**
```
{
  "process_guid": "58E0F638-D62C-11EA-8283-02F7A50E7DFE",
  "action": "PROC_TERMINATE",
  "node_id": 4
}
```
**Required Payload Arguments:** process_guid, action and node_id
**Response:** Returns a JSON array of data, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully get the data",
  "data": {
    "child_data": [
      {
        "color": "red",
        "name": "child",
        "data": {
          "eid": "404D77BA-055E-4EFD-9BE3-9C0403F8FFFF",
          "pid": "2156",
          "path": "C:\\Windows\\System32\\taskhostw.exe",
          "time": "1596551290",
          "action": "PROC_TERMINATE",
          "cmdline": "taskhostw.exe NGCKeyPregen",
          "utc_time": "Tue Aug  4 14:28:10 2020 UTC",
          "owner_uid": "NT AUTHORITY\\SYSTEM",
          "parent_pid": "1032",
          "parent_path": "C:\\Windows\\System32\\svchost.exe",
          "process_guid": "58E0F688-D62C-11EA-8283-02F7A50E7DFE",
          "parent_process_guid": "58E0F638-D62C-11EA-8283-02F7A50E7DFE"
        }
      }
    ],
    "last_time": "1596558693"
  }
}
```

Response Action's Section: -- Available only for Enterprise Edition
-------------------------------------------------------------------

### View all response actions
Returns all response actions.
**URL:** https://<BASE_URL>/response
**Request Type:** POST
**Example Request Format:**
```
{
  "start": 0,
  “limit”:1,
  “searchterm”:””
}
```
**Response:** Returns JSON array of data, status and message.
**Example Response Format:** 
```
{
  "status": "success",
  "message": "Successfully fetched the responses info",
  "data": {
    "count": 1,
    "total_count": 1,
    "results": [
      {
        "id": 7,
        "action": "stop",
        "command": {
          "action": "stop",
          "actuator": {
            "endpoint": "polylogyx_vasp"
          },
          "target": {
            "process": {
              "name": "calc.exe",
              "pid": "8282"
            }
          }
        },
        "created_at": "2020-08-04 15:10:11.284031",
        "updated_at": "2020-08-04 15:10:11.283453",
        "script_name": null,
        "target": "process",
        "Executed": "1/1"
      }
    ]
  }
}
```

### View response actions in node level
Returns all response actions in node level.
**URL:** https://<BASE_URL>/response/view
**Request Type:** POST
**Example Request Format:**
```
{
  "start": 0,
  “limit”:1,
  “searchterm”:””,
  “openc2_id”:1
}
```
**Required Payload Arguments:** openc2_id
**Response:** Returns JSON array of data, status and message.
**Example Response Format:** 
```
{
  "status": "success",
  "message": "Successfully fetched the responses info",
  "data": {
    "count": 1,
    "total_count": 7,
    "results": [
      {
        "id": 8,
        "command": {
          "action": "stop",
          "actuator": {
            "endpoint": "polylogyx_vasp"
          },
          "target": {
            "process": {
              "name": "calc.exe",
              "pid": "8282"
            }
          }
        },
        "created_at": "2020-08-04 15:10:11.315204",
        "updated_at": "2020-08-04 15:10:11.288915",
        "node_id": 3,
        "command_id": "2c92808273b870760173ba05d560000c",
        "status": "failure",
        "message": "RESP_SERVER_DISABLED",
        "hostname": "EC2AMAZ-VLRC0S2",
        "target": "process",
        "action": "stop"
      }
    ]
  }
}
```

### Export response actions
Returns all response actions into a csv file.
**URL:** https://<BASE_URL>/response/export
**Request Type:** POST
**Response:** Returns a csv file.

### View a response action
Returns all responses info for the command id given.
**URL:** https://<BASE_URL>/response/<string:command_id>
**Request Type:** GET
**Response:** Returns JSON array of data, status and message.
**Example Response Format:**
```
{
  “status”:”success”,
  “message”:”Successfully received the command status”,
  “data”: {
    "id": 8,
    "command": {
      "action": "stop",
      "actuator": {
        "endpoint": "polylogyx_vasp"
      },
      "target": {
        "process": {
          "name": "calc.exe",
          "pid": "8282"
        }
      }
    },
    "created_at": "2020-08-04 15:10:11.315204",
    "updated_at": "2020-08-04 15:10:11.288915",
    "node_id": 3,
    "command_id": "2c92808273b870760173ba05d560000c",
    "status": "failure",
    "message": "RESP_SERVER_DISABLED",
    "hostname": "EC2AMAZ-VLRC0S2",
    "target": "process",
    "action": "stop"
  }
}
```

### Get action status
Returns response action status of a host.
**URL:** https://<BASE_URL>/response/status
**Request Type:** POST
**Example Request Format:**
```
{
  “host_identifier”:”EC2CD1A0-140B-9331-7A60-CFFCE29D2E71”,
  “node_id”:1
}
```
**Required Payload Arguments:** host_identifier / node_id
**Response:** Returns JSON array of status, message and responseEnabled.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully received the status",
  "responseEnabled": true,
  "endpointOnline": true
}
```

### Agent restart
Restart an agent.
**URL:** https://<BASE_URL>/response/restart-agent
**Request Type:** POST
**Example Request Format:**
```
{
  “host_identifier”:”EC2CD1A0-140B-9331-7A60-CFFCE29D2E71”
}
```
**Required Payload Arguments:** host_identifier
**Response:** Returns JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Action to restart agent is added successfully"
}
```

### Add an action
Adds response action for the data given.
**URL:** https://<BASE_URL>/response/add
**Request Type:** POST
**Example Request Format:**
```
1)File Response Action:
{
  "action": "delete",
  "actuator_id": "EC2CD1A0-140B-9331-7A60-CFFCE29D2E71",
  "target": "file",
  "file_name": "C:\\Users\\PolyLogyx\\Downloads\\suspicious.exe",
  "file_hash": "o2MJjT8UKSRM7eoLDMWvm4LxqaFvDxd2wLg1KQQQ2jXfG5UE"
}
**Required Payload Arguments:** action, actuator_id, file_name/file_hash and target
2)Process Response Action:
{
  "action": "stop",
  "actuator_id": "EC2CD1A0-140B-9331-7A60-CFFCE29D2E71",
  "target": "process",
  "process_name": "suspicious1.exe",
  "pid": "3123"
}
**Required Payload Arguments:** action, actuator_id, process_name/pid and target
3)Network Response Action:
A) Delete a rule:
{
  "action": "delete",
  "actuator_id": "EC2CD1A0-140B-9331-7A60-CFFCE29D2E71",
  "target": "ip_connection",
  "rule_name": "test_rule_12"
}
**Required Payload Arguments:** action, actuator_id, rule_name and target
B) Isolate a rule:
{
  "action": "contain",
  "actuator_id": "EC2CD1A0-140B-9331-7A60-CFFCE29D2E71",
  "target": "ip_connection",
  "rule_name": "test_rule_12",
  "rule_group": "test",
  "src_port": "",
  "dst_port": "",
  "dst_addr": "",
  "application": "",
  "direction": "1",
  "layer4_protocol": "256"
}
```
**Response:** Returns JSON array of command_id, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Successfully sent the response command”,
  “command_id”:"2c92808a69099f17016910516100000a"
}
```

### Add a custom action:
Adds custom response action.
**URL:** https://<BASE_URL>/response/custom-action
**Request Type:** POST
**Example Request Format:**
```
{
  “host_identifier”:”EC2CD1A0-140B-9331-7A60-CFFCE29D2E71”,
  “content”:"dir\n$pwd",
  “file_type”:”2”,
  “save_script”:”true”,
  “script_name”:”dir_script”
}
```
**Filters Description:**
```
  file_type – 1 for .bat, 2 for powershell scripts and 3 for shell scripts
  save_script - “true” to save the script, “false” not to save
```
**Required Payload Arguments:** host_identifier, file_type
**Response:** Returns JSON array of openc2_id, status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": “Action is added successfully”,
  “openc2_id”: 1
}
```

### Delete a response action
Delete a response action record from the database.
**URL:** https://<BASE_URL>/response/<int: openc2_id>/delete
**Request Type:** DELETE
**Response:** Returns JSON array of status and message.
**Example Response Format:**
```
{
  "status": "success",
  "message": "Successfully removed the response"
}
```

### Distributed query flow:
--> Post query to /distributed/add API.
**URL:** https://<BASE_URL>/distributed/add
**Request Type:** POST
Example payload:
```
{ 
  "tags": "demo",
  "query": "select * from system_info;”,
  "nodes": "6357CE4F-5C62-4F4C-B2D6-CAC567BD6113,6357CE4F-5C62-4F4C-B2D6-CAGF12F17F23”,
  “description”:”live query to get system_info”
}
```
**Example Response Format:**
```
{
  "status": "success",
  "message": "Distributed query is sent successfully",
  "data": {
    "query_id": 200,
    "onlineNodes": 3
  }
}
```
--> Make a connection from a socketio client to the below URL.
wss://<IP_OF_THE_SERVER>:5000/distributed/result
--> Emit below payload to the socket server.
{“query_id”:<query_id_from_api_response>}
For ex: {“query_id”:2}
--> Keep the socket client listen to server till a message with format is received.
```
{
  "node": {
    "id": 6,
    "name": "ip-172-31-16-229"
  },
  "data": [
    {
      "uid": "0",
      "gid": "0",
      "uid_signed": "0",
      "gid_signed": "0",
      "username": "root",
      "description": "root",
      "directory": "/root",
      "shell": "/bin/bash",
      "uuid": ""
    }
  ],
  "query_id": 2
}
```
	

[Previous << Tables](../11_Tables/Readme.md)  
