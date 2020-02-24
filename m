Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D016AB74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBXQ3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:29:55 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49632 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgBXQ3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:29:54 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6GcD-0004Pr-JA; Mon, 24 Feb 2020 09:29:53 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6GcC-0007x0-LM; Mon, 24 Feb 2020 09:29:53 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
        <87v9odlxbr.fsf@x220.int.ebiederm.org>
        <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
        <87tv3vkg1a.fsf@x220.int.ebiederm.org>
        <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
        <87v9obipk9.fsf@x220.int.ebiederm.org>
        <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
        <20200212200335.GO23230@ZenIV.linux.org.uk>
        <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
        <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <871rqk2brn.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 24 Feb 2020 10:27:49 -0600
In-Reply-To: <871rqk2brn.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 24 Feb 2020 10:25:16 -0600")
Message-ID: <87k14c0x2y.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6GcC-0007x0-LM;;;mid=<87k14c0x2y.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PBz/fWPf6jpbA0LkgeAc4T35MgRRLVLo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 473 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 3.2 (0.7%), b_tie_ro: 2.0 (0.4%), parse: 2.1
        (0.4%), extract_message_metadata: 14 (3.0%), get_uri_detail_list: 1.62
        (0.3%), tests_pri_-1000: 16 (3.3%), tests_pri_-950: 1.35 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 28 (6.0%), check_bayes: 27
        (5.6%), b_tokenize: 9 (1.9%), b_tok_get_all: 7 (1.5%), b_comp_prob:
        2.5 (0.5%), b_tok_touch_all: 6 (1.2%), b_finish: 0.95 (0.2%),
        tests_pri_0: 390 (82.4%), check_dkim_signature: 0.81 (0.2%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 11 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 3/6] proc: In proc_prune_siblings_dcache cache an aquired super block
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Because there are likely to be several sysctls in a row on the
same superblock cache the super_block after the count has
been raised and don't deactivate it until we are processing
another super_block.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 74ce4a8d05eb..fa2dc732cd77 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -108,10 +108,11 @@ void proc_prune_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
 	struct inode *inode;
 	struct proc_inode *ei;
 	struct hlist_node *node;
-	struct super_block *sb;
+	struct super_block *old_sb = NULL;
 
 	rcu_read_lock();
 	for (;;) {
+		struct super_block *sb;
 		node = hlist_first_rcu(inodes);
 		if (!node)
 			break;
@@ -122,23 +123,28 @@ void proc_prune_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
 
 		inode = &ei->vfs_inode;
 		sb = inode->i_sb;
-		if (!atomic_inc_not_zero(&sb->s_active))
+		if ((sb != old_sb) && !atomic_inc_not_zero(&sb->s_active))
 			continue;
 		inode = igrab(inode);
 		rcu_read_unlock();
+		if (sb != old_sb) {
+			if (old_sb)
+				deactivate_super(old_sb);
+			old_sb = sb;
+		}
 		if (unlikely(!inode)) {
-			deactivate_super(sb);
 			rcu_read_lock();
 			continue;
 		}
 
 		d_prune_aliases(inode);
 		iput(inode);
-		deactivate_super(sb);
 
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
+	if (old_sb)
+		deactivate_super(old_sb);
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
-- 
2.25.0

