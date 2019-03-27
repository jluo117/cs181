def printHi ()
	puts "hi"
	end
def printBye ()
	puts "bye"
end
def printSomething (myArg)
	myArg.call()
end
begin
printSomething(printHi)
end