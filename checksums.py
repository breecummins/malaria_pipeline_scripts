import pandas as pd
import glob,subprocess,sys

# python md5 is known broken, hence shell call

df = pd.read_csv("CoreChecksums.tsv",sep="\t",index_col="Core checksum filename")
samp = sys.argv[1]

with open('checksum_failures.txt','a') as ff, open('checksum_successes.txt','a') as sf:
	for f in glob.glob("O"+str(samp)+"*.fastq.gz"):
		fmd5 = subprocess.check_output('md5sum '+f,shell=True).split()[0].decode("utf-8")
		if fmd5 != df.loc[f,'Core checksum']:
			print(df.loc[f,'Core checksum'])
			print(fmd5)
			ff.write(str((f,fmd5))+"\n")
		else:
			sf.write(str((f,fmd5))+"\n")



