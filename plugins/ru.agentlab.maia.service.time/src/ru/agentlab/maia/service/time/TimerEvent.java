package ru.agentlab.maia.service.time;

import java.util.UUID;

public class TimerEvent {

	final UUID eventKey;

	public TimerEvent(UUID eventKey) {
		this.eventKey = eventKey;
	}

	public UUID getEventKey() {
		return eventKey;
	}
	
}
