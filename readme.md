This library provides a collection of Sass functions for modifying the middle of a selector.  Also included are convenient helper functions and mixins for commonly used operations.

# How it works

The `selector-nth` function has 4 arguments:

* The selector you are working with, this will usually be `&`
* The position you want to modify (positive numbers start from the beginning, negative numbers start from the end)
* The name of the function you want to run on whatever is in the position specified in argument #2 (must accept at least one argument: the value at the designated position)
* A catchall for any extra arguments you want to pass to the function from argument #3

```scss
.one-a, .one-b {
	two {
		three {
			&:before {
				@at-root #{selector-nth(&, 1, append-smart-selector, '.new')} {
					color: red;
				}

				@at-root #{selector-nth(&, 2, append-smart-selector, '.new')} {
					color: blue;
				}

				@at-root #{selector-nth(&, 3, append-smart-selector, '.new')} {
					color: green;
				}
			}
		}
	}
}
```

Output:

```css
.one-a.new two three:before, .one-b.new two three:before {
  color: red;
}
.one-a two.new three:before, .one-b two.new three:before {
  color: blue;
}
.one-a two three.new:before, .one-b two three.new:before {
  color: green;
}
```

Using the function directly allows for easier debugging, but mixins are more convenient to use.

```scss
.one-a, .one-b {
	two {
		three {
			&:before {
				@debug selector-nth(&, -1, append-smart-selector, '.new');
				@debug selector-nth(&, -2, append-smart-selector, '.new');
				@debug selector-nth(&, -3, append-smart-selector, '.new');
			}
		}
	}
}
```


# Appending a selector

This function will properly insert a selector ensuring that element selectors are at the beginning and pseudo selectors are at the end.

```scss
.one-a, .one-b {
	two {
		three {
			&:before {
				@include nth-append-selector(1, '.new') {
					color: red;
				}

				@include nth-append-selector(2, '.new') {
					color: blue;
				}

				@include nth-append-selector(3, '.new') {
					color: green;
				}
			}
		}
	}
}
```

Output:

```css
.one-a.new two three:before, .one-b.new two three:before {
  color: red;
}
.one-a two.new three:before, .one-b two.new three:before {
  color: blue;
}
.one-a two three.new:before, .one-b two three.new:before {
  color: green;
}
```

# Appending a sibling selector

The `add-sibling-selector` function takes an optional 2nd argument.  By default it uses the `+` operator, but you can pass in `~` instead.

```scss
.one-a, .one-b {
	two {
		three {
			@include nth-sibling-selector(1) {
				color: red;
			}

			@include nth-sibling-selector(2) {
				color: blue;
			}

			@include nth-sibling-selector(3, '~') {
				color: green;
			}
		}
	}
}
```

Output:

```css
.one-a + .one-a two three, .one-b + .one-b two three {
  color: red;
}
.one-a two + two three, .one-b two + two three {
  color: blue;
}
.one-a two three ~ three, .one-b two three ~ three {
  color: green;
}
```

# Removing a selector

Ever wanted to remove a selector for whatever reason?

```scss
.one-a, .one-b {
	two {
		three {
			@include nth-remove-selector(1) {
				color: red;
			}

			@include nth-remove-selector(2) {
				color: blue;
			}

			@include nth-remove-selector(3) {
				color: green;
			}
		}
	}
}
```

Output:

```css
two three, two three {
  color: red;
}
.one-a three, .one-b three {
  color: blue;
}
.one-a two, .one-b two {
  color: green;
}
```
