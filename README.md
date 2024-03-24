# Digitalocean-DDNS
digitalocean ddns shell script




digitalocean 官方提供了 API接口用于实现对自定义域名即domain records的操作，都在https://docs.digitalocean.com/reference/api/api-reference/ 中描述。

# 对于List All Domain Records，

官方介绍To get a listing of all records configured for a domain, send a GET request to /v2/domains/DOMAIN_NAME/records. The list of records returned can be filtered by using the name and type query parameters. For example, to only include A records for a domain, send a GET request to /v2/domains/DOMAINNAME/records.Thelistofrecordsreturnedcanbefilteredbyusingthenameandtypequeryparameters.Forexample,toonlyincludeArecordsforadomain,sendaGETrequestto/v2/domains/DOMAIN_NAME/records?type=A. name must be a fully qualified record name. For example, to only include records matching sub.example.com, send a GET request to /v2/domains/DOMAIN_NAME/records?name=sub.example.com. Both name and type may be used together. 

官方提供的示例代码如下：

curl−XGET −H"Content−Type:application/json" −H"Authorization:BearerDIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/domains/example.com/records"

# 对于Create a New Domain Record，

官方介绍To create a new record to a domain, send a POST request to /v2/domains/$DOMAIN_NAME/records.

The request must include all of the required fields for the domain record type being added.

See the attribute table for details regarding record types and their respective required attributes.

官方提供的示例代码如下：

curl -X POST
-H "Content-Type: application/json"
-H "Authorization: Bearer $DIGITALOCEAN_TOKEN"
-d '{"type":"A","name":"www","data":"162.10.66.0","priority":null,"port":null,"ttl":1800,"weight":null,"flags":null,"tag":null}'
"https://api.digitalocean.com/v2/domains/example.com/records"

# 对于Retrieve an Existing Domain Record，

官方介绍To retrieve a specific domain record, send a GET request to /v2/domains/DOMAIN_NAME/records/DOMAIN 
NAME/records/RECORD_ID.

官方提供的示例代码如下：curl -X GET
-H "Content-Type: application/json"
-H "Authorization: Bearer $DIGITALOCEAN_TOKEN"
"https://api.digitalocean.com/v2/domains/example.com/records/3352896"

# 对于Update a Domain Record，

官方介绍To update an existing record, send a PUT request to /v2/domains/DOMAIN_NAME/records/DOMAIN 
NAME/records/DOMAIN_RECORD_ID. Any attribute valid for the record type can be set to a new value for the record.

See the attribute table for details regarding record types and their respective attributes.

官方提供的示例代码如下：curl -X PUT
-H "Content-Type: application/json"
-H "Authorization: Bearer $DIGITALOCEAN_TOKEN"
-d '{"name":"blog"}'
"https://api.digitalocean.com/v2/domains/example.com/records/3352896"

# 对于Delete a Domain Record，

官方介绍To delete a record for a domain, send a DELETE request to /v2/domains/DOMAIN_NAME/records/DOMAIN 
NAME/records/DOMAIN_RECORD_ID.

The record will be deleted and the response status will be a 204. This indicates a successful request with no body returned.

官方提供的示例代码如下：curl -X DELETE
-H "Content-Type: application/json"
-H "Authorization: Bearer $DIGITALOCEAN_TOKEN"
"https://api.digitalocean.com/v2/domains/example.com/records/3352896"

# 结果
那么，请   https://tongyi.aliyun.com/qianwen  根据官方api介绍，编写bash脚本，用于实现sub.domain.com的动态域名解析（DDNS）的自动化更新，即查询本机的IPV6地址与digitalocean云记录做比对后更新最新的cname指向。AI代码请参考ddns.sh。
