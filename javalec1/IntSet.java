public interface IntSet {
	/**
	  * Adds integer x to the set (if x is not already there)
	  * @param x   integer to add
	  */
	void insert(int x);
	/**
	  * Checks to see if x is a member of the set
	  * @param x   integer to check
	  * @return    whether x is a member of the set
	  */
	boolean ismember(int x);
}
