/*
 PureMVC Demo for AS3 - StopWatch
 Copyright(c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.stopwatch.view
{
	import flash.events.Event;
	
	import org.puremvc.as3.demos.flex.stopwatch.proxy.StopWatchProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.utilities.statemachine.State;
	import org.puremvc.as3.utilities.statemachine.StateMachine;

	public class ApplicationMediator extends Mediator
	{
		public static const NAME:String	= "ApplicationMediator";
	 
		public function ApplicationMediator( viewComponent:StopWatch ) 
		{
			super( NAME, viewComponent );
		}
	
		override public function onRegister( ):void
		{
			app.addEventListener( StopWatch.ACTION_STOP,    handleEvent );
			app.addEventListener( StopWatch.ACTION_START,   handleEvent );
			app.addEventListener( StopWatch.ACTION_RESET,   handleEvent );
			app.addEventListener( StopWatch.ACTION_SPLIT,   handleEvent );
			app.addEventListener( StopWatch.ACTION_UNSPLIT, handleEvent );
		}
	
		override public function listNotificationInterests():Array
		{
			return [ StopWatchProxy.TICK,
					 StopWatchProxy.LAP,
					 StopWatchProxy.SYNC,
					 StopWatchProxy.RESET,
					 StateMachine.CHANGED
					];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch ( note.getName() )
			{
				case StopWatchProxy.TICK:
					app.elapsed = note.getBody() as String;
					break;				

				case StopWatchProxy.LAP:
					app.laptime = note.getBody() as String;
					break;				

				case StopWatchProxy.SYNC:
				case StopWatchProxy.RESET:
					app.elapsed = note.getBody() as String;
					app.laptime = null;
					break;				
					
				case StateMachine.CHANGED:
					app.state = State( note.getBody() ).name;
					break;
			}
		}
	
		/**
		 * Handle events from the app.
		 * <P>
		 * For the StopWatch.ACTION_* events, we want to
		 * send a <code>StateMachine.ACTION</code> notification 
		 * with the event type being the action name.</P>
		 */  
		private function handleEvent( event:Event ):void
		{
			switch ( event.type ) 
			{
				case StopWatch.ACTION_STOP:
				case StopWatch.ACTION_START:
				case StopWatch.ACTION_RESET:
				case StopWatch.ACTION_UNSPLIT:
				case StopWatch.ACTION_SPLIT:
					sendNotification ( StateMachine.ACTION, null, event.type );
					break;
				
			}
		}
		
		public function get app():StopWatch
		{ 
			return viewComponent as StopWatch; 
		}
	}
}