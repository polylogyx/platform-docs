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
![query_workflow](https://github.com/preetpoly/test/blob/master/query_workflow.png)

 

