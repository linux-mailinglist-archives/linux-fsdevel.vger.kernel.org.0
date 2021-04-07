Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4E35771C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhDGVqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 17:46:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44583 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234143AbhDGVqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:46:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 482455C005D;
        Wed,  7 Apr 2021 17:46:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Apr 2021 17:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=BSlRvWdKiUN+u
        S17kDchw8iKNxB+3LsjnL5ICnMGYJI=; b=Y0QqS0hxPXBX/OuXcoCv701p9Q7LS
        GsFyABqe3JyksYig1rSAwFwI/cVlZ+bA6ge+Be7FwOV22KhYWoat36tFlo36V8fG
        L7r3N9/kkZHZrtGp6aGE2xdWac5Z8xlpJhWxThboAT42hXUwQQn6OpamFpscWxg5
        rwPGzErIgjNBbE3sqJ3zskyZT+/kL/uJZlvCoGz+8AoHlHpxYGR5+DneR42TM07x
        P4vmmIlLtutjeOB56fN7vobbh9W4ko7E8e8DwowC0OW9cQkRAjQcQmaASYP37vbT
        GL4UGOtjT9pcWLQKA12F6veMMEChj4hT8FXv1A2AVKcg4Z6xODaYBVZrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=BSlRvWdKiUN+uS17kDchw8iKNxB+3LsjnL5ICnMGYJI=; b=D0JAqJGF
        ImGVY1iym9knuB7JC8X85hqZswvL//BO2P/Ux2pS8r8nhKj+8ot5N5GVsttqmK0S
        XP1ddJX4EKZNr3Garj/5xg5scsupXRday7+Clgp7vCEk4rqOLpfyE0ECPwyGvo9J
        n1YoSGevKbuNPOX2rewvmh5Dqyojfps/qtRM8fhA1cqQwQBRpHz6lGGJAYRuurY9
        L20ID0Yu4eBomxAv6PTmKLjM7nTrJ+bEmwTg1KCzdJK2BunnUbgtfo9G/rmcrUpZ
        VjfYWF4qOwhvbZPNZmXWmc/k2YNrZVB87pzzJ++SXRjxoMKEK+cBwRdFn8FGwtaj
        1PqXjM0B6e8TDw==
X-ME-Sender: <xms:PShuYOTXFzxvyO0SbKNu5ftiU9cX_xEPpyEf7vkTv0OHQRpwDHQDDQ>
    <xme:PShuYEcy_U43HWN2eG2Cr1OHigb0PI3_0DcQytok3KtIjLNqPuOk1bSk5l3RzNiAc
    kQuT8IsX86w99BTrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejkedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucfkphepudeifedruddugedr
    udefvddrjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:PShuYKAGI1C2pyvng_Le8CmuVjC1EOSle7cdHE-dkn8gbfFZRVi5bQ>
    <xmx:PShuYOnxqsS0D5WBBO8WCi1JfC13Z9KEEcWFMHS3k826hH7VPJilPg>
    <xmx:PShuYNexxtZLA4bVZ1OeQPnlw9Qv6Pif1wZPg7AdbHYmqvGD4HlZsg>
    <xmx:PShuYE7WAM2l0wzyRsVobZBuPohp-wZXrenArNcHlPLg9YDmgbdIIA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A0C924005C;
        Wed,  7 Apr 2021 17:46:35 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Date:   Wed,  7 Apr 2021 14:46:11 -0700
Message-Id: <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1617831474.git.dxu@dxuuu.xyz>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit introduces the bpf page cache iterator. This iterator allows
users to run a bpf prog against each page in the "page cache".
Internally, the "page cache" is extremely tied to VFS superblock + inode
combo. Because of this, iter_pagecache will only examine pages in the
caller's mount namespace.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/Makefile         |   2 +-
 kernel/bpf/pagecache_iter.c | 293 ++++++++++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/pagecache_iter.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7f33098ca63f..3deb6a8d3f75 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o pagecache_iter.o map_iter.o task_iter.o prog_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
diff --git a/kernel/bpf/pagecache_iter.c b/kernel/bpf/pagecache_iter.c
new file mode 100644
index 000000000000..8442ab0d4221
--- /dev/null
+++ b/kernel/bpf/pagecache_iter.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/init.h>
+#include <linux/mm_types.h>
+#include <linux/mnt_namespace.h>
+#include <linux/nsproxy.h>
+#include <linux/pagemap.h>
+#include <linux/radix-tree.h>
+#include <linux/seq_file.h>
+#include "../../fs/mount.h"
+
+struct bpf_iter_seq_pagecache_info {
+	struct mnt_namespace *ns;
+	struct radix_tree_root superblocks;
+	struct super_block *cur_sb;
+	struct inode *cur_inode;
+	unsigned long cur_page_idx;
+};
+
+static struct super_block *goto_next_sb(struct bpf_iter_seq_pagecache_info *info)
+{
+	struct super_block *sb = NULL;
+	struct radix_tree_iter iter;
+	void **slot;
+
+	radix_tree_for_each_slot(slot, &info->superblocks, &iter,
+				 ((unsigned long)info->cur_sb + 1)) {
+		sb = (struct super_block *)iter.index;
+		break;
+	}
+
+	info->cur_sb = sb;
+	info->cur_inode = NULL;
+	info->cur_page_idx = 0;
+	return sb;
+}
+
+static bool inode_unusual(struct inode *inode) {
+	return ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		(inode->i_mapping->nrpages == 0));
+}
+
+static struct inode *goto_next_inode(struct bpf_iter_seq_pagecache_info *info)
+{
+	struct inode *prev_inode = info->cur_inode;
+	struct inode *inode;
+
+retry:
+	BUG_ON(!info->cur_sb);
+	spin_lock(&info->cur_sb->s_inode_list_lock);
+
+	if (!info->cur_inode) {
+		list_for_each_entry(inode, &info->cur_sb->s_inodes, i_sb_list) {
+			spin_lock(&inode->i_lock);
+			if (inode_unusual(inode)) {
+				spin_unlock(&inode->i_lock);
+				continue;
+			}
+			__iget(inode);
+			spin_unlock(&inode->i_lock);
+			info->cur_inode = inode;
+			break;
+		}
+	} else {
+		inode = info->cur_inode;
+		info->cur_inode = NULL;
+		list_for_each_entry_continue(inode, &info->cur_sb->s_inodes,
+					     i_sb_list) {
+			spin_lock(&inode->i_lock);
+			if (inode_unusual(inode)) {
+				spin_unlock(&inode->i_lock);
+				continue;
+			}
+			__iget(inode);
+			spin_unlock(&inode->i_lock);
+			info->cur_inode = inode;
+			break;
+		}
+	}
+
+	/* Seen all inodes in this superblock */
+	if (!info->cur_inode) {
+		spin_unlock(&info->cur_sb->s_inode_list_lock);
+		if (!goto_next_sb(info)) {
+			inode = NULL;
+			goto out;
+		}
+
+		goto retry;
+	}
+
+	spin_unlock(&info->cur_sb->s_inode_list_lock);
+	info->cur_page_idx = 0;
+out:
+	iput(prev_inode);
+	return info->cur_inode;
+}
+
+static struct page *goto_next_page(struct bpf_iter_seq_pagecache_info *info)
+{
+	struct page *page, *ret = NULL;
+	unsigned long idx;
+
+	rcu_read_lock();
+retry:
+	BUG_ON(!info->cur_inode);
+	ret = NULL;
+	xa_for_each_start(&info->cur_inode->i_data.i_pages, idx, page,
+			  info->cur_page_idx) {
+		if (!page_cache_get_speculative(page))
+			continue;
+
+		ret = page;
+		info->cur_page_idx = idx + 1;
+		break;
+	}
+
+	if (!ret) {
+		/* Seen all inodes and superblocks */
+		if (!goto_next_inode(info))
+			goto out;
+
+		goto retry;
+	}
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static void *pagecache_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpf_iter_seq_pagecache_info *info = seq->private;
+	struct page *page;
+
+	if (!info->cur_sb && !goto_next_sb(info))
+		return NULL;
+	if (!info->cur_inode && !goto_next_inode(info))
+		return NULL;
+
+	page = goto_next_page(info);
+	if (!page)
+		return NULL;
+
+	if (*pos == 0)
+		++*pos;
+
+	return page;
+
+}
+
+static void *pagecache_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpf_iter_seq_pagecache_info *info = seq->private;
+	struct page *page;
+
+	++*pos;
+	put_page((struct page *)v);
+	page = goto_next_page(info);
+	if (!page)
+		return NULL;
+
+	return page;
+}
+
+struct bpf_iter__pagecache {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct page *, page);
+};
+
+DEFINE_BPF_ITER_FUNC(pagecache, struct bpf_iter_meta *meta, struct page *page)
+
+static int __pagecache_seq_show(struct seq_file *seq, struct page *page,
+				bool in_stop)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_iter__pagecache ctx;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, in_stop);
+	if (!prog)
+		return 0;
+
+	meta.seq = seq;
+	ctx.meta = &meta;
+	ctx.page = page;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int pagecache_seq_show(struct seq_file *seq, void *v)
+{
+	return __pagecache_seq_show(seq, v, false);
+}
+
+static void pagecache_seq_stop(struct seq_file *seq, void *v)
+{
+	(void)__pagecache_seq_show(seq, v, true);
+	if (v)
+		put_page((struct page *)v);
+}
+
+static int init_seq_pagecache(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	struct bpf_iter_seq_pagecache_info *info = priv_data;
+	struct radix_tree_iter iter;
+	struct super_block *sb;
+	struct mount *mnt;
+	void **slot;
+	int err;
+
+	info->ns = current->nsproxy->mnt_ns;
+	get_mnt_ns(info->ns);
+	INIT_RADIX_TREE(&info->superblocks, GFP_KERNEL);
+
+	spin_lock(&info->ns->ns_lock);
+	list_for_each_entry(mnt, &info->ns->list, mnt_list) {
+		sb = mnt->mnt.mnt_sb;
+
+		/* The same mount may be mounted in multiple places */
+		if (radix_tree_lookup(&info->superblocks, (unsigned long)sb))
+			continue;
+
+		err = radix_tree_insert(&info->superblocks,
+				        (unsigned long)sb, (void *)1);
+		if (err)
+			goto out;
+	}
+
+	radix_tree_for_each_slot(slot, &info->superblocks, &iter, 0) {
+		sb = (struct super_block *)iter.index;
+		atomic_inc(&sb->s_active);
+	}
+
+	err = 0;
+out:
+	spin_unlock(&info->ns->ns_lock);
+	return err;
+}
+
+static void fini_seq_pagecache(void *priv_data)
+{
+	struct bpf_iter_seq_pagecache_info *info = priv_data;
+	struct radix_tree_iter iter;
+	struct super_block *sb;
+	void **slot;
+
+	radix_tree_for_each_slot(slot, &info->superblocks, &iter, 0) {
+		sb = (struct super_block *)iter.index;
+		atomic_dec(&sb->s_active);
+		radix_tree_delete(&info->superblocks, iter.index);
+	}
+
+	put_mnt_ns(info->ns);
+}
+
+static const struct seq_operations pagecache_seq_ops = {
+	.start	= pagecache_seq_start,
+	.next	= pagecache_seq_next,
+	.stop	= pagecache_seq_stop,
+	.show	= pagecache_seq_show,
+};
+
+static const struct bpf_iter_seq_info pagecache_seq_info = {
+	.seq_ops		= &pagecache_seq_ops,
+	.init_seq_private	= init_seq_pagecache,
+	.fini_seq_private	= fini_seq_pagecache,
+	.seq_priv_size		= sizeof(struct bpf_iter_seq_pagecache_info),
+};
+
+static struct bpf_iter_reg pagecache_reg_info = {
+	.target			= "pagecache",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__pagecache, page),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		= &pagecache_seq_info,
+};
+
+BTF_ID_LIST(btf_page_id)
+BTF_ID(struct, page)
+
+static int __init bpf_pagecache_iter_init(void)
+{
+	pagecache_reg_info.ctx_arg_info[0].btf_id = *btf_page_id;
+	return bpf_iter_reg_target(&pagecache_reg_info);
+}
+
+late_initcall(bpf_pagecache_iter_init);
-- 
2.26.3

