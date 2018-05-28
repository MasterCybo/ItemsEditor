/**
 * Created by Artem on 23.02.2015.
 */
package ru.arslanov.core.geometry
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class APoint
	{
		public var x:Number = 0;
		public var y:Number = 0;
		
		public function APoint( x:Number = 0, y:Number = 0 )
		{
			this.x = x;
			this.y = y;
		}
		
		public function setTo( x:Number, y:Number ):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function setFromNative( point:Point ):void
		{
			this.setTo( point.x, point.y );
		}
		
		public function distance( point:APoint ):Number
		{
			return Math.sqrt( (point.x - this.x) * (point.x - this.x) - (point.y - this.y) * (point.y - this.y) );
		}
		
		public function clone():APoint
		{
			return new APoint( this.x, this.y );
		}
		
		public function getNativePoint():Point
		{
			return new Point( this.x, this.y );
		}
		
		public function toString():String
		{
			return "[object APoint " + this.x + ", " + this.y + "]";
		}
	}
}
