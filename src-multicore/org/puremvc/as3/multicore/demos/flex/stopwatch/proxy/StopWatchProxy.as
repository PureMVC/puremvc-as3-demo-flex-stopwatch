package org.puremvc.as3.multicore.demos.flex.stopwatch.proxy
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class StopWatchProxy extends Proxy
	{
		public static const NAME:String 	= "StopWatchProxy";
		public static const SYNC:String 	= NAME+"/notes/sync";
		public static const TICK:String 	= NAME+"/notes/tick";
		public static const LAP:String  	= NAME+"/notes/lap";
		public static const RESET:String  	= NAME+"/notes/reset";
		
		public function StopWatchProxy()
		{
			super( NAME );
			
		}
		
		override public function onRegister():void
		{
			timer = new Timer( 1000, 0 );
			timer.addEventListener( TimerEvent.TIMER, onTick );
		}

		/**
		 * Start the timer.
		 * <P>
		 * Ensure the timer exists, and has a listener 
		 * placed if this is the first call.</P>
		 * <P>  
		 * Then start the timer. Note, the timer is
		 * not reset first, so this is also called 
		 * when restarting a paused timer.</P>
		 */  
		public function startTimer():void
		{
			timer.start();
			sendNotification( SYNC, displayTime );
		}

		/**
		 * Reset the timer.
		 */
		public function resetTimer():void
		{
			timer.reset();
			start 	= new Date();
			now 	= start;
        	sendNotification( RESET, displayTime );
		}

		/**
		 * Stop the timer.
		 */
		public function stopTimer():void
		{
			timer.stop();
			now = new Date();
		}

		/**
		 * Freeze the current lap time.
		 * <P>
		 * Send a LAP notification with the current elapsed time.</P>
		 * <P>
		 * Called when the Split button of the UI requests a split
		 * view of the current lap time (frozen) and the ongoing
		 * elapsed time as (updated with TICKS).</P>
		 */
        public function freeze( ):void 
        {
        	sendNotification( LAP, displayTime );
        }

		/**
		 * Update the time.
		 * <P>
		 * Each second, update the time and send a 
		 * TICK notification. 
		 */
        private function onTick( event:TimerEvent ):void 
        {
        	now = new Date();
        	sendNotification( TICK, displayTime );
        }

		/**
		 * Get the display time.
		 */
		private function get displayTime():String
		{
			var time:Date = elapsed;
			var seconds:Number = time.secondsUTC;
    	    var minutes:Number = time.minutesUTC;
        	var hours:Number   = time.hoursUTC;
        	
        	var output:String = "";
        	if (hours<10) output +="0";
        	output += String(hours)+":";
        	if (minutes<10) output +="0";
        	output += String(minutes)+":";
        	if (seconds<10) output +="0";
        	output += String(seconds);
        	
        	return output;
		}

		/**
		 * Get elapsed milliseconds as Date.
		 */
		private function get elapsed():Date
		{
			return new Date( now.time - start.time );	
		}		

		private var start:Date;
		private var now:Date;
		private var timer:Timer;
	}
}