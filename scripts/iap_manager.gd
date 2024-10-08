extends Node

signal unlock_new_skin

var google_payment = null


func _ready():
	if Engine.has_singleton("GodotGooglePlayBilling"):
		google_payment = Engine.get_singleton("GodotGooglePlayBilling")
		MyUtility.add_log_msg("Android IAP support is enabled")

		# Subscribe callback for IAP Google API.
		google_payment.connected.connect(_on_connected)
		google_payment.connect_error.connect(_on_connect_error)
		google_payment.disconnected.connect(_on_disconnected)

		google_payment.startConnection()
	else:
		MyUtility.add_log_msg("Android IAP support is not available")


func purchase_skin():
	unlock_new_skin.emit()


func _on_connected():
	MyUtility.add_log_msg("Connected to Google IAP service")


func _on_connect_error(response_id: int, debug_msg: String):
	MyUtility.add_log_msg(
		(
			"Error connection to Google IAP service. Reponse_id="
			+ str(response_id)
			+ ", debug_msg="
			+ str(debug_msg)
		)
	)


func _on_disconnected():
	MyUtility.add_log_msg("Disconnected from Google IAP service")
