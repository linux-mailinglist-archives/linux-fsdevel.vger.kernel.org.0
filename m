Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D6664140
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbjAJNIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjAJNIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:40 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E666133A
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356118; x=1704892118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/7TKvGtWPjPiMDh5r5PATLv5h5Si6j/IXDm2pDcSv7E=;
  b=OgLEkA4+3aJhZZDvqgKySVnSpXDWU4a8KBe1feiu3R0ZX75ceNgM2DJk
   7te6Ic7ZsTqqwqxz8x/VuWl4ESGIyHE7J26GGtCpYpx6YPwUwCpozB9vO
   lAx+4pc7FfyRsuetO60HLkBsJsn/IJlGmiHZgNfjJg4vGbcdCvqRZOYH0
   SJsgLaohfXQ9RemzX/Q1uQRyFpvbuVu6M3aBwD7AnXPQ00HCagxXOdakY
   rMKksGWi/0CIyTvn2wsDvUwZOqt7GHg34ZzTopk0jj0s7LPXbRWec1LfX
   42irJ4Rib+iRMk+7I5XeytN9rYhHRLxsVH9DYrsYGbf/WGMGlSK8EIAy+
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740563"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:38 +0800
IronPort-SDR: riHDY+wJjUcyjeamPgmfW+xgg2H6t7VJaMXKN3FAE0FjYBkPnL9aTxsbuUxMb6UKXPuWGTLTH9
 TbaAAiifdeQMpHerTDs60bFUfW0PU8lprEche/082m7QYQB26ghUNCAvcHfkLPlU4VUZHKm72Q
 6w4wO+uhWgAXj2/uLDlH2G/tzgNQxRCgFvkSAcLeetZ7BS3DhAgrYfomnYqxkU4aS3qUD7iYIU
 9Z6Q7OOq0brXTenFu910sfSKA5vprpqBor7hFxSIYj8Gl2u4RIvZatdItc6na1KFPM/jkA3rm3
 oJ0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:43 -0800
IronPort-SDR: WKmEF7Ye+j9D0NLqfE2uDzE4ccwMv7IzsZiFz0lfSXxID19EAB47uLFMQA7luNJFb3SLfvFzbJ
 Y7ubjnMNMGLKjk4a7oUhNx/KlEaR1AUr/BQllBXJEXkYoDdP35AwWPd+nqtF/SLOf8yXoS4INw
 Catt/gpB5yM7uixnFJz5NQl826UlzajZ7gcAEaYnPSKKfz+jM5fbsZk7bqTaaHDCco65HFrIAj
 t8qO91+XqmI76QePPhwxNIb31qu8spKZsMk473WM2Q7MidzgrOgwgnM05Yt2xGF9/KH7UPV97O
 iKI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjL1G4Rz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356117; x=1675948118; bh=/7TKvGtWPjPiMDh5r5
        PATLv5h5Si6j/IXDm2pDcSv7E=; b=G51zf2doheTLaDlw9Rik+bFyrb5J99u6I6
        HWu6xV3SKMGpHc9IAvvTi1DsILLRMbPoxYsGRw9alLzvPbB4rgrZ/F9pTU0SZI94
        X0R2vN62chEOlbiIoNu/UwEUO2Qpytlfygqc/sa47X7iAEaEzSXULVeKHFrndBmM
        NS/Xa9GJkBmpsQydHFFKJmHT4mGOZ/zoOTN07xWABh6BjyevXzBe/rvVOSqo9CNp
        WJjpdtAYuoPis09TWS4a88mKvkTuu9Fyuz3wmQCfVLqmQrSpz+NgXHlxmA8mitbQ
        wpv/5AJ4LiUDT2aAJAf8zNh9kxmfh2XjD8jIenLVqLOvojRVI5Dg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tYfetCNt8kG5 for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:37 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjJ3GKvz1RwqL;
        Tue, 10 Jan 2023 05:08:36 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 4/7] zonefs: Reduce struct zonefs_inode_info size
Date:   Tue, 10 Jan 2023 22:08:27 +0900
Message-Id: <20230110130830.246019-5-damien.lemoal@opensource.wdc.com>
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

Instead of using the i_ztype field in struct zonefs_inode_info to
indicate the zone type of an inode, introduce the new inode flag
ZONEFS_ZONE_CNV to be set in the i_flags field of struct
zonefs_inode_info to identify conventional zones. If this flag is not
set, the zone of an inode is considered to be a sequential zone.

The helpers zonefs_zone_is_cnv(), zonefs_zone_is_seq(),
zonefs_inode_is_cnv() and zonefs_inode_is_seq() are introduced to
simplify testing the zone type of a struct zonefs_inode_info and of a
struct inode.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/file.c   | 35 ++++++++++++++---------------------
 fs/zonefs/super.c  | 12 +++++++-----
 fs/zonefs/zonefs.h | 24 +++++++++++++++++++++---
 3 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index ece0f3959b6d..64873d31d75d 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -77,8 +77,7 @@ static int zonefs_write_iomap_begin(struct inode *inode=
, loff_t offset,
 	 * checked when writes are issued, so warn if we see a page writeback
 	 * operation.
 	 */
-	if (WARN_ON_ONCE(zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
-			 !(flags & IOMAP_DIRECT)))
+	if (WARN_ON_ONCE(zonefs_zone_is_seq(zi) && !(flags & IOMAP_DIRECT)))
 		return -EIO;
=20
 	/*
@@ -128,7 +127,7 @@ static int zonefs_write_map_blocks(struct iomap_write=
page_ctx *wpc,
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
=20
-	if (WARN_ON_ONCE(zi->i_ztype !=3D ZONEFS_ZTYPE_CNV))
+	if (WARN_ON_ONCE(zonefs_zone_is_seq(zi)))
 		return -EIO;
 	if (WARN_ON_ONCE(offset >=3D i_size_read(inode)))
 		return -EIO;
@@ -158,9 +157,8 @@ static int zonefs_swap_activate(struct swap_info_stru=
ct *sis,
 				struct file *swap_file, sector_t *span)
 {
 	struct inode *inode =3D file_inode(swap_file);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
=20
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_CNV) {
+	if (zonefs_inode_is_seq(inode)) {
 		zonefs_err(inode->i_sb,
 			   "swap file: not a conventional zone file\n");
 		return -EINVAL;
@@ -196,7 +194,7 @@ int zonefs_file_truncate(struct inode *inode, loff_t =
isize)
 	 * only down to a 0 size, which is equivalent to a zone reset, and to
 	 * the maximum file size, which is equivalent to a zone finish.
 	 */
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+	if (!zonefs_zone_is_seq(zi))
 		return -EPERM;
=20
 	if (!isize)
@@ -266,7 +264,7 @@ static int zonefs_file_fsync(struct file *file, loff_=
t start, loff_t end,
 	 * Since only direct writes are allowed in sequential files, page cache
 	 * flush is needed only for conventional zone files.
 	 */
-	if (ZONEFS_I(inode)->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)
+	if (zonefs_inode_is_cnv(inode))
 		ret =3D file_write_and_wait_range(file, start, end);
 	if (!ret)
 		ret =3D blkdev_issue_flush(inode->i_sb->s_bdev);
@@ -280,7 +278,6 @@ static int zonefs_file_fsync(struct file *file, loff_=
t start, loff_t end,
 static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
 	vm_fault_t ret;
=20
 	if (unlikely(IS_IMMUTABLE(inode)))
@@ -290,7 +287,7 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct =
vm_fault *vmf)
 	 * Sanity check: only conventional zone files can have shared
 	 * writeable mappings.
 	 */
-	if (WARN_ON_ONCE(zi->i_ztype !=3D ZONEFS_ZTYPE_CNV))
+	if (zonefs_inode_is_seq(inode))
 		return VM_FAULT_NOPAGE;
=20
 	sb_start_pagefault(inode->i_sb);
@@ -319,7 +316,7 @@ static int zonefs_file_mmap(struct file *file, struct=
 vm_area_struct *vma)
 	 * mappings are possible since there are no guarantees for write
 	 * ordering between msync() and page cache writeback.
 	 */
-	if (ZONEFS_I(file_inode(file))->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
+	if (zonefs_inode_is_seq(file_inode(file)) &&
 	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
 		return -EINVAL;
=20
@@ -352,7 +349,7 @@ static int zonefs_file_write_dio_end_io(struct kiocb =
*iocb, ssize_t size,
 		return error;
 	}
=20
-	if (size && zi->i_ztype !=3D ZONEFS_ZTYPE_CNV) {
+	if (size && zonefs_zone_is_seq(zi)) {
 		/*
 		 * Note that we may be seeing completions out of order,
 		 * but that is not a problem since a write completed
@@ -491,7 +488,7 @@ static ssize_t zonefs_write_checks(struct kiocb *iocb=
, struct iov_iter *from)
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_APPEND) {
-		if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+		if (zonefs_zone_is_cnv(zi))
 			return -EINVAL;
 		mutex_lock(&zi->i_truncate_mutex);
 		iocb->ki_pos =3D zi->i_wpoffset;
@@ -531,8 +528,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
 	 * on the inode lock but the second goes through but is now unaligned).
 	 */
-	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !sync &&
-	    (iocb->ki_flags & IOCB_NOWAIT))
+	if (zonefs_zone_is_seq(zi) && !sync && (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
=20
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -554,7 +550,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 	}
=20
 	/* Enforce sequential writes (append only) in sequential zones */
-	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ) {
+	if (zonefs_zone_is_seq(zi)) {
 		mutex_lock(&zi->i_truncate_mutex);
 		if (iocb->ki_pos !=3D zi->i_wpoffset) {
 			mutex_unlock(&zi->i_truncate_mutex);
@@ -570,7 +566,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
 	else
 		ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
 				   &zonefs_write_dio_ops, 0, NULL, 0);
-	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&
+	if (zonefs_zone_is_seq(zi) &&
 	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
 		if (ret > 0)
 			count =3D ret;
@@ -596,14 +592,13 @@ static ssize_t zonefs_file_buffered_write(struct ki=
ocb *iocb,
 					  struct iov_iter *from)
 {
 	struct inode *inode =3D file_inode(iocb->ki_filp);
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
 	ssize_t ret;
=20
 	/*
 	 * Direct IO writes are mandatory for sequential zone files so that the
 	 * write IO issuing order is preserved.
 	 */
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_CNV)
+	if (zonefs_inode_is_seq(inode))
 		return -EIO;
=20
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -731,9 +726,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
 static inline bool zonefs_seq_file_need_wro(struct inode *inode,
 					    struct file *file)
 {
-	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+	if (zonefs_inode_is_cnv(inode))
 		return false;
=20
 	if (!(file->f_mode & FMODE_WRITE))
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 6307cc95be06..a4af29dc32e7 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -37,7 +37,7 @@ void zonefs_account_active(struct inode *inode)
=20
 	lockdep_assert_held(&zi->i_truncate_mutex);
=20
-	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+	if (zonefs_zone_is_cnv(zi))
 		return;
=20
 	/*
@@ -177,14 +177,14 @@ static loff_t zonefs_check_zone_condition(struct in=
ode *inode,
 		zonefs_warn(inode->i_sb, "inode %lu: read-only zone\n",
 			    inode->i_ino);
 		zi->i_flags |=3D ZONEFS_ZONE_READONLY;
-		if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)
+		if (zonefs_zone_is_cnv(zi))
 			return zi->i_max_size;
 		return zi->i_wpoffset;
 	case BLK_ZONE_COND_FULL:
 		/* The write pointer of full zones is invalid. */
 		return zi->i_max_size;
 	default:
-		if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)
+		if (zonefs_zone_is_cnv(zi))
 			return zi->i_max_size;
 		return (zone->wp - zone->start) << SECTOR_SHIFT;
 	}
@@ -260,7 +260,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	 * In all cases, warn about inode size inconsistency and handle the
 	 * IO error according to the zone condition and to the mount options.
 	 */
-	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && isize !=3D data_size)
+	if (zonefs_zone_is_seq(zi) && isize !=3D data_size)
 		zonefs_warn(sb, "inode %lu: invalid size %lld (should be %lld)\n",
 			    inode->i_ino, isize, data_size);
=20
@@ -584,7 +584,9 @@ static int zonefs_init_file_inode(struct inode *inode=
, struct blk_zone *zone,
 	inode->i_ino =3D zone->start >> sbi->s_zone_sectors_shift;
 	inode->i_mode =3D S_IFREG | sbi->s_perm;
=20
-	zi->i_ztype =3D type;
+	if (type =3D=3D ZONEFS_ZTYPE_CNV)
+		zi->i_flags |=3D ZONEFS_ZONE_CNV;
+
 	zi->i_zsector =3D zone->start;
 	zi->i_zone_size =3D zone->len << SECTOR_SHIFT;
 	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 439096445ee5..1a225f74015a 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -44,6 +44,7 @@ static inline enum zonefs_ztype zonefs_zone_type(struct=
 blk_zone *zone)
 #define ZONEFS_ZONE_ACTIVE	(1U << 2)
 #define ZONEFS_ZONE_OFFLINE	(1U << 3)
 #define ZONEFS_ZONE_READONLY	(1U << 4)
+#define ZONEFS_ZONE_CNV		(1U << 31)
=20
 /*
  * In-memory inode data.
@@ -51,9 +52,6 @@ static inline enum zonefs_ztype zonefs_zone_type(struct=
 blk_zone *zone)
 struct zonefs_inode_info {
 	struct inode		i_vnode;
=20
-	/* File zone type */
-	enum zonefs_ztype	i_ztype;
-
 	/* File zone start sector (512B unit) */
 	sector_t		i_zsector;
=20
@@ -91,6 +89,26 @@ static inline struct zonefs_inode_info *ZONEFS_I(struc=
t inode *inode)
 	return container_of(inode, struct zonefs_inode_info, i_vnode);
 }
=20
+static inline bool zonefs_zone_is_cnv(struct zonefs_inode_info *zi)
+{
+	return zi->i_flags & ZONEFS_ZONE_CNV;
+}
+
+static inline bool zonefs_zone_is_seq(struct zonefs_inode_info *zi)
+{
+	return !zonefs_zone_is_cnv(zi);
+}
+
+static inline bool zonefs_inode_is_cnv(struct inode *inode)
+{
+	return zonefs_zone_is_cnv(ZONEFS_I(inode));
+}
+
+static inline bool zonefs_inode_is_seq(struct inode *inode)
+{
+	return zonefs_zone_is_seq(ZONEFS_I(inode));
+}
+
 /*
  * On-disk super block (block 0).
  */
--=20
2.39.0

