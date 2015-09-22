package milkmidi.core {

	/**
	 * 介面
	 */
	public interface IDestroy {
	
		/**
		 * destory object
		 */
		function destroy():void;			
		/**
		 * 是否已經被 destroy 過。
		 */
		function get destroyed():Boolean;		
	}
}