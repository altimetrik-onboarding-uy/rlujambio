global class scheduledEmail implements Schedulable  {

	global void execute(SchedulableContext SC) {

		 sendmail();

	}
	public void sendmail()
			{
				emaiBatch b = new emaiBatch();
				database.executebatch(b);
			}
}