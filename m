Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F13664146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjAJNJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbjAJNIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:45 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEEC574D8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356121; x=1704892121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yj82fwVBBGfLzKWMIsgcOgirWepKt0Go8WN0JXDj+c=;
  b=S7Wh2TkvA7Nz0lQu23nve/p6nW+fgGaf+vUdcYWX86uw0cr6sk/bkIEJ
   QMosLlFLYrKDY44Q6rsyHdqQUEnykMvU9Ur271i8dwHFauROxhE7Rnyfo
   DP2VOt5c015wXAP09Xg2tSyKFRCS+l55Lp1vhQe8CTDtdUw7jtktPC8tZ
   DlUKTFAg1IkPNAz76JKHNyOdEWWNoMoZ6SNmItb0GMX2NtyUVHquVYf0p
   5MEQVz7Pirm8pQpPHKsT57TQlbYwVwS+Ws3Yx3ZOEgkcjB+LHbHPbjyF3
   CQYt8GPMwcCF+hhO8mFHs7NqOAQXlOgMiIy7bdAxAHg1arx8Mfw+U1bgS
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740566"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:41 +0800
IronPort-SDR: uQOXuCft14RRsBdddrZB9aVB7m46WPlcEUFmbj2EcFwitzMIKrPQosWZFuAnYDGr2kLjMcx0fu
 07Tanc4t3JNFRnBmi76/P1vXBReWPFUkn8mQds6igXy6m9Gf1tFWXyXy9/a5U5u9tRdvqdWpIO
 zNEYZ59RbDaMHA7LQ7AH83T0zFXYnAtgHPw6hPv1HQjci1tpPXYqJFYJVVjhGj/L/x8KzBF7PZ
 mzsyKdH/mQdyndD5aOO+KuqNZK346Hd5wWIA4Wdteh/tHS7hDU0oRTGOZpFAjm15/9P1gG4czd
 a7Q=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:47 -0800
IronPort-SDR: CtNdKWfag/+u3tiRj2mKp84E3NEIuPblremkSEQ80fiGY0y1zRJ0+oEo6Et6cN8ZE3otMKVchS
 pDwA/ksfrEONdAwPp7OAcW8TwcKYMouMT7hHryLh+qeP6AqIXxO0Sl1d4vKLlH91dgLDf12z3e
 i4Pz4eKLgm9boT9tFKDDMm9KCw3js4CRRmnjCV0oQw6nJb7nBGIkb+7eyxwF3Qjqz+Nlond0uu
 eHgRZZVbIA9E2VthjwJNOnHwjZCDR6Ly7AzPbGVwdtkA7G+v6ZhFyw137Vza7xPJhWKgIvZcuq
 ie0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjP1tXTz1Rwrq
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356118; x=1675948119; bh=6yj82fwVBBGfLzKWMI
        sgcOgirWepKt0Go8WN0JXDj+c=; b=BxYhYhY9ENPPvrvIjB0wYf+Unqn/RkGjAj
        HuuPDfVhP3Suv31oHAdT9xqSKCirV0QgB3YoCXysuN80PyWTzMHP2nRzo1o9l8MB
        ECXtAPCaX8yt0du4jRzdA1d2YXKEJP97xnAoIHKHRSAxZQmXZxXTaY6T4dd7roWC
        ikenzzr9+WWZ3B6GTPsneNCtJd15m9tg6FkwqI3TsrcEU2F+5zScB1aeiAhCxdQc
        a2nbFfEIWqOUGGakbbUQUo06b4B3n44AqVnXhDkvXFGgs2Fk3p5XcNkJdCmAuRgU
        NsT0ohFJLNWbyZsKs+eYb4JuvagrP3ti9VrGqRVe7wFWkOzuUgLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id muSnhltymZev for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:38 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjK4y9Dz1RvTp;
        Tue, 10 Jan 2023 05:08:37 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 5/7] zonefs: Separate zone information from inode information
Date:   Tue, 10 Jan 2023 22:08:28 +0900
Message-Id: <20230110130830.246019-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for adding dynamic inode allocation, separate an inode
zone information from the zonefs inode structure. The new data structure
zonefs_zone is introduced to store in memory information about a zone
that must be kept throughout the lifetime of the device mount.

Linking between a zone file inode and its zone information is done by
setting the inode i_private field to point to a struct zonefs_zone.
Using the i_private pointer avoids the need for adding a pointer in
struct zonefs_inode_info. Beside the vfs inode, this structure is
reduced to a mutex and a write open counter.

One struct zonefs_zone is created per file inode on mount. These
structures are organized in an array using the new struct
zonefs_zone_group data structure to represent zone groups. The
zonefs_zone arrays are indexed per file number (the index of a struct
zonefs_zone in its array directly gives the file number/name for that
zone file inode).

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/file.c   |  99 ++++----
 fs/zonefs/super.c  | 571 +++++++++++++++++++++++++++------------------
 fs/zonefs/trace.h  |  20 +-
 fs/zonefs/zonefs.h |  63 +++--
 4 files changed, 449 insertions(+), 304 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 64873d31d75d..738b0e28d74b 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -29,6 +29,7 @@ static int zonefs_read_iomap_begin(struct inode *inode,=
 loff_t offset,
 				   struct iomap *iomap, struct iomap *srcmap)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct super_block *sb =3D inode->i_sb;
 	loff_t isize;
=20
@@ -46,7 +47,7 @@ static int zonefs_read_iomap_begin(struct inode *inode,=
 loff_t offset,
 		iomap->length =3D length;
 	} else {
 		iomap->type =3D IOMAP_MAPPED;
-		iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
+		iomap->addr =3D (z->z_sector << SECTOR_SHIFT) + iomap->offset;
 		iomap->length =3D isize - iomap->offset;
 	}
 	mutex_unlock(&zi->i_truncate_mutex);
@@ -65,11 +66,12 @@ static int zonefs_write_iomap_begin(struct inode *ino=
de, loff_t offset,
 				    struct iomap *iomap, struct iomap *srcmap)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct super_block *sb =3D inode->i_sb;
 	loff_t isize;
=20
 	/* All write I/Os should always be within the file maximum size */
-	if (WARN_ON_ONCE(offset + length > zi->i_max_size))
+	if (WARN_ON_ONCE(offset + length > z->z_capacity))
 		return -EIO;
=20
 	/*
@@ -77,7 +79,7 @@ static int zonefs_write_iomap_begin(struct inode *inode=
, loff_t offset,
 	 * checked when writes are issued, so warn if we see a page writeback
 	 * operation.
 	 */
-	if (WARN_ON_ONCE(zonefs_zone_is_seq(zi) && !(flags & IOMAP_DIRECT)))
+	if (WARN_ON_ONCE(zonefs_zone_is_seq(z) && !(flags & IOMAP_DIRECT)))
 		return -EIO;
=20
 	/*
@@ -88,11 +90,11 @@ static int zonefs_write_iomap_begin(struct inode *ino=
de, loff_t offset,
 	mutex_lock(&zi->i_truncate_mutex);
 	iomap->bdev =3D inode->i_sb->s_bdev;
 	iomap->offset =3D ALIGN_DOWN(offset, sb->s_blocksize);
-	iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
+	iomap->addr =3D (z->z_sector << SECTOR_SHIFT) + iomap->offset;
 	isize =3D i_size_read(inode);
 	if (iomap->offset >=3D isize) {
 		iomap->type =3D IOMAP_UNWRITTEN;
-		iomap->length =3D zi->i_max_size - iomap->offset;
+		iomap->length =3D z->z_capacity - iomap->offset;
 	} else {
 		iomap->type =3D IOMAP_MAPPED;
 		iomap->length =3D isize - iomap->offset;
@@ -125,9 +127,9 @@ static void zonefs_readahead(struct readahead_control=
 *rac)
 static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
 				   struct inode *inode, loff_t offset)
 {
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
=20
-	if (WARN_ON_ONCE(zonefs_zone_is_seq(zi)))
+	if (WARN_ON_ONCE(zonefs_zone_is_seq(z)))
 		return -EIO;
 	if (WARN_ON_ONCE(offset >=3D i_size_read(inode)))
 		return -EIO;
@@ -137,7 +139,8 @@ static int zonefs_write_map_blocks(struct iomap_write=
page_ctx *wpc,
 	    offset < wpc->iomap.offset + wpc->iomap.length)
 		return 0;
=20
-	return zonefs_write_iomap_begin(inode, offset, zi->i_max_size - offset,
+	return zonefs_write_iomap_begin(inode, offset,
+					z->z_capacity - offset,
 					IOMAP_WRITE, &wpc->iomap, NULL);
 }
=20
@@ -185,6 +188,7 @@ const struct address_space_operations zonefs_file_aop=
s =3D {
 int zonefs_file_truncate(struct inode *inode, loff_t isize)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	loff_t old_isize;
 	enum req_op op;
 	int ret =3D 0;
@@ -194,12 +198,12 @@ int zonefs_file_truncate(struct inode *inode, loff_=
t isize)
 	 * only down to a 0 size, which is equivalent to a zone reset, and to
 	 * the maximum file size, which is equivalent to a zone finish.
 	 */
-	if (!zonefs_zone_is_seq(zi))
+	if (!zonefs_zone_is_seq(z))
 		return -EPERM;
=20
 	if (!isize)
 		op =3D REQ_OP_ZONE_RESET;
-	else if (isize =3D=3D zi->i_max_size)
+	else if (isize =3D=3D z->z_capacity)
 		op =3D REQ_OP_ZONE_FINISH;
 	else
 		return -EPERM;
@@ -216,7 +220,7 @@ int zonefs_file_truncate(struct inode *inode, loff_t =
isize)
 	if (isize =3D=3D old_isize)
 		goto unlock;
=20
-	ret =3D zonefs_zone_mgmt(inode, op);
+	ret =3D zonefs_inode_zone_mgmt(inode, op);
 	if (ret)
 		goto unlock;
=20
@@ -224,7 +228,7 @@ int zonefs_file_truncate(struct inode *inode, loff_t =
isize)
 	 * If the mount option ZONEFS_MNTOPT_EXPLICIT_OPEN is set,
 	 * take care of open zones.
 	 */
-	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
+	if (z->z_flags & ZONEFS_ZONE_OPEN) {
 		/*
 		 * Truncating a zone to EMPTY or FULL is the equivalent of
 		 * closing the zone. For a truncation to 0, we need to
@@ -234,15 +238,15 @@ int zonefs_file_truncate(struct inode *inode, loff_=
t isize)
 		 * the open flag.
 		 */
 		if (!isize)
-			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
+			ret =3D zonefs_inode_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
 		else
-			zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+			z->z_flags &=3D ~ZONEFS_ZONE_OPEN;
 	}
=20
 	zonefs_update_stats(inode, isize);
 	truncate_setsize(inode, isize);
-	zi->i_wpoffset =3D isize;
-	zonefs_account_active(inode);
+	z->z_wpoffset =3D isize;
+	zonefs_inode_account_active(inode);
=20
 unlock:
 	mutex_unlock(&zi->i_truncate_mutex);
@@ -349,7 +353,7 @@ static int zonefs_file_write_dio_end_io(struct kiocb =
*iocb, ssize_t size,
 		return error;
 	}
=20
-	if (size && zonefs_zone_is_seq(zi)) {
+	if (size && zonefs_inode_is_seq(inode)) {
 		/*
 		 * Note that we may be seeing completions out of order,
 		 * but that is not a problem since a write completed
@@ -375,7 +379,7 @@ static const struct iomap_dio_ops zonefs_write_dio_op=
s =3D {
 static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_ite=
r *from)
 {
 	struct inode *inode =3D file_inode(iocb->ki_filp);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct block_device *bdev =3D inode->i_sb->s_bdev;
 	unsigned int max =3D bdev_max_zone_append_sectors(bdev);
 	struct bio *bio;
@@ -392,7 +396,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *i=
ocb, struct iov_iter *from)
=20
 	bio =3D bio_alloc(bdev, nr_pages,
 			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
-	bio->bi_iter.bi_sector =3D zi->i_zsector;
+	bio->bi_iter.bi_sector =3D z->z_sector;
 	bio->bi_ioprio =3D iocb->ki_ioprio;
 	if (iocb_is_dsync(iocb))
 		bio->bi_opf |=3D REQ_FUA;
@@ -417,12 +421,12 @@ static ssize_t zonefs_file_dio_append(struct kiocb =
*iocb, struct iov_iter *from)
 	 */
 	if (!ret) {
 		sector_t wpsector =3D
-			zi->i_zsector + (zi->i_wpoffset >> SECTOR_SHIFT);
+			z->z_sector + (z->z_wpoffset >> SECTOR_SHIFT);
=20
 		if (bio->bi_iter.bi_sector !=3D wpsector) {
 			zonefs_warn(inode->i_sb,
 				"Corrupted write pointer %llu for zone at %llu\n",
-				wpsector, zi->i_zsector);
+				wpsector, z->z_sector);
 			ret =3D -EIO;
 		}
 	}
@@ -450,9 +454,9 @@ static loff_t zonefs_write_check_limits(struct file *=
file, loff_t pos,
 					loff_t count)
 {
 	struct inode *inode =3D file_inode(file);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	loff_t limit =3D rlimit(RLIMIT_FSIZE);
-	loff_t max_size =3D zi->i_max_size;
+	loff_t max_size =3D z->z_capacity;
=20
 	if (limit !=3D RLIM_INFINITY) {
 		if (pos >=3D limit) {
@@ -476,6 +480,7 @@ static ssize_t zonefs_write_checks(struct kiocb *iocb=
, struct iov_iter *from)
 	struct file *file =3D iocb->ki_filp;
 	struct inode *inode =3D file_inode(file);
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	loff_t count;
=20
 	if (IS_SWAPFILE(inode))
@@ -488,10 +493,10 @@ static ssize_t zonefs_write_checks(struct kiocb *io=
cb, struct iov_iter *from)
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_APPEND) {
-		if (zonefs_zone_is_cnv(zi))
+		if (zonefs_zone_is_cnv(z))
 			return -EINVAL;
 		mutex_lock(&zi->i_truncate_mutex);
-		iocb->ki_pos =3D zi->i_wpoffset;
+		iocb->ki_pos =3D z->z_wpoffset;
 		mutex_unlock(&zi->i_truncate_mutex);
 	}
=20
@@ -518,6 +523,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 {
 	struct inode *inode =3D file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct super_block *sb =3D inode->i_sb;
 	bool sync =3D is_sync_kiocb(iocb);
 	bool append =3D false;
@@ -528,7 +534,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
 	 * on the inode lock but the second goes through but is now unaligned).
 	 */
-	if (zonefs_zone_is_seq(zi) && !sync && (iocb->ki_flags & IOCB_NOWAIT))
+	if (zonefs_zone_is_seq(z) && !sync && (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
=20
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -550,9 +556,9 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 	}
=20
 	/* Enforce sequential writes (append only) in sequential zones */
-	if (zonefs_zone_is_seq(zi)) {
+	if (zonefs_zone_is_seq(z)) {
 		mutex_lock(&zi->i_truncate_mutex);
-		if (iocb->ki_pos !=3D zi->i_wpoffset) {
+		if (iocb->ki_pos !=3D z->z_wpoffset) {
 			mutex_unlock(&zi->i_truncate_mutex);
 			ret =3D -EINVAL;
 			goto inode_unlock;
@@ -566,7 +572,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 	else
 		ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
 				   &zonefs_write_dio_ops, 0, NULL, 0);
-	if (zonefs_zone_is_seq(zi) &&
+	if (zonefs_zone_is_seq(z) &&
 	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
 		if (ret > 0)
 			count =3D ret;
@@ -577,8 +583,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 		 * will correct it. Also do active seq file accounting.
 		 */
 		mutex_lock(&zi->i_truncate_mutex);
-		zi->i_wpoffset +=3D count;
-		zonefs_account_active(inode);
+		z->z_wpoffset +=3D count;
+		zonefs_inode_account_active(inode);
 		mutex_unlock(&zi->i_truncate_mutex);
 	}
=20
@@ -629,6 +635,7 @@ static ssize_t zonefs_file_buffered_write(struct kioc=
b *iocb,
 static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_ite=
r *from)
 {
 	struct inode *inode =3D file_inode(iocb->ki_filp);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
=20
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
@@ -636,8 +643,8 @@ static ssize_t zonefs_file_write_iter(struct kiocb *i=
ocb, struct iov_iter *from)
 	if (sb_rdonly(inode->i_sb))
 		return -EROFS;
=20
-	/* Write operations beyond the zone size are not allowed */
-	if (iocb->ki_pos >=3D ZONEFS_I(inode)->i_max_size)
+	/* Write operations beyond the zone capacity are not allowed */
+	if (iocb->ki_pos >=3D z->z_capacity)
 		return -EFBIG;
=20
 	if (iocb->ki_flags & IOCB_DIRECT) {
@@ -669,6 +676,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
 {
 	struct inode *inode =3D file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct super_block *sb =3D inode->i_sb;
 	loff_t isize;
 	ssize_t ret;
@@ -677,7 +685,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
 	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
 		return -EPERM;
=20
-	if (iocb->ki_pos >=3D zi->i_max_size)
+	if (iocb->ki_pos >=3D z->z_capacity)
 		return 0;
=20
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -738,6 +746,7 @@ static inline bool zonefs_seq_file_need_wro(struct in=
ode *inode,
 static int zonefs_seq_file_write_open(struct inode *inode)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	int ret =3D 0;
=20
 	mutex_lock(&zi->i_truncate_mutex);
@@ -755,14 +764,15 @@ static int zonefs_seq_file_write_open(struct inode =
*inode)
 				goto unlock;
 			}
=20
-			if (i_size_read(inode) < zi->i_max_size) {
-				ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
+			if (i_size_read(inode) < z->z_capacity) {
+				ret =3D zonefs_inode_zone_mgmt(inode,
+							     REQ_OP_ZONE_OPEN);
 				if (ret) {
 					atomic_dec(&sbi->s_wro_seq_files);
 					goto unlock;
 				}
-				zi->i_flags |=3D ZONEFS_ZONE_OPEN;
-				zonefs_account_active(inode);
+				z->z_flags |=3D ZONEFS_ZONE_OPEN;
+				zonefs_inode_account_active(inode);
 			}
 		}
 	}
@@ -792,6 +802,7 @@ static int zonefs_file_open(struct inode *inode, stru=
ct file *file)
 static void zonefs_seq_file_write_close(struct inode *inode)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	int ret =3D 0;
@@ -807,8 +818,8 @@ static void zonefs_seq_file_write_close(struct inode =
*inode)
 	 * its maximum size or it was fully written). For this case, we only
 	 * need to decrement the write open count.
 	 */
-	if (zi->i_flags & ZONEFS_ZONE_OPEN) {
-		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
+	if (z->z_flags & ZONEFS_ZONE_OPEN) {
+		ret =3D zonefs_inode_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
 		if (ret) {
 			__zonefs_io_error(inode, false);
 			/*
@@ -817,11 +828,11 @@ static void zonefs_seq_file_write_close(struct inod=
e *inode)
 			 * exhausted). So take preventive action by remounting
 			 * read-only.
 			 */
-			if (zi->i_flags & ZONEFS_ZONE_OPEN &&
+			if (z->z_flags & ZONEFS_ZONE_OPEN &&
 			    !(sb->s_flags & SB_RDONLY)) {
 				zonefs_warn(sb,
 					"closing zone at %llu failed %d\n",
-					zi->i_zsector, ret);
+					z->z_sector, ret);
 				zonefs_warn(sb,
 					"remounting filesystem read-only\n");
 				sb->s_flags |=3D SB_RDONLY;
@@ -829,8 +840,8 @@ static void zonefs_seq_file_write_close(struct inode =
*inode)
 			goto unlock;
 		}
=20
-		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
-		zonefs_account_active(inode);
+		z->z_flags &=3D ~ZONEFS_ZONE_OPEN;
+		zonefs_inode_account_active(inode);
 	}
=20
 	atomic_dec(&sbi->s_wro_seq_files);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index a4af29dc32e7..270ded209dde 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -28,33 +28,47 @@
 #include "trace.h"
=20
 /*
- * Manage the active zone count. Called with zi->i_truncate_mutex held.
+ * Get the name of a zone group directory.
  */
-void zonefs_account_active(struct inode *inode)
+static const char *zonefs_zgroup_name(enum zonefs_ztype ztype)
 {
-	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	switch (ztype) {
+	case ZONEFS_ZTYPE_CNV:
+		return "cnv";
+	case ZONEFS_ZTYPE_SEQ:
+		return "seq";
+	default:
+		WARN_ON_ONCE(1);
+		return "???";
+	}
+}
=20
-	lockdep_assert_held(&zi->i_truncate_mutex);
+/*
+ * Manage the active zone count.
+ */
+static void zonefs_account_active(struct super_block *sb,
+				  struct zonefs_zone *z)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
=20
-	if (zonefs_zone_is_cnv(zi))
+	if (zonefs_zone_is_cnv(z))
 		return;
=20
 	/*
 	 * For zones that transitioned to the offline or readonly condition,
 	 * we only need to clear the active state.
 	 */
-	if (zi->i_flags & (ZONEFS_ZONE_OFFLINE | ZONEFS_ZONE_READONLY))
+	if (z->z_flags & (ZONEFS_ZONE_OFFLINE | ZONEFS_ZONE_READONLY))
 		goto out;
=20
 	/*
 	 * If the zone is active, that is, if it is explicitly open or
 	 * partially written, check if it was already accounted as active.
 	 */
-	if ((zi->i_flags & ZONEFS_ZONE_OPEN) ||
-	    (zi->i_wpoffset > 0 && zi->i_wpoffset < zi->i_max_size)) {
-		if (!(zi->i_flags & ZONEFS_ZONE_ACTIVE)) {
-			zi->i_flags |=3D ZONEFS_ZONE_ACTIVE;
+	if ((z->z_flags & ZONEFS_ZONE_OPEN) ||
+	    (z->z_wpoffset > 0 && z->z_wpoffset < z->z_capacity)) {
+		if (!(z->z_flags & ZONEFS_ZONE_ACTIVE)) {
+			z->z_flags |=3D ZONEFS_ZONE_ACTIVE;
 			atomic_inc(&sbi->s_active_seq_files);
 		}
 		return;
@@ -62,18 +76,29 @@ void zonefs_account_active(struct inode *inode)
=20
 out:
 	/* The zone is not active. If it was, update the active count */
-	if (zi->i_flags & ZONEFS_ZONE_ACTIVE) {
-		zi->i_flags &=3D ~ZONEFS_ZONE_ACTIVE;
+	if (z->z_flags & ZONEFS_ZONE_ACTIVE) {
+		z->z_flags &=3D ~ZONEFS_ZONE_ACTIVE;
 		atomic_dec(&sbi->s_active_seq_files);
 	}
 }
=20
-int zonefs_zone_mgmt(struct inode *inode, enum req_op op)
+/*
+ * Manage the active zone count. Called with zi->i_truncate_mutex held.
+ */
+void zonefs_inode_account_active(struct inode *inode)
 {
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	int ret;
+	lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex);
=20
-	lockdep_assert_held(&zi->i_truncate_mutex);
+	return zonefs_account_active(inode->i_sb, zonefs_inode_zone(inode));
+}
+
+/*
+ * Execute a zone management operation.
+ */
+static int zonefs_zone_mgmt(struct super_block *sb,
+			    struct zonefs_zone *z, enum req_op op)
+{
+	int ret;
=20
 	/*
 	 * With ZNS drives, closing an explicitly open zone that has not been
@@ -83,37 +108,45 @@ int zonefs_zone_mgmt(struct inode *inode, enum req_o=
p op)
 	 * are exceeded, make sure that the zone does not remain active by
 	 * resetting it.
 	 */
-	if (op =3D=3D REQ_OP_ZONE_CLOSE && !zi->i_wpoffset)
+	if (op =3D=3D REQ_OP_ZONE_CLOSE && !z->z_wpoffset)
 		op =3D REQ_OP_ZONE_RESET;
=20
-	trace_zonefs_zone_mgmt(inode, op);
-	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,
-			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);
+	trace_zonefs_zone_mgmt(sb, z, op);
+	ret =3D blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
+			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
 	if (ret) {
-		zonefs_err(inode->i_sb,
+		zonefs_err(sb,
 			   "Zone management operation %s at %llu failed %d\n",
-			   blk_op_str(op), zi->i_zsector, ret);
+			   blk_op_str(op), z->z_sector, ret);
 		return ret;
 	}
=20
 	return 0;
 }
=20
+int zonefs_inode_zone_mgmt(struct inode *inode, enum req_op op)
+{
+	lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex);
+
+	return zonefs_zone_mgmt(inode->i_sb, zonefs_inode_zone(inode), op);
+}
+
 void zonefs_i_size_write(struct inode *inode, loff_t isize)
 {
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
=20
 	i_size_write(inode, isize);
+
 	/*
 	 * A full zone is no longer open/active and does not need
 	 * explicit closing.
 	 */
-	if (isize >=3D zi->i_max_size) {
+	if (isize >=3D z->z_capacity) {
 		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
=20
-		if (zi->i_flags & ZONEFS_ZONE_ACTIVE)
+		if (z->z_flags & ZONEFS_ZONE_ACTIVE)
 			atomic_dec(&sbi->s_active_seq_files);
-		zi->i_flags &=3D ~(ZONEFS_ZONE_OPEN | ZONEFS_ZONE_ACTIVE);
+		z->z_flags &=3D ~(ZONEFS_ZONE_OPEN | ZONEFS_ZONE_ACTIVE);
 	}
 }
=20
@@ -150,20 +183,18 @@ void zonefs_update_stats(struct inode *inode, loff_=
t new_isize)
 }
=20
 /*
- * Check a zone condition and adjust its file inode access permissions f=
or
- * offline and readonly zones. Return the inode size corresponding to th=
e
- * amount of readable data in the zone.
+ * Check a zone condition. Return the amount of written (and still reada=
ble)
+ * data in the zone.
  */
-static loff_t zonefs_check_zone_condition(struct inode *inode,
+static loff_t zonefs_check_zone_condition(struct super_block *sb,
+					  struct zonefs_zone *z,
 					  struct blk_zone *zone)
 {
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-
 	switch (zone->cond) {
 	case BLK_ZONE_COND_OFFLINE:
-		zonefs_warn(inode->i_sb, "inode %lu: offline zone\n",
-			    inode->i_ino);
-		zi->i_flags |=3D ZONEFS_ZONE_OFFLINE;
+		zonefs_warn(sb, "Zone %llu: offline zone\n",
+			    z->z_sector);
+		z->z_flags |=3D ZONEFS_ZONE_OFFLINE;
 		return 0;
 	case BLK_ZONE_COND_READONLY:
 		/*
@@ -174,18 +205,18 @@ static loff_t zonefs_check_zone_condition(struct in=
ode *inode,
 		 * the inode size as it was when last updated so that the user
 		 * can recover data.
 		 */
-		zonefs_warn(inode->i_sb, "inode %lu: read-only zone\n",
-			    inode->i_ino);
-		zi->i_flags |=3D ZONEFS_ZONE_READONLY;
-		if (zonefs_zone_is_cnv(zi))
-			return zi->i_max_size;
-		return zi->i_wpoffset;
+		zonefs_warn(sb, "Zone %llu: read-only zone\n",
+			    z->z_sector);
+		z->z_flags |=3D ZONEFS_ZONE_READONLY;
+		if (zonefs_zone_is_cnv(z))
+			return z->z_capacity;
+		return z->z_wpoffset;
 	case BLK_ZONE_COND_FULL:
 		/* The write pointer of full zones is invalid. */
-		return zi->i_max_size;
+		return z->z_capacity;
 	default:
-		if (zonefs_zone_is_cnv(zi))
-			return zi->i_max_size;
+		if (zonefs_zone_is_cnv(z))
+			return z->z_capacity;
 		return (zone->wp - zone->start) << SECTOR_SHIFT;
 	}
 }
@@ -196,22 +227,22 @@ static loff_t zonefs_check_zone_condition(struct in=
ode *inode,
  */
 static void zonefs_inode_update_mode(struct inode *inode)
 {
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
=20
-	if (zi->i_flags & ZONEFS_ZONE_OFFLINE) {
+	if (z->z_flags & ZONEFS_ZONE_OFFLINE) {
 		/* Offline zones cannot be read nor written */
 		inode->i_flags |=3D S_IMMUTABLE;
 		inode->i_mode &=3D ~0777;
-	} else if (zi->i_flags & ZONEFS_ZONE_READONLY) {
+	} else if (z->z_flags & ZONEFS_ZONE_READONLY) {
 		/* Readonly zones cannot be written */
 		inode->i_flags |=3D S_IMMUTABLE;
-		if (zi->i_flags & ZONEFS_ZONE_INIT_MODE)
+		if (z->z_flags & ZONEFS_ZONE_INIT_MODE)
 			inode->i_mode &=3D ~0777;
 		else
 			inode->i_mode &=3D ~0222;
 	}
=20
-	zi->i_flags &=3D ~ZONEFS_ZONE_INIT_MODE;
+	z->z_flags &=3D ~ZONEFS_ZONE_INIT_MODE;
 }
=20
 struct zonefs_ioerr_data {
@@ -224,7 +255,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 {
 	struct zonefs_ioerr_data *err =3D data;
 	struct inode *inode =3D err->inode;
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	loff_t isize, data_size;
@@ -235,9 +266,9 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	 * as there is no inconsistency between the inode size and the amount o=
f
 	 * data writen in the zone (data_size).
 	 */
-	data_size =3D zonefs_check_zone_condition(inode, zone);
+	data_size =3D zonefs_check_zone_condition(sb, z, zone);
 	isize =3D i_size_read(inode);
-	if (!(zi->i_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)) &&
+	if (!(z->z_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)) &&
 	    !err->write && isize =3D=3D data_size)
 		return 0;
=20
@@ -260,8 +291,9 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	 * In all cases, warn about inode size inconsistency and handle the
 	 * IO error according to the zone condition and to the mount options.
 	 */
-	if (zonefs_zone_is_seq(zi) && isize !=3D data_size)
-		zonefs_warn(sb, "inode %lu: invalid size %lld (should be %lld)\n",
+	if (zonefs_zone_is_seq(z) && isize !=3D data_size)
+		zonefs_warn(sb,
+			    "inode %lu: invalid size %lld (should be %lld)\n",
 			    inode->i_ino, isize, data_size);
=20
 	/*
@@ -270,20 +302,20 @@ static int zonefs_io_error_cb(struct blk_zone *zone=
, unsigned int idx,
 	 * zone condition to read-only and offline respectively, as if the
 	 * condition was signaled by the hardware.
 	 */
-	if ((zi->i_flags & ZONEFS_ZONE_OFFLINE) ||
+	if ((z->z_flags & ZONEFS_ZONE_OFFLINE) ||
 	    (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZOL)) {
 		zonefs_warn(sb, "inode %lu: read/write access disabled\n",
 			    inode->i_ino);
-		if (!(zi->i_flags & ZONEFS_ZONE_OFFLINE))
-			zi->i_flags |=3D ZONEFS_ZONE_OFFLINE;
+		if (!(z->z_flags & ZONEFS_ZONE_OFFLINE))
+			z->z_flags |=3D ZONEFS_ZONE_OFFLINE;
 		zonefs_inode_update_mode(inode);
 		data_size =3D 0;
-	} else if ((zi->i_flags & ZONEFS_ZONE_READONLY) ||
+	} else if ((z->z_flags & ZONEFS_ZONE_READONLY) ||
 		   (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZRO)) {
 		zonefs_warn(sb, "inode %lu: write access disabled\n",
 			    inode->i_ino);
-		if (!(zi->i_flags & ZONEFS_ZONE_READONLY))
-			zi->i_flags |=3D ZONEFS_ZONE_READONLY;
+		if (!(z->z_flags & ZONEFS_ZONE_READONLY))
+			z->z_flags |=3D ZONEFS_ZONE_READONLY;
 		zonefs_inode_update_mode(inode);
 		data_size =3D isize;
 	} else if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_RO &&
@@ -299,8 +331,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	 * close of the zone when the inode file is closed.
 	 */
 	if ((sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) &&
-	    (zi->i_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)))
-		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+	    (z->z_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)))
+		z->z_flags &=3D ~ZONEFS_ZONE_OPEN;
=20
 	/*
 	 * If error=3Dremount-ro was specified, any error result in remounting
@@ -317,8 +349,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	 */
 	zonefs_update_stats(inode, data_size);
 	zonefs_i_size_write(inode, data_size);
-	zi->i_wpoffset =3D data_size;
-	zonefs_account_active(inode);
+	z->z_wpoffset =3D data_size;
+	zonefs_inode_account_active(inode);
=20
 	return 0;
 }
@@ -332,7 +364,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
  */
 void __zonefs_io_error(struct inode *inode, bool write)
 {
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	struct zonefs_zone *z =3D zonefs_inode_zone(inode);
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	unsigned int noio_flag;
@@ -348,8 +380,8 @@ void __zonefs_io_error(struct inode *inode, bool writ=
e)
 	 * files with aggregated conventional zones, for which the inode zone
 	 * size is always larger than the device zone size.
 	 */
-	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
-		nr_zones =3D zi->i_zone_size >>
+	if (z->z_size > bdev_zone_sectors(sb->s_bdev))
+		nr_zones =3D z->z_size >>
 			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
=20
 	/*
@@ -361,7 +393,7 @@ void __zonefs_io_error(struct inode *inode, bool writ=
e)
 	 * the GFP_NOIO context avoids both problems.
 	 */
 	noio_flag =3D memalloc_noio_save();
-	ret =3D blkdev_report_zones(sb->s_bdev, zi->i_zsector, nr_zones,
+	ret =3D blkdev_report_zones(sb->s_bdev, z->z_sector, nr_zones,
 				  zonefs_io_error_cb, &err);
 	if (ret !=3D nr_zones)
 		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
@@ -381,9 +413,7 @@ static struct inode *zonefs_alloc_inode(struct super_=
block *sb)
=20
 	inode_init_once(&zi->i_vnode);
 	mutex_init(&zi->i_truncate_mutex);
-	zi->i_wpoffset =3D 0;
 	zi->i_wr_refcnt =3D 0;
-	zi->i_flags =3D 0;
=20
 	return &zi->i_vnode;
 }
@@ -416,8 +446,8 @@ static int zonefs_statfs(struct dentry *dentry, struc=
t kstatfs *buf)
 	buf->f_bavail =3D buf->f_bfree;
=20
 	for (t =3D 0; t < ZONEFS_ZTYPE_MAX; t++) {
-		if (sbi->s_nr_files[t])
-			buf->f_files +=3D sbi->s_nr_files[t] + 1;
+		if (sbi->s_zgroup[t].g_nr_zones)
+			buf->f_files +=3D sbi->s_zgroup[t].g_nr_zones + 1;
 	}
 	buf->f_ffree =3D 0;
=20
@@ -557,11 +587,11 @@ static const struct inode_operations zonefs_dir_ino=
de_operations =3D {
 };
=20
 static void zonefs_init_dir_inode(struct inode *parent, struct inode *in=
ode,
-				  enum zonefs_ztype type)
+				  enum zonefs_ztype ztype)
 {
 	struct super_block *sb =3D parent->i_sb;
=20
-	inode->i_ino =3D bdev_nr_zones(sb->s_bdev) + type + 1;
+	inode->i_ino =3D bdev_nr_zones(sb->s_bdev) + ztype + 1;
 	inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
 	inode->i_op =3D &zonefs_dir_inode_operations;
 	inode->i_fop =3D &simple_dir_operations;
@@ -573,79 +603,34 @@ static const struct inode_operations zonefs_file_in=
ode_operations =3D {
 	.setattr	=3D zonefs_inode_setattr,
 };
=20
-static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *=
zone,
-				  enum zonefs_ztype type)
+static void zonefs_init_file_inode(struct inode *inode,
+				   struct zonefs_zone *z)
 {
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	int ret =3D 0;
-
-	inode->i_ino =3D zone->start >> sbi->s_zone_sectors_shift;
-	inode->i_mode =3D S_IFREG | sbi->s_perm;
=20
-	if (type =3D=3D ZONEFS_ZTYPE_CNV)
-		zi->i_flags |=3D ZONEFS_ZONE_CNV;
-
-	zi->i_zsector =3D zone->start;
-	zi->i_zone_size =3D zone->len << SECTOR_SHIFT;
-	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
-	    !(sbi->s_features & ZONEFS_F_AGGRCNV)) {
-		zonefs_err(sb,
-			   "zone size %llu doesn't match device's zone sectors %llu\n",
-			   zi->i_zone_size,
-			   bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
-		return -EINVAL;
-	}
-
-	zi->i_max_size =3D min_t(loff_t, MAX_LFS_FILESIZE,
-			       zone->capacity << SECTOR_SHIFT);
-	zi->i_wpoffset =3D zonefs_check_zone_condition(inode, zone);
+	inode->i_private =3D z;
=20
+	inode->i_ino =3D z->z_sector >> sbi->s_zone_sectors_shift;
+	inode->i_mode =3D S_IFREG | sbi->s_perm;
 	inode->i_uid =3D sbi->s_uid;
 	inode->i_gid =3D sbi->s_gid;
-	inode->i_size =3D zi->i_wpoffset;
-	inode->i_blocks =3D zi->i_max_size >> SECTOR_SHIFT;
+	inode->i_size =3D z->z_wpoffset;
+	inode->i_blocks =3D z->z_capacity >> SECTOR_SHIFT;
=20
 	inode->i_op =3D &zonefs_file_inode_operations;
 	inode->i_fop =3D &zonefs_file_operations;
 	inode->i_mapping->a_ops =3D &zonefs_file_aops;
=20
 	/* Update the inode access rights depending on the zone condition */
-	zi->i_flags |=3D ZONEFS_ZONE_INIT_MODE;
+	z->z_flags |=3D ZONEFS_ZONE_INIT_MODE;
 	zonefs_inode_update_mode(inode);
-
-	sb->s_maxbytes =3D max(zi->i_max_size, sb->s_maxbytes);
-	sbi->s_blocks +=3D zi->i_max_size >> sb->s_blocksize_bits;
-	sbi->s_used_blocks +=3D zi->i_wpoffset >> sb->s_blocksize_bits;
-
-	mutex_lock(&zi->i_truncate_mutex);
-
-	/*
-	 * For sequential zones, make sure that any open zone is closed first
-	 * to ensure that the initial number of open zones is 0, in sync with
-	 * the open zone accounting done when the mount option
-	 * ZONEFS_MNTOPT_EXPLICIT_OPEN is used.
-	 */
-	if (type =3D=3D ZONEFS_ZTYPE_SEQ &&
-	    (zone->cond =3D=3D BLK_ZONE_COND_IMP_OPEN ||
-	     zone->cond =3D=3D BLK_ZONE_COND_EXP_OPEN)) {
-		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
-		if (ret)
-			goto unlock;
-	}
-
-	zonefs_account_active(inode);
-
-unlock:
-	mutex_unlock(&zi->i_truncate_mutex);
-
-	return ret;
 }
=20
 static struct dentry *zonefs_create_inode(struct dentry *parent,
-					const char *name, struct blk_zone *zone,
-					enum zonefs_ztype type)
+					  const char *name,
+					  struct zonefs_zone *z,
+					  enum zonefs_ztype ztype)
 {
 	struct inode *dir =3D d_inode(parent);
 	struct dentry *dentry;
@@ -661,15 +646,10 @@ static struct dentry *zonefs_create_inode(struct de=
ntry *parent,
 		goto dput;
=20
 	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D dir->i_ctime;
-	if (zone) {
-		ret =3D zonefs_init_file_inode(inode, zone, type);
-		if (ret) {
-			iput(inode);
-			goto dput;
-		}
-	} else {
-		zonefs_init_dir_inode(dir, inode, type);
-	}
+	if (z)
+		zonefs_init_file_inode(inode, z);
+	else
+		zonefs_init_dir_inode(dir, inode, ztype);
=20
 	d_add(dentry, inode);
 	dir->i_size++;
@@ -685,100 +665,51 @@ static struct dentry *zonefs_create_inode(struct d=
entry *parent,
 struct zonefs_zone_data {
 	struct super_block	*sb;
 	unsigned int		nr_zones[ZONEFS_ZTYPE_MAX];
+	sector_t		cnv_zone_start;
 	struct blk_zone		*zones;
 };
=20
 /*
- * Create a zone group and populate it with zone files.
+ * Create the inodes for a zone group.
  */
-static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
-				enum zonefs_ztype type)
+static int zonefs_create_zgroup_inodes(struct super_block *sb,
+				       enum zonefs_ztype ztype)
 {
-	struct super_block *sb =3D zd->sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
-	struct blk_zone *zone, *next, *end;
-	const char *zgroup_name;
-	char *file_name;
+	struct zonefs_zone_group *zgroup =3D &sbi->s_zgroup[ztype];
 	struct dentry *dir, *dent;
-	unsigned int n =3D 0;
-	int ret;
+	char *file_name;
+	int i, ret =3D 0;
+
+	if (!zgroup)
+		return -ENOMEM;
=20
 	/* If the group is empty, there is nothing to do */
-	if (!zd->nr_zones[type])
+	if (!zgroup->g_nr_zones)
 		return 0;
=20
 	file_name =3D kmalloc(ZONEFS_NAME_MAX, GFP_KERNEL);
 	if (!file_name)
 		return -ENOMEM;
=20
-	if (type =3D=3D ZONEFS_ZTYPE_CNV)
-		zgroup_name =3D "cnv";
-	else
-		zgroup_name =3D "seq";
-
-	dir =3D zonefs_create_inode(sb->s_root, zgroup_name, NULL, type);
+	dir =3D zonefs_create_inode(sb->s_root, zonefs_zgroup_name(ztype),
+				  NULL, ztype);
 	if (IS_ERR(dir)) {
 		ret =3D PTR_ERR(dir);
 		goto free;
 	}
=20
-	/*
-	 * The first zone contains the super block: skip it.
-	 */
-	end =3D zd->zones + bdev_nr_zones(sb->s_bdev);
-	for (zone =3D &zd->zones[1]; zone < end; zone =3D next) {
-
-		next =3D zone + 1;
-		if (zonefs_zone_type(zone) !=3D type)
-			continue;
-
-		/*
-		 * For conventional zones, contiguous zones can be aggregated
-		 * together to form larger files. Note that this overwrites the
-		 * length of the first zone of the set of contiguous zones
-		 * aggregated together. If one offline or read-only zone is
-		 * found, assume that all zones aggregated have the same
-		 * condition.
-		 */
-		if (type =3D=3D ZONEFS_ZTYPE_CNV &&
-		    (sbi->s_features & ZONEFS_F_AGGRCNV)) {
-			for (; next < end; next++) {
-				if (zonefs_zone_type(next) !=3D type)
-					break;
-				zone->len +=3D next->len;
-				zone->capacity +=3D next->capacity;
-				if (next->cond =3D=3D BLK_ZONE_COND_READONLY &&
-				    zone->cond !=3D BLK_ZONE_COND_OFFLINE)
-					zone->cond =3D BLK_ZONE_COND_READONLY;
-				else if (next->cond =3D=3D BLK_ZONE_COND_OFFLINE)
-					zone->cond =3D BLK_ZONE_COND_OFFLINE;
-			}
-			if (zone->capacity !=3D zone->len) {
-				zonefs_err(sb, "Invalid conventional zone capacity\n");
-				ret =3D -EINVAL;
-				goto free;
-			}
-		}
-
-		/*
-		 * Use the file number within its group as file name.
-		 */
-		snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", n);
-		dent =3D zonefs_create_inode(dir, file_name, zone, type);
+	for (i =3D 0; i < zgroup->g_nr_zones; i++) {
+		/* Use the zone number within its group as the file name */
+		snprintf(file_name, ZONEFS_NAME_MAX - 1, "%u", i);
+		dent =3D zonefs_create_inode(dir, file_name,
+					   &zgroup->g_zones[i], ztype);
 		if (IS_ERR(dent)) {
 			ret =3D PTR_ERR(dent);
-			goto free;
+			break;
 		}
-
-		n++;
 	}
=20
-	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
-		    zgroup_name, n, n > 1 ? "s" : "");
-
-	sbi->s_nr_files[type] =3D n;
-	ret =3D 0;
-
 free:
 	kfree(file_name);
=20
@@ -789,21 +720,38 @@ static int zonefs_get_zone_info_cb(struct blk_zone =
*zone, unsigned int idx,
 				   void *data)
 {
 	struct zonefs_zone_data *zd =3D data;
+	struct super_block *sb =3D zd->sb;
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+
+	/*
+	 * We do not care about the first zone: it contains the super block
+	 * and not exposed as a file.
+	 */
+	if (!idx)
+		return 0;
=20
 	/*
-	 * Count the number of usable zones: the first zone at index 0 contains
-	 * the super block and is ignored.
+	 * Count the number of zones that will be exposed as files.
+	 * For sequential zones, we always have as many files as zones.
+	 * FOr conventional zones, the number of files depends on if we have
+	 * conventional zones aggregation enabled.
 	 */
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
-		zone->wp =3D zone->start + zone->len;
-		if (idx)
-			zd->nr_zones[ZONEFS_ZTYPE_CNV]++;
+		if (sbi->s_features & ZONEFS_F_AGGRCNV) {
+			/* One file per set of contiguous conventional zones */
+			if (!(sbi->s_zgroup[ZONEFS_ZTYPE_CNV].g_nr_zones) ||
+			    zone->start !=3D zd->cnv_zone_start)
+				sbi->s_zgroup[ZONEFS_ZTYPE_CNV].g_nr_zones++;
+			zd->cnv_zone_start =3D zone->start + zone->len;
+		} else {
+			/* One file per zone */
+			sbi->s_zgroup[ZONEFS_ZTYPE_CNV].g_nr_zones++;
+		}
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
-		if (idx)
-			zd->nr_zones[ZONEFS_ZTYPE_SEQ]++;
+		sbi->s_zgroup[ZONEFS_ZTYPE_SEQ].g_nr_zones++;
 		break;
 	default:
 		zonefs_err(zd->sb, "Unsupported zone type 0x%x\n",
@@ -843,11 +791,173 @@ static int zonefs_get_zone_info(struct zonefs_zone=
_data *zd)
 	return 0;
 }
=20
-static inline void zonefs_cleanup_zone_info(struct zonefs_zone_data *zd)
+static inline void zonefs_free_zone_info(struct zonefs_zone_data *zd)
 {
 	kvfree(zd->zones);
 }
=20
+/*
+ * Create a zone group and populate it with zone files.
+ */
+static int zonefs_init_zgroup(struct super_block *sb,
+			      struct zonefs_zone_data *zd,
+			      enum zonefs_ztype ztype)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	struct zonefs_zone_group *zgroup =3D &sbi->s_zgroup[ztype];
+	struct blk_zone *zone, *next, *end;
+	struct zonefs_zone *z;
+	unsigned int n =3D 0;
+	int ret;
+
+	/* Allocate the zone group. If it is empty, we have nothing to do. */
+	if (!zgroup->g_nr_zones)
+		return 0;
+
+	zgroup->g_zones =3D kvcalloc(zgroup->g_nr_zones,
+				   sizeof(struct zonefs_zone), GFP_KERNEL);
+	if (!zgroup->g_zones)
+		return -ENOMEM;
+
+	/*
+	 * Initialize the zone groups using the device zone information.
+	 * We always skip the first zone as it contains the super block
+	 * and is not use to back a file.
+	 */
+	end =3D zd->zones + bdev_nr_zones(sb->s_bdev);
+	for (zone =3D &zd->zones[1]; zone < end; zone =3D next) {
+
+		next =3D zone + 1;
+		if (zonefs_zone_type(zone) !=3D ztype)
+			continue;
+
+		if (WARN_ON_ONCE(n >=3D zgroup->g_nr_zones))
+			return -EINVAL;
+
+		/*
+		 * For conventional zones, contiguous zones can be aggregated
+		 * together to form larger files. Note that this overwrites the
+		 * length of the first zone of the set of contiguous zones
+		 * aggregated together. If one offline or read-only zone is
+		 * found, assume that all zones aggregated have the same
+		 * condition.
+		 */
+		if (ztype =3D=3D ZONEFS_ZTYPE_CNV &&
+		    (sbi->s_features & ZONEFS_F_AGGRCNV)) {
+			for (; next < end; next++) {
+				if (zonefs_zone_type(next) !=3D ztype)
+					break;
+				zone->len +=3D next->len;
+				zone->capacity +=3D next->capacity;
+				if (next->cond =3D=3D BLK_ZONE_COND_READONLY &&
+				    zone->cond !=3D BLK_ZONE_COND_OFFLINE)
+					zone->cond =3D BLK_ZONE_COND_READONLY;
+				else if (next->cond =3D=3D BLK_ZONE_COND_OFFLINE)
+					zone->cond =3D BLK_ZONE_COND_OFFLINE;
+			}
+		}
+
+		z =3D &zgroup->g_zones[n];
+		if (ztype =3D=3D ZONEFS_ZTYPE_CNV)
+			z->z_flags |=3D ZONEFS_ZONE_CNV;
+		z->z_sector =3D zone->start;
+		z->z_size =3D zone->len << SECTOR_SHIFT;
+		if (z->z_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
+		    !(sbi->s_features & ZONEFS_F_AGGRCNV)) {
+			zonefs_err(sb,
+				"Invalid zone size %llu (device zone sectors %llu)\n",
+				z->z_size,
+				bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
+			return -EINVAL;
+		}
+
+		z->z_capacity =3D min_t(loff_t, MAX_LFS_FILESIZE,
+				      zone->capacity << SECTOR_SHIFT);
+		z->z_wpoffset =3D zonefs_check_zone_condition(sb, z, zone);
+
+		sb->s_maxbytes =3D max(z->z_capacity, sb->s_maxbytes);
+		sbi->s_blocks +=3D z->z_capacity >> sb->s_blocksize_bits;
+		sbi->s_used_blocks +=3D z->z_wpoffset >> sb->s_blocksize_bits;
+
+		/*
+		 * For sequential zones, make sure that any open zone is closed
+		 * first to ensure that the initial number of open zones is 0,
+		 * in sync with the open zone accounting done when the mount
+		 * option ZONEFS_MNTOPT_EXPLICIT_OPEN is used.
+		 */
+		if (ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
+		    (zone->cond =3D=3D BLK_ZONE_COND_IMP_OPEN ||
+		     zone->cond =3D=3D BLK_ZONE_COND_EXP_OPEN)) {
+			ret =3D zonefs_zone_mgmt(sb, z, REQ_OP_ZONE_CLOSE);
+			if (ret)
+				return ret;
+		}
+
+		zonefs_account_active(sb, z);
+
+		n++;
+	}
+
+	if (WARN_ON_ONCE(n !=3D zgroup->g_nr_zones))
+		return -EINVAL;
+
+	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
+		    zonefs_zgroup_name(ztype),
+		    zgroup->g_nr_zones,
+		    zgroup->g_nr_zones > 1 ? "s" : "");
+
+	return 0;
+}
+
+static void zonefs_free_zgroups(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	enum zonefs_ztype ztype;
+
+	if (!sbi)
+		return;
+
+	for (ztype =3D 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
+		kvfree(sbi->s_zgroup[ztype].g_zones);
+		sbi->s_zgroup[ztype].g_zones =3D NULL;
+	}
+}
+
+/*
+ * Create a zone group and populate it with zone files.
+ */
+static int zonefs_init_zgroups(struct super_block *sb)
+{
+	struct zonefs_zone_data zd;
+	enum zonefs_ztype ztype;
+	int ret;
+
+	/* First get the device zone information */
+	memset(&zd, 0, sizeof(struct zonefs_zone_data));
+	zd.sb =3D sb;
+	ret =3D zonefs_get_zone_info(&zd);
+	if (ret)
+		goto cleanup;
+
+	/* Allocate and initialize the zone groups */
+	for (ztype =3D 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
+		ret =3D zonefs_init_zgroup(sb, &zd, ztype);
+		if (ret) {
+			zonefs_info(sb,
+				    "Zone group \"%s\" initialization failed\n",
+				    zonefs_zgroup_name(ztype));
+			break;
+		}
+	}
+
+cleanup:
+	zonefs_free_zone_info(&zd);
+	if (ret)
+		zonefs_free_zgroups(sb);
+
+	return ret;
+}
+
 /*
  * Read super block information from the device.
  */
@@ -945,7 +1055,6 @@ static const struct super_operations zonefs_sops =3D=
 {
  */
 static int zonefs_fill_super(struct super_block *sb, void *data, int sil=
ent)
 {
-	struct zonefs_zone_data zd;
 	struct zonefs_sb_info *sbi;
 	struct inode *inode;
 	enum zonefs_ztype t;
@@ -998,16 +1107,6 @@ static int zonefs_fill_super(struct super_block *sb=
, void *data, int silent)
 	if (ret)
 		return ret;
=20
-	memset(&zd, 0, sizeof(struct zonefs_zone_data));
-	zd.sb =3D sb;
-	ret =3D zonefs_get_zone_info(&zd);
-	if (ret)
-		goto cleanup;
-
-	ret =3D zonefs_sysfs_register(sb);
-	if (ret)
-		goto cleanup;
-
 	zonefs_info(sb, "Mounting %u zones", bdev_nr_zones(sb->s_bdev));
=20
 	if (!sbi->s_max_wro_seq_files &&
@@ -1018,6 +1117,11 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)
 		sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
 	}
=20
+	/* Initialize the zone groups */
+	ret =3D zonefs_init_zgroups(sb);
+	if (ret)
+		goto cleanup;
+
 	/* Create root directory inode */
 	ret =3D -ENOMEM;
 	inode =3D new_inode(sb);
@@ -1037,13 +1141,19 @@ static int zonefs_fill_super(struct super_block *=
sb, void *data, int silent)
=20
 	/* Create and populate files in zone groups directories */
 	for (t =3D 0; t < ZONEFS_ZTYPE_MAX; t++) {
-		ret =3D zonefs_create_zgroup(&zd, t);
+		ret =3D zonefs_create_zgroup_inodes(sb, t);
 		if (ret)
-			break;
+			goto cleanup;
 	}
=20
+	ret =3D zonefs_sysfs_register(sb);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
 cleanup:
-	zonefs_cleanup_zone_info(&zd);
+	zonefs_free_zgroups(sb);
=20
 	return ret;
 }
@@ -1062,6 +1172,7 @@ static void zonefs_kill_super(struct super_block *s=
b)
 		d_genocide(sb->s_root);
=20
 	zonefs_sysfs_unregister(sb);
+	zonefs_free_zgroups(sb);
 	kill_block_super(sb);
 	kfree(sbi);
 }
diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
index 42edcfd393ed..9969db3a9c7d 100644
--- a/fs/zonefs/trace.h
+++ b/fs/zonefs/trace.h
@@ -20,8 +20,9 @@
 #define show_dev(dev) MAJOR(dev), MINOR(dev)
=20
 TRACE_EVENT(zonefs_zone_mgmt,
-	    TP_PROTO(struct inode *inode, enum req_op op),
-	    TP_ARGS(inode, op),
+	    TP_PROTO(struct super_block *sb, struct zonefs_zone *z,
+		     enum req_op op),
+	    TP_ARGS(sb, z, op),
 	    TP_STRUCT__entry(
 			     __field(dev_t, dev)
 			     __field(ino_t, ino)
@@ -30,12 +31,12 @@ TRACE_EVENT(zonefs_zone_mgmt,
 			     __field(sector_t, nr_sectors)
 	    ),
 	    TP_fast_assign(
-			   __entry->dev =3D inode->i_sb->s_dev;
-			   __entry->ino =3D inode->i_ino;
+			   __entry->dev =3D sb->s_dev;
+			   __entry->ino =3D
+				z->z_sector >> ZONEFS_SB(sb)->s_zone_sectors_shift;
 			   __entry->op =3D op;
-			   __entry->sector =3D ZONEFS_I(inode)->i_zsector;
-			   __entry->nr_sectors =3D
-				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
+			   __entry->sector =3D z->z_sector;
+			   __entry->nr_sectors =3D z->z_size >> SECTOR_SHIFT;
 	    ),
 	    TP_printk("bdev=3D(%d,%d), ino=3D%lu op=3D%s, sector=3D%llu, nr_sec=
tors=3D%llu",
 		      show_dev(__entry->dev), (unsigned long)__entry->ino,
@@ -58,9 +59,10 @@ TRACE_EVENT(zonefs_file_dio_append,
 	    TP_fast_assign(
 			   __entry->dev =3D inode->i_sb->s_dev;
 			   __entry->ino =3D inode->i_ino;
-			   __entry->sector =3D ZONEFS_I(inode)->i_zsector;
+			   __entry->sector =3D zonefs_inode_zone(inode)->z_sector;
 			   __entry->size =3D size;
-			   __entry->wpoffset =3D ZONEFS_I(inode)->i_wpoffset;
+			   __entry->wpoffset =3D
+				zonefs_inode_zone(inode)->z_wpoffset;
 			   __entry->ret =3D ret;
 	    ),
 	    TP_printk("bdev=3D(%d, %d), ino=3D%lu, sector=3D%llu, size=3D%zu, w=
poffset=3D%llu, ret=3D%zu",
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 1a225f74015a..2d626e18b141 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -47,22 +47,39 @@ static inline enum zonefs_ztype zonefs_zone_type(stru=
ct blk_zone *zone)
 #define ZONEFS_ZONE_CNV		(1U << 31)
=20
 /*
- * In-memory inode data.
+ * In-memory per-file inode zone data.
  */
-struct zonefs_inode_info {
-	struct inode		i_vnode;
+struct zonefs_zone {
+	/* Zone state flags */
+	unsigned int		z_flags;
=20
-	/* File zone start sector (512B unit) */
-	sector_t		i_zsector;
+	/* Zone start sector (512B unit) */
+	sector_t		z_sector;
=20
-	/* File zone write pointer position (sequential zones only) */
-	loff_t			i_wpoffset;
+	/* Zone size (bytes) */
+	loff_t			z_size;
=20
-	/* File maximum size */
-	loff_t			i_max_size;
+	/* Zone capacity (file maximum size, bytes) */
+	loff_t			z_capacity;
=20
-	/* File zone size */
-	loff_t			i_zone_size;
+	/* Write pointer offset in the zone (sequential zones only, bytes) */
+	loff_t			z_wpoffset;
+};
+
+/*
+ * In memory zone group information: all zones of a group are exposed
+ * as files, one file per zone.
+ */
+struct zonefs_zone_group {
+	unsigned int		g_nr_zones;
+	struct zonefs_zone	*g_zones;
+};
+
+/*
+ * In-memory inode data.
+ */
+struct zonefs_inode_info {
+	struct inode		i_vnode;
=20
 	/*
 	 * To serialise fully against both syscall and mmap based IO and
@@ -81,7 +98,6 @@ struct zonefs_inode_info {
=20
 	/* guarded by i_truncate_mutex */
 	unsigned int		i_wr_refcnt;
-	unsigned int		i_flags;
 };
=20
 static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)
@@ -89,24 +105,29 @@ static inline struct zonefs_inode_info *ZONEFS_I(str=
uct inode *inode)
 	return container_of(inode, struct zonefs_inode_info, i_vnode);
 }
=20
-static inline bool zonefs_zone_is_cnv(struct zonefs_inode_info *zi)
+static inline bool zonefs_zone_is_cnv(struct zonefs_zone *z)
+{
+	return z->z_flags & ZONEFS_ZONE_CNV;
+}
+
+static inline bool zonefs_zone_is_seq(struct zonefs_zone *z)
 {
-	return zi->i_flags & ZONEFS_ZONE_CNV;
+	return !zonefs_zone_is_cnv(z);
 }
=20
-static inline bool zonefs_zone_is_seq(struct zonefs_inode_info *zi)
+static inline struct zonefs_zone *zonefs_inode_zone(struct inode *inode)
 {
-	return !zonefs_zone_is_cnv(zi);
+	return inode->i_private;
 }
=20
 static inline bool zonefs_inode_is_cnv(struct inode *inode)
 {
-	return zonefs_zone_is_cnv(ZONEFS_I(inode));
+	return zonefs_zone_is_cnv(zonefs_inode_zone(inode));
 }
=20
 static inline bool zonefs_inode_is_seq(struct inode *inode)
 {
-	return zonefs_zone_is_seq(ZONEFS_I(inode));
+	return zonefs_zone_is_seq(zonefs_inode_zone(inode));
 }
=20
 /*
@@ -200,7 +221,7 @@ struct zonefs_sb_info {
 	uuid_t			s_uuid;
 	unsigned int		s_zone_sectors_shift;
=20
-	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
+	struct zonefs_zone_group s_zgroup[ZONEFS_ZTYPE_MAX];
=20
 	loff_t			s_blocks;
 	loff_t			s_used_blocks;
@@ -229,8 +250,8 @@ static inline struct zonefs_sb_info *ZONEFS_SB(struct=
 super_block *sb)
 	pr_warn("zonefs (%s) WARNING: " format, sb->s_id, ## args)
=20
 /* In super.c */
-void zonefs_account_active(struct inode *inode);
-int zonefs_zone_mgmt(struct inode *inode, enum req_op op);
+void zonefs_inode_account_active(struct inode *inode);
+int zonefs_inode_zone_mgmt(struct inode *inode, enum req_op op);
 void zonefs_i_size_write(struct inode *inode, loff_t isize);
 void zonefs_update_stats(struct inode *inode, loff_t new_isize);
 void __zonefs_io_error(struct inode *inode, bool write);
--=20
2.39.0

