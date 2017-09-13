import sys

#input is .fastq file
with open(sys.argv[1],'r') as f:
    lineno = 0
    symbol=[]
    for l in f:
        lineno+=1
        symbol.append(l[0])
        if len(symbol) == 4:
            if symbol.count("@") != 1:
                print(lineno)
                print(symbol)
                break
            else:
                symbol = []
