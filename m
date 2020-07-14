Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8D21F297
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGNNbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:31:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48418 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:31:33 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL1w-0007RF-BS; Tue, 14 Jul 2020 07:31:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL1v-0006Xu-HX; Tue, 14 Jul 2020 07:31:32 -0600
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
Date:   Tue, 14 Jul 2020 08:28:42 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87v9iq6x9x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL1v-0006Xu-HX;;;mid=<87v9iq6x9x.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+L9NFh+ZPsxXvjHVAolHu7lSRa9Zwp4L0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 436 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.8%), b_tie_ro: 2.5 (0.6%), parse: 0.96
        (0.2%), extract_message_metadata: 17 (3.9%), get_uri_detail_list: 1.21
        (0.3%), tests_pri_-1000: 27 (6.1%), tests_pri_-950: 1.43 (0.3%),
        tests_pri_-900: 1.18 (0.3%), tests_pri_-90: 122 (27.9%), check_bayes:
        119 (27.2%), b_tokenize: 9 (2.1%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 98 (22.5%), b_finish: 0.66
        (0.2%), tests_pri_0: 253 (58.0%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        1.79 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/7] exec: Remove unnecessary spaces from binfmts.h
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The general convention in the linux kernel is to define a pointer
member as "type *name".  The declaration of struct linux_binprm has
several pointer defined as "type * name".  Update them to the
form of "type *name" for consistency.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/binfmts.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 7c27d7b57871..eb5cb8df5485 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -45,15 +45,15 @@ struct linux_binprm {
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-	struct file * executable; /* Executable to pass to the interpreter */
-	struct file * interpreter;
-	struct file * file;
+	struct file *executable; /* Executable to pass to the interpreter */
+	struct file *interpreter;
+	struct file *file;
 	struct cred *cred;	/* new credentials */
 	int unsafe;		/* how unsafe this exec is (mask of LSM_UNSAFE_*) */
 	unsigned int per_clear;	/* bits to clear in current->personality */
 	int argc, envc;
-	const char * filename;	/* Name of binary as seen by procps */
-	const char * interp;	/* Name of the binary really executed. Most
+	const char *filename;	/* Name of binary as seen by procps */
+	const char *interp;	/* Name of the binary really executed. Most
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	unsigned interp_flags;
-- 
2.25.0

