enum ExpenseCategory{
  foodanddrink,
  health,
  accessories,
  bill,
  transportation,
  clothing,
  other
}
enum IncomeCategory{
  salary,
  service,
  soldProperty
}
class CategoryUsage{
  String category;
  double amount;
  CategoryUsage(this.category,this.amount);  
}