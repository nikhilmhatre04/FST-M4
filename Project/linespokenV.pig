--Load input file from HDFS
inputFile = LOAD 'hdfs://user/inputfiles/episodeV_dialouges.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);

ranked = RANK inputFile;

onlydialouges = FILTER ranked BY (rank_inputFile > 2);

groupbyname = GROUP onlydialouges BY name;

names = FOREACH groupbyname GENERATE $0 as name, COUNT($1) as number;

-- Order data
order_data = ORDER names BY number DESC;

-- Store the result in HDFS
STORE names INTO 'hdfs://user/results/episodeV_dialouges';