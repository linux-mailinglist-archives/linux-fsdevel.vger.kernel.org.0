Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5602066B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbgFWV5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 17:57:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57396 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWV5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:57:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqvR-0004Kz-EY; Tue, 23 Jun 2020 15:57:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqvQ-00039X-No; Tue, 23 Jun 2020 15:57:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:53:29 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <87lfkdla92.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqvQ-00039X-No;;;mid=<87lfkdla92.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/1/vL+ah4gMSG5g2qvGjMYB9/S+zDHo+I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 327 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (3.3%), b_tie_ro: 9 (2.9%), parse: 0.71 (0.2%),
         extract_message_metadata: 9 (2.7%), get_uri_detail_list: 0.84 (0.3%),
        tests_pri_-1000: 12 (3.6%), tests_pri_-950: 1.28 (0.4%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 110 (33.8%), check_bayes:
        109 (33.2%), b_tokenize: 4.8 (1.5%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 1.58 (0.5%), b_tok_touch_all: 92 (28.2%), b_finish: 1.15
        (0.4%), tests_pri_0: 171 (52.2%), check_dkim_signature: 0.70 (0.2%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 1.20 (0.4%), tests_pri_10:
        2.2 (0.7%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 1/6] signal: Pretty up the SIGNAL_GROUP_FLAGS
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Renumber the flags that go in sig->flags giving different groups of
flags different hex digits.

This is needed so that future additions of flags can be adjacent.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0ee5e696c5d8..b4f36a11be5e 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -241,20 +241,22 @@ struct signal_struct {
  */
 #define SIGNAL_STOP_STOPPED	0x00000001 /* job control stop in effect */
 #define SIGNAL_STOP_CONTINUED	0x00000002 /* SIGCONT since WCONTINUED reap */
-#define SIGNAL_GROUP_EXIT	0x00000004 /* group exit in progress */
-#define SIGNAL_GROUP_COREDUMP	0x00000008 /* coredump in progress */
-/*
- * Pending notifications to parent.
- */
+
+/* Pending notifications to parent. */
 #define SIGNAL_CLD_STOPPED	0x00000010
 #define SIGNAL_CLD_CONTINUED	0x00000020
 #define SIGNAL_CLD_MASK		(SIGNAL_CLD_STOPPED|SIGNAL_CLD_CONTINUED)
 
-#define SIGNAL_UNKILLABLE	0x00000040 /* for init: ignore fatal signals */
-
 #define SIGNAL_STOP_MASK (SIGNAL_CLD_MASK | SIGNAL_STOP_STOPPED | \
 			  SIGNAL_STOP_CONTINUED)
 
+/* Signal group actions. */
+#define SIGNAL_GROUP_EXIT	0x00000100 /* group exit in progress */
+#define SIGNAL_GROUP_COREDUMP	0x00000200 /* coredump in progress */
+
+/* Flags applicable to the entire signal group. */
+#define SIGNAL_UNKILLABLE	0x00001000 /* for init: ignore fatal signals */
+
 static inline void signal_set_stop_flags(struct signal_struct *sig,
 					 unsigned int flags)
 {
-- 
2.20.1

