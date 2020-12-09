Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F002D4D12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 22:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbgLIVod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 16:44:33 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36840 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388024AbgLIVo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:44:26 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7FJ-0057n3-Pq; Wed, 09 Dec 2020 14:43:37 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7FI-0008Qp-5R; Wed, 09 Dec 2020 14:43:37 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
        <20201120231441.29911-15-ebiederm@xmission.com>
        <20201207232900.GD4115853@ZenIV.linux.org.uk>
        <877dprvs8e.fsf@x220.int.ebiederm.org>
        <20201209040731.GK3579531@ZenIV.linux.org.uk>
        <877dprtxly.fsf@x220.int.ebiederm.org>
        <20201209142359.GN3579531@ZenIV.linux.org.uk>
        <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
        <20201209195033.GP3579531@ZenIV.linux.org.uk>
Date:   Wed, 09 Dec 2020 15:42:57 -0600
In-Reply-To: <20201209195033.GP3579531@ZenIV.linux.org.uk> (Al Viro's message
        of "Wed, 9 Dec 2020 19:50:33 +0000")
Message-ID: <87k0tqr6zi.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kn7FI-0008Qp-5R;;;mid=<87k0tqr6zi.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX189Rw1cMt/IQ5KFj0AlXqXmYJxXSElH7wM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMGappySubj_01,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1290 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.9%), b_tie_ro: 10 (0.8%), parse: 1.05
        (0.1%), extract_message_metadata: 17 (1.3%), get_uri_detail_list: 1.65
        (0.1%), tests_pri_-1000: 14 (1.1%), tests_pri_-950: 1.23 (0.1%),
        tests_pri_-900: 0.98 (0.1%), tests_pri_-90: 59 (4.6%), check_bayes: 58
        (4.5%), b_tokenize: 6 (0.5%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.85 (0.1%), b_tok_touch_all: 41 (3.2%), b_finish: 0.82 (0.1%),
        tests_pri_0: 1171 (90.8%), check_dkim_signature: 0.50 (0.0%),
        check_dkim_adsp: 2.1 (0.2%), poll_dns_idle: 0.53 (0.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH -1/24] exec: Don't open code get_close_on_exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Al Viro pointed out that using the phrase "close_on_exec(fd,
rcu_dereference_raw(current->files->fdt))" instead of wrapping it in
rcu_read_lock(), rcu_read_unlock() is a very questionable
optimization[1].

Once wrapped with rcu_read_lock()/rcu_read_unlock() that phrase
becomes equivalent the helper function get_close_on_exec so
simplify the code and make it more robust by simply using
get_close_on_exec.

[1] https://lkml.kernel.org/r/20201207222214.GA4115853@ZenIV.linux.org.uk
Suggested-by: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

I aim to rebase my exec branch and apply this tomorrow.

 fs/exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf5..9aabf6e8c904 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1808,8 +1808,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	 * inaccessible after exec. Relies on having exclusive access to
 	 * current->files (due to unshare_files above).
 	 */
-	if (bprm->fdpath &&
-	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
+	if (bprm->fdpath && get_close_on_exec(fd))
 		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
 
 	/* Set the unchanging part of bprm->cred */
-- 
2.20.1

