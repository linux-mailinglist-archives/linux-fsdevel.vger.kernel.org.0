Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F631C6153
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgEETry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 15:47:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42784 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgEETrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 15:47:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Xk-0001UF-HF; Tue, 05 May 2020 13:47:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Xj-0007vt-LV; Tue, 05 May 2020 13:47:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
Date:   Tue, 05 May 2020 14:44:28 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87o8r2i2ub.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Xj-0007vt-LV;;;mid=<87o8r2i2ub.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+MM8noAZIW3+gtzC3/VW1oflU0z+e62Ns=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
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
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 470 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.9%), b_tie_ro: 8 (1.7%), parse: 1.33 (0.3%),
        extract_message_metadata: 12 (2.5%), get_uri_detail_list: 1.90 (0.4%),
        tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 72 (15.4%), check_bayes:
        71 (15.1%), b_tokenize: 9 (1.8%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.7 (0.6%), b_tok_touch_all: 47 (10.0%), b_finish: 0.99
        (0.2%), tests_pri_0: 342 (72.8%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.77 (0.2%), tests_pri_10:
        3.4 (0.7%), tests_pri_500: 10 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/7] exec: In setup_new_exec cache current in the local variable me
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


At least gcc 8.3 when generating code for x86_64 has a hard time
consolidating multiple calls to current aka get_current(), and winds
up unnecessarily rereading %gs:current_task several times in
setup_new_exec.

Caching the value of current in the local variable of me generates
slightly better and shorter assembly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 93e40f865523..8c3abafb9bb1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1391,6 +1391,7 @@ EXPORT_SYMBOL(would_dump);
 
 void setup_new_exec(struct linux_binprm * bprm)
 {
+	struct task_struct *me = current;
 	/*
 	 * Once here, prepare_binrpm() will not be called any more, so
 	 * the final state of setuid/setgid/fscaps can be merged into the
@@ -1400,7 +1401,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	if (bprm->secureexec) {
 		/* Make sure parent cannot signal privileged process. */
-		current->pdeath_signal = 0;
+		me->pdeath_signal = 0;
 
 		/*
 		 * For secureexec, reset the stack limit to sane default to
@@ -1413,9 +1414,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 			bprm->rlim_stack.rlim_cur = _STK_LIM;
 	}
 
-	arch_pick_mmap_layout(current->mm, &bprm->rlim_stack);
+	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
 
-	current->sas_ss_sp = current->sas_ss_size = 0;
+	me->sas_ss_sp = me->sas_ss_size = 0;
 
 	/*
 	 * Figure out dumpability. Note that this checking only of current
@@ -1431,18 +1432,18 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	arch_setup_new_exec();
 	perf_event_exec();
-	__set_task_comm(current, kbasename(bprm->filename), true);
+	__set_task_comm(me, kbasename(bprm->filename), true);
 
 	/* Set the new mm task size. We have to do that late because it may
 	 * depend on TIF_32BIT which is only updated in flush_thread() on
 	 * some architectures like powerpc
 	 */
-	current->mm->task_size = TASK_SIZE;
+	me->mm->task_size = TASK_SIZE;
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
-	WRITE_ONCE(current->self_exec_id, current->self_exec_id + 1);
-	flush_signal_handlers(current, 0);
+	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
+	flush_signal_handlers(me, 0);
 
 	/*
 	 * install the new credentials for this executable
@@ -1458,16 +1459,16 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 * wait until new credentials are committed
 	 * by commit_creds() above
 	 */
-	if (get_dumpable(current->mm) != SUID_DUMP_USER)
-		perf_event_exit_task(current);
+	if (get_dumpable(me->mm) != SUID_DUMP_USER)
+		perf_event_exit_task(me);
 	/*
 	 * cred_guard_mutex must be held at least to this point to prevent
 	 * ptrace_attach() from altering our determination of the task's
 	 * credentials; any time after this it may be unlocked.
 	 */
 	security_bprm_committed_creds(bprm);
-	mutex_unlock(&current->signal->exec_update_mutex);
-	mutex_unlock(&current->signal->cred_guard_mutex);
+	mutex_unlock(&me->signal->exec_update_mutex);
+	mutex_unlock(&me->signal->cred_guard_mutex);
 }
 EXPORT_SYMBOL(setup_new_exec);
 
-- 
2.20.1

