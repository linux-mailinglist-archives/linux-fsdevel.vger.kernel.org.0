Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721781CB79B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHStZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 14:49:25 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38412 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHStZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 14:49:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX83n-00046H-SA; Fri, 08 May 2020 12:49:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX83n-00031t-5l; Fri, 08 May 2020 12:49:23 -0600
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
Date:   Fri, 08 May 2020 13:45:56 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <875zd66za3.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX83n-00031t-5l;;;mid=<875zd66za3.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AXon5dcUfjuMt0Bp8k9tiBqs0tFK9Qcg=
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
X-Spam-Timing: total 282 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (3.8%), b_tie_ro: 9 (3.3%), parse: 0.85 (0.3%),
         extract_message_metadata: 10 (3.6%), get_uri_detail_list: 0.77 (0.3%),
         tests_pri_-1000: 13 (4.7%), tests_pri_-950: 1.24 (0.4%),
        tests_pri_-900: 1.01 (0.4%), tests_pri_-90: 74 (26.1%), check_bayes:
        72 (25.6%), b_tokenize: 6 (2.0%), b_tok_get_all: 4.5 (1.6%),
        b_comp_prob: 1.85 (0.7%), b_tok_touch_all: 57 (20.3%), b_finish: 0.81
        (0.3%), tests_pri_0: 159 (56.4%), check_dkim_signature: 0.48 (0.2%),
        check_dkim_adsp: 2.2 (0.8%), poll_dns_idle: 0.52 (0.2%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 7 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/6] exec: Run sync_mm_rss before taking exec_update_mutex
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Like exec_mm_release sync_mm_rss is about flushing out the state of
the old_mm, which does not need to happen under exec_update_mutex.

Make this explicit by moving sync_mm_rss outside of exec_update_mutex.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 11a5c073aa35..15682a1dfee9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1051,13 +1051,14 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk = current;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
+	if (old_mm)
+		sync_mm_rss(old_mm);
 
 	ret = mutex_lock_killable(&tsk->signal->exec_update_mutex);
 	if (ret)
 		return ret;
 
 	if (old_mm) {
-		sync_mm_rss(old_mm);
 		/*
 		 * Make sure that if there is a core dump in progress
 		 * for the old mm, we get out and die instead of going
-- 
2.20.1

