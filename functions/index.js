const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.pushNotification = functions.firestore
  .document("/chat/{message}")
  .onCreate((snapshot, context) => {
    const data = snapshot.data();

    return admin.messaging().sendToTopic("chat", {
      notification: {
        title: data["userName"],
        body: data["text"],
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });
