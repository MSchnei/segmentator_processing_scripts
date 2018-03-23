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

Note: assumes that evaluate segmentation file was run
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
switchList = ['fast', 'cbs']
# specify subject identifiers
subj = ['S001', 'S013', 'S014', 'S019']
# should the data be masked for artifacts?
artimask = True  # True or False

# %% collect all xml files and put their paths into a list
summary = []
for switch in switchList:
    files = []
    ide = {}  # define dictionary to collect contents of wildcards
    for sub in subj:
        # get file path
        if not artimask:
            tempPath = os.path.join(dirname, sub, 'derived', '07_evaluation/')
        elif artimask:
            tempPath = os.path.join(dirname, sub, 'derived',
                                    '08_evaluation_artifact_masked/')

        # get a list of all files that are in path and fullfil the switch id
        tempLst = glob.glob(tempPath + switch + '*.xml')
        files.append(sorted(tempLst))

        # get a list with the contents of the wildcards this allows us to check
        # later whether contents are identicaL across subjs
        ide[sub] = []
        for item in tempLst:
            ide[sub].append(re.search(tempPath + switch + '(.*).xml',
                                      item).group(1))
        ide[sub].sort()
    # flatten the list files
    files = [val for sublist in files for val in sublist]

    # %%
    # check that dictionary values are equal across subjects
    # if not equal, throw an exception
    vals = [x == y for i, x in enumerate(ide.values()) for j, y in enumerate(
            ide.values()) if i != j]
    if not all(vals):
        print(ide)
        raise ValueError('Xml files differ across subjects \n' + str(ide))

    # deduce the row labels
    labels = [switch + s for s in ide.values()[0]]
    results = []
    count = 0
    for j in range(len(subj)):
        results.append([subj[j], '', '', '', '', '', '', ''])
        for i in range(len(files)/len(subj)):
            with open(files[count]) as fd:
                doc = xmltodict.parse(fd.read())
            count += 1

            dice = float(doc['measurement']['metrics']['DICE']['@value'])
            avhd = float(doc['measurement']['metrics']['AVGDIST']['@value'])
            sens = float(doc['measurement']['metrics']['SNSVTY']['@value'])
            spec = float(doc['measurement']['metrics']['SPCFTY']['@value'])
            accu = float(doc['measurement']['metrics']['ACURCY']['@value'])
            prec = float(doc['measurement']['metrics']['PRCISON']['@value'])

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
                       headers=['', '', 'DICE', 'AVHD', 'DICE', 'AVHD'])
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
print("Show orig means:")
print df.iloc[::3].mean()
# select only gramag
print("Show gramag means:")
print df.iloc[1::3].mean()
# select only simplex
print("Show simplex means:")
print df.iloc[2::3].mean()

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
