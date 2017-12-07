global class iCustomIterator implements iterable<Email_Entry__c> {
	global Iterator<Email_Entry__c> Iterator(){
		return new CustomIterator();
	}
}
