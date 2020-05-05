File Acquisition (Carves)
======================

For investigative purposes, you can fetch any file from the managed endpoints to the PolyLogyx server. You can fetch files by using Live queries. You can fetch a single file or a batch of files based on specified criteria. 

Perform these steps to acquire files.

1. Run a [Live query](../06_Queries_and_packs#live-queries). 
2. On the Live Query Builder page, specify the query. 

    1. To fetch a single file from an endpoint, use the following syntax to build your query. 

    ``` select * from carves where path like '/file/path/%' and carve=1;``` 
    
    In the syntax, */file/path/%* represents the file path.

    2. To fetch one or more files that meet a specified criteria, use the following syntax to build your query. 

    ``` select carve(path) from file where directory like '/dir_path/%/Downloads/' and mode='0755' and type == 'regular';``` 
    
    In the syntax, */dir_path/%/Downloads/* represents the directory path, mode represents the file permissions on UNIX and type indicates the file type. You can use other file properties, as needed, to fetch the files. 
    
3. Navigate to the SOC Operations | Carves to open the Carves page.
4. Review the acquired files. Click a file name to download the file.    

***Note:*** Configuration to enable this functionality is included in the osquery.flags file. The following parameters are added to the file. 
 ```
 --disable_carver=false
--carver_block_size=300000
--carver_start_endpoint=/start_uploads
--carver_continue_endpoint=/upload_blocks
--carver_disable_function=false
 ```

|										|																							|
|:---									|													   								    ---:|
|[Previous << Alerts](../08_Alerts/Readme.md)  | [Next >> Using Response Action](../10_Responses/Readme.md)|



