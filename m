Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D62066C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbgFWWAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 18:00:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58744 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388125AbgFWWAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:00:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqyF-0004gJ-GE; Tue, 23 Jun 2020 16:00:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqyE-00011w-IF; Tue, 23 Jun 2020 16:00:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:56:23 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <87sgeljvjs.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqyE-00011w-IF;;;mid=<87sgeljvjs.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//9RpPvm0Ju/m/af9xHXdmD0J+69ybl0M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 543 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.15
        (0.2%), extract_message_metadata: 19 (3.4%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 24 (4.3%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 159 (29.2%), check_bayes:
        157 (28.9%), b_tokenize: 17 (3.1%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 4.3 (0.8%), b_tok_touch_all: 123 (22.6%), b_finish: 1.00
        (0.2%), tests_pri_0: 313 (57.7%), check_dkim_signature: 0.82 (0.2%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 6/6] exec: Rename group_exit_task group_exec_task and correct the Documentation
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Rename group_exit_task to group_exec_task to make it clear this
field is only used during exec.

Update the comments for the fields group_exec_task and notify_count as
they are only used by exec.  Notifications to the execing task aka
group_exec_task happen at 0 and -1.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    |  8 ++++----
 include/linux/sched/signal.h | 11 ++++-------
 kernel/exit.c                |  4 ++--
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9c4c1ab8f715..c594af64acd2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1146,7 +1146,7 @@ static int de_thread(struct task_struct *tsk)
 	}
 
 	sig->flags |= SIGNAL_GROUP_DETHREAD;
-	sig->group_exit_task = tsk;
+	sig->group_exec_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
@@ -1175,7 +1175,7 @@ static int de_thread(struct task_struct *tsk)
 			spin_lock(lock);
 			/*
 			 * Do this under tasklist_lock to ensure that
-			 * exit_notify() can't miss ->group_exit_task
+			 * exit_notify() can't miss ->group_exec_task
 			 */
 			sig->notify_count = -1;
 			if (likely(leader->exit_state))
@@ -1246,7 +1246,7 @@ static int de_thread(struct task_struct *tsk)
 
 	spin_lock_irq(lock);
 	sig->flags &= ~SIGNAL_GROUP_DETHREAD;
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock_irq(lock);
 
@@ -1262,7 +1262,7 @@ static int de_thread(struct task_struct *tsk)
 	read_lock_irq(&tasklist_lock);
 	spin_lock(lock);
 	sig->flags &= ~SIGNAL_GROUP_DETHREAD;
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock(lock);
 	read_unlock_irq(&tasklist_lock);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 43822e2b63e6..ad6b209b1363 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -98,13 +98,10 @@ struct signal_struct {
 
 	/* thread group exit support */
 	int			group_exit_code;
-	/* overloaded:
-	 * - notify group_exit_task when ->count is equal to notify_count
-	 * - everyone except group_exit_task is stopped during signal delivery
-	 *   of fatal signals, group_exit_task processes the signal.
-	 */
+
+	/* exec support, notify group_exec_task when notify_count is 0 or -1 */
 	int			notify_count;
-	struct task_struct	*group_exit_task;
+	struct task_struct	*group_exec_task;
 
 	/* thread group stop support, overloads group_exit_code too */
 	int			group_stop_count;
@@ -265,7 +262,7 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 	sig->flags = (sig->flags & ~SIGNAL_STOP_MASK) | flags;
 }
 
-/* If true, all threads except ->group_exit_task have pending SIGKILL */
+/* If true, all threads except ->group_exec_task have pending SIGKILL */
 static inline int signal_group_exit(const struct signal_struct *sig)
 {
 	return	(sig->flags & (SIGNAL_GROUP_EXIT |
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f28103..4206d33b4904 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -115,7 +115,7 @@ static void __exit_signal(struct task_struct *tsk)
 		 * then notify it:
 		 */
 		if (sig->notify_count > 0 && !--sig->notify_count)
-			wake_up_process(sig->group_exit_task);
+			wake_up_process(sig->group_exec_task);
 
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
@@ -672,7 +672,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 
 	/* mt-exec, de_thread() is waiting for group leader */
 	if (unlikely(tsk->signal->notify_count < 0))
-		wake_up_process(tsk->signal->group_exit_task);
+		wake_up_process(tsk->signal->group_exec_task);
 	write_unlock_irq(&tasklist_lock);
 
 	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
-- 
2.20.1

