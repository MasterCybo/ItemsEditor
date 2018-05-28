package core.commands
{
	import base.commands.Command;
	
	import categories.collections.CategoriesManager;
	import categories.models.MoCategory;
	
	import contents.models.ItemContent;
	
	import core.models.DataStore;
	import core.serialize.CategoriesManagerSerializer;
	import core.serialize.CategoryTypeSerializer;
	import core.serialize.DataStoreSerializer;
	import core.serialize.EffectContentSerializer;
	import core.serialize.ItemContentSerializer;
	import core.serialize.ItemSerializer;
	import core.serialize.ItemsManagerSerializer;
	import core.serialize.ContentsSerializer;
	
	import items.collections.ItemsManager;
	import items.models.MoItem;
	
	import contents.models.EffectContent;
	
	public class SerializeConfigurator extends Command
	{
		public function SerializeConfigurator()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			DataStore.config(new DataStoreSerializer());
			CategoriesManager.config(new CategoriesManagerSerializer());
			MoCategory.config(new CategoryTypeSerializer());
			ItemsManager.config(new ItemsManagerSerializer());
			MoItem.config(new ItemSerializer());
			EffectContent.config(new EffectContentSerializer());
			ItemContent.config(new ItemContentSerializer());
			ContentsSerializer.config(new ContentsSerializer());
			
			complete();
		}
	}
}
