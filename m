Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EB20DADC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgF2UBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:01:14 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33746 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgF2UBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:01:12 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpzxn-0002lW-5c; Mon, 29 Jun 2020 14:01:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpzxl-0003O1-TR; Mon, 29 Jun 2020 14:01:10 -0600
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
Date:   Mon, 29 Jun 2020 14:56:38 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <875zb97iix.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jpzxl-0003O1-TR;;;mid=<875zb97iix.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rW0kJ/Nu0di7F1+PvK/unH2VPrQ43lAM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 865 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 9 (1.0%), parse: 0.79 (0.1%),
         extract_message_metadata: 13 (1.4%), get_uri_detail_list: 1.38 (0.2%),
         tests_pri_-1000: 23 (2.6%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.92 (0.1%), tests_pri_-90: 137 (15.8%), check_bayes:
        135 (15.7%), b_tokenize: 8 (1.0%), b_tok_get_all: 7 (0.8%),
        b_comp_prob: 2.0 (0.2%), b_tok_touch_all: 115 (13.3%), b_finish: 0.87
        (0.1%), tests_pri_0: 671 (77.5%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 1.65 (0.2%), poll_dns_idle: 0.22 (0.0%),
        tests_pri_10: 1.76 (0.2%), tests_pri_500: 5 (0.6%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v2 01/15] umh: Capture the pid in umh_pipe_setup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The pid in struct subprocess_info is only used by umh_clean_and_save_pid to
write the pid into umh_info.

Instead always capture the pid on struct umh_info in umh_pipe_setup, removing
code that is specific to user mode drivers from the common user path of
user mode helpers.

Link: https://lkml.kernel.org/r/87h7uygf9i.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/umh.h | 1 -
 kernel/umh.c        | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 0c08de356d0d..aae16a0ebd0f 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -25,7 +25,6 @@ struct subprocess_info {
 	struct file *file;
 	int wait;
 	int retval;
-	pid_t pid;
 	int (*init)(struct subprocess_info *info, struct cred *new);
 	void (*cleanup)(struct subprocess_info *info);
 	void *data;
diff --git a/kernel/umh.c b/kernel/umh.c
index 79f139a7ca03..c2a582b3a2bf 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -102,7 +102,6 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	sub_info->pid = task_pid_nr(current);
 	if (sub_info->file) {
 		retval = do_execve_file(sub_info->file,
 					sub_info->argv, sub_info->envp);
@@ -468,6 +467,7 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 
 	umh_info->pipe_to_umh = to_umh[1];
 	umh_info->pipe_from_umh = from_umh[0];
+	umh_info->pid = task_pid_nr(current);
 	return 0;
 }
 
@@ -476,13 +476,12 @@ static void umh_clean_and_save_pid(struct subprocess_info *info)
 	struct umh_info *umh_info = info->data;
 
 	/* cleanup if umh_pipe_setup() was successful but exec failed */
-	if (info->pid && info->retval) {
+	if (info->retval) {
 		fput(umh_info->pipe_to_umh);
 		fput(umh_info->pipe_from_umh);
 	}
 
 	argv_free(info->argv);
-	umh_info->pid = info->pid;
 }
 
 /**
-- 
2.25.0

