#!/bin/bash
# report version for all relevant tools included in MG-RAST appliance.
# output to be pasted at the bottom of the README document

# run commands in the pipeline container with version
version=$1

# list of tools manually installed
TOOLS=(
'cd-hit -v | head -1  |  cut -f4 -d\  '
'fastq-mcf -h | head -2 | tail -1 | cut -f2 -d\   '
'cwl-runner --version | cut -f2 -d\   '
'prodigal -v 2>&1 | fgrep -i prodigal | cut -f2 -d\   | cut -f1 -d: '
'bowtie2 --version | head -1 | cut -f3 -d\  '
'diamond --version 2>&1 | head -1 | tail -1 | cut -f2 -d\ '
'vsearch --version 2>&1 | head -1 | cut -f2 -d\  | cut -f1 -d, '
'fastq-mcf 2>&1 | head -2 | tail -1 | cut -f2 -d\  '
'sortmerna --version 2>&1 | fgrep version | cut -f5 -d\   | cut -f1 -d, '
'jellyfish --version | cut -f2 -d\  '
'blat - | head -1 | cut -f6 -d\  '
'superblat - | head -1 | cut -f6 -d\  '
)



# start a container
container_id=$(docker run -t -d "mg-rast/pipeline:${version}")
if [ -z ${container_id} ]
then
  echo "no container running; please check your container environment"
  exit 1
fi

echo "#manually installed tools"

# walk thru list of tools with commands for version extraction
for line in "${TOOLS[@]}"
do
  name=$(echo ${line} | awk ' { print $1 } ')
  # tools installed using package manager
  vers=$(docker exec ${container_id} bash -c "${line}")
echo "${name} = ${vers}"
done

####
#
base=$(fgrep FROM Dockerfile | awk ' { print $2 } ')

echo "#Package manager installed tools (baseimage = ${base})"

# list all manually installed package versions
list=$(docker exec ${container_id} bash -c "apt-mark showmanual ")
for i in $list
do
  vers=$(docker exec ${container_id} dpkg -s $i| fgrep Version | awk ' { print $2 }')
  echo "$i = $vers"
done

# remove dangling container
docker kill ${container_id} >/dev/null
