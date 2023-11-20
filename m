Return-Path: <linux-fsdevel+bounces-3258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465F7F1D13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5B5B219E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F70358AF;
	Mon, 20 Nov 2023 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqZkGqKS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A50D9;
	Mon, 20 Nov 2023 11:05:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c320a821c4so3953328b3a.2;
        Mon, 20 Nov 2023 11:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700507133; x=1701111933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXX0MKLkDEebdlfkZE+jNXZc24IkqI5TJn2fONoQMIw=;
        b=aqZkGqKSjzp9F7Y4U99LsXiIMZKMI8Ig+lF3/NGJLSq/cJV58za4et23mv4rH9e85f
         n7K5EMZYmfSr08TkDLaxkMrRUKtkQfrtULZOwB6uIY1t7sY3YGYZ65mPkpqLm23QDgIL
         P0bpOIYKuBvs4cseG1XKdBRqSlwDw+k9feGgZzmrzOh6fCjo9lNpzhhJfYYv/Mcm8XZb
         +fBQxidLaTnz9D6sBdjz5FkEvis8aKvris1nY3awzK/OOM3odL/TRXRklo462qnX2hNk
         FdYeHv00NIcY18CWaD2pKBXLzkeoHiZiuQgdpEGWWJxof8XGvaL2pwrIbYtrD7jqiXmq
         NgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507133; x=1701111933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXX0MKLkDEebdlfkZE+jNXZc24IkqI5TJn2fONoQMIw=;
        b=i4yIm0y0S1pFoa2WcbKZciNb77kUBqjZqRqy3vTcGJv1Peg3gqWdrm1Fdb61LDLAoQ
         Eqs17fmS4kXxWARW/lmt0HNLtABjQD0XTDjtVn0DNWOGQLNvilsuE5yGI59uLSR2o1ow
         czxk+A1VLC1/+/ogqxFLuRWVpe4D7Wf2A1pqD7QUXzwOFoncbGfEVOLb7Y4aoxKMtyYV
         Q2eqxv3Y8MHzOMFcR1yeTda5CodiVDfSSqEOM7cwMyRXj8pbEe1Qh8hdENW0HwBTg0Gk
         oDpUlvm6JJEusXUV3KcIcvx/m3jdt6uY+r6LgY1Dx/rUu0xEzTZBNrW5T1FIDnrpFx7n
         ehIQ==
X-Gm-Message-State: AOJu0Yw6dP6tqqQzX84H1wbqBdaRIjD6akdOPLjtXZe3g/5qdf9m+tVE
	UIcvGZGsW0JeGZ0fXWAPw1j5Z+DVOeo=
X-Google-Smtp-Source: AGHT+IFI2Fl3AM82bCAAV2r0JalSUmNpHjcQGsW240HFsw1sMzAyHbV9Xan0BBMBVjPwm1a/LzjR7w==
X-Received: by 2002:a62:7908:0:b0:6cb:a1fe:18c0 with SMTP id u8-20020a627908000000b006cba1fe18c0mr3590018pfc.8.1700507132822;
        Mon, 20 Nov 2023 11:05:32 -0800 (PST)
Received: from dw-tp.localdomain ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id y10-20020a62f24a000000b006c69851c7c9sm6353699pfl.181.2023.11.20.11.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:05:32 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
Date: Tue, 21 Nov 2023 00:35:20 +0530
Message-ID: <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700506526.git.ritesh.list@gmail.com>
References: <cover.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch converts ext2 regular file's buffered-io path to use iomap.
- buffered-io path using iomap_file_buffered_write
- DIO fallback to buffered-io now uses iomap_file_buffered_write
- writeback path now uses a new aops - ext2_file_aops
- truncate now uses iomap_truncate_page
- mmap path of ext2 continues to use generic_file_vm_ops

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/file.c  | 20 +++++++++++++--
 fs/ext2/inode.c | 68 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 4ddc36f4dbd4..ee5cd4a2f24f 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -252,7 +252,7 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		iocb->ki_flags &= ~IOCB_DIRECT;
 		pos = iocb->ki_pos;
-		status = generic_perform_write(iocb, from);
+		status = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
 		if (unlikely(status < 0)) {
 			ret = status;
 			goto out_unlock;
@@ -278,6 +278,22 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
+static ssize_t ext2_buffered_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
+{
+	ssize_t ret = 0;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret > 0)
+		ret = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
+	inode_unlock(inode);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+
 static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 #ifdef CONFIG_FS_DAX
@@ -299,7 +315,7 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return ext2_dio_write_iter(iocb, from);
 
-	return generic_file_write_iter(iocb, from);
+	return ext2_buffered_write_iter(iocb, from);
 }
 
 const struct file_operations ext2_file_operations = {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 464faf6c217e..b6224d94a7dd 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -879,10 +879,14 @@ ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 	if ((flags & IOMAP_DIRECT) && (flags & IOMAP_WRITE) && written == 0)
 		return -ENOTBLK;
 
-	if (iomap->type == IOMAP_MAPPED &&
-	    written < length &&
-	    (flags & IOMAP_WRITE))
+	if (iomap->type == IOMAP_MAPPED && written < length &&
+	   (flags & IOMAP_WRITE)) {
 		ext2_write_failed(inode->i_mapping, offset + length);
+		return 0;
+	}
+
+	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
+		mark_inode_dirty(inode);
 	return 0;
 }
 
@@ -914,6 +918,16 @@ static void ext2_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, ext2_get_block);
 }
 
+static int ext2_file_read_folio(struct file *file, struct folio *folio)
+{
+	return iomap_read_folio(folio, &ext2_iomap_ops);
+}
+
+static void ext2_file_readahead(struct readahead_control *rac)
+{
+	return iomap_readahead(rac, &ext2_iomap_ops);
+}
+
 static int
 ext2_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
@@ -943,12 +957,40 @@ static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
 
+static sector_t ext2_file_bmap(struct address_space *mapping, sector_t block)
+{
+	return iomap_bmap(mapping, block, &ext2_iomap_ops);
+}
+
 static int
 ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	return mpage_writepages(mapping, wbc, ext2_get_block);
 }
 
+static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
+				 struct inode *inode, loff_t offset)
+{
+	if (offset >= wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length)
+		return 0;
+
+	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
+				IOMAP_WRITE, &wpc->iomap, NULL);
+}
+
+static const struct iomap_writeback_ops ext2_writeback_ops = {
+	.map_blocks		= ext2_write_map_blocks,
+};
+
+static int ext2_file_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = { };
+
+	return iomap_writepages(mapping, wbc, &wpc, &ext2_writeback_ops);
+}
+
 static int
 ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
@@ -957,6 +999,20 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
 	return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 }
 
+const struct address_space_operations ext2_file_aops = {
+	.dirty_folio		= iomap_dirty_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.read_folio		= ext2_file_read_folio,
+	.readahead		= ext2_file_readahead,
+	.bmap			= ext2_file_bmap,
+	.direct_IO		= noop_direct_IO,
+	.writepages		= ext2_file_writepages,
+	.migrate_folio		= filemap_migrate_folio,
+	.is_partially_uptodate	= iomap_is_partially_uptodate,
+	.error_remove_page	= generic_error_remove_page,
+};
+
 const struct address_space_operations ext2_aops = {
 	.dirty_folio		= block_dirty_folio,
 	.invalidate_folio	= block_invalidate_folio,
@@ -1281,8 +1337,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 		error = dax_truncate_page(inode, newsize, NULL,
 					  &ext2_iomap_ops);
 	else
-		error = block_truncate_page(inode->i_mapping,
-				newsize, ext2_get_block);
+		error = iomap_truncate_page(inode, newsize, NULL,
+					    &ext2_iomap_ops);
 	if (error)
 		return error;
 
@@ -1372,7 +1428,7 @@ void ext2_set_file_ops(struct inode *inode)
 	if (IS_DAX(inode))
 		inode->i_mapping->a_ops = &ext2_dax_aops;
 	else
-		inode->i_mapping->a_ops = &ext2_aops;
+		inode->i_mapping->a_ops = &ext2_file_aops;
 }
 
 struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
-- 
2.41.0


