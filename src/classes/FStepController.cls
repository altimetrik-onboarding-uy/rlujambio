public with sharing class FStepController {

	@AuraEnabled
	public static void insertTestStep(Step__c step){


		List<Step__c> query  = [SELECT Order__c FROM Step__c WHERE Test_Case__c = : step.Test_Case__c ORDER BY Order__c DESC];
		if (!query.isEmpty()){
			Step__c lastStep = query.get(0);
			step.Order__c = lastStep.Order__c + 1;
			Database.SaveResult sr = Database.insert(step);

				if(sr.isSuccess()){
					System.debug('Insert was ok' + sr);
				}
				else{
					for(Database.Error err : sr.getErrors()) {
	            System.debug('The following error has occurred.');
	            System.debug(err.getStatusCode() + ': ' + err.getMessage());
	            System.debug('Contact fields that affected this error: ' + err.getFields());
						 }
				}

		}
		else{
			step.Order__c = 0;
			Database.SaveResult sr = Database.insert(step);

				if(sr.isSuccess()){
					System.debug('Insert was ok' + sr);
				}
				else{
					for(Database.Error err : sr.getErrors()) {
	            System.debug('The following error has occurred.');
	            System.debug(err.getStatusCode() + ': ' + err.getMessage());
	            System.debug('Contact fields that affected this error: ' + err.getFields());
						 }
				}
		}
	}

}
