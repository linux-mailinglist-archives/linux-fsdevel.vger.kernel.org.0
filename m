Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124411CB793
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHSrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 14:47:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53562 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHSrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 14:47:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX82F-0001Dp-NB; Fri, 08 May 2020 12:47:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX82F-0002qd-2G; Fri, 08 May 2020 12:47:47 -0600
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
Date:   Fri, 08 May 2020 13:44:19 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87mu6i6zcs.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX82F-0002qd-2G;;;mid=<87mu6i6zcs.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18wYKPEvakFJCUELsQOPDMEKQPVyGLjgUg=
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
X-Spam-Timing: total 281 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (4.1%), b_tie_ro: 10 (3.6%), parse: 0.96
        (0.3%), extract_message_metadata: 12 (4.3%), get_uri_detail_list: 1.20
        (0.4%), tests_pri_-1000: 13 (4.7%), tests_pri_-950: 1.22 (0.4%),
        tests_pri_-900: 0.98 (0.4%), tests_pri_-90: 47 (16.7%), check_bayes:
        45 (16.2%), b_tokenize: 6 (2.1%), b_tok_get_all: 6 (2.1%),
        b_comp_prob: 1.86 (0.7%), b_tok_touch_all: 29 (10.2%), b_finish: 0.88
        (0.3%), tests_pri_0: 181 (64.4%), check_dkim_signature: 0.48 (0.2%),
        check_dkim_adsp: 2.2 (0.8%), poll_dns_idle: 0.49 (0.2%), tests_pri_10:
        2.8 (1.0%), tests_pri_500: 7 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/6] exec: Move the comment from above de_thread to above unshare_sighand
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The comment describes work that now happens in unshare_sighand so
move the comment where it makes sense.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3cc40048cc65..d4387bc92292 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1093,12 +1093,6 @@ static int exec_mmap(struct mm_struct *mm)
 	return 0;
 }
 
-/*
- * This function makes sure the current process has its own signal table,
- * so that flush_signal_handlers can later reset the handlers without
- * disturbing other processes.  (Other processes might share the signal
- * table via the CLONE_SIGHAND option to clone().)
- */
 static int de_thread(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
@@ -1240,6 +1234,12 @@ static int de_thread(struct task_struct *tsk)
 }
 
 
+/*
+ * This function makes sure the current process has its own signal table,
+ * so that flush_signal_handlers can later reset the handlers without
+ * disturbing other processes.  (Other processes might share the signal
+ * table via the CLONE_SIGHAND option to clone().)
+ */
 static int unshare_sighand(struct task_struct *me)
 {
 	struct sighand_struct *oldsighand = me->sighand;
-- 
2.20.1

