package ru.agentlab.maia.task.adapter.json.internal

import java.util.Hashtable
import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.task.ITaskRegistry
import ru.agentlab.maia.task.adapter.json.JsonTaskAdapter
import ru.agentlab.maia.task.adapter.IAdapter

class Activator implements BundleActivator {

	@Accessors
	var static BundleContext context

	override start(BundleContext context) throws Exception {
		Activator.context = context

		val reference = context.getServiceReference(ITaskRegistry)
		if (reference != null) {
			val registry = context.getService(reference)
			if (registry != null) {
				val properties = new Hashtable<String, Object> => [
					put(IAdapter.KEY_LANGUAGE, JsonTaskAdapter.JSON)
//					put(ITaskAdapter.KEY_TYPE, TaskSchedulerOrdered)
				]
				context.registerService(IAdapter, new JsonTaskAdapter(registry), properties)
			}
		}
//		val properties = new Hashtable<String, Object> => [
//			put(ITaskModifier.KEY_TYPE, TaskSchedulerOrdered)
//		]
//		context.registerService(ITaskModifier, new SequentialTaskSchedulerModifier, properties)
//		val properties2 = new Hashtable<String, Object> => [
//			put(ITaskAdapter.KEY_LANGUAGE, "json")
//			put(ITaskAdapter.KEY_TYPE, TaskSchedulerOrdered)
//		]
//		context.registerService(ITaskAdapter, new JsonTaskSchedulerAdapter, properties2)
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}