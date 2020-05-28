Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577071E66D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404597AbgE1Pyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:54:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49760 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404774AbgE1Pyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:54:32 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKrU-0004Y0-Lc; Thu, 28 May 2020 09:54:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKrT-0008Bp-Qq; Thu, 28 May 2020 09:54:28 -0600
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
Date:   Thu, 28 May 2020 10:50:36 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87mu5svz1v.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKrT-0008Bp-Qq;;;mid=<87mu5svz1v.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+MHtH6hLkB3oWNuRodn+5tMsim9ktuu6s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
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
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 408 ms - load_scoreonly_sql: 0.41 (0.1%),
        signal_user_changed: 14 (3.3%), b_tie_ro: 11 (2.7%), parse: 1.64
        (0.4%), extract_message_metadata: 15 (3.6%), get_uri_detail_list: 1.60
        (0.4%), tests_pri_-1000: 13 (3.2%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 1.05 (0.3%), tests_pri_-90: 134 (32.9%), check_bayes:
        132 (32.5%), b_tokenize: 7 (1.8%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 1.88 (0.5%), b_tok_touch_all: 113 (27.6%), b_finish: 0.89
        (0.2%), tests_pri_0: 214 (52.5%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 11/11] exec: Remove the label after_setid from bprm_fill_uid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


There is nothing past the label after_setid in bprm_fill_uid so
replace code that jumps to it with return, and delete
the label entirely.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fc4edc7517a6..ccb552fcdcff 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1598,15 +1598,15 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	kgid_t gid;
 
 	if (!mnt_may_suid(bprm->file->f_path.mnt))
-		goto after_setid;
+		return;
 
 	if (task_no_new_privs(current))
-		goto after_setid;
+		return;
 
 	inode = bprm->file->f_path.dentry->d_inode;
 	mode = READ_ONCE(inode->i_mode);
 	if (!(mode & (S_ISUID|S_ISGID)))
-		goto after_setid;
+		return;
 
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
@@ -1620,7 +1620,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!kuid_has_mapping(new->user_ns, uid) ||
 	    !kgid_has_mapping(new->user_ns, gid))
-		goto after_setid;
+		return;
 
 	/*
 	 * Is the root directory and working directory shared or is
@@ -1647,9 +1647,6 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 		bprm->secureexec = 1;
 		new->sgid = new->fsgid = new->egid = gid;
 	}
-
-after_setid:
-	;
 }
 
 /*
-- 
2.25.0

