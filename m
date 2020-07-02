Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB9212A38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGBQsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:48:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40794 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgGBQsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:48:38 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2O5-000260-NZ; Thu, 02 Jul 2020 10:48:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2Nl-0007up-A6; Thu, 02 Jul 2020 10:48:18 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  2 Jul 2020 11:41:37 -0500
Message-Id: <20200702164140.4468-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2Nl-0007up-A6;;;mid=<20200702164140.4468-13-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19HmRhPZpVcthqXrkTnKi3I8QVAgMh9DzI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4921]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 418 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.92 (0.2%),
         extract_message_metadata: 11 (2.6%), get_uri_detail_list: 1.73 (0.4%),
         tests_pri_-1000: 14 (3.4%), tests_pri_-950: 1.16 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 71 (16.9%), check_bayes:
        69 (16.6%), b_tokenize: 10 (2.3%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 46 (11.1%), b_finish: 0.78
        (0.2%), tests_pri_0: 285 (68.3%), check_dkim_signature: 0.69 (0.2%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.43 (0.1%), tests_pri_10:
        3.7 (0.9%), tests_pri_500: 17 (4.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 13/16] exit: Factor thread_group_exited out of pidfd_poll
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create an independent helper thread_group_exited report return true
when all threads have passed exit_notify in do_exit.  AKA all of the
threads are at least zombies and might be dead or completely gone.

Create this helper by taking the logic out of pidfd_poll where
it is already tested, and adding a missing READ_ONCE on
the read of task->exit_state.

I will be changing the user mode driver code to use this same logic
to know when a user mode driver needs to be restarted.

Place the new helper thread_group_exited in kernel/exit.c and
EXPORT it so it can be used by modules.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  2 ++
 kernel/exit.c                | 24 ++++++++++++++++++++++++
 kernel/fork.c                |  6 +-----
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0ee5e696c5d8..1bad18a1d8ba 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -674,6 +674,8 @@ static inline int thread_group_empty(struct task_struct *p)
 #define delay_group_leader(p) \
 		(thread_group_leader(p) && !thread_group_empty(p))
 
+extern bool thread_group_exited(struct pid *pid);
+
 extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
 							unsigned long *flags);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index d3294b611df1..a7f112feb0f6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1713,6 +1713,30 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 }
 #endif
 
+/**
+ * thread_group_exited - check that a thread group has exited
+ * @pid: tgid of thread group to be checked.
+ *
+ * Test if thread group is has exited (all threads are zombies, dead
+ * or completely gone).
+ *
+ * Return: true if the thread group has exited. false otherwise.
+ */
+bool thread_group_exited(struct pid *pid)
+{
+	struct task_struct *task;
+	bool exited;
+
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	exited = !task ||
+		(READ_ONCE(task->exit_state) && thread_group_empty(task));
+	rcu_read_unlock();
+
+	return exited;
+}
+EXPORT_SYMBOL(thread_group_exited);
+
 __weak void abort(void)
 {
 	BUG();
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..bf215af7a904 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1787,22 +1787,18 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
  */
 static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
-	struct task_struct *task;
 	struct pid *pid = file->private_data;
 	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
 
-	rcu_read_lock();
-	task = pid_task(pid, PIDTYPE_PID);
 	/*
 	 * Inform pollers only when the whole thread group exits.
 	 * If the thread group leader exits before all other threads in the
 	 * group, then poll(2) should block, similar to the wait(2) family.
 	 */
-	if (!task || (task->exit_state && thread_group_empty(task)))
+	if (thread_group_exited(pid))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
-	rcu_read_unlock();
 
 	return poll_flags;
 }
-- 
2.25.0

