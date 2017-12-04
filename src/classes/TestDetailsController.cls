public with sharing class TestDetailsController {

	@AuraEnabled
	public static List<Step__c> getSteps(Test_Case__c tc){
		return [SELECT Name, Description__c, Expected_Result__c, Test_Case__c FROM Step__c WHERE Test_Case__c = :tc.Id LIMIT 10000];
	}

}
