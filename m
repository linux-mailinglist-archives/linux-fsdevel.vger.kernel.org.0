Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA531D8C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 02:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgESAdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 20:33:24 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59200 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgESAdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 20:33:23 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqCA-0002eO-8w; Mon, 18 May 2020 18:33:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqC8-0004Hu-W1; Mon, 18 May 2020 18:33:22 -0600
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
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 18 May 2020 19:29:41 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <871rng22dm.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqC8-0004Hu-W1;;;mid=<871rng22dm.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5Ib6hqHkieMX7PPoHgPDToeUME0OO9Kw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 867 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.44
        (0.2%), extract_message_metadata: 13 (1.4%), get_uri_detail_list: 1.38
        (0.2%), tests_pri_-1000: 14 (1.6%), tests_pri_-950: 1.18 (0.1%),
        tests_pri_-900: 0.99 (0.1%), tests_pri_-90: 160 (18.4%), check_bayes:
        158 (18.2%), b_tokenize: 7 (0.8%), b_tok_get_all: 4.9 (0.6%),
        b_comp_prob: 2.1 (0.2%), b_tok_touch_all: 140 (16.2%), b_finish: 1.02
        (0.1%), tests_pri_0: 653 (75.3%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.61 (0.1%), tests_pri_10:
        2.0 (0.2%), tests_pri_500: 7 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 1/8] exec: Teach prepare_exec_creds how exec treats uids & gids
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


It is almost possible to use the result of prepare_exec_creds with no
modifications during exec.  Update prepare_exec_creds to initialize
the suid and the fsuid to the euid, and the sgid and the fsgid to the
egid.  This is all that is needed to handle the common case of exec
when nothing special like a setuid exec is happening.

That this preserves the existing behavior of exec can be verified
by examing bprm_fill_uid and cap_bprm_set_creds.

This change makes it clear that the later parts of exec that
update bprm->cred are just need to handle special cases such
as setuid exec and change of domains.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/cred.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cred.c b/kernel/cred.c
index 71a792616917..421b1149c651 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -315,6 +315,9 @@ struct cred *prepare_exec_creds(void)
 	new->process_keyring = NULL;
 #endif
 
+	new->suid = new->fsuid = new->euid;
+	new->sgid = new->fsgid = new->egid;
+
 	return new;
 }
 
-- 
2.25.0

