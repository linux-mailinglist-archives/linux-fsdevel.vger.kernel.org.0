Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F84721F2B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgGNNd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:33:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52472 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgGNNdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:33:55 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL4D-0002gA-MW; Tue, 14 Jul 2020 07:33:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL4C-0005bi-PE; Tue, 14 Jul 2020 07:33:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
Date:   Tue, 14 Jul 2020 08:31:03 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87365u6x60.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL4C-0005bi-PE;;;mid=<87365u6x60.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+tYbnh3Q62SSMVnifjKF7zDyhQnXaMvYo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 416 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.3%), parse: 0.88 (0.2%),
         extract_message_metadata: 11 (2.6%), get_uri_detail_list: 1.18 (0.3%),
         tests_pri_-1000: 15 (3.5%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 112 (26.9%), check_bayes:
        110 (26.5%), b_tokenize: 8 (1.9%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 1.87 (0.5%), b_tok_touch_all: 90 (21.6%), b_finish: 0.96
        (0.2%), tests_pri_0: 252 (60.6%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.72 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/7] exec: Factor bprm_stack_limits out of prepare_arg_pages
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In preparation for implementiong kernel_execve (which will take kernel
pointers not userspace pointers) factor out bprm_stack_limits out of
prepare_arg_pages.  This separates the counting which depends upon the
getting data from userspace from the calculations of the stack limits
which is usable in kernel_execve.

The remove prepare_args_pages and compute bprm->argc and bprm->envc
directly in do_execveat_common, before bprm_stack_limits is called.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 50508892fa71..f8135dc149b3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -448,19 +448,10 @@ static int count(struct user_arg_ptr argv, int max)
 	return i;
 }
 
-static int prepare_arg_pages(struct linux_binprm *bprm,
-			struct user_arg_ptr argv, struct user_arg_ptr envp)
+static int bprm_stack_limits(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
 
-	bprm->argc = count(argv, MAX_ARG_STRINGS);
-	if (bprm->argc < 0)
-		return bprm->argc;
-
-	bprm->envc = count(envp, MAX_ARG_STRINGS);
-	if (bprm->envc < 0)
-		return bprm->envc;
-
 	/*
 	 * Limit to 1/4 of the max stack size or 3/4 of _STK_LIM
 	 * (whichever is smaller) for the argv+env strings.
@@ -1964,7 +1955,17 @@ static int do_execveat_common(int fd, struct filename *filename,
 		goto out_ret;
 	}
 
-	retval = prepare_arg_pages(bprm, argv, envp);
+	retval = count(argv, MAX_ARG_STRINGS);
+	if (retval < 0)
+		goto out_free;
+	bprm->argc = retval;
+
+	retval = count(envp, MAX_ARG_STRINGS);
+	if (retval < 0)
+		goto out_free;
+	bprm->envc = retval;
+
+	retval = bprm_stack_limits(bprm);
 	if (retval < 0)
 		goto out_free;
 
-- 
2.25.0

