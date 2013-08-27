HipChat User Status Logs
=======================

A quick and dirty app for collecting users statuses from HipChat and logging them to a database. Ugly, but it works. Built to run as a scheduled IronWorker task. 

Expects a `credentials.json` file with properties `mongoUri` and `hipchatApiKey`. 
