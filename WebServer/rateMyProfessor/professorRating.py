'''
Created on Jan 28, 2015

@author: ksrinivas
'''
import urllib2,sys
import time, json
rmpUrl = "http://www.ratemyprofessors.com/filter/professor/?department=&institution=University+of+Southern+California&filter=teacherlastname_sort_s+asc&query=*%3A*&queryoption=TEACHER&queryBy=schoolId&sid=1381&page="
i = 1
professorData = []
while True:
    time.sleep(1)
    scrapedData = urllib2.urlopen(rmpUrl + str(i)).read()
    try:
        scrapedData = json.loads(scrapedData)
    except TypeError:
        print (scrapedData)
        sys.exit()
    except ValueError:
        print (scrapedData)
        sys.exit()
    i += 1
    for professor in scrapedData["professors"]:
        professor.pop("institution_name", None)
        professor.pop("contentType", None)
        professor.pop("categoryType", None)
    professorData.extend(scrapedData["professors"])
    if scrapedData["remaining"] == 0:
        break
with open('data.txt', 'w') as outfile:
    json.dump(professorData , outfile,indent = 4)