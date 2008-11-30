/*
 PureMVC Demo for AS3 - StopWatch
 Copyright(c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.puremvc.as3.demos.flex.stopwatch.controller
{
	import org.puremvc.as3.demos.flex.stopwatch.ApplicationFacade;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.utilities.statemachine.FSMInjector;

	/**
	 * Create and inject the StateMachine.
	 */
	public class InjectFSMCommand extends SimpleCommand
	{
		/**
		 * Inject the Finite State Machine.
		 * <P>
		 * Though the XML could come from anywhere, even loaded remotely,
		 * we are simply creating it here in this command since it is 
		 * easy to refefence the StopWatch ACTION and STATE constants,
		 * so they will match up with the events acutally being sent from
		 * the stopwatch view.</P>
		 * 
		 * <P>
		 * Then we use the <code>FSMInjector</code> to create the configured 
		 * <code>StateMachine</code> from the XML FSM description and 'inject' 
		 * it into the PureMVC apparatus.</P>
		 *
		 * <P> 
		 * The <code>StateMachine</code> is registered as an <code>IMediator</code>, 
		 * interested in <code>StateMachine.ACTION</code> Notifications. The 
		 * <code>type</code> parameter of those Notifications must be a valid 
		 * registered <code>State</code> in the FSM.</P>
		 */
		override public function execute ( note:INotification ) : void
		{
			// Create the FSM definition
			var fsm:XML = 
			<fsm initial={StopWatch.STATE_READY}>
			   <state name={StopWatch.STATE_READY} entering={ApplicationFacade.RESET_DISPLAY}>
			       <transition action={StopWatch.ACTION_START} target={StopWatch.STATE_RUNNING}/>
			   </state>
			   <state name={StopWatch.STATE_RUNNING} entering={ApplicationFacade.ENSURE_TIMER}>
			       <transition action={StopWatch.ACTION_SPLIT} target={StopWatch.STATE_PAUSED}/>
			       <transition action={StopWatch.ACTION_STOP}  target={StopWatch.STATE_STOPPED}/>
			   </state>
			   <state name={StopWatch.STATE_PAUSED} entering={ApplicationFacade.FREEZE_DISPLAY}>
			       <transition action={StopWatch.ACTION_UNSPLIT} target={StopWatch.STATE_RUNNING}/>
			       <transition action={StopWatch.ACTION_STOP}	 target={StopWatch.STATE_STOPPED}/>
			   </state>
			   <state name={StopWatch.STATE_STOPPED} entering={ApplicationFacade.STOP_TIMER}>
			       <transition action={StopWatch.ACTION_RESET} target={StopWatch.STATE_READY}/>
			   </state>
			</fsm>;
			
			// Create and inject the StateMachine 
			var injector:FSMInjector = new FSMInjector( fsm );
			injector.inject();
		}
	}
}
