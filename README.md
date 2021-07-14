# inspec osquery resource

An InSpec resource that wraps osquery and makes the result set testable.

### Example

To execute the example profile, use test-kitchen.

    $ kitchen verify

Profile:

```ruby
describe osquery("SELECT * FROM users WHERE uid = '0';") do
  its('length') { should eq 1 }
  its('exit_status') { should eq 0 }
  its(['result_set', 0, 'username']) { should eq 'root' }
  its('username') { should eq 'root' }
  its('directory') { should eq '/root' }
  its('gid') { should eq '0' }
end
```
