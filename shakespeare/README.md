Text Search with Elasticsearch

Searching natural language documents, based on [this tutorial](https://www.elastic.co/guide/en/kibana/6.8/tutorial-load-dataset.html)

Elasticsearch is a search engine with powerful analytics capabilities. We use it to demonstrate basics of a document database and the additional capabilities that the full text search capability provides.

# Components

- Elasticsearch - the server
- Kibana - a UI for issuing queries (amongst other things)

# Steps

We will run both Elasticsearch and Kibana.

## Run Elasticsearch

`run_elasticsearch.sh` will run Elasticsearch in a Docker container. You can access the server through [http://localhost:9200](http://localhost:9200).

Before running the server, the script will create a dedicated docker network and label it `elasticsearch`. We will use this network to connect Kibana.

## Run Kibana

`run_kibana.sh` will run the Kibana server on the `elasticsearch` docker network. It overrides the `ELASTICSEARCH_HOSTS` environment variable to tell Kibana how to connect to the server. The server was given a `name` of `search-server`, so Kibana can find it by that name on the docker network.

You can find Kibana on [http://localhost:5601](http://localhost:5601).

## Fetch and load a dataset of Shakespeare speeches into Elasticsearch

`get_dataset.sh` will fetch a sample dataset provided by Elasticsearch. The dataset is formatted for loading into Elasticsearch.

`load_dataset.sh` takes that dataset and loads it into the search server, after applying `mapping.json` to tell Elasticsearch how to process, or 'index' the fields defined in the shakespeare documents.

See the 'text_entry' field definition in the mapping.json file.

# Queries

A document by ID
```json
GET /shakespeare/_doc/36089
```

All speeches mentioning "yorick" (two matches)
```json
GET /shakespeare/_search
{
  "query": {
    "simple_query_string": {
      "fields": ["text_entry"], 
      "query": "yorick"
    }
  }
}
```

Looking for "Alas, poor Yorick, I knew him well" (216 matches)
```json
GET /shakespeare/_search
{
  "query": {
    "simple_query_string": {
      "fields": ["text_entry"], 
      "query": "alas yorick"
    }
  }
}
```

Alternative search for "...Yorick, I knew him well", demonstrating stemming
```json
GET /shakespeare/_search
{
  "query": {
    "simple_query_string": {
      "fields": ["text_entry"], 
      "query": "knowing yorick"
    }
  }
}
```

Handling misspelling with fuzzy matching
```json
GET /shakespeare/_search
{
  "query": {
    "fuzzy": {
      "text_entry": {
        "value": "yorisk"
      }
    }
  }
}
```

Significant terms in each play
```json
GET /shakespeare/_search
{
  "size": 0,
  "aggregations": {
    "plays": {
      "terms": {
        "field": "play_name"
      },
      "aggregations": {
        "significant_terms": {
          "significant_terms": {
            "field": "text_entry"
          }
        }
      }
    }
  }
}
```

Analyze a term using different analyzers - see stemming, stopwords

```json
GET /_analyze
{
  "analyzer" : "standard",
  "text" : "alas knowing the yorick"
}
```

```json
GET /_analyze
{
  "analyzer" : "english",
  "text" : "alas knowing the yorick"
}
```
