//Logic of our application
//The below seven steps are followed to write bloc code for any application.
//imports

//List of employees

//Stream Controller: - It is a class which has couple of methods sink and stream
//Stream controller is going to defined for everything for any object or any functionality
//For performing any function we  have to send in some data and we get some data back so we have to do that

//Stream Sink getter

//Constructor - add data;  Listen to changes

//Core functions

//dispose :- Means calling up all the stream and free the resources

//1st step
import 'dart:async';
import 'Employee.dart';

//2nd step
class EmployeeBloc {
  //sink to add in pipe
  //stream get data from pipe
  //by pipe i mean data flow
  List<Employee> _employeeList = [
    Employee(1, 'Employee1', 10000.0),
    Employee(2, 'Employee2', 20000.0),
    Employee(3, 'Employee3', 30000.0),
    Employee(4, 'Employee4', 40000.0),
    Employee(5, 'Employee5', 50000.0),
  ];

  //3rd step
  final _employeeListStreamController = StreamController<List<Employee>>();

//for increment and decrement
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //getters

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

//you can call the constructor to initialize the data or call as per user needs
  EmployeeBloc() {
    //to add data
    _employeeListStreamController.add(_employeeList);

    //to listen to changes
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);

    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
