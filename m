Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504902066C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbgFWV7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 17:59:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51274 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbgFWV7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:59:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqxE-0004Hk-I8; Tue, 23 Jun 2020 15:59:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqxD-0003OQ-N3; Tue, 23 Jun 2020 15:59:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:55:20 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <874kr1la5z.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqxD-0003OQ-N3;;;mid=<874kr1la5z.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+2UXPbTw30wEkfFjbQUHoFz2avs7xxoas=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 334 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (3.1%), b_tie_ro: 9 (2.7%), parse: 0.94 (0.3%),
         extract_message_metadata: 11 (3.3%), get_uri_detail_list: 1.27 (0.4%),
         tests_pri_-1000: 13 (3.8%), tests_pri_-950: 1.28 (0.4%),
        tests_pri_-900: 1.00 (0.3%), tests_pri_-90: 102 (30.7%), check_bayes:
        101 (30.2%), b_tokenize: 6 (1.9%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 82 (24.6%), b_finish: 0.96
        (0.3%), tests_pri_0: 182 (54.5%), check_dkim_signature: 0.54 (0.2%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 0.78 (0.2%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 4/6] signal: In signal_group_exit remove the group_exit_task test
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


There are two places where signal_group_exit are set.  In the
fs/exec.c:de_thread() and in fs/coredump.c:zap_threads().

The coredump usage of group_exit_task was explicitly added[1]
so that signal_group_exit() would return true during a
coredump.

When examining the coredump usage it turns out that SIGNAL_GROUP_COREDUMP
is set in all of the same places as group_exit_task.  So signal_group_exit
can test SIGNAL_GROUP_COREDUMP and achieve the same results with
respect to coredumps as testing group_exit_task.

Similarly the exec code sets and clears SIGNAL_GROUP_DETHREAD in all
of the places where group_exit_task is set and cleared.

So test SIGNAL_GROUP_COREDUMP | SIGNAL_GROUP_DETHREAD instead of
group_exit_task.

Cc: Oleg Nesterov <oleg@redhat.com>
[1] 6cd8f0acae34 ("coredump: ensure that SIGKILL always kills the dumping thread")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 5ff8697b21cd..43822e2b63e6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -268,8 +268,9 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 /* If true, all threads except ->group_exit_task have pending SIGKILL */
 static inline int signal_group_exit(const struct signal_struct *sig)
 {
-	return	(sig->flags & SIGNAL_GROUP_EXIT) ||
-		(sig->group_exit_task != NULL);
+	return	(sig->flags & (SIGNAL_GROUP_EXIT |
+			       SIGNAL_GROUP_COREDUMP |
+			       SIGNAL_GROUP_DETHREAD));
 }
 
 extern void flush_signals(struct task_struct *);
-- 
2.20.1

