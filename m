Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C253B507EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358965AbiDTCii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358936AbiDTCig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947F237D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422152; x=1681958152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IYGt78WnzXnHgnH3i7vdDJgh6A3hbxq+hUYizsdTVag=;
  b=g5RZEvgITNkoi3WiBXP2RN7bFHq6tRxX6I4sqa1cXY9pziBBEEDSj+Zw
   wJVB2ruYDDlyw3D8q5hu+8QraB06J6AcBi8kXoyowKdcXvo1CS9uZnvCq
   4UikSMJjmXIK2rJOWjCdCQDqcHw09SBfWsccWgRpvJqaMZY7wZAJmVLPh
   6gTtNvAwne3cqcakRDj2OuNbfrugidy9fgFrAUxPswZ651wq0OsDVdd24
   EvzKsCS/atcTOA+f2DPGIR+Ur1EOpb+Yz0FO6xzJ7SPUH4oCjrkfPPEaJ
   HeQLYiJKDdWWQtPE3DotJCAZOVH0c73btNBUGmxidlRO/Wr5Kmip2KiCw
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="197177974"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:51 +0800
IronPort-SDR: s9vHLufAYe6Vm2YoNX9PVGNWRiqOshcZPQjMi/vUuQ2jWoQTSDaHufkRQ32+g5UpfuRH4MNVw4
 Q5XNu2aiIS/P+EhscXu6hrBwUv5DePr2Mn0aW+buYMmvKp8SPQFkWttMdxCFw1MINAPITzdV9L
 mLefVz8PAZm2vzB0w8stEVSQOMcEFulkuHNeznc534SJyFomw51d9a2fiGMYlqXXjzPmT/vzo9
 1T6nOjE7z7Pnh8KzyijhuX8VgcIAx21z+WmjT9igncAhk8W+cCupgSYH6CisDsl3uFkAWZ8q/t
 foVrMbdtyEgQch42vDqrzv+V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:09 -0700
IronPort-SDR: Qc8UGprznw6hHp9qafnCN7eh5o9PRbNe7T2FRqJUIwoWlrBxhnkoGrjWNliITBED0u+ICxy6Hi
 1zKwXXNKVy7zNuW34f71RluMDsDeeBdgx7QfLmIgOpdi1A9rMEaURfM4ekBIHnNKAsUchAx/oi
 16QSa94qUmrCFkGPjAbYtSce+7OUiJ8fIoTCytq7yypVGx43LZVKrLgwhFQ96VtLNnu50SwFif
 gXG3SnSb37XSKCkf0UwjthRQNiFCw7vS4G5xyn/fX4qyLMQWf+2hoJwXbZjc4Fm0q4sDAqy6SN
 y8E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCT5gkmz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422149; x=1653014150; bh=IYGt78WnzXnHgnH3i7
        vdDJgh6A3hbxq+hUYizsdTVag=; b=FpTvt67b302VgNKzvaccjobTJE6Vlo/p4x
        tQEKNoL+VNlbsD0+sgitVQ24Kb5aufIEbMHkCh5ndIBD7axtwyc5ISSbVT/gkvVF
        8z1zI+TIaeIfJrHUPDkL4wZh1jbEBsSCXaOwiJmhD+MG5ganP2xKzVDa/SUKIBN9
        JYEnnObfGVhsnGwfsupavMn9VNlU+R052PaITLGK01uwezcvmcU2L4ZumD3RMLjb
        +6aj7GxOlsIwjTvgA/vGxZtEU6S7RdD+RathDr+vKx294KFB76xkwGeOUT1ZaC5V
        p7wqj0vQryPlQYqze0iUvkMWFI3TRW6T2DvbM8kA04jnEFKKEICg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4non2qbPnkwi for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:49 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCS6zYlz1Rvlx;
        Tue, 19 Apr 2022 19:35:48 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/8] zonefs: Rename super block information fields
Date:   Wed, 20 Apr 2022 11:35:40 +0900
Message-Id: <20220420023545.3814998-4-damien.lemoal@opensource.wdc.com>
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

The s_open_zones field of struct zonefs_sb_info is used to count the
number of files that are open for writing and may not necessarilly
correspond to the number of open zones on the device. For instance, an
application may open for writing a sequential zone file, fully write it
and keep the file open. In such case, the zone of the file is not open
anymore (it is in the full state).

Avoid confusion about this counter meaning by renaming it to
s_wro_seq_files. To keep things consistent, the field s_max_open_zones
is renamed to s_max_wro_seq_files.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c  | 17 ++++++++++-------
 fs/zonefs/zonefs.h |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e20e7c841489..dafacde65659 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1035,8 +1035,10 @@ static int zonefs_open_zone(struct inode *inode)
 	mutex_lock(&zi->i_truncate_mutex);
=20
 	if (!zi->i_wr_refcnt) {
-		if (atomic_inc_return(&sbi->s_open_zones) > sbi->s_max_open_zones) {
-			atomic_dec(&sbi->s_open_zones);
+		unsigned int wro =3D atomic_inc_return(&sbi->s_wro_seq_files);
+
+		if (wro > sbi->s_max_wro_seq_files) {
+			atomic_dec(&sbi->s_wro_seq_files);
 			ret =3D -EBUSY;
 			goto unlock;
 		}
@@ -1044,7 +1046,7 @@ static int zonefs_open_zone(struct inode *inode)
 		if (i_size_read(inode) < zi->i_max_size) {
 			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);
 			if (ret) {
-				atomic_dec(&sbi->s_open_zones);
+				atomic_dec(&sbi->s_wro_seq_files);
 				goto unlock;
 			}
 			zi->i_flags |=3D ZONEFS_ZONE_OPEN;
@@ -1108,7 +1110,7 @@ static void zonefs_close_zone(struct inode *inode)
 		}
 		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;
 dec:
-		atomic_dec(&sbi->s_open_zones);
+		atomic_dec(&sbi->s_wro_seq_files);
 	}
 	mutex_unlock(&zi->i_truncate_mutex);
 }
@@ -1688,9 +1690,10 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)
 	sbi->s_gid =3D GLOBAL_ROOT_GID;
 	sbi->s_perm =3D 0640;
 	sbi->s_mount_opts =3D ZONEFS_MNTOPT_ERRORS_RO;
-	sbi->s_max_open_zones =3D bdev_max_open_zones(sb->s_bdev);
-	atomic_set(&sbi->s_open_zones, 0);
-	if (!sbi->s_max_open_zones &&
+
+	atomic_set(&sbi->s_wro_seq_files, 0);
+	sbi->s_max_wro_seq_files =3D bdev_max_open_zones(sb->s_bdev);
+	if (!sbi->s_max_wro_seq_files &&
 	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
 		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount opt=
ion\n");
 		sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 7b147907c328..67fd00ab173f 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -182,8 +182,8 @@ struct zonefs_sb_info {
 	loff_t			s_blocks;
 	loff_t			s_used_blocks;
=20
-	unsigned int		s_max_open_zones;
-	atomic_t		s_open_zones;
+	unsigned int		s_max_wro_seq_files;
+	atomic_t		s_wro_seq_files;
 };
=20
 static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
--=20
2.35.1

