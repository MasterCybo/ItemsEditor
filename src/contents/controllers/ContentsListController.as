package contents.controllers
{
	import contents.events.ContentsEvent;
	import contents.views.ContentsList;
	
	import items.events.ItemListEvent;
	import items.models.MoItem;
	
	import ru.aa.march.controllers.ControllerFeathers;
	
	public class ContentsListController extends ControllerFeathers
	{
		private var _item:MoItem;
		
		public function ContentsListController(view:ContentsList)
		{
			super(view);
		}
		
		public function get view():ContentsList {return getView() as ContentsList;}
		
		
		override protected function initialize():void
		{
			super.initialize();
			
			eventDispatcher.addEventListener(ItemListEvent.SELECTED_ITEM, selectItemHandler);
		}
		
		override public function destroy():void
		{
			eventDispatcher.removeEventListener(ItemListEvent.SELECTED_ITEM, selectItemHandler);
			removeItemListeners(_item);
			super.destroy();
		}
		
		private function selectItemHandler(event:ItemListEvent):void
		{
			if (event.item == _item) return;
			
			removeItemListeners(_item);
			
			_item = event.item;
			if (_item) {
				view.setData(_item.category.contentsType, _item.contents);
				_item.addEventListener(ContentsEvent.ADDED_CONTENT, stuffHandler);
				_item.addEventListener(ContentsEvent.REMOVED_CONTENT, stuffHandler);
			} else {
				view.setData();
			}
		}
		
		private function removeItemListeners(item:MoItem):void
		{
			if (!item) return;
			item.removeEventListener(ContentsEvent.ADDED_CONTENT, stuffHandler);
			item.removeEventListener(ContentsEvent.REMOVED_CONTENT, stuffHandler);
		}
		
		private function stuffHandler(event:ContentsEvent):void
		{
			switch(event.type) {
				case ContentsEvent.ADDED_CONTENT:
					view.addItem(event.content);
					break;
				case ContentsEvent.REMOVED_CONTENT:
					view.removeItem(event.content);
					break;
			}
		}
	}
}
