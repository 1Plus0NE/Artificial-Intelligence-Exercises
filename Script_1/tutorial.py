def testString(s):
    if(s.islower()):
        print("This string" + s +"is lower")
    else:
        s = s.lower()
        print(s)
if __name__ == '__main__':
    print('Write a string: ')
    s = input()
    testString(s)