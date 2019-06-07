Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57189397F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 23:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfFGVli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 17:41:38 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52888 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfFGVli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:41:38 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMcC-0007xv-9c; Fri, 07 Jun 2019 15:41:36 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMcB-0008Kv-FQ; Fri, 07 Jun 2019 15:41:36 -0600
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
Date:   Fri, 07 Jun 2019 16:41:23 -0500
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 07 Jun 2019 16:39:54 -0500")
Message-ID: <87ef45axa4.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZMcB-0008Kv-FQ;;;mid=<87ef45axa4.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+1o+mLqXT5oq9Xv8ZmJiMeax+zJW/VDo8=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 473 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.6%), b_tie_ro: 2.1 (0.4%), parse: 0.93
        (0.2%), extract_message_metadata: 11 (2.4%), get_uri_detail_list: 1.71
        (0.4%), tests_pri_-1000: 13 (2.7%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 26 (5.4%), check_bayes: 24
        (5.1%), b_tokenize: 9 (1.9%), b_tok_get_all: 7 (1.6%), b_comp_prob:
        2.1 (0.4%), b_tok_touch_all: 3.5 (0.7%), b_finish: 0.60 (0.1%),
        tests_pri_0: 405 (85.8%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.85 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The sigsuspend system call overrides the signal mask just
like all of the other users of set_user_sigmask, so convert
it to use the same helpers.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 6f72cff043f0..bfa36320a4f7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2932,6 +2932,15 @@ int sigprocmask(int how, sigset_t *set, sigset_t *oldset)
 }
 EXPORT_SYMBOL(sigprocmask);
 
+static int set_sigmask(sigset_t *kmask)
+{
+	set_restore_sigmask();
+	current->saved_sigmask = current->blocked;
+	set_current_blocked(kmask);
+
+	return 0;
+}
+
 /*
  * The api helps set app-provided sigmasks.
  *
@@ -2952,11 +2961,7 @@ int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize)
 	if (copy_from_user(&kmask, umask, sizeof(sigset_t)))
 		return -EFAULT;
 
-	set_restore_sigmask();
-	current->saved_sigmask = current->blocked;
-	set_current_blocked(&kmask);
-
-	return 0;
+	return set_sigmask(&kmask);
 }
 
 #ifdef CONFIG_COMPAT
@@ -2972,11 +2977,7 @@ int set_compat_user_sigmask(const compat_sigset_t __user *umask,
 	if (get_compat_sigset(&kmask, umask))
 		return -EFAULT;
 
-	set_restore_sigmask();
-	current->saved_sigmask = current->blocked;
-	set_current_blocked(&kmask);
-
-	return 0;
+	return set_sigmask(&kmask);
 }
 #endif
 
@@ -4409,14 +4410,10 @@ SYSCALL_DEFINE0(pause)
 
 static int sigsuspend(sigset_t *set)
 {
-	current->saved_sigmask = current->blocked;
-	set_current_blocked(set);
-
 	while (!signal_pending(current)) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
 	}
-	set_restore_sigmask();
 	return -ERESTARTNOHAND;
 }
 
@@ -4430,12 +4427,10 @@ SYSCALL_DEFINE2(rt_sigsuspend, sigset_t __user *, unewset, size_t, sigsetsize)
 {
 	sigset_t newset;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&newset, unewset, sizeof(newset)))
+	set_user_sigmask(unewset, sigsetsize);
+	if (!unewset)
 		return -EFAULT;
+
 	return sigsuspend(&newset);
 }
  
@@ -4444,12 +4439,10 @@ COMPAT_SYSCALL_DEFINE2(rt_sigsuspend, compat_sigset_t __user *, unewset, compat_
 {
 	sigset_t newset;
 
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (get_compat_sigset(&newset, unewset))
+	set_compat_user_sigmask(unewset, sigsetsize);
+	if (!unewset)
 		return -EFAULT;
+
 	return sigsuspend(&newset);
 }
 #endif
@@ -4459,6 +4452,7 @@ SYSCALL_DEFINE1(sigsuspend, old_sigset_t, mask)
 {
 	sigset_t blocked;
 	siginitset(&blocked, mask);
+	set_sigmask(&blocked);
 	return sigsuspend(&blocked);
 }
 #endif
@@ -4467,6 +4461,7 @@ SYSCALL_DEFINE3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask)
 {
 	sigset_t blocked;
 	siginitset(&blocked, mask);
+	set_sigmask(&blocked);
 	return sigsuspend(&blocked);
 }
 #endif
-- 
2.21.0.dirty

