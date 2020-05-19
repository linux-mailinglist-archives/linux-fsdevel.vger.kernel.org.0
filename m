Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5B1D8C51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 02:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgESAdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 20:33:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37174 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgESAdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 20:33:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqCe-0000Pe-A9; Mon, 18 May 2020 18:33:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqCc-0004K8-Ny; Mon, 18 May 2020 18:33:52 -0600
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
Date:   Mon, 18 May 2020 19:30:10 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87v9kszrzh.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqCc-0004K8-Ny;;;mid=<87v9kszrzh.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ecPFCymisO0mdQ0r9+TKZOTSbzdPHvMY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TooManySym_01,XMGappySubj_01,
        XMGappySubj_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.0 XMGappySubj_02 Gappier still
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1152 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (1.0%), b_tie_ro: 10 (0.9%), parse: 2.1 (0.2%),
         extract_message_metadata: 22 (1.9%), get_uri_detail_list: 9 (0.8%),
        tests_pri_-1000: 14 (1.2%), tests_pri_-950: 1.41 (0.1%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 141 (12.3%), check_bayes:
        139 (12.1%), b_tokenize: 29 (2.5%), b_tok_get_all: 17 (1.4%),
        b_comp_prob: 6 (0.5%), b_tok_touch_all: 83 (7.2%), b_finish: 0.95
        (0.1%), tests_pri_0: 941 (81.7%), check_dkim_signature: 0.88 (0.1%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.59 (0.1%), tests_pri_10:
        3.2 (0.3%), tests_pri_500: 9 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 2/8] exec: Factor security_bprm_creds_for_exec out of security_bprm_set_creds
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Today security_bprm_set_creds has several implementations:
apparmor_bprm_set_creds, cap_bprm_set_creds, selinux_bprm_set_creds,
smack_bprm_set_creds, and tomoyo_bprm_set_creds.

Except for cap_bprm_set_creds they all test bprm->called_set_creds and
return immediately if it is true.  The function cap_bprm_set_creds
ignores bprm->calld_sed_creds entirely.

Create a new LSM hook security_bprm_creds_for_exec that is called just
before prepare_binprm in __do_execve_file, resulting in a LSM hook
that is called exactly once for the entire of exec.  Modify the bits
of security_bprm_set_creds that only want to be called once per exec
into security_bprm_creds_for_exec, leaving only cap_bprm_set_creds
behind.

Remove bprm->called_set_creds all of it's former users have been moved
to security_bprm_creds_for_exec.

Add or upate comments a appropriate to bring them up to date and
to reflect this change.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                          |  6 +++-
 include/linux/binfmts.h            | 18 +++--------
 include/linux/lsm_hook_defs.h      |  1 +
 include/linux/lsm_hooks.h          | 50 +++++++++++++++++-------------
 include/linux/security.h           |  6 ++++
 security/apparmor/domain.c         |  7 ++---
 security/apparmor/include/domain.h |  2 +-
 security/apparmor/lsm.c            |  2 +-
 security/security.c                |  5 +++
 security/selinux/hooks.c           |  8 ++---
 security/smack/smack_lsm.c         |  9 ++----
 security/tomoyo/tomoyo.c           | 12 ++-----
 12 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 14b786158aa9..9e70da47f8d9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1640,7 +1640,6 @@ int prepare_binprm(struct linux_binprm *bprm)
 	retval = security_bprm_set_creds(bprm);
 	if (retval)
 		return retval;
-	bprm->called_set_creds = 1;
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
@@ -1855,6 +1854,11 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval < 0)
 		goto out;
 
+	/* Set the unchanging part of bprm->cred */
+	retval = security_bprm_creds_for_exec(bprm);
+	if (retval)
+		goto out;
+
 	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		goto out;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 1b48e2154766..d1217fcdedea 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -27,22 +27,14 @@ struct linux_binprm {
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
 		/*
-		 * True after the bprm_set_creds hook has been called once
-		 * (multiple calls can be made via prepare_binprm() for
-		 * binfmt_script/misc).
-		 */
-		called_set_creds:1,
-		/*
-		 * True if most recent call to the commoncaps bprm_set_creds
-		 * hook (due to multiple prepare_binprm() calls from the
-		 * binfmt_script/misc handlers) resulted in elevated
-		 * privileges.
+		 * True if most recent call to cap_bprm_set_creds
+		 * resulted in elevated privileges.
 		 */
 		cap_elevated:1,
 		/*
-		 * Set by bprm_set_creds hook to indicate a privilege-gaining
-		 * exec has happened. Used to sanitize execution environment
-		 * and to set AT_SECURE auxv for glibc.
+		 * Set by bprm_creds_for_exec hook to indicate a
+		 * privilege-gaining exec has happened. Used to set
+		 * AT_SECURE auxv for glibc.
 		 */
 		secureexec:1,
 		/*
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..aab0695f41df 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -49,6 +49,7 @@ LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
 LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_set_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 988ca0df7824..c719af37df20 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -34,40 +34,46 @@
  *
  * Security hooks for program execution operations.
  *
+ * @bprm_creds_for_exec:
+ *	If the setup in prepare_exec_creds did not setup @bprm->cred->security
+ *	properly for executing @bprm->file, update the LSM's portion of
+ *	@bprm->cred->security to be what commit_creds needs to install for the
+ *	new program.  This hook may also optionally check permissions
+ *	(e.g. for transitions between security domains).
+ *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
+ *	request libc enable secure mode.
+ *	@bprm contains the linux_binprm structure.
+ *	Return 0 if the hook is successful and permission is granted.
  * @bprm_set_creds:
- *	Save security information in the bprm->security field, typically based
- *	on information about the bprm->file, for later use by the apply_creds
- *	hook.  This hook may also optionally check permissions (e.g. for
+ *	Assuming that the relevant bits of @bprm->cred->security have been
+ *	previously set, examine @bprm->file and regenerate them.  This is
+ *	so that the credentials derived from the interpreter the code is
+ *	actually going to run are used rather than credentials derived
+ *	from a script.  This done because the interpreter binary needs to
+ *	reopen script, and may end up opening something completely different.
+ *	This hook may also optionally check permissions (e.g. for
  *	transitions between security domains).
- *	This hook may be called multiple times during a single execve, e.g. for
- *	interpreters.  The hook can tell whether it has already been called by
- *	checking to see if @bprm->security is non-NULL.  If so, then the hook
- *	may decide either to retain the security information saved earlier or
- *	to replace it.  The hook must set @bprm->secureexec to 1 if a "secure
- *	exec" has happened as a result of this hook call.  The flag is used to
- *	indicate the need for a sanitized execution environment, and is also
- *	passed in the ELF auxiliary table on the initial stack to indicate
- *	whether libc should enable secure mode.
+ *	The hook must set @bprm->cap_elevated to 1 if AT_SECURE should be set to
+ *	request libc enable secure mode.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_check_security:
  *	This hook mediates the point when a search for a binary handler will
- *	begin.  It allows a check the @bprm->security value which is set in the
- *	preceding set_creds call.  The primary difference from set_creds is
- *	that the argv list and envp list are reliably available in @bprm.  This
- *	hook may be called multiple times during a single execve; and in each
- *	pass set_creds is called first.
+ *	begin.  It allows a check against the @bprm->cred->security value
+ *	which was set in the preceding creds_for_exec call.  The argv list and
+ *	envp list are reliably available in @bprm.  This hook may be called
+ *	multiple times during a single execve.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_committing_creds:
  *	Prepare to install the new security attributes of a process being
  *	transformed by an execve operation, based on the old credentials
  *	pointed to by @current->cred and the information set in @bprm->cred by
- *	the bprm_set_creds hook.  @bprm points to the linux_binprm structure.
- *	This hook is a good place to perform state changes on the process such
- *	as closing open file descriptors to which access will no longer be
- *	granted when the attributes are changed.  This is called immediately
- *	before commit_creds().
+ *	the bprm_creds_for_exec hook.  @bprm points to the linux_binprm
+ *	structure.  This hook is a good place to perform state changes on the
+ *	process such as closing open file descriptors to which access will no
+ *	longer be granted when the attributes are changed.  This is called
+ *	immediately before commit_creds().
  * @bprm_committed_creds:
  *	Tidy up after the installation of the new security attributes of a
  *	process being transformed by an execve operation.  The new credentials
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d9310472df..1bd7a6582775 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -276,6 +276,7 @@ int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
+int security_bprm_creds_for_exec(struct linux_binprm *bprm);
 int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
@@ -569,6 +570,11 @@ static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
 }
 
+static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	return 0;
+}
+
 static inline int security_bprm_set_creds(struct linux_binprm *bprm)
 {
 	return cap_bprm_set_creds(bprm);
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 6ceb74e0f789..0b870a647488 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -854,14 +854,14 @@ static struct aa_label *handle_onexec(struct aa_label *label,
 }
 
 /**
- * apparmor_bprm_set_creds - set the new creds on the bprm struct
+ * apparmor_bprm_creds_for_exec - Update the new creds on the bprm struct
  * @bprm: binprm for the exec  (NOT NULL)
  *
  * Returns: %0 or error on failure
  *
  * TODO: once the other paths are done see if we can't refactor into a fn
  */
-int apparmor_bprm_set_creds(struct linux_binprm *bprm)
+int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
 	struct aa_task_ctx *ctx;
 	struct aa_label *label, *new = NULL;
@@ -875,9 +875,6 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		file_inode(bprm->file)->i_mode
 	};
 
-	if (bprm->called_set_creds)
-		return 0;
-
 	ctx = task_ctx(current);
 	AA_BUG(!cred_label(bprm->cred));
 	AA_BUG(!ctx);
diff --git a/security/apparmor/include/domain.h b/security/apparmor/include/domain.h
index 21b875fe2d37..d14928fe1c6f 100644
--- a/security/apparmor/include/domain.h
+++ b/security/apparmor/include/domain.h
@@ -30,7 +30,7 @@ struct aa_domain {
 struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
 				const char **name);
 
-int apparmor_bprm_set_creds(struct linux_binprm *bprm);
+int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm);
 
 void aa_free_domain_entries(struct aa_domain *domain);
 int aa_change_hat(const char *hats[], int count, u64 token, int flags);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b621ad74f54a..3623ab08279d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1232,7 +1232,7 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, apparmor_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, apparmor_cred_transfer),
 
-	LSM_HOOK_INIT(bprm_set_creds, apparmor_bprm_set_creds),
+	LSM_HOOK_INIT(bprm_creds_for_exec, apparmor_bprm_creds_for_exec),
 	LSM_HOOK_INIT(bprm_committing_creds, apparmor_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, apparmor_bprm_committed_creds),
 
diff --git a/security/security.c b/security/security.c
index 7fed24b9d57e..4ee76a729f73 100644
--- a/security/security.c
+++ b/security/security.c
@@ -823,6 +823,11 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
+int security_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	return call_int_hook(bprm_creds_for_exec, 0, bprm);
+}
+
 int security_bprm_set_creds(struct linux_binprm *bprm)
 {
 	return call_int_hook(bprm_set_creds, 0, bprm);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b77..718345dd76bb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2286,7 +2286,7 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 	return -EACCES;
 }
 
-static int selinux_bprm_set_creds(struct linux_binprm *bprm)
+static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
 	const struct task_security_struct *old_tsec;
 	struct task_security_struct *new_tsec;
@@ -2297,8 +2297,6 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
-	if (bprm->called_set_creds)
-		return 0;
 
 	old_tsec = selinux_cred(current_cred());
 	new_tsec = selinux_cred(bprm->cred);
@@ -6385,7 +6383,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/* Permission checking based on the specified context is
 	   performed during the actual operation (execve,
 	   open/mkdir/...), when we know the full context of the
-	   operation.  See selinux_bprm_set_creds for the execve
+	   operation.  See selinux_bprm_creds_for_exec for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
 	tsec = selinux_cred(new);
@@ -6914,7 +6912,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(netlink_send, selinux_netlink_send),
 
-	LSM_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
+	LSM_HOOK_INIT(bprm_creds_for_exec, selinux_bprm_creds_for_exec),
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8c61d175e195..0ac8f4518d07 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -891,12 +891,12 @@ static int smack_sb_statfs(struct dentry *dentry)
  */
 
 /**
- * smack_bprm_set_creds - set creds for exec
+ * smack_bprm_creds_for_exec - Update bprm->cred if needed for exec
  * @bprm: the exec information
  *
  * Returns 0 if it gets a blob, -EPERM if exec forbidden and -ENOMEM otherwise
  */
-static int smack_bprm_set_creds(struct linux_binprm *bprm)
+static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
 	struct inode *inode = file_inode(bprm->file);
 	struct task_smack *bsp = smack_cred(bprm->cred);
@@ -904,9 +904,6 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	struct superblock_smack *sbsp;
 	int rc;
 
-	if (bprm->called_set_creds)
-		return 0;
-
 	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
@@ -4598,7 +4595,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
 	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
 
-	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
+	LSM_HOOK_INIT(bprm_creds_for_exec, smack_bprm_creds_for_exec),
 
 	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
 	LSM_HOOK_INIT(inode_init_security, smack_inode_init_security),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92ec941a..f9adddc42ac8 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -63,20 +63,14 @@ static void tomoyo_bprm_committed_creds(struct linux_binprm *bprm)
 
 #ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
 /**
- * tomoyo_bprm_set_creds - Target for security_bprm_set_creds().
+ * tomoyo_bprm_for_exec - Target for security_bprm_creds_for_exec().
  *
  * @bprm: Pointer to "struct linux_binprm".
  *
  * Returns 0.
  */
-static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
+static int tomoyo_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
-	/*
-	 * Do only if this function is called for the first time of an execve
-	 * operation.
-	 */
-	if (bprm->called_set_creds)
-		return 0;
 	/*
 	 * Load policy if /sbin/tomoyo-init exists and /sbin/init is requested
 	 * for the first time.
@@ -539,7 +533,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
 	LSM_HOOK_INIT(task_free, tomoyo_task_free),
 #ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
-	LSM_HOOK_INIT(bprm_set_creds, tomoyo_bprm_set_creds),
+	LSM_HOOK_INIT(bprm_creds_for_exec, tomoyo_bprm_creds_for_exec),
 #endif
 	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
 	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
-- 
2.25.0

