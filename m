Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4BC504A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiDRBPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiDRBOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:14:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C212AE1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650244336; x=1681780336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7+GNKL4IIw1kWeAS+kv2DNxAPjNGUaWyz9nL+3PgsaQ=;
  b=YOdrfq8/M+PbfmR5a+XBxQlx9qzcGIKJENJDXKEvkaBQc/sny95CyFhH
   RyUjLcpU9n2OtRCQ5+C+p9ZGsnvhEwSJRVc5Nd4jOgsmcplyJbh9sVRg2
   J9OCqVaMZPkudeoWv5crcpGiGNUh57o4eJnOMUBI8OkimHKlHp3FRfks5
   SdbrNYSdRMaTpm+yWGnZAfUy7p78Uhlebkxcv5RssqiE9/DJJu+cs+Q++
   qwPVpHNnmnJ8y5EAcl9rTI1CKfRHKr70TrcIl+T/9xGp58l2hKmqdcwXM
   9fBOivSdD55PgfcAyQZL574BcJkCcBXuHoWr1jkaimASrXxswoO4aaWYH
   A==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302313773"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 09:12:15 +0800
IronPort-SDR: xxos/I0H682U1UWCXr9oL9eL1TNibZ8YKbrs8Zn8+Q0J5AAuobTZ5r0N5+Iy+1i4ZY2U2pybig
 N2YjfNZRkI7gyMTAKbllO4hksLEwWA6O1yEbFuZ0YZ7YUfbmRpDfdVV5u2ThIixFjLJRXkls+C
 +5bRwzH9e/4JvkjLjck++ZExbhP4zTOj2pVrj4nRnbLUmY3eVA6gSoIjH+QRI2jD/f+yFdCiNM
 otg9a+X43AEE++A/KbCcJeZZqsyTE5TQttYalJO1e7LVDauISgUBs+uJnlLwaLZcdqK67liFOD
 xcMQ5tKH86k1YMPDoLoR881a
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 17:42:36 -0700
IronPort-SDR: rKiNX1A45/4i7enpPrQlKafd33zkRHwq0n70zb0B0qQ1FYQkf8wdefH26Zm3ZcSmL7g3fFpYp+
 cqqUZoNYZRGO+Ce57knklMveL4spCClV6J9/uZU440dhSEprESwCYJGlEOwE+knHu0D6Madx2S
 0gl2nJlQdM7dMrkoe/UaPs7m7XkI2DEt3+lpDDua8ADkb5tIPrLOHB/sTpB8aU8sMoSMmZbiro
 NJ1ErOyQixuu14HYWD9HYg9qKuN2ONfWumG3re/lSiYtU4OhD1WEk6TSVVOiVOpzwWVFmH47L/
 EpQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 18:12:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhTRy5bCFz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650244334; x=1652836335; bh=7+GNKL4IIw1kWeAS+k
        v2DNxAPjNGUaWyz9nL+3PgsaQ=; b=aa+ESpK0Tr2eVktCOZmTvFVXaf79aQ4cg5
        WeLj9BndHOARvKDZqFxxNYhjKCO+kZ0yLOVfPBSbFfcBSa+DpPcPHNvEfzsNH+9K
        Q3yb7c+JwTJtbT2fiZkBFVJmol8lcai9y1AqBAhwjY82TZ3epx0OLXI2x3pDwL1a
        zfE61Q3lYR9jObHEMNDnjzQbhSl/iFTyLj2Q868nNecYO7Np9YHF1dRp+Lq/Broc
        hZns+CvwnxNkJwqggGulxbrKCiJt0Q6BFt4EDndxg1Jloq7bL3V1Sfj/Hsk+0SuF
        cnhn8mpwzg9cmiRM2qkyCzSz0dJJKTqhsV23w9m7yhdE64HVFtqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2FgKU-A4ws5D for <linux-fsdevel@vger.kernel.org>;
        Sun, 17 Apr 2022 18:12:14 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhTRx6SR1z1Rvlx;
        Sun, 17 Apr 2022 18:12:13 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 6/8] zonefs: Add active seq file accounting
Date:   Mon, 18 Apr 2022 10:12:05 +0900
Message-Id: <20220418011207.2385416-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modify struct zonefs_sb_info to add the s_active_seq_files atomic to
count the number of seq files representing a zone that is partially
written or explicitly open, that is, to count sequential files with
a zone that is in an active state on the device.

The helper function zonefs_account_active() is introduced to update
this counter whenever a file is written or truncated. This helper is
also used in the zonefs_seq_file_write_open() and
zonefs_seq_file_write_close() functions when the explicit_open mount
option is used.

The s_active_seq_files counter is exported through sysfs using the
read-only attribute nr_active_seq_files. The device maximum number of
active zones is also exported through sysfs with the read-only attribute
max_active_seq_files.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c  | 62 +++++++++++++++++++++++++++++++++++++++++++---
 fs/zonefs/sysfs.c  | 14 +++++++++++
 fs/zonefs/zonefs.h |  4 +++
 3 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index aa359f27102e..3934a68520fe 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -27,6 +27,37 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
=20
+/*
+ * Manage the active zone count. Called with zi->i_truncate_mutex held.
+ */
+static void zonefs_account_active(struct inode *inode)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
+	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+
+	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)
+		return;
+
+	/*
+	 * If the zone is active, that is, if it is explicitly open or
+	 * partially written, check if it was already accounted as active.
+	 */
+	if ((zi->i_flags & ZONEFS_ZONE_OPEN) ||
+	    (zi->i_wpoffset > 0 && zi->i_wpoffset < zi->i_max_size)) {
+		if (!(zi->i_flags & ZONEFS_ZONE_ACTIVE)) {
+			zi->i_flags |=3D ZONEFS_ZONE_ACTIVE;
+			atomic_inc(&sbi->s_active_seq_files);
+		}
+		return;
+	}
+
+	/* The zone is not active. If it was, update the active count */
+	if (zi->i_flags & ZONEFS_ZONE_ACTIVE) {
+		zi->i_flags &=3D ~ZONEFS_ZONE_ACTIVE;
+		atomic_dec(&sbi->s_active_seq_files);
+	}
+}
+
 static inline int zonefs_zone_mgmt(struct inode *inode,
 				   enum req_opf op)
 {
@@ -68,8 +99,13 @@ static inline void zonefs_i_size_write(struct inode *i=
node, loff_t isize)
 	 * A full zone is no longer open/active and does not need
 	 * explicit closing.
 	 */
-	if (isize >=3D zi->i_max_size)
-		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+	if (isize >=3D zi->i_max_size) {
+		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);
+
+		if (zi->i_flags & ZONEFS_ZONE_ACTIVE)
+			atomic_dec(&sbi->s_active_seq_files);
+		zi->i_flags &=3D ~(ZONEFS_ZONE_OPEN | ZONEFS_ZONE_ACTIVE);
+	}
 }
=20
 static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t=
 length,
@@ -397,6 +433,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	zonefs_update_stats(inode, data_size);
 	zonefs_i_size_write(inode, data_size);
 	zi->i_wpoffset =3D data_size;
+	zonefs_account_active(inode);
=20
 	return 0;
 }
@@ -508,6 +545,7 @@ static int zonefs_file_truncate(struct inode *inode, =
loff_t isize)
 	zonefs_update_stats(inode, isize);
 	truncate_setsize(inode, isize);
 	zi->i_wpoffset =3D isize;
+	zonefs_account_active(inode);
=20
 unlock:
 	mutex_unlock(&zi->i_truncate_mutex);
@@ -866,8 +904,15 @@ static ssize_t zonefs_file_dio_write(struct kiocb *i=
ocb, struct iov_iter *from)
 	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
 		if (ret > 0)
 			count =3D ret;
+
+		/*
+		 * Update the zone write pointer offset assuming the write
+		 * operation succeeded. If it did not, the error recovery path
+		 * will correct it. Also do active seq file accounting.
+		 */
 		mutex_lock(&zi->i_truncate_mutex);
 		zi->i_wpoffset +=3D count;
+		zonefs_account_active(inode);
 		mutex_unlock(&zi->i_truncate_mutex);
 	}
=20
@@ -1052,6 +1097,7 @@ static int zonefs_seq_file_write_open(struct inode =
*inode)
 					goto unlock;
 				}
 				zi->i_flags |=3D ZONEFS_ZONE_OPEN;
+				zonefs_account_active(inode);
 			}
 		}
 	}
@@ -1119,6 +1165,7 @@ static void zonefs_seq_file_write_close(struct inod=
e *inode)
 		}
=20
 		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+		zonefs_account_active(inode);
 	}
=20
 	atomic_dec(&sbi->s_wro_seq_files);
@@ -1325,7 +1372,7 @@ static int zonefs_init_file_inode(struct inode *ino=
de, struct blk_zone *zone,
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	int ret =3D 0;
+	int ret;
=20
 	inode->i_ino =3D zone->start >> sbi->s_zone_sectors_shift;
 	inode->i_mode =3D S_IFREG | sbi->s_perm;
@@ -1363,9 +1410,13 @@ static int zonefs_init_file_inode(struct inode *in=
ode, struct blk_zone *zone,
 		mutex_lock(&zi->i_truncate_mutex);
 		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
 		mutex_unlock(&zi->i_truncate_mutex);
+		if (ret)
+			return ret;
 	}
=20
-	return ret;
+	zonefs_account_active(inode);
+
+	return 0;
 }
=20
 static struct dentry *zonefs_create_inode(struct dentry *parent,
@@ -1711,6 +1762,9 @@ static int zonefs_fill_super(struct super_block *sb=
, void *data, int silent)
 		sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
 	}
=20
+	atomic_set(&sbi->s_active_seq_files, 0);
+	sbi->s_max_active_seq_files =3D bdev_max_active_zones(sb->s_bdev);
+
 	ret =3D zonefs_read_super(sb);
 	if (ret)
 		return ret;
diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index eaeaf983ed87..9cb6755ce39a 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -51,9 +51,23 @@ static ssize_t nr_wro_seq_files_show(struct zonefs_sb_=
info *sbi, char *buf)
 }
 ZONEFS_SYSFS_ATTR_RO(nr_wro_seq_files);
=20
+static ssize_t max_active_seq_files_show(struct zonefs_sb_info *sbi, cha=
r *buf)
+{
+	return sysfs_emit(buf, "%u\n", sbi->s_max_active_seq_files);
+}
+ZONEFS_SYSFS_ATTR_RO(max_active_seq_files);
+
+static ssize_t nr_active_seq_files_show(struct zonefs_sb_info *sbi, char=
 *buf)
+{
+	return sysfs_emit(buf, "%d\n", atomic_read(&sbi->s_active_seq_files));
+}
+ZONEFS_SYSFS_ATTR_RO(nr_active_seq_files);
+
 static struct attribute *zonefs_sysfs_attrs[] =3D {
 	ATTR_LIST(max_wro_seq_files),
 	ATTR_LIST(nr_wro_seq_files),
+	ATTR_LIST(max_active_seq_files),
+	ATTR_LIST(nr_active_seq_files),
 	NULL,
 };
 ATTRIBUTE_GROUPS(zonefs_sysfs);
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 77d2d153c59d..4b3de66c3233 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -40,6 +40,7 @@ static inline enum zonefs_ztype zonefs_zone_type(struct=
 blk_zone *zone)
 }
=20
 #define ZONEFS_ZONE_OPEN	(1 << 0)
+#define ZONEFS_ZONE_ACTIVE	(1 << 1)
=20
 /*
  * In-memory inode data.
@@ -186,6 +187,9 @@ struct zonefs_sb_info {
 	unsigned int		s_max_wro_seq_files;
 	atomic_t		s_wro_seq_files;
=20
+	unsigned int		s_max_active_seq_files;
+	atomic_t		s_active_seq_files;
+
 	bool			s_sysfs_registered;
 	struct kobject		s_kobj;
 	struct completion	s_kobj_unregister;
--=20
2.35.1

