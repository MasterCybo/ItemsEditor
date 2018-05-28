/**
 * Created by Artem on 24.02.2015.
 */
package ru.arslanov.core.collection
{
	import ru.arslanov.core.geometry.APoint;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class APointsPool
	{
		private var _pool:Vector.<APoint>;
		private var _count:uint;
		
		public function APointsPool( length:uint )
		{
			_pool = new Vector.<APoint>( length, true );
			for ( var i:int = 0; i < length; i++ )
			{
				_pool.push( new APoint() );
			}
		}
		
		public function newPoint( x:Number, y:Number ):APoint
		{
			return _pool[ _count++ ].setTo( x, y );
		}
		
		public function dispose():void
		{
			_pool.length = 0;
			_count = 0;
		}
	}
}
