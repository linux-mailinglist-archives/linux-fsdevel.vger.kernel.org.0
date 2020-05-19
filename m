Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361401D8C72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 02:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgESAiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 20:38:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59706 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgESAiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 20:38:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqGe-0002w7-Jc; Mon, 18 May 2020 18:38:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqGd-0004lP-G5; Mon, 18 May 2020 18:38:00 -0600
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
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 18 May 2020 19:34:19 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87sgfwyd84.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqGd-0004lP-G5;;;mid=<87sgfwyd84.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19NGjIG6pRsk4dc9RIXJzoLeOwe3nHlUBU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 697 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.81
        (0.3%), extract_message_metadata: 20 (2.8%), get_uri_detail_list: 5
        (0.7%), tests_pri_-1000: 16 (2.2%), tests_pri_-950: 1.57 (0.2%),
        tests_pri_-900: 1.30 (0.2%), tests_pri_-90: 80 (11.5%), check_bayes:
        78 (11.2%), b_tokenize: 18 (2.6%), b_tok_get_all: 12 (1.8%),
        b_comp_prob: 3.9 (0.6%), b_tok_touch_all: 40 (5.7%), b_finish: 0.93
        (0.1%), tests_pri_0: 550 (78.9%), check_dkim_signature: 0.77 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.84 (0.1%), tests_pri_10:
        3.0 (0.4%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 8/8] exec: Remove recursion from search_binary_handler
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Recursion in kernel code is generally a bad idea as it can overflow
the kernel stack.  Recursion in exec also hides that the code is
looping and that the loop changes bprm->file.

Instead of recursing in search_binary_handler have the methods that
would recurse set bprm->interpreter and return 0.  Modify exec_binprm
to loop when bprm->interpreter is set.  Consolidate all of the
reassignments of bprm->file in that loop to make it clear what is
going on.

The structure of the new loop in exec_binprm is that all errors return
immediately, while successful completion (ret == 0 &&
!bprm->interpreter) just breaks out of the loop and runs what
exec_bprm has always run upon successful completion.

Fail if the an interpreter is being call after execfd has been set.
The code has never properly handled an interpreter being called with
execfd being set and with reassignments of bprm->file and the
assignment of bprm->executable in generic code it has finally become
possible to test and fail when if this problematic condition happens.

With the reassignments of bprm->file and the assignment of
bprm->executable moved into the generic code add a test to see if
bprm->executable is being reassigned.

In search_binary_handler remove the test for !bprm->file.  With all
reassignments of bprm->file moved to exec_binprm bprm->file can never
be NULL in search_binary_handler.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/binfmt_loader.c |  8 ++---
 fs/binfmt_em86.c                  |  9 ++----
 fs/binfmt_misc.c                  | 18 ++---------
 fs/binfmt_script.c                |  9 ++----
 fs/exec.c                         | 51 ++++++++++++++++++++-----------
 include/linux/binfmts.h           |  3 +-
 6 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/arch/alpha/kernel/binfmt_loader.c b/arch/alpha/kernel/binfmt_loader.c
index d712ba51d15a..e4be7a543ecf 100644
--- a/arch/alpha/kernel/binfmt_loader.c
+++ b/arch/alpha/kernel/binfmt_loader.c
@@ -19,10 +19,6 @@ static int load_binary(struct linux_binprm *bprm)
 	if (bprm->loader)
 		return -ENOEXEC;
 
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
-
 	loader = bprm->vma->vm_end - sizeof(void *);
 
 	file = open_exec("/sbin/loader");
@@ -33,9 +29,9 @@ static int load_binary(struct linux_binprm *bprm)
 	/* Remember if the application is TASO.  */
 	bprm->taso = eh->ah.entry < 0x100000000UL;
 
-	bprm->file = file;
+	bprm->interpreter = file;
 	bprm->loader = loader;
-	return search_binary_handler(bprm);
+	return 0;
 }
 
 static struct linux_binfmt loader_format = {
diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index cedde2341ade..995883693cb2 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -48,10 +48,6 @@ static int load_em86(struct linux_binprm *bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
 		return -ENOENT;
 
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
-
 	/* Unlike in the script case, we don't have to do any hairy
 	 * parsing to find our interpreter... it's hardcoded!
 	 */
@@ -89,9 +85,8 @@ static int load_em86(struct linux_binprm *bprm)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	bprm->file = file;
-
-	return search_binary_handler(bprm);
+	bprm->interpreter = file;
+	return 0;
 }
 
 static struct linux_binfmt em86_format = {
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ad2866f28f0c..53968ea07b57 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -159,18 +159,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 			goto ret;
 	}
 
-	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
-		/* Pass the open binary to the interpreter */
+	if (fmt->flags & MISC_FMT_OPEN_BINARY)
 		bprm->have_execfd = 1;
-		bprm->executable = bprm->file;
 
-		allow_write_access(bprm->file);
-		bprm->file = NULL;
-	} else {
-		allow_write_access(bprm->file);
-		fput(bprm->file);
-		bprm->file = NULL;
-	}
 	/* make argv[1] be the path to the binary */
 	retval = copy_strings_kernel(1, &bprm->interp, bprm);
 	if (retval < 0)
@@ -199,14 +190,11 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (IS_ERR(interp_file))
 		goto ret;
 
-	bprm->file = interp_file;
+	bprm->interpreter = interp_file;
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
 		bprm->preserve_creds = 1;
 
-	retval = search_binary_handler(bprm);
-	if (retval < 0)
-		goto ret;
-
+	retval = 0;
 ret:
 	dput(fmt->dentry);
 	return retval;
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 85e0ef86eb11..0e8b953d12cf 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -93,11 +93,6 @@ static int load_script(struct linux_binprm *bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
 		return -ENOENT;
 
-	/* Release since we are not mapping a binary into memory. */
-	allow_write_access(bprm->file);
-	fput(bprm->file);
-	bprm->file = NULL;
-
 	/*
 	 * OK, we've parsed out the interpreter name and
 	 * (optional) argument.
@@ -138,8 +133,8 @@ static int load_script(struct linux_binprm *bprm)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	bprm->file = file;
-	return search_binary_handler(bprm);
+	bprm->interpreter = file;
+	return 0;
 }
 
 static struct linux_binfmt script_format = {
diff --git a/fs/exec.c b/fs/exec.c
index ca91393893ea..47d831e5efde 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1710,16 +1710,12 @@ EXPORT_SYMBOL(remove_arg_zero);
 /*
  * cycle the list of binary formats handler, until one recognizes the image
  */
-int search_binary_handler(struct linux_binprm *bprm)
+static int search_binary_handler(struct linux_binprm *bprm)
 {
 	bool need_retry = IS_ENABLED(CONFIG_MODULES);
 	struct linux_binfmt *fmt;
 	int retval;
 
-	/* This allows 4 levels of binfmt rewrites before failing hard. */
-	if (bprm->recursion_depth > 5)
-		return -ELOOP;
-
 	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		return retval;
@@ -1736,14 +1732,11 @@ int search_binary_handler(struct linux_binprm *bprm)
 			continue;
 		read_unlock(&binfmt_lock);
 
-		bprm->recursion_depth++;
 		retval = fmt->load_binary(bprm);
-		bprm->recursion_depth--;
 
 		read_lock(&binfmt_lock);
 		put_binfmt(fmt);
-		if (bprm->point_of_no_return || !bprm->file ||
-		    (retval != -ENOEXEC)) {
+		if (bprm->point_of_no_return || (retval != -ENOEXEC)) {
 			read_unlock(&binfmt_lock);
 			return retval;
 		}
@@ -1762,12 +1755,11 @@ int search_binary_handler(struct linux_binprm *bprm)
 
 	return retval;
 }
-EXPORT_SYMBOL(search_binary_handler);
 
 static int exec_binprm(struct linux_binprm *bprm)
 {
 	pid_t old_pid, old_vpid;
-	int ret;
+	int ret, depth;
 
 	/* Need to fetch pid before load_binary changes it */
 	old_pid = current->pid;
@@ -1775,15 +1767,38 @@ static int exec_binprm(struct linux_binprm *bprm)
 	old_vpid = task_pid_nr_ns(current, task_active_pid_ns(current->parent));
 	rcu_read_unlock();
 
-	ret = search_binary_handler(bprm);
-	if (ret >= 0) {
-		audit_bprm(bprm);
-		trace_sched_process_exec(current, old_pid, bprm);
-		ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
-		proc_exec_connector(current);
+	/* This allows 4 levels of binfmt rewrites before failing hard. */
+	for (depth = 0;; depth++) {
+		struct file *exec;
+		if (depth > 5)
+			return -ELOOP;
+
+		ret = search_binary_handler(bprm);
+		if (ret < 0)
+			return ret;
+		if (!bprm->interpreter)
+			break;
+
+		exec = bprm->file;
+		bprm->file = bprm->interpreter;
+		bprm->interpreter = NULL;
+
+		allow_write_access(exec);
+		if (unlikely(bprm->have_execfd)) {
+			if (bprm->executable) {
+				fput(exec);
+				return -ENOEXEC;
+			}
+			bprm->executable = exec;
+		} else
+			fput(exec);
 	}
 
-	return ret;
+	audit_bprm(bprm);
+	trace_sched_process_exec(current, old_pid, bprm);
+	ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
+	proc_exec_connector(current);
+	return 0;
 }
 
 /*
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 653508b25815..7fc05929c967 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -50,8 +50,8 @@ struct linux_binprm {
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-	unsigned int recursion_depth; /* only for search_binary_handler() */
 	struct file * executable; /* Executable to pass to the interpreter */
+	struct file * interpreter;
 	struct file * file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
@@ -117,7 +117,6 @@ static inline void insert_binfmt(struct linux_binfmt *fmt)
 extern void unregister_binfmt(struct linux_binfmt *);
 
 extern int __must_check remove_arg_zero(struct linux_binprm *);
-extern int search_binary_handler(struct linux_binprm *);
 extern int begin_new_exec(struct linux_binprm * bprm);
 extern void setup_new_exec(struct linux_binprm * bprm);
 extern void finalize_exec(struct linux_binprm *bprm);
-- 
2.25.0

