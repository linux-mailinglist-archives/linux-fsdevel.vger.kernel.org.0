Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A521A1E66C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404667AbgE1PxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:53:11 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33262 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404565AbgE1PxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:53:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKqC-0001W7-C9; Thu, 28 May 2020 09:53:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKq6-0007zz-5k; Thu, 28 May 2020 09:53:07 -0600
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
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 28 May 2020 10:49:10 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <874ks0xdop.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKq6-0007zz-5k;;;mid=<874ks0xdop.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ELoUISo4voXjVc4cOnoi5+XqInd2HxUI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 515 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.5 (0.7%), b_tie_ro: 2.3 (0.4%), parse: 1.20
        (0.2%), extract_message_metadata: 15 (2.9%), get_uri_detail_list: 1.48
        (0.3%), tests_pri_-1000: 17 (3.3%), tests_pri_-950: 1.47 (0.3%),
        tests_pri_-900: 1.21 (0.2%), tests_pri_-90: 134 (26.0%), check_bayes:
        132 (25.7%), b_tokenize: 10 (1.8%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 111 (21.5%), b_finish: 0.71
        (0.1%), tests_pri_0: 328 (63.6%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.81 (0.2%), tests_pri_10:
        2.6 (0.5%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/11] exec: In bprm_fill_uid remove unnecessary no new privs check
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When the no new privs code was added[1], a test was added to
cap_bprm_set_creds to ensure that the credential change were always
reverted if no new privs was set.

That test has been refactored into a test to not make the credential
change in bprm_fill_uid when no new privs is set.  Remove that
unncessary test as it can now been seen by a quick inspection that
execution can never make it to the test with no new privs set.

The same change[1] also added a test that guaranteed the credentials
would never change when no_new_privs was set, so the test I am removing
was never necessary but historically that was far from obvious.

[1]: 259e5e6c75a9 ("Add PR_{GET,SET}_NO_NEW_PRIVS to prevent execve from granting privs")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8dd7254931dc..af108ecf9632 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1636,16 +1636,12 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 
 	if (mode & S_ISUID) {
 		bprm->per_clear = 1;
-		if (!need_cap ||
-		    (ns_capable(new->user_ns, CAP_SETUID) &&
-		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
+		if (!need_cap || ns_capable(new->user_ns, CAP_SETUID))
 			new->suid = new->fsuid = new->euid = uid;
 	}
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear = 1;
-		if (!need_cap ||
-		    (ns_capable(new->user_ns, CAP_SETGID) &&
-		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
+		if (!need_cap || ns_capable(new->user_ns, CAP_SETGID))
 			new->sgid = new->fsgid = new->egid = gid;
 	}
 
-- 
2.25.0

