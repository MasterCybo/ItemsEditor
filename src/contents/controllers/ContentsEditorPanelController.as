package contents.controllers
{
	import base.views.AppButton;
	
	import contents.commands.AddContent;
	import contents.commands.RemoveContent;
	import contents.events.ContentListItemEvent;
	import contents.views.ContentsEditorPanel;
	
	import items.events.ItemListEvent;
	import items.models.MoItem;
	
	import ru.aa.march.controllers.ControllerFeathers;
	
	import starling.events.Event;
	
	public class ContentsEditorPanelController extends ControllerFeathers
	{
		private var _item:MoItem;
		
		public function ContentsEditorPanelController(view:ContentsEditorPanel)
		{
			super(view);
		}
		
		public function get view():ContentsEditorPanel {return getView() as ContentsEditorPanel;}
		
		
		override protected function initialize():void
		{
			super.initialize();
			
			view.addEventListener(Event.TRIGGERED, buttonTriggeredHandler);
			view.addEventListener(ContentListItemEvent.TRIGGERED_REMOVE_BUTTON, removeButtonHandler);
			eventDispatcher.addEventListener(ItemListEvent.SELECTED_ITEM, selectItemHandler);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(Event.TRIGGERED, buttonTriggeredHandler);
			view.removeEventListener(ContentListItemEvent.TRIGGERED_REMOVE_BUTTON, removeButtonHandler);
			eventDispatcher.removeEventListener(ItemListEvent.SELECTED_ITEM, selectItemHandler);
			super.destroy();
		}
		
		private function selectItemHandler(event:ItemListEvent):void
		{
			if (event.item == _item) return;
			
			_item = event.item;
			if (_item) {
				view.setData(_item.contents);
			} else {
				view.setData();
			}
		}
		
		private function buttonTriggeredHandler(event:Event):void
		{
			var button:AppButton = event.target as AppButton;
			if (!button) return;
			
			switch (button.name) {
				case ContentsEditorPanel.ADD_BUTTON:
					new AddContent().execute(_item);
					break;
			}
		}
		
		private function removeButtonHandler(event:ContentListItemEvent):void
		{
			new RemoveContent(_item).execute(event.content);
		}
	}
}
