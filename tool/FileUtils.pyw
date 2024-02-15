def readFile(file_name):
    output = "derp"
    with open(file_name, "r") as file:
        output = file.read()
    return output