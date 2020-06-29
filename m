Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B19F20DB7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgF2UHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:07:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36126 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgF2UHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:07:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq03P-0003QP-La; Mon, 29 Jun 2020 14:06:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq03O-00044y-HS; Mon, 29 Jun 2020 14:06:59 -0600
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
Date:   Mon, 29 Jun 2020 15:02:27 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87366d63os.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq03O-00044y-HS;;;mid=<87366d63os.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19gwZGq9LfYG7qMeJVaSLTCNUd+z0ghDAE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 752 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 13 (1.7%), b_tie_ro: 11 (1.4%), parse: 2.4 (0.3%),
         extract_message_metadata: 26 (3.4%), get_uri_detail_list: 4.6 (0.6%),
        tests_pri_-1000: 21 (2.8%), tests_pri_-950: 1.05 (0.1%),
        tests_pri_-900: 0.93 (0.1%), tests_pri_-90: 317 (42.1%), check_bayes:
        314 (41.8%), b_tokenize: 10 (1.3%), b_tok_get_all: 9 (1.2%),
        b_comp_prob: 2.5 (0.3%), b_tok_touch_all: 288 (38.3%), b_finish: 1.43
        (0.2%), tests_pri_0: 349 (46.4%), check_dkim_signature: 0.92 (0.1%),
        check_dkim_adsp: 2.2 (0.3%), poll_dns_idle: 0.37 (0.0%), tests_pri_10:
        4.4 (0.6%), tests_pri_500: 13 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 07/15] umd: Rename umd_info.cmdline umd_info.driver_name
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The only thing supplied in the cmdline today is the driver name so
rename the field to clarify the code.

As this value is always supplied stop trying to handle the case of
a NULL cmdline.

Additionally since we now have a name we can count on use the
driver_name any place where the code is looking for a name
of the binary.

Link: https://lkml.kernel.org/r/87imfef0k3.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umd.h         |  2 +-
 kernel/umd.c                | 11 ++++-------
 net/ipv4/bpfilter/sockopt.c |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/umd.h b/include/linux/umd.h
index 58a9c603c78d..d827fb038d00 100644
--- a/include/linux/umd.h
+++ b/include/linux/umd.h
@@ -18,7 +18,7 @@ static inline void exit_umh(struct task_struct *tsk)
 #endif
 
 struct umd_info {
-	const char *cmdline;
+	const char *driver_name;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
 	struct list_head list;
diff --git a/kernel/umd.c b/kernel/umd.c
index f7dacb19c705..7fe08a8eb231 100644
--- a/kernel/umd.c
+++ b/kernel/umd.c
@@ -67,9 +67,6 @@ static void umd_cleanup(struct subprocess_info *info)
  * @len: length of the blob
  * @info: information about usermode process (shouldn't be NULL)
  *
- * If info->cmdline is set it will be used as command line for the
- * user process, else "usermodehelper" is used.
- *
  * Returns either negative error or zero which indicates success
  * in executing a blob of bytes as a usermode process. In such
  * case 'struct umd_info *info' is populated with two pipes
@@ -79,7 +76,6 @@ static void umd_cleanup(struct subprocess_info *info)
  */
 int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 {
-	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
 	char **argv = NULL;
 	struct file *file;
@@ -87,7 +83,7 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	loff_t pos = 0;
 	int err;
 
-	file = shmem_kernel_file_setup("", len, 0);
+	file = shmem_kernel_file_setup(info->driver_name, len, 0);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
@@ -100,11 +96,12 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	}
 
 	err = -ENOMEM;
-	argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
 	if (!argv)
 		goto out;
 
-	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
+	sub_info = call_usermodehelper_setup(info->driver_name, argv, NULL,
+					     GFP_KERNEL,
 					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index c0dbcc86fcdb..5050de28333d 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -70,7 +70,7 @@ static int __init bpfilter_sockopt_init(void)
 {
 	mutex_init(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
-	bpfilter_ops.info.cmdline = "bpfilter_umh";
+	bpfilter_ops.info.driver_name = "bpfilter_umh";
 	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
 
 	return 0;
-- 
2.25.0

