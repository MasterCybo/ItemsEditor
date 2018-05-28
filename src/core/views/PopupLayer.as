package core.views
{
	import core.controllers.PopupLayerController;
	
	import feathers.controls.Alert;
	import feathers.controls.LayoutGroup;
	import feathers.data.ArrayCollection;
	
	import starling.text.TextFormat;
	
	public class PopupLayer extends LayoutGroup
	{
		private static const _messageFormat:TextFormat = new TextFormat("Calibri", 14);
		private static const _okButton:ArrayCollection = new ArrayCollection([{ label: "Ok" }]);
		
		public function PopupLayer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			new PopupLayerController(this);
		}
		
		public function showAlert(title:String, message:String):void
		{
			var alert:Alert = Alert.show(message, title, _okButton);
			
			alert.fontStyles = _messageFormat;
			alert.paddingRight = alert.paddingLeft = 50;
			alert.outerPaddingTop = alert.outerPaddingBottom = 15;
		}
		
		public function showQuestion(title:String, message:String, acceptCallback:Function = null, cancelCallback:Function = null):void
		{
			var okButton:Object = { label: "Ok" };
			if (acceptCallback != null) {
				okButton.triggered = acceptCallback;
			}
			
			var cancelButton:Object = { label: "Cancel" };
			if (cancelCallback != null) {
				cancelButton.triggered = cancelCallback;
			}
			
			var buttons:ArrayCollection = new ArrayCollection([okButton, cancelButton]);
			
			var alert:Alert = Alert.show(message, title, buttons);
			
			alert.fontStyles = _messageFormat;
			alert.paddingRight = alert.paddingLeft = 50;
			alert.outerPaddingTop = alert.outerPaddingBottom = 15;
		}
	}
}
