public with sharing class TestDetailsController {

	@AuraEnabled
	public static List<Step__c> getSteps(Test_Case__c tc){
		return [SELECT Id, Name, Description__c, Expected_Result__c, Test_Case__c, Order__c FROM Step__c WHERE Test_Case__c = :tc.Id ORDER BY Order__c ASC LIMIT 10000];

	}

	@AuraEnabled
	public static List<Step__c> updateSteps(List<Step__c> steps, String tcId){
		Database.SaveResult[] srList = Database.update(steps);

		for(Database.SaveResult sr : srList){
			if(sr.isSuccess()){
				System.debug('Update was ok' + sr);
			}
			else{
				for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());	 }
			}
		}

		return [SELECT Id, Name, Description__c, Expected_Result__c, Test_Case__c, Order__c FROM Step__c WHERE Test_Case__c = :tcId ORDER BY Order__c ASC LIMIT 10000];
		
	}
}