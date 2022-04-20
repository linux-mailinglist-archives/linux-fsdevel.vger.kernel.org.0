Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36458507EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358969AbiDTCis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358936AbiDTCij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA08237D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422154; x=1681958154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3x/xLe7TMZthng2iUARN9Tvlx0+e4ji1sYAR+eZO670=;
  b=LvXRp67j4E3UyB6OdENmySqPrx31gsZ+L/q7S9oEYchMZgjjg9uxgxxd
   9C1YMLvvRLh6GugB1uAoIMolnitFfEd9569wM6NWV8/FVp51GHH30lW4c
   blRVqbGUUGquz+fPo4ur5hoJCFKsfYngf7kyu7Xb4vf6M5VYfuv6jxpEK
   IheF/gp+xZFKEj2euqJO+iNFId5Vr4XcowpxvxnXey2znNDiLyGX/Wz8J
   gBSDy3cuAe06OFT2CPJ3s9OgXYUTBIG5xvkOgnUZXoIloANn2uE1RA6Ya
   mnvOxa/1lWXpSnOJQcIyt9CoAHjhZFHmDIFEAaBqmnCcrVTYqKYulUQ3Z
   w==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="197177975"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:52 +0800
IronPort-SDR: wEE1z9h6Jxp8M+RMuq6KnTYNWL915hf20opLPjPUUUcRXHP28iSFMKZxNXDHHlQauUl7Bi5rTi
 ikWZn0njRI8ZrZqy9jQVfNfeJDDaaj7qBFrMSmIj58hCus5hjyHn7Rkw3rHI7Mfvq4iZ609wH+
 0bzYYZFlBmyq39SASjIoyPbwlGCq0SSAOOEdfb6HkErLMk19veQQ8Sw5aV8SytTTGcZGZxs2rb
 9hGQ5me4TfO68kRZ930pxqeghsGlhnrlNqxKjau0xvy8opdXgqS0Rf6vaNNEd/E0fUduag/HfQ
 lK70z4SxWg4GyjmINycXst9u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:11 -0700
IronPort-SDR: lRDR35BDzyx332SKbiO2I/0ryuatrD/uEVYLsE+75/RzixGUNYUnA3rGYrtj/G35ojgPmMl/Cb
 ZBRbKScohEbKJs4IN3REUAmMG3vKcbev5bpPb282L9HLGEJDjEE/DAh+J9DhVYQ5HyWv8E6oS5
 0Re3KePtHNRD/AqSDLFyZRE9OiwWqISDp4cJTFLXVY9tDqnJjqgoKzdwtVIBt+D9o7RRF0hfcu
 3pkYcuBc/DMxBO7LwIZu0zTRRmjYhPyfbeIsanLxWG8O6y9hqj7Y2mT5wFjvBr7tIODXfUDWLt
 ytI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCX15sRz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422151; x=1653014152; bh=3x/xLe7TMZthng2iUA
        RN9Tvlx0+e4ji1sYAR+eZO670=; b=otjOgLmMtYOJeS7/lNjA4ZtF6A87NOBpZ6
        RkeqLqdj2KNTyRW6wkC+vNkempMzoPsw+rDBy/+W859oQHy3dooi/4T8Vhe31t1r
        2xbDnasS3t9NopgH+cF07xgm2R5um0cGF2KdByo78cmBGAtnFYIAsIVL27Vdolxy
        ryjPSLhhut8XAnP4XrRsriBrJo/ZyadwWm3/kakC0K4xGwh8mzNugwnczC73zVph
        f8EaMf9TWN9VS+KRkrnNuxzFBlh0hWFo4znMqrZ/PSCciIU23N4yT3kOCXm47aKG
        tRmHuCg+YudUufmZB8+Cc45/ivdDGS5q2m2bKxg3KHLoqlnDIqRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NpQAC8HW7lKj for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:51 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCW1m8Mz1Rwrw;
        Tue, 19 Apr 2022 19:35:51 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 6/8] zonefs: Add active seq file accounting
Date:   Wed, 20 Apr 2022 11:35:43 +0900
Message-Id: <20220420023545.3814998-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
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
 fs/zonefs/super.c  | 71 ++++++++++++++++++++++++++++++++++++++++++----
 fs/zonefs/sysfs.c  | 14 +++++++++
 fs/zonefs/zonefs.h |  4 +++
 3 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index aa359f27102e..e65da43f1453 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -27,6 +27,39 @@
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
+	lockdep_assert_held(&zi->i_truncate_mutex);
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
@@ -68,8 +101,13 @@ static inline void zonefs_i_size_write(struct inode *=
inode, loff_t isize)
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
@@ -397,6 +435,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,
 	zonefs_update_stats(inode, data_size);
 	zonefs_i_size_write(inode, data_size);
 	zi->i_wpoffset =3D data_size;
+	zonefs_account_active(inode);
=20
 	return 0;
 }
@@ -508,6 +547,7 @@ static int zonefs_file_truncate(struct inode *inode, =
loff_t isize)
 	zonefs_update_stats(inode, isize);
 	truncate_setsize(inode, isize);
 	zi->i_wpoffset =3D isize;
+	zonefs_account_active(inode);
=20
 unlock:
 	mutex_unlock(&zi->i_truncate_mutex);
@@ -866,8 +906,15 @@ static ssize_t zonefs_file_dio_write(struct kiocb *i=
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
@@ -1052,6 +1099,7 @@ static int zonefs_seq_file_write_open(struct inode =
*inode)
 					goto unlock;
 				}
 				zi->i_flags |=3D ZONEFS_ZONE_OPEN;
+				zonefs_account_active(inode);
 			}
 		}
 	}
@@ -1119,6 +1167,7 @@ static void zonefs_seq_file_write_close(struct inod=
e *inode)
 		}
=20
 		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
+		zonefs_account_active(inode);
 	}
=20
 	atomic_dec(&sbi->s_wro_seq_files);
@@ -1325,7 +1374,7 @@ static int zonefs_init_file_inode(struct inode *ino=
de, struct blk_zone *zone,
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
-	int ret =3D 0;
+	int ret;
=20
 	inode->i_ino =3D zone->start >> sbi->s_zone_sectors_shift;
 	inode->i_mode =3D S_IFREG | sbi->s_perm;
@@ -1351,6 +1400,8 @@ static int zonefs_init_file_inode(struct inode *ino=
de, struct blk_zone *zone,
 	sbi->s_blocks +=3D zi->i_max_size >> sb->s_blocksize_bits;
 	sbi->s_used_blocks +=3D zi->i_wpoffset >> sb->s_blocksize_bits;
=20
+	mutex_lock(&zi->i_truncate_mutex);
+
 	/*
 	 * For sequential zones, make sure that any open zone is closed first
 	 * to ensure that the initial number of open zones is 0, in sync with
@@ -1360,12 +1411,17 @@ static int zonefs_init_file_inode(struct inode *i=
node, struct blk_zone *zone,
 	if (type =3D=3D ZONEFS_ZTYPE_SEQ &&
 	    (zone->cond =3D=3D BLK_ZONE_COND_IMP_OPEN ||
 	     zone->cond =3D=3D BLK_ZONE_COND_EXP_OPEN)) {
-		mutex_lock(&zi->i_truncate_mutex);
 		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
-		mutex_unlock(&zi->i_truncate_mutex);
+		if (ret)
+			goto unlock;
 	}
=20
-	return ret;
+	zonefs_account_active(inode);
+
+unlock:
+	mutex_unlock(&zi->i_truncate_mutex);
+
+	return 0;
 }
=20
 static struct dentry *zonefs_create_inode(struct dentry *parent,
@@ -1711,6 +1767,9 @@ static int zonefs_fill_super(struct super_block *sb=
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

