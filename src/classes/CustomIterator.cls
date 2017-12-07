global class CustomIterator implements Iterator<Email_Entry__c> {

  Email_Entry__c[] results { get;set; }
  Integer i { get;set; }
  global List<Project__c> projects;
	global List<String> owners;
	global List<String> addresses;
	global List<User> users;
	global Integer index;
	global String message;
	global List<String> projectIds;
	global List<AggregateResult> queryResult;
	global Map<String, Integer> mapResult;

  public CustomIterator() {
    i = 0;
    results = new List<Email_Entry__c>();
    projects = TabsController.getOngoingProjects();
    owners = new List<String>();
    for(Project__c p : projects){
      owners.add(p.OwnerId);
    }
    addresses = new List<String>();
    users = [SELECT Id, Name, Email FROM User WHERE Id IN : owners];
    for(User u : users){
      addresses.add(u.Email);
    }
    index = 0;
    message = '';
    projectIds = new List<String>();
    for(Project__c p : projects){
      projectIds.add(p.Id);
    }
    queryResult = [SELECT COUNT_DISTINCT(Id) total FROM Test_Case__c WHERE Project__c IN : projectIds GROUP BY Project__c];
    mapResult = new Map<String, Integer>();
    for(Integer i = 0; i < queryResult.size(); i++){
      mapResult.put(projectIds.get(i), (Integer) queryResult[i].get('total'));
    }
    for(String a : addresses){
      Email_Entry__c entry = new Email_Entry__c();
			String name = users[index].Name;
			String uId = users[index].Id;
			message = 'Hi, ' + name + '\n' + 'This is a list of your ongoing projects' + '\n';

			for(Project__c p : projects){
				if(p.OwnerId == uId){
					message = message + 'Name: ' + p.Name + '- Status: ' + p.Status__c + ' ';
					Integer countOfTC = mapResult.get(p.Id);
					message = message + '- Number of associated Test Cases: ' + countOfTC + '\n';
				}
			}
      entry.Recipient_Name__c = name;
      entry.Recipient_Id__c = uId;
      entry.Recipient_Mail__c = a;
      entry.Message__c = message;
      results.add(entry);
			index++;
			}
  }

  public Boolean hasNext(){
   return results != null && !results.isEmpty() && i < results.size();
  }

  public Email_Entry__c next() {
    return results[i++];
  }

}
