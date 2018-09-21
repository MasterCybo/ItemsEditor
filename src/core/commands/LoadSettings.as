package core.commands
{
	import core.models.AppSettings;
	
	import ru.aa.march.commands.Command;
	
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
