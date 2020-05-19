Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24C1D8C6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 02:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgESAh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 20:37:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37812 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgESAh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 20:37:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqG7-0000am-3z; Mon, 18 May 2020 18:37:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqG5-0004ce-WA; Mon, 18 May 2020 18:37:26 -0600
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
Date:   Mon, 18 May 2020 19:33:46 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqG5-0004ce-WA;;;mid=<87y2poyd91.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hBvVAJEz5VTuL9F3pCoTSZ4Vfzxiz3sQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 638 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.23
        (0.2%), extract_message_metadata: 14 (2.3%), get_uri_detail_list: 4.1
        (0.6%), tests_pri_-1000: 13 (2.1%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 75 (11.7%), check_bayes:
        73 (11.5%), b_tokenize: 16 (2.5%), b_tok_get_all: 12 (1.9%),
        b_comp_prob: 3.3 (0.5%), b_tok_touch_all: 39 (6.0%), b_finish: 0.82
        (0.1%), tests_pri_0: 508 (79.6%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.79 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 7/8] exec: Generic execfd support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Most of the support for passing the file descriptor of an executable
to an interpreter already lives in the generic code and in binfmt_elf.
Rework the fields in binfmt_elf that deal with executable file
descriptor passing to make executable file descriptor passing a first
class concept.

Move the fd_install from binfmt_misc into begin_new_exec after the new
creds have been installed.  This means that accessing the file through
/proc/<pid>/fd/N is able to see the creds for the new executable
before allowing access to the new executables files.

Performing the install of the executables file descriptor after
the point of no return also means that nothing special needs to
be done on error.  The exiting of the process will close all
of it's open files.

Move the would_dump from binfmt_misc into begin_new_exec right
after would_dump is called on the bprm->file.  This makes it
obvious this case exists and that no nesting of bprm->file is
currently supported.

In binfmt_misc the movement of fd_install into generic code means
that it's special error exit path is no longer needed.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_elf.c         |  4 ++--
 fs/binfmt_elf_fdpic.c   |  4 ++--
 fs/binfmt_misc.c        | 40 ++++++++--------------------------------
 fs/exec.c               | 15 +++++++++++++++
 include/linux/binfmts.h | 10 +++++-----
 5 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 396d5c2e6b5e..441c85f04dfd 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -273,8 +273,8 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		NEW_AUX_ENT(AT_BASE_PLATFORM,
 			    (elf_addr_t)(unsigned long)u_base_platform);
 	}
-	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
-		NEW_AUX_ENT(AT_EXECFD, bprm->interp_data);
+	if (bprm->have_execfd) {
+		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
 	}
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 896e3ca9bf85..2d5e9eb12075 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -628,10 +628,10 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 			    (elf_addr_t) (unsigned long) u_base_platform);
 	}
 
-	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
+	if (bprm->have_execfd) {
 		nr = 0;
 		csp -= 2 * sizeof(unsigned long);
-		NEW_AUX_ENT(AT_EXECFD, bprm->interp_data);
+		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
 	}
 
 	nr = 0;
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 50a73afdf9b7..ad2866f28f0c 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -134,7 +134,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	Node *fmt;
 	struct file *interp_file = NULL;
 	int retval;
-	int fd_binary = -1;
 
 	retval = -ENOEXEC;
 	if (!enabled)
@@ -161,29 +160,12 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	}
 
 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
-
-		/* if the binary should be opened on behalf of the
-		 * interpreter than keep it open and assign descriptor
-		 * to it
-		 */
-		fd_binary = get_unused_fd_flags(0);
-		if (fd_binary < 0) {
-			retval = fd_binary;
-			goto ret;
-		}
-		fd_install(fd_binary, bprm->file);
-
-		/* if the binary is not readable than enforce mm->dumpable=0
-		   regardless of the interpreter's permissions */
-		would_dump(bprm, bprm->file);
+		/* Pass the open binary to the interpreter */
+		bprm->have_execfd = 1;
+		bprm->executable = bprm->file;
 
 		allow_write_access(bprm->file);
 		bprm->file = NULL;
-
-		/* mark the bprm that fd should be passed to interp */
-		bprm->interp_flags |= BINPRM_FLAGS_EXECFD;
-		bprm->interp_data = fd_binary;
-
 	} else {
 		allow_write_access(bprm->file);
 		fput(bprm->file);
@@ -192,19 +174,19 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	/* make argv[1] be the path to the binary */
 	retval = copy_strings_kernel(1, &bprm->interp, bprm);
 	if (retval < 0)
-		goto error;
+		goto ret;
 	bprm->argc++;
 
 	/* add the interp as argv[0] */
 	retval = copy_strings_kernel(1, &fmt->interpreter, bprm);
 	if (retval < 0)
-		goto error;
+		goto ret;
 	bprm->argc++;
 
 	/* Update interp in case binfmt_script needs it. */
 	retval = bprm_change_interp(fmt->interpreter, bprm);
 	if (retval < 0)
-		goto error;
+		goto ret;
 
 	if (fmt->flags & MISC_FMT_OPEN_FILE) {
 		interp_file = file_clone_open(fmt->interp_file);
@@ -215,7 +197,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	}
 	retval = PTR_ERR(interp_file);
 	if (IS_ERR(interp_file))
-		goto error;
+		goto ret;
 
 	bprm->file = interp_file;
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
@@ -223,17 +205,11 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	retval = search_binary_handler(bprm);
 	if (retval < 0)
-		goto error;
+		goto ret;
 
 ret:
 	dput(fmt->dentry);
 	return retval;
-error:
-	if (fd_binary > 0)
-		ksys_close(fd_binary);
-	bprm->interp_flags = 0;
-	bprm->interp_data = 0;
-	goto ret;
 }
 
 /* Command parsers */
diff --git a/fs/exec.c b/fs/exec.c
index 5fc458460e44..ca91393893ea 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1323,7 +1323,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	set_mm_exe_file(bprm->mm, bprm->file);
 
+	/* If the binary is not readable than enforce mm->dumpable=0 */
 	would_dump(bprm, bprm->file);
+	if (bprm->have_execfd)
+		would_dump(bprm, bprm->executable);
 
 	/*
 	 * Release all of the old mmap stuff
@@ -1427,6 +1430,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * credentials; any time after this it may be unlocked.
 	 */
 	security_bprm_committed_creds(bprm);
+
+	/* Pass the opened binary to the interpreter. */
+	if (bprm->have_execfd) {
+		retval = get_unused_fd_flags(0);
+		if (retval < 0)
+			goto out_unlock;
+		fd_install(retval, bprm->executable);
+		bprm->executable = NULL;
+		bprm->execfd = retval;
+	}
 	return 0;
 
 out_unlock:
@@ -1516,6 +1529,8 @@ static void free_bprm(struct linux_binprm *bprm)
 		allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
+	if (bprm->executable)
+		fput(bprm->executable);
 	/* If a binfmt changed the interp, free it. */
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8c7779d6bf19..653508b25815 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,6 +26,9 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
+		/* Should an execfd be passed to userspace? */
+		have_execfd:1,
+
 		/* It is safe to use the creds of a script (see binfmt_misc) */
 		preserve_creds:1,
 		/*
@@ -48,6 +51,7 @@ struct linux_binprm {
 	unsigned int taso:1;
 #endif
 	unsigned int recursion_depth; /* only for search_binary_handler() */
+	struct file * executable; /* Executable to pass to the interpreter */
 	struct file * file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
@@ -58,7 +62,7 @@ struct linux_binprm {
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	unsigned interp_flags;
-	unsigned interp_data;
+	int execfd;		/* File descriptor of the executable */
 	unsigned long loader, exec;
 
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
@@ -69,10 +73,6 @@ struct linux_binprm {
 #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
 #define BINPRM_FLAGS_ENFORCE_NONDUMP (1 << BINPRM_FLAGS_ENFORCE_NONDUMP_BIT)
 
-/* fd of the binary should be passed to the interpreter */
-#define BINPRM_FLAGS_EXECFD_BIT 1
-#define BINPRM_FLAGS_EXECFD (1 << BINPRM_FLAGS_EXECFD_BIT)
-
 /* filename of the binary will be inaccessible after exec */
 #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
 #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
-- 
2.25.0

