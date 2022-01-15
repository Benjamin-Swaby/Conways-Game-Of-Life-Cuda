import random as r

x = (0,1)

if __name__ == "__main__":

    directory = "./bin/map.mp"
    numbers = int(input("Enter How Many Times: "))

    #can be changed later but I don't want it fucking up my source code
    with open(directory, "w+") as f:
        for i in range(numbers):
            f.write(str(r.choice(x)))
        f.close()
    
    print(f"Written {numbers} numbers to {directory}")
