package ru.arslanov.core.enum
{
	
	/**
	 * Целочисленный перечисляемый тип
	 * @author Artem Arslanov
	 */
	public class EnumInt extends Enum
	{
		
		public function EnumInt( val:int = undefined )
		{
			value = val;
		}
		
		public function getInt():int {
			return int( value );
		}
	}

}
