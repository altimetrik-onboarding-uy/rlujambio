global class scheduledEmail implements Schedulable  {

	global void execute(SchedulableContext SC) {

		 sendmail();

	}
	public void sendmail()
			{
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					List<Project__c> projects = TabsController.getOngoingProjects();
					List<String> owners = new List<String>();
					for(Project__c p : projects){
						owners.add(p.OwnerId);
					}
					List<String> addresses = new List<String>();

					List<User> users = [SELECT Id, Name, SenderEmail FROM User WHERE Id IN : owners];

					for(User u : users){
						addresses.add(u.SenderEmail);
					}

					Integer index = 0;
					String message = '';

					for(String a : addresses){
						String name = users[index].Name;
						String id = users[index].Id;
						List<String> sendTo = new List<String>();
						sendTo.add(a);

						message = 'Hi, ' + name + '\n' + 'This is a list of your ongoing projects' + '\n';
						for(Project__c p : projects){
							if(p.OwnerId == id){
								message = message + 'Name: ' + p.Name + '- Status: ' + p.Status__c + ' ';
								List<AggregateResult> queryResult = [SELECT COUNT_DISTINCT(Id) total FROM Test_Case__c WHERE Project__c = : p.Id];
								Integer countOfTC = (Integer) queryResult[0].get('total');
								message = message + '- Number of associated Test Cases: ' + countOfTC + '\n';
							}
						}
						email.setSubject('List of Ongoing Projects');
						email.setPlainTextBody(message);
						email.setToAddresses(sendTo);
						Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
						index++;

					}

			}

}
