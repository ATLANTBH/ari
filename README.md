Ari
===

Active Record Inspector - extend rails project to easily display and navigate through ActiveRecord Models. Ari will display model data including columns, relations (has and belongs) and custom functions. It's easy to customize and extend Ari for your purposes.

Features
--------

* Generators - automatically generate Ari controller and corresponding views
* Ari will display both belongs to and has relations as links for easy navigation
* Customize each model which columns you don't wanna to display
* Add functions that you like to display

Requirements
--------
* Rails 3+

Installation
--------

Install 'ari' gem:

```
gem 'ari'
```

or

```
gem 'ari', :git => git://github.com/ATLANTBH/ari.git
```
	
Note: Currently ari was tested only on rails 3.0+	
	
Setup
--------

After installation run ari generator.

```
rails generate ari
```
	
Add following resource to routes.rb.

```
resources :ari, :only => [:index, :show]
```
	
Run rails and point your browser to ari route, e.g. http://localhost:3000/ari

Customization
--------

By default ari will display following information from model:

* all columns
* all has_ relations
* all belongs_ relations

You can exclude informations via ari_options

```
class User < ActiveRecord::Base
	ari_options	:exclude => [:password, :money]
end
```

This will exclude columns/relations names 'password' and 'money' from displaying.

In addition to excluding, sometimes is good idea to include results from some functions, e.g.

```
class User < ActiveRecord::Base
	ari_options	:exclude => [:password, :money], :functions => ['displayable_name']
	
	def displayable_name
		return self.name || self.email  # if name is nil return email as displayable_name
	end
end
```

Preview
------

Here is preview of ari:

[Model listing](https://github.com/ATLANTBH/ari/raw/master/images/table-list.png "Model listing")
[Sample table 1](https://github.com/ATLANTBH/ari/raw/master/images/sample-1.png "Sample table 1")
[Sample table 2](https://github.com/ATLANTBH/ari/raw/master/images/sample-2.png "Sample table 2")

Note
----

AriController is inherited from ActionController::Base and it's strongly recomanded to extend AriController
from some Admin-like controllers in production environment so it will not be accessible by everyone.

License
-------

Copyright 2012 AtlantBH

ari is licensed under the MIT License.

For more info see MIT_LICENSE file.
