Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE49C4A4EC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357657AbiAaSqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:46:15 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53042 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357564AbiAaSqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:46:10 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:49910)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbgm-006c8W-Tf; Mon, 31 Jan 2022 11:46:09 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:56344 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbgl-00ExTQ-Ud; Mon, 31 Jan 2022 11:46:08 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
        <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
Date:   Mon, 31 Jan 2022 12:46:01 -0600
In-Reply-To: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 31 Jan 2022 12:44:53 -0600")
Message-ID: <875ypzoiae.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEbgl-00ExTQ-Ud;;;mid=<875ypzoiae.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18jQRBv9iObiu0wrlEsJHbWC0XiQ+TmAOA=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_SCC_BODY_TEXT_LINE,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 416 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (2.8%), b_tie_ro: 10 (2.4%), parse: 1.77
        (0.4%), extract_message_metadata: 20 (4.8%), get_uri_detail_list: 2.3
        (0.6%), tests_pri_-1000: 22 (5.3%), tests_pri_-950: 2.2 (0.5%),
        tests_pri_-900: 1.79 (0.4%), tests_pri_-90: 75 (18.0%), check_bayes:
        73 (17.6%), b_tokenize: 12 (2.8%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 3.0 (0.7%), b_tok_touch_all: 47 (11.4%), b_finish: 1.07
        (0.3%), tests_pri_0: 261 (62.8%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 3.0 (0.7%), poll_dns_idle: 1.09 (0.3%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 12 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/5] coredump: Move definition of struct coredump_params
 into coredump.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Move the definition of struct coredump_params into coredump.h where
it belongs.

Remove the slightly errorneous comment explaining why struct
coredump_params was declared in binfmts.h.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/binfmts.h  | 13 +------------
 include/linux/coredump.h | 12 +++++++++++-
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 049cf9421d83..05a91f5499ba 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -8,6 +8,7 @@
 #include <uapi/linux/binfmts.h>
 
 struct filename;
+struct coredump_params;
 
 #define CORENAME_MAX_SIZE 128
 
@@ -77,18 +78,6 @@ struct linux_binprm {
 #define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
 #define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
 
-/* Function parameter for binfmt->coredump */
-struct coredump_params {
-	const kernel_siginfo_t *siginfo;
-	struct pt_regs *regs;
-	struct file *file;
-	unsigned long limit;
-	unsigned long mm_flags;
-	loff_t written;
-	loff_t pos;
-	loff_t to_skip;
-};
-
 /*
  * This structure defines the functions that are used to load the binary formats that
  * linux accepts.
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 248a68c668b4..2ee1460a1d66 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -14,11 +14,21 @@ struct core_vma_metadata {
 	unsigned long dump_size;
 };
 
+struct coredump_params {
+	const kernel_siginfo_t *siginfo;
+	struct pt_regs *regs;
+	struct file *file;
+	unsigned long limit;
+	unsigned long mm_flags;
+	loff_t written;
+	loff_t pos;
+	loff_t to_skip;
+};
+
 /*
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
  */
-struct coredump_params;
 extern void dump_skip_to(struct coredump_params *cprm, unsigned long to);
 extern void dump_skip(struct coredump_params *cprm, size_t nr);
 extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
-- 
2.29.2

