from pydoc import replace
from FileUtils import readFile
from EnvUtils import getEnvVarsSorted, getMissingEnvVars
import os

def runTest():
    print("~Current dir: " + os.getcwd())
    file_name = "TestPkg/test/test.env"
    print(readFile(file_name))
    return 0

def runEnvCompareTest():
    env_name_str = "TestPkg/test/test.env"
    env_content_str = readFile(env_name_str)

    env_loc_name_str = "TestPkg/test/test.env.loc"
    env_loc_content_str = readFile(env_loc_name_str)
    
    env_dic=getEnvVarsSorted(env_content_str)
    loc_dic=getEnvVarsSorted(env_loc_content_str)
    
    print("Variables in 'test.env' but not 'test.env.loc': ", getMissingEnvVars(env_dic, loc_dic))
    print("Variables in 'test.env.loc' but not 'test.env': ", getMissingEnvVars(loc_dic, env_dic))
    return 0
