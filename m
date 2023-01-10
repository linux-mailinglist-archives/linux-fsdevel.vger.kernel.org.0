Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091FA664143
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjAJNI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbjAJNIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:44 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA26147E
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356122; x=1704892122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9mm9qLuG8rNcYArUGfh/LM/aVpk3V1Mr0OAACY97XA=;
  b=HnqsHTpu7GDo5vmgRGZOEDVR8pI7WrS8+x9DMG9hX513oU6FnO5wdDNB
   dY5eBf03Z5wD53S49YBIUbdVmuUOpxk3787yrfJhJdebQOswwPbgKoIi6
   4UnV6e/auqMGcqnVmO75uHNLJ31l3qaMnL3R2b8cLmPkqnlGAsYS92S5m
   m0C9zSvJiu4B7M+3MjScZOwE8srNFMBsG9fQ4fyrhz7U3qHIDf8KbPdWt
   DMWW+JD5N+b4IMtlOOxxrZx18k6KFr89HQxo5oISbR3E72/u3GSL6JXxQ
   vrLuXstQwK8gJAJaIolj5kVgx/a3mG3dM6y+ujZZonjWmpR7FDR6bbJ9P
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740568"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:41 +0800
IronPort-SDR: 7rSA1rBrxYYas7wAsDdON8xY+M1WW1Brswox6xUVlhrrSzR9SE9VTDuVHDWyT0PMSD8h0NBSVI
 nCpFLNxikszrX7GvPZ0lrMwUjA4LYswdAZFcwblbDMVSD/SrtjOzL64NZgpj+fJz8EQpLCknfK
 H2B3YwhOyX2BApEjj6HZNxDbhKGW3RLOLrXSNA5TVhJiF/cESK8515KfSxHLAMgev/YOnVKrDJ
 qf1QKCrD5H05+Ax6VtH2BS1VlQQ5okqsif9PJroZ1gYq/jWAG/GtKHSvIR5DSEeWuBjrnKY9cW
 Efo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:47 -0800
IronPort-SDR: Sq3tdnQbK1AGs18r6uwxgAtABbrnmzQZauDR9G0aKkKvEYZfo4BOR9aCp0auBQ4XIPd7V3r3rh
 wVn1bmPfK6VtCxqAJKcNiU4NHiLQfH1B5pkYZZOvbqFSHAUqQdgSRfEeVW2ZzgkUjnP/38Zsum
 P5ATtFLzeNZpC4SBf3Ekh9snNmCC+Q2/pfnE0PkmzfjEYLQoRaOXEa4K6my0X873wainG92WG4
 K7hpm31ps74g03LcK+YJyF3LWsWhoQOrKQupgoYK9locQRcC8lhRjsrDJWhbYOhO913wJKsd/t
 404=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjP4VCnz1RwtC
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356121; x=1675948122; bh=d9mm9qLuG8rNcYArUG
        fh/LM/aVpk3V1Mr0OAACY97XA=; b=sih4ZF2smckMXHjsaqr9oICr9zolZ/9VVE
        M6pQ8o0QvQV9J7TUSeh0D3hEgg+Y40sAChxl/JxIsXfsq/YnXKVJxg6ByXMZCaYC
        5a5QFIDtZr47bZDMpLyTazYGVKIxcSvAEzeouNPY43/a93Q7eZ1a2cUkUbfI2uXv
        dM0ee1LIydw21tTGmUhzn4CdMY5+NjEYMIzFB9qZMThU+WG3F7qzu3R7dNuad/Vy
        5vVMTtVxIPbnM07MK/QuMOm/fe+1a57xsitq1hD4j8EQSe52H2k53KTo98wkQeH5
        Yl/O6ApQc3l2w7uc08+Ni8wstx/awNpELdSS6IlKqtPBbbUcscMQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 049t049r3or2 for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:41 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjM6389z1RwqL;
        Tue, 10 Jan 2023 05:08:39 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 7/7] zonefs: Cache zone group directory inodes
Date:   Tue, 10 Jan 2023 22:08:30 +0900
Message-Id: <20230110130830.246019-8-damien.lemoal@opensource.wdc.com>
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

Since looking up any zone file inode requires looking up first the inode
for the directory representing the zone group of the file, ensuring that
the zone group inodes are always cached is desired. To do so, take an
extra reference on the zone groups directory inodes on mount, thus
avoiding the eviction of these inodes from the inode cache until the
volume is unmounted.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/zonefs/zonefs.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 7d70c327883e..010b53545e5b 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1199,6 +1199,42 @@ static const struct super_operations zonefs_sops =3D=
 {
 	.show_options	=3D zonefs_show_options,
 };
=20
+static int zonefs_get_zgroup_inodes(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	struct inode *dir_inode;
+	enum zonefs_ztype ztype;
+
+	for (ztype =3D 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
+		if (!sbi->s_zgroup[ztype].g_nr_zones)
+			continue;
+
+		dir_inode =3D zonefs_get_zgroup_inode(sb, ztype);
+		if (IS_ERR(dir_inode))
+			return PTR_ERR(dir_inode);
+
+		sbi->s_zgroup[ztype].g_inode =3D dir_inode;
+	}
+
+	return 0;
+}
+
+static void zonefs_release_zgroup_inodes(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	enum zonefs_ztype ztype;
+
+	if (!sbi)
+		return;
+
+	for (ztype =3D 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
+		if (sbi->s_zgroup[ztype].g_inode) {
+			iput(sbi->s_zgroup[ztype].g_inode);
+			sbi->s_zgroup[ztype].g_inode =3D NULL;
+		}
+	}
+}
+
 /*
  * Check that the device is zoned. If it is, get the list of zones and c=
reate
  * sub-directories and files according to the device zone configuration =
and
@@ -1297,6 +1333,14 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)
 	if (!sb->s_root)
 		goto cleanup;
=20
+	/*
+	 * Take a reference on the zone groups directory inodes
+	 * to keep them in the inode cache.
+	 */
+	ret =3D zonefs_get_zgroup_inodes(sb);
+	if (ret)
+		goto cleanup;
+
 	ret =3D zonefs_sysfs_register(sb);
 	if (ret)
 		goto cleanup;
@@ -1304,6 +1348,7 @@ static int zonefs_fill_super(struct super_block *sb=
, void *data, int silent)
 	return 0;
=20
 cleanup:
+	zonefs_release_zgroup_inodes(sb);
 	zonefs_free_zgroups(sb);
=20
 	return ret;
@@ -1319,6 +1364,9 @@ static void zonefs_kill_super(struct super_block *s=
b)
 {
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
=20
+	/* Release the reference on the zone group directory inodes */
+	zonefs_release_zgroup_inodes(sb);
+
 	kill_block_super(sb);
=20
 	zonefs_sysfs_unregister(sb);
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index f88466a4158b..8175652241b5 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -76,6 +76,7 @@ struct zonefs_zone {
  * as files, one file per zone.
  */
 struct zonefs_zone_group {
+	struct inode		*g_inode;
 	unsigned int		g_nr_zones;
 	struct zonefs_zone	*g_zones;
 };
--=20
2.39.0

