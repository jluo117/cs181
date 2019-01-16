int globalmult = 2;
static char zerochar = '0';
int manyreturns (int start, char digit){
	start = start + (digit - zerochar);
	return start * globalmult;
}
int main (int argc, char **argv){
	int storage = 10;
	storage = storage + manyreturns(storage,'4');
}