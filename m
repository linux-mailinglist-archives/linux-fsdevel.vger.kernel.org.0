Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B064139800
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 23:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfFGVng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 17:43:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53807 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfFGVng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:43:36 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMe6-0008BU-It; Fri, 07 Jun 2019 15:43:34 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMe5-00007T-Gx; Fri, 07 Jun 2019 15:43:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        <linux-arch@vger.kernel.org>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
Date:   Fri, 07 Jun 2019 16:43:21 -0500
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 07 Jun 2019 16:39:54 -0500")
Message-ID: <87wohx9ime.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZMe5-00007T-Gx;;;mid=<87wohx9ime.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18P0VJzgd3V/iTMGLHkzGDAaMXjRN+/OPE=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 503 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.0 (0.8%), b_tie_ro: 2.6 (0.5%), parse: 1.57
        (0.3%), extract_message_metadata: 19 (3.7%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 19 (3.8%), tests_pri_-950: 1.75 (0.3%),
        tests_pri_-900: 1.45 (0.3%), tests_pri_-90: 40 (8.0%), check_bayes: 36
        (7.2%), b_tokenize: 13 (2.5%), b_tok_get_all: 9 (1.7%), b_comp_prob:
        3.0 (0.6%), b_tok_touch_all: 4.1 (0.8%), b_finish: 0.72 (0.1%),
        tests_pri_0: 391 (77.8%), check_dkim_signature: 0.98 (0.2%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        4.2 (0.8%), tests_pri_500: 16 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC PATCH 4/5] signal: Remove saved_sigmask
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


We have real_sigmask that serves the same purpose and is always kept
uptodate.  Remove a field from the task structure and a conditional
from the signal delivery code by removing this field.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched.h        |  2 --
 include/linux/sched/signal.h |  9 +++------
 kernel/ptrace.c              | 12 ++----------
 kernel/signal.c              |  2 --
 4 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..520efbd355be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -864,8 +864,6 @@ struct task_struct {
 	struct sighand_struct		*sighand;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
-	/* Restored if set_restore_sigmask() was used: */
-	sigset_t			saved_sigmask;
 	struct sigpending		pending;
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 97f6a6a35a81..78678de45278 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -407,7 +407,7 @@ void task_join_group_stop(struct task_struct *task);
  */
 
 /**
- * set_restore_sigmask() - make sure saved_sigmask processing gets done
+ * set_restore_sigmask() - make sure real_sigmask processing gets done
  *
  * This sets TIF_RESTORE_SIGMASK and ensures that the arch signal code
  * will run before returning to user mode, to process the flag.  For
@@ -479,7 +479,7 @@ static inline bool test_and_clear_restore_sigmask(void)
 static inline void restore_saved_sigmask(void)
 {
 	if (test_and_clear_restore_sigmask())
-		__set_current_blocked(&current->saved_sigmask);
+		__set_current_blocked(&current->real_blocked);
 }
 
 extern int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize);
@@ -494,10 +494,7 @@ static inline void restore_saved_sigmask_unless(bool interrupted)
 
 static inline sigset_t *sigmask_to_save(void)
 {
-	sigset_t *res = &current->blocked;
-	if (unlikely(test_restore_sigmask()))
-		res = &current->saved_sigmask;
-	return res;
+	return &current->real_blocked;
 }
 
 static inline int kill_cad_pid(int sig, int priv)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6507d700d70f..5ed6126e1cc5 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -925,26 +925,18 @@ int ptrace_request(struct task_struct *child, long request,
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 
-	case PTRACE_GETSIGMASK: {
-		sigset_t *mask;
-
+	case PTRACE_GETSIGMASK:
 		if (addr != sizeof(sigset_t)) {
 			ret = -EINVAL;
 			break;
 		}
 
-		if (test_tsk_restore_sigmask(child))
-			mask = &child->saved_sigmask;
-		else
-			mask = &child->blocked;
-
-		if (copy_to_user(datavp, mask, sizeof(sigset_t)))
+		if (copy_to_user(datavp, &child->real_blocked, sizeof(sigset_t)))
 			ret = -EFAULT;
 		else
 			ret = 0;
 
 		break;
-	}
 
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
diff --git a/kernel/signal.c b/kernel/signal.c
index fcd84f4a93c9..c37d4f209699 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2941,8 +2941,6 @@ EXPORT_SYMBOL(sigprocmask);
 static int set_sigmask(sigset_t *newset)
 {
 	set_restore_sigmask();
-	current->saved_sigmask = current->blocked;
-
 	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	__set_current_blocked(newset);
 
-- 
2.21.0.dirty

