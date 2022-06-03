Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4253C992
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 13:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbiFCLtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbiFCLtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:49:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8810D3A180
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654256985; x=1685792985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyBIUX5Cm4HFnTZ0/TlfjgJ6wGX7FqPYnLr8LjzqbXU=;
  b=PBWMAH8+nb/HkP6caar17Q5SzDPxkWcdCqdTC+yDsLtqO5g+YCX112XG
   h9sWdNW0Hv/fEDls/7ZtyInAv1kgUjFkNoNbJv8KzAXZFFfNnBFqlfuJ0
   KDThzYL5gY6kXtfXThDbYrF/RuNb74Qc6YqYQBl2Ev/q8Q2OytqGmMoAh
   LHz79iWFmAbY79QQEIFjjmQWBYqg0sy1Qu7RmhRubE/cfHgJ/x3nMXXP8
   kwVBJn0kPGY69jV7fv1cm4j1EyLbglq3q9lixRn0ZxGOBKRNbvyCk1T0V
   cIYxMOzewe8HR9zj2P0Dmx0ijl2KvBBn6i6lo2BrQPjaGk/LEHhAHUpnl
   g==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647273600"; 
   d="scan'208";a="306454536"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 19:49:43 +0800
IronPort-SDR: phep4PCByohs5FS8njkLJWGQHB3uXhM3WHlhqFIV30Ka1gk323Un2G5qUVPK34LXzPhXw3MY1Q
 nvNx2yTeUDHS9F3252e2jsl1aVSjZBOjwjQsfOTpwgFNPqVPLCUAADwlVZ5HHKcXhAIZk/fBXW
 7pji4bmSmU0palRnjNGmz5TThm/0aj0jH/e6SOomsDyBse6awY5ptZnzUz91W6Z9UHuQvXrTPD
 eMablJqBs6jVA2abFlL2SAkVUt3DELVjRyAC00hUuGQPMgZ80eX3RG1ufb/6xsFduURYY+yAvG
 86lHTd03t35MBJ2TskggX07z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:08:47 -0700
IronPort-SDR: JQixmg7x9v6twch888kRLzgDTuxewXvZ/Bq5ePpzWlLMsDybpVEt4XxymyIaBWOC3bk5a61Gop
 rldpKA/WondYZO/Hs2yiZXXdspcAnoqgk7iZsePnQBwgscXJfD6uo43CctzO+LjB+3KXIIQcHa
 bozSrTgXPqpWiOJXib8gHbLYM+/QK15JH+oip5gu83nbHtkJKO+KCl5VXG3x4y3OWj4YgxTDmi
 N38TKOFbvVXIFchbCHg3nmuMZ4LkqbXzpDzkCVe//oAOqqcy5YqTE6/9Q6LENuSJliMW5ejzvu
 85w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 04:49:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LF1QH28yfz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 04:49:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1654256983; x=1656848984; bh=hyBIUX5Cm4HFnTZ0/T
        lfjgJ6wGX7FqPYnLr8LjzqbXU=; b=mWT41u/zNxKkovN15yNqVS+GEsPMw2mmHJ
        UCb6pQcWwVG9zA17v//nXrFlbYyXqdWf1q9K/+joIgAxOxxp5UGbX2rQPAJnF6UW
        7tMsBFtY4O55AGjxb0T8nczhsdzOFr9RWWRUnZBq5101EgoIDiA9oIx/mP+r8ull
        9KcdQ12PJcwSuXzYbt54USMtYNMBlaLXt2eJWilJqvuuCSZztzC5hUHQsFzz6olA
        gdMKVcH6ao26zwec/L0sjx73nCCv3uI536TigXgJpS1VnRbXf5bshNRIwMeGZ2bA
        3dKEza7+mCeqwSL9OH2U9u1YurjrwfGEYIFxM1whPNhLlYyzdF5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A3C_pb8y4vw6 for <linux-fsdevel@vger.kernel.org>;
        Fri,  3 Jun 2022 04:49:43 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LF1QG3x8gz1Rvlc;
        Fri,  3 Jun 2022 04:49:42 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] zonefs: Do not ignore explicit_open with active zone limit
Date:   Fri,  3 Jun 2022 20:49:38 +0900
Message-Id: <20220603114939.236783-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
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

A zoned device may have no limit on the number of open zones but may
have a limit on the number of active zones it can support. In such
case, the explicit_open mount option should not be ignored to ensure
that the open() system call activates the zone with an explicit zone
open command, thus guaranteeing that the zone can be written.

Enforce this by ignoring the explicit_open mount option only for
devices that have both the open and active zone limits equal to 0.

Fixes: 87c9ce3ffec9 ("zonefs: Add active seq file accounting")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ecce84909ca1..123464d2145a 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1085,7 +1085,8 @@ static int zonefs_seq_file_write_open(struct inode =
*inode)
=20
 		if (sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
=20
-			if (wro > sbi->s_max_wro_seq_files) {
+			if (sbi->s_max_wro_seq_files
+			    && wro > sbi->s_max_wro_seq_files) {
 				atomic_dec(&sbi->s_wro_seq_files);
 				ret =3D -EBUSY;
 				goto unlock;
@@ -1785,8 +1786,10 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)
 		    blkdev_nr_zones(sb->s_bdev->bd_disk));
=20
 	if (!sbi->s_max_wro_seq_files &&
+	    !sbi->s_max_active_seq_files &&
 	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
-		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount opt=
ion\n");
+		zonefs_info(sb,
+			"No open and active zone limits. Ignoring explicit_open mount option\=
n");
 		sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
 	}
=20
--=20
2.36.1

