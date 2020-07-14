Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7317F21F2A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGNNdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:33:00 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48954 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:32:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3F-0007ZZ-1S; Tue, 14 Jul 2020 07:32:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL3E-0006ij-1l; Tue, 14 Jul 2020 07:32:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
Date:   Tue, 14 Jul 2020 08:30:02 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87eepe6x7p.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL3E-0006ij-1l;;;mid=<87eepe6x7p.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Tp8T+D0arIMZhfUhTvULP2xEom+axBvw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 552 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.7%), parse: 0.98
        (0.2%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 2.0
        (0.4%), tests_pri_-1000: 16 (2.9%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 86 (15.5%), check_bayes:
        84 (15.2%), b_tokenize: 10 (1.8%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 58 (10.5%), b_finish: 1.02
        (0.2%), tests_pri_0: 413 (74.7%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 23 (4.1%), poll_dns_idle: 21 (3.8%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/7] exec: Move bprm_mm_init into alloc_bprm
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Currently it is necessary for the usermode helper code and the code that
launches init to use set_fs so that pages coming from the kernel look like
they are coming from userspace.

To allow that usage of set_fs to be removed cleanly the argument copying
from userspace needs to happen earlier.  Move the allocation and
initialization of bprm->mm into alloc_bprm so that the bprm->mm is
available early to store the new user stack into.  This is a prerequisite
for copying argv and envp into the new user stack early before ther rest of
exec.

To keep the things consistent the cleanup of bprm->mm is moved into
free_bprm.  So that bprm->mm will be cleaned up whenever bprm->mm is
allocated and free_bprm are called.

Moving bprm_mm_init earlier is safe as it does not depend on any files,
current->in_execve, current->fs->in_exec, bprm->unsafe, or the if the file
table is shared. (AKA bprm_mm_init does not depend on any of the code that
happens between alloc_bprm and where it was previously called.)

This moves bprm->mm cleanup after current->fs->in_exec is set to 0.  This
is safe because current->fs->in_exec is only used to preventy taking an
additional reference on the fs_struct.

This moves bprm->mm cleanup after current->in_execve is set to 0.  This is
safe because current->in_execve is only used by the lsms (apparmor and
tomoyou) and always for LSM specific functions, never for anything to do
with the mm.

This adds bprm->mm cleanup into the successful return path.  This is safe
because being on the successful return path implies that begin_new_exec
succeeded and set brpm->mm to NULL.  As bprm->mm is NULL bprm cleanup I am
moving into free_bprm will do nothing.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7e8af27dd199..afb168bf5e23 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1543,6 +1543,10 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 
 static void free_bprm(struct linux_binprm *bprm)
 {
+	if (bprm->mm) {
+		acct_arg_size(bprm, 0);
+		mmput(bprm->mm);
+	}
 	free_arg_pages(bprm);
 	if (bprm->cred) {
 		mutex_unlock(&current->signal->cred_guard_mutex);
@@ -1582,6 +1586,10 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 		bprm->filename = bprm->fdpath;
 	}
 	bprm->interp = bprm->filename;
+
+	retval = bprm_mm_init(bprm);
+	if (retval)
+		goto out_free;
 	return bprm;
 
 out_free:
@@ -1911,10 +1919,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
 		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
 
-	retval = bprm_mm_init(bprm);
-	if (retval)
-		goto out_unmark;
-
 	retval = prepare_arg_pages(bprm, argv, envp);
 	if (retval < 0)
 		goto out;
@@ -1962,10 +1966,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 */
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
 		force_sigsegv(SIGSEGV);
-	if (bprm->mm) {
-		acct_arg_size(bprm, 0);
-		mmput(bprm->mm);
-	}
 
 out_unmark:
 	current->fs->in_exec = 0;
-- 
2.25.0

