global_stored = {}
def Tribonacci(n)
	if global_stored[n] != nil
		return global_stored[n]
	end
	current = 0
	currentValue = 0
	while current < n
		currentValue += Tribonacci(current)
		current += 1
	end
	global_stored[n] = currentValue
	return currentValue
end