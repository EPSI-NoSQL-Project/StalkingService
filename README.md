# StalkingService

An API consumer and web crawler service using Ruby On Rails, Redis, ArangoDB and Elasticsearch.
If you want more details on how every databases are filled up, please refer to StalkingWorkerPool.

## Scenarii

You'll find below the different managed scenarii :

* The user wants to find someone. He begins to write down a name and a location.
An autocomplete system looks for the person in Elasticsearch thanks to an Ajax function.
Then it suggests a list of person corresponding to the name and the location.

* If the person is unknown, the user can click on "search" to indicate the system has to find this person.
The name and the location is save into Redis in a job "workers".

StalkingWorkerPool will work on this job and launch all the crawlers to find information about this new person.
The next time the user will ask for this person, the autocomple will suggest him.

* If the person is in the suggestion list, then we use Ruby to attack ArangoDB and retrive this person's information.
Finally, we present the data group by source.
Here is an exemple :

===

## Technical help

We kept default ports for each database. Here is the recap list :
- ArangoDB : 8529
- Redis : 6379
- Elasticserach : 9200
- StalkingService : 9393


If you want to add manually a person in Redis, here is the bash command :

> redis-cli

> LPUSH workers '{"name": "Name SURNAME", "location": "Bordeaux" }'

If you want to add manually a person in Elasticsearch, here is the bash command :
> curl -XPUT 'http://localhost:9200/people/person/9530004439' -d '{
    "name" : "Name SURNAME",
    "location" : "Bordeaux"
}'

To check out if the result, you can :
- use your navigator : http://localhost:9200/people/person/9530004439
- use a bash command : 

> curl -XGET 'http://localhost:9200/people/person/_search?q=name:Name+SURNAME'
