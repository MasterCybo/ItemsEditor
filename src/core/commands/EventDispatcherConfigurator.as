package core.commands
{
	import base.commands.Command;
	import base.controllers.ControllerFeathers;
	import base.controllers.ControllerStarling;
	
	import flash.events.EventDispatcher;
	
	public class EventDispatcherConfigurator extends Command
	{
		public function EventDispatcherConfigurator()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			var globalDispatcher:EventDispatcher = new EventDispatcher();
			ControllerStarling.config(globalDispatcher);
			ControllerFeathers.config(globalDispatcher);
			Command.config(globalDispatcher);
			
			complete();
		}
	}
}
