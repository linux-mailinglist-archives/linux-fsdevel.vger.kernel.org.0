Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2806C31A746
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhBLWDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 17:03:02 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46884 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhBLWC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:02:59 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lAgW1-001BiK-6J; Fri, 12 Feb 2021 15:02:17 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lAgVy-009wdA-8A; Fri, 12 Feb 2021 15:02:16 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com> (Joe
        Perches's message of "Fri, 12 Feb 2021 11:11:10 -0800")
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 12 Feb 2021 16:01:48 -0600
Message-ID: <m1im6x0wtv.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lAgVy-009wdA-8A;;;mid=<m1im6x0wtv.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX197vli1yhtureWX83BsoxIbtqC8l++31cQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Joe Perches <joe@perches.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1588 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.1 (0.2%), b_tie_ro: 2.2 (0.1%), parse: 1.49
        (0.1%), extract_message_metadata: 20 (1.3%), get_uri_detail_list: 10
        (0.6%), tests_pri_-1000: 4.9 (0.3%), tests_pri_-950: 1.09 (0.1%),
        tests_pri_-900: 0.87 (0.1%), tests_pri_-90: 334 (21.0%), check_bayes:
        326 (20.5%), b_tokenize: 33 (2.1%), b_tok_get_all: 13 (0.8%),
        b_comp_prob: 2.6 (0.2%), b_tok_touch_all: 274 (17.2%), b_finish: 0.72
        (0.0%), tests_pri_0: 1211 (76.3%), check_dkim_signature: 0.74 (0.0%),
        check_dkim_adsp: 5.0 (0.3%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        1.67 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> Convert S_<FOO> permissions to the more readable octal.
>
> Done using:
> $ ./scripts/checkpatch.pl -f --fix-inplace --types=SYMBOLIC_PERMS fs/proc/*.[ch]
>
> No difference in generated .o files allyesconfig x86-64
>
> Link:
> https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/


I will be frank.  I don't know what 0644 means.  I can never remember
which bit is read, write or execute.  So I like symbolic constants.

I don't see a compelling reason to change the existing code.

There are definitely information density and clarity issues with
the symbolic constants.  So I can understand a desire to do something
better.

If we could somehow get something closer to ls output where it
lists things as rwxr-xr-x  I think that would be much better.

Perhaps we can do something like:

#define S_IRWX 7
#define S_IRW_ 6
#define S_IR_X 5
#define S_IR__ 4
#define S_I_WX 3
#define S_I_W_ 2
#define S_I__X 1
#define S_I___ 0

#define MODE(TYPE, USER, GROUP, OTHER) \
	(((S_IF##TYPE) << 9) | \
         ((S_I##USER)  << 6) | \
         ((S_I##GROUP) << 3) | \
         (S_I##OTHER))

Which would be used something like:
MODE(DIR, RWX, R_X, R_X)
MODE(REG, RWX, R__, R__)

Something like that should be able to address the readability while
still using symbolic constants.

Eric



> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  fs/proc/base.c        | 216 +++++++++++++++++++++++++-------------------------
>  fs/proc/fd.c          |   6 +-
>  fs/proc/generic.c     |   8 +-
>  fs/proc/kcore.c       |   2 +-
>  fs/proc/kmsg.c        |   2 +-
>  fs/proc/namespaces.c  |   2 +-
>  fs/proc/nommu.c       |   2 +-
>  fs/proc/page.c        |   6 +-
>  fs/proc/proc_sysctl.c |   8 +-
>  fs/proc/proc_tty.c    |   2 +-
>  fs/proc/root.c        |   2 +-
>  fs/proc/self.c        |   2 +-
>  fs/proc/thread_self.c |   2 +-
>  fs/proc/vmcore.c      |   2 +-
>  14 files changed, 131 insertions(+), 131 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 3851bfcdba56..49cf949fb295 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -135,7 +135,7 @@ struct pid_entry {
>  #define DIR(NAME, MODE, iops, fops)	\
>  	NOD(NAME, (S_IFDIR|(MODE)), &iops, &fops, {} )
>  #define LNK(NAME, get_link)					\
> -	NOD(NAME, (S_IFLNK|S_IRWXUGO),				\
> +	NOD(NAME, (S_IFLNK | 0777),				\
>  		&proc_pid_link_inode_operations, NULL,		\
>  		{ .proc_get_link = get_link } )
>  #define REG(NAME, MODE, fops)				\
> @@ -1840,7 +1840,7 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
>  	 * made this apply to all per process world readable and executable
>  	 * directories.
>  	 */
> -	if (mode != (S_IFDIR|S_IRUGO|S_IXUGO)) {
> +	if (mode != (S_IFDIR | 0555)) {
>  		struct mm_struct *mm;
>  		task_lock(task);
>  		mm = task->mm;
> @@ -2235,8 +2235,8 @@ proc_map_files_instantiate(struct dentry *dentry,
>  	struct inode *inode;
>  
>  	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK |
> -				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
> -				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
> +				    ((mode & FMODE_READ) ? 0400 : 0) |
> +				    ((mode & FMODE_WRITE) ? 0200 : 0));
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> @@ -3156,114 +3156,114 @@ static const struct file_operations proc_task_operations;
>  static const struct inode_operations proc_task_inode_operations;
>  
>  static const struct pid_entry tgid_base_stuff[] = {
> -	DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_operations),
> -	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
> -	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
> -	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> -	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
> +	DIR("task",       0555, proc_task_inode_operations, proc_task_operations),
> +	DIR("fd",         0500, proc_fd_inode_operations, proc_fd_operations),
> +	DIR("map_files",  0500, proc_map_files_inode_operations, proc_map_files_operations),
> +	DIR("fdinfo",     0500, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> +	DIR("ns",	  0511, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>  #ifdef CONFIG_NET
> -	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
> +	DIR("net",        0555, proc_net_inode_operations, proc_net_operations),
>  #endif
> -	REG("environ",    S_IRUSR, proc_environ_operations),
> -	REG("auxv",       S_IRUSR, proc_auxv_operations),
> -	ONE("status",     S_IRUGO, proc_pid_status),
> -	ONE("personality", S_IRUSR, proc_pid_personality),
> -	ONE("limits",	  S_IRUGO, proc_pid_limits),
> +	REG("environ",    0400, proc_environ_operations),
> +	REG("auxv",       0400, proc_auxv_operations),
> +	ONE("status",     0444, proc_pid_status),
> +	ONE("personality", 0400, proc_pid_personality),
> +	ONE("limits",	  0444, proc_pid_limits),
>  #ifdef CONFIG_SCHED_DEBUG
> -	REG("sched",      S_IRUGO|S_IWUSR, proc_pid_sched_operations),
> +	REG("sched",      0644, proc_pid_sched_operations),
>  #endif
>  #ifdef CONFIG_SCHED_AUTOGROUP
> -	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
> +	REG("autogroup",  0644, proc_pid_sched_autogroup_operations),
>  #endif
>  #ifdef CONFIG_TIME_NS
> -	REG("timens_offsets",  S_IRUGO|S_IWUSR, proc_timens_offsets_operations),
> +	REG("timens_offsets",  0644, proc_timens_offsets_operations),
>  #endif
> -	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
> +	REG("comm",      0644, proc_pid_set_comm_operations),
>  #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
> -	ONE("syscall",    S_IRUSR, proc_pid_syscall),
> +	ONE("syscall",    0400, proc_pid_syscall),
>  #endif
> -	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
> -	ONE("stat",       S_IRUGO, proc_tgid_stat),
> -	ONE("statm",      S_IRUGO, proc_pid_statm),
> -	REG("maps",       S_IRUGO, proc_pid_maps_operations),
> +	REG("cmdline",    0444, proc_pid_cmdline_ops),
> +	ONE("stat",       0444, proc_tgid_stat),
> +	ONE("statm",      0444, proc_pid_statm),
> +	REG("maps",       0444, proc_pid_maps_operations),
>  #ifdef CONFIG_NUMA
> -	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
> +	REG("numa_maps",  0444, proc_pid_numa_maps_operations),
>  #endif
> -	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
> +	REG("mem",        0600, proc_mem_operations),
>  	LNK("cwd",        proc_cwd_link),
>  	LNK("root",       proc_root_link),
>  	LNK("exe",        proc_exe_link),
> -	REG("mounts",     S_IRUGO, proc_mounts_operations),
> -	REG("mountinfo",  S_IRUGO, proc_mountinfo_operations),
> -	REG("mountstats", S_IRUSR, proc_mountstats_operations),
> +	REG("mounts",     0444, proc_mounts_operations),
> +	REG("mountinfo",  0444, proc_mountinfo_operations),
> +	REG("mountstats", 0400, proc_mountstats_operations),
>  #ifdef CONFIG_PROC_PAGE_MONITOR
> -	REG("clear_refs", S_IWUSR, proc_clear_refs_operations),
> -	REG("smaps",      S_IRUGO, proc_pid_smaps_operations),
> -	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
> -	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
> +	REG("clear_refs", 0200, proc_clear_refs_operations),
> +	REG("smaps",      0444, proc_pid_smaps_operations),
> +	REG("smaps_rollup", 0444, proc_pid_smaps_rollup_operations),
> +	REG("pagemap",    0400, proc_pagemap_operations),
>  #endif
>  #ifdef CONFIG_SECURITY
> -	DIR("attr",       S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
> +	DIR("attr",       0555, proc_attr_dir_inode_operations, proc_attr_dir_operations),
>  #endif
>  #ifdef CONFIG_KALLSYMS
> -	ONE("wchan",      S_IRUGO, proc_pid_wchan),
> +	ONE("wchan",      0444, proc_pid_wchan),
>  #endif
>  #ifdef CONFIG_STACKTRACE
> -	ONE("stack",      S_IRUSR, proc_pid_stack),
> +	ONE("stack",      0400, proc_pid_stack),
>  #endif
>  #ifdef CONFIG_SCHED_INFO
> -	ONE("schedstat",  S_IRUGO, proc_pid_schedstat),
> +	ONE("schedstat",  0444, proc_pid_schedstat),
>  #endif
>  #ifdef CONFIG_LATENCYTOP
> -	REG("latency",  S_IRUGO, proc_lstats_operations),
> +	REG("latency",  0444, proc_lstats_operations),
>  #endif
>  #ifdef CONFIG_PROC_PID_CPUSET
> -	ONE("cpuset",     S_IRUGO, proc_cpuset_show),
> +	ONE("cpuset",     0444, proc_cpuset_show),
>  #endif
>  #ifdef CONFIG_CGROUPS
> -	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> +	ONE("cgroup",  0444, proc_cgroup_show),
>  #endif
>  #ifdef CONFIG_PROC_CPU_RESCTRL
> -	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
> +	ONE("cpu_resctrl_groups", 0444, proc_resctrl_show),
>  #endif
> -	ONE("oom_score",  S_IRUGO, proc_oom_score),
> -	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
> -	REG("oom_score_adj", S_IRUGO|S_IWUSR, proc_oom_score_adj_operations),
> +	ONE("oom_score",  0444, proc_oom_score),
> +	REG("oom_adj",    0644, proc_oom_adj_operations),
> +	REG("oom_score_adj", 0644, proc_oom_score_adj_operations),
>  #ifdef CONFIG_AUDIT
> -	REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
> -	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> +	REG("loginuid",   0644, proc_loginuid_operations),
> +	REG("sessionid",  0444, proc_sessionid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
> -	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> +	REG("make-it-fail", 0644, proc_fault_inject_operations),
>  	REG("fail-nth", 0644, proc_fail_nth_operations),
>  #endif
>  #ifdef CONFIG_ELF_CORE
> -	REG("coredump_filter", S_IRUGO|S_IWUSR, proc_coredump_filter_operations),
> +	REG("coredump_filter", 0644, proc_coredump_filter_operations),
>  #endif
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
> -	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
> +	ONE("io",	0400, proc_tgid_io_accounting),
>  #endif
>  #ifdef CONFIG_USER_NS
> -	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
> -	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
> -	REG("projid_map", S_IRUGO|S_IWUSR, proc_projid_map_operations),
> -	REG("setgroups",  S_IRUGO|S_IWUSR, proc_setgroups_operations),
> +	REG("uid_map",    0644, proc_uid_map_operations),
> +	REG("gid_map",    0644, proc_gid_map_operations),
> +	REG("projid_map", 0644, proc_projid_map_operations),
> +	REG("setgroups",  0644, proc_setgroups_operations),
>  #endif
>  #if defined(CONFIG_CHECKPOINT_RESTORE) && defined(CONFIG_POSIX_TIMERS)
> -	REG("timers",	  S_IRUGO, proc_timers_operations),
> +	REG("timers",	  0444, proc_timers_operations),
>  #endif
> -	REG("timerslack_ns", S_IRUGO|S_IWUGO, proc_pid_set_timerslack_ns_operations),
> +	REG("timerslack_ns", 0666, proc_pid_set_timerslack_ns_operations),
>  #ifdef CONFIG_LIVEPATCH
> -	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
> +	ONE("patch_state",  0400, proc_pid_patch_state),
>  #endif
>  #ifdef CONFIG_STACKLEAK_METRICS
> -	ONE("stack_depth", S_IRUGO, proc_stack_depth),
> +	ONE("stack_depth", 0444, proc_stack_depth),
>  #endif
>  #ifdef CONFIG_PROC_PID_ARCH_STATUS
> -	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
> +	ONE("arch_status", 0444, proc_pid_arch_status),
>  #endif
>  #ifdef CONFIG_SECCOMP_CACHE_DEBUG
> -	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
> +	ONE("seccomp_cache", 0400, proc_pid_seccomp_cache),
>  #endif
>  };
>  
> @@ -3330,7 +3330,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
>  {
>  	struct inode *inode;
>  
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | 0555);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> @@ -3503,100 +3503,100 @@ static const struct inode_operations proc_tid_comm_inode_operations = {
>   * Tasks
>   */
>  static const struct pid_entry tid_base_stuff[] = {
> -	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
> -	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> -	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
> +	DIR("fd",        0500, proc_fd_inode_operations, proc_fd_operations),
> +	DIR("fdinfo",    0500, proc_fdinfo_inode_operations, proc_fdinfo_operations),
> +	DIR("ns",	 0511, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>  #ifdef CONFIG_NET
> -	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
> +	DIR("net",        0555, proc_net_inode_operations, proc_net_operations),
>  #endif
> -	REG("environ",   S_IRUSR, proc_environ_operations),
> -	REG("auxv",      S_IRUSR, proc_auxv_operations),
> -	ONE("status",    S_IRUGO, proc_pid_status),
> -	ONE("personality", S_IRUSR, proc_pid_personality),
> -	ONE("limits",	 S_IRUGO, proc_pid_limits),
> +	REG("environ",   0400, proc_environ_operations),
> +	REG("auxv",      0400, proc_auxv_operations),
> +	ONE("status",    0444, proc_pid_status),
> +	ONE("personality", 0400, proc_pid_personality),
> +	ONE("limits",	 0444, proc_pid_limits),
>  #ifdef CONFIG_SCHED_DEBUG
> -	REG("sched",     S_IRUGO|S_IWUSR, proc_pid_sched_operations),
> +	REG("sched",     0644, proc_pid_sched_operations),
>  #endif
> -	NOD("comm",      S_IFREG|S_IRUGO|S_IWUSR,
> +	NOD("comm",      S_IFREG | 0644,
>  			 &proc_tid_comm_inode_operations,
>  			 &proc_pid_set_comm_operations, {}),
>  #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
> -	ONE("syscall",   S_IRUSR, proc_pid_syscall),
> +	ONE("syscall",   0400, proc_pid_syscall),
>  #endif
> -	REG("cmdline",   S_IRUGO, proc_pid_cmdline_ops),
> -	ONE("stat",      S_IRUGO, proc_tid_stat),
> -	ONE("statm",     S_IRUGO, proc_pid_statm),
> -	REG("maps",      S_IRUGO, proc_pid_maps_operations),
> +	REG("cmdline",   0444, proc_pid_cmdline_ops),
> +	ONE("stat",      0444, proc_tid_stat),
> +	ONE("statm",     0444, proc_pid_statm),
> +	REG("maps",      0444, proc_pid_maps_operations),
>  #ifdef CONFIG_PROC_CHILDREN
> -	REG("children",  S_IRUGO, proc_tid_children_operations),
> +	REG("children",  0444, proc_tid_children_operations),
>  #endif
>  #ifdef CONFIG_NUMA
> -	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
> +	REG("numa_maps", 0444, proc_pid_numa_maps_operations),
>  #endif
> -	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
> +	REG("mem",       0600, proc_mem_operations),
>  	LNK("cwd",       proc_cwd_link),
>  	LNK("root",      proc_root_link),
>  	LNK("exe",       proc_exe_link),
> -	REG("mounts",    S_IRUGO, proc_mounts_operations),
> -	REG("mountinfo",  S_IRUGO, proc_mountinfo_operations),
> +	REG("mounts",    0444, proc_mounts_operations),
> +	REG("mountinfo",  0444, proc_mountinfo_operations),
>  #ifdef CONFIG_PROC_PAGE_MONITOR
> -	REG("clear_refs", S_IWUSR, proc_clear_refs_operations),
> -	REG("smaps",     S_IRUGO, proc_pid_smaps_operations),
> -	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
> -	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
> +	REG("clear_refs", 0200, proc_clear_refs_operations),
> +	REG("smaps",     0444, proc_pid_smaps_operations),
> +	REG("smaps_rollup", 0444, proc_pid_smaps_rollup_operations),
> +	REG("pagemap",    0400, proc_pagemap_operations),
>  #endif
>  #ifdef CONFIG_SECURITY
> -	DIR("attr",      S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
> +	DIR("attr",      0555, proc_attr_dir_inode_operations, proc_attr_dir_operations),
>  #endif
>  #ifdef CONFIG_KALLSYMS
> -	ONE("wchan",     S_IRUGO, proc_pid_wchan),
> +	ONE("wchan",     0444, proc_pid_wchan),
>  #endif
>  #ifdef CONFIG_STACKTRACE
> -	ONE("stack",      S_IRUSR, proc_pid_stack),
> +	ONE("stack",      0400, proc_pid_stack),
>  #endif
>  #ifdef CONFIG_SCHED_INFO
> -	ONE("schedstat", S_IRUGO, proc_pid_schedstat),
> +	ONE("schedstat", 0444, proc_pid_schedstat),
>  #endif
>  #ifdef CONFIG_LATENCYTOP
> -	REG("latency",  S_IRUGO, proc_lstats_operations),
> +	REG("latency",  0444, proc_lstats_operations),
>  #endif
>  #ifdef CONFIG_PROC_PID_CPUSET
> -	ONE("cpuset",    S_IRUGO, proc_cpuset_show),
> +	ONE("cpuset",    0444, proc_cpuset_show),
>  #endif
>  #ifdef CONFIG_CGROUPS
> -	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> +	ONE("cgroup",  0444, proc_cgroup_show),
>  #endif
>  #ifdef CONFIG_PROC_CPU_RESCTRL
> -	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
> +	ONE("cpu_resctrl_groups", 0444, proc_resctrl_show),
>  #endif
> -	ONE("oom_score", S_IRUGO, proc_oom_score),
> -	REG("oom_adj",   S_IRUGO|S_IWUSR, proc_oom_adj_operations),
> -	REG("oom_score_adj", S_IRUGO|S_IWUSR, proc_oom_score_adj_operations),
> +	ONE("oom_score", 0444, proc_oom_score),
> +	REG("oom_adj",   0644, proc_oom_adj_operations),
> +	REG("oom_score_adj", 0644, proc_oom_score_adj_operations),
>  #ifdef CONFIG_AUDIT
> -	REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
> -	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> +	REG("loginuid",  0644, proc_loginuid_operations),
> +	REG("sessionid",  0444, proc_sessionid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
> -	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> +	REG("make-it-fail", 0644, proc_fault_inject_operations),
>  	REG("fail-nth", 0644, proc_fail_nth_operations),
>  #endif
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
> -	ONE("io",	S_IRUSR, proc_tid_io_accounting),
> +	ONE("io",	0400, proc_tid_io_accounting),
>  #endif
>  #ifdef CONFIG_USER_NS
> -	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
> -	REG("gid_map",    S_IRUGO|S_IWUSR, proc_gid_map_operations),
> -	REG("projid_map", S_IRUGO|S_IWUSR, proc_projid_map_operations),
> -	REG("setgroups",  S_IRUGO|S_IWUSR, proc_setgroups_operations),
> +	REG("uid_map",    0644, proc_uid_map_operations),
> +	REG("gid_map",    0644, proc_gid_map_operations),
> +	REG("projid_map", 0644, proc_projid_map_operations),
> +	REG("setgroups",  0644, proc_setgroups_operations),
>  #endif
>  #ifdef CONFIG_LIVEPATCH
> -	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
> +	ONE("patch_state",  0400, proc_pid_patch_state),
>  #endif
>  #ifdef CONFIG_PROC_PID_ARCH_STATUS
> -	ONE("arch_status", S_IRUGO, proc_pid_arch_status),
> +	ONE("arch_status", 0444, proc_pid_arch_status),
>  #endif
>  #ifdef CONFIG_SECCOMP_CACHE_DEBUG
> -	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
> +	ONE("seccomp_cache", 0400, proc_pid_seccomp_cache),
>  #endif
>  };
>  
> @@ -3629,7 +3629,7 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
>  	struct task_struct *task, const void *ptr)
>  {
>  	struct inode *inode;
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | 0555);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 07fc4fad2602..ec29382fc2af 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -102,9 +102,9 @@ static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
>  	if (S_ISLNK(inode->i_mode)) {
>  		unsigned i_mode = S_IFLNK;
>  		if (f_mode & FMODE_READ)
> -			i_mode |= S_IRUSR | S_IXUSR;
> +			i_mode |= 0500;
>  		if (f_mode & FMODE_WRITE)
> -			i_mode |= S_IWUSR | S_IXUSR;
> +			i_mode |= 0300;
>  		inode->i_mode = i_mode;
>  	}
>  	security_task_to_inode(task, inode);
> @@ -308,7 +308,7 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
>  	struct proc_inode *ei;
>  	struct inode *inode;
>  
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR);
> +	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | 0400);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index bc86aa87cc41..cece01579ab4 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -466,7 +466,7 @@ struct proc_dir_entry *proc_symlink(const char *name,
>  	struct proc_dir_entry *ent;
>  
>  	ent = __proc_create(&parent, name,
> -			  (S_IFLNK | S_IRUGO | S_IWUGO | S_IXUGO),1);
> +			  (S_IFLNK | 0777), 1);
>  
>  	if (ent) {
>  		ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
> @@ -489,7 +489,7 @@ struct proc_dir_entry *_proc_mkdir(const char *name, umode_t mode,
>  	struct proc_dir_entry *ent;
>  
>  	if (mode == 0)
> -		mode = S_IRUGO | S_IXUGO;
> +		mode = 0555;
>  
>  	ent = __proc_create(&parent, name, S_IFDIR | mode, 2);
>  	if (ent) {
> @@ -528,7 +528,7 @@ EXPORT_SYMBOL(proc_mkdir);
>  
>  struct proc_dir_entry *proc_create_mount_point(const char *name)
>  {
> -	umode_t mode = S_IFDIR | S_IRUGO | S_IXUGO;
> +	umode_t mode = S_IFDIR | 0555;
>  	struct proc_dir_entry *ent, *parent = NULL;
>  
>  	ent = __proc_create(&parent, name, mode, 2);
> @@ -550,7 +550,7 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
>  	if ((mode & S_IFMT) == 0)
>  		mode |= S_IFREG;
>  	if ((mode & S_IALLUGO) == 0)
> -		mode |= S_IRUGO;
> +		mode |= 0444;
>  	if (WARN_ON_ONCE(!S_ISREG(mode)))
>  		return NULL;
>  
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 4d2e64e9016c..8c57f22ef41a 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -636,7 +636,7 @@ static void __init add_modules_range(void)
>  
>  static int __init proc_kcore_init(void)
>  {
> -	proc_root_kcore = proc_create("kcore", S_IRUSR, NULL, &kcore_proc_ops);
> +	proc_root_kcore = proc_create("kcore", 0400, NULL, &kcore_proc_ops);
>  	if (!proc_root_kcore) {
>  		pr_err("couldn't create /proc/kcore\n");
>  		return 0; /* Always returns 0. */
> diff --git a/fs/proc/kmsg.c b/fs/proc/kmsg.c
> index b38ad552887f..3402656feaf7 100644
> --- a/fs/proc/kmsg.c
> +++ b/fs/proc/kmsg.c
> @@ -60,7 +60,7 @@ static const struct proc_ops kmsg_proc_ops = {
>  
>  static int __init proc_kmsg_init(void)
>  {
> -	proc_create("kmsg", S_IRUSR, NULL, &kmsg_proc_ops);
> +	proc_create("kmsg", 0400, NULL, &kmsg_proc_ops);
>  	return 0;
>  }
>  fs_initcall(proc_kmsg_init);
> diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
> index 8e159fc78c0a..6cc8aa7b5ee0 100644
> --- a/fs/proc/namespaces.c
> +++ b/fs/proc/namespaces.c
> @@ -102,7 +102,7 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
>  	struct inode *inode;
>  	struct proc_inode *ei;
>  
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRWXUGO);
> +	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | 0777);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
> index 13452b32e2bd..b4c93cbd467c 100644
> --- a/fs/proc/nommu.c
> +++ b/fs/proc/nommu.c
> @@ -110,7 +110,7 @@ static const struct seq_operations proc_nommu_region_list_seqop = {
>  
>  static int __init proc_nommu_init(void)
>  {
> -	proc_create_seq("maps", S_IRUGO, NULL, &proc_nommu_region_list_seqop);
> +	proc_create_seq("maps", 0444, NULL, &proc_nommu_region_list_seqop);
>  	return 0;
>  }
>  
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 4dcbcd506cb6..b3a084076dbd 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -330,10 +330,10 @@ static const struct proc_ops kpagecgroup_proc_ops = {
>  
>  static int __init proc_page_init(void)
>  {
> -	proc_create("kpagecount", S_IRUSR, NULL, &kpagecount_proc_ops);
> -	proc_create("kpageflags", S_IRUSR, NULL, &kpageflags_proc_ops);
> +	proc_create("kpagecount", 0400, NULL, &kpagecount_proc_ops);
> +	proc_create("kpageflags", 0400, NULL, &kpageflags_proc_ops);
>  #ifdef CONFIG_MEMCG
> -	proc_create("kpagecgroup", S_IRUSR, NULL, &kpagecgroup_proc_ops);
> +	proc_create("kpagecgroup", 0400, NULL, &kpagecgroup_proc_ops);
>  #endif
>  	return 0;
>  }
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 984e42f8cb11..beeacbf0aefc 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -62,7 +62,7 @@ void proc_sys_poll_notify(struct ctl_table_poll *poll)
>  static struct ctl_table root_table[] = {
>  	{
>  		.procname = "",
> -		.mode = S_IFDIR|S_IRUGO|S_IXUGO,
> +		.mode = S_IFDIR | 0555,
>  	},
>  	{ }
>  };
> @@ -967,7 +967,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
>  	memcpy(new_name, name, namelen);
>  	new_name[namelen] = '\0';
>  	table[0].procname = new_name;
> -	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
> +	table[0].mode = S_IFDIR | 0555;
>  	init_header(&new->header, set->dir.header.root, set, node, table);
>  
>  	return new;
> @@ -1138,7 +1138,7 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
>  		if (!table->proc_handler)
>  			err |= sysctl_err(path, table, "No proc_handler");
>  
> -		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
> +		if ((table->mode & (0666)) != table->mode)
>  			err |= sysctl_err(path, table, "bogus .mode 0%o",
>  				table->mode);
>  	}
> @@ -1178,7 +1178,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
>  		int len = strlen(entry->procname) + 1;
>  		memcpy(link_name, entry->procname, len);
>  		link->procname = link_name;
> -		link->mode = S_IFLNK|S_IRWXUGO;
> +		link->mode = S_IFLNK | 0777;
>  		link->data = link_root;
>  		link_name += len;
>  	}
> diff --git a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
> index c69ff191e5d8..629bbab446f1 100644
> --- a/fs/proc/proc_tty.c
> +++ b/fs/proc/proc_tty.c
> @@ -173,7 +173,7 @@ void __init proc_tty_init(void)
>  	 * password lengths and inter-keystroke timings during password
>  	 * entry.
>  	 */
> -	proc_tty_driver = proc_mkdir_mode("tty/driver", S_IRUSR|S_IXUSR, NULL);
> +	proc_tty_driver = proc_mkdir_mode("tty/driver", 0500, NULL);
>  	proc_create_seq("tty/ldiscs", 0, NULL, &tty_ldiscs_seq_ops);
>  	proc_create_seq("tty/drivers", 0, NULL, &tty_drivers_op);
>  }
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index c7e3b1350ef8..0f05ffac7f90 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -362,7 +362,7 @@ static const struct inode_operations proc_root_inode_operations = {
>  struct proc_dir_entry proc_root = {
>  	.low_ino	= PROC_ROOT_INO, 
>  	.namelen	= 5, 
> -	.mode		= S_IFDIR | S_IRUGO | S_IXUGO, 
> +	.mode		= S_IFDIR | 0555,
>  	.nlink		= 2, 
>  	.refcnt		= REFCOUNT_INIT(1),
>  	.proc_iops	= &proc_root_inode_operations, 
> diff --git a/fs/proc/self.c b/fs/proc/self.c
> index cc71ce3466dc..f82e3680c048 100644
> --- a/fs/proc/self.c
> +++ b/fs/proc/self.c
> @@ -54,7 +54,7 @@ int proc_setup_self(struct super_block *s)
>  		if (inode) {
>  			inode->i_ino = self_inum;
>  			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> -			inode->i_mode = S_IFLNK | S_IRWXUGO;
> +			inode->i_mode = S_IFLNK | 0777;
>  			inode->i_uid = GLOBAL_ROOT_UID;
>  			inode->i_gid = GLOBAL_ROOT_GID;
>  			inode->i_op = &proc_self_inode_operations;
> diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
> index a553273fbd41..def800fd540f 100644
> --- a/fs/proc/thread_self.c
> +++ b/fs/proc/thread_self.c
> @@ -47,7 +47,7 @@ int proc_setup_thread_self(struct super_block *s)
>  		if (inode) {
>  			inode->i_ino = thread_self_inum;
>  			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> -			inode->i_mode = S_IFLNK | S_IRWXUGO;
> +			inode->i_mode = S_IFLNK | 0777;
>  			inode->i_uid = GLOBAL_ROOT_UID;
>  			inode->i_gid = GLOBAL_ROOT_GID;
>  			inode->i_op = &proc_thread_self_inode_operations;
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 9a15334da208..fe600a672d3c 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1552,7 +1552,7 @@ static int __init vmcore_init(void)
>  	elfcorehdr_free(elfcorehdr_addr);
>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  
> -	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
> +	proc_vmcore = proc_create("vmcore", 0400, NULL, &vmcore_proc_ops);
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
>  	return 0;
