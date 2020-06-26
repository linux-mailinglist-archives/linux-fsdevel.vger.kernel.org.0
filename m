Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4820B1E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgFZM7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 08:59:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37722 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZM7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:59:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonwh-0000xk-6F; Fri, 26 Jun 2020 06:59:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jonwf-0003Cb-CG; Fri, 26 Jun 2020 06:59:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 26 Jun 2020 07:54:38 -0500
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 07:51:41 -0500")
Message-ID: <87zh8qf0mp.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jonwf-0003Cb-CG;;;mid=<87zh8qf0mp.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+HsWqH4+X3F/PIqsWxPmr9tnxY0FwhXvU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,T_TooManySym_02,
        XMGappySubj_01,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1435 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 14 (1.0%), b_tie_ro: 12 (0.8%), parse: 2.2 (0.2%),
         extract_message_metadata: 20 (1.4%), get_uri_detail_list: 3.2 (0.2%),
        tests_pri_-1000: 21 (1.5%), tests_pri_-950: 1.78 (0.1%),
        tests_pri_-900: 1.42 (0.1%), tests_pri_-90: 69 (4.8%), check_bayes: 67
        (4.7%), b_tokenize: 14 (1.0%), b_tok_get_all: 8 (0.6%), b_comp_prob:
        2.8 (0.2%), b_tok_touch_all: 38 (2.7%), b_finish: 1.15 (0.1%),
        tests_pri_0: 1287 (89.7%), check_dkim_signature: 1.06 (0.1%),
        check_dkim_adsp: 3.5 (0.2%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 11 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 04/14] umh: Remove call_usermodehelper_setup_file.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The only caller of call_usermodehelper_setup_file is fork_usermode_blob.
In fork_usermode_blob replace call_usermodehelper_setup_file with
call_usermodehelper_setup and delete fork_usermodehelper_setup_file.

For this to work the argv_free is moved from umh_clean_and_save_pid
to fork_usermode_blob.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umh.h |  3 ---
 kernel/umh.c        | 42 +++++++++++-------------------------------
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index aae16a0ebd0f..de08af00c68a 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -39,9 +39,6 @@ call_usermodehelper_setup(const char *path, char **argv, char **envp,
 			  int (*init)(struct subprocess_info *info, struct cred *new),
 			  void (*cleanup)(struct subprocess_info *), void *data);
 
-struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
-			  int (*init)(struct subprocess_info *info, struct cred *new),
-			  void (*cleanup)(struct subprocess_info *), void *data);
 struct umh_info {
 	const char *cmdline;
 	struct file *pipe_to_umh;
diff --git a/kernel/umh.c b/kernel/umh.c
index 0ffe0a08cdde..14d63b5f29a7 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -402,33 +402,6 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
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
 static int umd_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct umh_info *umh_info = info->data;
@@ -479,8 +452,6 @@ static void umd_cleanup(struct subprocess_info *info)
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
 	}
-
-	argv_free(info->argv);
 }
 
 /**
@@ -501,7 +472,9 @@ static void umd_cleanup(struct subprocess_info *info)
  */
 int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 {
+	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
+	char **argv = NULL;
 	struct file *file;
 	ssize_t written;
 	loff_t pos = 0;
@@ -520,11 +493,16 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 	}
 
 	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup_file(file, umd_setup, umd_cleanup,
-						  info);
+	argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	if (!argv)
+		goto out;
+
+	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
+					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
 
+	sub_info->file = file;
 	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
 	if (!err) {
 		mutex_lock(&umh_list_lock);
@@ -532,6 +510,8 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 		mutex_unlock(&umh_list_lock);
 	}
 out:
+	if (argv)
+		argv_free(argv);
 	fput(file);
 	return err;
 }
-- 
2.25.0

