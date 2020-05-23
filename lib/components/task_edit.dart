// Define a custom Form widget.
import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/models/task_lane_model.dart';
import 'package:flt_task_board/models/task_model.dart';
import 'package:flt_task_board/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';

typedef OnTaskEditCreate = void Function(Task task);
typedef OnTaskEditUpdate = void Function(Task task);
typedef OnTaskEditDelete = void Function(Task task);

class TaskEditForm extends StatefulWidget {
  final Task task;
  final List<User> users;
  final List<TaskLane> lanes;
  final OnTaskEditCreate onCreate;
  final OnTaskEditUpdate onUpdate;
  final OnTaskEditDelete onDelete;
  TaskEditForm(
      {this.task,
      this.users,
      this.lanes,
      this.onCreate,
      this.onUpdate,
      this.onDelete});
  @override
  TaskEditFormState createState() {
    return TaskEditFormState();
  }
}

class TaskEditFormState extends State<TaskEditForm> {
  final _formKey = GlobalKey<FormState>();
  var titleCtrl, descriptionCtrl;

  User _selectedUser;
  TaskLane _selectedLane;
  Task _updatedTask;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    titleCtrl = TextEditingController(text: widget.task.title);
    descriptionCtrl = TextEditingController(text: widget.task.description);

    _updatedTask = widget.task.copyWith();

    _userDDLB = buildUsersDDLBItems(widget.users);
    try {
      _selectedUser =
          widget.users.firstWhere((user) => user.id == widget.task.assignedTo);
    } catch (e) {}
    _laneDDLB = buildLanesDDLBItems(widget.lanes);
    try {
      _selectedLane =
          widget.lanes.firstWhere((lane) => lane.id == widget.task.laneId);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem<User>> _userDDLB;
  List<DropdownMenuItem<TaskLane>> _laneDDLB;
  List<DropdownMenuItem<User>> buildUsersDDLBItems(List users) {
    List<DropdownMenuItem<User>> items = List();
    for (User user in users) {
      items.add(
        DropdownMenuItem(
          value: user,
          child: Text(user.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<TaskLane>> buildLanesDDLBItems(List lanes) {
    List<DropdownMenuItem<TaskLane>> items = List();
    for (TaskLane lane in lanes) {
      items.add(
        DropdownMenuItem(
          value: lane,
          child: Text(lane.title),
        ),
      );
    }
    return items;
  }

  onChangeUserDDLB(User selectedUser) {
    setState(() {
      _selectedUser = selectedUser;
    });
  }

  onChangeLaneDDLB(TaskLane selectedLane) {
    setState(() {
      _selectedLane = selectedLane;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 500,
      padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
            child: Text(
              widget.task.id == 0 ? 'Create Task' : 'Update Task',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: titleCtrl,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Title';
                    }
                    return null;
                  },
                  onSaved: (newTitle) =>
                      {_updatedTask = _updatedTask.copyWith(title: newTitle)},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: kRoundedBorderRadius,
                    ),
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    hintText: 'Give a Title for the Task here',
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: descriptionCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: kRoundedBorderRadius,
                    ),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    hintText: 'Give a Description of the Task',
                  ),
                  style: TextStyle(color: Colors.black),
                  onSaved: (newDescription) => {
                    _updatedTask =
                        _updatedTask.copyWith(description: newDescription)
                  },
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField(
                  // iconSize: 24,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: kRoundedBorderRadius,
                    ),
                    isDense: true,
                    labelText: 'Assigned To',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  value: _selectedUser,
                  items: _userDDLB,
                  onChanged: onChangeUserDDLB,
                  validator: (selectedUser) {
                    if (selectedUser == null) {
                      return 'Please select User';
                    }
                    return null;
                  },
                  onSaved: (selectedUser) => {
                    if (selectedUser != null)
                      _updatedTask = _updatedTask.copyWith(
                          assignedTo: selectedUser.id, user: selectedUser)
                  },
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField(
                  // iconSize: 24,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: kRoundedBorderRadius,
                    ),
                    isDense: true,
                    labelText: 'Lane',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  value: _selectedLane,
                  items: _laneDDLB,
                  onChanged: onChangeLaneDDLB,
                  validator: (selectedLane) {
                    if (selectedLane == null) {
                      return 'Please select Lane';
                    }
                    return null;
                  },
                  onSaved: (selectedLane) => {
                    if (selectedLane != null)
                      _updatedTask =
                          _updatedTask.copyWith(laneId: selectedLane.id)
                  },
                ),
              ],
            ),
          ),
          ButtonBar(
            children: <Widget>[
              (widget.task.id == 0)
                  ? SizedBox(width: 0)
                  : RaisedButton.icon(
                      icon: FaIcon(Icons.save),
                      color: Colors.redAccent,
                      onPressed: () {
                        widget.onDelete(_updatedTask);
                      },
                      label: Text('Delete'),
                    ),
              RaisedButton.icon(
                icon: FaIcon(Icons.save),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print('saving ${widget.task.id}');
                    (widget.task.id == 0)
                        ? widget.onCreate(_updatedTask)
                        : widget.onUpdate(_updatedTask);
                  }
                },
                label: (widget.task.id == 0) ? Text('Create') : Text('Update'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
