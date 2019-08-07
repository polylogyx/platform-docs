Using Queries
===================================
A query is a request for data or information from a database table or combination of tables. After the PolyLogyx client is provisioned, data for managed endpoints is fetched and stored in the database on the PolyLogyx server. You can query this data (included in various tables ADD LINKS TO TABLE SECTION) to review node state and get real-time results.
You can review, push, and and manage queries from the UI or by using APIs. This topic describes how to manage queries using the UI. For more information on managing queries using API, see LINK TBA.
   
Query Structure
--------------------
All queries you define or use in the PolyLogyx framework are defined using JSON syntax. 
Here is format used to define queries.

```
"table name": {
         "query": "select * from table  where column='value';",
         "interval": number of seconds,
         "platform": "operating system",
         "version": "x.x.x",
         "description": "this describes the query",
        "value": "Process Events",
         "removed": false
       },
 ```    
Here is an example.

```
"win_process_events": {
         "query": "select * from win_process_events  where action='PROC_CREATE';",
         "interval": 30,
         "platform": "windows",
         "version": "2.9.0",
         "description": "Windows Process Events",
         "value": "Process Events",
         "removed": false
       },
 ```

Query Workflow
--------------------
The following diagram depicts the high-level query workflow. 
![query_workflow](https://github.com/preetpoly/test/blob/pooja/query_workflow.png)

1.	Query is pushed to the node at the next configuration refresh interval.
2.	Query result is sent from the client database to the server database or stream (if configured).  
3.	Query results can be viewed on the UI or by using APIs.
Steps 1, 2 and 3 apply to scheduled queries, query packs, and queries. Step 2 isn’t performed for Live queries. The following table describes how query data is stored.

| Query type      | Query Data Storage |           |                        |
|-----------------|--------------------|-----------|------------------------|
|                 | Client DB          | Server DB | Stream (if configured) |
| Scheduled query | Yes                | Yes       | Yes                    |
| Query pack      | Yes                | Yes       | Yes                    |
| Query           | Yes                | Yes       | Yes                    |
| Live query      | Yes                | No        | No                     |

The client database can store up to 2500 events. If it receives more events, events older than an hour are deleted. These values are configurable. See <add link> for more information. 
   
Types of Queries
-------------------- 
Here are the types of queries you can use.

| Type              | Description                                                                                                                                                                                                                                                               |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Scheduled queries | As the name suggests, scheduled queries run periodically to fetch the specified data for you. After the PolyLogyx client is provisioned and the connection to the PolyLogyx server is established, predefined queries are run to pull relevant information for each node. |
| Query packs       | A pack is a collection of queries. It allows you to logically group queries into categories. Once defined, you can run all queries included in a pack simultaneously.                                                                                                     |
| Queries           | A query is an individual request for data from a table or collection of tables. Define an individual query, as needed, to fetch data for nodes.                                                                                                                           |
| Live Queries      | A Live Query is suitable to meet your immediate and infrequent needs. It gives you a current snapshot of the nodes.                                                                                                                                                       |

Scheduled Queries 
-------------------- 
These out-of-box queries run frequently (as defined for the query) to fetch data from the nodes and require no configuration. 

### Manage Scheduled Queries
Perform these steps to view or edit this configuration:
1. Access the web interface for the server.
2. Navigate to CONFIG MANAGEMENT  > Config.

   ![configs_menu](https://github.com/preetpoly/test/blob/pooja/configs_menu.png)

   The page lists the predefined queries available for Windows, Linux, and Apple.  
3. Select an operating system, such as Windows.

   ![configs_list_new](https://github.com/preetpoly/test/blob/pooja/configs_list_new2.png)

4. Review the predefined queries applied on the Windows endpoints. 
5. Deselect a query to remove it from the applied client configuration. 
6. Optionally, modify the interval for a query to specify how often the query is run. The time duration (in seconds) specifies the duration after which the query is run on the client and query results are pushed to the server. 


