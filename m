Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27C5504A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiDRBOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiDRBOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:14:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277F13E3C
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650244333; x=1681780333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oOSi7P4nsBSx+gZTKuOcLlG+tlxO5KOYfgplYW3yXbY=;
  b=KlzqS043rWG4tHWJW+3pJuLMnCU0xBl3borUvVaWWc0RvCdcBRzOGpy6
   MHDdQ6JGQcRqmFwspdBmANl8YXVmdZO3san8AdhKcnit3IT++v6GOZ4wT
   +tnT4mX9Nv6e/y4jU+K8ZnP01b4J5uCXilhgLyFAXAhD3QmBsxqFH3zbJ
   oW+XS+kQzdaZFZaKzLG4NJ9JFtU3nEAnB43OuJwD06oZN6U9kj9m5yKDQ
   Tmw/0BiOWxzFJequdW9HC9WG/gHXK9nlkN58ngv24YOxJHK6f39CwjIaY
   g7sSy2OOZYay6d2HTYGF4G0VHxWFieddEeVNKL4R68yuKA6Hcb1q4QnDV
   w==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302313768"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 09:12:12 +0800
IronPort-SDR: aghzEzkQPmerhRZQxPhZ3H+5GKzusdn50wjOLkaa6oX3ROzIU2XjB6LdTrzuTwKB84FSZvyWDO
 NZwcLhBSak1V3pqHVGhp2qEg6azbdwm0eV/mA1EXHp0gAPDVeeP7P16E4zhZcHEEyvKCDxYeBx
 JKwvGdqNspPmbnoRFPBax5Rx4MxRe+0ifMzM32skhaOGbjDhv4TNGGeZpL5zPZd0xMnOMc539H
 t3wgNGHsZfg8VzsyuGirlmMnJsYrr4EoMU484UcK7iHPtlm6TMR9IPPCZppvfXl4Of7RpEY2d3
 2Wcn2VpN/JUG5Xy0j7RwJfdd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 17:42:34 -0700
IronPort-SDR: xKzrYbp7C+rcLSZ5C2e22uA59ihA3ceYZSHe//6+TA5gmFbI02JW5FygREV8SEUM66iS/OnitE
 BIqhtVxB9uucrDi9+bCOPvN9Zw4HglYRaR36HFLTuSTGTbeH6qq22H3Am3BaVN1LDPj/c9ypzE
 OHhJwsaR644QmlwJZXDxEgL3QGs87qUSNYROw93G26vwon7mTL7oju6FgxwKYG4O5wh5bJuzmQ
 PCSDm118UK5xaTCohPo46yKwVwTWEtv8CjHa6KTM681L5iLWNWxSfLM6MCCt/88TMQvYD8Rwzr
 i/8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 18:12:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhTRw41VHz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650244332; x=1652836333; bh=oOSi7P4nsBSx+gZTKu
        OcLlG+tlxO5KOYfgplYW3yXbY=; b=jtlnqY313sjyJk7xdc2D31d6qrh+wKvRYI
        81S4v52bbrvo/rNcfWfbb9lfO1BsVixaebxOiFMzehq5mt08AM/Y+CrNCUwMHkUg
        XD3Ja7QgANra3hGC3cW613q+CFLuwU1BfcTiDlOEUUZz24b/z7qwz2NlcP47H8tV
        oU09Vr3TZDYkfN24YoqhY+ozYwQ5nqJtRiNyAi+JmAz3d6wmvZn9OTiO6u0HvZkB
        +sidST6zFCCpt3ed5gLjEQAHRDEWf3ROVUOg8nxB5WmXnuxs/ogRQOusrUIihm6q
        xVYXdMsqHVUTUY3sc7VtQnzwjbvzjAPsN2AiQiYWSztvnkkqXo6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GdhzP-szQwpG for <linux-fsdevel@vger.kernel.org>;
        Sun, 17 Apr 2022 18:12:12 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhTRv5VJDz1Rwrw;
        Sun, 17 Apr 2022 18:12:11 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/8] zonefs: Rename super block information fields
Date:   Mon, 18 Apr 2022 10:12:02 +0900
Message-Id: <20220418011207.2385416-4-damien.lemoal@opensource.wdc.com>
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

