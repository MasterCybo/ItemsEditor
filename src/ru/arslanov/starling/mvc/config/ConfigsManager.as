package ru.arslanov.starling.mvc.config
{
	import ru.arslanov.starling.mvc.context.IContext;
	
	public class ConfigsManager
	{
		private var _context:IContext;
		
		public function ConfigsManager(context:IContext)
		{
			_context = context;
		}
		
		public function configure(config:Object):void
		{
			if (config is Class) {
				var configObject:Config = new config(_context);
				configObject.configure();
			} else if (config is Object) {
				(config as Config).configure();
			}
		}
	}
}
