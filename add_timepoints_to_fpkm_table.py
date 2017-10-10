import os,glob,shutil

def writeme(in_file,outfile,firstline):            
    with open(in_file,"r") as f, open(outfile,"w") as g:
        f.readline()
        g.write(firstline)
        shutil.copyfileobj(f,g)

for d in glob.glob("results*"):
    if os.path.isdir(d):
        malfile=os.path.join(d,"fpkm_mal/genes.fpkm_table")
        maltimeseries=os.path.join(d,d + "_mal_timeseries.tsv")
        humfile=os.path.join(d,"fpkm_hum/genes.fpkm_table")
        humtimeseries=os.path.join(d,d + "_hum_timeseries.tsv")
        if "18" not in d:
            firstline = "tracking_id\t0\t3\t6\t9\t12\t15\t18\t21\t24\t27\t30\t33\t36\t39\t42\t45\n"
        else:
            firstline = "tracking_id\t0\t3\t6\t9\t12\t15\t18\t21\t27\t30\t33\t36\t39\t42\t45\n"
        writeme(malfile,maltimeseries,firstline)
        writeme(humfile,humtimeseries,firstline)


