const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp();

// Sends a push notification to everyone subscribed to the "chat" topic
// whenever a new message is added to the chat collection.
exports.sendChatNotification = onDocumentCreated("chat/{messageId}", (event) => {
  const data = event.data?.data();
  if (!data) {
    return null;
  }

  return admin.messaging().send({
    notification: {
      title: data.username,
      body: data.text,
    },
    data: {
      click_action: "FLUTTER_NOTIFICATION_CLICK",
    },
    topic: "chat",
  });
});
