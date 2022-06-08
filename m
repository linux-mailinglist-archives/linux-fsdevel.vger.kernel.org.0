Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5C542698
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiFHGoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbiFHGEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:04:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EB126EE99
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654664355; x=1686200355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0SMWDuWsxE3dyExXGKJTZLDWsylNdk2ZwEaW5DIMC38=;
  b=fGb+YE/mYPJ6lIDzrIPMxj87sFaaMZ8MDykqd0x+KHdkkhDtvbmK8Pvx
   JeuVqKovoiZZlM9ORX0Mm6loxqIknt1qLea8DKPkrtu4OvHEY2RxVTarG
   rOZlakEMISMEgB+ja3D5tnkjSfZvHqvCJwi7NHbJFUWTZmQAxJgQO8uS/
   9x4nlXT9wBKdMUwdcAvS0BDRGjId9UXZfjWpxIGfZ4HZ8zpp6WTcSvs9x
   4BjcAXYsxLVBwNKivMyPiKYxmAvWJFlziw7KcPZka0A7euyU/lyidqiE4
   DoS817m7wpbWTITqlelK9tqvKdDznc1dLrQOEk/PUItPNH2toW51R7SlT
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="201289627"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 12:56:33 +0800
IronPort-SDR: HZlaZ1+1cdEi3kFQ8zORJ3vh4YE0U97RSDjaD95AZ2Pe+AweMd/msPtv0XXhrEGUOT0AM8yn2R
 4oOEgfvqqrnupAgYVU7pLbh3PuAoofz/zMovmuOT02R9BB+BI2v20iEPyJhRxnVXbQL3L465Cw
 BbCMOhK8ClV1BbtJLcu/YVknP47yBizBvVqzEpArf/VDzjS4HopxS8TTBSc+aNiaH036ZX8EVn
 EPSH8fme9Q+Dp7hYd618Xb78tCkBQDc3doBn9yqo+f4kXPYL/8Pbbz6ECzabbj91iPOim//3W5
 QO+eae+kJxSEL5kWhUSL31Q9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:15:23 -0700
IronPort-SDR: 73cpDNXSZBH43EvfzbpetU94JjohwJg5QyIuTcO9L+fC79M6KIUULnmDbXVcfGCahyeexX747U
 w/1vq8eP2wou7AwLZkUZXjO66k6okI3ieOsiCe9KdQTPfEJ1OgZ6ebjGzZ8LiUJjiaof3PjLYF
 DTrXIxDszsxVKX5xDWtvXEUVggmV5GLJpjs9lNKvtpDnwF8IkQhjd2qmydWM3h4QPWXypXHSG7
 wre+6eJUmV5JDyJzspzmPM5sJYUCRpJMSvco/40EfVdyLwY9u9pD7IfzUK2hlTvEo2NT704IUM
 esk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:56:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHw1F4Ds8z1SHwl
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:56:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1654664193; x=1657256194; bh=0SMWDuWsxE3dyExXGK
        JTZLDWsylNdk2ZwEaW5DIMC38=; b=RBjEY3vMOhzdmXTFSVlM9jmXtBsds1LDfv
        7YTqb5ke0okbqqq+jxty6gGEHx/AU4thpc91epOPO6+7PMCMHlPJS4Z+WwIWhNvR
        /B7NT4EeydDhfeFcRRpg/ntGxezdFruZHaJEhJ4oA0cMR8Y13308g6HF/u+Gk5LC
        QuQIQ4POZgEp293BWysTb7Hwxzldkuyeusx75xFokhNm3Bcfl36cZ9anU8EQyNzA
        xykWxxsiMcPLQ67P0PF0hgnxuHIJumJ4yt1n4/n28o9gG3rlbj3rUveyGMhkJt/5
        iuoy//jjR9MgPEqxEg+djN+aQuFscqKZyBDCW0iZ83vJq0G1xDjQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ke2KqA5JOwL9 for <linux-fsdevel@vger.kernel.org>;
        Tue,  7 Jun 2022 21:56:33 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHw1D2ntbz1Rvlx;
        Tue,  7 Jun 2022 21:56:32 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/3] zonefs: fix zonefs_iomap_begin() for reads
Date:   Wed,  8 Jun 2022 13:56:27 +0900
Message-Id: <20220608045627.142408-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
References: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a readahead) is issued to a sequential zone file with an offset
exactly equal to the current file size, the iomap type is set to
IOMAP_UNWRITTEN, which will prevent an IO, but the iomap length is
calculated as 0. This causes a WARN_ON() in iomap_iter():

[17309.548939] WARNING: CPU: 3 PID: 2137 at fs/iomap/iter.c:34 iomap_iter=
+0x9cf/0xe80
[...]
[17309.650907] RIP: 0010:iomap_iter+0x9cf/0xe80
[...]
[17309.754560] Call Trace:
[17309.757078]  <TASK>
[17309.759240]  ? lock_is_held_type+0xd8/0x130
[17309.763531]  iomap_readahead+0x1a8/0x870
[17309.767550]  ? iomap_read_folio+0x4c0/0x4c0
[17309.771817]  ? lockdep_hardirqs_on_prepare+0x400/0x400
[17309.778848]  ? lock_release+0x370/0x750
[17309.784462]  ? folio_add_lru+0x217/0x3f0
[17309.790220]  ? reacquire_held_locks+0x4e0/0x4e0
[17309.796543]  read_pages+0x17d/0xb60
[17309.801854]  ? folio_add_lru+0x238/0x3f0
[17309.807573]  ? readahead_expand+0x5f0/0x5f0
[17309.813554]  ? policy_node+0xb5/0x140
[17309.819018]  page_cache_ra_unbounded+0x27d/0x450
[17309.825439]  filemap_get_pages+0x500/0x1450
[17309.831444]  ? filemap_add_folio+0x140/0x140
[17309.837519]  ? lock_is_held_type+0xd8/0x130
[17309.843509]  filemap_read+0x28c/0x9f0
[17309.848953]  ? zonefs_file_read_iter+0x1ea/0x4d0 [zonefs]
[17309.856162]  ? trace_contention_end+0xd6/0x130
[17309.862416]  ? __mutex_lock+0x221/0x1480
[17309.868151]  ? zonefs_file_read_iter+0x166/0x4d0 [zonefs]
[17309.875364]  ? filemap_get_pages+0x1450/0x1450
[17309.881647]  ? __mutex_unlock_slowpath+0x15e/0x620
[17309.888248]  ? wait_for_completion_io_timeout+0x20/0x20
[17309.895231]  ? lock_is_held_type+0xd8/0x130
[17309.901115]  ? lock_is_held_type+0xd8/0x130
[17309.906934]  zonefs_file_read_iter+0x356/0x4d0 [zonefs]
[17309.913750]  new_sync_read+0x2d8/0x520
[17309.919035]  ? __x64_sys_lseek+0x1d0/0x1d0

Furthermore, this causes iomap_readahead() to loop forever as
iomap_readahead_iter() always returns 0, making no progress.

Fix this by treating reads after the file size as access to holes,
setting the iomap type to IOMAP_HOLE, the iomap addr to IOMAP_NULL_ADDR
and using the length argument as is for the iomap length. To simplify
the code with this change, zonefs_iomap_begin() is split into the read
variant, zonefs_read_iomap_begin() and zonefs_read_iomap_ops, and the
write variant, zonefs_write_iomap_begin() and zonefs_write_iomap_ops.

Reported-by: Jorgen Hansen <Jorgen.Hansen@wdc.com>
Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 94 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 30 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 123464d2145a..053299758deb 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -110,15 +110,51 @@ static inline void zonefs_i_size_write(struct inode=
 *inode, loff_t isize)
 	}
 }
=20
-static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t=
 length,
-			      unsigned int flags, struct iomap *iomap,
-			      struct iomap *srcmap)
+static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
+				   loff_t length, unsigned int flags,
+				   struct iomap *iomap, struct iomap *srcmap)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
 	struct super_block *sb =3D inode->i_sb;
 	loff_t isize;
=20
-	/* All I/Os should always be within the file maximum size */
+	/*
+	 * All blocks are always mapped below EOF. If reading past EOF,
+	 * act as if there is a hole up to the file maximum size.
+	 */
+	mutex_lock(&zi->i_truncate_mutex);
+	iomap->bdev =3D inode->i_sb->s_bdev;
+	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
+	isize =3D i_size_read(inode);
+	if (iomap->offset >=3D isize) {
+		iomap->type =3D IOMAP_HOLE;
+		iomap->addr =3D IOMAP_NULL_ADDR;
+		iomap->length =3D length;
+	} else {
+		iomap->type =3D IOMAP_MAPPED;
+		iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
+		iomap->length =3D isize - iomap->offset;
+	}
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	trace_zonefs_iomap_begin(inode, iomap);
+
+	return 0;
+}
+
+static const struct iomap_ops zonefs_read_iomap_ops =3D {
+	.iomap_begin	=3D zonefs_read_iomap_begin,
+};
+
+static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
+				    loff_t length, unsigned int flags,
+				    struct iomap *iomap, struct iomap *srcmap)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct super_block *sb =3D inode->i_sb;
+	loff_t isize;
+
+	/* All write I/Os should always be within the file maximum size */
 	if (WARN_ON_ONCE(offset + length > zi->i_max_size))
 		return -EIO;
=20
@@ -128,7 +164,7 @@ static int zonefs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
 	 * operation.
 	 */
 	if (WARN_ON_ONCE(zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
-			 (flags & IOMAP_WRITE) && !(flags & IOMAP_DIRECT)))
+			 !(flags & IOMAP_DIRECT)))
 		return -EIO;
=20
 	/*
@@ -137,47 +173,44 @@ static int zonefs_iomap_begin(struct inode *inode, =
loff_t offset, loff_t length,
 	 * write pointer) and unwriten beyond.
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
+	iomap->bdev =3D inode->i_sb->s_bdev;
+	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
+	iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
 	isize =3D i_size_read(inode);
-	if (offset >=3D isize)
+	if (iomap->offset >=3D isize) {
 		iomap->type =3D IOMAP_UNWRITTEN;
-	else
+		iomap->length =3D zi->i_max_size - iomap->offset;
+	} else {
 		iomap->type =3D IOMAP_MAPPED;
-	if (flags & IOMAP_WRITE)
-		length =3D zi->i_max_size - offset;
-	else
-		length =3D min(length, isize - offset);
+		iomap->length =3D isize - iomap->offset;
+	}
 	mutex_unlock(&zi->i_truncate_mutex);
=20
-	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
-	iomap->length =3D ALIGN(offset + length, sb->s_blocksize) - iomap->offs=
et;
-	iomap->bdev =3D inode->i_sb->s_bdev;
-	iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
-
 	trace_zonefs_iomap_begin(inode, iomap);
=20
 	return 0;
 }
=20
-static const struct iomap_ops zonefs_iomap_ops =3D {
-	.iomap_begin	=3D zonefs_iomap_begin,
+static const struct iomap_ops zonefs_write_iomap_ops =3D {
+	.iomap_begin	=3D zonefs_write_iomap_begin,
 };
=20
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_iomap_ops);
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
 }
=20
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_iomap_ops);
+	iomap_readahead(rac, &zonefs_read_iomap_ops);
 }
=20
 /*
  * Map blocks for page writeback. This is used only on conventional zone=
 files,
  * which implies that the page range can only be within the fixed inode =
size.
  */
-static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,
-			     struct inode *inode, loff_t offset)
+static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
+				   struct inode *inode, loff_t offset)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
=20
@@ -191,12 +224,12 @@ static int zonefs_map_blocks(struct iomap_writepage=
_ctx *wpc,
 	    offset < wpc->iomap.offset + wpc->iomap.length)
 		return 0;
=20
-	return zonefs_iomap_begin(inode, offset, zi->i_max_size - offset,
-				  IOMAP_WRITE, &wpc->iomap, NULL);
+	return zonefs_write_iomap_begin(inode, offset, zi->i_max_size - offset,
+					IOMAP_WRITE, &wpc->iomap, NULL);
 }
=20
 static const struct iomap_writeback_ops zonefs_writeback_ops =3D {
-	.map_blocks		=3D zonefs_map_blocks,
+	.map_blocks		=3D zonefs_write_map_blocks,
 };
=20
 static int zonefs_writepage(struct page *page, struct writeback_control =
*wbc)
@@ -226,7 +259,8 @@ static int zonefs_swap_activate(struct swap_info_stru=
ct *sis,
 		return -EINVAL;
 	}
=20
-	return iomap_swapfile_activate(sis, swap_file, span, &zonefs_iomap_ops)=
;
+	return iomap_swapfile_activate(sis, swap_file, span,
+				       &zonefs_read_iomap_ops);
 }
=20
 static const struct address_space_operations zonefs_file_aops =3D {
@@ -647,7 +681,7 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct =
vm_fault *vmf)
=20
 	/* Serialize against truncates */
 	filemap_invalidate_lock_shared(inode->i_mapping);
-	ret =3D iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
+	ret =3D iomap_page_mkwrite(vmf, &zonefs_write_iomap_ops);
 	filemap_invalidate_unlock_shared(inode->i_mapping);
=20
 	sb_end_pagefault(inode->i_sb);
@@ -899,7 +933,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 	if (append)
 		ret =3D zonefs_file_dio_append(iocb, from);
 	else
-		ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
+		ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
 				   &zonefs_write_dio_ops, 0, NULL, 0);
 	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
@@ -948,7 +982,7 @@ static ssize_t zonefs_file_buffered_write(struct kioc=
b *iocb,
 	if (ret <=3D 0)
 		goto inode_unlock;
=20
-	ret =3D iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
+	ret =3D iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops);
 	if (ret > 0)
 		iocb->ki_pos +=3D ret;
 	else if (ret =3D=3D -EIO)
@@ -1041,7 +1075,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
 			goto inode_unlock;
 		}
 		file_accessed(iocb->ki_filp);
-		ret =3D iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
+		ret =3D iomap_dio_rw(iocb, to, &zonefs_read_iomap_ops,
 				   &zonefs_read_dio_ops, 0, NULL, 0);
 	} else {
 		ret =3D generic_file_read_iter(iocb, to);
--=20
2.36.1

