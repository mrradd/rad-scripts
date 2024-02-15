from pydoc import replace
from FileUtils import readFile
from EnvUtils import getVarNames
import os


def runTest():
    print("~Current dir: " + os.getcwd())
    file_name = "TestPkg/test/test.env"
    print(readFile(file_name))
    return 0

def runEnvCompareTest():
    print()
    
    env_name = "TestPkg/test/test.env"
    env_content = readFile(env_name)
    print(env_content)
    print("\n___\n")

    env_loc_name = "TestPkg/test/test.env.loc"
    env_content = readFile(env_loc_name)
    var_name_list=getVarNames(env_content)
    
    print(var_name_list)
    return 0
