Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372421C613C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgEETqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 15:46:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55434 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgEETqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 15:46:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3W0-00087g-7W; Tue, 05 May 2020 13:46:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Vm-0003u4-HF; Tue, 05 May 2020 13:46:03 -0600
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
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
Date:   Tue, 05 May 2020 14:42:26 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87zhami2xp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Vm-0003u4-HF;;;mid=<87zhami2xp.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+97DPrkHwEDW6vjLYFCW03Ty/3N9zNyBk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 8 (1.7%), b_tie_ro: 7 (1.4%), parse: 0.87 (0.2%),
        extract_message_metadata: 10 (2.2%), get_uri_detail_list: 1.22 (0.3%),
        tests_pri_-1000: 13 (2.8%), tests_pri_-950: 1.16 (0.3%),
        tests_pri_-900: 0.95 (0.2%), tests_pri_-90: 122 (26.6%), check_bayes:
        121 (26.3%), b_tokenize: 7 (1.4%), b_tok_get_all: 4.8 (1.0%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 104 (22.6%), b_finish: 0.92
        (0.2%), tests_pri_0: 293 (63.7%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.58 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/7] exec: Rename the flag called_exec_mmap point_of_no_return
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Update the comments and make the code easier to understand by
renaming this flag.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c               | 12 ++++++------
 include/linux/binfmts.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6bd82a007bfc..71de9f57ae09 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1326,12 +1326,12 @@ int flush_old_exec(struct linux_binprm * bprm)
 		goto out;
 
 	/*
-	 * After setting bprm->called_exec_mmap (to mark that current is
-	 * using the prepared mm now), we have nothing left of the original
-	 * process. If anything from here on returns an error, the check
-	 * in search_binary_handler() will SEGV current.
+	 * With the new mm installed it is completely impossible to
+	 * fail and return to the original process.  If anything from
+	 * here on returns an error, the check in
+	 * search_binary_handler() will SEGV current.
 	 */
-	bprm->called_exec_mmap = 1;
+	bprm->point_of_no_return = true;
 	bprm->mm = NULL;
 
 #ifdef CONFIG_POSIX_TIMERS
@@ -1720,7 +1720,7 @@ int search_binary_handler(struct linux_binprm *bprm)
 
 		read_lock(&binfmt_lock);
 		put_binfmt(fmt);
-		if (retval < 0 && bprm->called_exec_mmap) {
+		if (retval < 0 && bprm->point_of_no_return) {
 			/* we got to flush_old_exec() and failed after it */
 			read_unlock(&binfmt_lock);
 			force_sigsegv(SIGSEGV);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 6f564b9ad882..8f479dad7931 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -46,10 +46,10 @@ struct linux_binprm {
 		 */
 		secureexec:1,
 		/*
-		 * Set by flush_old_exec, when exec_mmap has been called.
-		 * This is past the point of no return.
+		 * Set when errors can no longer be returned to the
+		 * original userspace.
 		 */
-		called_exec_mmap:1;
+		point_of_no_return:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
2.20.1

