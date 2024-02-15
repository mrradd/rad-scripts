#This file contains the functions to read and write files.
'''
readFile
---
Reads the content of a file with the given file_name and returns it as a string.
---
param: file_name - The name of the file to read.
returns: The content of the file as a string.
'''
def readFile(file_name):
    output = "~NO OUTPUT PROVIDED~"
    with open(file_name, "r") as file:
        output = file.read()
    return output