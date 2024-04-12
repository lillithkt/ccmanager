sharedWs.connect()

pcall(sharedWs.loop)

lvn.chat.send("Websocket crashed, rebooting...")

print("Websocket crashed, rebooting...")

sleep(5)

os.reboot()