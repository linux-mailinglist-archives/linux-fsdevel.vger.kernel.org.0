Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4781CB795
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 20:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEHSsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 14:48:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54346 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHSsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 14:48:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX82g-0005OS-CG; Fri, 08 May 2020 12:48:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX82f-0004Z3-Fu; Fri, 08 May 2020 12:48:14 -0600
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
Date:   Fri, 08 May 2020 13:44:46 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87h7wq6zc1.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX82f-0004Z3-Fu;;;mid=<87h7wq6zc1.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18I4XqN+zQietoOeTu38q9Y+IWIWtiZyE0=
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
X-Spam-Timing: total 474 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 16 (3.4%), b_tie_ro: 15 (3.1%), parse: 1.29
        (0.3%), extract_message_metadata: 17 (3.6%), get_uri_detail_list: 1.16
        (0.2%), tests_pri_-1000: 20 (4.1%), tests_pri_-950: 1.77 (0.4%),
        tests_pri_-900: 1.45 (0.3%), tests_pri_-90: 183 (38.7%), check_bayes:
        181 (38.2%), b_tokenize: 8 (1.6%), b_tok_get_all: 7 (1.4%),
        b_comp_prob: 3.2 (0.7%), b_tok_touch_all: 159 (33.6%), b_finish: 1.00
        (0.2%), tests_pri_0: 215 (45.4%), check_dkim_signature: 0.80 (0.2%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        3.3 (0.7%), tests_pri_500: 10 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/6] exec: Fix spelling of search_binary_handler in a comment
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index d4387bc92292..82106241ed53 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1296,7 +1296,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
  * Calling this is the point of no return. None of the failures will be
  * seen by userspace since either the process is already taking a fatal
  * signal (via de_thread() or coredump), or will have SEGV raised
- * (after exec_mmap()) by search_binary_handlers (see below).
+ * (after exec_mmap()) by search_binary_handler (see below).
  */
 int begin_new_exec(struct linux_binprm * bprm)
 {
-- 
2.20.1

