Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15291E66C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbgE1Pwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:52:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52566 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404565AbgE1Pwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:52:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKpg-0005EG-KT; Thu, 28 May 2020 09:52:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKpf-00033R-Pz; Thu, 28 May 2020 09:52:36 -0600
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
Date:   Thu, 28 May 2020 10:48:44 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87a71sxdpf.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKpf-00033R-Pz;;;mid=<87a71sxdpf.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19L2GQX5s9eCjNWe4gHmrLWVMHrvsxnIhk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 387 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 14 (3.5%), b_tie_ro: 12 (3.0%), parse: 1.36
        (0.4%), extract_message_metadata: 16 (4.1%), get_uri_detail_list: 1.55
        (0.4%), tests_pri_-1000: 19 (4.8%), tests_pri_-950: 1.59 (0.4%),
        tests_pri_-900: 1.32 (0.3%), tests_pri_-90: 120 (31.0%), check_bayes:
        118 (30.6%), b_tokenize: 9 (2.3%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 97 (25.1%), b_finish: 0.87
        (0.2%), tests_pri_0: 200 (51.8%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 07/11] exec: Set saved, fs, and effective ids together in bprm_fill_uid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Now that there is only one place in bprm_fill_uid where the
euid and the egid are set, move setting of the saved, and the
fs ids to that place.

This makes it clear that this is the only location in the function
that changes these ids.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 123402f218fe..8dd7254931dc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1639,23 +1639,20 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		if (!need_cap ||
 		    (ns_capable(new->user_ns, CAP_SETUID) &&
 		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
-			new->euid = uid;
+			new->suid = new->fsuid = new->euid = uid;
 	}
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear = 1;
 		if (!need_cap ||
 		    (ns_capable(new->user_ns, CAP_SETGID) &&
 		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
-			new->egid = gid;
+			new->sgid = new->fsgid = new->egid = gid;
 	}
 
 after_setid:
 	/* Will the new creds have multiple uids or gids? */
 	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid))
 		bprm->secureexec = 1;
-
-	new->suid = new->fsuid = new->euid;
-	new->sgid = new->fsgid = new->egid;
 }
 
 /*
-- 
2.25.0

