Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1961B64A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 21:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDWTmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 15:42:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44078 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWTmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:42:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhkI-0007IC-E3; Thu, 23 Apr 2020 13:42:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhkH-00022D-GR; Thu, 23 Apr 2020 13:42:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
Date:   Thu, 23 Apr 2020 14:39:41 -0500
In-Reply-To: <87ftcv1nqe.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 22 Apr 2020 11:36:41 -0500")
Message-ID: <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jRhkH-00022D-GR;;;mid=<87wo66vvnm.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+p1OI9uD+ggl4NnOJQC9jcVE7p3h3y1M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;LKML <linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 526 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 0.86
        (0.2%), extract_message_metadata: 10 (2.0%), get_uri_detail_list: 1.91
        (0.4%), tests_pri_-1000: 13 (2.5%), tests_pri_-950: 1.32 (0.3%),
        tests_pri_-900: 1.20 (0.2%), tests_pri_-90: 182 (34.6%), check_bayes:
        180 (34.2%), b_tokenize: 10 (1.9%), b_tok_get_all: 30 (5.7%),
        b_comp_prob: 4.0 (0.8%), b_tok_touch_all: 130 (24.8%), b_finish: 1.37
        (0.3%), tests_pri_0: 294 (55.8%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 1.09 (0.2%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When the thread group leader changes during exec and the old leaders
thread is reaped proc_flush_pid will flush the dentries for the entire
process because the leader still has it's original pid.

Fix this by exchanging the pids in an rcu safe manner,
and wrapping the code to do that up in a helper exchange_tids.

When I removed switch_exec_pids and introduced this behavior
in d73d65293e3e ("[PATCH] pidhash: kill switch_exec_pids") there
really was nothing that cared as flushing happened with
the cached dentry and de_thread flushed both of them on exec.

This lack of fully exchanging pids became a problem a few months later
when I introduced 48e6484d4902 ("[PATCH] proc: Rewrite the proc dentry
flush on exit optimization").  Which overlooked the de_thread case
was no longer swapping pids, and I was looking up proc dentries
by task->pid.

The current behavior isn't properly a bug as everything in proc will
continue to work correctly just a little bit less efficiently.  Fix
this just so there are no little surprise corner cases waiting to bite
people.

-- Oleg points out this could be an issue in next_tgid in proc where
   has_group_leader_pid is called, and reording some of the assignments
   should fix that.

-- Oleg points out this will break the 10 year old hack in __exit_signal.c
>	/*
>	 * This can only happen if the caller is de_thread().
>	 * FIXME: this is the temporary hack, we should teach
>	 * posix-cpu-timers to handle this case correctly.
>	 */
>	if (unlikely(has_group_leader_pid(tsk)))
>		posix_cpu_timers_exit_group(tsk);

The code in next_tgid has been changed to use PIDTYPE_TGID,
and the posix cpu timers code has been fixed so it does not
need the 10 year old hack, so this should be safe to merge
now.

Fixes: 48e6484d4902 ("[PATCH] proc: Rewrite the proc dentry flush on exit optimization").
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/exec.c           |  5 +----
 include/linux/pid.h |  1 +
 kernel/pid.c        | 16 ++++++++++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..9b60f927afd7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1186,11 +1186,8 @@ static int de_thread(struct task_struct *tsk)
 
 		/* Become a process group leader with the old leader's pid.
 		 * The old leader becomes a thread of the this thread group.
-		 * Note: The old leader also uses this pid until release_task
-		 *       is called.  Odd but simple and correct.
 		 */
-		tsk->pid = leader->pid;
-		change_pid(tsk, PIDTYPE_PID, task_pid(leader));
+		exchange_tids(tsk, leader);
 		transfer_pid(leader, tsk, PIDTYPE_TGID);
 		transfer_pid(leader, tsk, PIDTYPE_PGID);
 		transfer_pid(leader, tsk, PIDTYPE_SID);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index cc896f0fc4e3..2159ffca63fc 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -102,6 +102,7 @@ extern void attach_pid(struct task_struct *task, enum pid_type);
 extern void detach_pid(struct task_struct *task, enum pid_type);
 extern void change_pid(struct task_struct *task, enum pid_type,
 			struct pid *pid);
+extern void exchange_tids(struct task_struct *task, struct task_struct *old);
 extern void transfer_pid(struct task_struct *old, struct task_struct *new,
 			 enum pid_type);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index c835b844aca7..4ece32d8791a 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -363,6 +363,22 @@ void change_pid(struct task_struct *task, enum pid_type type,
 	attach_pid(task, type);
 }
 
+void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
+{
+	/* pid_links[PIDTYPE_PID].next is always NULL */
+	struct pid *npid = READ_ONCE(ntask->thread_pid);
+	struct pid *opid = READ_ONCE(otask->thread_pid);
+
+	rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
+	rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
+	rcu_assign_pointer(ntask->thread_pid, opid);
+	rcu_assign_pointer(otask->thread_pid, npid);
+	WRITE_ONCE(ntask->pid_links[PIDTYPE_PID].pprev, &opid->tasks[PIDTYPE_PID].first);
+	WRITE_ONCE(otask->pid_links[PIDTYPE_PID].pprev, &npid->tasks[PIDTYPE_PID].first);
+	WRITE_ONCE(ntask->pid, pid_nr(opid));
+	WRITE_ONCE(otask->pid, pid_nr(npid));
+}
+
 /* transfer_pid is an optimization of attach_pid(new), detach_pid(old) */
 void transfer_pid(struct task_struct *old, struct task_struct *new,
 			   enum pid_type type)
-- 
2.20.1

