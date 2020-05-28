Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870CE1E66D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404749AbgE1PyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:54:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53032 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgE1PyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:54:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKr3-0005Lz-CC; Thu, 28 May 2020 09:54:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKr2-0003Dg-EH; Thu, 28 May 2020 09:54:01 -0600
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
Date:   Thu, 28 May 2020 10:50:09 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87sgfkvz2m.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKr2-0003Dg-EH;;;mid=<87sgfkvz2m.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+noWZXFqvq+oA4X8eGsRDwP21udiMjpIw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
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
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 530 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (0.8%), b_tie_ro: 3.0 (0.6%), parse: 1.09
        (0.2%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 1.92
        (0.4%), tests_pri_-1000: 11 (2.1%), tests_pri_-950: 1.14 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 229 (43.1%), check_bayes:
        227 (42.8%), b_tokenize: 7 (1.3%), b_tok_get_all: 7 (1.2%),
        b_comp_prob: 1.73 (0.3%), b_tok_touch_all: 209 (39.4%), b_finish: 0.83
        (0.2%), tests_pri_0: 262 (49.3%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 0.80 (0.2%), tests_pri_10:
        1.80 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/11] exec: In bprm_fill_uid set secureexec at same time as per_clear
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


We currently have two different policies for setting per_clear and for
setting secureexec.  For per_clear the policy is if the setxid bits on
a file are honored.  For secureexec the policy is if the resulting
credentials will have multiple uids or gids.

Looking closely the policy for setting AT_SECURE and asking userspace
not to trust our caller in all cases where we have multiple uids or
gids does not make sense.   In some of those cases it is the caller
of exec that provides multiple uids and gids.

The point of setting AT_SECURE is so that the called application or
it's libraries can take defensive measures to guard against a lesser
privileged program which calls it via exec.  If all of your privilege
comes from your caller there is no point in taking defensive measures,
against them.

Further the only way that libc or other userspace can know that the
privilege came from the caller of exec and not from the exec being
suid or sgid is by the kernel telling it.  As userspace does not
have enough information to distinguish between these two cases.

So set secureexec when the exec itself results in multiple uids
or gids, not when we happen to have mulitple ids because the
binary was called that way.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 347dade4bc54..fc4edc7517a6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1637,19 +1637,19 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	if ((mode & S_ISUID) &&
 	    (!need_cap || ns_capable(new->user_ns, CAP_SETUID))) {
 		bprm->per_clear = 1;
+		bprm->secureexec = 1;
 		new->suid = new->fsuid = new->euid = uid;
 	}
 
 	if (((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) &&
 	    (!need_cap || ns_capable(new->user_ns, CAP_SETGID))) {
 		bprm->per_clear = 1;
+		bprm->secureexec = 1;
 		new->sgid = new->fsgid = new->egid = gid;
 	}
 
 after_setid:
-	/* Will the new creds have multiple uids or gids? */
-	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid))
-		bprm->secureexec = 1;
+	;
 }
 
 /*
-- 
2.25.0

