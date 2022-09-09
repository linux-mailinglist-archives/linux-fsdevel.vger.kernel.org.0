Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010DD5B41A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 23:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiIIVrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 17:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIIVrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:47:40 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F7F1F32;
        Fri,  9 Sep 2022 14:47:36 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55152)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oWlqZ-004koM-9E; Fri, 09 Sep 2022 15:47:35 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:48530 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oWlqX-00EpiA-LG; Fri, 09 Sep 2022 15:47:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Florian Mayer <fmayer@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, <linux-api@vger.kernel.org>
References: <20220909180617.374238-1-fmayer@google.com>
Date:   Fri, 09 Sep 2022 16:47:10 -0500
In-Reply-To: <20220909180617.374238-1-fmayer@google.com> (Florian Mayer's
        message of "Fri, 9 Sep 2022 11:06:17 -0700")
Message-ID: <87v8pw8bkx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oWlqX-00EpiA-LG;;;mid=<87v8pw8bkx.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/kq5B3pAXavRvluA8Jwvs8fCXtJ1M6zpU=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Florian Mayer <fmayer@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1041 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.1%), b_tie_ro: 10 (0.9%), parse: 1.53
        (0.1%), extract_message_metadata: 9 (0.9%), get_uri_detail_list: 7
        (0.7%), tests_pri_-1000: 3.9 (0.4%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 86 (8.3%), check_bayes: 84
        (8.1%), b_tokenize: 26 (2.5%), b_tok_get_all: 17 (1.6%), b_comp_prob:
        4.3 (0.4%), b_tok_touch_all: 33 (3.2%), b_finish: 0.90 (0.1%),
        tests_pri_0: 908 (87.2%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 3.0 (0.3%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 8 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RESEND] Add sicode to /proc/<PID>/stat.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Added linux-api because you are changing the api.

Florian Mayer <fmayer@google.com> writes:

> In order to enable additional debugging features, Android init needs a
> way to distinguish MTE-related SEGVs (with si_code of SEGV_MTEAERR)
> from other SEGVs. This is not possible with current APIs, neither by
> the existing information in /proc/<pid>/stat, nor via waitpid.
>
> Tested with the following program
>
> int main(int argc, char** argv) {
>   int pid = fork();
>   if (!pid) {
>     if (strcmp(argv[1], "sigqueue") == 0) {
>     union sigval value;
>     value.sival_int = 0;
>     sigqueue(getpid(), SIGSEGV, value);
>     } else if (strcmp(argv[1], "raise") == 0) {
>      raise(SIGSEGV);
>     } else if (strcmp(argv[1], "kill") == 0) {
>       kill(getpid(), SIGSEGV);
>     } else if (strcmp(argv[1], "raisestop") == 0) {
>       raise(SIGSTOP);
>     } else if (strcmp(argv[1], "crash") == 0) {
>       volatile int* x = (int*)(0x23);
>       *x = 1;
>     } else if (strcmp(argv[1], "mte") == 0) {
>       volatile char* y = malloc(1);
>       y += 100;
>       *y = 1;
>     }
>   } else {
>     printf("%d\n", pid);
>     sleep(5);
>     char buf[1024];
>     sprintf(buf, "/proc/%d/stat", pid);
>     int fd = open(buf, O_RDONLY);
>     char statb[1024];
>     read(fd, statb, sizeof(statb));
>     printf("%s\n", statb);
>   }
> }

The implementation seems horrible.

Several things.  First you are messing with /proc/<pid>/stat which is
heavily used.  You do add the value to the end of the list which is
good.  You don't talk about how many userspace applications you have
tested to be certain that it is actually safe to add something to this
file, nor do you talk about measuring performance.

Second the only two places that have any legitimate reason to be setting
group_exit_sicode are complete_signal for short circuited signals and
get_signal for signals that come the long way around.  Unfortunately
because of debuggers we can't always short circuit signals.

Do not allow reading this value for SIGNAL_GROUP_STOP it makes no sense.

This implementation seems very fragile.  How long until you need the
full siginfo of the signal that caused the process to exit somewhere?


There are two ways to get this information with existing APIs.
- Catch the signal in the process and give it to someone.
- Debug the process and stop in PTRACE_EVENT_EXIT and read
  the signal with PTRACE_PEEKSIGINFO.

Not that I am saying those are good alternatives, I am just
saying that they exist.

I know people have wanted the full siginfo on exit before, but we have
not gotten there yet.

Eric

>
> Signed-off-by: Florian Mayer <fmayer@google.com>
> ---
>  Documentation/filesystems/proc.rst |  2 ++
>  fs/coredump.c                      | 17 ++++++++++-------
>  fs/proc/array.c                    | 12 ++++++++----
>  include/linux/sched/signal.h       |  1 +
>  include/linux/sched/task.h         |  2 +-
>  kernel/exit.c                      |  5 +++--
>  kernel/pid_namespace.c             |  4 +++-
>  kernel/signal.c                    | 29 +++++++++++++++++++----------
>  8 files changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index e7aafc82be99..12ad5ecd7434 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -381,6 +381,8 @@ It's slow but very precise.
>    env_end       address below which program environment is placed
>    exit_code     the thread's exit_code in the form reported by the waitpid
>  		system call
> +  exit_sicode   if the process was stopped or terminated by a signal, the
> +		signal's si_code. 0 otherwise
>    ============= ===============================================================
>  
>  The /proc/PID/maps file contains the currently mapped memory regions and
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9f4aae202109..61e9f27d2bf8 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -349,7 +349,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  	return ispipe;
>  }
>  
> -static int zap_process(struct task_struct *start, int exit_code)
> +static int zap_process(struct task_struct *start, int exit_code, int sicode)
>  {
>  	struct task_struct *t;
>  	int nr = 0;
> @@ -357,6 +357,7 @@ static int zap_process(struct task_struct *start, int exit_code)
>  	/* ignore all signals except SIGKILL, see prepare_signal() */
>  	start->signal->flags = SIGNAL_GROUP_EXIT;
>  	start->signal->group_exit_code = exit_code;
> +	start->signal->group_exit_sicode = sicode;
>  	start->signal->group_stop_count = 0;
>  
>  	for_each_thread(start, t) {
> @@ -371,8 +372,8 @@ static int zap_process(struct task_struct *start, int exit_code)
>  	return nr;
>  }
>  
> -static int zap_threads(struct task_struct *tsk,
> -			struct core_state *core_state, int exit_code)
> +static int zap_threads(struct task_struct *tsk, struct core_state *core_state,
> +		       int exit_code, int sicode)
>  {
>  	struct signal_struct *signal = tsk->signal;
>  	int nr = -EAGAIN;
> @@ -380,7 +381,7 @@ static int zap_threads(struct task_struct *tsk,
>  	spin_lock_irq(&tsk->sighand->siglock);
>  	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
>  		signal->core_state = core_state;
> -		nr = zap_process(tsk, exit_code);
> +		nr = zap_process(tsk, exit_code, sicode);
>  		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
>  		tsk->flags |= PF_DUMPCORE;
>  		atomic_set(&core_state->nr_threads, nr);
> @@ -389,7 +390,8 @@ static int zap_threads(struct task_struct *tsk,
>  	return nr;
>  }
>  
> -static int coredump_wait(int exit_code, struct core_state *core_state)
> +static int coredump_wait(int exit_code, int sicode,
> +			 struct core_state *core_state)
>  {
>  	struct task_struct *tsk = current;
>  	int core_waiters = -EBUSY;
> @@ -398,7 +400,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  	core_state->dumper.task = tsk;
>  	core_state->dumper.next = NULL;
>  
> -	core_waiters = zap_threads(tsk, core_state, exit_code);
> +	core_waiters = zap_threads(tsk, core_state, exit_code, sicode);
>  	if (core_waiters > 0) {
>  		struct core_thread *ptr;
>  
> @@ -560,7 +562,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		need_suid_safe = true;
>  	}
>  
> -	retval = coredump_wait(siginfo->si_signo, &core_state);
> +	retval =
> +		coredump_wait(siginfo->si_signo, siginfo->si_code, &core_state);
>  	if (retval < 0)
>  		goto fail_creds;
>  
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 99fcbfda8e25..23553460627c 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -474,6 +474,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  	unsigned long rsslim = 0;
>  	unsigned long flags;
>  	int exit_code = task->exit_code;
> +	int exit_sicode = 0;
>  
>  	state = *get_task_state(task);
>  	vsize = eip = esp = 0;
> @@ -538,8 +539,10 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  			thread_group_cputime_adjusted(task, &utime, &stime);
>  			gtime += sig->gtime;
>  
> -			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
> +			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED)) {
>  				exit_code = sig->group_exit_code;
> +				exit_sicode = sig->group_exit_sicode;
> +			}
>  		}
>  
>  		sid = task_session_nr_ns(task, ns);
> @@ -638,10 +641,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  	} else
>  		seq_puts(m, " 0 0 0 0 0 0 0");
>  
> -	if (permitted)
> +	if (permitted) {
>  		seq_put_decimal_ll(m, " ", exit_code);
> -	else
> -		seq_puts(m, " 0");
> +		seq_put_decimal_ll(m, " ", exit_sicode);
> +	} else
> +		seq_puts(m, " 0 0");
>  
>  	seq_putc(m, '\n');
>  	if (mm)
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index cafbe03eed01..1631dba7a7db 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -109,6 +109,7 @@ struct signal_struct {
>  
>  	/* thread group exit support */
>  	int			group_exit_code;
> +	int			group_exit_sicode;
>  	/* notify group_exec_task when notify_count is less or equal to 0 */
>  	int			notify_count;
>  	struct task_struct	*group_exec_task;
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 81cab4b01edc..6ff4825fc88a 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -82,7 +82,7 @@ static inline void exit_thread(struct task_struct *tsk)
>  {
>  }
>  #endif
> -extern __noreturn void do_group_exit(int);
> +extern __noreturn void do_group_exit(int,int);
>  
>  extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct task_struct *);
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 84021b24f79e..278469d13433 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -897,7 +897,7 @@ SYSCALL_DEFINE1(exit, int, error_code)
>   * as well as by sys_exit_group (below).
>   */
>  void __noreturn
> -do_group_exit(int exit_code)
> +do_group_exit(int exit_code, int sicode)
>  {
>  	struct signal_struct *sig = current->signal;
>  
> @@ -916,6 +916,7 @@ do_group_exit(int exit_code)
>  			exit_code = 0;
>  		else {
>  			sig->group_exit_code = exit_code;
> +			sig->group_exit_sicode = sicode;
>  			sig->flags = SIGNAL_GROUP_EXIT;
>  			zap_other_threads(current);
>  		}
> @@ -933,7 +934,7 @@ do_group_exit(int exit_code)
>   */
>  SYSCALL_DEFINE1(exit_group, int, error_code)
>  {
> -	do_group_exit((error_code & 0xff) << 8);
> +	do_group_exit((error_code & 0xff) << 8, 0);
>  	/* NOTREACHED */
>  	return 0;
>  }
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index f4f8cb0435b4..c80db136726d 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -248,8 +248,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> -	if (pid_ns->reboot)
> +	if (pid_ns->reboot) {
>  		current->signal->group_exit_code = pid_ns->reboot;
> +		current->signal->group_exit_sicode = 0;
> +	}
>  
>  	acct_exit_ns(pid_ns);
>  	return;
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 6f86fda5e432..180310a9171c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -963,6 +963,7 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>  			signal_set_stop_flags(signal, why | SIGNAL_STOP_CONTINUED);
>  			signal->group_stop_count = 0;
>  			signal->group_exit_code = 0;
> +			signal->group_exit_sicode = 0;
>  		}
>  	}
>  
> @@ -994,7 +995,8 @@ static inline bool wants_signal(int sig, struct task_struct *p)
>  	return task_curr(p) || !task_sigpending(p);
>  }
>  
> -static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
> +static void complete_signal(int sig, int code, struct task_struct *p,
> +			    enum pid_type type)
>  {
>  	struct signal_struct *signal = p->signal;
>  	struct task_struct *t;
> @@ -1051,6 +1053,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>  			 */
>  			signal->flags = SIGNAL_GROUP_EXIT;
>  			signal->group_exit_code = sig;
> +			signal->group_exit_sicode = code;
>  			signal->group_stop_count = 0;
>  			t = p;
>  			do {
> @@ -1082,6 +1085,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>  	struct sigqueue *q;
>  	int override_rlimit;
>  	int ret = 0, result;
> +	int code = 0;
>  
>  	lockdep_assert_held(&t->sighand->siglock);
>  
> @@ -1129,7 +1133,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>  			clear_siginfo(&q->info);
>  			q->info.si_signo = sig;
>  			q->info.si_errno = 0;
> -			q->info.si_code = SI_USER;
> +			code = q->info.si_code = SI_USER;
>  			q->info.si_pid = task_tgid_nr_ns(current,
>  							task_active_pid_ns(t));
>  			rcu_read_lock();
> @@ -1142,12 +1146,13 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>  			clear_siginfo(&q->info);
>  			q->info.si_signo = sig;
>  			q->info.si_errno = 0;
> -			q->info.si_code = SI_KERNEL;
> +			code = q->info.si_code = SI_KERNEL;
>  			q->info.si_pid = 0;
>  			q->info.si_uid = 0;
>  			break;
>  		default:
>  			copy_siginfo(&q->info, info);
> +			code = info->si_code;
>  			break;
>  		}
>  	} else if (!is_si_special(info) &&
> @@ -1186,7 +1191,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>  		}
>  	}
>  
> -	complete_signal(sig, t, type);
> +	complete_signal(sig, code, t, type);
>  ret:
>  	trace_signal_generate(sig, info, t, type != PIDTYPE_PID, result);
>  	return ret;
> @@ -1960,6 +1965,7 @@ void sigqueue_free(struct sigqueue *q)
>  int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  {
>  	int sig = q->info.si_signo;
> +	int code = q->info.si_code;
>  	struct sigpending *pending;
>  	struct task_struct *t;
>  	unsigned long flags;
> @@ -1995,7 +2001,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
>  	list_add_tail(&q->list, &pending->list);
>  	sigaddset(&pending->signal, sig);
> -	complete_signal(sig, t, type);
> +	complete_signal(sig, code, t, type);
>  	result = TRACE_SIGNAL_DELIVERED;
>  out:
>  	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
> @@ -2380,7 +2386,7 @@ int ptrace_notify(int exit_code, unsigned long message)
>   * %false if group stop is already cancelled or ptrace trap is scheduled.
>   * %true if participated in group stop.
>   */
> -static bool do_signal_stop(int signr)
> +static bool do_signal_stop(int signr, int sicode)
>  	__releases(&current->sighand->siglock)
>  {
>  	struct signal_struct *sig = current->signal;
> @@ -2415,8 +2421,10 @@ static bool do_signal_stop(int signr)
>  		 * an intervening stop signal is required to cause two
>  		 * continued events regardless of ptrace.
>  		 */
> -		if (!(sig->flags & SIGNAL_STOP_STOPPED))
> +		if (!(sig->flags & SIGNAL_STOP_STOPPED)) {
>  			sig->group_exit_code = signr;
> +			sig->group_exit_sicode = sicode;
> +		}
>  
>  		sig->group_stop_count = 0;
>  
> @@ -2701,7 +2709,7 @@ bool get_signal(struct ksignal *ksig)
>  		}
>  
>  		if (unlikely(current->jobctl & JOBCTL_STOP_PENDING) &&
> -		    do_signal_stop(0))
> +		    do_signal_stop(0, 0))
>  			goto relock;
>  
>  		if (unlikely(current->jobctl &
> @@ -2806,7 +2814,8 @@ bool get_signal(struct ksignal *ksig)
>  				spin_lock_irq(&sighand->siglock);
>  			}
>  
> -			if (likely(do_signal_stop(ksig->info.si_signo))) {
> +			if (likely(do_signal_stop(ksig->info.si_signo,
> +						  ksig->info.si_code))) {
>  				/* It released the siglock.  */
>  				goto relock;
>  			}
> @@ -2854,7 +2863,7 @@ bool get_signal(struct ksignal *ksig)
>  		/*
>  		 * Death signals, no core dump.
>  		 */
> -		do_group_exit(ksig->info.si_signo);
> +		do_group_exit(ksig->info.si_signo, ksig->info.si_code);
>  		/* NOTREACHED */
>  	}
>  	spin_unlock_irq(&sighand->siglock);
