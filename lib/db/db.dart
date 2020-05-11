import 'package:flt_task_board/models/board_model.dart';
import 'package:flt_task_board/models/task_lane_model.dart';
import 'package:flt_task_board/models/task_model.dart';
import 'package:flt_task_board/models/user_model.dart';

class DB {
  static DB _instance;

  factory DB() => _instance ??= new DB._internal();

  DB._internal();

  // moveTaskAcrossLanes({Task task,TaskLane toLane}){

  // }

  final users = <User>[
    User(
        id: 1,
        name: 'hareesh',
        avatar: 'https://picsum.photos/100/100?random=3'),
    User(
        id: 2, name: 'laasya', avatar: 'https://picsum.photos/100/100?random=2')
  ];

  final boards = <Board>[
    Board(id: 1, title: 'Testing'),
    Board(id: 2, title: 'Production')
  ];

  final lanes = <TaskLane>[
    TaskLane(id: 1, title: 'To do', boardId: 1, order: 1),
    TaskLane(id: 2, title: 'In progress', boardId: 1, order: 2),
    TaskLane(id: 3, title: 'In review', boardId: 1, order: 3),
    TaskLane(id: 4, title: 'Done', boardId: 1, order: 4)
  ];

  final tasks = <Task>[
    Task(
      id: 1,
      title: 'Mobile Wireframes',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 1,
      assignedTo: 1,
    ),
    Task(
      id: 2,
      title: 'User Research',
      dueBy: DateTime.parse('2020-05-12'),
      description:
          'Some methods may be better than others, depending on time constraints, system maturity, type of product the solution may differ. Which should be handled by the system administrators using special tools.',
      boardId: 1,
      laneId: 1,
      assignedTo: 2,
    ),
    Task(
      id: 3,
      title: 'Client Call',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 1,
      assignedTo: 1,
    ),
    Task(
      id: 4,
      title: 'Login Flow',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 2,
      assignedTo: 1,
    ),
    Task(
      id: 5,
      title: 'Forgot Password Screen',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 2,
      assignedTo: 1,
    ),
    Task(
      id: 6,
      title: 'Landing Page',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 3,
      assignedTo: 1,
    ),
    Task(
      id: 7,
      title: 'Annual Presentation',
      dueBy: DateTime.parse('2020-05-12'),
      description:
          'Regardless of who is persuing the report, what is sought is accurate information revealing an overall team effor to be conted as the team work.',
      boardId: 1,
      laneId: 3,
      assignedTo: 1,
    ),
    Task(
      id: 8,
      title: 'Icons',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 3,
      assignedTo: 2,
    ),
    Task(
      id: 9,
      title: 'Onboarding Screens',
      dueBy: DateTime.parse('2020-05-12'),
      description:
          'Introduce the app and demonstrate what it does in few steps.',
      boardId: 1,
      laneId: 3,
      assignedTo: 1,
    ),
    Task(
      id: 10,
      title: 'Product Mockups',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 4,
      assignedTo: 2,
    ),
    Task(
      id: 11,
      title: 'Workshop Ideas',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 4,
      assignedTo: 1,
    ),
    Task(
      id: 12,
      title: 'Navigation',
      dueBy: DateTime.parse('2020-05-12'),
      description: '',
      boardId: 1,
      laneId: 4,
      assignedTo: 2,
    ),
  ];
}
