package contents.commands
{
	import base.commands.Command;
	
	import contents.collections.ContentsTypeEnum;
	import contents.models.IContentItem;
	import contents.models.ItemContent;
	
	import core.models.DataStore;
	
	import items.models.MoItem;
	
	import contents.models.EffectContent;
	
	public class AddContent extends Command
	{
		public function AddContent()
		{
			super();
		}
		
		override public function execute(data:* = null):void
		{
			var item:MoItem = data;
			
			var contentItem:IContentItem;
			
			if (item.category.contentsType.equals(ContentsTypeEnum.EFFECTS)) {
				contentItem = new EffectContent("effect", 0);
			} else {
				var items:Vector.<MoItem> = DataStore.me.itemsManager.items;
				if (items.length) {
					contentItem = new ItemContent(items[0].id, 1);
				}
			}
			item.addContent(contentItem);
			
			complete();
		}
	}
}
