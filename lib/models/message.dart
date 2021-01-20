class Message {
  final int chatId;
  final String sender;
  final String content;
  final int timestamp;

  const Message({
    this.chatId,
    this.sender,
    this.content,
    this.timestamp
  });
}

// Pár üzenet, amit megjelenítünk
const MSGS = [
  Message(
    chatId: 0,
    sender: 'Tomi_Ohl',
    content: "Elso uzenet wew",
    timestamp: 1610970981
  ),
  Message(
    chatId: 0,
    sender: 'CJ4567',
    content: "Nice",
    timestamp: 1610970985
  ),
  Message(
    chatId: 1,
    sender: 'Shronk',
    content: "Kul",
    timestamp: 1610971002
  ),
  Message(
    chatId: 1,
    sender: 'Tomi_Ohl',
    content: "Two channels :monkayay:",
    timestamp: 1610971008
  ),
];