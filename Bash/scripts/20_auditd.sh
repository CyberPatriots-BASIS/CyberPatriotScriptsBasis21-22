#! /bin/bash

function f_auditd {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Running Auditd"

  sed -i 's/^action_mail_acct =.*/action_mail_acct = root/' "$AUDITDCONF"
  sed -i 's/^admin_space_left_action = .*/admin_space_left_action = halt/' "$AUDITDCONF"
  sed -i 's/^max_log_file_action =.*/max_log_file_action = keep_logs/' "$AUDITDCONF"
  sed -i 's/^space_left_action =.*/space_left_action = email/' "$AUDITDCONF"

  if ! grep -q 'audit=1' /proc/cmdline; then
    echo "GRUB_CMDLINE_LINUX=\"\$GRUB_CMDLINE_LINUX audit=1 audit_backlog_limit=8192\"" > "$DEFAULTGRUB/99-hardening-audit.cfg"
  fi

  cp "./misc/audit.header" /etc/audit/audit.rules
  for l in $AUDITD_RULES; do
    cat "$l" >> /etc/audit/audit.rules
  done
  cat "./misc/audit.footer" >> /etc/audit/audit.rules

  sed -i "s/-f.*/-f $AUDITD_MODE/g" /etc/audit/audit.rules

  cp /etc/audit/audit.rules "$AUDITRULES"

  systemctl enable auditd
  systemctl restart auditd.service

}