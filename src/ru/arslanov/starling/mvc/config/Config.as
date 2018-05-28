package ru.arslanov.starling.mvc.config
{
	import ru.arslanov.starling.mvc.commands.ICommandMap;
	import ru.arslanov.starling.mvc.context.IContext;
	import ru.arslanov.starling.mvc.injection.IInjector;
	import ru.arslanov.starling.mvc.mediators.IMediatorMap;
	
	/**
	 * Конфигурация архитектуры приложения.
	 * В нём описываются все взаимосвязи между основными объекми архитектуры.
	 * @author Artem Arslanov
	 */
	public class Config
	{
		private var _context:IContext;
		
		public function Config(context:IContext)
		{
			_context = context;
		}
		
		public function configure():void
		{
			trace(this + "::initialize()");
			// override me
		}
		
		public function get context():IContext { return _context }
		public function get injector():IInjector { return _context.injector; }
		public function get mediatorMap():IMediatorMap { return _context.mediatorMap; }
		public function get commandMap():ICommandMap { return _context.commandMap; }
	}
}