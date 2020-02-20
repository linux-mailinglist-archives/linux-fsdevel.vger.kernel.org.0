Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C71668F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgBTUvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:51:24 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48810 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgBTUvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:51:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4sn4-0001ko-94; Thu, 20 Feb 2020 13:51:22 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4smw-0005SC-BW; Thu, 20 Feb 2020 13:51:21 -0700
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
        Solar Designer <solar@openwall.com>
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
Date:   Thu, 20 Feb 2020 14:49:09 -0600
In-Reply-To: <871rqpaswu.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 20 Feb 2020 14:46:25 -0600")
Message-ID: <87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j4smw-0005SC-BW;;;mid=<87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18yxsTIN6rEo+POZRFDqs4bpwfG8Bf38/Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,TR_Symld_Words,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMGappySubj_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 7271 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 1.16
        (0.0%), extract_message_metadata: 12 (0.2%), get_uri_detail_list: 1.32
        (0.0%), tests_pri_-1000: 3.4 (0.0%), tests_pri_-950: 0.98 (0.0%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 21 (0.3%), check_bayes: 20
        (0.3%), b_tokenize: 6 (0.1%), b_tok_get_all: 7 (0.1%), b_comp_prob:
        1.55 (0.0%), b_tok_touch_all: 3.9 (0.1%), b_finish: 0.62 (0.0%),
        tests_pri_0: 6184 (85.0%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 6008 (82.6%), poll_dns_idle: 7038 (96.8%),
        tests_pri_10: 1.66 (0.0%), tests_pri_500: 1041 (14.3%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH 3/7] proc: Mov rcu_read_(lock|unlock) in proc_prune_siblings_dcache
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Don't make it look like rcu_read_lock is held over the entire loop
instead just take the rcu_read_lock over the part of the loop that
matters.  This makes the intent of the code a little clearer.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 74ce4a8d05eb..38a7baa41aba 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -110,11 +110,13 @@ void proc_prune_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
 	struct hlist_node *node;
 	struct super_block *sb;
 
-	rcu_read_lock();
 	for (;;) {
+		rcu_read_lock();
 		node = hlist_first_rcu(inodes);
-		if (!node)
+		if (!node) {
+			rcu_read_unlock();
 			break;
+		}
 		ei = hlist_entry(node, struct proc_inode, sibling_inodes);
 		spin_lock(lock);
 		hlist_del_init_rcu(&ei->sibling_inodes);
@@ -122,23 +124,21 @@ void proc_prune_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
 
 		inode = &ei->vfs_inode;
 		sb = inode->i_sb;
-		if (!atomic_inc_not_zero(&sb->s_active))
+		if (!atomic_inc_not_zero(&sb->s_active)) {
+			rcu_read_unlock();
 			continue;
+		}
 		inode = igrab(inode);
 		rcu_read_unlock();
 		if (unlikely(!inode)) {
 			deactivate_super(sb);
-			rcu_read_lock();
 			continue;
 		}
 
 		d_prune_aliases(inode);
 		iput(inode);
 		deactivate_super(sb);
-
-		rcu_read_lock();
 	}
-	rcu_read_unlock();
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
-- 
2.20.1

