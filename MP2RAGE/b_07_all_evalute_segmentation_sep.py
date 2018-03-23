"""
Description: Convert EvaluateSegmentation XML outputs to simple tables.
To be set:
   -path to parent directory,
   -list with programme names used for initial segmentation
   -subject names
   -artifact flag
Input:
   -grey matter evaluation xml files
Output:
   -overview tables with results
Written by: Marian Schneider, Faruk Gulban

Dependency:
https://github.com/Visceral-Project/EvaluateSegmentation

Note1: assumes that evaluate segmentation file was run
Note2: this script uses seperate inputs from distance and overlap metrics
"""

import os
import re
import glob
import xmltodict
import pandas as pd
from tabulate import tabulate

# %%
# specify path to the directory
dirname = '/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE/'
# specify whether the fast or the spm table should be produced
switchList = ['cbs', 'fast']
# specify subject identifiers
subj = ['S001', 'S013', 'S014', 'S019']
# should the data be masked for artifacts?
artimask = True  # True or False

# %% collect all xml files and put their paths into a list
summary = []
for switch in switchList:
    # define dictionaries to collect contents of wildcards
    ideDst = {}
    ideOvl = {}
    # define lists to collect file names
    filesDst = []
    filesOvl = []

    for sub in subj:
        # get file path
        if not artimask:
            tempPath = os.path.join(dirname, sub, 'derived', '07_evaluation/')
        elif artimask:
            tempPath = os.path.join(dirname, sub, 'derived',
                                    '08_evaluation_artifact_masked/')

        # get a list of all files that are in path and fullfil the switch id
        tempLstDst = glob.glob(tempPath + switch + '*_dst.xml')
        tempLstOvl = glob.glob(tempPath + switch + '*_ovl.xml')

        filesDst.append(sorted(tempLstDst))
        filesOvl.append(sorted(tempLstOvl))

        # get a list with the contents of the wildcards this allows us to check
        # later whether contents are identicaL across subjs
        ideDst[sub] = []
        for item in tempLstDst:
            ideDst[sub].append(re.search(tempPath + switch + '(.*)_dst.xml',
                                         item).group(1))
        ideDst[sub].sort()

        ideOvl[sub] = []
        for item in tempLstOvl:
            ideOvl[sub].append(re.search(tempPath + switch + '(.*)_ovl.xml',
                                         item).group(1))
        ideOvl[sub].sort()
    # flatten the list files
    # flatten the list files
    filesDst = [val for sublist in filesDst for val in sublist]
    filesOvl = [val for sublist in filesOvl for val in sublist]
    # %%
    # check that dictionary values are equal across subjects
    # if not equal, throw an exception
    valsDst = [x == y for i, x in enumerate(ideDst.values()) for j, y in
               enumerate(ideDst.values()) if i != j]
    valsOvl = [x == y for i, x in enumerate(ideOvl.values()) for j, y in
               enumerate(ideOvl.values()) if i != j]
    if not all(valsDst + valsOvl):
        raise ValueError('Xml files differ across subjects \n' + str(ideOvl))

    # deduce the row labels
    labels = [switch + s for s in ideOvl.values()[0]]
    results = []
    count = 0
    for j in range(len(subj)):
        results.append([subj[j], '', '', '', '', '', '', ''])
        for i in range(len(filesOvl)/len(subj)):
            with open(filesOvl[count]) as fd1:
                doc1 = xmltodict.parse(fd1.read())
            with open(filesDst[count]) as fd2:
                doc2 = xmltodict.parse(fd2.read())

                count += 1

            dice = float(doc1['measurement']['metrics']['DICE']['@value'])
            avhd = float(doc2['measurement']['metrics']['AVGDIST']['@value'])
            sens = float(doc1['measurement']['metrics']['SNSVTY']['@value'])
            spec = float(doc1['measurement']['metrics']['SPCFTY']['@value'])
            accu = float(doc1['measurement']['metrics']['ACURCY']['@value'])
            prec = float(doc1['measurement']['metrics']['PRCISON']['@value'])

            results.append(['', labels[i],
                            "%.4f" % dice,
                            "%.4f" % avhd,
                            "%.4f" % sens,
                            "%.4f" % spec,
                            "%.4f" % accu,
                            "%.4f" % prec])

    # %% print table to look at in simple text format
    table = tabulate(results,  tablefmt='orgtbl',
                     headers=['', '', 'DICE', 'AVHD', 'SENS', 'SPEC', 'ACCU', 'PREC'])
    print(table)

    # %% print reduced table in latex format
    simple_results = []
    [simple_results.append(results[i][:4]) for i in range(len(results))]
    table = tabulate(simple_results,  tablefmt='latex',
                     headers=['', '', 'DICE', 'AVHD'])
    print(table)

    summary.append(simple_results)

# %% create common output table for all subjects and switches
# set keys
keys = ['', 'orig', 'orig + gramag', 'orig + simplex']
keys = keys * len(subj)
# assemble new reults list
joined = [[i[0]] + [j] + k[2:] + l[2:] for i, j, k, l in zip(summary[0], keys,
          *summary)]
joinedTable = tabulate(joined,  tablefmt='latex',
                       headers=['', '', 'DICE ' + switchList[0],
                                'AVHD ' + switchList[0],
                                'DICE ' + switchList[1],
                                'AVHD ' + switchList[1]])
print(joinedTable)

# %% load list into pandas data frame to calculate the mean and std

# convert joined table to pandas object
df = pd.DataFrame(data=joined, columns=['', '',
                                        'DICE'+switchList[0],
                                        'AVHD'+switchList[0],
                                        'DICE'+switchList[1],
                                        'AVHD'+switchList[1]],
                  index=keys)
# clean up the data frame
df = df.drop('', axis=0)
df = df.drop('', axis=1)
# convert string to floats
df = df.astype(float)

# calculate means across subjects
# select only orig
print("Show orig median:")
print df.iloc[::3].median()

# select only gramag
print("Show gramag median:")
print df.iloc[1::3].median()
# select only simplex
print("Show simplex median:")
print df.iloc[2::3].median()

# calculate stds across subjects
# select only orig
print("Show orig std:")
print df.iloc[::3].std()
# select only gramag
print("Show gramag std:")
print df.iloc[1::3].std()
# select only simplex
print("Show simplex std:")
print df.iloc[2::3].std()
