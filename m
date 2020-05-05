Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F181C6157
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 21:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgEETtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 15:49:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60594 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgEETtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 15:49:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Yn-0008OI-Ha; Tue, 05 May 2020 13:48:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Ym-0008CU-IP; Tue, 05 May 2020 13:48:57 -0600
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
Date:   Tue, 05 May 2020 14:45:33 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87ftcei2si.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Ym-0008CU-IP;;;mid=<87ftcei2si.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0vxq8buPMPNgPKrDcyd7EIeeeXCYCozY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 561 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 9 (1.7%), b_tie_ro: 8 (1.4%), parse: 1.69 (0.3%),
        extract_message_metadata: 18 (3.3%), get_uri_detail_list: 3.4 (0.6%),
        tests_pri_-1000: 17 (3.0%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 126 (22.5%), check_bayes:
        124 (22.2%), b_tokenize: 9 (1.7%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 102 (18.2%), b_finish: 0.91
        (0.2%), tests_pri_0: 372 (66.3%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The current idiom for the callers is:

flush_old_exec(bprm);
set_personality(...);
setup_new_exec(bprm);

In 2010 Linus split flush_old_exec into flush_old_exec and
setup_new_exec.  With the intention that setup_new_exec be what is
called after the processes new personality is set.

Move the code that doesn't depend upon the personality from
setup_new_exec into flush_old_exec.  This is to facilitate future
changes by having as much code together in one function as possible.

Ref: 221af7f87b97 ("Split 'flush_old_exec' into two functions")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 85 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8c3abafb9bb1..0eff20558735 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1359,39 +1359,7 @@ int flush_old_exec(struct linux_binprm * bprm)
 	 * undergoing exec(2).
 	 */
 	do_close_on_exec(me->files);
-	return 0;
-
-out_unlock:
-	mutex_unlock(&me->signal->exec_update_mutex);
-out:
-	return retval;
-}
-EXPORT_SYMBOL(flush_old_exec);
-
-void would_dump(struct linux_binprm *bprm, struct file *file)
-{
-	struct inode *inode = file_inode(file);
-	if (inode_permission(inode, MAY_READ) < 0) {
-		struct user_namespace *old, *user_ns;
-		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
-
-		/* Ensure mm->user_ns contains the executable */
-		user_ns = old = bprm->mm->user_ns;
-		while ((user_ns != &init_user_ns) &&
-		       !privileged_wrt_inode_uidgid(user_ns, inode))
-			user_ns = user_ns->parent;
 
-		if (old != user_ns) {
-			bprm->mm->user_ns = get_user_ns(user_ns);
-			put_user_ns(old);
-		}
-	}
-}
-EXPORT_SYMBOL(would_dump);
-
-void setup_new_exec(struct linux_binprm * bprm)
-{
-	struct task_struct *me = current;
 	/*
 	 * Once here, prepare_binrpm() will not be called any more, so
 	 * the final state of setuid/setgid/fscaps can be merged into the
@@ -1414,8 +1382,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 			bprm->rlim_stack.rlim_cur = _STK_LIM;
 	}
 
-	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
-
 	me->sas_ss_sp = me->sas_ss_size = 0;
 
 	/*
@@ -1430,16 +1396,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	else
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
-	arch_setup_new_exec();
 	perf_event_exec();
 	__set_task_comm(me, kbasename(bprm->filename), true);
 
-	/* Set the new mm task size. We have to do that late because it may
-	 * depend on TIF_32BIT which is only updated in flush_thread() on
-	 * some architectures like powerpc
-	 */
-	me->mm->task_size = TASK_SIZE;
-
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
 	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
@@ -1467,6 +1426,50 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 * credentials; any time after this it may be unlocked.
 	 */
 	security_bprm_committed_creds(bprm);
+	return 0;
+
+out_unlock:
+	mutex_unlock(&me->signal->exec_update_mutex);
+out:
+	return retval;
+}
+EXPORT_SYMBOL(flush_old_exec);
+
+void would_dump(struct linux_binprm *bprm, struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	if (inode_permission(inode, MAY_READ) < 0) {
+		struct user_namespace *old, *user_ns;
+		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
+
+		/* Ensure mm->user_ns contains the executable */
+		user_ns = old = bprm->mm->user_ns;
+		while ((user_ns != &init_user_ns) &&
+		       !privileged_wrt_inode_uidgid(user_ns, inode))
+			user_ns = user_ns->parent;
+
+		if (old != user_ns) {
+			bprm->mm->user_ns = get_user_ns(user_ns);
+			put_user_ns(old);
+		}
+	}
+}
+EXPORT_SYMBOL(would_dump);
+
+void setup_new_exec(struct linux_binprm * bprm)
+{
+	/* Setup things that can depend upon the personality */
+	struct task_struct *me = current;
+
+	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
+
+	arch_setup_new_exec();
+
+	/* Set the new mm task size. We have to do that late because it may
+	 * depend on TIF_32BIT which is only updated in flush_thread() on
+	 * some architectures like powerpc
+	 */
+	me->mm->task_size = TASK_SIZE;
 	mutex_unlock(&me->signal->exec_update_mutex);
 	mutex_unlock(&me->signal->cred_guard_mutex);
 }
-- 
2.20.1

