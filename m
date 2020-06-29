Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4856620DBE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgF2UKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:10:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37826 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgF2UKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:10:42 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq06y-0003sK-H1; Mon, 29 Jun 2020 14:10:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq06x-0004aE-1a; Mon, 29 Jun 2020 14:10:39 -0600
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
Date:   Mon, 29 Jun 2020 15:06:07 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87a70l4oy8.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq06x-0004aE-1a;;;mid=<87a70l4oy8.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/x4mrxyEgtfOPj78oDI1znxchawvWVzpY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 636 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.6%), b_tie_ro: 2.8 (0.4%), parse: 0.89
        (0.1%), extract_message_metadata: 14 (2.2%), get_uri_detail_list: 2.7
        (0.4%), tests_pri_-1000: 20 (3.1%), tests_pri_-950: 1.11 (0.2%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 164 (25.7%), check_bayes:
        162 (25.5%), b_tokenize: 12 (1.9%), b_tok_get_all: 11 (1.7%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 134 (21.0%), b_finish: 0.75
        (0.1%), tests_pri_0: 421 (66.3%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.91 (0.1%), tests_pri_10:
        1.85 (0.3%), tests_pri_500: 5 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 12/15] umd: Track user space drivers with struct pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Use struct pid instead of user space pid values that are prone to wrap
araound.

In addition track the entire thread group instead of just the first
thread that is started by exec.  There are no multi-threaded user mode
drivers today but there is nothing preclucing user drivers from being
multi-threaded, so it is just a good idea to track the entire process.

Take a reference count on the tgid's in question to make it possible
to remove exit_umh in a future change.

As a struct pid is available directly use kill_pid_info.

The prior process signalling code was iffy in using a userspace pid
known to be in the initial pid namespace and then looking up it's task
in whatever the current pid namespace is.  It worked only because
kernel threads always run in the initial pid namespace.

As the tgid is now refcounted verify the tgid is NULL at the start of
fork_usermode_driver to avoid the possibility of silent pid leaks.

Link: https://lkml.kernel.org/r/87mu4qdlv2.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umd.h          |  2 +-
 kernel/exit.c                |  3 ++-
 kernel/umd.c                 | 15 ++++++++++-----
 net/bpfilter/bpfilter_kern.c | 13 +++++--------
 net/ipv4/bpfilter/sockopt.c  |  3 ++-
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/umd.h b/include/linux/umd.h
index 12ff8f753ea7..edb1c62c62f4 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -25,7 +25,7 @@ struct umd_info {
 	struct list_head list;
 	void (*cleanup)(struct umd_info *info);
 	struct path wd;
-	pid_t pid;
+	struct pid *tgid;
 };
 int umd_load_blob(struct umd_info *info, const void *data, size_t len);
 int umd_unload_blob(struct umd_info *info);
diff --git a/kernel/exit.c b/kernel/exit.c
index b94fe03e609c..b53107abdd31 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -805,7 +805,8 @@ void __noreturn do_exit(long code)
 	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
-	exit_umh(tsk);
+	if (group_dead)
+		exit_umh(tsk);
 
 	/*
 	 * Flush inherited counters to the parent - before the parent
diff --git a/kernel/umd.c b/kernel/umd.c
index aaa6f3142e52..c1e8eccaee76 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -133,7 +133,7 @@ static int umd_setup(struct subprocess_info *info, struct cred *new)
 	set_fs_pwd(current->fs, &umd_info->wd);
 	umd_info->pipe_to_umh = to_umh[1];
 	umd_info->pipe_from_umh = from_umh[0];
-	umd_info->pid = task_pid_nr(current);
+	umd_info->tgid = get_pid(task_tgid(current));
 	current->flags |= PF_UMH;
 	return 0;
 }
@@ -146,6 +146,8 @@ static void umd_cleanup(struct subprocess_info *info)
 	if (info->retval) {
 		fput(umd_info->pipe_to_umh);
 		fput(umd_info->pipe_from_umh);
+		put_pid(umd_info->tgid);
+		umd_info->tgid = NULL;
 	}
 }
 
@@ -155,9 +157,9 @@ static void umd_cleanup(struct subprocess_info *info)
  *
  * Returns either negative error or zero which indicates success in
  * executing a usermode driver. In such case 'struct umd_info *info'
- * is populated with two pipes and a pid of the process. The caller is
+ * is populated with two pipes and a tgid of the process. The caller is
  * responsible for health check of the user process, killing it via
- * pid, and closing the pipes when user process is no longer needed.
+ * tgid, and closing the pipes when user process is no longer needed.
  */
 int fork_usermode_driver(struct umd_info *info)
 {
@@ -165,6 +167,9 @@ int fork_usermode_driver(struct umd_info *info)
 	char **argv = NULL;
 	int err;
 
+	if (WARN_ON_ONCE(info->tgid))
+		return -EBUSY;
+
 	err = -ENOMEM;
 	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
 	if (!argv)
@@ -192,11 +197,11 @@ EXPORT_SYMBOL_GPL(fork_usermode_driver);
 void __exit_umh(struct task_struct *tsk)
 {
 	struct umd_info *info;
-	pid_t pid = tsk->pid;
+	struct pid *tgid = task_tgid(tsk);
 
 	mutex_lock(&umh_list_lock);
 	list_for_each_entry(info, &umh_list, list) {
-		if (info->pid == pid) {
+		if (info->tgid == tgid) {
 			list_del(&info->list);
 			mutex_unlock(&umh_list_lock);
 			goto out;
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 28883b00609d..b73dedeb6dbf 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -15,16 +15,13 @@ extern char bpfilter_umh_end;
 
 static void shutdown_umh(void)
 {
-	struct task_struct *tsk;
+	struct umd_info *info = &bpfilter_ops.info;
+	struct pid *tgid = info->tgid;
 
 	if (bpfilter_ops.stop)
 		return;
 
-	tsk = get_pid_task(find_vpid(bpfilter_ops.info.pid), PIDTYPE_PID);
-	if (tsk) {
-		send_sig(SIGKILL, tsk, 1);
-		put_task_struct(tsk);
-	}
+	kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
 }
 
 static void __stop_umh(void)
@@ -48,7 +45,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	req.cmd = optname;
 	req.addr = (long __force __user)optval;
 	req.len = optlen;
-	if (!bpfilter_ops.info.pid)
+	if (!bpfilter_ops.info.tgid)
 		goto out;
 	n = __kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
 			   &pos);
@@ -81,7 +78,7 @@ static int start_umh(void)
 	if (err)
 		return err;
 	bpfilter_ops.stop = false;
-	pr_info("Loaded bpfilter_umh pid %d\n", bpfilter_ops.info.pid);
+	pr_info("Loaded bpfilter_umh pid %d\n", pid_nr(bpfilter_ops.info.tgid));
 
 	/* health check that usermode process started correctly */
 	if (__bpfilter_process_sockopt(NULL, 0, NULL, 0, 0) != 0) {
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index 5050de28333d..56cbc43145f6 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -18,7 +18,8 @@ static void bpfilter_umh_cleanup(struct umd_info *info)
 	bpfilter_ops.stop = true;
 	fput(info->pipe_to_umh);
 	fput(info->pipe_from_umh);
-	info->pid = 0;
+	put_pid(info->tgid);
+	info->tgid = NULL;
 	mutex_unlock(&bpfilter_ops.lock);
 }
 
-- 
2.25.0

