'''
getVarNames
---
Reads the content of an environment file and returns a list of the variable names.
---
param: env_content - the content of the environment file.
return: var_name_list - a list of the variable names.
'''
def getVarNames(env_content):
    var_list = env_content.splitlines()
    
    var_name_list=[]
    for elem in var_list:
        var_name_list.append(elem.split("=")[0])
        pass
    
    return var_name_list