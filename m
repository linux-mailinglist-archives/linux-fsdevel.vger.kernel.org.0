Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C7664141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjAJNIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjAJNIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:38 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ADD5E093
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356117; x=1704892117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bB4tEFe8pkh+KfjQXkgkwHvjQ9kZFKkZbuYrb1exEN8=;
  b=FZdObvpnqhNMEHF7ueH3vbXXY4PKbtYMI6Qp2XLy4TfTng07NcQmCpnt
   KC+0E5n448DgCULdS38KIxzc02Q67kniMKUnJx8gCBIRu9EcUS7CQc5oS
   7UayVSWmnyJy+7UA6x+PYDJRXOO8QxHkfHV/+hmz8kwZ45+rhVQvn54YO
   dLtHoGZ1SU0Pk7ycDWKlRPq1QSJxJ7lBoLtFvyrNslXo75aR66u7KMwPo
   Z81l7W0t7qKzDitFwUDGISLTt3tjl03kf1h2419i5GkaEJm6EsPobonMG
   vMRog8bXooLQrdIXZFEsUVD6AHPc5Kdotbi1LjBwTctukg1k7nCtaZ4RM
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740560"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:37 +0800
IronPort-SDR: Wk1BBd+Z5IcJiq+9FziF2RRHkfCPlGRE1e6ZaRN/4BXTGG3Yyt6JEFdXf4X4oBPcvKQOBQfHrx
 cJs7dar47aktfO0swQLs2UcOA/i2ZJhaNzquVYnSW9eMRTIQ7v9RTbRHjdkF+VZAYRQVBc+x/y
 C328QEw820E3RIhQtt8tw6S7nrsX5nIwvfRG2a3BEKVUIKsWLRhogwLwvuzsIV9zu7hGKdV+k5
 bR3d/yRz5xdxtPrD6jfa6cQq5O6yVay35P8NB0PZVnQaBQGnbkmVGrFFH47O+3T8Xf1DAhrkid
 pm8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:42 -0800
IronPort-SDR: niT3QGca1rZbLf+Vyb0naaofX83RmfOvtQkimiF5iaJXSttxnyTXP+fZFDdmRR2joiXcoDivPJ
 dFM7/TDz4xKmYce3gtWSc1XbxZhlytS49MtWn8CE4x1wgKYBAXVWJyuDXwXG1NP+1j3ThRj/Vn
 HGb2UP6FAwstUs9T0+YOi9yVgNFitgbennjTi6Fp1GJkQUhEAUaPkldRFwdjLbdcmpnTBf9nb5
 WLsstLIyxdFaKI1GrRpqA5Kx+Ucw3zn1NEJbmeTo5FzwW2B3YYV1bsWqfEZW8XIdwGVVNC5ppF
 ZWQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjK0kkNz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356116; x=1675948117; bh=bB4tEFe8pkh+KfjQXk
        gkwHvjQ9kZFKkZbuYrb1exEN8=; b=H1ulPslWnE1Og+SJwvwA0ZqjAUPi3qstU9
        swCKa3hmA/u6upkADJxAEUSCxAQTN14ZPHINQpk3NkbHknS6gvtOtFYpG0EftyHx
        j7QLgDBFmiao33C8kz5U+YD/o6DDWDjzclsASWQrubHLCEKOiy6xAcgiwdVOWiQ/
        +6EzzWz9L2hZY/pNHbSatlrgR2HWCfuq3IELXq1Utwz2QuG4ePS79e+ykhj/pwT8
        nd/9cSAcoH2VWYiaq95a68WDBumGXEARykQaUX6ZG3CRYlFnEoXIIEmMY/hPN94Y
        +AHD6G5SzYXLo4EhHtxytjp/xeJApmeksh/S//HrvDknTFZpF58Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fFS2nhbVS3fH for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:36 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjH16n7z1RvTp;
        Tue, 10 Jan 2023 05:08:34 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 3/7] zonefs: Simplify IO error handling
Date:   Tue, 10 Jan 2023 22:08:26 +0900
Message-Id: <20230110130830.246019-4-damien.lemoal@opensource.wdc.com>
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

Simplify zonefs_check_zone_condition() by moving the code that changes
an inode access rights to the new function zonefs_inode_update_mode().
Furthermore, since on mount an inode wpoffset is always zero when
zonefs_check_zone_condition() is called during an inode initialization,
the "mount" boolean argument is not necessary for the readonly zone
case. This argument is thus removed.

zonefs_io_error_cb() is also modified to use the inode offline and
zone state flags instead of checking the device zone condition. The
multiple calls to zonefs_check_zone_condition() are reduced to the first
call on entry, which allows removing the "warn" argument.
zonefs_inode_update_mode() is also used to update an inode access rights
as zonefs_io_error_cb() modifies the inode flags depending on the volume
error handling mode (defined with a mount option). Since an inode mode
change differs for read-only zones between mount time and IO error time,
the flag ZONEFS_ZONE_INIT_MODE is used to differentiate both cases.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c  | 110 ++++++++++++++++++++++++---------------------
 fs/zonefs/zonefs.h |   9 ++--
 2 files changed, 64 insertions(+), 55 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e808276b8801..6307cc95be06 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -155,48 +155,31 @@ void zonefs_update_stats(struct inode *inode, loff_=
t new_isize)
  * amount of readable data in the zone.
  */
 static loff_t zonefs_check_zone_condition(struct inode *inode,
-					  struct blk_zone *zone, bool warn,
-					  bool mount)
+					  struct blk_zone *zone)
 {
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
=20
 	switch (zone->cond) {
 	case BLK_ZONE_COND_OFFLINE:
-		/*
-		 * Dead zone: make the inode immutable, disable all accesses
-		 * and set the file size to 0 (zone wp set to zone start).
-		 */
-		if (warn)
-			zonefs_warn(inode->i_sb, "inode %lu: offline zone\n",
-				    inode->i_ino);
-		inode->i_flags |=3D S_IMMUTABLE;
-		inode->i_mode &=3D ~0777;
-		zone->wp =3D zone->start;
+		zonefs_warn(inode->i_sb, "inode %lu: offline zone\n",
+			    inode->i_ino);
 		zi->i_flags |=3D ZONEFS_ZONE_OFFLINE;
 		return 0;
 	case BLK_ZONE_COND_READONLY:
 		/*
-		 * The write pointer of read-only zones is invalid. If such a
-		 * zone is found during mount, the file size cannot be retrieved
-		 * so we treat the zone as offline (mount =3D=3D true case).
-		 * Otherwise, keep the file size as it was when last updated
-		 * so that the user can recover data. In both cases, writes are
-		 * always disabled for the zone.
+		 * The write pointer of read-only zones is invalid, so we cannot
+		 * determine the zone wpoffset (inode size). We thus keep the
+		 * zone wpoffset as is, which leads to an empty file
+		 * (wpoffset =3D=3D 0) on mount. For a runtime error, this keeps
+		 * the inode size as it was when last updated so that the user
+		 * can recover data.
 		 */
-		if (warn)
-			zonefs_warn(inode->i_sb, "inode %lu: read-only zone\n",
-				    inode->i_ino);
-		inode->i_flags |=3D S_IMMUTABLE;
-		if (mount) {
-			zone->cond =3D BLK_ZONE_COND_OFFLINE;
-			inode->i_mode &=3D ~0777;
-			zone->wp =3D zone->start;
-			zi->i_flags |=3D ZONEFS_ZONE_OFFLINE;
-			return 0;
-		}
+		zonefs_warn(inode->i_sb, "inode %lu: read-only zone\n",
+			    inode->i_ino);
 		zi->i_flags |=3D ZONEFS_ZONE_READONLY;
-		inode->i_mode &=3D ~0222;
-		return i_size_read(inode);
+		if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)
+			return zi->i_max_size;
+		return zi->i_wpoffset;
 	case BLK_ZONE_COND_FULL:
 		/* The write pointer of full zones is invalid. */
 		return zi->i_max_size;
@@ -207,6 +190,30 @@ static loff_t zonefs_check_zone_condition(struct ino=
de *inode,
 	}
 }
=20
+/*
+ * Check a zone condition and adjust its inode access permissions for
+ * offline and readonly zones.
+ */
+static void zonefs_inode_update_mode(struct inode *inode)
+{
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+
+	if (zi->i_flags & ZONEFS_ZONE_OFFLINE) {
+		/* Offline zones cannot be read nor written */
+		inode->i_flags |=3D S_IMMUTABLE;
+		inode->i_mode &=3D ~0777;
+	} else if (zi->i_flags & ZONEFS_ZONE_READONLY) {
+		/* Readonly zones cannot be written */
+		inode->i_flags |=3D S_IMMUTABLE;
+		if (zi->i_flags & ZONEFS_ZONE_INIT_MODE)
+			inode->i_mode &=3D ~0777;
+		else
+			inode->i_mode &=3D ~0222;
+	}
+
+	zi->i_flags &=3D ~ZONEFS_ZONE_INIT_MODE;
+}
+
 struct zonefs_ioerr_data {
 	struct inode	*inode;
 	bool		write;
@@ -228,10 +235,9 @@ static int zonefs_io_error_cb(struct blk_zone *zone,=
 unsigned int idx,
 	 * as there is no inconsistency between the inode size and the amount o=
f
 	 * data writen in the zone (data_size).
 	 */
-	data_size =3D zonefs_check_zone_condition(inode, zone, true, false);
+	data_size =3D zonefs_check_zone_condition(inode, zone);
 	isize =3D i_size_read(inode);
-	if (zone->cond !=3D BLK_ZONE_COND_OFFLINE &&
-	    zone->cond !=3D BLK_ZONE_COND_READONLY &&
+	if (!(zi->i_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)) &&
 	    !err->write && isize =3D=3D data_size)
 		return 0;
=20
@@ -264,24 +270,22 @@ static int zonefs_io_error_cb(struct blk_zone *zone=
, unsigned int idx,
 	 * zone condition to read-only and offline respectively, as if the
 	 * condition was signaled by the hardware.
 	 */
-	if (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE ||
-	    sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZOL) {
+	if ((zi->i_flags & ZONEFS_ZONE_OFFLINE) ||
+	    (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZOL)) {
 		zonefs_warn(sb, "inode %lu: read/write access disabled\n",
 			    inode->i_ino);
-		if (zone->cond !=3D BLK_ZONE_COND_OFFLINE) {
-			zone->cond =3D BLK_ZONE_COND_OFFLINE;
-			data_size =3D zonefs_check_zone_condition(inode, zone,
-								false, false);
-		}
-	} else if (zone->cond =3D=3D BLK_ZONE_COND_READONLY ||
-		   sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZRO) {
+		if (!(zi->i_flags & ZONEFS_ZONE_OFFLINE))
+			zi->i_flags |=3D ZONEFS_ZONE_OFFLINE;
+		zonefs_inode_update_mode(inode);
+		data_size =3D 0;
+	} else if ((zi->i_flags & ZONEFS_ZONE_READONLY) ||
+		   (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_ZRO)) {
 		zonefs_warn(sb, "inode %lu: write access disabled\n",
 			    inode->i_ino);
-		if (zone->cond !=3D BLK_ZONE_COND_READONLY) {
-			zone->cond =3D BLK_ZONE_COND_READONLY;
-			data_size =3D zonefs_check_zone_condition(inode, zone,
-								false, false);
-		}
+		if (!(zi->i_flags & ZONEFS_ZONE_READONLY))
+			zi->i_flags |=3D ZONEFS_ZONE_READONLY;
+		zonefs_inode_update_mode(inode);
+		data_size =3D isize;
 	} else if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_RO &&
 		   data_size > isize) {
 		/* Do not expose garbage data */
@@ -295,8 +299,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	 * close of the zone when the inode file is closed.
 	 */
 	if ((sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) &&
-	    (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE ||
-	     zone->cond =3D=3D BLK_ZONE_COND_READONLY))
+	    (zi->i_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)))
 		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
=20
 	/*
@@ -378,6 +381,7 @@ static struct inode *zonefs_alloc_inode(struct super_=
block *sb)
=20
 	inode_init_once(&zi->i_vnode);
 	mutex_init(&zi->i_truncate_mutex);
+	zi->i_wpoffset =3D 0;
 	zi->i_wr_refcnt =3D 0;
 	zi->i_flags =3D 0;
=20
@@ -594,7 +598,7 @@ static int zonefs_init_file_inode(struct inode *inode=
, struct blk_zone *zone,
=20
 	zi->i_max_size =3D min_t(loff_t, MAX_LFS_FILESIZE,
 			       zone->capacity << SECTOR_SHIFT);
-	zi->i_wpoffset =3D zonefs_check_zone_condition(inode, zone, true, true)=
;
+	zi->i_wpoffset =3D zonefs_check_zone_condition(inode, zone);
=20
 	inode->i_uid =3D sbi->s_uid;
 	inode->i_gid =3D sbi->s_gid;
@@ -605,6 +609,10 @@ static int zonefs_init_file_inode(struct inode *inod=
e, struct blk_zone *zone,
 	inode->i_fop =3D &zonefs_file_operations;
 	inode->i_mapping->a_ops =3D &zonefs_file_aops;
=20
+	/* Update the inode access rights depending on the zone condition */
+	zi->i_flags |=3D ZONEFS_ZONE_INIT_MODE;
+	zonefs_inode_update_mode(inode);
+
 	sb->s_maxbytes =3D max(zi->i_max_size, sb->s_maxbytes);
 	sbi->s_blocks +=3D zi->i_max_size >> sb->s_blocksize_bits;
 	sbi->s_used_blocks +=3D zi->i_wpoffset >> sb->s_blocksize_bits;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 839ebe9afb6c..439096445ee5 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -39,10 +39,11 @@ static inline enum zonefs_ztype zonefs_zone_type(stru=
ct blk_zone *zone)
 	return ZONEFS_ZTYPE_SEQ;
 }
=20
-#define ZONEFS_ZONE_OPEN	(1U << 0)
-#define ZONEFS_ZONE_ACTIVE	(1U << 1)
-#define ZONEFS_ZONE_OFFLINE	(1U << 2)
-#define ZONEFS_ZONE_READONLY	(1U << 3)
+#define ZONEFS_ZONE_INIT_MODE	(1U << 0)
+#define ZONEFS_ZONE_OPEN	(1U << 1)
+#define ZONEFS_ZONE_ACTIVE	(1U << 2)
+#define ZONEFS_ZONE_OFFLINE	(1U << 3)
+#define ZONEFS_ZONE_READONLY	(1U << 4)
=20
 /*
  * In-memory inode data.
--=20
2.39.0

