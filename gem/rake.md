# Rake

## Intro

- 'Rake' stands for 'Ruby Maker'.
- Specify tasks and dependencies.

## Feature

### Basic

- just ruby dsl.
- define tasks.
- task dependencies.
- task namespace.
- invoke tasks.
- default task.

### Advanced:

- supports rule patterns to synthesize implicit tasks.
- intellectual flexible 'file_lists' that act like array.
- library of prepackaged tasks to build rakefile easier.
- support parallel execution of tasks.

## Commands

- `rake` => run default task.
- `rake --tasks` => list desc tasks.
- `rake --all --tasks` => list all tasks.
- `rake --dry-run 'ok:foo'` => show dependencies.
- `rake --rakefile my_task_file my_task`

## Examples

### define task
```
  desc 'foo'
  task :foo do
    debugger
  end

  rake foo
```

### define task with rails env
```
  desc 'foo'
  task foo: :environment do
    debugger
  end

  rake foo
```

### define task with namespace
```
  namespace :ok do
    desc 'foo'
    task foo: :environment do
      debugger
    end
  end

  rake ok:foo
```

### define task with dependencies
```
  namespace :ok do
    desc 'foo'
    task foo: [:aaa, :bbb, 'other:ccc'] do
      debugger
    end

    task aaa: :environment do
      p 'aaa'
    end

    task bbb: :environment do
      p 'bbb'
    end
  end

  namespace :other do
    task ccc: :environment do
      p 'ccc'
    end
  end

  rake ok:foo

  aaa
  bbb
  ccc
```

### invoke tasks
```
  namespace :ok do
    desc 'foo'
    task foo: :environment do
      Rake::Task['ok:aaa'].invoke
      Rake::Task['ok:bbb'].invoke
      Rake::Task['other:ccc'].invoke
      debugger
    end

    task aaa: :environment do
      p 'aaa'
    end

    task bbb: :environment do
      p 'bbb'
    end
  end

  namespace :other do
    task ccc: :environment do
      p 'ccc'
    end
  end

  rake ok:foo

  aaa
  bbb
  ccc
```

### pass variable to task
```
  namespace :ok do
    desc 'foo'
    task :foo, [:arg_1, :arg_2] => :environment do |t, args|
      args.with_defaults(arg_1: "first", arg_2: "second")
      p args.arg_1 # '1'
      p args.arg_2 # '2'
      p args.to_hash # => {:arg_1=>"1", :arg_2=>"2"}
      p args.to_a # => ["1", "2"]
      debugger
    end
  end

  rake 'ok:foo[1,2]'

  rake 'ok:foo[,2]'

  rake 'ok:foo[,2]'
```

### pass env variable to task
```
  namespace :ok do
    desc 'foo'
    task foo: :environment do
      ENV['AAA']
      debugger
    end
  end

  rake ok:foo AAA=aaa
```

### pass env variable to task (convert to array)
```
  namespace :ok do
    desc 'foo'
    task foo: :environment do
      ENV['AAA'].split(',')
      debugger
    end
  end

  rake ok:foo AAA=aaa,bbb,ccc
```

### default task
```
  task default: [:foo, :bar] do
    p 'default'
    debugger
  end

  rake
```

### open task
```
  namespace :ok do
    task foo: :environment do
      p 'old foo'
    end

    task foo: :environment do
      p 'new foo'
    end
  end

  rake ok:foo

  "old foo"
  "new foo"
```

### work with progress_bar
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

