package core.commands
{
	import base.commands.Command;
	
	import core.models.AppSettings;
	
	public class LoadSettings extends Command
	{
		public function LoadSettings()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			AppSettings.me.load();
			complete();
		}
	}
}
