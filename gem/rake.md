# Rake

## Intro

- 'Rake' stands for 'Ruby Maker'.
- Specify tasks and dependencies.

## Feature

### Basic:

- Just Ruby DSL.
- Define tasks.
- Task dependencies.
- Task namespace.
- Invoke tasks.
- Default task.

### Advanced:

- supports rule patterns to synthesize implicit tasks.
- intellectual flexible 'file_lists' that act like array.
- library of prepackaged tasks to build rakefile easier.
- support parallel execution of tasks.

## Commands

- `rake` => run default task.
- `rake --tasks` => list desc tasks.
- `rake --all --tasks` => list all tasks.
- `rake --dry-run 'foo:bar'` => show dependencies.
- `rake --rakefile my_task_file my_task`

## Examples

### Define tasks:
```
  desc 'a'
  task :a do
    debugger
  end

  rake a
```

### Define tasks with rails env:
```
  task a: :environment do
    debugger
  end

  rake a
```

### Define tasks with namespace:
```
  namespace :foo do
    task a: :environment do
      debugger
    end
  end

  rake foo:a
```

### Define tasks with dependencies:
```
  namespace :foo do
    task a: [:b, 'bar:c'] do
      debugger
    end

    task :b do
      p 'b'
    end
  end

  namespace :bar do
    task :c do
      p 'c'
    end
  end

  rake foo:a

  b
  c
```

### Invoke tasks:
```
  namespace :foo do
    task :a do
      Rake::Task['foo:b'].invoke
      Rake::Task['bar:c'].invoke
      Rake::Task['foo:d'].invoke('1', '2')
      debugger
    end

    task :b do
      p 'b'
    end

    task :d, [:arg_1, :arg_2] do |t, args|
      p 'd'
    end
  end

  namespace :bar do
    task :c do
      p 'c'
    end
  end

  rake foo:a
```

### Pass args to tasks:
```
  namespace :foo do
    task :a, [:arg_1, :arg_2] => :environment do |t, args|
      args.with_defaults(arg_1: "first", arg_2: "second")
      p args.to_hash # => {:arg_1=>"1", :arg_2=>"2"}
      p args.to_a # => ["1", "2"]
      p args.arg_1 # '1'
      p args.arg_2 # '2'
      debugger
    end
  end

  rake 'foo:a[1,2]'
  rake 'foo:a[1,]'
  rake 'foo:a[,2]'
  rake 'foo:a'
```

### Pass env variable to tasks:
```
  namespace :foo do
    task :a do
      ENV['OK']
      debugger
    end
  end

  rake foo:a OK=okay
```

### Pass env variable to task (convert to array):
```
  namespace :foo do
    task :a do
      ENV['OK'].split(',')
      debugger
    end
  end

  rake foo:A OK=a,b,c
```

### Default tasks:
```
  task default: [:a, :b] do
    debugger
  end

  rake
```

### Open tasks:
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

### Work with progress_bar:
```
  require 'progress_bar'

  desc "init score"
  task init_score: :environment do
    sql_query = "SELECT user_id, SUM(amount) as total_amount FROM orders " \
                "WHERE state = 'completed' and amount > 0 " \
                "GROUP BY user_id;"

    user_id_with_total_amount = Order.connection.execute(sql_query)
    bar = ProgressBar.new(user_id_with_total_amount.size)

    begin
      Order.transaction do
        user_id_with_total_amount.each do |(user_id, total_amount)|
          next unless user = User.find_by(id: user_id)
          score_action = user.users_score_actions.find_or_initialize_by(action_name: 'init')
          score_action.amount = [total_amount, 2000].min
          score_action.save
          bar.increment!
        end
      end
    rescue => e
      p "Failed: #{e}"
    end
  end
```

## Resources

- https://github.com/ruby/rake

