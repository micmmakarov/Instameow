 head = <<EOF
 <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head profile="http://selenium-ide.openqa.org/profiles/test-case">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="selenium.base" href="http://instagram.com/" />
<title>New Test</title>
</head>
<body>
<table cellpadding="1" cellspacing="1" border="1">
<thead>
<tr><td rowspan="1" colspan="3">Test :||name||</td></tr>
</thead><tbody>
EOF

footer = <<EOF
</tbody></table>
</body>
</html>
EOF

 t = <<EOF
<tr>
  <td>open</td>
  <td>/||name||/</td>
  <td></td>
</tr>
<tr>
  <td>click</td>
  <td>css=div.photoShadow</td>
  <td></td>
</tr>
<tr>
  <td>click</td>
  <td>css=span.ibInner</td>
  <td></td>
</tr>
EOF

directory = "."
File.open(File.join(directory, 'file.txt'), 'w') do |f|
  f.puts head
  a.each do |name|
    f.puts name
  end
  f.puts footer
end