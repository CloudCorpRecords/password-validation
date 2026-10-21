package main

import (
	"reflect"
	"testing"
)

func TestProblemExample(t *testing.T) {
	got := GetPasswordStrength(
		[]string{"iliketoCoDe", "teaMAKEsmehappy", "123456789", "xYz12", "password"},
		[]string{"coffee", "code", "happy"},
	)
	want := []string{"strong", "weak", "weak", "weak", "weak"}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("got %v, want %v", got, want)
	}
}

func TestIsWeak(t *testing.T) {
	cases := []struct {
		pwd   string
		words []string
		want  bool
	}{
		{"Abc12", nil, true},
		{"Abc123", nil, false},
		{"123456", nil, true},
		{"12345a", nil, false},
		{"abcdefg", nil, true},
		{"ABCDEFG", nil, true},
		{"Abcdefg", nil, false},
		{"mycoffeecup1", []string{"coffee"}, true},
		{"myCoffeeCup", []string{"coffee"}, false},
		{"Abc123", []string{""}, false},
	}
	for _, c := range cases {
		if got := IsWeak(c.pwd, c.words); got != c.want {
			t.Errorf("IsWeak(%q, %v) = %v, want %v", c.pwd, c.words, got, c.want)
		}
	}
}
