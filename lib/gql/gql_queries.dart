const String kGQL_BoardFullDetails = r'''
query($boardId:ID!){
  boards(id:$boardId){
    id
    title
    lanes{
      id
      title
      order
      tasks{
        id
        title
        description
        order
        dueBy
        assignedTo{
          id
          name
          avatar
        }
      }
    }
  }
}
''';
const String kGQL_CreateTask = r'''
mutation createTask($taskInput:TaskCreateInput!){
  createTask(input:$taskInput){
    id
    title
    dueBy
    order
    board{
      id
      title
    }
    lane{
      id
      title
    }
    assignedTo{
      id
      name
    }
  }
}
''';
const String kGQL_UpdateTask = r'''
mutation updateTask($taskId:ID!,$taskInput:TaskUpdateInput!){
  updateTask(id:$taskId,input:$taskInput){
    id
    title
    dueBy
    order
    board{
      id
      title
    }
    lane{
      id
      title
    }
    assignedTo{
      id
      name
    }
  }
}
''';
const String kGQL_DeleteTask = r'''
mutation deleteTask($taskId:ID!){
  deleteTask(id:$taskId)
}
''';
const String kGQL_TaskEditListValues = r'''
query($boardId:ID!){
  lanes(board:$boardId){
    id
    title
  }
  users{
    id
    name
  }    
}
''';
const String kGQL_AllBoards = r'''
query{
  boards{
    id
    title
  }
}
''';
const String kGQL_AllLanes = r'''
query{
  lanes{
    id
    title
  }
}
''';
const String kGQL_AllUsers = r'''
query{
  users{
    id
    name
  }
}
''';
const String kGQL_MoveTask = r'''
mutation moveTask($taskId: ID!, $toLane: ID, $toItemOrder: Int!) {
  moveTask(id: $taskId, toLane: $toLane, toItemOrder: $toItemOrder) {
    id
    title
    order
    lane {
      id
      title
    }
  }
}
''';

const String kGQL_MoveLane = r'''
mutation moveLane($laneId:ID!,$toLaneOrder:Int!){
  moveLane(id:$laneId,toLaneOrder:$toLaneOrder){
    id
    title
    order
    board{
      id
      title
    }
  }
}
''';

const String kGQL_SearchTasks = r'''
query($boardId:ID!,$searchQuery:String){
  boards(id:$boardId){
    id
    title
    lanes{
      id
      title
      order
      tasks(searchQuery:$searchQuery){
        id
        title
        description
        order
        dueBy
        assignedTo{
          id
          name
          avatar
        }
      }
    }
  }
}
''';
