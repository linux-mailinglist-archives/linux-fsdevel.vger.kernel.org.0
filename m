Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A508916AB67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBXQ2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:28:48 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49320 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXQ2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:28:47 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6Gb9-0004LB-2f; Mon, 24 Feb 2020 09:28:47 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6Gb7-0007hr-Mu; Mon, 24 Feb 2020 09:28:46 -0700
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
Date:   Mon, 24 Feb 2020 10:26:42 -0600
In-Reply-To: <871rqk2brn.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 24 Feb 2020 10:25:16 -0600")
Message-ID: <87v9nw0x4t.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6Gb7-0007hr-Mu;;;mid=<87v9nw0x4t.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+1jB7207zqKuGkzNocTI/FE1FQ8bEJSFo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4979]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=98]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=98 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 533 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.5%), b_tie_ro: 2.0 (0.4%), parse: 0.97
        (0.2%), extract_message_metadata: 11 (2.1%), get_uri_detail_list: 1.63
        (0.3%), tests_pri_-1000: 15 (2.8%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 27 (5.0%), check_bayes: 25
        (4.8%), b_tokenize: 10 (1.9%), b_tok_get_all: 7 (1.4%), b_comp_prob:
        2.1 (0.4%), b_tok_touch_all: 3.9 (0.7%), b_finish: 0.62 (0.1%),
        tests_pri_0: 462 (86.7%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.64 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 1/6] proc: Rename in proc_inode rename sysctl_inodes sibling_inodes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I about to need and use the same functionality for pid based
inodes and there is no point in adding a second field when
this field is already here and serving the same purporse.

Just give the field a generic name so it is clear that
it is no longer sysctl specific.

Also for good measure initialize sibling_inodes when
proc_inode is initialized.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/inode.c       | 1 +
 fs/proc/internal.h    | 2 +-
 fs/proc/proc_sysctl.c | 8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 6da18316d209..bdae442d5262 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -68,6 +68,7 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 	ei->pde = NULL;
 	ei->sysctl = NULL;
 	ei->sysctl_entry = NULL;
+	INIT_HLIST_NODE(&ei->sibling_inodes);
 	ei->ns_ops = NULL;
 	return &ei->vfs_inode;
 }
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 41587276798e..366cd3aa690b 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -91,7 +91,7 @@ struct proc_inode {
 	struct proc_dir_entry *pde;
 	struct ctl_table_header *sysctl;
 	struct ctl_table *sysctl_entry;
-	struct hlist_node sysctl_inodes;
+	struct hlist_node sibling_inodes;
 	const struct proc_ns_operations *ns_ops;
 	struct inode vfs_inode;
 } __randomize_layout;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c75bb4632ed1..42fbb7f3c587 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -279,9 +279,9 @@ static void proc_sys_prune_dcache(struct ctl_table_header *head)
 		node = hlist_first_rcu(&head->inodes);
 		if (!node)
 			break;
-		ei = hlist_entry(node, struct proc_inode, sysctl_inodes);
+		ei = hlist_entry(node, struct proc_inode, sibling_inodes);
 		spin_lock(&sysctl_lock);
-		hlist_del_init_rcu(&ei->sysctl_inodes);
+		hlist_del_init_rcu(&ei->sibling_inodes);
 		spin_unlock(&sysctl_lock);
 
 		inode = &ei->vfs_inode;
@@ -483,7 +483,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	}
 	ei->sysctl = head;
 	ei->sysctl_entry = table;
-	hlist_add_head_rcu(&ei->sysctl_inodes, &head->inodes);
+	hlist_add_head_rcu(&ei->sibling_inodes, &head->inodes);
 	head->count++;
 	spin_unlock(&sysctl_lock);
 
@@ -514,7 +514,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 void proc_sys_evict_inode(struct inode *inode, struct ctl_table_header *head)
 {
 	spin_lock(&sysctl_lock);
-	hlist_del_init_rcu(&PROC_I(inode)->sysctl_inodes);
+	hlist_del_init_rcu(&PROC_I(inode)->sibling_inodes);
 	if (!--head->count)
 		kfree_rcu(head, rcu);
 	spin_unlock(&sysctl_lock);
-- 
2.25.0

