
import "fmt"

10.Abs()
10.Times(func(i){fmt.Println(i)})

a = 10
a++

a += 10 // 21
a *= 2  // 42
a /= 3  // 14
a -= 5  // 9

if a * 3 == 81 / 3 {
	fmt.Println(true)
}