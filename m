Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256DE1CB797
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEHSsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 14:48:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54612 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgEHSsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 14:48:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX83I-0005SA-Sr; Fri, 08 May 2020 12:48:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX83I-0002xa-4g; Fri, 08 May 2020 12:48:52 -0600
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
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
Date:   Fri, 08 May 2020 13:45:25 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX83I-0002xa-4g;;;mid=<87blmy6zay.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/M8xbipLE7+kJXgkEYUSylu3e6cNqDnCs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 299 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (1.2%), b_tie_ro: 2.5 (0.9%), parse: 0.74
        (0.2%), extract_message_metadata: 9 (2.9%), get_uri_detail_list: 0.86
        (0.3%), tests_pri_-1000: 11 (3.5%), tests_pri_-950: 1.01 (0.3%),
        tests_pri_-900: 0.81 (0.3%), tests_pri_-90: 62 (20.7%), check_bayes:
        61 (20.3%), b_tokenize: 5 (1.8%), b_tok_get_all: 5 (1.7%),
        b_comp_prob: 1.55 (0.5%), b_tok_touch_all: 46 (15.5%), b_finish: 0.63
        (0.2%), tests_pri_0: 202 (67.6%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.3 (0.8%), poll_dns_idle: 0.92 (0.3%), tests_pri_10:
        1.77 (0.6%), tests_pri_500: 5 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/6] exec: Stop open coding mutex_lock_killable of cred_guard_mutex
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Oleg modified the code that did
"mutex_lock_interruptible(&current->cred_guard_mutex)" to return
-ERESTARTNOINTR instead of -EINTR, so that userspace will never see a
failure to grab the mutex.

Slightly earlier Liam R. Howlett defined mutex_lock_killable for
exactly the same situation but it does it a little more cleanly.

Switch the code to mutex_lock_killable so that it is clearer what the
code is doing.

Ref: ad776537cc6b ("Add mutex_lock_killable")
Ref: 793285fcafce ("cred_guard_mutex: do not return -EINTR to user-space")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c       | 5 +++--
 kernel/ptrace.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 82106241ed53..11a5c073aa35 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1493,8 +1493,9 @@ EXPORT_SYMBOL(finalize_exec);
  */
 static int prepare_bprm_creds(struct linux_binprm *bprm)
 {
-	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
-		return -ERESTARTNOINTR;
+	int retval = mutex_lock_killable(&current->signal->cred_guard_mutex);
+	if (retval)
+		return retval;
 
 	bprm->cred = prepare_exec_creds();
 	if (likely(bprm->cred))
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..1876b3392488 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -391,8 +391,8 @@ static int ptrace_attach(struct task_struct *task, long request,
 	 * SUID, SGID and LSM creds get determined differently
 	 * under ptrace.
 	 */
-	retval = -ERESTARTNOINTR;
-	if (mutex_lock_interruptible(&task->signal->cred_guard_mutex))
+	retval = mutex_lock_killable(&task->signal->cred_guard_mutex);
+	if (retval)
 		goto out;
 
 	task_lock(task);
-- 
2.20.1

