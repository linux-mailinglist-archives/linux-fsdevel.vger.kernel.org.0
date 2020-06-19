Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E22201A77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 20:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgFSShl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 14:37:41 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40208 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgFSShl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:37:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLtS-0004KO-02; Fri, 19 Jun 2020 12:37:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLtR-0001qA-4j; Fri, 19 Jun 2020 12:37:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
Date:   Fri, 19 Jun 2020 13:33:19 -0500
In-Reply-To: <87pn9u6h8c.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 19 Jun 2020 13:30:27 -0500")
Message-ID: <87eeqa6h3k.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmLtR-0001qA-4j;;;mid=<87eeqa6h3k.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+KI2lJvwlCsNg7M5ExV7z+N31SkkoRnc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 475 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.1%), b_tie_ro: 9 (1.9%), parse: 1.33 (0.3%),
         extract_message_metadata: 17 (3.6%), get_uri_detail_list: 3.4 (0.7%),
        tests_pri_-1000: 18 (3.9%), tests_pri_-950: 1.65 (0.3%),
        tests_pri_-900: 1.34 (0.3%), tests_pri_-90: 90 (18.9%), check_bayes:
        88 (18.5%), b_tokenize: 14 (3.0%), b_tok_get_all: 12 (2.6%),
        b_comp_prob: 3.4 (0.7%), b_tok_touch_all: 54 (11.4%), b_finish: 0.94
        (0.2%), tests_pri_0: 318 (67.0%), check_dkim_signature: 0.75 (0.2%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.31 (0.1%), tests_pri_10:
        2.9 (0.6%), tests_pri_500: 10 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/2] exec: Rename group_exit_task group_exec_task and correct the Documentation
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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
 include/linux/sched/signal.h | 13 +++++--------
 kernel/exit.c                |  4 ++--
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..0bf8bde6edfd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1145,7 +1145,7 @@ static int de_thread(struct task_struct *tsk)
 		return -EAGAIN;
 	}
 
-	sig->group_exit_task = tsk;
+	sig->group_exec_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
 		sig->notify_count--;
@@ -1173,7 +1173,7 @@ static int de_thread(struct task_struct *tsk)
 			write_lock_irq(&tasklist_lock);
 			/*
 			 * Do this under tasklist_lock to ensure that
-			 * exit_notify() can't miss ->group_exit_task
+			 * exit_notify() can't miss ->group_exec_task
 			 */
 			sig->notify_count = -1;
 			if (likely(leader->exit_state))
@@ -1240,7 +1240,7 @@ static int de_thread(struct task_struct *tsk)
 		release_task(leader);
 	}
 
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 
 no_thread_group:
@@ -1253,7 +1253,7 @@ static int de_thread(struct task_struct *tsk)
 killed:
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock(&tasklist_lock);
-	sig->group_exit_task = NULL;
+	sig->group_exec_task = NULL;
 	sig->notify_count = 0;
 	read_unlock(&tasklist_lock);
 	return -EAGAIN;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 92c72f5db111..61019d8fe86b 100644
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
@@ -262,11 +259,11 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 	sig->flags = (sig->flags & ~SIGNAL_STOP_MASK) | flags;
 }
 
-/* If true, all threads except ->group_exit_task have pending SIGKILL */
+/* If true, all threads except ->group_exec_task have pending SIGKILL */
 static inline int signal_group_exit(const struct signal_struct *sig)
 {
 	return	(sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
-		(sig->group_exit_task != NULL);
+		(sig->group_exec_task != NULL);
 }
 
 extern void flush_signals(struct task_struct *);
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

