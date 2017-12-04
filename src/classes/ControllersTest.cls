@isTest
private class ControllersTest {

	@isTest static void testgetStepsTDController() {
		Test_Case__c example = new Test_Case__c();
		example.Id = 'a061I000002O1DHQA0';
		example.Project__c = 'a071I000001JQpHQAW';
		example.User_Story__c = 'http://www.elobservador.com';
		List<Step__c> actual_value = TestDetailsController.getSteps(example);
		List<Step__c> expected_value = [SELECT Name, Description__c, Expected_Result__c, Test_Case__c FROM Step__c WHERE Test_Case__c = :example.Id LIMIT 10000];
		System.assertEquals(expected_value,actual_value);
	}

	@isTest static void testgetProjectsTabController() {
		List<Project__c> expected_value = [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name LIMIT 10000];
		List<Project__c> actual_value = TabsController.getProjects();
		System.assertEquals(expected_value, actual_value);

	}

	@isTest static void testgetOngoingProjectsTabsController(){
		List<Project__c> expected_value = [SELECT Id, Name, Status__c, OwnerId FROM Project__c WHERE Status__c = 'Ongoing' ORDER BY Name LIMIT 10000];
		List<Project__c> actual_value = TabsController.getOngoingProjects();
		System.assertEquals(expected_value, actual_value);
	}

	@isTest static void testgetTestCasesTabsController(){
		List<Test_Case__c> expected_value = [SELECT Id, Title__c, Name, Description__c, Project__c, Preconditions__c, User_Story__c FROM Test_Case__c ORDER BY Name LIMIT 10000];
		List<Test_Case__c> actual_value = TabsController.getTestCases();
		System.assertEquals(expected_value, actual_value);
	}

	@isTest static void testgetRelatedTCTabsController(){
		Project__c example = new Project__c();
		example.Id = 'a071I000001JQpHQAW';
		example.Status__c = 'Ongoing';
		List<Test_Case__c> expected_value = [SELECT Id, Title__c, Name, Description__c, Project__c, Preconditions__c, User_Story__c, LastModifiedDate FROM Test_Case__c  WHERE Project__c = 'a071I000001JQpHQAW' ORDER BY LastModifiedDate DESC LIMIT 10000];
		List<Test_Case__c> actual_value = TabsController.getRelatedTC(example);
		System.assertEquals(expected_value, actual_value);
	}

	@isTest static void testremoveTCandaddTestTabsandTestController(){
		Test_Case__c tc = new Test_Case__c();
		tc.Title__c= 'Test';
		tc.User_Story__c='http://www.google.com.uy';
		tc.Project__c='a071I000001JQpHQAW';
		tc = FTestController.addTestCase(tc);

		List<Test_Case__c> results = [SELECT Id FROM Test_Case__c WHERE Id = :tc.Id];
		Test_Case__c result = results.get(0);

		System.assertEquals(tc.Id, result.Id);

		TabsController.removeTC(tc);
		List<Test_Case__c> empty = new List<Test_Case__c>();

		System.assertEquals(empty, [SELECT Id, Name FROM Test_Case__c WHERE Id = :tc.Id]);
	}

	@isTest static void testupdateTestCaseTabsController(){
		Test_Case__c tc = new Test_Case__c();
		tc.Title__c= 'Test';
		tc.User_Story__c='http://www.google.com.uy';
		tc.Project__c='a071I000001JQpHQAW';
		tc.Preconditions__c = 'Old preconditions';
		tc = FTestController.addTestCase(tc);

		String oldPreconditions = tc.Preconditions__c;
		tc.Preconditions__c = 'New preconditions';

		Test_Case__c returnedValue = TabsController.updateTestCase(tc);
		System.assertEquals(tc.Preconditions__c, returnedValue.Preconditions__c);

		tc.Preconditions__c = oldPreconditions;
		TabsController.updateTestCase(tc);
	}

	@isTest static void testgetProjectsFTestController(){
		List<Project__c> expected_value = [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name LIMIT 10000];
		List<Project__c> actual_value = FTestController.getProjects();
		System.assertEquals(expected_value, actual_value);
	}

	@isTest static void testgetOPProjectsFTestController(){
		List<Project__c> expected_value = [SELECT Id, Name, Status__c, OwnerId FROM Project__c WHERE ((Status__c = 'Ongoing') OR (Status__c = 'Proposed')) ORDER BY Name LIMIT 10000];
		List<Project__c> actual_value = FTestController.getOPProjects();
		System.assertEquals(expected_value, actual_value);
	}

	@isTest static void testinsertTestStep(){
		Step__c example = new Step__c();
		example.Description__c = 'Example Step';
		example.Expected_Result__c = 'Example Step';
		example.Test_Case__c = 'a061I000002O1DHQA0';

		FStepController.insertTestStep(example);

		Step__c insertedValue = [SELECT Id FROM Step__c WHERE Id = : example.Id];

		System.assertEquals(example.Id,insertedValue.Id);
	}

}
