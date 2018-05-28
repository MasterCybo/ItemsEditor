package contents.controllers
{
	import base.controllers.ControllerFeathers;
	import base.views.AppPickerList;
	import base.views.AppTextInput;
	
	import contents.models.EffectContent;
	import contents.views.EffectListItemRenderer;
	
	import starling.events.Event;
	
	public class EffectContentListItemController extends ControllerFeathers
	{
		
		public function EffectContentListItemController(view:EffectListItemRenderer)
		{
			super(view);
		}
		
		public function get view():EffectListItemRenderer {return getView() as EffectListItemRenderer}
		
		override protected function initialize():void
		{
			super.initialize();
			
			view.addEventListener(Event.CHANGE, changeHandler);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(Event.CHANGE, changeHandler);
			super.destroy();
		}
		
		private function changeHandler(event:Event):void
		{
			var content:EffectContent = view.data as EffectContent;
			if (!content) return;
			
			switch (true) {
				case event.target is AppTextInput:
					content.additive = view.additive;
					break;
				case event.target is AppPickerList:
					if (view.selectedItem) content.property = view.selectedItem.getString();
					break;
			}
		}
	}
}
