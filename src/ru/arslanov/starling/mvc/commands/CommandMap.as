package ru.arslanov.starling.mvc.commands
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import ru.arslanov.starling.mvc.commands.ICommand;
	import ru.arslanov.starling.mvc.commands.ICommandMap;
	import ru.arslanov.starling.mvc.commands.ICommandSetter;
	import ru.arslanov.starling.mvc.context.IContext;
	
	/**
	 * Карта команд
	 * @author Artem Arslanov
	 */
	public class CommandMap implements ICommandMap, ICommandSetter
	{
		private var _context:IContext;
		
		private var _map:Dictionary = new Dictionary(); // eventType = [ commandClass1, commandClass2 ]
		
		private var _mappedType:String;
		
		public function CommandMap(context:IContext)
		{
			_context = context;
		}
			
		public function hasEventCommand(eventType:String, concreteCommand:Class = null):Boolean
		{
			var commands:Array = _map[eventType];
			if (!commands) {
				return false;
			} else if (concreteCommand) {
				var idx:int = commands.indexOf(concreteCommand);
				return idx != -1;
			}
			
			return true;
		}
		
		public function unmap(eventType:String, concreteCommand:Class = null):void
		{
			if (hasEventCommand(eventType)) {
				var commands:Array = _map[eventType];
				
				if (concreteCommand && commands.length > 0) {
					var idx:int = commands.indexOf(concreteCommand);
					if (idx != -1) commands.splice(idx, 1);
				}
				
				if (commands.length == 0 || !concreteCommand) {
					delete _map[eventType];
				}
			}
		}
		
		public function map(eventType:String, eventClass:Class = null):ICommandSetter
		{
			// eventClass пока не используется
			_mappedType = eventType;
			return this;
		}
		
		public function toCommand(commandClass:Class):void
		{
			var commands:Array = _map[_mappedType];
			if (!commands) {
				_map[_mappedType] = commands = [];
			}
			
			var idx:int = commands.indexOf(commandClass);
			if (idx == -1) {
				commands.push(commandClass);
				trace(this, "Mapped '" + _mappedType + "' to command " + commandClass);
			} else {
				trace(this, "ERROR already mapped '" + _mappedType + "' to command " + commandClass);
			}
			
			_mappedType = null;
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			if (!hasEventCommand(event.type)) return false;
			
			var commands:Array = _map[event.type];
			var CommandClass:Class;
			var command:ICommand;
			for (var i:int = 0; i < commands.length; i++) {
				CommandClass = commands[ i ];
				command = new CommandClass(_context, event);
				command.execute();
				command.destruct();
			}
			return true;
		}
	}
}