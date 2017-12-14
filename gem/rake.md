# Rake

## Intro

- rake stands for ruby maker
- specify tasks and its dependencies
- https://github.com/ruby/rake

## Feature

### Basic:

- ruby dsl
- define tasks
- define task dependencies
- define task with args or env variables
- define tasks in namespace
- define default task
- invoke other tasks

### Advanced:

- support rule pattern for implicit tasks
- support parallel execution of tasks
- support flexible file lists that act like array,
- library of prepackaged tasks to build Rakefile easier.

## Commands

- `rake` # run default task.
- `rake -T`  # list desc tasks.
- `rake -AT` # list all tasks.
- `rake --dry-run taskname` # show dependencies.
- `rake --rakefile taskfile taskname` # ...learn more...

## Test

1. write logic in model, then test model methods.
2. customize spec for rake tasts, check links below:
  - https://robots.thoughtbot.com/test-rake-tasks-like-a-boss
  - https://www.wetestrails.com/blog/test-rails-rake-tasks-with-rspec
  - https://github.com/eliotsykes/rails-testing-toolbox/blob/master/tasks.rb

## Examples

- define task:

```
  desc 'a'
  task :a do
    # TODO
  end

  rake a
```

- define task depends on rails env:

```
  task a: :environment do
    # TODO
  end

  rake a
```

- define task with namespace:

```
  namespace :foo do
    task a: :environment do
      # TODO
    end
  end

  rake foo:a
```

- define task with dependencies:

```
  namespace :foo do
    task a: [:b, :c, 'bar:c'] do
      # TODO
    end
  end

  rake foo:a
```

- invoke tasks (with args):

```
  namespace :foo do
    task :a do
      Rake::Task['foo:b'].invoke
      Rake::Task['foo:c'].invoke('1', '2')
      Rake::Task['bar:d'].invoke
      # TODO
    end
  end

  rake foo:a
```

- pass args to task:

```
  namespace :foo do
    task :a, [:arg_1, :arg_2] => :environment do |t, args|
      args.with_defaults(arg_1: "first", arg_2: "second")
      args.to_hash # => {:arg_1=>"1", :arg_2=>"2"}
      args.to_a # => ["1", "2"]
      args.arg_1 # '1'
      args.arg_2 # '2'
      # TODO
    end
  end

  rake 'foo:a[1,2]'
  rake 'foo:a[1,]'
  rake 'foo:a[,2]'
  rake 'foo:a'
```

- pass env variables to task:

```
  namespace :foo do
    task :a do
      ENV['OK']
      ENV['OKK'].split(',')
      # TODO
    end
  end

  rake foo:a OK=okay
  rake foo:A OKK=a,b,c
```

- default task:

```
  task default: [:a, :b] do
    # TODO
  end

  rake
```

- open task ( add more ):

```
  namespace :foo do
    task :a do
      p 'old'
    end

    task :a do
      p 'new'
    end
  end

  rake foo:a

  "old"
  "new"
```

- ways to invoke tasks:

```
  `bundle exec rake foo:a[1,2,3]`

  Rake::Task['foo:a'].invoke(1,2,3)

  Rake.application.invoke_task('foo:a[1,2,3]')
```

- rails load rake tasks:

```
  Rails.application.load_tasks
```

- example with progress bar:

```
  require 'progress_bar'

  desc "init score"
  task init_score: :environment do
    sql_query = <<-SQL.gsub(/\s+/, " ").strip
    	SELECT user_id, SUM(amount) as total_amount FROM orders
        WHERE state = 'completed' and amount > 0
        GROUP BY user_id;
    SQL

    user_id_with_total_amount = Order.connection.execute(sql_query)
    bar = ProgressBar.new(user_id_with_total_amount.size)

    begin
      Order.transaction do
        user_id_with_total_amount.each do |(user_id, total_amount)|
          next unless user = User.find_by(id: user_id)
          score = user.scores.find_or_initialize_by(status: "init")
          score.update(amount: [total_amount, 2000].min)
          bar.increment!
        end
      end
    rescue => e
      p "Failed: #{e}"
    end
  end
```
