Return-Path: <linux-fsdevel+bounces-4320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266897FE855
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 05:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590AAB20C0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09F1DA2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz6gylYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C281B4;
	Wed, 29 Nov 2023 19:24:41 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c6282f8d95so57679a12.0;
        Wed, 29 Nov 2023 19:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701314680; x=1701919480; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kAj6yJvu05E6Xi0f/eguW2krx+48+fiAiYpVUT1CErk=;
        b=mz6gylYUqllinNxXYd7zw3IkdIXXfx2Z31vW4rdLtsfy2Kfr2Sysy4Bj/14TCk6nce
         sRucSILzEdzZxQc9Ie31QX8x0Be9c4c0nGave0jsCrLMZDyO9rw69YgUUAAhDbMnJAuF
         03XffEHhuKsPt1hioW4dBpZuQOgcnLYD4hWXVZ1Utzwx2a+41eDp7qpHp8n+lCrsUg7F
         6gRQSOiby8guWNd/JvPqHZzwdrdTDCWqLlv90DzcIEuZ+3EbxYCSP0BOUSxmP0wGJ5uI
         YxEQpIewcwuFxSLXSbO7d0DlEyogaLL5wrPI2QdnnBCmdkXQLCMwNuRPseeGCe3XTxmx
         kOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701314680; x=1701919480;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAj6yJvu05E6Xi0f/eguW2krx+48+fiAiYpVUT1CErk=;
        b=tyId2Iz1knhK9fRBuWuSDbAYQay4vgKfzb5DVOOydmTcaBrVetcxCdLDPPkumVqk/c
         iqcRLWEGyE4EVX38P7+vuaUpnf4XGvFGZ3uu/LX+d/4g6i/xhD8n9QQnadmaMrPZ44Wa
         x400MyyN49ENzboalsJAmkRkciXEjuIkjcKrhi3sAYtv0q+5x43eMaNjZk1HMI/FJ0GM
         EP+9+UOgFMr3XebnaunVCKP3VNt27iVaUE2Lqe/jcd8Cfqj7I72oZBjKpsmsTBSH59CI
         c4mV3OdrEePi56PeWr4o6EwCIBmE2U0W/wewVqfRMxixM+ojCWupE69Ako1+3JzccUOf
         7Yaw==
X-Gm-Message-State: AOJu0YwXpNJbD0LowBkW24OuvE0ddHJxXWEIbq4Xhx8tVVEuffKRQqL1
	kWpVQrZgZmf3WffqMa//TDZpx9A7AbKQlw==
X-Google-Smtp-Source: AGHT+IE4scPAT5jh/AKx8q/d+FSaN9Lv1/1W3sFH6eeXa5PugvOS6AwFlaaLGvWU163vYdPgJwGavg==
X-Received: by 2002:a17:90a:e004:b0:285:be58:6abb with SMTP id u4-20020a17090ae00400b00285be586abbmr15958468pjy.24.1701314679681;
        Wed, 29 Nov 2023 19:24:39 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090aec0800b002839a4f65c5sm201310pjy.30.2023.11.29.19.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 19:24:38 -0800 (PST)
Date: Thu, 30 Nov 2023 08:54:31 +0530
Message-Id: <8734wnj53k.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <87msv5r0uq.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Christoph Hellwig <hch@infradead.org> writes:
>
>> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
>>> writeback bit set. XFS plays the revalidation sequence counter games
>>> because of this so we'd have to do something similar for ext2. Not that I'd
>>> care as much about ext2 writeback performance but it should not be that
>>> hard and we'll definitely need some similar solution for ext4 anyway. Can
>>> you give that a try (as a followup "performance improvement" patch).
>>
>> Darrick has mentioned that he is looking into lifting more of the
>> validation sequence counter validation into iomap.
>>
>> In the meantime I have a series here that at least maps multiple blocks
>> inside a folio in a single go, which might be worth trying with ext2 as
>> well:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/iomap-map-multiple-blocks
>
> Sure, thanks for providing details. I will check this.
>

So I took a look at this. Here is what I think -
So this is useful of-course when we have a large folio. Because
otherwise it's just one block at a time for each folio. This is not a
problem once FS buffered-io handling code moves to iomap (because we
can then enable large folio support to it).

However, this would still require us to pass a folio to ->map_blocks
call to determine the size of the folio (which I am not saying can't be
done but just stating my observations here).

Now coming to implementing validation seq check. I am hoping, it should
be straight forward at least for ext2, because it mostly just have to
protect against truncate operation (which can change the block mapping)...

...ok so here is the PoC for seq counter check for ext2. Next let me
try to see if we can lift this up from the FS side to iomap - 


From 86b7bdf79107c3d0a4f37583121d7c136db1bc5c Mon Sep 17 00:00:00 2001
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] ext2: Implement seq check for mapping multiblocks in ->map_blocks

This implements inode block seq counter (ib_seq) which helps in validating 
whether the cached wpc (struct iomap_writepage_ctx) still has the valid 
entries or not. Block mapping can get changed say due to a racing truncate. 

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/balloc.c |  1 +
 fs/ext2/ext2.h   |  6 ++++++
 fs/ext2/inode.c  | 51 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/ext2/super.c  |  2 +-
 4 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index e124f3d709b2..e97040194da4 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -495,6 +495,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 	}
 
 	ext2_debug ("freeing block(s) %lu-%lu\n", block, block + count - 1);
+	ext2_inc_ib_seq(EXT2_I(inode));
 
 do_more:
 	overflow = 0;
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 677a9ad45dcb..882c14d20183 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -663,6 +663,7 @@ struct ext2_inode_info {
 	struct rw_semaphore xattr_sem;
 #endif
 	rwlock_t i_meta_lock;
+	unsigned int ib_seq;
 
 	/*
 	 * truncate_mutex is for serialising ext2_truncate() against
@@ -698,6 +699,11 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
 	return container_of(inode, struct ext2_inode_info, vfs_inode);
 }
 
+static inline void ext2_inc_ib_seq(struct ext2_inode_info *ei)
+{
+	WRITE_ONCE(ei->ib_seq, READ_ONCE(ei->ib_seq) + 1);
+}
+
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index f4e0b9a93095..a5490d641c26 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -406,6 +406,8 @@ static int ext2_alloc_blocks(struct inode *inode,
 	ext2_fsblk_t current_block = 0;
 	int ret = 0;
 
+	ext2_inc_ib_seq(EXT2_I(inode));
+
 	/*
 	 * Here we try to allocate the requested multiple blocks at once,
 	 * on a best-effort basis.
@@ -966,14 +968,53 @@ ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	return mpage_writepages(mapping, wbc, ext2_get_block);
 }
 
+struct ext2_writepage_ctx {
+	struct iomap_writepage_ctx ctx;
+	unsigned int		ib_seq;
+};
+
+static inline
+struct ext2_writepage_ctx *EXT2_WPC(struct iomap_writepage_ctx *ctx)
+{
+	return container_of(ctx, struct ext2_writepage_ctx, ctx);
+}
+
+static bool ext2_imap_valid(struct iomap_writepage_ctx *wpc, struct inode *inode,
+			    loff_t offset)
+{
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length)
+		return false;
+
+	if (EXT2_WPC(wpc)->ib_seq != READ_ONCE(EXT2_I(inode)->ib_seq))
+		return false;
+
+	return true;
+}
+
 static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
 				 struct inode *inode, loff_t offset)
 {
-	if (offset >= wpc->iomap.offset &&
-	    offset < wpc->iomap.offset + wpc->iomap.length)
+	loff_t maxblocks = (loff_t)INT_MAX;
+	u8 blkbits = inode->i_blkbits;
+	u32 bno;
+	bool new, boundary;
+	int ret;
+
+	if (ext2_imap_valid(wpc, inode, offset))
 		return 0;
 
-	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
+	EXT2_WPC(wpc)->ib_seq = READ_ONCE(EXT2_I(inode)->ib_seq);
+
+	ret = ext2_get_blocks(inode, offset >> blkbits, maxblocks << blkbits,
+			      &bno, &new, &boundary, 0);
+	if (ret < 0)
+		return ret;
+	/*
+	 * ret can be 0 in case of a hole which is possible for mmaped writes.
+	 */
+	ret = ret ? ret : 1;
+	return ext2_iomap_begin(inode, offset, (loff_t)ret << blkbits,
 				IOMAP_WRITE, &wpc->iomap, NULL);
 }
 
@@ -984,9 +1025,9 @@ static const struct iomap_writeback_ops ext2_writeback_ops = {
 static int ext2_file_writepages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct ext2_writepage_ctx wpc = { };
 
-	return iomap_writepages(mapping, wbc, &wpc, &ext2_writeback_ops);
+	return iomap_writepages(mapping, wbc, &wpc.ctx, &ext2_writeback_ops);
 }
 
 static int
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 645ee6142f69..cd1d1678e35b 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -188,7 +188,7 @@ static struct inode *ext2_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_QUOTA
 	memset(&ei->i_dquot, 0, sizeof(ei->i_dquot));
 #endif
-
+	WRITE_ONCE(ei->ib_seq, 0);
 	return &ei->vfs_inode;
 }
 

2.30.2



