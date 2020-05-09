Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3295B1CC43B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgEITqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 15:46:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53778 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEITqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 15:46:22 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVQT-00010n-JQ; Sat, 09 May 2020 13:46:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVQS-0001AK-Ni; Sat, 09 May 2020 13:46:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
Date:   Sat, 09 May 2020 14:42:52 -0500
In-Reply-To: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 09 May 2020 14:40:17 -0500")
Message-ID: <873688zygz.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVQS-0001AK-Ni;;;mid=<873688zygz.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+OrFdAy5/7YXr8d4/LPpD0UxlU62AvuFQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 467 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.95 (0.2%),
         extract_message_metadata: 12 (2.5%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 13 (2.9%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 65 (14.0%), check_bayes:
        64 (13.7%), b_tokenize: 11 (2.3%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 39 (8.4%), b_finish: 0.78
        (0.2%), tests_pri_0: 346 (74.1%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.67 (0.1%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 12 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/5] exec: Move the call of prepare_binprm into search_binary_handler
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The code in prepare_binary_handler needs to be run every time
search_binary_handler is called so move the call into search_binary_handler
itself to make the code simpler and easier to understand.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/binfmt_loader.c |  3 ---
 fs/binfmt_em86.c                  |  5 -----
 fs/binfmt_misc.c                  |  4 ----
 fs/binfmt_script.c                |  3 ---
 fs/exec.c                         | 12 +++++-------
 include/linux/binfmts.h           |  1 -
 6 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/kernel/binfmt_loader.c b/arch/alpha/kernel/binfmt_loader.c
index a90c8b1d5498..ec7b26e4b81a 100644
--- a/arch/alpha/kernel/binfmt_loader.c
+++ b/arch/alpha/kernel/binfmt_loader.c
@@ -35,9 +35,6 @@ static int load_binary(struct linux_binprm *bprm)
 
 	bprm->file = file;
 	bprm->loader = loader;
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		return retval;
 	return 1; /* Search for the interpreter */
 }
 
diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index a9b9ac7f9bb0..2726bfb832b2 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -90,11 +90,6 @@ static int load_em86(struct linux_binprm *bprm)
 		return PTR_ERR(file);
 
 	bprm->file = file;
-
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		return retval;
-
 	return 1; /* Search for the interpreter */
 }
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 16bfafd2671d..6b5e67eed65e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -221,10 +221,6 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
 		bprm->preserve_creds = 1;
 
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		goto error;
-
 	retval = 1; /* Search for the interpreter */
 ret:
 	dput(fmt->dentry);
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 76a05696d376..ed4607c7095e 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -143,9 +143,6 @@ static int load_script(struct linux_binprm *bprm)
 		return PTR_ERR(file);
 
 	bprm->file = file;
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		return retval;
 	return 1; /* Search for the interpreter */
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index 01dbeb025c46..206f18120073 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1628,7 +1628,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
  *
  * This may be called multiple times for binary chains (scripts for example).
  */
-int prepare_binprm(struct linux_binprm *bprm)
+static int prepare_binprm(struct linux_binprm *bprm)
 {
 	loff_t pos = 0;
 
@@ -1647,8 +1647,6 @@ int prepare_binprm(struct linux_binprm *bprm)
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
 }
 
-EXPORT_SYMBOL(prepare_binprm);
-
 /*
  * Arguments are '\0' separated strings found at the location bprm->p
  * points to; chop off the first by relocating brpm->p to right after
@@ -1700,6 +1698,10 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	struct linux_binfmt *fmt;
 	int retval;
 
+	retval = prepare_binprm(bprm);
+	if (retval < 0)
+		return retval;
+
 	retval = security_bprm_check(bprm);
 	if (retval)
 		return retval;
@@ -1859,10 +1861,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval)
 		goto out;
 
-	retval = prepare_binprm(bprm);
-	if (retval < 0)
-		goto out;
-
 	retval = copy_strings_kernel(1, &bprm->filename, bprm);
 	if (retval < 0)
 		goto out;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index cb016f001e7a..0748afca40cb 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -117,7 +117,6 @@ static inline void insert_binfmt(struct linux_binfmt *fmt)
 
 extern void unregister_binfmt(struct linux_binfmt *);
 
-extern int prepare_binprm(struct linux_binprm *);
 extern int __must_check remove_arg_zero(struct linux_binprm *);
 extern int begin_new_exec(struct linux_binprm * bprm);
 extern void setup_new_exec(struct linux_binprm * bprm);
-- 
2.25.0

