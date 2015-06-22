package ru.agentlab.maia.context.injector.e4

import java.util.ArrayList
import java.util.Collection
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.eclipse.xtend2.lib.StringConcatenation
import ru.agentlab.maia.context.IMaiaContext

class E4MaiaContext implements IMaiaContext {

//	var IMaiaEventBroker broker

	package IEclipseContext context

	@Inject
	new(IEclipseContext context) {
		this.context = context
//		this.broker = broker
	}

	override getParent() {
		return get(KEY_PARENT_CONTEXT) as IMaiaContext
	}

	override getChilds() {
		var result = getLocal(KEY_CHILD_CONTEXTS) as Collection<IMaiaContext>
		if (result == null) {
			result = new ArrayList<IMaiaContext>
			set(KEY_CHILD_CONTEXTS, result)
		}
		return result
	}

	override get(String name) {
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		return context.get(name)
	}

	override <T> get(Class<T> clazz) {
		if (clazz == IEclipseContext) {
			return context as T
		}
		return context.get(clazz)
	}

	override getLocal(String name) {
		if (IEclipseContext.name.equalsIgnoreCase(name)) {
			return context
		}
		return context.getLocal(name)
	}

	override <T> getLocal(Class<T> clazz) {
		if (clazz == IEclipseContext) {
			return context as T
		}
		return context.getLocal(clazz)
	}

	override remove(String name) {
		val old = context.getLocal(name)
		context.remove(name)
//		if (old != null) {
//			broker.post(new MaiaContextRemoveObjectEvent(old))
//		}
	}

	override remove(Class<?> clazz) {
		val old = context.getLocal(clazz)
		context.remove(clazz)
//		if (old != null) {
//			broker.post(new MaiaContextRemoveObjectEvent(old))
//		}
	}

	override set(String name, Object value) {
		val old = context.getLocal(name)
		context.set(name, value)
//		if (old == null) {
//			broker.post(new MaiaContextSetObjectEvent(this, value))
//		} else {
//			broker.post(new MaiaContextChangeObjectEvent(old, value))
//		}
	}

	override <T> set(Class<T> clazz, T value) {
		val old = context.getLocal(clazz)
		context.set(clazz, value)
//		if (old == null) {
//			broker.post(new MaiaContextSetObjectEvent(this, value))
//		} else {
//			broker.post(new MaiaContextChangeObjectEvent(old, value))
//		}
	}

	override toString() {
		context.toString
	}

	override String dump() {
		var StringConcatenation result = ''''''
		result.newLine
		var current = this
		while (current != null) {
			result.append("[" + current + "] contains:")
			result.newLine
			val list = (current.context as EclipseContext).localData.keySet.filter [
				it != "org.eclipse.e4.core.internal.contexts.ContextObjectSupplier" && //				it != "ru.agentlab.maia.context.IMaiaContext" && 
				it != "debugString" && it != "parentContext"
			].sortWith [ a, b |
				a.compareTo(b)
			]
			for (p1 : list) {
				result.append("	[" + p1 + "] -> [" + (current.context as EclipseContext).localData.get(p1) + "]")
				result.newLine
			}
			current = current.parent  as E4MaiaContext
		}
		return result.toString
	}

}