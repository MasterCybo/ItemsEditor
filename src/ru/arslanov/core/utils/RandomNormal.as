package ru.arslanov.core.utils {
	
	/**
	 * Равномерный рандом.
	 * Частоты выпадения генерируемых различных чисел, стремятся быть одинаковыми.
	 * Генератор случайных чисел будет выдавать случайные целые, неповторяющиеся числа от 0 до modul-1 с периодом, равным 7 миллионам.
	 * @author Artem Arslanov
	 */
	public class RandomNormal {
		
		static private var _maxValue:uint = 2147483647;
		
		private var _val:uint;
		private var _k:uint = 1220703125;
		private var _b:uint = 7;
		private var _m:uint;
		
		public function RandomNormal( modul:uint = 100 ) {
			_m = modul;
			var t:Date = new Date();
			var s:String = t.time.toString();
			s = s.substr( s.length - 6, 6 );
			_val = uint( s );
		}
		
		/**
		 * При каждом обращении к свойству, получаем новое случайное число.
		 */
		public function get value():uint {
			_val = (( _k * _val + _b ) % _maxValue );
			return _val % _m;
		}
	}

}