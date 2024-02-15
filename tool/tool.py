# This app is a tool to help make things a bit easier for managing dev tasks.
from TestPkg.Test import runTest, runEnvCompareTest

'''
main
---
Main entry point for the tool.
'''
def main():
    print("~Running the tool.\n")
    
    runEnvCompareTest()
    
    print("\n~Ending the tool.")

main()
