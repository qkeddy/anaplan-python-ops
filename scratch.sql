SELECT *  FROM events e;  WHERE e."additionalAttributes.actionId" = 116000000000 ;

SELECT count(*) FROM events e ;

SELECT * FROM users u;

SELECT * FROM workspaces w --where w.id = "8a868cd9837162ef0183cd4d7ba842c0" ;

SELECT * FROM act_codes ac ;

SELECT * FROM cloudworks c ;

SELECT * from models m  --where id = "295D98F37F1B4682BE7A29035CBFB924";

SELECT * from actions a --WHERE id = 116000000000;

SELECT printf("%.0f", e.id) as id, e.eventTypeId  , e.userId, u.userName, u.displayName, e.tenantId, e.objectId, e.message, e.success, e.errorNumber, e.ipAddress, e.userAgent, e.sessionId, e.hostName, e.serviceVersion, e.eventDate, e.eventTimeZone, e.createdDate, e.createdTimeZone, e.checksum, e.objectTypeId, e.objectTenantId, e."additionalAttributes.workspaceId", e."additionalAttributes.actionId", e."additionalAttributes.name", e."additionalAttributes.type", e."additionalAttributes.auth_id"  
FROM events e 
left JOIN users u ON e.userId = u.id; 

SELECT 
	printf("%.0f", e.eventDate / 1000) || printf("%06d", e.[index] ) as LOAD_ID ,
	e.id as AUDIT_ID , 
	e.eventTypeId as EVENT_ID , 
	ac.[Event Message] as EVENT_MESSAGE , 
	ac.[Associated Object Id] as ASSOCIATED_OBJECT_ID, 
	ac.Notes as NOTES , 
	e.userId as USER_ID , 
	u.userName as USER_NAME , 
	u.displayName as DISPLAY_NAME , 
	e.tenantId as TENANT_ID , 
	"Quin Eddy Employee Tenant" as TENANT_NAME , 
	e."additionalAttributes.workspaceId" as WORKSPACE_ID , 
	w.name as WORKSPACE_NAME ,
	CASE 
		WHEN e."additionalAttributes.modelId" IS NOT NULL THEN e."additionalAttributes.modelId"
		WHEN e.objectId = cw.integrationId THEN cw.modelId
	END as MODEL_ID ,
	CASE 
		WHEN e."additionalAttributes.modelId" IS NOT NULL THEN m.name
		WHEN e.objectId = cw.integrationId THEN (SELECT  m3.name FROM cloudworks c INNER JOIN models m3 ON c.modelId = m3.id)  
	END as MODEL_NAME ,
	e.objectId as OBJECT_ID ,
	CASE 
		WHEN e.objectId = m2.id THEN "Model"
		WHEN e.objectId = cw.integrationId THEN "CloudWorks Integration"
		WHEN e.objectId = u2.id  THEN "User"
	END as OBJECT_TYPE ,
	CASE 
		WHEN e.objectId = m2.id THEN m2.name
		WHEN e.objectId = cw.integrationId THEN cw.name 
		WHEN e.objectId = u2.id  THEN u2.userName 
	END as OBJECT_NAME ,
	e.message as MESSAGE , 
	e.success as SUCCESS, 
	e.errorNumber as ERROR_NUMBER , 
	e.ipAddress as IP_ADDRESS , 
	e.userAgent as USER_AGENT , 
	e.sessionId as SESSION_ID , 
	e.hostName as HOST_NAME , 
	e.serviceVersion as SERVICE_VERSION , 
	datetime(e.eventDate/1000 , 'unixepoch') as EVENT_DATE ,
	e.eventTimeZone as EVENT_TIMEZONE , 
	datetime(e.createdDate/1000 , 'unixepoch') as CREATED_DATE ,
	e.createdTimeZone as CREATE_TIMEZONE , 
	e.objectTypeId as OBJECT_TYPE_ID , 
	e.objectTenantId as OBJECT_TENANT_ID , 
	e."additionalAttributes.actionId" AS ACTION_ID ,
	CASE 
		WHEN e."additionalAttributes.actionId" IS "-1" THEN "Unsaved Action" 
		WHEN a.name IS NULL AND e."additionalAttributes.actionId" IS NOT NULL THEN "<Object has been Deleted>"
		ELSE a.name 
	END AS ACTION_NAME ,
	e."additionalAttributes.name" as ADDITIONAL_ATTRIBUTES_NAME , 
	e."additionalAttributes.type" as ADDITIONAL_ATTRIBUTES_TYPE , 
	e."additionalAttributes.auth_id" as ADDITIONAL_ATTRIBUTES_AUTH_ID ,
	e."additionalAttributes.modelRoleName" as MODEL_ROLE_NAME ,
	e."additionalAttributes.modelRoleId" as MODEL_ROLE_ID ,
	e."additionalAttributes.objectTypeId" as ADDITIONAL_ATTRIBUTES_OBJECT_TYPE_ID , 
	e."additionalAttributes.roleId" as ADDITIONAL_ATTRIBUTES_ROLE_ID , 
	e."additionalAttributes.roleName" as ADDITIONAL_ATTRIBUTES_ROLE_NAME ,
	e."additionalAttributes.objectTenantId" as ADDITIONAL_ATTRIBUTES_OBJECT_TENANT_ID ,
	e."additionalAttributes.objectId" as ADDITOINAL_ATTRIBUTES_OBJECT_ID ,
	e."additionalAttributes.active" as ADDITIONAL_ATTRIBUTES_ACTIVE ,
	e.checksum as CHECKSUM
FROM events e 
LEFT JOIN users u ON e.userId = u.id
LEFT JOIN users u2 ON e.objectId = u2.id 
LEFT JOIN workspaces w ON e."additionalAttributes.workspaceId" = w.id 
LEFT JOIN models m ON e."additionalAttributes.modelId" = m.id 
LEFT JOIN models m2 ON e.objectId = m2.id
LEFT JOIN cloudworks cw on e.objectId = cw.integrationId 
LEFT JOIN act_codes ac on e.eventTypeId = ac.[Event Code]
LEFT JOIN actions a on e."additionalAttributes.actionId" || e.objectId  = a.id || a.model_id  ;
WHERE OBJECT_ID = "81a2d77de57045719b363bf7884fe68c" ;




SELECT LOAD_ID, COUNT(*) c FROM events GROUP BY DataId HAVING c > 1;

SELECT * from events e ;



pragma table_info (events);

select DISTINCT eventTypeId from events e ;

DROP table actions ;