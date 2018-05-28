package ru.arslanov.starling.mvc.extensions
{
	import ru.arslanov.starling.mvc.context.IContext;
	
	public class ExtensionInstaller
	{
		private var _context:IContext;
		
		public function ExtensionInstaller(context:IContext)
		{
			_context = context;
		}
		
		public function install(extension:Object):void
		{
			var ext:Extension;
			if (extension is Class) {
				ext = new extension(_context);
			}
			
			ext.initialize();
		}
	}
}
