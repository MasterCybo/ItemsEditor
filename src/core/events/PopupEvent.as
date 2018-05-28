package core.events
{
	import flash.events.Event;
	
	public class PopupEvent extends Event
	{
		public static const SHOW_ALERT:String = "showAlert";
		public static const SHOW_PERMISSION:String = "showPermission";
		
		private var _title:String;
		private var _message:String;
		private var _acceptCallback:Function;
		private var _cancelCallback:Function;
		
		public function PopupEvent(type:String, title:String, message:String, acceptCallback:Function = null, cancelCallback:Function = null)
		{
			_title = title;
			_message = message;
			_acceptCallback = acceptCallback;
			_cancelCallback = cancelCallback;
			super(type);
		}
		
		public function get title():String {return _title;}
		public function get message():String {return _message;}
		
		public function get acceptCallback():Function {return _acceptCallback;}
		public function get cancelCallback():Function {return _cancelCallback;}
	}
}
