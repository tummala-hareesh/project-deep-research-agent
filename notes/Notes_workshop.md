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

### Fix Docker Daemon socket Error
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