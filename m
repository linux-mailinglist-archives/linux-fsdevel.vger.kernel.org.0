Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6035E21F29A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGNNb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:31:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48594 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:31:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL2J-0007Tv-Ik; Tue, 14 Jul 2020 07:31:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL2I-0005L6-SL; Tue, 14 Jul 2020 07:31:55 -0600
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
Date:   Tue, 14 Jul 2020 08:29:05 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87pn8y6x9a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL2I-0005L6-SL;;;mid=<87pn8y6x9a.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SB46uFkLNkWWJuV08LWp9w9461KO6n04=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 369 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.5 (0.9%), b_tie_ro: 2.4 (0.6%), parse: 0.95
        (0.3%), extract_message_metadata: 13 (3.4%), get_uri_detail_list: 1.52
        (0.4%), tests_pri_-1000: 14 (3.8%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 0.99 (0.3%), tests_pri_-90: 61 (16.5%), check_bayes:
        59 (16.1%), b_tokenize: 10 (2.6%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.1 (0.6%), b_tok_touch_all: 37 (10.1%), b_finish: 0.57
        (0.2%), tests_pri_0: 262 (71.1%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.70 (0.2%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/7] exec: Factor out alloc_bprm
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Currently it is necessary for the usermode helper code and the code
that launches init to use set_fs so that pages coming from the kernel
look like they are coming from userspace.

To allow that usage of set_fs to be removed cleanly the argument
copying from userspace needs to happen earlier.  Move the allocation
of the bprm into it's own function (alloc_bprm) and move the call of
alloc_bprm before unshare_files so that bprm can ultimately be
allocated, the arguments can be placed on the new stack, and then the
bprm can be passed into the core of exec.

Neither the allocation of struct binprm nor the unsharing depend upon each
other so swapping the order in which they are called is trivially safe.

To keep things consistent the order of cleanup at the end of
do_execve_common swapped to match the order of initialization.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 23dfbb820626..526156d6461d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1560,6 +1560,14 @@ static void free_bprm(struct linux_binprm *bprm)
 	kfree(bprm);
 }
 
+static struct linux_binprm *alloc_bprm(void)
+{
+	struct linux_binprm *bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
+	if (!bprm)
+		return ERR_PTR(-ENOMEM);
+	return bprm;
+}
+
 int bprm_change_interp(const char *interp, struct linux_binprm *bprm)
 {
 	/* If a binfmt changed the interp, free it first. */
@@ -1848,18 +1856,19 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	retval = unshare_files(&displaced);
-	if (retval)
+	bprm = alloc_bprm();
+	if (IS_ERR(bprm)) {
+		retval = PTR_ERR(bprm);
 		goto out_ret;
+	}
 
-	retval = -ENOMEM;
-	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
-	if (!bprm)
-		goto out_files;
+	retval = unshare_files(&displaced);
+	if (retval)
+		goto out_free;
 
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
-		goto out_free;
+		goto out_files;
 
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
@@ -1956,13 +1965,13 @@ static int do_execveat_common(int fd, struct filename *filename,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
+out_files:
+	if (displaced)
+		reset_files_struct(displaced);
 out_free:
 	free_bprm(bprm);
 	kfree(pathbuf);
 
-out_files:
-	if (displaced)
-		reset_files_struct(displaced);
 out_ret:
 	putname(filename);
 	return retval;
-- 
2.25.0

