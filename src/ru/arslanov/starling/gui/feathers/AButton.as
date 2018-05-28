package ru.arslanov.starling.gui.feathers
{
	import feathers.controls.Button;

	import flash.geom.Point;
	
	import ru.arslanov.starling.gui.events.ButtonEvent;
	
	import ru.arslanov.starling.interfaces.IKillableStarling;
	
	import starling.events.Event;
	
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class AButton extends Button implements IKillableStarling, IButton
	{
		public var customData:Object; // Для хранения пользовательских данных. Зануляется в kill()
		
		private var _isKilled:Boolean;
		private var _pos:Point = new Point();
		
		public function AButton()
		{
			super();
			addEventListener(Event.TRIGGERED, onTriggered);
		}
		
		/* INTERFACE ru.arslanov.starling.interfaces.IKillableStarling */

		public function kill():void
		{
			removeFromParent(true);
			removeEventListener(Event.TRIGGERED, onTriggered);
			customData = null;
			_pos = null;
			_isKilled = true;
		}
		
		private function onTriggered(event:Event):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE));
		}
		
		public function get isKilled():Boolean { return _isKilled; }
				
		public function get pos():Point { return _pos; }
		public function set pos(value:Point):void
		{
			if ((pos.x == value.x) && (pos.y == value.y)) return;
			_pos = value;
			applyPosition();
		}
		
		public function setXY(x:Number = 0, y:Number = 0, round:Boolean = true):void
		{
			_pos.setTo(round ? Math.round(x) : x, round ? Math.round(y) : y);
			applyPosition();
		}
		
		private function applyPosition():void
		{
			x = pos.x;
			y = pos.y;
		}
	}
}