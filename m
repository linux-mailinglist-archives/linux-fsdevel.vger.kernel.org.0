Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED2A21F2A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgGNNdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:33:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37604 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgGNNdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:33:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3h-0006vp-3b; Tue, 14 Jul 2020 07:33:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3f-0005XQ-Pc; Tue, 14 Jul 2020 07:33:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
Date:   Tue, 14 Jul 2020 08:30:30 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <878sfm6x6x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL3f-0005XQ-Pc;;;mid=<878sfm6x6x.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+OY/NvhT3MYjHsTJQkDJtTncWPgQJQ95w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 922 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.1%), b_tie_ro: 9 (0.9%), parse: 1.81 (0.2%),
         extract_message_metadata: 19 (2.0%), get_uri_detail_list: 3.7 (0.4%),
        tests_pri_-1000: 24 (2.6%), tests_pri_-950: 2.5 (0.3%),
        tests_pri_-900: 2.2 (0.2%), tests_pri_-90: 184 (20.0%), check_bayes:
        181 (19.7%), b_tokenize: 22 (2.4%), b_tok_get_all: 19 (2.0%),
        b_comp_prob: 4.3 (0.5%), b_tok_touch_all: 131 (14.2%), b_finish: 1.48
        (0.2%), tests_pri_0: 663 (71.8%), check_dkim_signature: 0.78 (0.1%),
        check_dkim_adsp: 2.9 (0.3%), poll_dns_idle: 1.05 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 8 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/7] exec: Factor bprm_execve out of do_execve_common
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Currently it is necessary for the usermode helper code and the code
that launches init to use set_fs so that pages coming from the kernel
look like they are coming from userspace.

To allow that usage of set_fs to be removed cleanly the argument
copying from userspace needs to happen earlier.  Factor bprm_execve
out of do_execve_common to separate out the copying of arguments
to the newe stack, and the rest of exec.

In separating bprm_execve from do_execve_common the copying
of the arguments onto the new stack happens earlier.

As the copying of the arguments does not depend any security hooks,
files, the file table, current->in_execve, current->fs->in_exec,
bprm->unsafe, or creds this is safe.

Likewise the security hook security_creds_for_exec does not depend upon
preventing the argument copying from happening.

In addition to making it possible to implement kernel_execve that
performs the copying differently, this separation of bprm_execve from
do_execve_common makes for a nice separation of responsibilities making
the exec code easier to navigate.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 108 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index afb168bf5e23..50508892fa71 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1856,44 +1856,16 @@ static int exec_binprm(struct linux_binprm *bprm)
 /*
  * sys_execve() executes a new program.
  */
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
+static int bprm_execve(struct linux_binprm *bprm,
+		       int fd, struct filename *filename, int flags)
 {
-	struct linux_binprm *bprm;
 	struct file *file;
 	struct files_struct *displaced;
 	int retval;
 
-	if (IS_ERR(filename))
-		return PTR_ERR(filename);
-
-	/*
-	 * We move the actual failure in case of RLIMIT_NPROC excess from
-	 * set*uid() to execve() because too many poorly written programs
-	 * don't check setuid() return code.  Here we additionally recheck
-	 * whether NPROC limit is still exceeded.
-	 */
-	if ((current->flags & PF_NPROC_EXCEEDED) &&
-	    atomic_read(&current_user()->processes) > rlimit(RLIMIT_NPROC)) {
-		retval = -EAGAIN;
-		goto out_ret;
-	}
-
-	/* We're below the limit (still or again), so we don't want to make
-	 * further execve() calls fail. */
-	current->flags &= ~PF_NPROC_EXCEEDED;
-
-	bprm = alloc_bprm(fd, filename);
-	if (IS_ERR(bprm)) {
-		retval = PTR_ERR(bprm);
-		goto out_ret;
-	}
-
 	retval = unshare_files(&displaced);
 	if (retval)
-		goto out_free;
+		return retval;
 
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
@@ -1919,28 +1891,11 @@ static int do_execveat_common(int fd, struct filename *filename,
 	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
 		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
 
-	retval = prepare_arg_pages(bprm, argv, envp);
-	if (retval < 0)
-		goto out;
-
 	/* Set the unchanging part of bprm->cred */
 	retval = security_bprm_creds_for_exec(bprm);
 	if (retval)
 		goto out;
 
-	retval = copy_string_kernel(bprm->filename, bprm);
-	if (retval < 0)
-		goto out;
-
-	bprm->exec = bprm->p;
-	retval = copy_strings(bprm->envc, envp, bprm);
-	if (retval < 0)
-		goto out;
-
-	retval = copy_strings(bprm->argc, argv, bprm);
-	if (retval < 0)
-		goto out;
-
 	retval = exec_binprm(bprm);
 	if (retval < 0)
 		goto out;
@@ -1951,8 +1906,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
-	free_bprm(bprm);
-	putname(filename);
 	if (displaced)
 		put_files_struct(displaced);
 	return retval;
@@ -1974,6 +1927,61 @@ static int do_execveat_common(int fd, struct filename *filename,
 out_files:
 	if (displaced)
 		reset_files_struct(displaced);
+
+	return retval;
+}
+
+static int do_execveat_common(int fd, struct filename *filename,
+			      struct user_arg_ptr argv,
+			      struct user_arg_ptr envp,
+			      int flags)
+{
+	struct linux_binprm *bprm;
+	int retval;
+
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
+
+	/*
+	 * We move the actual failure in case of RLIMIT_NPROC excess from
+	 * set*uid() to execve() because too many poorly written programs
+	 * don't check setuid() return code.  Here we additionally recheck
+	 * whether NPROC limit is still exceeded.
+	 */
+	if ((current->flags & PF_NPROC_EXCEEDED) &&
+	    atomic_read(&current_user()->processes) > rlimit(RLIMIT_NPROC)) {
+		retval = -EAGAIN;
+		goto out_ret;
+	}
+
+	/* We're below the limit (still or again), so we don't want to make
+	 * further execve() calls fail. */
+	current->flags &= ~PF_NPROC_EXCEEDED;
+
+	bprm = alloc_bprm(fd, filename);
+	if (IS_ERR(bprm)) {
+		retval = PTR_ERR(bprm);
+		goto out_ret;
+	}
+
+	retval = prepare_arg_pages(bprm, argv, envp);
+	if (retval < 0)
+		goto out_free;
+
+	retval = copy_string_kernel(bprm->filename, bprm);
+	if (retval < 0)
+		goto out_free;
+	bprm->exec = bprm->p;
+
+	retval = copy_strings(bprm->envc, envp, bprm);
+	if (retval < 0)
+		goto out_free;
+
+	retval = copy_strings(bprm->argc, argv, bprm);
+	if (retval < 0)
+		goto out_free;
+
+	retval = bprm_execve(bprm, fd, filename, flags);
 out_free:
 	free_bprm(bprm);
 
-- 
2.25.0

