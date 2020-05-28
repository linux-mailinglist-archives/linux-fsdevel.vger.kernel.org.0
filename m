Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F249C1E6699
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbgE1Pqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:46:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47282 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgE1Pqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:46:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKjp-0003d4-LB; Thu, 28 May 2020 09:46:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKjo-0006wE-5f; Thu, 28 May 2020 09:46:33 -0600
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
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 28 May 2020 10:42:40 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87367kysjz.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKjo-0006wE-5f;;;mid=<87367kysjz.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19In91xGLctcIhWOZF7QnMbxz9oDXYbZF8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1008 ms - load_scoreonly_sql: 0.50 (0.1%),
        signal_user_changed: 15 (1.5%), b_tie_ro: 12 (1.2%), parse: 2.6 (0.3%),
         extract_message_metadata: 30 (3.0%), get_uri_detail_list: 12 (1.2%),
        tests_pri_-1000: 19 (1.9%), tests_pri_-950: 1.72 (0.2%),
        tests_pri_-900: 1.41 (0.1%), tests_pri_-90: 127 (12.6%), check_bayes:
        124 (12.3%), b_tokenize: 30 (3.0%), b_tok_get_all: 17 (1.7%),
        b_comp_prob: 5 (0.5%), b_tok_touch_all: 68 (6.7%), b_finish: 1.17
        (0.1%), tests_pri_0: 790 (78.3%), check_dkim_signature: 1.01 (0.1%),
        check_dkim_adsp: 3.1 (0.3%), poll_dns_idle: 0.86 (0.1%), tests_pri_10:
        4.4 (0.4%), tests_pri_500: 10 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/11] exec: Compute file based creds only once
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Move the computation of creds from prepare_binfmt into begin_new_exec
so that the creds can be computed only onc.

I have looked through the kernel and verified none of the binfmts
look at bprm->cred directly so computing the bprm->cred later
should be safe.

Rename preserve_creds to execfd_creds to make it clear that the creds
should be derived from the executable file descriptor.

Remove active_secureexec and active_per_clear and use secureexec and
per_clear respectively.  The active versions of these variables were
only necessary to allow their values to be recomputed from scratch
for each value of bprm->file.

Remove the now unnecessary work from bprm_fill_uid to reset the
bprm->cred->euid and bprm->cred->egid, and add a small comment
about what bprm_fill_uid now does.

Remove the now unnecessary work in cap_bprm_creds_from_file to
reset the ambient capabilities, and add a small comment
about what cap_bprm_creds_from_file does.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_misc.c              |  2 +-
 fs/exec.c                     | 65 +++++++++++++++++------------------
 include/linux/binfmts.h       | 12 ++-----
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/lsm_hooks.h     | 19 +++++-----
 include/linux/security.h      |  8 ++---
 security/commoncap.c          | 12 +++----
 security/security.c           |  4 +--
 8 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 53968ea07b57..bc5506619b7e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -192,7 +192,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	bprm->interpreter = interp_file;
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
-		bprm->preserve_creds = 1;
+		bprm->execfd_creds = 1;
 
 	retval = 0;
 ret:
diff --git a/fs/exec.c b/fs/exec.c
index 221d12dcaa3e..091ff6269610 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -72,6 +72,8 @@
 
 #include <trace/events/sched.h>
 
+static int bprm_creds_from_file(struct linux_binprm *bprm);
+
 int suid_dumpable = 0;
 
 static LIST_HEAD(formats);
@@ -1304,6 +1306,11 @@ int begin_new_exec(struct linux_binprm * bprm)
 	struct task_struct *me = current;
 	int retval;
 
+	/* Once we are committed compute the creds */
+	retval = bprm_creds_from_file(bprm);
+	if (retval)
+		return retval;
+
 	/*
 	 * Ensure all future errors are fatal.
 	 */
@@ -1354,7 +1361,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
-	if (bprm->per_clear || bprm->active_per_clear)
+	if (bprm->per_clear)
 		me->personality &= ~PER_CLEAR_ON_SETID;
 
 	/*
@@ -1365,13 +1372,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	do_close_on_exec(me->files);
 
-	/*
-	 * Once here, prepare_binrpm() will not be called any more, so
-	 * the final state of setuid/setgid/fscaps can be merged into the
-	 * secureexec flag.
-	 */
-	bprm->secureexec |= bprm->active_secureexec;
-
 	if (bprm->secureexec) {
 		/* Make sure parent cannot signal privileged process. */
 		me->pdeath_signal = 0;
@@ -1589,20 +1589,12 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 
 static void bprm_fill_uid(struct linux_binprm *bprm)
 {
+	/* Handle suid and sgid on files */
 	struct inode *inode;
 	unsigned int mode;
 	kuid_t uid;
 	kgid_t gid;
 
-	/*
-	 * Since this can be called multiple times (via prepare_binprm),
-	 * we must clear any previous work done when setting set[ug]id
-	 * bits from any earlier bprm->file uses (for example when run
-	 * first for a setuid script then again for its interpreter).
-	 */
-	bprm->cred->euid = current_euid();
-	bprm->cred->egid = current_egid();
-
 	if (!mnt_may_suid(bprm->file->f_path.mnt))
 		return;
 
@@ -1629,19 +1621,38 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		return;
 
 	if (mode & S_ISUID) {
-		bprm->active_per_clear = 1;
+		bprm->per_clear = 1;
 		bprm->cred->euid = uid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
-		bprm->active_per_clear = 1;
+		bprm->per_clear = 1;
 		bprm->cred->egid = gid;
 	}
 }
 
+/*
+ * Compute brpm->cred based upon the final binary.
+ */
+static int bprm_creds_from_file(struct linux_binprm *bprm)
+{
+	struct file *file = bprm->file;
+	int retval;
+
+	/* Compute creds from the executable passed to userspace? */
+	if (bprm->execfd_creds)
+		bprm->file = bprm->executable;
+
+	bprm_fill_uid(bprm);
+	retval = security_bprm_creds_from_file(bprm);
+	bprm->file = file;
+
+	return retval;
+}
+
 /*
  * Fill the binprm structure from the inode.
- * Check permissions, then read the first BINPRM_BUF_SIZE bytes
+ * Read the first BINPRM_BUF_SIZE bytes
  *
  * This may be called multiple times for binary chains (scripts for example).
  */
@@ -1649,20 +1660,6 @@ static int prepare_binprm(struct linux_binprm *bprm)
 {
 	loff_t pos = 0;
 
-	/* Can the interpreter get to the executable without races? */
-	if (!bprm->preserve_creds) {
-		int retval;
-
-		/* Recompute parts of bprm->cred based on bprm->file */
-		bprm->active_secureexec = 0;
-		bprm->active_per_clear = 0;
-		bprm_fill_uid(bprm);
-		retval = security_bprm_repopulate_creds(bprm);
-		if (retval)
-			return retval;
-	}
-	bprm->preserve_creds = 0;
-
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
 }
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 89231a689957..39f6b5a7ace7 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,22 +26,14 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
-		/* Does bprm->file warrant clearing personality bits? */
-		active_per_clear:1,
-
 		/* Should unsafe personality bits be cleared? */
 		per_clear:1,
 
 		/* Should an execfd be passed to userspace? */
 		have_execfd:1,
 
-		/* It is safe to use the creds of a script (see binfmt_misc) */
-		preserve_creds:1,
-		/*
-		 * True if most recent call to security_bprm_set_creds
-		 * resulted in elevated privileges.
-		 */
-		active_secureexec:1,
+		/* Use the creds of a script (see binfmt_misc) */
+		execfd_creds:1,
 		/*
 		 * Set by bprm_creds_for_exec hook to indicate a
 		 * privilege-gaining exec has happened. Used to set
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 1e295ba12c0d..36b07c1eb0f1 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -50,7 +50,7 @@ LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
 LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
-LSM_HOOK(int, 0, bprm_repopulate_creds, struct linux_binprm *bprm)
+LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 62e60e55cb99..0aeaa3de69b2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -46,18 +46,19 @@
  *	bits must be cleared from current->personality.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
- * @bprm_repopulate_creds:
- *	Assuming that the relevant bits of @bprm->cred->security have been
- *	previously set, examine @bprm->file and regenerate them.  This is
- *	so that the credentials derived from the interpreter the code is
- *	actually going to run are used rather than credentials derived
- *	from a script.  This done because the interpreter binary needs to
- *	reopen script, and may end up opening something completely different.
+ * @bprm_creds_from_file:
+ *	If @bprm->file is setpcap, suid, sgid or otherwise marked to
+ *	change the privilege level upon exec update @bprm->cred to
+ *	handle the marking on the file.  This is called after finding
+ *	the native code binary that will be executed.  This ensures that
+ *	the credentials will not be derived from a script that the binary
+ *	will need to reopen, which when reopend may end up being a completely
+ *	different file.
  *	This hook may also optionally check permissions (e.g. for
  *	transitions between security domains).
- *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
+ *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
  *	request libc enable secure mode.
- *	The hook must set @bprm->active_per_clear to 1 if the dangerous personality
+ *	The hook must set @bprm->per_clear to 1 if the dangerous personality
  *	bits must be cleared from current->personality.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
diff --git a/include/linux/security.h b/include/linux/security.h
index 6dcec9375e8f..df8ad2fb7374 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -140,7 +140,7 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
 		      const kernel_cap_t *permitted);
-extern int cap_bprm_repopulate_creds(struct linux_binprm *bprm);
+extern int cap_bprm_creds_from_file(struct linux_binprm *bprm);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
 extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
@@ -277,7 +277,7 @@ int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
-int security_bprm_repopulate_creds(struct linux_binprm *bprm);
+int security_bprm_creds_from_file(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
@@ -575,9 +575,9 @@ static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return 0;
 }
 
-static inline int security_bprm_repopulate_creds(struct linux_binprm *bprm)
+static inline int security_bprm_creds_from_file(struct linux_binprm *bprm)
 {
-	return cap_bprm_repopulate_creds(bprm);
+	return cap_bprm_creds_from_file(bprm);
 }
 
 static inline int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/commoncap.c b/security/commoncap.c
index 0b72d7bf23e1..2bd1f24f3796 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -797,22 +797,22 @@ static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old,
 }
 
 /**
- * cap_bprm_repopulate_creds - Set up the proposed credentials for execve().
+ * cap_bprm_creds_from_file - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
  *
  * Set up the proposed credentials for a new execution context being
  * constructed by execve().  The proposed creds in @bprm->cred is altered,
  * which won't take effect immediately.  Returns 0 if successful, -ve on error.
  */
-int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
+int cap_bprm_creds_from_file(struct linux_binprm *bprm)
 {
+	/* Process setpcap binaries and capabilities for uid 0 */
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
 	bool effective = false, has_fcap = false, is_setid;
 	int ret;
 	kuid_t root_uid;
 
-	new->cap_ambient = old->cap_ambient;
 	if (WARN_ON(!cap_ambient_invariant_ok(old)))
 		return -EPERM;
 
@@ -826,7 +826,7 @@ int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 
 	/* if we have fs caps, clear dangerous personality flags */
 	if (__cap_gained(permitted, new, old))
-		bprm->active_per_clear = 1;
+		bprm->per_clear = 1;
 
 	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
 	 * credentials unless they have the appropriate permit.
@@ -889,7 +889,7 @@ int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 	    (!__is_real(root_uid, new) &&
 	     (effective ||
 	      __cap_grew(permitted, ambient, new))))
-		bprm->active_secureexec = 1;
+		bprm->secureexec = 1;
 
 	return 0;
 }
@@ -1346,7 +1346,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, cap_ptrace_traceme),
 	LSM_HOOK_INIT(capget, cap_capget),
 	LSM_HOOK_INIT(capset, cap_capset),
-	LSM_HOOK_INIT(bprm_repopulate_creds, cap_bprm_repopulate_creds),
+	LSM_HOOK_INIT(bprm_creds_from_file, cap_bprm_creds_from_file),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
diff --git a/security/security.c b/security/security.c
index b890b7e2a765..0688359bf8f4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -828,9 +828,9 @@ int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return call_int_hook(bprm_creds_for_exec, 0, bprm);
 }
 
-int security_bprm_repopulate_creds(struct linux_binprm *bprm)
+int security_bprm_creds_from_file(struct linux_binprm *bprm)
 {
-	return call_int_hook(bprm_repopulate_creds, 0, bprm);
+	return call_int_hook(bprm_creds_from_file, 0, bprm);
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
-- 
2.25.0

