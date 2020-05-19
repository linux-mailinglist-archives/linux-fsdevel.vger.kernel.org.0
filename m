Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFE1D8C61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 02:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgESAfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 20:35:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37512 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESAfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 20:35:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqEG-0000Vb-7M; Mon, 18 May 2020 18:35:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqEF-0003a2-Dh; Mon, 18 May 2020 18:35:32 -0600
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
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 18 May 2020 19:31:51 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87imgszrwo.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqEF-0003a2-Dh;;;mid=<87imgszrwo.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+zSDC+oPj2CKUq9mJvOsL3qCDQjL7cYcM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 403 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.8 (0.9%), b_tie_ro: 2.6 (0.6%), parse: 1.17
        (0.3%), extract_message_metadata: 11 (2.8%), get_uri_detail_list: 2.3
        (0.6%), tests_pri_-1000: 11 (2.7%), tests_pri_-950: 1.03 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 64 (15.9%), check_bayes:
        63 (15.6%), b_tokenize: 7 (1.8%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 1.78 (0.4%), b_tok_touch_all: 46 (11.4%), b_finish: 0.63
        (0.2%), tests_pri_0: 298 (73.9%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.6 (0.7%), poll_dns_idle: 1.29 (0.3%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 4/8] exec: Allow load_misc_binary to call prepare_binfmt unconditionally
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Add a flag preserve_creds that binfmt_misc can set to prevent
credentials from being updated.  This allows binfmt_misc to always
call prepare_binfmt.  Allowing the credential computation logic to be
consolidated.

Not replacing the credentials with the interpreters credentials is
safe because because an open file descriptor to the executable is
passed to the interpreter.   As the interpreter does not need to
reopen the executable it is guaranteed to see the same file that
exec sees.

Ref: c407c033de84 ("[PATCH] binfmt_misc: improve calculation of interpreter's credentials")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_misc.c        | 15 +++------------
 fs/exec.c               | 19 ++++++++++++-------
 include/linux/binfmts.h |  2 ++
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cdb45829354d..264829745d6f 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -218,19 +218,10 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		goto error;
 
 	bprm->file = interp_file;
-	if (fmt->flags & MISC_FMT_CREDENTIALS) {
-		loff_t pos = 0;
-
-		/*
-		 * No need to call prepare_binprm(), it's already been
-		 * done.  bprm->buf is stale, update from interp_file.
-		 */
-		memset(bprm->buf, 0, BINPRM_BUF_SIZE);
-		retval = kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE,
-				&pos);
-	} else
-		retval = prepare_binprm(bprm);
+	if (fmt->flags & MISC_FMT_CREDENTIALS)
+		bprm->preserve_creds = 1;
 
+	retval = prepare_binprm(bprm);
 	if (retval < 0)
 		goto error;
 
diff --git a/fs/exec.c b/fs/exec.c
index 8e3b93d51d31..028e0e323af5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1631,15 +1631,20 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
  */
 int prepare_binprm(struct linux_binprm *bprm)
 {
-	int retval;
 	loff_t pos = 0;
 
-	/* Recompute parts of bprm->cred based on bprm->file */
-	bprm->active_secureexec = 0;
-	bprm_fill_uid(bprm);
-	retval = security_bprm_repopulate_creds(bprm);
-	if (retval)
-		return retval;
+	/* Can the interpreter get to the executable without races? */
+	if (!bprm->preserve_creds) {
+		int retval;
+
+		/* Recompute parts of bprm->cred based on bprm->file */
+		bprm->active_secureexec = 0;
+		bprm_fill_uid(bprm);
+		retval = security_bprm_repopulate_creds(bprm);
+		if (retval)
+			return retval;
+	}
+	bprm->preserve_creds = 0;
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8605ab4a0f89..dbb5614d62a2 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,6 +26,8 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
+		/* It is safe to use the creds of a script (see binfmt_misc) */
+		preserve_creds:1,
 		/*
 		 * True if most recent call to security_bprm_set_creds
 		 * resulted in elevated privileges.
-- 
2.25.0

