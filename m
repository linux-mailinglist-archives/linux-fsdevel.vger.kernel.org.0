Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C668B6BD28A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjCPOki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCPOkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:40:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA251A66D
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 07:40:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id y2so1844373pjg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678977636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyW2SvG3UTDKocelVyPa5DVOdPH4lrK1qG7JAvJlCt4=;
        b=KXn5Z5Zz2m0BEouHiaU7orh8kgiH5oNwjhbmPff045mNOy+nvi2/EqjbTGIF4oA5MI
         wPRx6MyzafwxjHTxqG/ZwZSzBLQlTS55Pvy5+USXiszPam3wCW96uLggtt58LfPkDDub
         1wADiUSbuC8W7r4TFx9QcKizebuG1+qasdCV3YimHRgJQT9eyX4s9i86nIooHSwx0U7D
         Om2Mtw/fXjULafq+cbSzRPvbXdVz5fGeyij9btA0exHOQpm0Sac/O9MJoxvxyuJ89Pz+
         am/fKXg8c4NjO4k8FUVd3Ulf0C67Iu8uBNYfA5WHTCy/vYsIRngTcyg4QdWMPIaMoRta
         9J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678977636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyW2SvG3UTDKocelVyPa5DVOdPH4lrK1qG7JAvJlCt4=;
        b=7wOoY1kuT9O7RDB4j4Bb0DoZJvJax41EDUpXSwZKy/OHGgllgwAnZhPMC3s0tzeQym
         09BazBIEFDal3c5F+OV7o44TqDkj2T35OdSnwHl8tCoLnTBduAgVLQTltLjw2u4FlJmC
         NaNxRml0JEQ9JRIXA4z6QNdpXeIIfqDGNi2mUbSTWhziaGkUfRcyq92ATwZhWKvhQ0jP
         d9AvbAQ3ZRAK6+2uqzpi9at/ko6K9MQvcIVeSS4N2wUwzOHlqk9VkQvoNg7q/jmxu7+t
         RnYo1K9z4U1icORIsoqHwheeFYHh5csVryBKZU8iHbs58AXx8a+vQi+KajC4IaLIAyLA
         Wd1g==
X-Gm-Message-State: AO0yUKW8IwqJaRY8r6BxqhDnGwiz3fJ2kToqOx3U/MvThiQTBE7Etp4v
        AdCslRH1PNkk4jTYlqzEC/Q=
X-Google-Smtp-Source: AK7set/826oEA2tueYXZwLzCSMlrVyJc9HehZR8zeCuRt8B8KYw0NaLf8dw6IH2Z4mG6trWOME9fKQ==
X-Received: by 2002:a17:90b:4d05:b0:237:50b6:9843 with SMTP id mw5-20020a17090b4d0500b0023750b69843mr4142451pjb.0.1678977635896;
        Thu, 16 Mar 2023 07:40:35 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090a654100b0023670dbb82fsm3306736pjs.25.2023.03.16.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:40:35 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1][WIP] ext2: Move direct-io to use iomap
Date:   Thu, 16 Mar 2023 20:10:29 +0530
Message-Id: <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87ttz889ns.fsf@doe.com>
References: <87ttz889ns.fsf@doe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[DO NOT MERGE] [WORK-IN-PROGRESS]

Hello Jan,

This is an initial version of the patch set which I wanted to share
before today's call. This is still work in progress but atleast passes
the set of test cases which I had kept for dio testing (except 1 from my
list).

Looks like there won't be much/any changes required from iomap side to
support ext2 moving to iomap apis.

I will be doing some more testing specifically test generic/083 which is
occassionally failing in my testing.
Also once this is stabilized, I can do some performance testing too if you
feel so. Last I remembered we saw some performance regressions when ext4
moved to iomap for dio.

PS: Please ignore if there are some silly mistakes. As I said, I wanted
to get this out before today's discussion. :)

Thanks for your help!!

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/ext2.h  |   1 +
 fs/ext2/file.c  | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/inode.c |  20 +--------
 3 files changed, 117 insertions(+), 18 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index cb78d7dcfb95..cb5e309fe040 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -753,6 +753,7 @@ extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
 extern struct inode *ext2_iget (struct super_block *, unsigned long);
 extern int ext2_write_inode (struct inode *, struct writeback_control *);
 extern void ext2_evict_inode(struct inode *);
+extern void ext2_write_failed(struct address_space *mapping, loff_t to);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
 extern int ext2_getattr (struct mnt_idmap *, const struct path *,
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 6b4bebe982ca..7a8561304559 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -161,12 +161,123 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return ret;
 }

+static ssize_t ext2_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	ssize_t ret;
+
+	inode_lock_shared(inode);
+	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
+				 int error, unsigned int flags)
+{
+	loff_t pos = iocb->ki_pos;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error)
+		return error;
+
+	pos += size;
+	if (pos > i_size_read(inode))
+		i_size_write(inode, pos);
+
+	return 0;
+}
+
+static const struct iomap_dio_ops ext2_dio_write_ops = {
+	.end_io = ext2_dio_write_end_io,
+};
+
+static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	ssize_t ret;
+	unsigned int flags;
+	unsigned long blocksize = inode->i_sb->s_blocksize;
+	loff_t offset = iocb->ki_pos;
+	loff_t count = iov_iter_count(from);
+
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_unlock;
+	ret = file_remove_privs(file);
+	if (ret)
+		goto out_unlock;
+	ret = file_update_time(file);
+	if (ret)
+		goto out_unlock;
+
+	/*
+	 * We pass IOMAP_DIO_NOSYNC because otherwise iomap_dio_rw()
+	 * calls for generic_write_sync in iomap_dio_complete().
+	 * Since ext2_fsync nmust be called w/o inode lock,
+	 * hence we pass IOMAP_DIO_NOSYNC and handle generic_write_sync()
+	 * ourselves.
+	 */
+	flags = IOMAP_DIO_NOSYNC;
+
+	/* use IOMAP_DIO_FORCE_WAIT for unaligned of extending writes */
+	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
+	   (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize)))
+		flags |= IOMAP_DIO_FORCE_WAIT;
+
+	ret = iomap_dio_rw(iocb, from, &ext2_iomap_ops, &ext2_dio_write_ops,
+			   flags, NULL, 0);
+
+	if (ret == -ENOTBLK)
+		ret = 0;
+
+	if (ret < 0 && ret != -EIOCBQUEUED)
+		ext2_write_failed(inode->i_mapping, offset + count);
+
+	/* handle case for partial write or fallback to buffered write */
+	if (ret >= 0 && iov_iter_count(from)) {
+		loff_t pos, endbyte;
+		ssize_t status;
+		ssize_t ret2;
+
+		pos = iocb->ki_pos;
+		status = generic_perform_write(iocb, from);
+		if (unlikely(status < 0)) {
+			ret = status;
+			goto out_unlock;
+		}
+		endbyte = pos + status - 1;
+		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
+						    endbyte);
+		if (ret2 == 0) {
+			iocb->ki_pos = endbyte + 1;
+			ret += status;
+			invalidate_mapping_pages(inode->i_mapping,
+						 pos >> PAGE_SHIFT,
+						 endbyte >> PAGE_SHIFT);
+		}
+	}
+out_unlock:
+	inode_unlock(inode);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+
 static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 #ifdef CONFIG_FS_DAX
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_read_iter(iocb, to);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext2_dio_read_iter(iocb, to);
+
 	return generic_file_read_iter(iocb, to);
 }

@@ -176,6 +287,9 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_write_iter(iocb, from);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext2_dio_write_iter(iocb, from);
+
 	return generic_file_write_iter(iocb, from);
 }

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 26f135e7ffce..7ff669d0b6d2 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -56,7 +56,7 @@ static inline int ext2_inode_is_fast_symlink(struct inode *inode)

 static void ext2_truncate_blocks(struct inode *inode, loff_t offset);

-static void ext2_write_failed(struct address_space *mapping, loff_t to)
+void ext2_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;

@@ -908,22 +908,6 @@ static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }

-static ssize_t
-ext2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	size_t count = iov_iter_count(iter);
-	loff_t offset = iocb->ki_pos;
-	ssize_t ret;
-
-	ret = blockdev_direct_IO(iocb, inode, iter, ext2_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
-		ext2_write_failed(mapping, offset + count);
-	return ret;
-}
-
 static int
 ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
@@ -946,7 +930,7 @@ const struct address_space_operations ext2_aops = {
 	.write_begin		= ext2_write_begin,
 	.write_end		= ext2_write_end,
 	.bmap			= ext2_bmap,
-	.direct_IO		= ext2_direct_IO,
+	.direct_IO		= noop_direct_IO,
 	.writepages		= ext2_writepages,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
--
2.39.2

