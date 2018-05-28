package base.commands
{
	import base.commands.events.CommandEvent;
	
	import flash.events.EventDispatcher;
	
	public class Command extends EventDispatcher
	{
		public static var _eventDispatcher:EventDispatcher;
		
		public static function config(eventDispatcher:EventDispatcher):void
		{
			_eventDispatcher = eventDispatcher;
		}
		
		
		public function Command()
		{
		}
		
		protected function get eventDispatcher():EventDispatcher {
			if (!_eventDispatcher) _eventDispatcher = new EventDispatcher();
			return _eventDispatcher;
		}
		
		
		private var _queue:Vector.<Command> = new Vector.<Command>();
		
		public function execute(data:* = null):void
		{
			// override me
			complete(data);
		}
		
		public function next(command:Command):Command
		{
			_queue.push(command);
			return this;
		}
		
		protected function complete(data:* = null):void
		{
			dispatchEvent(new CommandEvent(CommandEvent.COMPLETE, data));
			
			var command:Command = _queue.shift();
			if (command) {
				command.execute(data);
			}
		}
	}
}
