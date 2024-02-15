# This file contains utility functions for working with environment files (.env).
'''
getVarNames
---
Reads the content of an environment (.env) file and returns a list of the variable names. This assumes the syntax of
the .env file is "var_name=var_value".
---
param: env_content - The content of the environment file.
returns: A dictionary environment variables sorted by key. Key = variable name, Value = variable value.
'''
def getEnvVarsSorted(env_content):
    var_list = env_content.splitlines()
    sorted_list = sorted(var_list)
    
    env_var_list={}
    for elem in sorted_list:
        kv = elem.split("=");
        env_var_list[kv[0].strip()] = kv[1].strip()
        pass
    
    return env_var_list

'''
getMissingEnvVars
---
Compares two dictionaries of environment variables and returns a list of the variable names that are in the first, but
not the second.
---
param: first_dic - The first dictionary of environment variables to search for.
param: second_dic - The second dictionary of environment variables to search in.
returns: A list of the variable names that are in the first dictionary, but not the second.
'''
def getMissingEnvVars(first_dic, second_dic):
    first_keys = first_dic.keys()
    second_keys = second_dic.keys()
    not_found=[]
   
    for key in first_keys:
        if key not in second_keys:
            not_found.append(key)
        pass
    
    return not_found