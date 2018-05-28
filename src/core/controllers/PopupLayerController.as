package core.controllers
{
	import base.controllers.ControllerFeathers;
	
	import core.events.PopupEvent;
	import core.views.PopupLayer;
	
	public class PopupLayerController extends ControllerFeathers
	{
		public function PopupLayerController(view:PopupLayer)
		{
			super(view);
		}
		
		public function get view():PopupLayer {return getView() as PopupLayer;}
		
		override protected function initialize():void
		{
			super.initialize();
			
			eventDispatcher.addEventListener(PopupEvent.SHOW_ALERT, showPopupHandler);
			eventDispatcher.addEventListener(PopupEvent.SHOW_PERMISSION, showPopupHandler);
		}
		
		override public function destroy():void
		{
			eventDispatcher.removeEventListener(PopupEvent.SHOW_ALERT, showPopupHandler);
			eventDispatcher.removeEventListener(PopupEvent.SHOW_PERMISSION, showPopupHandler);
			super.destroy();
		}
		
		private function showPopupHandler(event:PopupEvent):void
		{
			switch (event.type) {
				case PopupEvent.SHOW_ALERT:
					view.showAlert(event.title, event.message);
					break;
				case PopupEvent.SHOW_PERMISSION:
					view.showQuestion(event.title, event.message, event.acceptCallback, event.cancelCallback);
					break;
			}
		}
	}
}
