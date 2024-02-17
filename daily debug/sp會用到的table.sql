--查看DB以下的sp執行時會關連到的table
SELECT OBJECT_NAME(referencing_id) AS referencing_entity_name, 
       o.type_desc AS referencing_desciption, 
       COALESCE(COL_NAME(referencing_id, referencing_minor_id), '(n/a)') AS referencing_minor_id, 
       referencing_class_desc,
       referenced_entity_name,
       isnull(o2.type_desc,'') AS referenced_desciption, 
       referenced_server_name, 
       referenced_database_name, 
       referenced_schema_name, 
       COALESCE(COL_NAME(referenced_id, referenced_minor_id), '(n/a)') AS referenced_column_name,
       o.type AS referencing_type,
       is_caller_dependent, 
       is_ambiguous
FROM sys.sql_expression_dependencies AS sed
JOIN sys.objects AS o ON sed.referencing_id = o.object_id
left JOIN sys.objects AS o2 ON sed.referenced_entity_name = o2.name
where referenced_database_name is not null --and o.type_desc='USER_TABLE'
order by 1
