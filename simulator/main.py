def main():
    word = list(input().strip())
    machine = makemachine()
    runmachine(machine, word)

def makemachine():
    file = open("machine.mt", "r")
    machine = [line.strip() for line in file.readlines()]
    for i in range(len(machine)):
        machine[i] = machine[i].split(",")
    file.close()
    return machine

def runmachine(machine, word):
    tape = maketape(machine, word) 
    state = makestate(machine, tape)
    table = maketable(machine)
    indefinitestate = False
    while(not indefinitestate):
        state = transition(table, state)
        if state[4]:
            indefinitestate = True
            break
        else:
            tape[state[0]] = state[2]
            state = updateheadpos(state)
            
            # ver se precisa ajustar array
            if state[0] == -1:
                tape.insert(0, (machine[2][0]))
                state[0] = 0
            elif state[0] == (len(tape) - 1):
                tape.append(machine[2][0])
    if state[1] in machine[5]:
        print("WORD ACCEPTED")
    else:
        print("WORD REJECTED")
    print(tape) 

def updateheadpos(state):
    if state[0] == "R":
        state[3] += 1
    if state[3] == "L":
        state[0] -= 1
    return state

def makestate(machine, tape):
    headpos = 0
    curstate = machine[4][0]
    curchar = tape[0]
    move = ""
    done = False
    state = [headpos, curstate, curchar, move, done]
    return state

def maketape(machine, word):
    tape = list()
    for char in word:
        tape.append(char)
    return tape

def maketable(machine):
    table = list()
    numlines = len(machine)
    for i in range(6, numlines):
        line = machine[i]
        table.append(line)
    return table

def transition(table, state):
    found = False
    for line in table:
        if line[0] == state[1] and line[1] == state[2]:
            state[1] = line[2]
            state[2] = line[3]
            match line[4]:
                case "L":
                    state[3] = "L"
                case "R":
                    state[3] = "R"
            found = True
            break
    if found == False:
        state[4] = True
        return state
    else:
        return state

main()
