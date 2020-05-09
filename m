Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2122A1CC438
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 21:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgEITpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 15:45:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42758 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgEITpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 15:45:55 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVQ1-0003mG-1E; Sat, 09 May 2020 13:45:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVPz-0006mp-VW; Sat, 09 May 2020 13:45:52 -0600
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
Date:   Sat, 09 May 2020 14:42:23 -0500
In-Reply-To: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 09 May 2020 14:40:17 -0500")
Message-ID: <878si0zyhs.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVPz-0006mp-VW;;;mid=<878si0zyhs.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+WaFjsADm08u5UbPlcu3GHSSNgJl9oWdE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 529 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 14 (2.7%), b_tie_ro: 12 (2.3%), parse: 1.80
        (0.3%), extract_message_metadata: 20 (3.7%), get_uri_detail_list: 2.8
        (0.5%), tests_pri_-1000: 23 (4.3%), tests_pri_-950: 2.3 (0.4%),
        tests_pri_-900: 1.96 (0.4%), tests_pri_-90: 101 (19.1%), check_bayes:
        98 (18.6%), b_tokenize: 13 (2.4%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 3.2 (0.6%), b_tok_touch_all: 69 (13.1%), b_finish: 1.42
        (0.3%), tests_pri_0: 350 (66.2%), check_dkim_signature: 1.06 (0.2%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/5] exec: Allow load_misc_binary to call prepare_binfmt unconditionally
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Add a flag preserve_creds that binfmt_misc can set to prevent
credentials from being updated.  This allows binfmrt_misc to always
call prepare_binfmt.  Allowing the credential computation logic to be
consolidated.

Ref: c407c033de84 ("[PATCH] binfmt_misc: improve calculation of interpreter's credentials")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_misc.c        | 15 +++------------
 fs/exec.c               | 14 +++++++++-----
 include/linux/binfmts.h |  2 ++
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 127fae9c21ab..16bfafd2671d 100644
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
index 8bbf5fa785a6..01dbeb025c46 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1630,14 +1630,18 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
  */
 int prepare_binprm(struct linux_binprm *bprm)
 {
-	int retval;
 	loff_t pos = 0;
 
-	bprm_fill_uid(bprm);
+	if (!bprm->preserve_creds) {
+		int retval;
 
-	retval = cap_bprm_set_creds(bprm);
-	if (retval)
-		return retval;
+		bprm_fill_uid(bprm);
+
+		retval = cap_bprm_set_creds(bprm);
+		if (retval)
+			return retval;
+	}
+	bprm->preserve_creds = 0;
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 89f1135dcb75..cb016f001e7a 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -26,6 +26,8 @@ struct linux_binprm {
 	unsigned long p; /* current top of mem */
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
+		/* Don't update the creds for an interpreter (see binfmt_misc) */
+		preserve_creds:1,
 		/*
 		 * True if most recent call to the commoncaps bprm_set_creds
 		 * hook (due to multiple prepare_binprm() calls from the
-- 
2.25.0

