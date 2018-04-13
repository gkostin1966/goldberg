# Genetic Algorithms in Search, Optimization, and Machine Learning
David E. Goldberg
The University of Alabama
Copyright (c) 1989 by Addision-Wesley Publishing Company, Inc.
ISBN 0-201-15767-5
***
[![Floobits Status](https://floobits.com/gkostin/goldberg.svg)](https://floobits.com/gkostin/goldberg/redirect)
## [Computer Assignments](https://github.com/gkostin1966/goldberg/wiki/Computer_Assignments)
[Chapter 1 / A Gentle Introduction to Genetic Algorithms](https://github.com/gkostin1966/goldberg/wiki/Chapter_1)
## Exercise Quick Setup Guide
### git
```
$ git init .
$ ls -a
./ ../ .git/
$
```
### Gemfile
```
$ bundle init
$ ls
Gemfile
$
```
### gems rspec & rubocop-rspec
```
$ echo 'gem "rspec"' >> Gemfile
$ echo 'gem "rubocop-rspec"' >> Gemfile
$ bundle install
Fetching gem metadata from https://rubygems.org/..........
...
Bundle complete! 2 Gemfile dependencies, 16 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
$ ls 
Gemfile Gemfile.lock
$ rspec --init
  create   .rspec
  create   spec/spec_helper.rb
$ ls -a
./ ../ .git/ .rspec Gemfile Gemfile.lock spec/
$ ls spec
spec_helper.rb
$ 
```
### lib
```
$ mkdir lib
$ touch lib/<filename>.rb
$ touch spec/<filename>_spec.rb
$
```
### rubocop
```
$ echo "require: rubocop-rspec"        > .rubocop.yml
$ echo "AllCops:"                     >> .rubocop.yml
$ echo "  Exclude:"                   >> .rubocop.yml
$ echo "    - 'spec/spec_helper.rb'"  >> .rubocop.yml
$ echo "Metrics/BlockLength:"         >> .rubocop.yml
$ echo "  Exclude:"                   >> .rubocop.yml
$ echo "    - 'spec/**/*'"            >> .rubocop.yml
$ rubocop
Inspecting 2 files
..
   
2 files inspected, no offenses detected
$
```
### rspec
```
$ rspec
No examples found.


Finished in 0.00044 seconds (files took 0.30251 seconds to load)
0 examples, 0 failures
$
```
### commit
```
$ git commit -m "initial commit"
$
```
***
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
