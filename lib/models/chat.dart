class Chat {
  final int id;
  final String title;

  const Chat({
    this.id,
    this.title
  });
}

// Pár chat, amit megjelenítünk
const CHATS = [
  Chat(
      id: 0,
      title: 'Generális'
  ),
  Chat(
      id: 1,
      title: 'Shitposta'
  ),
];