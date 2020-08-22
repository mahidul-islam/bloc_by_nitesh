// 1 import
// 2 list
// 3 stream controller
// 4 stream sink getter
// 5 constractor add data; listen to change
// 6 core functions
// 7 dispose

import 'dart:async';
import 'employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "One", 100),
    Employee(2, "Two", 100),
    Employee(3, "Three", 100),
    Employee(4, "Four", 100),
    Employee(5, "Five", 100),
    Employee(6, "Six", 100),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  final _employeeSalaryIncStreamController = StreamController<Employee>();
  final _employeeSalaryDecStreamController = StreamController<Employee>();

  // getters

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecStreamController.sink;

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecStreamController.stream.listen(_decrementSalary);
  }
  _incrementSalary(Employee employee) {
    double incrementSalary = employee.salary * (20 / 100);
    _employeeList[employee.id - 1].salary =
        num.parse((employee.salary + incrementSalary).toStringAsFixed(2));
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double decrementSalary = employee.salary * (20 / 100);
    _employeeList[employee.id - 1].salary =
        num.parse((employee.salary - decrementSalary).toStringAsFixed(2));
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncStreamController.close();
    _employeeSalaryDecStreamController.close();
  }
}
