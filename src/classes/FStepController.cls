public with sharing class FStepController {

	@AuraEnabled
	public static void insertTestStep(Step__c step){

		Database.SaveResult sr = Database.insert(step);

	}

}
