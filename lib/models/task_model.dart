class TaskModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isDone" : isDone,
      "id" : id,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json){
    return TaskModel(
        id: json["id"],
        taskName: json["taskName"],
        taskDescription: json["taskDescription"],
        isHighPriority: json["isHighPriority"],
        isDone: json["isDone"] ?? false,
    );
  }

}
