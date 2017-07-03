#
# The "include_controls" command brings in all controls for the named profile.
# In this example, all controls from the "linux-baseline" profile will be run
# against our target every time our profile is executed.
#
# Profiles to be included/inherited must be defined in the "depends" section of
# the inspec.yml.
#
include_controls 'linux-baseline' do
  # In the event there is a control from an inherited profile that should not be
  # run, it can be skipped with the "skip_control" command. In this example,
  # InSpec will not run the "os-05" control from the "linux-baseline" profile
  # even though we've told InSpec to run all controls from "linux-baseline".
  skip_control 'os-05'

  # Controls from an inherited profile can be modified as well without requiring
  # forking the profile and maintaining a copy. A common use-case is altering
  # the impact of a given control. In this example, we are lowering the priority
  # of the "package-08" control to 0.1 (low severity) from the original impact
  # of 1.0 (critical severity).
  control 'package-08' do
    impact 0.1
  end
end

#
# The "require_controls" command allows specific controls from an inherited profile to be executed.
#
# In this example, only the controls from the "ssh-baseline" profile that are
# called out with the "control" command below will be executed when our profile
# is executed. No other controls from the "ssh-baseline" profile will be
# executed.
#
require_controls 'ssh-baseline' do
  # Controls "sshd-01" and "sshd-02" will be executed as-is as they are defined
  # in the "ssh-baseline" profile whenever our profile is executed.
  control 'sshd-01'
  control 'sshd-02'

  # Just like the "include_controls" command, controls inherited from another
  # profile can be modified if necessary without requiring the control or
  # profile to be copied and maintained separately. In this example, the
  # "sshd-03" control will be executed every time our profile is executed, but
  # if it fails, it will only report as a low severity (0.1) instead of the
  # original critical severity.
  control 'sshd-03' do
    impact 0.1
  end
end
