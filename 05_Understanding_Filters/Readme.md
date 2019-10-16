Understanding Filters
======================

By default, the PolyLogyx client is designed to capture system events in
real-time for a variety of system activities. Also, it makes the telemetry
available through a flexible SQL syntax.

Any system, even when idle, generates a high volume of events. Streaming these
events from an endpoint to the server at regular intervals using scheduled
queries, despite compressing data, causes burden on the network and server
storage. A lot of the system activity is benign or irrelevant for incident
reporting and results in a large volume of data.

By default, the data captured for endpoints is based on multiple seeded filters
already defined in the osquery configuration file. These seeded filters reduce
the volume of data you need to review to search for incidents of interest. Also,
this reduces the burden on network and server resources. These filter are
derived from the high fidelity sysmon filters built by
[SwiftOnSecurity](https://github.com/SwiftOnSecurity/sysmon-config). For the
most part, the data captured by the seeded filters will meet your needs.
However, if needed, you can further tweak the data captured by defining
additional filters.

Filter Types
------------

Using filters, you can configure the PolyLogyx client to capture only data
relevant to you. You can choose to include relevant data and exclude
non-meaningful data. In effect you can define these type of filters:

-   Include filters to receive information about events matching the specified
    filtering criteria.

-   Exclude filters to ignore information about events matching the specified
    filtering criteria.

Before you define filters, review the following guidelines:

-   If you define an include filter for a table and column combination, all
    other data for that table and column combination is automatically excluded.
    Only the data matching the defined include filters is captured.

-   If you define an exclude filter for a table and column combination, all
    other data for that table and column combination is automatically captured.
    Only the data matching the defined exclude filters is ignored.

-   When the defined filters are processed:

    -   Exclude filters take precedence over include filters when rules
        conflict. So, if an include and exclude filter match the same event,
        information for the file is not captured.

    -   Include filters take precedence over exclude filters when rules do not
        conflict.

Adding Filters
--------------

Filters operate on the tables and are defined in the
osquery configuration file. Use the JSON syntax to define filters. Place all
filters within the plgx_event_filters tag in the osquery configuration file.
Here is the syntax used to define a filter.
``` 
“plgx_event_filters”: {
 	“table name1”: {
		“column name1” : {
			“filter type” : {
				“values”:[
					“value 1”,
					“value 2”
					]
					}
				},
		“column name2” : {
			“filter type” : {
				“values”:[
					“value 3”,
					“value 4”
					]
				    }
			   }
			},
	“table name2”: {
		“column name3” : {
			“filter type” : {
				“values”:[
					“value 5”,
					“value 6”
					]
				}
		   },
		“column name2” : {
			“filter type” : {
				“values”:[
					“value 7”,
					“value 8”
					]
				}
			}
		}
	}

```
 
In the syntax:

-   table name1 and table name2 - Represents the name of the table for which to
    define filters. You must include the table names in quotes (“”). You can
    apply filters only on a selected set of tables. For more information, see
    [Supported Tables](#tables-that-support-filters).

-   column name1, column name2, and so on - Indicates the name of the column
    within the table on which to filter information. You must include the column
    names in quotes (“”). You can define filters on selected columns in a set of
    tables. For more information, see [Supported
    Tables](#tables-that-support-filters).

-   filter type - Specifies the filter type. Possible values are include and
    exclude. You must include the values in quotes (“”).

-   value 1, value 2 and so on - List the values to match for the specified
    filter. Each entry represents a value that you want to store or ignore data
    for (based on the filter type). You must include the values in quotes (“”).
    Specified values are case insensitive. You can also use regular expressions
    in the values.

    -   \* – Represents one or more characters

    -   ? – Represents a single character

Examples
--------

Here are a few examples of exclude filters.
``` "win_process_events": {	
			"cmdline": {
				"exclude" : {
					"values": 
					[
					"C:\\Windows\\system32\\DllHost.exe /Processid*",
					"C:\\Windows\\system32\\SearchIndexer.exe /Embedding",
					"C:\\windows\\system32\\wermgr.exe -queuereporting",
					]
     		            	           }
                                    }
                            }
```
Here are a few examples of include filters.
``` "win_registry_events": {
			"target_name": {
				"include": {
					"values": 
					[
					"*CurrentVersion\\Run*",
					"*Policies\\Explorer\\Run*",
					"*Group Policy\\Scripts*",
					"*Windows\\System\\Scripts*",
					]
					   }
				      }
			     }
```

Tables that Support Filters
---------------------------

Event filtering is supported on following tables (and fields or columns).

| Table Name                                                  | Supported Columns |
|-------------------------------------------------------------|-------------------|
|  win_process_events                                         | cmdline, path, and parent_path           |
|  win_registry_events                                        | target_name       |
|  win_socket_events                                          | process_name, remote_port, and remote_address      |
|  win_file_events                                            | target_path and process_name       |
|  win_remote_thread_events                                   | src_path, target_path, and function_name          |
|  win_dns_events                                             | domain_name       |
|  win_dns_response_events                                    | domain_name       |
|  win_ssl_events                                             | process_name       |


|										|																							|
|:---									|													   								    ---:|
|[Previous << Client Configurations](../04_PolyLogyx_Client_Configurations/Readme.md)  | [Next >> Queries and Packs](../06_Queries_and_packs/Readme.md)|
