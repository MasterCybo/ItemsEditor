/**
 * Created by Artem on 15.03.2016.
 */
package ru.arslanov.starling.gui.feathers
{
	import feathers.controls.ToggleButton;
	
	import flash.geom.Point;
	
	import ru.arslanov.starling.gui.events.ButtonEvent;
	import ru.arslanov.starling.interfaces.IKillableStarling;
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AToggler extends ToggleButton implements IKillableStarling, IButton
	{
		public var customData:Object; // Для хранения пользовательских данных. Зануляется в kill()
		
		private var _isKilled:Boolean;
		private var _pos:Point = new Point();
		private var _autoValidate:Boolean;
		
		public function AToggler(autoValidate:Boolean = false)
		{
			_autoValidate = autoValidate;
			super();
			addEventListener(Event.TRIGGERED, onTriggered);
		}

		public function kill():void
		{
			removeEventListener(Event.TRIGGERED, onTriggered);
			customData = null;
			_pos = null;
			_isKilled = true;
		}
		
		public function get isKilled():Boolean { return _isKilled; }
		
		override public function set label(value:String):void {
			super.label = value;
			if (_autoValidate) super.validate();
		}
		
		public function get pos():Point { return _pos; } 
		public function set pos(value:Point):void
		{
			if ( (pos.x == value.x) && (pos.y == value.y) ) return;
			
			_pos = value;
			applyPosition();
		}
		
		public function setXY(x:Number = 0, y:Number = 0, round:Boolean = true):void
		{
			_pos.setTo( round ? Math.round( x ) : x, round ? Math.round( y ) : y );
			applyPosition();
		}
		
		private function applyPosition():void {
			x = pos.x;
			y = pos.y;
		}
		
		private function onTriggered(event:Event):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE));
		}
	}
}
