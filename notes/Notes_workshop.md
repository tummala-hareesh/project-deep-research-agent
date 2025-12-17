# Notes during Workshop
- Title: Durable Agentic Workflows with `Temporal.io`
- Link to Workshop: https://github.com/alexeygrigorev/workshops/tree/main/temporal.io
- DataTalks.Club Podcasts
    - 150+ podcasts over 5 years
    - https://www.youtube.com/playlist?list=PL3MmuxUbc_hK60wsCyvrEK2RjQsUi4Oa_
    - Not convenient to go through all the podcasts 
    - Agent to help us Answers based on the podcasts 

## Prerequisites
    - Python 3.13
    - Docker (for running Elastic search)
    - uv package management

## Two components of the Workshop
    - 1. Data ingestion - Extract transcripts from youtube video for elastic search
    - 2. Data from elastic search for the Agent 

## Environment setup
```
# Install python3.13, if not present (Linux - ubuntu)
sudo apt install python3.13-full
```

```
# Install uv
wget -qO- https://astral.sh/uv/install.sh | sh
source $HOME/snap/code/212/.local/share/../bin/env
uv --version
```

```
# Empty flow folder for data ingestion scrip
mkdir src/flow
cd src/flow


# Setup env. using uv
uv init --python=3.13
```

### Fetching youtube transcripts
- [Youtube Transcripts API](https://pypi.org/project/youtube-transcript-api/) and jupyter notebook 
- youtube Transcripts API overview:
    - Python API
    - Get the Transcripts/Subtitles for a given youtube video
    - Works for automatically generated subtitles, supports translating subtitles
    - Doesn't require a headless browser, like other selenium based solutions!
```
uv add youtube-transcript-api
uv add --dev jupyter
```

- Add ElasticSearch 
```
uv add elasticsearch
```

- Run jupyter 
```
uv run jupyter
```

### Elastic Search as docker 
```
docker run -it \
  --rm \
  --name elasticsearch \
  -m 4GB \
  -p 9200:9200 \
  -p 9300:9300 \
  -v elasticsearch-data:/usr/share/elasticsearch/data \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=false" \
  docker.elastic.co/elasticsearch/elasticsearch:9.2.0
```

#### Fix Docker Daemon socket Error
- Update docker 
```
# Update existing package list
sudo apt update

# Install necessary packages
sudo apt install ca-certificates curl gnupg software-properties-common
```

- Create docker user group
```
sudo groupadd docker
```

- Add user to the group
```
sudo usermod -aG docker $USER
```

- Apply changes 
```
newgrp docker
```

- Test docker
```
docker run hello-world
```

- Test if the Elastic Search continer is working 
```
curl http://localhost:9200
```

## Fetch all Transcripts Data into local data/ folder 
- [data](https://github.com/alexeygrigorev/workshops/tree/main/temporal.io/data/)
- Processing large data faces PROXY issues
    - 


## Convert notebook into script 
```
uv run jupyter nbconvert --to=script workflow.ipynb
```

## Temporal.io in the picture 
- A reliable way to `orchestrate workflows with retry logic and durable execution`.
    - Durable execution: Workflows survive crashes and restarts
    - Built-in retries: Automatic retry policies with backoff
    - State management: No need to manually track progress
    - Visibility: Web UI to monitor workflow execution
    - Concurrency control: Easy to manage parallel execution

### Temporal Activities 
- `Activities` = individual units of work that a Temporal workflow performs. 
- Tasks we do in this workflow:
    - Interacting with exxternal systems (e.g: making API calls)
    - Writing data to database
    - Sending email or notification
    - Processing files, images or business logic 
- Annotate with `@activity.defn`

### Temporal Workflows
- Activities are executed in a workflow.
- Annotated with `@workflow.defn`


### Install Temporal 
- https://github.com/alexeygrigorev/workshops/blob/main/temporal.io/temporal-install.md


## Creating a Basic Research Agent
- Agent with `Pydantic AI`
- 

