package ru.arslanov.starling.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	import ru.arslanov.starling.interfaces.IKillableContainerStarling;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	

	/**
	 * Базовый спрайт
	 * @author Artem Arslanov
	 */
	public class ASprite extends Sprite implements IKillableContainerStarling
	{
		public var customData:Object; // Для хранения пользовательских данных. Зануляется в kill()
		
		private var _isKilled:Boolean;
		private var _pos:Point = new Point();
		
		public function ASprite()
		{
			super();
		}

		public function kill():void
		{
			if (isKilled) throw( new Error(this + " already killed!") ).getStackTrace();
			
			killChildren();
			removeFromParent(true);
//			dispose();
			
			customData = null;
			_pos = null;
			_isKilled = true;
			// override me
		}
		
		public function get isKilled():Boolean { return _isKilled; }

		override public function addChild(object:DisplayObject):DisplayObject
		{
//			if ( !( "kill" in object ) ) throw new ArgumentError( "StSpriteBase : added object no have a kill() method!" ).getStackTrace();
			return super.addChild(object);
		}
		
		public function get pos():Point
		{
			_pos.setTo(x, y);
			return _pos;
		}
		
		public function set pos(value:Point):void
		{
			if (_pos.equals(value)) return;

			_pos = value;
			
			x = _pos.x;
			y = _pos.y;
		}
		
		public function setXY(x:Number = 0, y:Number = 0, round:Boolean = true):void
		{
			super.x = round ? Math.round(x) : x;
			super.y = round ? Math.round(y) : y;
			
			_pos.setTo(super.x, super.y);
		}
		
		public function killChildren(startIdx:uint = 0, num:int = -1):void
		{
			if (numChildren == 0) return;

			var child:DisplayObject;
			
			num = ( num == -1 ) ? numChildren : Math.min(num, numChildren - startIdx);
			startIdx = Math.min(startIdx, numChildren);
			
			while (num > 0) {
				child = getChildAt(startIdx);
				
				if ("kill" in child) {
					child["kill"]();
				}/* else {
					child.removeFromParent(true);
				}*/
				num--;
				/*
				 if ( child )
				 {
				 child[ "kill" ]();
				 num--;
				 }
				 */
			}
			
			child = null;
		}
	}
}