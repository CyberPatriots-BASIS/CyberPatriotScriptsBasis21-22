#! /bin/bash

function f_sysctl {
  echo "Script: [$SCRIPT_NUM] ::: Configure $SYSCTL"

  cp "$SYSCTL_CONF" "$SYSCTL"

  sysctl -w dev.tty.ldisc_autoload=0
  sysctl -w fs.protected_fifos=2
  sysctl -w fs.protected_hardlinks=1
  sysctl -w fs.protected_symlinks=1
  sysctl -w fs.suid_dumpable=0
  sysctl -w kernel.core_uses_pid=1
  sysctl -w kernel.dmesg_restrict=1
  sysctl -w kernel.kptr_restrict=2
  sysctl -w kernel.panic=60
  sysctl -w kernel.panic_on_oops=60
  sysctl -w kernel.perf_event_paranoid=3
  sysctl -w kernel.randomize_va_space=2
  sysctl -w kernel.sysrq=0
  sysctl -w kernel.unprivileged_bpf_disabled=1
  sysctl -w kernel.yama.ptrace_scope=2
  sysctl -w net.core.bpf_jit_harden=2
  sysctl -w net.ipv4.conf.all.accept_redirects=0
  sysctl -w net.ipv4.conf.all.accept_source_route=0
  sysctl -w net.ipv4.conf.all.log_martians=1
  sysctl -w net.ipv4.conf.all.rp_filter=1
  sysctl -w net.ipv4.conf.all.secure_redirects=0
  sysctl -w net.ipv4.conf.all.send_redirects=0
  sysctl -w net.ipv4.conf.all.shared_media=0
  sysctl -w net.ipv4.conf.default.accept_redirects=0
  sysctl -w net.ipv4.conf.default.accept_source_route=0
  sysctl -w net.ipv4.conf.default.log_martians=1
  sysctl -w net.ipv4.conf.default.rp_filter=1
  sysctl -w net.ipv4.conf.default.secure_redirects=0
  sysctl -w net.ipv4.conf.default.send_redirects=0
  sysctl -w net.ipv4.conf.default.shared_media=0
  sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
  sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
  sysctl -w net.ipv4.ip_forward=0
  sysctl -w net.ipv4.tcp_challenge_ack_limit=2147483647
  sysctl -w net.ipv4.tcp_invalid_ratelimit=500
  sysctl -w net.ipv4.tcp_max_syn_backlog=20480
  sysctl -w net.ipv4.tcp_rfc1337=1
  sysctl -w net.ipv4.tcp_syn_retries=5
  sysctl -w net.ipv4.tcp_synack_retries=2
  sysctl -w net.ipv4.tcp_syncookies=1
  sysctl -w net.ipv6.conf.all.accept_ra=0
  sysctl -w net.ipv6.conf.all.accept_redirects=0
  sysctl -w net.ipv6.conf.all.accept_source_route=0
  sysctl -w net.ipv6.conf.all.forwarding=0
  sysctl -w net.ipv6.conf.all.use_tempaddr=2
  sysctl -w net.ipv6.conf.default.accept_ra=0
  sysctl -w net.ipv6.conf.default.accept_ra_defrtr=0
  sysctl -w net.ipv6.conf.default.accept_ra_pinfo=0
  sysctl -w net.ipv6.conf.default.accept_ra_rtr_pref=0
  sysctl -w net.ipv6.conf.default.accept_redirects=0
  sysctl -w net.ipv6.conf.default.accept_source_route=0
  sysctl -w net.ipv6.conf.default.autoconf=0
  sysctl -w net.ipv6.conf.default.dad_transmits=0
  sysctl -w net.ipv6.conf.default.max_addresses=1
  sysctl -w net.ipv6.conf.default.router_solicitations=0
  sysctl -w net.ipv6.conf.default.use_tempaddr=2
  sysctl -w net.ipv6.conf.eth0.accept_ra_rtr_pref=0
  sysctl -w net.filter.nf_conntrack_max=2000000
  sysctl -w net.filter.nf_conntrack_tcp_loose=0
  sysctl -w kernel.panic=10
  sysctl -w kernel.modules_disabled=1  
  chmod 0600 "$SYSCTL"
  systemctl restart systemd-sysctl

  ((SCRIPT_NUM++))
}