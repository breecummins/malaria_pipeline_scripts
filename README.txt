Procedure:

(1) Build the genomes for STAR from downloaded files. See build_genome.sh for the files that I used. I can provide them from DCC.

(2) Download malaria data to DCC. See download_from_dropbox.sh for downloading multiple files. 

Example call on DCC: 

screen -d -m srun --partition=harerlab --mem=0 --output=DBdownload.log ./down_load_dropbox.sh <linkfile.txt>

Example linkfile.txt:

[bc187@dcc-slogin-01 ~]$ cat /work/bc187/malariadataJuly2017/REDOWNLOAD_FOR_CHECKSUMS/Sample08links.txt 

https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AAA5kf8Tf15bPf7sZMTq2-sJa/Sample%208/08-01?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AAA1oN-vrLHB6p8FEGA4SzBxa/Sample%208/08-02?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AAAjOvX9NnBRKJjgZ-uWa-9xa/Sample%208/08-03?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AAAfcfjorm8mWh2exTKbj3SRa/Sample%208/08-04?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AACLA9sFmelkBd4ox1k7is1Ea/Sample%208/08-05?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AADn2qvzZHIRJDczdau6FNw9a/Sample%208/08-06?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AACnUTdd4T0Vm-bQGr9MLIIla/Sample%208/08-07?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AACrpHimGXfUD7Ah26lecYy4a/Sample%208/08-08?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AABFHGPSRXKkriwNVPvcYcFAa/Sample%208/08-09?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AABTBTiY13A6EWALdYKEPBgDa/Sample%208/08-10?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AADwvjRZFua_fXJ8Ap05OhI6a/Sample%208/08-11?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AACdiJXhsiJ7jdeWGjzfBC91a/Sample%208/08-12?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AAA4_Bzz4Go8JOf9xHAJDKsQa/Sample%208/08-13?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AACsSNKUNTOfTbzV5R-8yjkka/Sample%208/08-14?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AABQ7cREpQYgEvfxKR__oCAYa/Sample%208/08-15?dl=1
https://www.dropbox.com/sh/wmm0oo8sdd0fsro/AAAuMS4iskpLCRviPZlpUKwka/Sample%208/08-16?dl=1 

These links were found by right-clicking on a dropbox folder in a browser (like 08-01), copying the link, and changing the last digit from 0 to 1 (allows dropbox to hierarchically search the folder). 

(3) Double-check that all files were downloaded -- sometimes the download process chokes.

(4) Check the checksums of the downloaded files. Example script checksums.py and checksum file CoreChecksums.tsv. Example call on DCC:

[bc187@dcc-slogin-01 ~]$  cd <folder containing .fastq.gz files>
[bc187@dcc-slogin-01 ~]$  srun --pty bash
srun: job 11720788 queued and waiting for resources
srun: job 11720788 has been allocated resources
bc187@dcc-core-191  ~ $  python ~/GIT/malaria_pipeline_scripts/checksums.py <sample number>

The command srun --pty bash puts you in interactive SLURM. You may want to call screen instead as in earlier calls if the process takes too long to run.

After the procedure is done, be sure to check the checksums_failures.txt file for any files that failed the checksum test. checksum_successes.txt lists all the files that passed. Missing files probably failed to download.

(5) Make sure the data has a file hierarchy in which the 4 lanes for one time point are all in the same folder. Example:

[bc187@dcc-slogin-01 ~]$  ls /work/bc187/malariadataJuly2017/Sample02/02_01/

O2-01_S14_L005_R1_001.fastq.gz	O2-01_S14_L006_R1_001.fastq.gz	O2-01_S14_L007_R1_001.fastq.gz	O2-01_S14_L008_R1_001.fastq.gz

(6) Run the data for Sample X through STAR and cuffquant. Example call:

screen -d -m srun --partition=harerlab --mem=0 --output=<sample_number>.log ./mal_hum_analysis.sh <top level data dir>

Example argument: 

<top level data dir> = /work/bc187/malariadataJuly2017/Sample02

(7) CHECK THE OUTPUT LOGFILE <sample_number>.log. This is a very important step because the process will often complete even if there's an error. The file is long and tedious, but this needs to be done. Just scan through and look for the word 'error' or other confusing output. The following warning is normal:

Warning: Could not connect to update server to verify current version. Please check at the Cufflinks website (http://cufflinks.cbcb.umd.edu).

In previous versions of the script, there was also a common .bam error that was thrown because there was a .sam file as input. It would try the .bam format and fail, and then try the .sam format. Some of the uploaded log files have this error and it's OK. Since I stopped using the .sam format, this error has not appeared.

(8) Extract the abundances and final log files into a results folder. Example call:

cd <folder containing top level sample directory>
bash scrape_logs.sh <sample number>

Make this call in the top level directory for all the samples. Example:

[bc187@dcc-slogin-01 ~]$  ls /work/bc187/malariadataJuly2017

REDOWNLOAD_FOR_CHECKSUMS  results_Sample08	results_Sample09.zip  results_Sample11	    results_Sample13.zip  results_Sample17	results_Sample18.zip  Sample02	Sample10  Sample16  Sample19
results_Sample02	  results_Sample08.zip	results_Sample10      results_Sample11.zip  results_Sample16	  results_Sample17.zip	results_Sample19      Sample08	Sample11  Sample17
results_Sample02.zip	  results_Sample09	results_Sample10.zip  results_Sample13	    results_Sample16.zip  results_Sample18	results_Sample19.zip  Sample09	Sample13  Sample18

(9) Manually move the <sample_number>.log output file from the STAR/cuffquant process to the results folder.

(10) Run cuffnorm analysis. Example call:

cd <results folder>
screen -d -m srun --partition=harerlab --mem=0 --output=cuffnorm.log ~/GIT/malaria_pipeline_scripts/cuffnorm_analysis.sh

The log file is too horrible to view the whole thing by hand. However you can check if the process went to completion by using the commands 

head -20 cuffnorm.log
tail -20 cuffnorm.log

Any errors should show up in those two locations (I'm pretty sure), and the last lines of both commands should read "Writing run info." There are run.info files in each of the fpkm_mal and fpkm_hum folders, and these might catch errors too, although I never saw any.

(11) Now zip the results folder:

zip -r <results_folder>.zip <results_folder>

Then upload to dropbox. Usually I transfer the file to a local computer using scp and then upload via browser.



