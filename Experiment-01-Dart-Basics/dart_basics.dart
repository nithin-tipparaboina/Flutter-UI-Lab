void main() {

  int age = 20;
  double weight = 54.0;
  String name = "FitTrack";
  bool isActive = true;

  print("Name: $name");
  print("Age: $age");
  print("Weight: $weight kg");
  print("Active: $isActive");


  int a = 20;
  int b = 10;

  print("Addition: ${a + b}");
  print("Subtraction: ${a - b}");
  print("Multiplication: ${a * b}");
  print("Division: ${a / b}");
  print("Sum using function: ${add(5, 10)}");

  
  int marks = 85;

  if (marks >= 35) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }
}

int add(int a, int b) {
  return a + b;
}