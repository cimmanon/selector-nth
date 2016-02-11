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
				@at-root #{selector-nth(&, 2, smart-append-selector, '.new')} {
					color: blue;
				}
			}
		}
	}
}
```

Output:

```css
.one-a two.new three:before, .one-b two.new three:before {
  color: blue;
}
```

Using the function directly allows for easier debugging, but mixins are more convenient to use.

```scss
.one-a, .one-b {
	two {
		three {
			&:before {
				@debug selector-nth(&, -1, smart-append-selector, '.new');
				@debug selector-nth(&, -2, smart-append-selector, '.new');
				@debug selector-nth(&, -3, smart-append-selector, '.new');
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
				@at-root #{selector-nth(&, 3, smart-append-selector, '.new')} {
					color: green;
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
			@at-root #{selector-nth(&, 2, add-sibling-selector)} {
				color: blue;
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
.one-a two + two three, .one-b two + two three {
  color: blue;
}
.one-a two three ~ three, .one-b two three ~ three {
  color: green;
}
```

# Append attribute selector value

The `smart-append-attribute-selector` function takes an optional 2nd argument.  By default it uses a hyphen when appending the new attribute value to an existing attribute value.


```scss
.one-a, .one-b {
	two {
		three[foo], three[foo="boo"], three[foo='moo'] {
			&:before {
				@at-root #{selector-nth(&, 3, smart-append-attribute-selector, 'xyz')} {

				@include nth-append-attribute-selector(3, 'new') {
					color: green;
				}
			}
		}
	}
}
```

Output:

```css
.one-a two three[foo="new"]:before, .one-a two three[foo="boo-new"]:before, .one-a two three[foo='moo-new']:before,
.one-b two three[foo="new"]:before, .one-b two three[foo="boo-new"]:before, .one-b two three[foo='moo-new']:before {
  color: green;
}
```

# Removing a selector

Ever wanted to remove a selector for whatever reason?

```scss
.one-a, .one-b {
	two {
		three {
			@at-root #{selector-nth(&, 2, remove-selector)} {
				color: blue;
			}

			@include nth-remove-selector(2) {
				color: blue;
			}
		}
	}
}
```

Output:

```css
.one-a three, .one-b three {
  color: blue;
}
```
