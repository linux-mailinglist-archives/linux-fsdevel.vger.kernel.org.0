Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1D20DB40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbgF2UFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:05:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35334 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbgF2UFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:05:00 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq01S-0003Cg-16; Mon, 29 Jun 2020 14:04:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq01Q-0008TW-Cc; Mon, 29 Jun 2020 14:04:57 -0600
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
Date:   Mon, 29 Jun 2020 15:00:25 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87imf963s6.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq01Q-0008TW-Cc;;;mid=<87imf963s6.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ykOG3gXo6yJeqsDnSIIrix9rU0MsLxLI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1017 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.0%), b_tie_ro: 9 (0.9%), parse: 1.73 (0.2%),
         extract_message_metadata: 20 (2.0%), get_uri_detail_list: 7 (0.6%),
        tests_pri_-1000: 24 (2.3%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 178 (17.5%), check_bayes:
        176 (17.3%), b_tokenize: 26 (2.5%), b_tok_get_all: 14 (1.4%),
        b_comp_prob: 3.8 (0.4%), b_tok_touch_all: 127 (12.5%), b_finish: 0.95
        (0.1%), tests_pri_0: 755 (74.3%), check_dkim_signature: 0.86 (0.1%),
        check_dkim_adsp: 2.1 (0.2%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        3.8 (0.4%), tests_pri_500: 18 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 05/15] umh: Separate the user mode driver and the user mode helper support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This makes it clear which code is part of the core user mode
helper support and which code is needed to implement user mode
drivers.

This makes the kernel smaller for everyone who does not use a usermode
driver.

v2: Moved exit_umh from sched.h to umd.h and handle the case when the
code is compiled out.

Link: https://lkml.kernel.org/r/87tuyyf0ln.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/bpfilter.h |   2 +-
 include/linux/sched.h    |   8 ---
 include/linux/umd.h      |  30 ++++++++
 include/linux/umh.h      |  10 ---
 kernel/Makefile          |   1 +
 kernel/exit.c            |   1 +
 kernel/umd.c             | 146 +++++++++++++++++++++++++++++++++++++++
 kernel/umh.c             | 139 -------------------------------------
 8 files changed, 179 insertions(+), 158 deletions(-)
 create mode 100644 include/linux/umd.h
 create mode 100644 kernel/umd.c

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index d815622cd31e..b42e44e29033 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -3,7 +3,7 @@
 #define _LINUX_BPFILTER_H
 
 #include <uapi/linux/bpfilter.h>
-#include <linux/umh.h>
+#include <linux/umd.h>
 
 struct sock;
 int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..59d1e92bb88e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2020,14 +2020,6 @@ static inline void rseq_execve(struct task_struct *t)
 
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
diff --git a/include/linux/umd.h b/include/linux/umd.h
new file mode 100644
index 000000000000..ef40bee590c1
--- /dev/null
+++ b/include/linux/umd.h
@@ -0,0 +1,30 @@
+#ifndef __LINUX_UMD_H__
+#define __LINUX_UMD_H__
+
+#include <linux/umh.h>
+
+#ifdef CONFIG_BPFILTER
+void __exit_umh(struct task_struct *tsk);
+
+static inline void exit_umh(struct task_struct *tsk)
+{
+	if (unlikely(tsk->flags & PF_UMH))
+		__exit_umh(tsk);
+}
+#else
+static inline void exit_umh(struct task_struct *tsk)
+{
+}
+#endif
+
+struct umh_info {
+	const char *cmdline;
+	struct file *pipe_to_umh;
+	struct file *pipe_from_umh;
+	struct list_head list;
+	void (*cleanup)(struct umh_info *info);
+	pid_t pid;
+};
+int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
+
+#endif /* __LINUX_UMD_H__ */
diff --git a/include/linux/umh.h b/include/linux/umh.h
index de08af00c68a..73173c4a07e5 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -39,16 +39,6 @@ call_usermodehelper_setup(const char *path, char **argv, char **envp,
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
-
 extern int
 call_usermodehelper_exec(struct subprocess_info *info, int wait);
 
diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..a81d7354323c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -12,6 +12,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o
 
+obj-$(CONFIG_BPFILTER) += umd.o
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f28103..b94fe03e609c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -63,6 +63,7 @@
 #include <linux/random.h>
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
+#include <linux/umd.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
diff --git a/kernel/umd.c b/kernel/umd.c
new file mode 100644
index 000000000000..99af9d594eca
--- /dev/null
+++ b/kernel/umd.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * umd - User mode driver support
+ */
+#include <linux/shmem_fs.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/umd.h>
+
+static LIST_HEAD(umh_list);
+static DEFINE_MUTEX(umh_list_lock);
+
+static int umd_setup(struct subprocess_info *info, struct cred *new)
+{
+	struct umh_info *umh_info = info->data;
+	struct file *from_umh[2];
+	struct file *to_umh[2];
+	int err;
+
+	/* create pipe to send data to umh */
+	err = create_pipe_files(to_umh, 0);
+	if (err)
+		return err;
+	err = replace_fd(0, to_umh[0], 0);
+	fput(to_umh[0]);
+	if (err < 0) {
+		fput(to_umh[1]);
+		return err;
+	}
+
+	/* create pipe to receive data from umh */
+	err = create_pipe_files(from_umh, 0);
+	if (err) {
+		fput(to_umh[1]);
+		replace_fd(0, NULL, 0);
+		return err;
+	}
+	err = replace_fd(1, from_umh[1], 0);
+	fput(from_umh[1]);
+	if (err < 0) {
+		fput(to_umh[1]);
+		replace_fd(0, NULL, 0);
+		fput(from_umh[0]);
+		return err;
+	}
+
+	umh_info->pipe_to_umh = to_umh[1];
+	umh_info->pipe_from_umh = from_umh[0];
+	umh_info->pid = task_pid_nr(current);
+	current->flags |= PF_UMH;
+	return 0;
+}
+
+static void umd_cleanup(struct subprocess_info *info)
+{
+	struct umh_info *umh_info = info->data;
+
+	/* cleanup if umh_setup() was successful but exec failed */
+	if (info->retval) {
+		fput(umh_info->pipe_to_umh);
+		fput(umh_info->pipe_from_umh);
+	}
+}
+
+/**
+ * fork_usermode_blob - fork a blob of bytes as a usermode process
+ * @data: a blob of bytes that can be do_execv-ed as a file
+ * @len: length of the blob
+ * @info: information about usermode process (shouldn't be NULL)
+ *
+ * If info->cmdline is set it will be used as command line for the
+ * user process, else "usermodehelper" is used.
+ *
+ * Returns either negative error or zero which indicates success
+ * in executing a blob of bytes as a usermode process. In such
+ * case 'struct umh_info *info' is populated with two pipes
+ * and a pid of the process. The caller is responsible for health
+ * check of the user process, killing it via pid, and closing the
+ * pipes when user process is no longer needed.
+ */
+int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
+{
+	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
+	struct subprocess_info *sub_info;
+	char **argv = NULL;
+	struct file *file;
+	ssize_t written;
+	loff_t pos = 0;
+	int err;
+
+	file = shmem_kernel_file_setup("", len, 0);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	written = kernel_write(file, data, len, &pos);
+	if (written != len) {
+		err = written;
+		if (err >= 0)
+			err = -ENOMEM;
+		goto out;
+	}
+
+	err = -ENOMEM;
+	argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	if (!argv)
+		goto out;
+
+	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
+					     umd_setup, umd_cleanup, info);
+	if (!sub_info)
+		goto out;
+
+	sub_info->file = file;
+	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
+	if (!err) {
+		mutex_lock(&umh_list_lock);
+		list_add(&info->list, &umh_list);
+		mutex_unlock(&umh_list_lock);
+	}
+out:
+	if (argv)
+		argv_free(argv);
+	fput(file);
+	return err;
+}
+EXPORT_SYMBOL_GPL(fork_usermode_blob);
+
+void __exit_umh(struct task_struct *tsk)
+{
+	struct umh_info *info;
+	pid_t pid = tsk->pid;
+
+	mutex_lock(&umh_list_lock);
+	list_for_each_entry(info, &umh_list, list) {
+		if (info->pid == pid) {
+			list_del(&info->list);
+			mutex_unlock(&umh_list_lock);
+			goto out;
+		}
+	}
+	mutex_unlock(&umh_list_lock);
+	return;
+out:
+	if (info->cleanup)
+		info->cleanup(info);
+}
+
diff --git a/kernel/umh.c b/kernel/umh.c
index b8fa9b99b366..3e4e453d45c8 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -26,8 +26,6 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
-#include <linux/shmem_fs.h>
-#include <linux/pipe_fs_i.h>
 
 #include <trace/events/module.h>
 
@@ -38,8 +36,6 @@ static kernel_cap_t usermodehelper_bset = CAP_FULL_SET;
 static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
 static DEFINE_SPINLOCK(umh_sysctl_lock);
 static DECLARE_RWSEM(umhelper_sem);
-static LIST_HEAD(umh_list);
-static DEFINE_MUTEX(umh_list_lock);
 
 static void call_usermodehelper_freeinfo(struct subprocess_info *info)
 {
@@ -402,121 +398,6 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
 }
 EXPORT_SYMBOL(call_usermodehelper_setup);
 
-static int umd_setup(struct subprocess_info *info, struct cred *new)
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
-	umh_info->pid = task_pid_nr(current);
-	current->flags |= PF_UMH;
-	return 0;
-}
-
-static void umd_cleanup(struct subprocess_info *info)
-{
-	struct umh_info *umh_info = info->data;
-
-	/* cleanup if umh_setup() was successful but exec failed */
-	if (info->retval) {
-		fput(umh_info->pipe_to_umh);
-		fput(umh_info->pipe_from_umh);
-	}
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
-	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
-	struct subprocess_info *sub_info;
-	char **argv = NULL;
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
-	argv = argv_split(GFP_KERNEL, cmdline, NULL);
-	if (!argv)
-		goto out;
-
-	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
-					     umd_setup, umd_cleanup, info);
-	if (!sub_info)
-		goto out;
-
-	sub_info->file = file;
-	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
-	if (!err) {
-		mutex_lock(&umh_list_lock);
-		list_add(&info->list, &umh_list);
-		mutex_unlock(&umh_list_lock);
-	}
-out:
-	if (argv)
-		argv_free(argv);
-	fput(file);
-	return err;
-}
-EXPORT_SYMBOL_GPL(fork_usermode_blob);
-
 /**
  * call_usermodehelper_exec - start a usermode application
  * @sub_info: information about the subprocessa
@@ -678,26 +559,6 @@ static int proc_cap_handler(struct ctl_table *table, int write,
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
-- 
2.25.0

