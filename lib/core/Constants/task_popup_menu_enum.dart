enum TaskPopupMenuEnum{
  toggleDoneMark(name: "Toggle Done Mark"),
  edit(name: "Edit"),
  delete(name: "Delete");

  final String name;

  const TaskPopupMenuEnum({required this.name});
}