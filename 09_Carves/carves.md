File Acquisition (Carves)
======================

For investigative purposes, you can fetch any file from the managed endpoints to the PolyLogyx server. You can fetch files by using queries. You can fetch a single file or a batch of files based on specified criteria. 


Run a [Live query](../06_Queries_and_packs#live-queries) to acquire the needed files.

1. To fetch a single file from an endpoint, use the following syntax. 

    ``` select * from carves where path like '/some/path/%' and carve=1;``` 

 2. To fetch one or more files that meet a specified criteria, use the following syntax. 

    ``` select carve(path) from file where directory like '/Users/%/Downloads/' and mode='0755' and type == 'regular';``` 

Configuration to enable this functionality is included in the osquery.flags file. The following parameters are added to the file. 
--disable_carver=false
--carver_block_size=300000
--carver_start_endpoint=/start_uploads
--carver_continue_endpoint=/upload_blocks
--carver_disable_function=false






