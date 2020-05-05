Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB331C615A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgEETt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 15:49:27 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60734 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgEETt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 15:49:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3ZF-0008Qf-Po; Tue, 05 May 2020 13:49:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3ZE-0008Fx-VN; Tue, 05 May 2020 13:49:25 -0600
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
Date:   Tue, 05 May 2020 14:46:01 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87a72mi2rq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3ZE-0008Fx-VN;;;mid=<87a72mi2rq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/fMSRrm2CRmfcXc6TpoAntNKrf175ivK8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 453 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (0.9%), b_tie_ro: 2.6 (0.6%), parse: 0.76
        (0.2%), extract_message_metadata: 10 (2.1%), get_uri_detail_list: 1.92
        (0.4%), tests_pri_-1000: 11 (2.3%), tests_pri_-950: 1.10 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 63 (14.0%), check_bayes:
        62 (13.7%), b_tokenize: 9 (1.9%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 1.64 (0.4%), b_tok_touch_all: 43 (9.6%), b_finish: 0.58
        (0.1%), tests_pri_0: 352 (77.7%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.80 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 7/7] exec: Rename flush_old_exec begin_new_exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


There is and has been for a very long time been a lot more going on in
flush_old_exec than just flushing the old state.  After the movement
of code from setup_new_exec there is a whole lot more going on than
just flushing the old executables state.

Rename flush_old_exec to begin_new_exec to more accurately reflect
what this function does.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Documentation/trace/ftrace.rst | 2 +-
 arch/x86/ia32/ia32_aout.c      | 2 +-
 fs/binfmt_aout.c               | 2 +-
 fs/binfmt_elf.c                | 2 +-
 fs/binfmt_elf_fdpic.c          | 2 +-
 fs/binfmt_flat.c               | 2 +-
 fs/exec.c                      | 4 ++--
 include/linux/binfmts.h        | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 3b5614b1d1a5..430a16283103 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1524,7 +1524,7 @@ display-graph option::
    => remove_vma
    => exit_mmap
    => mmput
-   => flush_old_exec
+   => begin_new_exec
    => load_elf_binary
    => search_binary_handler
    => __do_execve_file.isra.32
diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index 8255fdc3a027..385d3d172ee1 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -131,7 +131,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
 		return -ENOMEM;
 
 	/* Flush all traces of the currently running executable */
-	retval = flush_old_exec(bprm);
+	retval = begin_new_exec(bprm);
 	if (retval)
 		return retval;
 
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index c8ba28f285e5..3e84e9bb9084 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -151,7 +151,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 		return -ENOMEM;
 
 	/* Flush all traces of the currently running executable */
-	retval = flush_old_exec(bprm);
+	retval = begin_new_exec(bprm);
 	if (retval)
 		return retval;
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e6b586623035..396d5c2e6b5e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -844,7 +844,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_dentry;
 
 	/* Flush all traces of the currently running executable */
-	retval = flush_old_exec(bprm);
+	retval = begin_new_exec(bprm);
 	if (retval)
 		goto out_free_dentry;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 9a1aa61b4cc3..896e3ca9bf85 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -338,7 +338,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 		interp_params.flags |= ELF_FDPIC_FLAG_CONSTDISP;
 
 	/* flush all traces of the currently running executable */
-	retval = flush_old_exec(bprm);
+	retval = begin_new_exec(bprm);
 	if (retval)
 		goto error;
 
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 252878969582..9b82bc111d0a 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -534,7 +534,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 	/* Flush all traces of the currently running executable */
 	if (id == 0) {
-		ret = flush_old_exec(bprm);
+		ret = begin_new_exec(bprm);
 		if (ret)
 			goto err;
 
diff --git a/fs/exec.c b/fs/exec.c
index 0eff20558735..3cc40048cc65 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1298,7 +1298,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
  * signal (via de_thread() or coredump), or will have SEGV raised
  * (after exec_mmap()) by search_binary_handlers (see below).
  */
-int flush_old_exec(struct linux_binprm * bprm)
+int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
 	int retval;
@@ -1433,7 +1433,7 @@ int flush_old_exec(struct linux_binprm * bprm)
 out:
 	return retval;
 }
-EXPORT_SYMBOL(flush_old_exec);
+EXPORT_SYMBOL(begin_new_exec);
 
 void would_dump(struct linux_binprm *bprm, struct file *file)
 {
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 2a8fddf3574a..1b48e2154766 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -125,7 +125,7 @@ extern void unregister_binfmt(struct linux_binfmt *);
 extern int prepare_binprm(struct linux_binprm *);
 extern int __must_check remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *);
-extern int flush_old_exec(struct linux_binprm * bprm);
+extern int begin_new_exec(struct linux_binprm * bprm);
 extern void setup_new_exec(struct linux_binprm * bprm);
 extern void finalize_exec(struct linux_binprm *bprm);
 extern void would_dump(struct linux_binprm *, struct file *);
-- 
2.20.1

