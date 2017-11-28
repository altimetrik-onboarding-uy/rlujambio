public with sharing class TabsController {
	    
    @AuraEnabled
    public static List<Project__c> getProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name];
    }

    @AuraEnabled
    public static List<Test_Case__c> getTestCases(){
        return [SELECT Id, Title__c, Name FROM Test_Case__c ORDER BY Name];
    }

    @AuraEnabled
    public static List<Test_Case__c> getRelatedTC(Project__c project){
        return [SELECT Id, (SELECT Id, Title__c FROM Test_Cases__r) FROM Project__c WHERE Id = : project.Id].Test_Cases__r;
    }
}
