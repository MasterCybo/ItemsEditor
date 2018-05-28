package core.commands
{
	import base.commands.Command;
	
	public class FeathersConfigurator extends Command
	{
		public function FeathersConfigurator()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
//			new MetalWorksDesktopTheme();
			new AppTheme();
			
			complete();
		}
	}
}
