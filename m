Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC07E1CC432
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgEITos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 15:44:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53504 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEITor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 15:44:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVOw-0000nF-GS; Sat, 09 May 2020 13:44:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVOv-0006Yo-Mw; Sat, 09 May 2020 13:44:46 -0600
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
Date:   Sat, 09 May 2020 14:41:17 -0500
In-Reply-To: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 09 May 2020 14:40:17 -0500")
Message-ID: <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVOv-0006Yo-Mw;;;mid=<87k11kzyjm.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AGw81UWuOF7eURcXUoWmPIIkBUcFGjcs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 453 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (3.2%), b_tie_ro: 12 (2.7%), parse: 1.13
        (0.2%), extract_message_metadata: 12 (2.7%), get_uri_detail_list: 2.4
        (0.5%), tests_pri_-1000: 13 (2.8%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 96 (21.3%), check_bayes:
        95 (20.9%), b_tokenize: 9 (2.0%), b_tok_get_all: 10 (2.1%),
        b_comp_prob: 3.0 (0.7%), b_tok_touch_all: 68 (15.1%), b_finish: 1.22
        (0.3%), tests_pri_0: 300 (66.1%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 1.09 (0.2%), tests_pri_10:
        3.5 (0.8%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Now that security_bprm_set_creds is no longer responsible for calling
cap_bprm_set_creds, security_bprm_set_creds only does something for
the primary file that is being executed (not any interpreters it may
have).  Therefore call security_bprm_set_creds from __do_execve_file,
instead of from prepare_binprm so that it is only called once, and
remove the now unnecessary called_set_creds field of struct binprm.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                  | 11 +++++------
 include/linux/binfmts.h    |  6 ------
 security/apparmor/domain.c |  3 ---
 security/selinux/hooks.c   |  2 --
 security/smack/smack_lsm.c |  3 ---
 security/tomoyo/tomoyo.c   |  6 ------
 6 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 765bfd51a546..635b5085050c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1635,12 +1635,6 @@ int prepare_binprm(struct linux_binprm *bprm)
 
 	bprm_fill_uid(bprm);
 
-	/* fill in binprm security blob */
-	retval = security_bprm_set_creds(bprm);
-	if (retval)
-		return retval;
-	bprm->called_set_creds = 1;
-
 	retval = cap_bprm_set_creds(bprm);
 	if (retval)
 		return retval;
@@ -1858,6 +1852,11 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval < 0)
 		goto out;
 
+	/* fill in binprm security blob */
+	retval = security_bprm_set_creds(bprm);
+	if (retval)
+		goto out;
+
 	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		goto out;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 1b48e2154766..42f760acfc2c 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,12 +26,6 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
-		/*
-		 * True after the bprm_set_creds hook has been called once
-		 * (multiple calls can be made via prepare_binprm() for
-		 * binfmt_script/misc).
-		 */
-		called_set_creds:1,
 		/*
 		 * True if most recent call to the commoncaps bprm_set_creds
 		 * hook (due to multiple prepare_binprm() calls from the
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 6ceb74e0f789..61b9181a9e1f 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -875,9 +875,6 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		file_inode(bprm->file)->i_mode
 	};
 
-	if (bprm->called_set_creds)
-		return 0;
-
 	ctx = task_ctx(current);
 	AA_BUG(!cred_label(bprm->cred));
 	AA_BUG(!ctx);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b77..ff3e1be53da5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2297,8 +2297,6 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
-	if (bprm->called_set_creds)
-		return 0;
 
 	old_tsec = selinux_cred(current_cred());
 	new_tsec = selinux_cred(bprm->cred);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8c61d175e195..bd1967730fec 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -904,9 +904,6 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	struct superblock_smack *sbsp;
 	int rc;
 
-	if (bprm->called_set_creds)
-		return 0;
-
 	isp = smack_inode(inode);
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92ec941a..d965ce80a7fb 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -71,12 +71,6 @@ static void tomoyo_bprm_committed_creds(struct linux_binprm *bprm)
  */
 static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 {
-	/*
-	 * Do only if this function is called for the first time of an execve
-	 * operation.
-	 */
-	if (bprm->called_set_creds)
-		return 0;
 	/*
 	 * Load policy if /sbin/tomoyo-init exists and /sbin/init is requested
 	 * for the first time.
-- 
2.25.0

