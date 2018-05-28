package ru.arslanov.starling.mvc.mediators
{
	import flash.utils.Dictionary;
	
	import ru.arslanov.starling.mvc.context.IContext;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class MediatorMap implements IMediatorMap, IMediateSetter
	{
		private var _context:IContext;
		private var _mapMediators:Dictionary = new Dictionary(); // DisplayObjectClass = MediatorClass
		private var _mapViewMediator:Dictionary = new Dictionary(); // displayObject = mediator
		private var _mapViews:Dictionary = new Dictionary(); // MediatorClass = DisplayObjectClass
		
		private var _mappedClass:Class;
		
		public function MediatorMap(context:IContext)
		{
			_context = context;
		}
		
		public function hasMediator(mediatorClass:Class):Boolean { return _mapViews[mediatorClass]; }
		public function isMapped(view:Object):Boolean
		{
			var viewClass:Class = view["constructor"];
			return _mapMediators[viewClass];
		}
		
		public function isMediated(view:Object):Boolean { return _mapViewMediator[view]; }
		
		public function map(viewClass:Class):IMediateSetter
		{
			_mappedClass = viewClass;
			return this;
		}
		
		public function toMediator(mediatorClass:Class):void
		{
			if (_mapViews[mediatorClass] != undefined) {
				trace("WARNING! " + this + "::toMediator() : " + mediatorClass + " already mapped to " + _mappedClass);
				_mappedClass = null;
				return;
			}
			
			_mapMediators[_mappedClass] = mediatorClass;
			_mapViews[mediatorClass] = _mappedClass;
			
			trace(this, "mapped " + _mappedClass + " to mediator " + mediatorClass);
			
			_mappedClass = null;
		}
		
		public function unmap(mediatorClass:Class):void
		{
			var viewClass:Class = _mapViews[mediatorClass];
			
			if (viewClass) {
				delete _mapMediators[viewClass];
				delete _mapViews[mediatorClass];
				trace(this, "unmapped " + mediatorClass + " to mediate " + viewClass);
			}
		}
				
		public function mediate(view:Object):void
		{
			var viewClass:Class = view["constructor"];
			var mediatorClass:Class = _mapMediators[viewClass];
			
			if (!mediatorClass) return;
			if (_mapViewMediator[view]) throw new Error(mediatorClass + " already mediated to " + viewClass + "!");
			
			trace(this, "mediate " + viewClass);
			
			var mediator:IMediator = new mediatorClass(_context);
			_mapViewMediator[view] = mediator;
			mediator.initialize(view);
		}
		
		public function unmediate(view:Object):void
		{
			var viewClass:Class = view["constructor"];
			var mediator:IMediator = _mapViewMediator[view];
			
			if (!mediator) throw new Error(mediator + " already unmediated from " + viewClass + "!");
			
			trace(this, "unmediate " + viewClass);
			
			mediator.destroy();
			delete _mapViewMediator[view];
		}
	}
}