Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7020DB73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbgF2UGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:06:35 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35920 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388859AbgF2UGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:06:32 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq02t-0003N6-VO; Mon, 29 Jun 2020 14:06:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq02s-0000GO-Gg; Mon, 29 Jun 2020 14:06:27 -0600
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
Date:   Mon, 29 Jun 2020 15:01:55 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <878sg563po.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq02s-0000GO-Gg;;;mid=<878sg563po.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xzYzSGIoZRKG59bBBeB+kZ2XZYfxfOB4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1035 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.0%), b_tie_ro: 9 (0.9%), parse: 1.02 (0.1%),
         extract_message_metadata: 15 (1.4%), get_uri_detail_list: 2.6 (0.3%),
        tests_pri_-1000: 24 (2.3%), tests_pri_-950: 1.15 (0.1%),
        tests_pri_-900: 0.99 (0.1%), tests_pri_-90: 287 (27.7%), check_bayes:
        286 (27.6%), b_tokenize: 12 (1.2%), b_tok_get_all: 8 (0.8%),
        b_comp_prob: 2.6 (0.3%), b_tok_touch_all: 259 (25.1%), b_finish: 0.65
        (0.1%), tests_pri_0: 685 (66.2%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        1.75 (0.2%), tests_pri_500: 5 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 06/15] umd: For clarity rename umh_info umd_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This structure is only used for user mode drivers so change
the prefix from umh to umd to make that clear.

Link: https://lkml.kernel.org/r/87o8p6f0kw.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/bpfilter.h    |  2 +-
 include/linux/umd.h         |  6 +++---
 kernel/umd.c                | 20 ++++++++++----------
 net/ipv4/bpfilter/sockopt.c |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index b42e44e29033..4b43d2240172 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -11,7 +11,7 @@ int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
 int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 			    int __user *optlen);
 struct bpfilter_umh_ops {
-	struct umh_info info;
+	struct umd_info info;
 	/* since ip_getsockopt() can run in parallel, serialize access to umh */
 	struct mutex lock;
 	int (*sockopt)(struct sock *sk, int optname,
diff --git a/include/linux/umd.h b/include/linux/umd.h
index ef40bee590c1..58a9c603c78d 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -17,14 +17,14 @@ static inline void exit_umh(struct task_struct *tsk)
 }
 #endif
 
-struct umh_info {
+struct umd_info {
 	const char *cmdline;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
 	struct list_head list;
-	void (*cleanup)(struct umh_info *info);
+	void (*cleanup)(struct umd_info *info);
 	pid_t pid;
 };
-int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
+int fork_usermode_blob(void *data, size_t len, struct umd_info *info);
 
 #endif /* __LINUX_UMD_H__ */
diff --git a/kernel/umd.c b/kernel/umd.c
index 99af9d594eca..f7dacb19c705 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -11,7 +11,7 @@ static DEFINE_MUTEX(umh_list_lock);
 
 static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
-	struct umh_info *umh_info = info->data;
+	struct umd_info *umd_info = info->data;
 	struct file *from_umh[2];
 	struct file *to_umh[2];
 	int err;
@@ -43,21 +43,21 @@ static int umd_setup(struct subprocess_info *info, struct cred *new)
 		return err;
 	}
 
-	umh_info->pipe_to_umh = to_umh[1];
-	umh_info->pipe_from_umh = from_umh[0];
-	umh_info->pid = task_pid_nr(current);
+	umd_info->pipe_to_umh = to_umh[1];
+	umd_info->pipe_from_umh = from_umh[0];
+	umd_info->pid = task_pid_nr(current);
 	current->flags |= PF_UMH;
 	return 0;
 }
 
 static void umd_cleanup(struct subprocess_info *info)
 {
-	struct umh_info *umh_info = info->data;
+	struct umd_info *umd_info = info->data;
 
 	/* cleanup if umh_setup() was successful but exec failed */
 	if (info->retval) {
-		fput(umh_info->pipe_to_umh);
-		fput(umh_info->pipe_from_umh);
+		fput(umd_info->pipe_to_umh);
+		fput(umd_info->pipe_from_umh);
 	}
 }
 
@@ -72,12 +72,12 @@ static void umd_cleanup(struct subprocess_info *info)
  *
  * Returns either negative error or zero which indicates success
  * in executing a blob of bytes as a usermode process. In such
- * case 'struct umh_info *info' is populated with two pipes
+ * case 'struct umd_info *info' is populated with two pipes
  * and a pid of the process. The caller is responsible for health
  * check of the user process, killing it via pid, and closing the
  * pipes when user process is no longer needed.
  */
-int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
+int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 {
 	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(fork_usermode_blob);
 
 void __exit_umh(struct task_struct *tsk)
 {
-	struct umh_info *info;
+	struct umd_info *info;
 	pid_t pid = tsk->pid;
 
 	mutex_lock(&umh_list_lock);
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index 0480918bfc7c..c0dbcc86fcdb 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -12,7 +12,7 @@
 struct bpfilter_umh_ops bpfilter_ops;
 EXPORT_SYMBOL_GPL(bpfilter_ops);
 
-static void bpfilter_umh_cleanup(struct umh_info *info)
+static void bpfilter_umh_cleanup(struct umd_info *info)
 {
 	mutex_lock(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
-- 
2.25.0

