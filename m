Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E5C247A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 00:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgHQWJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 18:09:39 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60014 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgHQWJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nJu-001qlG-Is; Mon, 17 Aug 2020 16:09:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nJt-0004PB-Fc; Mon, 17 Aug 2020 16:09:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, criu@openvz.org,
        bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 17 Aug 2020 17:04:09 -0500
Message-Id: <20200817220425.9389-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nJt-0004PB-Fc;;;mid=<20200817220425.9389-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/o4kAvkkEgoK7xQWUvEOU/m0JXjAtAz0g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,T_TooManySym_01,
        XMNoVowels,XMSubLong,XM_B_SpammyWords,XM_B_Unicode,XM_B_Unicode3
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 XM_B_Unicode3 BODY: Testing for specific types of unicode
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 647 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.18
        (0.2%), extract_message_metadata: 13 (2.0%), get_uri_detail_list: 4.8
        (0.7%), tests_pri_-1000: 14 (2.1%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.28 (0.2%), tests_pri_-90: 179 (27.7%), check_bayes:
        178 (27.5%), b_tokenize: 15 (2.3%), b_tok_get_all: 16 (2.5%),
        b_comp_prob: 4.4 (0.7%), b_tok_touch_all: 136 (21.0%), b_finish: 1.25
        (0.2%), tests_pri_0: 412 (63.7%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 1.14 (0.2%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 01/17] exec: Move unshare_files to fix posix file locking during exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many moons ago the binfmts were doing some very questionable things
with file descriptors and an unsharing of the file descriptor table
was added to make things better[1][2].  The helper steal_files was
added to avoid breaking the userspace programs[3][4][6].

Unfortunately it turned out that steal_locks did not work for network
file systems[5], so it was removed to see if anyone would
complain[7][8].  It was thought at the time that NPTL would not be
affected as the unshare_files happened after the other threads were
killed[8].  Unfortunately because there was an unshare_files in
binfmt_elf.c before the threads were killed this analysis was
incorrect.

This unshare_files in binfmt_elf.c resulted in the unshares_files
happening whenever threads were present.  Which led to unshare_files
being moved to the start of do_execve[9].

Later the problems were rediscovered and suggested approach was to
readd steal_locks under a different name[10].  I happened to be
reviewing patches and I noticed that this approach was a step
backwards[11].

I proposed simply moving unshare_files[12] and it was pointed
out that moving unshare_files without auditing the code was
also unsafe[13].

There were then several attempts to solve this[14][15][16] and I even
posted this set of changes[17].  Unfortunately because auditing all of
execve is time consuming this change did not make it in at the time.

Well now that I am cleaning up exec I have made the time to read
through all of the binfmts and the only playing with file descriptors
is either the security modules closing them in
security_bprm_committing_creds or is in the generic code in fs/exec.c.
None of it happens before begin_new_exec is called.

So move unshare_files into begin_new_exec, after the point of no
return.  If memory is very very very low and the application calling
exec is sharing file descriptor tables between processes we might fail
past the point of no return.  Which is unfortunate but no different
than any of the other places where we allocate memory after the point
of no return.

This movement allows another process that shares the file table, or
another thread of the same process and that closes files or changes
their close on exec behavior and races with execve to cause some
unexpected things to happen.  There is only one time of check to time
of use race and it is just there so that execve fails instead of
an interpreter failing when it tries to open the file it is supposed
to be interpreting.   Failing later if userspace is being silly is
not a problem.

With this change it the following discription from the removal
of steal_locks[8] finally becomes true.

    Apps using NPTL are not affected, since all other threads are killed before
    execve.

    Apps using LinuxThreads are only affected if they

      - have multiple threads during exec (LinuxThreads doesn't kill other
        threads, the app may do it with pthread_kill_other_threads_np())
      - rely on POSIX locks being inherited across exec

    Both conditions are documented, but not their interaction.

    Apps using clone() natively are affected if they

      - use clone(CLONE_FILES)
      - rely on POSIX locks being inherited across exec

I have investigated some paths to make it possible to solve this
without moving unshare_files but they all look more complicated[18].

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Jeff Layton <jlayton@redhat.com>
History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
[1] 02cda956de0b ("[PATCH] unshare_files"
[2] 04e9bcb4d106 ("[PATCH] use new unshare_files helper")
[3] 088f5d7244de ("[PATCH] add steal_locks helper")
[4] 02c541ec8ffa ("[PATCH] use new steal_locks helper")
[5] https://lkml.kernel.org/r/E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu
[6] https://lkml.kernel.org/r/0060321191605.GB15997@sorel.sous-sol.org
[7] https://lkml.kernel.org/r/E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu
[8] c89681ed7d0e ("[PATCH] remove steal_locks()")
[9] fd8328be874f ("[PATCH] sanitize handling of shared descriptor tables in failing execve()")
[10] https://lkml.kernel.org/r/20180317142520.30520-1-jlayton@kernel.org
[11] https://lkml.kernel.org/r/87r2nwqk73.fsf@xmission.com
[12] https://lkml.kernel.org/r/87bmfgvg8w.fsf@xmission.com
[13] https://lkml.kernel.org/r/20180322111424.GE30522@ZenIV.linux.org.uk
[14] https://lkml.kernel.org/r/20180827174722.3723-1-jlayton@kernel.org
[15] https://lkml.kernel.org/r/20180830172423.21964-1-jlayton@kernel.org
[16] https://lkml.kernel.org/r/20180914105310.6454-1-jlayton@kernel.org
[17] https://lkml.kernel.org/r/87a7ohs5ow.fsf@xmission.com
[18] https://lkml.kernel.org/r/87pn8c1uj6.fsf_-_@x220.int.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..17c007bba712 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1354,6 +1354,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
+	struct files_struct *displaced;
 	int retval;
 
 	/* Once we are committed compute the creds */
@@ -1373,6 +1374,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/* Ensure the files table is not shared. */
+	retval = unshare_files(&displaced);
+	if (retval)
+		goto out;
+	if (displaced)
+		put_files_struct(displaced);
+
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
 	 * not visibile until then. This also enables the update
@@ -1892,16 +1900,11 @@ static int bprm_execve(struct linux_binprm *bprm,
 		       int fd, struct filename *filename, int flags)
 {
 	struct file *file;
-	struct files_struct *displaced;
 	int retval;
 
-	retval = unshare_files(&displaced);
-	if (retval)
-		return retval;
-
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
-		goto out_files;
+		return retval;
 
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
@@ -1916,8 +1919,12 @@ static int bprm_execve(struct linux_binprm *bprm,
 	bprm->file = file;
 	/*
 	 * Record that a name derived from an O_CLOEXEC fd will be
-	 * inaccessible after exec. Relies on having exclusive access to
-	 * current->files (due to unshare_files above).
+	 * inaccessible after exec.  This allows the code in exec to
+	 * choose to fail when the executable is not mmaped into the
+	 * interpreter and an open file descriptor is not passed to
+	 * the interpreter.  This makes for a better user experience
+	 * than having the interpreter start and then immediately fail
+	 * when it finds the executable is inaccessible.
 	 */
 	if (bprm->fdpath &&
 	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
@@ -1938,8 +1945,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
-	if (displaced)
-		put_files_struct(displaced);
 	return retval;
 
 out:
@@ -1956,10 +1961,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
-out_files:
-	if (displaced)
-		reset_files_struct(displaced);
-
 	return retval;
 }
 
-- 
2.25.0

