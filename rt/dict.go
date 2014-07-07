package rt

import (
	"fmt"
)

/// dict

type DictObject struct {
	Property
}

func (self *DictObject) Name() string {
	return "dict"
}

func (self *DictObject) HashCode() string {
	return fmt.Sprintf("%p", self)
}

func (self *DictObject) String() string {
	s := "#{"

	ln := len(self.Property.Slots)
	idx := 0
	for key, val := range self.Property.Slots {
		s += key
		s += ":"
		s += val.String()
		if idx < ln-1 {
			s += ","
		}
		idx++
	}
	s += "}"
	return s
}

func (self *DictObject) ToString(rt *Runtime, args ...Object) []Object {
	return []Object{rt.NewStringObject(self.String())}
}

func (self *DictObject) OP__get_index__(rt *Runtime, args ...Object) (results []Object) {
	idx := args[0]
	results = append(results, self.GetProp(idx.HashCode()))
	return
}

func (self *DictObject) OP__set_index__(rt *Runtime, args ...Object) (results []Object) {
	idx := args[0]
	val := args[1]
	self.SetProp(idx.HashCode(), val)
	return
}