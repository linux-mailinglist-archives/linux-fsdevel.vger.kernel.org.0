Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C64506E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhKOOcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 09:32:04 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53344 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhKOObp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:31:45 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:58080)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmcyT-004MGR-Fd; Mon, 15 Nov 2021 07:28:45 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:34974 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmcyR-00HQ6w-NQ; Mon, 15 Nov 2021 07:28:45 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Vladimir Divjak <vladimir.divjak@bmw.de>
Cc:     <viro@zeniv.linux.org.uk>, <mcgrof@kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <will@kernel.org>, <yuzhao@google.com>, <hannes@cmpxchg.org>,
        <fenghua.yu@intel.com>, <guro@fb.com>, <jgg@ziepe.ca>,
        <hughd@google.com>, <axboe@kernel.dk>, <pcc@google.com>,
        <tglx@linutronix.de>, <elver@google.com>, <jannh@google.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, <linux-api@vger.kernel.org>
References: <20211115091540.3806073-1-vladimir.divjak@bmw.de>
Date:   Mon, 15 Nov 2021 08:28:09 -0600
In-Reply-To: <20211115091540.3806073-1-vladimir.divjak@bmw.de> (Vladimir
        Divjak's message of "Mon, 15 Nov 2021 10:15:40 +0100")
Message-ID: <87wnl9fq86.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mmcyR-00HQ6w-NQ;;;mid=<87wnl9fq86.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18G+DoGfFfG9gfrkAu/MHcNxFo+W0XCKM0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Vladimir Divjak <vladimir.divjak@bmw.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1154 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 13 (1.2%), b_tie_ro: 11 (1.0%), parse: 1.72
        (0.1%), extract_message_metadata: 18 (1.6%), get_uri_detail_list: 6
        (0.5%), tests_pri_-1000: 6 (0.5%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 183 (15.8%), check_bayes:
        181 (15.7%), b_tokenize: 23 (2.0%), b_tok_get_all: 16 (1.4%),
        b_comp_prob: 4.1 (0.4%), b_tok_touch_all: 133 (11.5%), b_finish: 0.93
        (0.1%), tests_pri_0: 821 (71.2%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 87 (7.5%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 102 (8.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] coredump-ptrace: Delayed delivery of SIGSTOP
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Added Oleg and linux-api.

Vladimir Divjak <vladimir.divjak@bmw.de> writes:

> Allow SIGSTOP to be delivered to the dying process,
> if it is coming from coredump user mode helper (umh)
> process, but delay it until coredump is finished,
> at which point it will be re-triggered in coredump_finish().
>
> When processing this signal, set the tasks of the dying process
> directly to TASK_TRACED state during complete_signal(),
> instead of attempting signal_wake_up().
>
> Do so to allow the umh process to ptrace(PTRACE_ATTACH,...)
> to the dying process, whose coredump it's handling.
>
> * Problem description:
> In automotive and/or embedded environments,
> the storage capacity to store, and/or
> network capabilities to upload
> a complete core file can easily be a limiting factor,
> making offline crash analysis difficult.
>
> * Solution:
> Allow the user mode coredump helper process
> to perform ptrace on the dying process in order to obtain
> useful information such as user mode stacktrace,
> thereby improving the offline debugging possibilities
> for such environments.

I don't think PTRACE_ATTACH is fundamentally wrong during a coredump.

Allowing SIGSTOP is fundamentally wrong.  Processing any signal after
receiving a fatal signal that will result in coredump is wrong.  There
is a small exception for SIGKILL which will terminate the coredump.


I think what you are actually looking for is PTRACE_SEIZE and stopping
at PTRACE_EVENT_EXIT both of which already exist.

There may be something preventing them from working and if some please
let me know.  I took a quick skim through the code and it looks like
PTRACE_SEIZE and PTRACE_EVENT_EXIT should just work with no changes
to the current code.


I think this is also possible by filtering the coredump that is piped to
a userspace coredump process.  So I am not certain what is gained.  But
if PTRACE_SEIZE and PTRACE_EVENT_EXIT already work there is no point
in not allowing what you are looking for either.


I really really don't like the patch below.  It gives me the heebie
jeebies.  It is doing so many weird and questionable things on so many
layers.

There is already a mechanism to get the pid of the user mode helper.
All you need to do is capture the pid in the init/setup routine
passed to call_usermodehelper_setup.

Supporting SIGSTOP when the process is dying is horrible, and
with PTRACE_SEIZE completely unnecessary.

There is no reason to believe next_signal will necessary be SIGSTOP
if a process is being coredumps.  There may be all manner of pending
signals.

I don't think you can safely change the task state of another process.
You certainly can't do it without using the task state change helpers.
There also need to be a verification that the task is in some kind of
stop state before it might be safe.

In general I have having trouble finding even a line of the code
change below that is not wrong for some reason.  So please please don't
start with this code change if PTRACE_SEIZE + PTRACE_EVENT_EXIT needs
some work.

Eric


> Signed-off-by: Vladimir Divjak <vladimir.divjak@bmw.de>
> ---
>  fs/coredump.c            | 18 +++++++++--
>  include/linux/mm_types.h |  2 ++
>  include/linux/umh.h      |  1 +
>  kernel/signal.c          | 64 +++++++++++++++++++++++++++++++++++++---
>  kernel/umh.c             |  7 +++--
>  5 files changed, 84 insertions(+), 8 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 2868e3e171ae..9a51a1a2168d 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -487,6 +487,20 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
>  {
>  	struct core_thread *curr, *next;
>  	struct task_struct *task;
> +	int signr;
> +	struct ksignal ksig;
> +
> +	current->mm->core_state->core_dumped = true;
                                 ^^^^^^^^^^^  See the core_dumped argument

It is completely possible for coredump_finish to be called because
the coredump was interrupted with SIGKILL.  In which case reporting that
the was dumped is incorrect.

> +
> +	/*
> +	 * Check if there is a SIGSTOP pending, and if so, re-trigger its delivery
> +	 * allowing the coredump umh process to do a ptrace on this one.
> +	 */
> +	spin_lock_irq(&current->sighand->siglock);
> +	signr = next_signal(&current->pending, &current->blocked);
> +	spin_unlock_irq(&current->sighand->siglock);
> +	if (signr == SIGSTOP)
> +		get_signal(&ksig);
>  
>  	spin_lock_irq(&current->sighand->siglock);
>  	if (core_dumped && !__fatal_signal_pending(current))
> @@ -601,7 +615,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		 */
>  		.mm_flags = mm->flags,
>  	};
> -
> +	core_state.core_dumped = false;
>  	audit_core_dumps(siginfo->si_signo);
>  
>  	binfmt = mm->binfmt;
> @@ -695,7 +709,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		if (sub_info)
>  			retval = call_usermodehelper_exec(sub_info,
>  							  UMH_WAIT_EXEC);
> -
> +		core_state.umh_pid = sub_info->pid;
>  		kfree(helper_argv);
>  		if (retval) {
>  			printk(KERN_INFO "Core dump to |%s pipe failed\n",
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6613b26a8894..475b3d8cd399 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -381,6 +381,8 @@ struct core_state {
>  	atomic_t nr_threads;
>  	struct core_thread dumper;
>  	struct completion startup;
> +	bool core_dumped;
> +	pid_t umh_pid;
>  };
>  
>  struct kioctx_table;
> diff --git a/include/linux/umh.h b/include/linux/umh.h
> index 244aff638220..b2bbcafe7c98 100644
> --- a/include/linux/umh.h
> +++ b/include/linux/umh.h
> @@ -24,6 +24,7 @@ struct subprocess_info {
>  	char **envp;
>  	int wait;
>  	int retval;
> +	pid_t pid;
>  	int (*init)(struct subprocess_info *info, struct cred *new);
>  	void (*cleanup)(struct subprocess_info *info);
>  	void *data;
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 66e88649cf74..5e7812644c8a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -943,8 +943,22 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>  	sigset_t flush;
>  
>  	if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
> -		if (!(signal->flags & SIGNAL_GROUP_EXIT))
> -			return sig == SIGKILL;
> +		if (!(signal->flags & SIGNAL_GROUP_EXIT)) {
> +			/*
> +			 * If the signal is for the process being core-dumped
> +			 * and the signal is SIGSTOP sent by the coredump umh process
> +			 * let it through (in addition to SIGKILL)
> +			 * allowing the coredump umh process to ptrace the dying process.
> +			 */
> +			bool sig_from_umh = false;
> +
> +			if (unlikely(p->mm && p->mm->core_state &&
> +				p->mm->core_state->umh_pid == current->tgid)) {
> +				sig_from_umh = true;
> +			}
> +			return sig == SIGKILL || (sig == SIGSTOP && sig_from_umh);
> +		}
> +
>  		/*
>  		 * The process is in the middle of dying, nothing to do.
>  		 */
> @@ -1014,8 +1028,18 @@ static inline bool wants_signal(int sig, struct task_struct *p)
>  	if (sigismember(&p->blocked, sig))
>  		return false;
>  
> -	if (p->flags & PF_EXITING)
> +	if (p->flags & PF_EXITING) {
> +		/*
> +		 * Ignore the fact the process is exiting,
> +		 * if it's being core-dumped, and the signal is SIGSTOP
> +		 * allowing the coredump umh process to ptrace the dying process.
> +		 * See prepare_signal().
> +		 */
> +		if (unlikely(p->mm && p->mm->core_state && sig == SIGSTOP))
> +			return true;
> +
>  		return false;
> +	}
>  
>  	if (sig == SIGKILL)
>  		return true;
> @@ -1094,6 +1118,22 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>  		}
>  	}
>  
> +	/*
> +	 * If the signal is completed for a process being core-dumped,
> +	 * and the signal is SIGSTOP, there is no point in waking up its tasks,
> +	 * as they are either dumping the core, or in uninterruptible state,
> +	 * so skip the wake up if core-dump is not yet completed.
> +	 * Instead, if the core-dump has been completed, see coredump_finish()
> +	 * set the task state directly to TASK_TRACED,
> +	 * allowing the coredump umh process to ptrace the dying process.
> +	 */
> +	if (unlikely(t->mm && t->mm->core_state) && sig == SIGSTOP) {
> +		if (t->mm->core_state->core_dumped)
> +			t->state = TASK_TRACED;
> +
> +		return;
> +	}
> +
>  	/*
>  	 * The signal is already in the shared-pending queue.
>  	 * Tell the chosen thread to wake up and dequeue it.
> @@ -2586,6 +2626,7 @@ bool get_signal(struct ksignal *ksig)
>  	struct sighand_struct *sighand = current->sighand;
>  	struct signal_struct *signal = current->signal;
>  	int signr;
> +	bool sigstop_pending = false;
>  
>  	if (unlikely(current->task_works))
>  		task_work_run();
> @@ -2651,8 +2692,23 @@ bool get_signal(struct ksignal *ksig)
>  		goto relock;
>  	}
>  
> +
> +	/*
> +	 * If this task is being core-dumped,
> +	 * and the next signal is SIGSTOP, allow its delivery
> +	 * to enable the coredump umh process to ptrace the dying one.
> +	 */
> +	if (unlikely(current->mm && current->mm->core_state)) {
> +		int nextsig = 0;
> +
> +		nextsig = next_signal(&current->pending, &current->blocked);
> +		if (nextsig == SIGSTOP) {
> +			sigstop_pending = true;
> +		}
> +	}
> +
>  	/* Has this task already been marked for death? */
> -	if (signal_group_exit(signal)) {
> +	if (signal_group_exit(signal) && !sigstop_pending) {
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
>  		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 36c123360ab8..8ac027c75d70 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -107,6 +107,7 @@ static int call_usermodehelper_exec_async(void *data)
>  	}
>  
>  	commit_creds(new);
> +	sub_info->pid = task_pid_nr(current);
>  
>  	wait_for_initramfs();
>  	retval = kernel_execve(sub_info->path,
> @@ -133,10 +134,12 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
>  	/* If SIGCLD is ignored do_wait won't populate the status. */
>  	kernel_sigaction(SIGCHLD, SIG_DFL);
>  	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
> -	if (pid < 0)
> +	if (pid < 0) {
>  		sub_info->retval = pid;
> -	else
> +	} else {
> +		sub_info->pid = pid;
>  		kernel_wait(pid, &sub_info->retval);
> +	}
>  
>  	/* Restore default kernel sig handler */
>  	kernel_sigaction(SIGCHLD, SIG_IGN);
