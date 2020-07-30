Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F2233BA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgG3W77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 18:59:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41580 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3W77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:59:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1HWm-0020SL-70; Thu, 30 Jul 2020 16:59:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1HWk-0006md-Hb; Thu, 30 Jul 2020 16:59:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
        <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
        <87d04fhkyz.fsf@x220.int.ebiederm.org>
        <87h7trg4ie.fsf@x220.int.ebiederm.org>
        <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
        <878sf16t34.fsf@x220.int.ebiederm.org>
Date:   Thu, 30 Jul 2020 17:56:45 -0500
In-Reply-To: <878sf16t34.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 30 Jul 2020 08:16:47 -0500")
Message-ID: <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1HWk-0006md-Hb;;;mid=<87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5iVlOpukdhK3Is3+8qmtO7vex3LGrfR8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1093 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 14 (1.3%), b_tie_ro: 12 (1.1%), parse: 2.5 (0.2%),
         extract_message_metadata: 24 (2.2%), get_uri_detail_list: 8 (0.8%),
        tests_pri_-1000: 19 (1.7%), tests_pri_-950: 1.64 (0.2%),
        tests_pri_-900: 1.36 (0.1%), tests_pri_-90: 282 (25.8%), check_bayes:
        280 (25.6%), b_tokenize: 22 (2.0%), b_tok_get_all: 124 (11.3%),
        b_comp_prob: 7 (0.6%), b_tok_touch_all: 122 (11.2%), b_finish: 1.15
        (0.1%), tests_pri_0: 688 (63.0%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.58 (0.1%), tests_pri_10:
        2.7 (0.2%), tests_pri_500: 51 (4.6%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Right now I think I see solutions to the problems of exec without
using this code.

However this code is tested and working for the common cases (and has no
lockdep warnings) and the techniques it is using could potentially be
used to simplify the freezer, the cgroup v1 freezer, or the cgroup v2
freezer.

The key is the function make_task_wakekill which could probably
benefit from a little more review and refinement but appears to
be basically correct.

---
[This change requires more work to handle TASK_STOPPED and TASK_TRACED]
[This adds a new lock ordering dependency siglock -> pi_lock -> rq_lock ]

Many of the challenges of implementing a simple version of exec come
from the fact the code handles exec'ing multi-thread processes.

To the best of my knowledge processes with more than one thread
calling exec are not common, and as all of the threads will be killed
by exec there does not appear to be any useful work a thread can
reliably do during exec.

Therefore make it simpler to get exec correct by concealing the other
threads from wakeups at the beginning of exec.  This removes an entire
class of races, and makes it tractable to fix some of the long
standing issues with exec.

One issue that this change makes it easier to solve is the issue of
deailing with the file table.  Today exec unshares the file table at
the beginning to ensure there are no weird races with file
descriptors.  Unfortunately this unsharing can unshare the file table
when only threads of the current process share it.  Which results in
unnecessary unsharing and posix locks being inappropriately dropped by
a multi-threaded exec.  With all of the threads frozen the thread
count is stable and it is easy to tell if the if the file table really
needs to be unshared by exec.

Further this changes allows seccomp to stop taking cred_guard_mutex,
as the seccomp code takes cred_guard_mutex to protect against another
thread that is in the middle of calling exec and this change
guarantees that if one threads is calling exec all of the other threads
have stopped running.  So this problematic kind of concurrency between
threads can no longer happen.

The code in de_thread was modified to unmask the threads at the same
time as it is killing them ensuring that code continues to work as it
does today, and without introducing any races where a thread might
perform any problematic work in the middle of de_thread.

The code in fork is modified to fail if another thread in the parent
is in the middle of fork.

A new generic scheduler function make_task_killable is added.
I think the locking is ok, changing task->state under
both pi_lock and the rq_lock, but I have not done a detailed
looked yet to confirm that I am not missing something subtle.

A new function exec_conceal_threads is added, to set
group_execing_task and walk through all of the threads and change
their state to TASK_WAKEKILL if it is not already.

A new companion function exec_reveal_threads sends a wake up to all of
the other threads and clear group_execing_task.  This may cause a
spuroius wake up but that is an uncommon case and the code for
TASK_UNINTERRUPTIBLE and TASK_INTERRUPTIBLE is expected to be handle
spurious so it should be fine.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 98 +++++++++++++++++++++++++++++++++++-
 include/linux/sched.h        |  2 +
 include/linux/sched/signal.h |  3 ++
 kernel/fork.c                |  6 +++
 kernel/sched/core.c          | 38 ++++++++++++++
 kernel/signal.c              | 11 ++++
 6 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3698252719a3..5e4b0187ac05 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1145,6 +1145,95 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
+static void exec_reveal_threads_locked(void)
+{
+	struct task_struct *p = current, *t;
+	struct signal_struct *signal = p->signal;
+
+	if (signal->group_execing_task) {
+		signal->group_execing_task = NULL;
+		__for_each_thread(signal, t) {
+			if (t == p)
+				continue;
+			/*
+			 * This might be a spurious wake up task t but
+			 * this should be fine as t should verify it
+			 * is the appropriate time to wake up and if
+			 * not fall back asleep.
+			 *
+			 * Any performance (rather than correctness)
+			 * implications of this code should be unimportant
+			 * as it is only called on error.
+			 */
+			wake_up_state(t, TASK_WAKEKILL);
+		}
+	}
+}
+
+static void exec_reveal_threads(void)
+{
+	spinlock_t *lock = &current->sighand->siglock;
+
+	spin_lock_irq(lock);
+	exec_reveal_threads_locked();
+	spin_unlock_irq(lock);
+}
+
+/*
+ * Conceal all other threads in the thread group from wakeups
+ */
+static int exec_conceal_threads(void)
+{
+	struct task_struct *me = current, *t;
+	struct signal_struct *signal = me->signal;
+	spinlock_t *lock = &me->sighand->siglock;
+	int ret = 0;
+
+	if (thread_group_empty(me))
+		return 0;
+
+	spin_lock_irq(lock);
+	if (signal_pending(me) || signal_group_exit(signal) ||
+	    signal->group_execing_task) {
+		spin_unlock(lock);
+		return -ERESTARTNOINTR;
+	}
+
+	signal->group_execing_task = me;
+	for (;;) {
+		unsigned int todo = 0;
+
+		__for_each_thread(signal, t) {
+			if ((t == me) || (t->flags & PF_EXITING))
+				continue;
+
+			if (make_task_wakekill(t))
+				continue;
+
+			signal_wake_up(t, 0);
+			todo++;
+		}
+
+		if ((todo == 0) || __fatal_signal_pending(me))
+			break;
+
+		set_current_state(TASK_KILLABLE);
+		spin_unlock_irq(lock);
+
+		schedule();
+
+		spin_lock_irq(lock);
+		if (__fatal_signal_pending(me))
+			break;
+	}
+	if (__fatal_signal_pending(me)) {
+		ret = -ERESTARTNOINTR;
+		exec_reveal_threads_locked();
+	}
+	spin_unlock_irq(lock);
+	return ret;
+}
+
 static int de_thread(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
@@ -1885,10 +1974,15 @@ static int bprm_execve(struct linux_binprm *bprm,
 	struct files_struct *displaced;
 	int retval;
 
-	retval = unshare_files(&displaced);
+	/* Conceal any other threads from wakeups */
+	retval = exec_conceal_threads();
 	if (retval)
 		return retval;
 
+	retval = unshare_files(&displaced);
+	if (retval)
+		goto out_ret;
+
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
 		goto out_files;
@@ -1949,6 +2043,8 @@ static int bprm_execve(struct linux_binprm *bprm,
 out_files:
 	if (displaced)
 		reset_files_struct(displaced);
+out_ret:
+	exec_reveal_threads();
 
 	return retval;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index edb2020875ad..dcd79e78b651 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1726,6 +1726,8 @@ extern void kick_process(struct task_struct *tsk);
 static inline void kick_process(struct task_struct *tsk) { }
 #endif
 
+extern int make_task_wakekill(struct task_struct *tsk);
+
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 
 static inline void set_task_comm(struct task_struct *tsk, const char *from)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1bad18a1d8ba..647b7d0d2231 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -106,6 +106,9 @@ struct signal_struct {
 	int			notify_count;
 	struct task_struct	*group_exit_task;
 
+	/* Task that is performing exec */
+	struct task_struct	*group_execing_task;
+
 	/* thread group stop support, overloads group_exit_code too */
 	int			group_stop_count;
 	unsigned int		flags; /* see SIGNAL_* flags below */
diff --git a/kernel/fork.c b/kernel/fork.c
index bf215af7a904..686c6901eabd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2247,6 +2247,12 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
+	/* Don't allow creation of new tasks during exec */
+	if (unlikely(current->signal->group_execing_task)) {
+		retval = -ERESTARTNOINTR;
+		goto bad_fork_cancel_cgroup;
+	}
+
 	/* past the last point of failure */
 	if (pidfile)
 		fd_install(pidfd, pidfile);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f360326861e..1ac8b81f22de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2648,6 +2648,44 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	return success;
 }
 
+int make_task_wakekill(struct task_struct *p)
+{
+	unsigned long flags;
+	int cpu, success = 0;
+	struct rq_flags rf;
+	struct rq *rq;
+	long state;
+
+	/* Assumes p != current */
+	preempt_disable();
+	/*
+	 * If we are going to change a thread waiting for CONDITION we
+	 * need to ensure that CONDITION=1 done by the caller can not be
+	 * reordered with p->state check below. This pairs with mb() in
+	 * set_current_state() the waiting thread does.
+	 */
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	smp_mb__after_spinlock();
+	state = p->state;
+
+	/* FIXME handle TASK_STOPPED and TASK_TRACED */
+	if ((state == TASK_KILLABLE) ||
+	    (state == TASK_INTERRUPTIBLE)) {
+		success = 1;
+		cpu = task_cpu(p);
+		rq = cpu_rq(cpu);
+		rq_lock(rq, &rf);
+		p->state = TASK_WAKEKILL;
+		rq_unlock(rq, &rf);
+	}
+	else if (state == TASK_WAKEKILL)
+		success = 1;
+
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	preempt_enable();
+	return success;
+}
+
 /**
  * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
  * @p: Process for which the function is to be invoked.
diff --git a/kernel/signal.c b/kernel/signal.c
index 5ca48cc5da76..19f73eda1d54 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2590,6 +2590,15 @@ bool get_signal(struct ksignal *ksig)
 		goto fatal;
 	}
 
+	/* Is this task concealing itself from wake-ups during exec? */
+	if (unlikely(signal->group_execing_task)) {
+		set_current_state(TASK_WAKEKILL);
+		wake_up_process(signal->group_execing_task);
+		spin_unlock_irq(&sighand->siglock);
+		schedule();
+		goto relock;
+	}
+
 	for (;;) {
 		struct k_sigaction *ka;
 
@@ -2849,6 +2858,8 @@ void exit_signals(struct task_struct *tsk)
 	    task_participate_group_stop(tsk))
 		group_stop = CLD_STOPPED;
 out:
+	if (unlikely(tsk->signal->group_execing_task))
+		wake_up_process(tsk->signal->group_execing_task);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/*
-- 
2.20.1

