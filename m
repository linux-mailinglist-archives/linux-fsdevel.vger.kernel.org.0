Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A192507EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358957AbiDTCii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiDTCig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D8237C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422152; x=1681958152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQ2qxpZJtPoEBoqTcwviu2hCUoOP+4WOSbBCuQ2mZY4=;
  b=Ysq0WSuncJerVS0XSlAfvkr9IHuVF+zO8hAuZr9WkSaQmAwdV4Xl2VoW
   fz7tv1BAeMjxlaJxlt1wexzMOh1HzskzX5u2JeDYHsh/g7oOwJpgO+zTU
   jLoGouRYrJMiPgnn+xH6otuSCg2+Hk86vNFVknAZ2AQDX1A4l4ToHpdKY
   Q/VkHSoAnna7ky/nxAgNemB363bhaYLqO7431V4zfkq+PcM1FsRf2mT82
   g34TkeRJ9bB6H5s8HFVW6NCCviUNDPa3ZJXcW6nzNs+A3KckizqhDouv6
   KTtbgo20ImREjqaSAlPGHi/WDsinnVVeN/1RQrQBaqh5e71HljPcYZmev
   A==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="197177973"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:49 +0800
IronPort-SDR: EzDN6AH81+q/SYK7v3EhlLdfZOjwNcNWyA2hf4qB6aAkx5MM6eQcv3Z/pIppHb7JWENDd6SLZi
 y/KZmnYVyrr0HXXKGOzKDt0Ao/9TXAI88tIDeyWZ/gWe+EEr2ff9jQHxkpqlWhfbh8Geg7VgMM
 eDUOL3D2nlVcSJtwUrFywjG9DbaWxQQ56ftIj0CEqJvIekHmsZchr0F38O7RZmcdciqWObciz2
 w/DeaCleVotO11xjA/eEl4k57is6wON+TyvQG4dB4+HtJBP5/GLwaXgicp6zglbx2QS6E8aZOd
 omFsZB4keuOTP/ztQSs9dcap
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:08 -0700
IronPort-SDR: YUH6z34Kxvz7qcLKaroja8tUOm+dJOgIq1Kn6el8HGR/L4OYoNnPwWKuiDInOEzb8ztpMRfVs6
 nQsAQnUPUexsrjIa67LMV5BcqXMrPPU3M/ANvsVbX9BouhVA+YALiKeb0mR/cpZBvs7sJ7tmYa
 ebkB/0pRqDFGn31h55LEmY7FyWHcYFCdRjhyfJtJCc0vJAE6HO5o8caJPTRnwVmr3EH0WvEEst
 A8kZfqzjhWkPwAicTSYwXg23nzy2EKbDVjpBhBjOkgTLqWEvz1s9JZOmq10tS5fDp8Si2A4NpN
 g8w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCT0r5Dz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422148; x=1653014149; bh=NQ2qxpZJtPoEBoqTcw
        viu2hCUoOP+4WOSbBCuQ2mZY4=; b=qMY/MpcyJyo0CpF6dLGhmu7OyuuEYf27oZ
        RdY4fvmeDyoARc96u1d3tUbE/hQPn2IpWyenF0BA2C3gn8cW67W5LXA2Gs+FMIvo
        MuQlFeMWCdniHc6vxC5X5PgmDAyQrBlmjrqbRszulXYMLKlTwAXCVAZMDG95syF/
        jNLlI2H80yc9fXKGofqxJwI0ks4id9pHyBPdrbWWWVTsMp4W8D0TptkQ8AhtBqqw
        x6QrGh4mO5iM/hi9GOWLdCmcBSW/K0+5zEyN6oRTjKMetGgrpklNx6HiC5Jw9Sox
        osZPsuYkKWXKlH2l4g5PHfPWu7/mBsjJsb38IKYxHGdWHy5FYsAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V27JCardHI1T for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:48 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCS1wCsz1SVnx;
        Tue, 19 Apr 2022 19:35:48 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/8] zonefs: Fix management of open zones
Date:   Wed, 20 Apr 2022 11:35:39 +0900
Message-Id: <20220420023545.3814998-3-damien.lemoal@opensource.wdc.com>
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

The mount option "explicit_open" manages the device open zone
resources to ensure that if an application opens a sequential file for
writing, the file zone can always be written by explicitly opening
the zone and accounting for that state with the s_open_zones counter.

However, if some zones are already open when mounting, the device open
zone resource usage status will be larger than the initial s_open_zones
value of 0. Ensure that this inconsistency does not happen by closing
any sequential zone that is open when mounting.

Furthermore, with ZNS drives, closing an explicitly open zone that has
not been written will change the zone state to "closed", that is, the
zone will remain in an active state. Since this can then cause failures
of explicit open operations on other zones if the drive active zone
resources are exceeded, we need to make sure that the zone is not
active anymore by resetting it instead of closing it. To address this,
zonefs_zone_mgmt() is modified to change a REQ_OP_ZONE_CLOSE request
into a REQ_OP_ZONE_RESET for sequential zones that have not been
written.

Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 75d8dabe0807..e20e7c841489 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -35,6 +35,17 @@ static inline int zonefs_zone_mgmt(struct inode *inode=
,
=20
 	lockdep_assert_held(&zi->i_truncate_mutex);
=20
+	/*
+	 * With ZNS drives, closing an explicitly open zone that has not been
+	 * written will change the zone state to "closed", that is, the zone
+	 * will remain active. Since this can then cause failure of explicit
+	 * open operation on other zones if the drive active zone resources
+	 * are exceeded, make sure that the zone does not remain active by
+	 * resetting it.
+	 */
+	if (op =3D=3D REQ_OP_ZONE_CLOSE && !zi->i_wpoffset)
+		op =3D REQ_OP_ZONE_RESET;
+
 	trace_zonefs_zone_mgmt(inode, op);
 	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,
 			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);
@@ -1294,12 +1305,13 @@ static void zonefs_init_dir_inode(struct inode *p=
arent, struct inode *inode,
 	inc_nlink(parent);
 }
=20
-static void zonefs_init_file_inode(struct inode *inode, struct blk_zone =
*zone,
-				   enum zonefs_ztype type)
+static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *=
zone,
+				  enum zonefs_ztype type)
 {
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
+	int ret =3D 0;
=20
 	inode->i_ino =3D zone->start >> sbi->s_zone_sectors_shift;
 	inode->i_mode =3D S_IFREG | sbi->s_perm;
@@ -1324,6 +1336,22 @@ static void zonefs_init_file_inode(struct inode *i=
node, struct blk_zone *zone,
 	sb->s_maxbytes =3D max(zi->i_max_size, sb->s_maxbytes);
 	sbi->s_blocks +=3D zi->i_max_size >> sb->s_blocksize_bits;
 	sbi->s_used_blocks +=3D zi->i_wpoffset >> sb->s_blocksize_bits;
+
+	/*
+	 * For sequential zones, make sure that any open zone is closed first
+	 * to ensure that the initial number of open zones is 0, in sync with
+	 * the open zone accounting done when the mount option
+	 * ZONEFS_MNTOPT_EXPLICIT_OPEN is used.
+	 */
+	if (type =3D=3D ZONEFS_ZTYPE_SEQ &&
+	    (zone->cond =3D=3D BLK_ZONE_COND_IMP_OPEN ||
+	     zone->cond =3D=3D BLK_ZONE_COND_EXP_OPEN)) {
+		mutex_lock(&zi->i_truncate_mutex);
+		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);
+		mutex_unlock(&zi->i_truncate_mutex);
+	}
+
+	return ret;
 }
=20
 static struct dentry *zonefs_create_inode(struct dentry *parent,
@@ -1333,6 +1361,7 @@ static struct dentry *zonefs_create_inode(struct de=
ntry *parent,
 	struct inode *dir =3D d_inode(parent);
 	struct dentry *dentry;
 	struct inode *inode;
+	int ret;
=20
 	dentry =3D d_alloc_name(parent, name);
 	if (!dentry)
@@ -1343,10 +1372,16 @@ static struct dentry *zonefs_create_inode(struct =
dentry *parent,
 		goto dput;
=20
 	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D dir->i_ctime;
-	if (zone)
-		zonefs_init_file_inode(inode, zone, type);
-	else
+	if (zone) {
+		ret =3D zonefs_init_file_inode(inode, zone, type);
+		if (ret) {
+			iput(inode);
+			goto dput;
+		}
+	} else {
 		zonefs_init_dir_inode(dir, inode, type);
+	}
+
 	d_add(dentry, inode);
 	dir->i_size++;
=20
--=20
2.35.1

