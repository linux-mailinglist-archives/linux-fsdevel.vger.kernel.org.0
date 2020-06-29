Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE51E20DBBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgF2UJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:09:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40112 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgF2UJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:09:22 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq05b-0006JU-NI; Mon, 29 Jun 2020 14:09:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq05a-0000cx-I2; Mon, 29 Jun 2020 14:09:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 29 Jun 2020 15:04:41 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87lfk54p0m.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq05a-0000cx-I2;;;mid=<87lfk54p0m.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18jk9MPy/jYN6RjgP7KmdEpIJ9vTl3XBbc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,T_TooManySym_01,XM_B_Phish66
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 619 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.6%), parse: 1.62
        (0.3%), extract_message_metadata: 29 (4.6%), get_uri_detail_list: 4.8
        (0.8%), tests_pri_-1000: 44 (7.1%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 146 (23.6%), check_bayes:
        144 (23.3%), b_tokenize: 17 (2.7%), b_tok_get_all: 12 (1.9%),
        b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 109 (17.6%), b_finish: 0.94
        (0.2%), tests_pri_0: 371 (59.9%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.0 (0.3%), poll_dns_idle: 0.59 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 10/15] exec: Remove do_execve_file
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Now that the last callser has been removed remove this code from exec.

For anyone thinking of resurrecing do_execve_file please note that
the code was buggy in several fundamental ways.

- It did not ensure the file it was passed was read-only and that
  deny_write_access had been called on it.  Which subtlely breaks
  invaniants in exec.

- The caller of do_execve_file was expected to hold and put a
  reference to the file, but an extra reference for use by exec was
  not taken so that when exec put it's reference to the file an
  underflow occured on the file reference count.

- The point of the interface was so that a pathname did not need to
  exist.  Which breaks pathname based LSMs.

Tetsuo Handa originally reported these issues[1].  While it was clear
that deny_write_access was missing the fundamental incompatibility
with the passed in O_RDWR filehandle was not immediately recognized.

All of these issues were fixed by modifying the usermode driver code
to have a path, so it did not need this hack.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[1] https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
Link: https://lkml.kernel.org/r/871rm2f0hi.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               | 38 +++++++++-----------------------------
 include/linux/binfmts.h |  1 -
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..23dfbb820626 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1818,13 +1818,14 @@ static int exec_binprm(struct linux_binprm *bprm)
 /*
  * sys_execve() executes a new program.
  */
-static int __do_execve_file(int fd, struct filename *filename,
-			    struct user_arg_ptr argv,
-			    struct user_arg_ptr envp,
-			    int flags, struct file *file)
+static int do_execveat_common(int fd, struct filename *filename,
+			      struct user_arg_ptr argv,
+			      struct user_arg_ptr envp,
+			      int flags)
 {
 	char *pathbuf = NULL;
 	struct linux_binprm *bprm;
+	struct file *file;
 	struct files_struct *displaced;
 	int retval;
 
@@ -1863,8 +1864,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	if (!file)
-		file = do_open_execat(fd, filename, flags);
+	file = do_open_execat(fd, filename, flags);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_unmark;
@@ -1872,9 +1872,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	sched_exec();
 
 	bprm->file = file;
-	if (!filename) {
-		bprm->filename = "none";
-	} else if (fd == AT_FDCWD || filename->name[0] == '/') {
+	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
 		if (filename->name[0] == '\0')
@@ -1935,8 +1933,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	task_numa_free(current, false);
 	free_bprm(bprm);
 	kfree(pathbuf);
-	if (filename)
-		putname(filename);
+	putname(filename);
 	if (displaced)
 		put_files_struct(displaced);
 	return retval;
@@ -1967,27 +1964,10 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (displaced)
 		reset_files_struct(displaced);
 out_ret:
-	if (filename)
-		putname(filename);
+	putname(filename);
 	return retval;
 }
 
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
-{
-	return __do_execve_file(fd, filename, argv, envp, flags, NULL);
-}
-
-int do_execve_file(struct file *file, void *__argv, void *__envp)
-{
-	struct user_arg_ptr argv = { .ptr.native = __argv };
-	struct user_arg_ptr envp = { .ptr.native = __envp };
-
-	return __do_execve_file(AT_FDCWD, NULL, argv, envp, 0, file);
-}
-
 int do_execve(struct filename *filename,
 	const char __user *const __user *__argv,
 	const char __user *const __user *__envp)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 4a20b7517dd0..7c27d7b57871 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -141,6 +141,5 @@ extern int do_execveat(int, struct filename *,
 		       const char __user * const __user *,
 		       const char __user * const __user *,
 		       int);
-int do_execve_file(struct file *file, void *__argv, void *__envp);
 
 #endif /* _LINUX_BINFMTS_H */
-- 
2.25.0

