Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E201F0852
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgFFTYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 15:24:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51612 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgFFTYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:24:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jheQr-0006qH-1M; Sat, 06 Jun 2020 13:24:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jheQo-0001Ql-VF; Sat, 06 Jun 2020 13:24:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        akpm@linux-foundation.org, ast@kernel.org, davem@davemloft.net,
        viro@zeniv.linux.org.uk, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
        <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
        <202006051903.C44988B@keescook>
Date:   Sat, 06 Jun 2020 14:20:36 -0500
In-Reply-To: <202006051903.C44988B@keescook> (Kees Cook's message of "Fri, 5
        Jun 2020 19:05:10 -0700")
Message-ID: <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jheQo-0001Ql-VF;;;mid=<875zc4c86z.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pLP9O2pio6cMxqhlEKi/H1udwcmhHaA0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,TR_Symld_Words,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1324 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (1.0%), b_tie_ro: 12 (0.9%), parse: 2.8 (0.2%),
         extract_message_metadata: 20 (1.5%), get_uri_detail_list: 10 (0.8%),
        tests_pri_-1000: 12 (0.9%), tests_pri_-950: 1.45 (0.1%),
        tests_pri_-900: 1.17 (0.1%), tests_pri_-90: 121 (9.2%), check_bayes:
        119 (9.0%), b_tokenize: 36 (2.7%), b_tok_get_all: 28 (2.1%),
        b_comp_prob: 8 (0.6%), b_tok_touch_all: 41 (3.1%), b_finish: 1.25
        (0.1%), tests_pri_0: 1137 (85.9%), check_dkim_signature: 1.80 (0.1%),
        check_dkim_adsp: 3.9 (0.3%), poll_dns_idle: 1.41 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 7 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] net/bpfilter:  Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Tetsuo Honda recently noticed that the exec support of bpfilter is buggy.
https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/

I agree with Al that Tetsuo's patch does not lend clarity to the code in
exec.  At a rough glance Tetsuo's patch does appear correct.

There have been no replies from the people who I expect would be
maintainers of the code.  When I look at the history of the code all it
appears to have received since it was merged was trivial maintenance
updates.  There has been no apparent work to finish fleshing out the
code to do what it is was aimed to do.

Examinine the code the pid handling is questionable.  The custom hook
into do_exit might prevent it but it appears that shutdown_umh has every
possibility of sending SIGKILL to the wrong process.

The Kconfig documentation lists this code as experimental.

The code only supports ipv4 not ipv6 another strong sign that this
code has not been going anywhere.

So as far as I can tell this bpfilter code was an experiment that did
not succeed and now no one cares about it.

So let's fix all of the bugs by removing the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Kees, Tesuo.  Unless someone chimes in and says they care I will
rebase this patch onto -rc1 to ensure I haven't missed something
because of the merge window and send this to Linus.

 fs/exec.c                        |  38 ++-----
 include/linux/binfmts.h          |   1 -
 include/linux/sched.h            |   8 --
 include/linux/umh.h              |  11 ---
 kernel/exit.c                    |   1 -
 kernel/umh.c                     | 163 +------------------------------
 net/Kconfig                      |   1 -
 net/Makefile                     |   1 -
 net/bpfilter/.gitignore          |   2 -
 net/bpfilter/Kconfig             |  16 ---
 net/bpfilter/Makefile            |  21 ----
 net/bpfilter/bpfilter_kern.c     | 128 ------------------------
 net/bpfilter/bpfilter_umh_blob.S |   7 --
 net/bpfilter/main.c              |  64 ------------
 net/bpfilter/msgfmt.h            |  17 ----
 net/ipv4/Makefile                |   1 -
 net/ipv4/bpfilter/Makefile       |   2 -
 net/ipv4/bpfilter/sockopt.c      |  78 ---------------
 18 files changed, 12 insertions(+), 548 deletions(-)
 delete mode 100644 net/bpfilter/.gitignore
 delete mode 100644 net/bpfilter/Kconfig
 delete mode 100644 net/bpfilter/Makefile
 delete mode 100644 net/bpfilter/bpfilter_kern.c
 delete mode 100644 net/bpfilter/bpfilter_umh_blob.S
 delete mode 100644 net/bpfilter/main.c
 delete mode 100644 net/bpfilter/msgfmt.h
 delete mode 100644 net/ipv4/bpfilter/Makefile
 delete mode 100644 net/ipv4/bpfilter/sockopt.c

diff --git a/fs/exec.c b/fs/exec.c
index e8599236290d..e6c24dabc1e4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1795,13 +1795,14 @@ static int exec_binprm(struct linux_binprm *bprm)
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
 
@@ -1840,8 +1841,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	if (!file)
-		file = do_open_execat(fd, filename, flags);
+	file = do_open_execat(fd, filename, flags);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_unmark;
@@ -1849,9 +1849,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	sched_exec();
 
 	bprm->file = file;
-	if (!filename) {
-		bprm->filename = "none";
-	} else if (fd == AT_FDCWD || filename->name[0] == '/') {
+	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
 		if (filename->name[0] == '\0')
@@ -1912,8 +1910,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	task_numa_free(current, false);
 	free_bprm(bprm);
 	kfree(pathbuf);
-	if (filename)
-		putname(filename);
+	putname(filename);
 	if (displaced)
 		put_files_struct(displaced);
 	return retval;
@@ -1944,27 +1941,10 @@ static int __do_execve_file(int fd, struct filename *filename,
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
index aece1b340e7d..e01eddc42750 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -142,6 +142,5 @@ extern int do_execveat(int, struct filename *,
 		       const char __user * const __user *,
 		       const char __user * const __user *,
 		       int);
-int do_execve_file(struct file *file, void *__argv, void *__envp);
 
 #endif /* _LINUX_BINFMTS_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..73d0eb46a67f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1986,14 +1986,6 @@ static inline void rseq_execve(struct task_struct *t)
 
 #endif
 
-void __exit_umh(struct task_struct *tsk);
-
-static inline void exit_umh(struct task_struct *tsk)
-{
-	if (unlikely(tsk->flags & PF_UMH))
-		__exit_umh(tsk);
-}
-
 #ifdef CONFIG_DEBUG_RSEQ
 
 void rseq_syscall(struct pt_regs *regs);
diff --git a/include/linux/umh.h b/include/linux/umh.h
index 0c08de356d0d..128ae92e6983 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -22,10 +22,8 @@ struct subprocess_info {
 	const char *path;
 	char **argv;
 	char **envp;
-	struct file *file;
 	int wait;
 	int retval;
-	pid_t pid;
 	int (*init)(struct subprocess_info *info, struct cred *new);
 	void (*cleanup)(struct subprocess_info *info);
 	void *data;
@@ -43,15 +41,6 @@ call_usermodehelper_setup(const char *path, char **argv, char **envp,
 struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
 			  int (*init)(struct subprocess_info *info, struct cred *new),
 			  void (*cleanup)(struct subprocess_info *), void *data);
-struct umh_info {
-	const char *cmdline;
-	struct file *pipe_to_umh;
-	struct file *pipe_from_umh;
-	struct list_head list;
-	void (*cleanup)(struct umh_info *info);
-	pid_t pid;
-};
-int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
 
 extern int
 call_usermodehelper_exec(struct subprocess_info *info, int wait);
diff --git a/kernel/exit.c b/kernel/exit.c
index ce2a75bc0ade..989f1ada0bf1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -795,7 +795,6 @@ void __noreturn do_exit(long code)
 	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
-	exit_umh(tsk);
 
 	/*
 	 * Flush inherited counters to the parent - before the parent
diff --git a/kernel/umh.c b/kernel/umh.c
index 7f255b5a8845..a9a6032e08a6 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -26,8 +26,6 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
-#include <linux/shmem_fs.h>
-#include <linux/pipe_fs_i.h>
 
 #include <trace/events/module.h>
 
@@ -39,7 +37,6 @@ static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
 static DEFINE_SPINLOCK(umh_sysctl_lock);
 static DECLARE_RWSEM(umhelper_sem);
 static LIST_HEAD(umh_list);
-static DEFINE_MUTEX(umh_list_lock);
 
 static void call_usermodehelper_freeinfo(struct subprocess_info *info)
 {
@@ -102,16 +99,9 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	sub_info->pid = task_pid_nr(current);
-	if (sub_info->file) {
-		retval = do_execve_file(sub_info->file,
-					sub_info->argv, sub_info->envp);
-		if (!retval)
-			current->flags |= PF_UMH;
-	} else
-		retval = do_execve(getname_kernel(sub_info->path),
-				   (const char __user *const __user *)sub_info->argv,
-				   (const char __user *const __user *)sub_info->envp);
+	retval = do_execve(getname_kernel(sub_info->path),
+			   (const char __user *const __user *)sub_info->argv,
+			   (const char __user *const __user *)sub_info->envp);
 out:
 	sub_info->retval = retval;
 	/*
@@ -405,133 +395,6 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 }
 EXPORT_SYMBOL(call_usermodehelper_setup);
 
-struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
-		int (*init)(struct subprocess_info *info, struct cred *new),
-		void (*cleanup)(struct subprocess_info *info), void *data)
-{
-	struct subprocess_info *sub_info;
-	struct umh_info *info = data;
-	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
-
-	sub_info = kzalloc(sizeof(struct subprocess_info), GFP_KERNEL);
-	if (!sub_info)
-		return NULL;
-
-	sub_info->argv = argv_split(GFP_KERNEL, cmdline, NULL);
-	if (!sub_info->argv) {
-		kfree(sub_info);
-		return NULL;
-	}
-
-	INIT_WORK(&sub_info->work, call_usermodehelper_exec_work);
-	sub_info->path = "none";
-	sub_info->file = file;
-	sub_info->init = init;
-	sub_info->cleanup = cleanup;
-	sub_info->data = data;
-	return sub_info;
-}
-
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
-{
-	struct umh_info *umh_info = info->data;
-	struct file *from_umh[2];
-	struct file *to_umh[2];
-	int err;
-
-	/* create pipe to send data to umh */
-	err = create_pipe_files(to_umh, 0);
-	if (err)
-		return err;
-	err = replace_fd(0, to_umh[0], 0);
-	fput(to_umh[0]);
-	if (err < 0) {
-		fput(to_umh[1]);
-		return err;
-	}
-
-	/* create pipe to receive data from umh */
-	err = create_pipe_files(from_umh, 0);
-	if (err) {
-		fput(to_umh[1]);
-		replace_fd(0, NULL, 0);
-		return err;
-	}
-	err = replace_fd(1, from_umh[1], 0);
-	fput(from_umh[1]);
-	if (err < 0) {
-		fput(to_umh[1]);
-		replace_fd(0, NULL, 0);
-		fput(from_umh[0]);
-		return err;
-	}
-
-	umh_info->pipe_to_umh = to_umh[1];
-	umh_info->pipe_from_umh = from_umh[0];
-	return 0;
-}
-
-static void umh_clean_and_save_pid(struct subprocess_info *info)
-{
-	struct umh_info *umh_info = info->data;
-
-	argv_free(info->argv);
-	umh_info->pid = info->pid;
-}
-
-/**
- * fork_usermode_blob - fork a blob of bytes as a usermode process
- * @data: a blob of bytes that can be do_execv-ed as a file
- * @len: length of the blob
- * @info: information about usermode process (shouldn't be NULL)
- *
- * If info->cmdline is set it will be used as command line for the
- * user process, else "usermodehelper" is used.
- *
- * Returns either negative error or zero which indicates success
- * in executing a blob of bytes as a usermode process. In such
- * case 'struct umh_info *info' is populated with two pipes
- * and a pid of the process. The caller is responsible for health
- * check of the user process, killing it via pid, and closing the
- * pipes when user process is no longer needed.
- */
-int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
-{
-	struct subprocess_info *sub_info;
-	struct file *file;
-	ssize_t written;
-	loff_t pos = 0;
-	int err;
-
-	file = shmem_kernel_file_setup("", len, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	written = kernel_write(file, data, len, &pos);
-	if (written != len) {
-		err = written;
-		if (err >= 0)
-			err = -ENOMEM;
-		goto out;
-	}
-
-	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup_file(file, umh_pipe_setup,
-						  umh_clean_and_save_pid, info);
-	if (!sub_info)
-		goto out;
-
-	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
-	if (!err) {
-		mutex_lock(&umh_list_lock);
-		list_add(&info->list, &umh_list);
-		mutex_unlock(&umh_list_lock);
-	}
-out:
-	fput(file);
-	return err;
-}
-EXPORT_SYMBOL_GPL(fork_usermode_blob);
 
 /**
  * call_usermodehelper_exec - start a usermode application
@@ -689,26 +552,6 @@ static int proc_cap_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-void __exit_umh(struct task_struct *tsk)
-{
-	struct umh_info *info;
-	pid_t pid = tsk->pid;
-
-	mutex_lock(&umh_list_lock);
-	list_for_each_entry(info, &umh_list, list) {
-		if (info->pid == pid) {
-			list_del(&info->list);
-			mutex_unlock(&umh_list_lock);
-			goto out;
-		}
-	}
-	mutex_unlock(&umh_list_lock);
-	return;
-out:
-	if (info->cleanup)
-		info->cleanup(info);
-}
-
 struct ctl_table usermodehelper_table[] = {
 	{
 		.procname	= "bset",
diff --git a/net/Kconfig b/net/Kconfig
index df8d8c9bd021..56066e279336 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -209,7 +209,6 @@ source "net/bridge/netfilter/Kconfig"
 
 endif
 
-source "net/bpfilter/Kconfig"
 
 source "net/dccp/Kconfig"
 source "net/sctp/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 07ea48160874..5148cce5f588 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX_SCM)		+= unix/
 obj-$(CONFIG_NET)		+= ipv6/
-obj-$(CONFIG_BPFILTER)		+= bpfilter/
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
 obj-$(CONFIG_BRIDGE)		+= bridge/
diff --git a/net/bpfilter/.gitignore b/net/bpfilter/.gitignore
deleted file mode 100644
index f34e85ee8204..000000000000
--- a/net/bpfilter/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-bpfilter_umh
diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
deleted file mode 100644
index fed9290e3b41..000000000000
--- a/net/bpfilter/Kconfig
+++ /dev/null
@@ -1,16 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig BPFILTER
-	bool "BPF based packet filtering framework (BPFILTER)"
-	depends on NET && BPF && INET
-	help
-	  This builds experimental bpfilter framework that is aiming to
-	  provide netfilter compatible functionality via BPF
-
-if BPFILTER
-config BPFILTER_UMH
-	tristate "bpfilter kernel module with user mode helper"
-	depends on CC_CAN_LINK
-	default m
-	help
-	  This builds bpfilter kernel module with embedded user mode helper
-endif
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
deleted file mode 100644
index 36580301da70..000000000000
--- a/net/bpfilter/Makefile
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the Linux BPFILTER layer.
-#
-
-hostprogs := bpfilter_umh
-bpfilter_umh-objs := main.o
-KBUILD_HOSTCFLAGS += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
-HOSTCC := $(CC)
-
-ifeq ($(CONFIG_BPFILTER_UMH), y)
-# builtin bpfilter_umh should be compiled with -static
-# since rootfs isn't mounted at the time of __init
-# function is called and do_execv won't find elf interpreter
-KBUILD_HOSTLDFLAGS += -static
-endif
-
-$(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
-
-obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
-bpfilter-objs += bpfilter_kern.o bpfilter_umh_blob.o
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
deleted file mode 100644
index c0f0990f30b6..000000000000
--- a/net/bpfilter/bpfilter_kern.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/umh.h>
-#include <linux/bpfilter.h>
-#include <linux/sched.h>
-#include <linux/sched/signal.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include "msgfmt.h"
-
-extern char bpfilter_umh_start;
-extern char bpfilter_umh_end;
-
-static void shutdown_umh(void)
-{
-	struct task_struct *tsk;
-
-	if (bpfilter_ops.stop)
-		return;
-
-	tsk = get_pid_task(find_vpid(bpfilter_ops.info.pid), PIDTYPE_PID);
-	if (tsk) {
-		send_sig(SIGKILL, tsk, 1);
-		put_task_struct(tsk);
-	}
-}
-
-static void __stop_umh(void)
-{
-	if (IS_ENABLED(CONFIG_INET))
-		shutdown_umh();
-}
-
-static int __bpfilter_process_sockopt(struct sock *sk, int optname,
-				      char __user *optval,
-				      unsigned int optlen, bool is_set)
-{
-	struct mbox_request req;
-	struct mbox_reply reply;
-	loff_t pos;
-	ssize_t n;
-	int ret = -EFAULT;
-
-	req.is_set = is_set;
-	req.pid = current->pid;
-	req.cmd = optname;
-	req.addr = (long __force __user)optval;
-	req.len = optlen;
-	if (!bpfilter_ops.info.pid)
-		goto out;
-	n = __kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
-			   &pos);
-	if (n != sizeof(req)) {
-		pr_err("write fail %zd\n", n);
-		__stop_umh();
-		ret = -EFAULT;
-		goto out;
-	}
-	pos = 0;
-	n = kernel_read(bpfilter_ops.info.pipe_from_umh, &reply, sizeof(reply),
-			&pos);
-	if (n != sizeof(reply)) {
-		pr_err("read fail %zd\n", n);
-		__stop_umh();
-		ret = -EFAULT;
-		goto out;
-	}
-	ret = reply.status;
-out:
-	return ret;
-}
-
-static int start_umh(void)
-{
-	int err;
-
-	/* fork usermode process */
-	err = fork_usermode_blob(&bpfilter_umh_start,
-				 &bpfilter_umh_end - &bpfilter_umh_start,
-				 &bpfilter_ops.info);
-	if (err)
-		return err;
-	bpfilter_ops.stop = false;
-	pr_info("Loaded bpfilter_umh pid %d\n", bpfilter_ops.info.pid);
-
-	/* health check that usermode process started correctly */
-	if (__bpfilter_process_sockopt(NULL, 0, NULL, 0, 0) != 0) {
-		shutdown_umh();
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int __init load_umh(void)
-{
-	int err;
-
-	mutex_lock(&bpfilter_ops.lock);
-	if (!bpfilter_ops.stop) {
-		err = -EFAULT;
-		goto out;
-	}
-	err = start_umh();
-	if (!err && IS_ENABLED(CONFIG_INET)) {
-		bpfilter_ops.sockopt = &__bpfilter_process_sockopt;
-		bpfilter_ops.start = &start_umh;
-	}
-out:
-	mutex_unlock(&bpfilter_ops.lock);
-	return err;
-}
-
-static void __exit fini_umh(void)
-{
-	mutex_lock(&bpfilter_ops.lock);
-	if (IS_ENABLED(CONFIG_INET)) {
-		shutdown_umh();
-		bpfilter_ops.start = NULL;
-		bpfilter_ops.sockopt = NULL;
-	}
-	mutex_unlock(&bpfilter_ops.lock);
-}
-module_init(load_umh);
-module_exit(fini_umh);
-MODULE_LICENSE("GPL");
diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
deleted file mode 100644
index 9ea6100dca87..000000000000
--- a/net/bpfilter/bpfilter_umh_blob.S
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-	.section .rodata, "a"
-	.global bpfilter_umh_start
-bpfilter_umh_start:
-	.incbin "net/bpfilter/bpfilter_umh"
-	.global bpfilter_umh_end
-bpfilter_umh_end:
diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
deleted file mode 100644
index 05e1cfc1e5cd..000000000000
--- a/net/bpfilter/main.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <sys/uio.h>
-#include <errno.h>
-#include <stdio.h>
-#include <sys/socket.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "../../include/uapi/linux/bpf.h"
-#include <asm/unistd.h>
-#include "msgfmt.h"
-
-FILE *debug_f;
-
-static int handle_get_cmd(struct mbox_request *cmd)
-{
-	switch (cmd->cmd) {
-	case 0:
-		return 0;
-	default:
-		break;
-	}
-	return -ENOPROTOOPT;
-}
-
-static int handle_set_cmd(struct mbox_request *cmd)
-{
-	return -ENOPROTOOPT;
-}
-
-static void loop(void)
-{
-	while (1) {
-		struct mbox_request req;
-		struct mbox_reply reply;
-		int n;
-
-		n = read(0, &req, sizeof(req));
-		if (n != sizeof(req)) {
-			fprintf(debug_f, "invalid request %d\n", n);
-			return;
-		}
-
-		reply.status = req.is_set ?
-			handle_set_cmd(&req) :
-			handle_get_cmd(&req);
-
-		n = write(1, &reply, sizeof(reply));
-		if (n != sizeof(reply)) {
-			fprintf(debug_f, "reply failed %d\n", n);
-			return;
-		}
-	}
-}
-
-int main(void)
-{
-	debug_f = fopen("/dev/kmsg", "w");
-	setvbuf(debug_f, 0, _IOLBF, 0);
-	fprintf(debug_f, "Started bpfilter\n");
-	loop();
-	fclose(debug_f);
-	return 0;
-}
diff --git a/net/bpfilter/msgfmt.h b/net/bpfilter/msgfmt.h
deleted file mode 100644
index 98d121c62945..000000000000
--- a/net/bpfilter/msgfmt.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NET_BPFILTER_MSGFMT_H
-#define _NET_BPFILTER_MSGFMT_H
-
-struct mbox_request {
-	__u64 addr;
-	__u32 len;
-	__u32 is_set;
-	__u32 cmd;
-	__u32 pid;
-};
-
-struct mbox_reply {
-	__u32 status;
-};
-
-#endif
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 9e1a186a3671..e4c1cb8df316 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -16,7 +16,6 @@ obj-y     := route.o inetpeer.o protocol.o \
 	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
 	     metrics.o netlink.o nexthop.o
 
-obj-$(CONFIG_BPFILTER) += bpfilter/
 
 obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
 obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
diff --git a/net/ipv4/bpfilter/Makefile b/net/ipv4/bpfilter/Makefile
deleted file mode 100644
index 00af5305e05a..000000000000
--- a/net/ipv4/bpfilter/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_BPFILTER) += sockopt.o
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
deleted file mode 100644
index 0480918bfc7c..000000000000
--- a/net/ipv4/bpfilter/sockopt.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/uaccess.h>
-#include <linux/bpfilter.h>
-#include <uapi/linux/bpf.h>
-#include <linux/wait.h>
-#include <linux/kmod.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-
-struct bpfilter_umh_ops bpfilter_ops;
-EXPORT_SYMBOL_GPL(bpfilter_ops);
-
-static void bpfilter_umh_cleanup(struct umh_info *info)
-{
-	mutex_lock(&bpfilter_ops.lock);
-	bpfilter_ops.stop = true;
-	fput(info->pipe_to_umh);
-	fput(info->pipe_from_umh);
-	info->pid = 0;
-	mutex_unlock(&bpfilter_ops.lock);
-}
-
-static int bpfilter_mbox_request(struct sock *sk, int optname,
-				 char __user *optval,
-				 unsigned int optlen, bool is_set)
-{
-	int err;
-	mutex_lock(&bpfilter_ops.lock);
-	if (!bpfilter_ops.sockopt) {
-		mutex_unlock(&bpfilter_ops.lock);
-		request_module("bpfilter");
-		mutex_lock(&bpfilter_ops.lock);
-
-		if (!bpfilter_ops.sockopt) {
-			err = -ENOPROTOOPT;
-			goto out;
-		}
-	}
-	if (bpfilter_ops.stop) {
-		err = bpfilter_ops.start();
-		if (err)
-			goto out;
-	}
-	err = bpfilter_ops.sockopt(sk, optname, optval, optlen, is_set);
-out:
-	mutex_unlock(&bpfilter_ops.lock);
-	return err;
-}
-
-int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
-			    unsigned int optlen)
-{
-	return bpfilter_mbox_request(sk, optname, optval, optlen, true);
-}
-
-int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
-			    int __user *optlen)
-{
-	int len;
-
-	if (get_user(len, optlen))
-		return -EFAULT;
-
-	return bpfilter_mbox_request(sk, optname, optval, len, false);
-}
-
-static int __init bpfilter_sockopt_init(void)
-{
-	mutex_init(&bpfilter_ops.lock);
-	bpfilter_ops.stop = true;
-	bpfilter_ops.info.cmdline = "bpfilter_umh";
-	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
-
-	return 0;
-}
-device_initcall(bpfilter_sockopt_init);
-- 
2.20.1
