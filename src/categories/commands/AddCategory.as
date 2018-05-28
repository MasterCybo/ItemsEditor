package categories.commands
{
	import base.commands.Command;
	
	import categories.models.MoCategory;
	
	import core.models.DataStore;
	
	public class AddCategory extends Command
	{
		public static var _counter:int;
		
		public function AddCategory()
		{
			super();
		}
		
		override public function execute(name:* = null):void
		{
			var count:String = String(_counter++);
			DataStore.me.categoriesManager.addCategory(new MoCategory(name + count));
			complete();
		}
	}
}
