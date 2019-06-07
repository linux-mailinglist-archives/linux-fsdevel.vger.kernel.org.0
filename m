Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0433B397FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 23:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfFGVmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 17:42:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35017 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfFGVmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:42:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMdP-00052p-9m; Fri, 07 Jun 2019 15:42:51 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMdN-0008Ta-Vo; Fri, 07 Jun 2019 15:42:51 -0600
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
Date:   Fri, 07 Jun 2019 16:42:38 -0500
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 07 Jun 2019 16:39:54 -0500")
Message-ID: <8736klax81.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZMdN-0008Ta-Vo;;;mid=<8736klax81.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196inFbSGEV5ZM/UKXy2JalQH0m48f/YkU=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
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
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 477 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.8%), b_tie_ro: 2.7 (0.6%), parse: 1.42
        (0.3%), extract_message_metadata: 17 (3.6%), get_uri_detail_list: 3.2
        (0.7%), tests_pri_-1000: 17 (3.6%), tests_pri_-950: 1.69 (0.4%),
        tests_pri_-900: 1.35 (0.3%), tests_pri_-90: 31 (6.5%), check_bayes: 29
        (6.1%), b_tokenize: 12 (2.5%), b_tok_get_all: 8 (1.7%), b_comp_prob:
        2.7 (0.6%), b_tok_touch_all: 3.9 (0.8%), b_finish: 0.70 (0.1%),
        tests_pri_0: 386 (81.0%), check_dkim_signature: 0.77 (0.2%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.88 (0.2%), tests_pri_10:
        4.1 (0.9%), tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC PATCH 3/5] signal: Always keep real_blocked in sync with blocked
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Except where we temporarily override blocked always keep real_blocked
in sync with blocked.

By always setting real_blocked when we set blocked this allows
some slight efficiency and simplifications, by not having
to save blocked.

This also preparse the code for the removal of saved_sigmask.  That
should result in a massive simplification.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c     |  1 +
 kernel/signal.c     | 14 ++++++++++----
 virt/kvm/kvm_main.c |  8 --------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..6507d700d70f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -968,6 +968,7 @@ int ptrace_request(struct task_struct *child, long request,
 		 */
 		spin_lock_irq(&child->sighand->siglock);
 		child->blocked = new_set;
+		child->real_blocked = new_set;
 		spin_unlock_irq(&child->sighand->siglock);
 
 		clear_tsk_restore_sigmask(child);
diff --git a/kernel/signal.c b/kernel/signal.c
index bfa36320a4f7..fcd84f4a93c9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2878,6 +2878,9 @@ void set_current_blocked(sigset_t *newset)
 {
 	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	__set_current_blocked(newset);
+
+	/* Lockless, only current can change ->real_blocked, never from irq */
+	current->real_blocked = *newset;
 }
 
 void __set_current_blocked(const sigset_t *newset)
@@ -2928,15 +2931,20 @@ int sigprocmask(int how, sigset_t *set, sigset_t *oldset)
 	}
 
 	__set_current_blocked(&newset);
+
+	/* Lockless, only current can change ->real_blocked, never from irq */
+	tsk->real_blocked = newset;
 	return 0;
 }
 EXPORT_SYMBOL(sigprocmask);
 
-static int set_sigmask(sigset_t *kmask)
+static int set_sigmask(sigset_t *newset)
 {
 	set_restore_sigmask();
 	current->saved_sigmask = current->blocked;
-	set_current_blocked(kmask);
+
+	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
+	__set_current_blocked(newset);
 
 	return 0;
 }
@@ -3440,7 +3448,6 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 		 * they arrive. Unblocking is always fine, we can avoid
 		 * set_current_blocked().
 		 */
-		tsk->real_blocked = tsk->blocked;
 		sigandsets(&tsk->blocked, &tsk->blocked, &mask);
 		recalc_sigpending();
 		spin_unlock_irq(&tsk->sighand->siglock);
@@ -3450,7 +3457,6 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 							 HRTIMER_MODE_REL);
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
-		sigemptyset(&tsk->real_blocked);
 		sig = dequeue_signal(tsk, &mask, info);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8575a1010bfc..4bfed018574a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2234,13 +2234,6 @@ void kvm_sigset_activate(struct kvm_vcpu *vcpu)
 	if (!vcpu->sigset_active)
 		return;
 
-	/*
-	 * This does a lockless modification of ->real_blocked, which is fine
-	 * because, only current can change ->real_blocked and all readers of
-	 * ->real_blocked don't care as long ->real_blocked is always a subset
-	 * of ->blocked.
-	 */
-	current->real_blocked = current->blocked;
 	__set_current_blocked(&vcpu->sigset);
 }
 
@@ -2250,7 +2243,6 @@ void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
 		return;
 
 	__set_current_blocked(&current->real_blocked);
-	sigemptyset(&current->real_blocked);
 }
 
 static void grow_halt_poll_ns(struct kvm_vcpu *vcpu)
-- 
2.21.0.dirty

