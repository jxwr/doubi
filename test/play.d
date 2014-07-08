
// datatype
list0 = [1,2,3,4]
list1 = [1,2,
      4,5]

empty_dict = #{}

dict = #{ 
     "name": "jxwr"
     "age": 123 
     }

dict = #{ "name": "jxwr",
     "age": 123 }

dict = #{ "name": "jxwr",
     "age": 123,
     }

dict = #{ 
     "name": "jxwr",
     "age": 123,
     }

empty_set = #[]

a,b,c = 8,9,10
set = #[1,2,3,4,a,b,c]

set = #[1,2,3,4,
    a,b,c]

set = #[1,
    2,
    b,
    c]

set = #[    
    1, a, c
]

print(list0, "\n", list1, "\n", empty_dict, "\n", dict, "\n", set, "\n")

// 

a = 100 + 3 * 123 
b = a + 2

print("a", a, "\n")
print("b", b, "\n")

c = [1,2,3,4]

print(c, "\n")
print(100 + c[3], "\n")
print(c[0] + c[1] + c[2] + c[3], "\n")

func println(str) {
     print(str, "\n")
}

println("fun decl")

func add(a, b) {
     return a + b
}

println(add(1, 200))

c[0] = 1000
println(c[0])

c.len = func() {
         return 2 * (c[0] + 1)
}

println(c.len())
c[0] = 132
println(c.len())

if 2 > 1 {
  println("true")
} else {
  println("false")
}

if false {
  println("true")
} else {
  println("false")
}

a = 500
a++
a++
a.b = 998
a.b++
a.b++
println(a)
println(a.b)

for i = 0; i < 3; i++ {
    print(i,"")
}

for i, v = range c {
    print(i, "=", v, "\n")
    return true
}

list = [1,2,3,4]
list.append(5)
println(list)

cl = [1,2,3,4] + [5,6,7,8]
println(cl)
println(cl[1:8])

base = 99
print("abs:", -100.abs(), "\n")
11.times(func(i){b 
  if i % 2 == 0 { 
    print(i, "") 
  }
})

list = ["hello", "world"]
list.name = func() {
  return list[0] + " " + list[1]
}

println(list.name())

func printA() {
     for i = 0; i< 1000; i {
     	 print("A")
     }
}

person = #{
  "name": "jiaoxiang",
  "age": 28,
  "summary": func(obj) {
     println(obj["name"] + ":" + obj["age"])
  }
}

person.weight = 125
println(person)

person.summary(person)

//hello
i = 0

func testLoop() {
	for i < 10 {
		i++
    
		if i == 2 {
			n = 0
			for n < 5 {
				n++
				if n == 3 {
					break
					print("break")
				}
				print("[", n, "]")	
			} 
			continue
		}

		if i == 9 {
			println("quit")
			return i
			print("never reach here")
		}
		print(i, "")
	}
}

n = testLoop()
println("return:"+n)

// 1 [ 1 ] [ 2 ] 3 4 5 6 7 8 quit
// return: 9

// custom print function
println(220)

// 

func test0(n) {
     sum = 0
     for i = 0; i < n; i++ {
         sum += i
     }
     return sum
}

func test1() {
     n = 100

     a = test0(n)

     print("a", a, "\n")

     b = test0(n)
     
     c = a + b
     print("c", c, "\n")
}

func test2(n) {
     a = n
     print("test2\n")
     return a + 1
}

func test3() {
     print("test3\n")
     m = test2(123)
     print(m, "\n")
}

test1()
bb = test2(888)
print(bb, "\n")
test3()

func fib(n) {
    if n < 2 {
        return n
    }
    return fib(n-2) + fib(n-1)
}

for i = 0; i < 20; i++ {
    print(fib(i), "")
}
print("\n")
