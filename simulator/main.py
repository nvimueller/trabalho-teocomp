# simulador de duas fitas

def main():
    word = list(input("insira uma palavra na fita: ").strip())
    machine, table = buildmachine()
    print(machine)
    print("")
    
    for i in table:
        print(i)
    print("")
    
    runmachine(machine, table, word)

# rewritten
def buildmachine():
    file = open("machine.mt", "r")
    machine = dict()
    data = [line.strip() for line in file.readlines()]
    file.close()
    
    machine["alphabet"] = data[0].strip().split(",")
    machine["auxalphabet"] = data[1].strip().split(",")
    machine["empty"] = data[2].strip()
    machine["states"] = data[3].strip().split(",")
    machine["initialstate"] = data[4].strip()
    machine["finalstates"] = data[5].strip().split(",")
    
    table = []
    
    for i in range(6, len(data)):
        line = data[i].split(",")
        tran = dict()
        tran["curstate"] = line[0]
        tran["curchar1"] = line[1]
        tran["curchar2"] = line[2]
        tran["nextstate"] = line[3]
        tran["nextchar1"] = line[4]
        tran["nextchar2"] = line[5]
        tran["movement1"] = line[6]
        tran["movement2"] = line[7]
        table.append(tran)

    return machine, table

# rewritten
def maketape(word):
    tape = list()
    for char in word:
        tape.append(char)
    return tape

# rewritten
def makestate(machine, tape):
    state = dict()
    state["headpos1"] = 0
    state["headpos2"] = 0
    state["curstate"] = machine["initialstate"]
    state["curchar1"] = tape[0]
    state["curchar2"] = machine["empty"]
    state["movement1"] = ""
    state["movement2"] = ""
    state["done"] = False
    return state

# rewritten
def transition(table, state):
    found = False
    for tran in table:
        if tran["curstate"] == state["curstate"] and tran["curchar1"] == state["curchar1"] and tran["curchar2"] == state["curchar2"]:
            state["curstate"] = tran["nextstate"]
            state["curchar1"] = tran["nextchar1"]
            state["curchar2"] = tran["nextchar2"]
            
            match tran["movement1"]:
                case "L":
                    state["movement1"] = "L"
                case "R":
                    state["movement1"] = "R"
                case "S":
                    state["movement1"] = "S"
            
            match tran["movement2"]:
                case "L":
                    state["movement2"] = "L"
                case "R":
                    state["movement2"] = "R"
                case "S":
                    state["movement2"] = "S"
            
            found = True
            break

    if found == False:
        state["done"] = True
        return state
    else:
        return state

# rewritten
def updateheadpos(state):
    if state["movement1"] == "R":
        state["headpos1"] += 1
    if state["movement1"] == "L":
        state["headpos1"] -= 1
    if state["movement1"] == "S":
        state["headpos1"] += 0

    if state["movement2"] == "R":
        state["headpos2"] += 1
    if state["movement2"] == "L":
        state["headpos2"] -= 1
    if state["movement2"] == "S":
        state["headpos2"] += 0

    return state

# rewritten
def runmachine(machine, table, word):
    tape1 = maketape(word) 
    tape2 = ["-"]
    state = makestate(machine, tape1)
    indefinitestate = False
    
    while(not indefinitestate):

        state = transition(table, state)
        
        if state["done"]:
            indefinitestate = True
            break
        else:
            tape1[state["headpos1"]] = state["curchar1"]
            tape2[state["headpos2"]] = state["curchar2"]
           
            state = updateheadpos(state)
            
            if state["headpos1"] == -1:
                tape1.insert(0, (machine["empty"]))
                state["headpos1"] = 0
            elif state["headpos1"] == (len(tape1) - 1):
                tape1.append(machine["empty"])

            if state["headpos2"] == -1:
                tape2.insert(0, (machine["empty"]))
                state["headpos2"] = 0
            elif state["headpos2"] == (len(tape2) - 1):
                tape2.append(machine["empty"])
            
            state["curchar1"] = tape1[state["headpos1"]]
            state["curchar2"] = tape2[state["headpos2"]]

            print("STATE AFTER TRANSITION ", state)
    
    print("CURSTATE ", state["curstate"])
    print("FINALSTATES ", machine["finalstates"])
    print(state["curstate"] in machine["finalstates"])

    if state["curstate"] in machine["finalstates"]:
        print("WORD ACCEPTED")
    else:
        print("WORD REJECTED")
    print(tape1)
    print(tape2)

main()
