package ru.arslanov.starling.mvc.extensions
{
	import ru.arslanov.starling.mvc.context.IContext;
	
	public class Extension
	{
		private var _context:IContext;
		
		public function Extension(context:IContext)
		{
			_context = context;
		}
		
		protected function get context():IContext {return _context;}
		
		public function initialize():void
		{
			throw new Error("This abstract method!");
		}
	}
}
