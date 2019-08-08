
# MG-RAST (https://mg-rast.org) metagenomic analysis pipeline appliance

## Purpose
This is a software appliance that is intended to be used with the MG-RAST CWL pipeline. The pipeline is contained in the repository

While we welcome third-party re-use of this appliance we note that we are not resourced to provide assistance.

## How to run the pipeline
cwl_runner workflow.cwl jobsfile

Example:
TBA

## obtain provenance trail for result files via CWLprov
TBA

## How to run in a cluster or "on the cloud"
TBA

## build your own version pipeline
```bash
# define a version number
Version=2.0.2
# clone the repository
git clone https://github.com/MG-RAST/pipeline.git
# build a container with your version number
docker build -t mg-rast/pipeline:${Version}  .
# report the versions of the tools and libraries in the container
bash build_bin/version_report.sh 2.0.2
```
