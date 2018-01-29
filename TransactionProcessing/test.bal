struct Person {
    string name;
    int age;
    string city;
}function main (string[] args) {
     json<Person> person = {name:"Jon"};
     person.age = 25;
     person.city = "Colombo";
     println(person);
     json employee = person;
     employee["profession"] = "Software Engineer";
     println(employee);
     json testJson = {name:"Hello"};
     testJson["age"] = 24;
     println(testJson);
 }