class_name InteractableComponent extends Node


## Emitted when this object was just interacted with
## See func interact()
signal just_interacted(interacted_by: GridObject)

func interact(interacted_by : GridObject):
	just_interacted.emit(interacted_by)
