#!/bin/bash
az group create --name {{ __filename__ }} --location {{ __config__.azure.location }}
{% for email in teams %}
az role assignment create --role Contributor --assignee {{ email }} --resource-group {{ __filename__ }}
{% endfor %}
az role assignment list --resource-group {{ __filename__ }}