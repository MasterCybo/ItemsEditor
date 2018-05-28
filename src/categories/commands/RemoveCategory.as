package categories.commands
{
	import base.commands.Command;
	
	import categories.models.MoCategory;
	
	import core.models.DataStore;
	
	public class RemoveCategory extends Command
	{
		public function RemoveCategory()
		{
			super();
		}
		
		override public function execute(category:* = null):void
		{
			var category:MoCategory = category as MoCategory;
			DataStore.me.categoriesManager.removeCategory(category);
			complete();
		}
	}
}
