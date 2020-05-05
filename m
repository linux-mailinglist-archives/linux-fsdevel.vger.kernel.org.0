Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8C1C614C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgEETrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 15:47:07 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42182 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEETrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 15:47:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Ww-0001Ki-9p; Tue, 05 May 2020 13:47:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Wj-00042X-5R; Tue, 05 May 2020 13:47:02 -0600
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
Date:   Tue, 05 May 2020 14:43:25 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87tv0ui2w2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Wj-00042X-5R;;;mid=<87tv0ui2w2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18QSz4DLyeszrOZOaNmZzpSmF0BTSh/cw8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4944]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 595 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.5%), b_tie_ro: 8 (1.3%), parse: 1.03 (0.2%),
        extract_message_metadata: 12 (2.1%), get_uri_detail_list: 3.1 (0.5%),
        tests_pri_-1000: 8 (1.4%), tests_pri_-950: 1.23 (0.2%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 126 (21.2%), check_bayes:
        119 (20.0%), b_tokenize: 14 (2.4%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 3.0 (0.5%), b_tok_touch_all: 89 (14.9%), b_finish: 0.94
        (0.2%), tests_pri_0: 422 (70.9%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/7] exec: Merge install_exec_creds into setup_new_exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The two functions are now always called one right after the
other so merge them together to make future maintenance easier.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/ia32/ia32_aout.c |  1 -
 fs/binfmt_aout.c          |  1 -
 fs/binfmt_elf.c           |  1 -
 fs/binfmt_elf_fdpic.c     |  1 -
 fs/binfmt_flat.c          |  1 -
 fs/exec.c                 | 56 ++++++++++++++++++---------------------
 include/linux/binfmts.h   |  1 -
 kernel/events/core.c      |  2 +-
 8 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index 37b36a8ce5fa..8255fdc3a027 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -140,7 +140,6 @@ static int load_aout_binary(struct linux_binprm *bprm)
 	set_personality_ia32(false);
 
 	setup_new_exec(bprm);
-	install_exec_creds(bprm);
 
 	regs->cs = __USER32_CS;
 	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index ace587b66904..c8ba28f285e5 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -162,7 +162,6 @@ static int load_aout_binary(struct linux_binprm * bprm)
 	set_personality(PER_LINUX);
 #endif
 	setup_new_exec(bprm);
-	install_exec_creds(bprm);
 
 	current->mm->end_code = ex.a_text +
 		(current->mm->start_code = N_TXTADDR(ex));
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..e6b586623035 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -858,7 +858,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
-	install_exec_creds(bprm);
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 6c94c6d53d97..9a1aa61b4cc3 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -353,7 +353,6 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 		current->personality |= READ_IMPLIES_EXEC;
 
 	setup_new_exec(bprm);
-	install_exec_creds(bprm);
 
 	set_binfmt(&elf_fdpic_format);
 
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 1a1d1fcb893f..252878969582 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -541,7 +541,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 		/* OK, This is the point of no return */
 		set_personality(PER_LINUX_32BIT);
 		setup_new_exec(bprm);
-		install_exec_creds(bprm);
 	}
 
 	/*
diff --git a/fs/exec.c b/fs/exec.c
index 71de9f57ae09..93e40f865523 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1443,6 +1443,31 @@ void setup_new_exec(struct linux_binprm * bprm)
 	   group */
 	WRITE_ONCE(current->self_exec_id, current->self_exec_id + 1);
 	flush_signal_handlers(current, 0);
+
+	/*
+	 * install the new credentials for this executable
+	 */
+	security_bprm_committing_creds(bprm);
+
+	commit_creds(bprm->cred);
+	bprm->cred = NULL;
+
+	/*
+	 * Disable monitoring for regular users
+	 * when executing setuid binaries. Must
+	 * wait until new credentials are committed
+	 * by commit_creds() above
+	 */
+	if (get_dumpable(current->mm) != SUID_DUMP_USER)
+		perf_event_exit_task(current);
+	/*
+	 * cred_guard_mutex must be held at least to this point to prevent
+	 * ptrace_attach() from altering our determination of the task's
+	 * credentials; any time after this it may be unlocked.
+	 */
+	security_bprm_committed_creds(bprm);
+	mutex_unlock(&current->signal->exec_update_mutex);
+	mutex_unlock(&current->signal->cred_guard_mutex);
 }
 EXPORT_SYMBOL(setup_new_exec);
 
@@ -1458,7 +1483,7 @@ EXPORT_SYMBOL(finalize_exec);
 
 /*
  * Prepare credentials and lock ->cred_guard_mutex.
- * install_exec_creds() commits the new creds and drops the lock.
+ * setup_new_exec() commits the new creds and drops the lock.
  * Or, if exec fails before, free_bprm() should release ->cred and
  * and unlock.
  */
@@ -1504,35 +1529,6 @@ int bprm_change_interp(const char *interp, struct linux_binprm *bprm)
 }
 EXPORT_SYMBOL(bprm_change_interp);
 
-/*
- * install the new credentials for this executable
- */
-void install_exec_creds(struct linux_binprm *bprm)
-{
-	security_bprm_committing_creds(bprm);
-
-	commit_creds(bprm->cred);
-	bprm->cred = NULL;
-
-	/*
-	 * Disable monitoring for regular users
-	 * when executing setuid binaries. Must
-	 * wait until new credentials are committed
-	 * by commit_creds() above
-	 */
-	if (get_dumpable(current->mm) != SUID_DUMP_USER)
-		perf_event_exit_task(current);
-	/*
-	 * cred_guard_mutex must be held at least to this point to prevent
-	 * ptrace_attach() from altering our determination of the task's
-	 * credentials; any time after this it may be unlocked.
-	 */
-	security_bprm_committed_creds(bprm);
-	mutex_unlock(&current->signal->exec_update_mutex);
-	mutex_unlock(&current->signal->cred_guard_mutex);
-}
-EXPORT_SYMBOL(install_exec_creds);
-
 /*
  * determine how safe it is to execute the proposed program
  * - the caller must hold ->cred_guard_mutex to protect against
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8f479dad7931..2a8fddf3574a 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -145,7 +145,6 @@ extern int transfer_args_to_stack(struct linux_binprm *bprm,
 extern int bprm_change_interp(const char *interp, struct linux_binprm *bprm);
 extern int copy_strings_kernel(int argc, const char *const *argv,
 			       struct linux_binprm *bprm);
-extern void install_exec_creds(struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 633b4ae72ed5..169449b5e56b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12217,7 +12217,7 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
  * When a child task exits, feed back event values to parent events.
  *
  * Can be called with exec_update_mutex held when called from
- * install_exec_creds().
+ * setup_new_exec().
  */
 void perf_event_exit_task(struct task_struct *child)
 {
-- 
2.20.1

