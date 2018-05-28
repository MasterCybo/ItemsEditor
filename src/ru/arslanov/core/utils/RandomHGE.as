package ru.arslanov.core.utils {
	/**
	 * Рандом из движка HGE (Haaf's Game Engine)
	 * @author Artem Arslanov
	 */
	public class RandomHGE {
		
        static private var _seed:uint;
		
		static public function set seed( value:uint ):void {
			_seed = (value == 0) ? uint(Math.random() * uint.MAX_VALUE) : value;
		}
		
		static public function get seed():uint {
			return _seed;
		}
		
		static public function getInt( min:int = 0, max:int = 100 ):int {
			_seed = 214013 * _seed + 2531011;
			return min + (_seed ^ (_seed >> 15)) % (max - min + 1);
		}
		static public function getFloat( min:Number = 0, max:Number = 1 ):Number {
			_seed = 214013 * _seed + 2531011;
			return min + (_seed >>> 16) * (1.0 / 65535.0) * (max - min);
		}
		
	}

}