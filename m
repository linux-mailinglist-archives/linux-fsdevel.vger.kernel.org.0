Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961A11E66C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404622AbgE1PwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:52:11 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49102 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404518AbgE1PwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:52:10 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKpA-0004Mo-Cr; Thu, 28 May 2020 09:52:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKp9-0007rJ-31; Thu, 28 May 2020 09:52:04 -0600
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
Date:   Thu, 28 May 2020 10:48:11 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87ftbkxdqc.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKp9-0007rJ-31;;;mid=<87ftbkxdqc.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19acW7gYINIOd1UYM//vzVBWHHd36D56kw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 479 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.8 (0.8%), b_tie_ro: 2.6 (0.5%), parse: 0.77
        (0.2%), extract_message_metadata: 9 (1.9%), get_uri_detail_list: 1.42
        (0.3%), tests_pri_-1000: 11 (2.3%), tests_pri_-950: 1.00 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 119 (24.8%), check_bayes:
        118 (24.6%), b_tokenize: 8 (1.6%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 1.67 (0.3%), b_tok_touch_all: 98 (20.5%), b_finish: 0.67
        (0.1%), tests_pri_0: 323 (67.5%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 1.95 (0.4%), poll_dns_idle: 0.60 (0.1%),
        tests_pri_10: 1.72 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 06/11] exec: Don't set secureexec when the uid or gid changes are abandoned
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When the is_secureexec test was removed from cap_bprm_set_creds the
test was modified so that it based the status of secureexec on a
version of the euid and egid before ptrace and shared fs tests
possibly reverted them.

The effect of which is that secureexec continued to be set when the
euid and egid change were abandoned because the executable was being
ptraced to secureexec being set in that same situation.

As far as I can tell it is just an oversight and very poor quality of
implementation to set AT_SECURE when it is not ncessary.  So improve
the quality of the implementation by only setting secureexec when there
will be multiple uids or gids in the final cred structure.

Fixes: ee67ae7ef6ff ("commoncap: Move cap_elevated calculation into bprm_set_creds")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index bac8db14f30d..123402f218fe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1622,44 +1622,38 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	    !kgid_has_mapping(new->user_ns, gid))
 		goto after_setid;
 
+	/*
+	 * Is the root directory and working directory shared or is
+	 * the process traced and the tracing process does not have
+	 * CAP_SYS_PTRACE?
+	 *
+	 * In either case it is not safe to change the euid or egid
+	 * unless the current process has the appropriate cap and so
+	 * chaning the euid or egid was already possible.
+	 */
+	need_cap = bprm->unsafe & LSM_UNSAFE_SHARE ||
+		!ptracer_capable(current, new->user_ns);
+
 	if (mode & S_ISUID) {
 		bprm->per_clear = 1;
-		new->euid = uid;
+		if (!need_cap ||
+		    (ns_capable(new->user_ns, CAP_SETUID) &&
+		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
+			new->euid = uid;
 	}
-
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear = 1;
-		new->egid = gid;
+		if (!need_cap ||
+		    (ns_capable(new->user_ns, CAP_SETGID) &&
+		     !(bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)))
+			new->egid = gid;
 	}
 
 after_setid:
 	/* Will the new creds have multiple uids or gids? */
-	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid)) {
+	if (!uid_eq(new->euid, new->uid) || !gid_eq(new->egid, new->gid))
 		bprm->secureexec = 1;
 
-		/*
-		 * Is the root directory and working directory shared or is
-		 * the process traced and the tracing process does not have
-		 * CAP_SYS_PTRACE?
-		 *
-		 * In either case it is not safe to change the euid or egid
-		 * unless the current process has the appropriate cap and so
-		 * chaning the euid or egid was already possible.
-		 */
-		need_cap = bprm->unsafe & LSM_UNSAFE_SHARE ||
-			!ptracer_capable(current, new->user_ns);
-		if (need_cap && !uid_eq(new->euid, new->uid) &&
-		    (!ns_capable(new->user_ns, CAP_SETUID) ||
-		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
-			new->euid = new->uid;
-		}
-		if (need_cap && !gid_eq(new->egid, new->gid) &&
-		    (!ns_capable(new->user_ns, CAP_SETGID) ||
-		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
-			new->egid = new->gid;
-		}
-	}
-
 	new->suid = new->fsuid = new->euid;
 	new->sgid = new->fsgid = new->egid;
 }
-- 
2.25.0

