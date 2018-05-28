package core.serialize
{
	public interface ISerializer
	{
		function serialize(entity:*):Object;
		function deserialize(data:Object):*;
	}
}
