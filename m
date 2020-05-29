Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A151E8407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgE2Qvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:51:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60806 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:51:25 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeiE7-0002O4-Ci; Fri, 29 May 2020 10:51:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeiE5-0003HU-Nf; Fri, 29 May 2020 10:51:23 -0600
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
        <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 29 May 2020 11:47:29 -0500
In-Reply-To: <87d06mr8ps.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 29 May 2020 11:45:19 -0500")
Message-ID: <871rn2r8m6.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeiE5-0003HU-Nf;;;mid=<871rn2r8m6.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX181wX+NRhhP4m1CiH+i9ON3W6pa6AHjXFY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1128 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (0.8%), b_tie_ro: 7 (0.6%), parse: 1.58 (0.1%),
        extract_message_metadata: 18 (1.6%), get_uri_detail_list: 8 (0.7%),
        tests_pri_-1000: 14 (1.2%), tests_pri_-950: 1.26 (0.1%),
        tests_pri_-900: 1.05 (0.1%), tests_pri_-90: 149 (13.2%), check_bayes:
        147 (13.0%), b_tokenize: 28 (2.5%), b_tok_get_all: 18 (1.6%),
        b_comp_prob: 4.6 (0.4%), b_tok_touch_all: 91 (8.1%), b_finish: 0.90
        (0.1%), tests_pri_0: 916 (81.3%), check_dkim_signature: 0.81 (0.1%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.60 (0.1%), tests_pri_10:
        2.7 (0.2%), tests_pri_500: 12 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/2] exec: Compute file based creds only once
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Move the computation of creds from prepare_binfmt into begin_new_exec
so that the creds need only be computed once.  This is just code
reorganization no semantic changes of any kind are made.

Moving the computation is safe.  I have looked through the kernel and
verified none of the binfmts look at bprm->cred directly, and that
there are no helpers that look at bprm->cred indirectly.  Which means
that it is not a problem to compute the bprm->cred later in the
execution flow as it is not used until it becomes current->cred.

A new function bprm_creds_from_file is added to contain the work that
needs to be done.  bprm_creds_from_file first computes which file
bprm->executable or most likely bprm->file that the bprm->creds
will be computed from.

The funciton bprm_fill_uid is updated to receive the file instead of
accessing bprm->file.  The now unnecessary work needed to reset the
bprm->cred->euid, and bprm->cred->egid is removed from brpm_fill_uid.
A small comment to document that bprm_fill_uid now only deals with the
work to handle suid and sgid files.  The default case is already
heandled by prepare_exec_creds.

The function security_bprm_repopulate_creds is renamed
security_bprm_creds_from_file and now is explicitly passed the file
from which to compute the creds.  The documentation of the
bprm_creds_from_file security hook is updated to explain when the hook
is called and what it needs to do.  The file is passed from
cap_bprm_creds_from_file into get_file_caps so that the caps are
computed for the appropriate file.  The now unnecessary work in
cap_bprm_creds_from_file to reset the ambient capabilites has been
removed.  A small comment to document that the work of
cap_bprm_creds_from_file is to read capabilities from the files
secureity attribute and derive capabilities from the fact the
user had uid 0 has been added.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_misc.c              |  2 +-
 fs/exec.c                     | 63 +++++++++++++++--------------------
 include/linux/binfmts.h       | 14 ++------
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/lsm_hooks.h     | 22 ++++++------
 include/linux/security.h      |  9 ++---
 security/commoncap.c          | 24 +++++++------
 security/security.c           |  4 +--
 8 files changed, 61 insertions(+), 79 deletions(-)

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
index 0f793536e393..e8599236290d 100644
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
@@ -1354,7 +1361,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
-	bprm->per_clear |= bprm->pf_per_clear;
 	me->personality &= ~bprm->per_clear;
 
 	/*
@@ -1365,13 +1371,6 @@ int begin_new_exec(struct linux_binprm * bprm)
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
@@ -1587,29 +1586,21 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	spin_unlock(&p->fs->lock);
 }
 
-static void bprm_fill_uid(struct linux_binprm *bprm)
+static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
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
-	if (!mnt_may_suid(bprm->file->f_path.mnt))
+	if (!mnt_may_suid(file->f_path.mnt))
 		return;
 
 	if (task_no_new_privs(current))
 		return;
 
-	inode = bprm->file->f_path.dentry->d_inode;
+	inode = file->f_path.dentry->d_inode;
 	mode = READ_ONCE(inode->i_mode);
 	if (!(mode & (S_ISUID|S_ISGID)))
 		return;
@@ -1629,19 +1620,31 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		return;
 
 	if (mode & S_ISUID) {
-		bprm->pf_per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->euid = uid;
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
-		bprm->pf_per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear |= PER_CLEAR_ON_SETID;
 		bprm->cred->egid = gid;
 	}
 }
 
+/*
+ * Compute brpm->cred based upon the final binary.
+ */
+static int bprm_creds_from_file(struct linux_binprm *bprm)
+{
+	/* Compute creds based on which file? */
+	struct file *file = bprm->execfd_creds ? bprm->executable : bprm->file;
+
+	bprm_fill_uid(bprm, file);
+	return security_bprm_creds_from_file(bprm, file);
+}
+
 /*
  * Fill the binprm structure from the inode.
- * Check permissions, then read the first BINPRM_BUF_SIZE bytes
+ * Read the first BINPRM_BUF_SIZE bytes
  *
  * This may be called multiple times for binary chains (scripts for example).
  */
@@ -1649,20 +1652,6 @@ static int prepare_binprm(struct linux_binprm *bprm)
 {
 	loff_t pos = 0;
 
-	/* Can the interpreter get to the executable without races? */
-	if (!bprm->preserve_creds) {
-		int retval;
-
-		/* Recompute parts of bprm->cred based on bprm->file */
-		bprm->active_secureexec = 0;
-		bprm->pf_per_clear = 0;
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
index 50025ead0b72..aece1b340e7d 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -29,13 +29,8 @@ struct linux_binprm {
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
@@ -55,11 +50,6 @@ struct linux_binprm {
 	struct file * file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
-	/*
-	 * bits to clear in current->personality
-	 * recalculated for each bprm->file.
-	 */
-	unsigned int pf_per_clear;
 	unsigned int per_clear;	/* bits to clear in current->personality */
 	int argc, envc;
 	const char * filename;	/* Name of binary as seen by procps */
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 1e295ba12c0d..adbc6603abba 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -50,7 +50,7 @@ LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
 LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
-LSM_HOOK(int, 0, bprm_repopulate_creds, struct linux_binprm *bprm)
+LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index cd3dd0afceb5..37bb3df751c6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -44,18 +44,18 @@
  *	request libc enable secure mode.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
- * @bprm_repopulate_creds:
- *	Assuming that the relevant bits of @bprm->cred->security have been
- *	previously set, examine @bprm->file and regenerate them.  This is
- *	so that the credentials derived from the interpreter the code is
- *	actually going to run are used rather than credentials derived
- *	from a script.  This done because the interpreter binary needs to
- *	reopen script, and may end up opening something completely different.
- *	This hook may also optionally check permissions (e.g. for
- *	transitions between security domains).
- *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
+ * @bprm_creds_from_file:
+ *	If @file is setpcap, suid, sgid or otherwise marked to change
+ *	privilege upon exec, update @bprm->cred to reflect that change.
+ *	This is called after finding the binary that will be executed.
+ *	without an interpreter.  This ensures that the credentials will not
+ *	be derived from a script that the binary will need to reopen, which
+ *	when reopend may end up being a completely different file.  This
+ *	hook may also optionally check permissions (e.g. for transitions
+ *	between security domains).
+ *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
  *	request libc enable secure mode.
- *	The hook must set @bprm->pf_per_clear to the personality flags that
+ *	The hook must set @bprm->per_clear to the personality flags that
  *	should be cleared from current->personality.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
diff --git a/include/linux/security.h b/include/linux/security.h
index 6dcec9375e8f..8444fae7c5b9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -140,7 +140,7 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
 		      const kernel_cap_t *permitted);
-extern int cap_bprm_repopulate_creds(struct linux_binprm *bprm);
+extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
 extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
@@ -277,7 +277,7 @@ int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
-int security_bprm_repopulate_creds(struct linux_binprm *bprm);
+int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
@@ -575,9 +575,10 @@ static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return 0;
 }
 
-static inline int security_bprm_repopulate_creds(struct linux_binprm *bprm)
+static inline int security_bprm_creds_from_file(struct linux_binprm *bprm,
+						struct file *file)
 {
-	return cap_bprm_repopulate_creds(bprm);
+	return cap_bprm_creds_from_file(bprm, file);
 }
 
 static inline int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/commoncap.c b/security/commoncap.c
index 6de72d22dc6c..59bf3c1674c8 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -647,7 +647,8 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
  * its xattrs and, if present, apply them to the proposed credentials being
  * constructed by execve().
  */
-static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_fcap)
+static int get_file_caps(struct linux_binprm *bprm, struct file *file,
+			 bool *effective, bool *has_fcap)
 {
 	int rc = 0;
 	struct cpu_vfs_cap_data vcaps;
@@ -657,7 +658,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
 	if (!file_caps_enabled)
 		return 0;
 
-	if (!mnt_may_suid(bprm->file->f_path.mnt))
+	if (!mnt_may_suid(file->f_path.mnt))
 		return 0;
 
 	/*
@@ -665,10 +666,10 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
 	 * explicit that capability bits are limited to s_user_ns and its
 	 * descendants.
 	 */
-	if (!current_in_userns(bprm->file->f_path.mnt->mnt_sb->s_user_ns))
+	if (!current_in_userns(file->f_path.mnt->mnt_sb->s_user_ns))
 		return 0;
 
-	rc = get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
+	rc = get_vfs_caps_from_disk(file->f_path.dentry, &vcaps);
 	if (rc < 0) {
 		if (rc == -EINVAL)
 			printk(KERN_NOTICE "Invalid argument reading file caps for %s\n",
@@ -797,26 +798,27 @@ static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old,
 }
 
 /**
- * cap_bprm_repopulate_creds - Set up the proposed credentials for execve().
+ * cap_bprm_creds_from_file - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
+ * @file: The file to pull the credentials from
  *
  * Set up the proposed credentials for a new execution context being
  * constructed by execve().  The proposed creds in @bprm->cred is altered,
  * which won't take effect immediately.  Returns 0 if successful, -ve on error.
  */
-int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
+int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
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
 
-	ret = get_file_caps(bprm, &effective, &has_fcap);
+	ret = get_file_caps(bprm, file, &effective, &has_fcap);
 	if (ret < 0)
 		return ret;
 
@@ -826,7 +828,7 @@ int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 
 	/* if we have fs caps, clear dangerous personality flags */
 	if (__cap_gained(permitted, new, old))
-		bprm->pf_per_clear |= PER_CLEAR_ON_SETID;
+		bprm->per_clear |= PER_CLEAR_ON_SETID;
 
 	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
 	 * credentials unless they have the appropriate permit.
@@ -889,7 +891,7 @@ int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 	    (!__is_real(root_uid, new) &&
 	     (effective ||
 	      __cap_grew(permitted, ambient, new))))
-		bprm->active_secureexec = 1;
+		bprm->secureexec = 1;
 
 	return 0;
 }
@@ -1346,7 +1348,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, cap_ptrace_traceme),
 	LSM_HOOK_INIT(capget, cap_capget),
 	LSM_HOOK_INIT(capset, cap_capset),
-	LSM_HOOK_INIT(bprm_repopulate_creds, cap_bprm_repopulate_creds),
+	LSM_HOOK_INIT(bprm_creds_from_file, cap_bprm_creds_from_file),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
diff --git a/security/security.c b/security/security.c
index b890b7e2a765..259b8e750aa2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -828,9 +828,9 @@ int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return call_int_hook(bprm_creds_for_exec, 0, bprm);
 }
 
-int security_bprm_repopulate_creds(struct linux_binprm *bprm)
+int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
 {
-	return call_int_hook(bprm_repopulate_creds, 0, bprm);
+	return call_int_hook(bprm_creds_from_file, 0, bprm, file);
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
-- 
2.25.0

