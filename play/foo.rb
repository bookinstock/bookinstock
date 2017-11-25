

a = "foo"
b = 'bar'
c = %q(abc def)
d = %Q(abc #{666})
e = <<SQL
  SELECT * FROM USERS
  WHERE users.name = "wende";
SQL

p a,b,c,d,e