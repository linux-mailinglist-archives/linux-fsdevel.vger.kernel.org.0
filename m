Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619BB1668FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgBTUvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:51:54 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34144 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgBTUvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:51:54 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4snZ-0006Pe-Ka; Thu, 20 Feb 2020 13:51:53 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4snY-0005Ze-Lt; Thu, 20 Feb 2020 13:51:53 -0700
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
Date:   Thu, 20 Feb 2020 14:49:53 -0600
In-Reply-To: <871rqpaswu.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 20 Feb 2020 14:46:25 -0600")
Message-ID: <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j4snY-0005Ze-Lt;;;mid=<87blpt9e6m.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0jzXheB+9rojm9OHQfM0H+L/hnF6cm6M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 538 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.3 (0.6%), b_tie_ro: 2.3 (0.4%), parse: 1.02
        (0.2%), extract_message_metadata: 11 (2.1%), get_uri_detail_list: 1.95
        (0.4%), tests_pri_-1000: 14 (2.7%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 29 (5.4%), check_bayes: 28
        (5.2%), b_tokenize: 11 (2.0%), b_tok_get_all: 8 (1.5%), b_comp_prob:
        2.5 (0.5%), b_tok_touch_all: 4.2 (0.8%), b_finish: 0.66 (0.1%),
        tests_pri_0: 466 (86.5%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.79 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The function d_prune_aliases has the problem that it will only prune
aliases thare are completely unused.  It will not remove aliases for
the dcache or even think of removing mounts from the dcache.  For that
behavior d_invalidate is needed.

To use d_invalidate replace d_prune_aliases with d_find_alias
followed by d_invalidate and dput.  This is safe and complete
because no inode in proc has any hardlinks or aliases.

To make this behavior change clear rename
proc_prune_siblings_dache proc_invalidate_siblings_dcache,
and rename proc_sys_prune_dcache proc_sys_invalidate_dcache.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/inode.c       | 9 +++++++--
 fs/proc/internal.h    | 2 +-
 fs/proc/proc_sysctl.c | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 38a7baa41aba..c4528c419876 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -103,12 +103,13 @@ void __init proc_init_kmemcache(void)
 	BUILD_BUG_ON(sizeof(struct proc_dir_entry) >= SIZEOF_PDE);
 }
 
-void proc_prune_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
+void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
 {
 	struct inode *inode;
 	struct proc_inode *ei;
 	struct hlist_node *node;
 	struct super_block *sb;
+	struct dentry *dentry;
 
 	for (;;) {
 		rcu_read_lock();
@@ -135,7 +136,11 @@ void proc_prune_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
 			continue;
 		}
 
-		d_prune_aliases(inode);
+		dentry = d_find_alias(inode);
+		if (dentry) {
+			d_invalidate(dentry);
+			dput(dentry);
+		}
 		iput(inode);
 		deactivate_super(sb);
 	}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index ba9a991824a5..fd470172675f 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -210,7 +210,7 @@ extern const struct inode_operations proc_pid_link_inode_operations;
 extern const struct super_operations proc_sops;
 
 void proc_init_kmemcache(void);
-void proc_prune_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock);
+void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock);
 void set_proc_pid_nlink(void);
 extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry *);
 extern void proc_entry_rundown(struct proc_dir_entry *);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5da9d7f7ae34..b6f5d459b087 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -267,9 +267,9 @@ static void unuse_table(struct ctl_table_header *p)
 			complete(p->unregistering);
 }
 
-static void proc_sys_prune_dcache(struct ctl_table_header *head)
+static void proc_sys_invalidate_dcache(struct ctl_table_header *head)
 {
-	proc_prune_siblings_dcache(&head->inodes, &sysctl_lock);
+	proc_invalidate_siblings_dcache(&head->inodes, &sysctl_lock);
 }
 
 /* called under sysctl_lock, will reacquire if has to wait */
@@ -291,10 +291,10 @@ static void start_unregistering(struct ctl_table_header *p)
 		spin_unlock(&sysctl_lock);
 	}
 	/*
-	 * Prune dentries for unregistered sysctls: namespaced sysctls
+	 * Invalidate dentries for unregistered sysctls: namespaced sysctls
 	 * can have duplicate names and contaminate dcache very badly.
 	 */
-	proc_sys_prune_dcache(p);
+	proc_sys_invalidate_dcache(p);
 	/*
 	 * do not remove from the list until nobody holds it; walking the
 	 * list in do_sysctl() relies on that.
-- 
2.20.1

