Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6C5426B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiFHGp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiFHGEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:04:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10D244091
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654664353; x=1686200353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CevkZZnhv6j2Mk73kiuiXO8Tmh2N1oB2gvlfpnKcSXs=;
  b=cufsK0OCBVBaHPrhqkbcmcecPPPTIAjoyl8o/ySgTzzwSMEn+JCTaKmh
   N2TVxFPva0AG8d7FRASoiGC/i9GoeOXWeWaoyw5iVibsxxXnRqS4XIEkK
   iZaezqlxumO2DpkyCXHwfV5ECmVRt4nrj4B+wzx+N0h0ywum6+b2ewnXl
   OAFbQDuO07MKqn7SweWAKXhqaXDHKLDqy3MZsexhz4/lsGkUZL3BeKziV
   z/K5lStIxjmvu3DxUue/yoosgT2kc8L1JqaBsI5e5NvvdbZzKbxsj4+3U
   CgJsLGBv7y6+9AkEZ8a+XLwxLdA4xs+rwSETLV55MADCKr7KVy61o17Yo
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="201289626"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 12:56:33 +0800
IronPort-SDR: 68t6Yfuskz8xCr7SsUzWtaD65CfftbtwsKEbLTl7Q24HXFdQNUp/YccWHYXYEt/aNP3XR4xoau
 CfbzCLKn0OEaHxyXt8VlNNKXlXIQWJkybT1RY58K040TUKGpl/sf3zEPNLKHFx7ECJJX6ADt0N
 9HDnVS8fNwv5UQbDyYprBVwxEKu1llI1kvMshfJ0lLKjKFbhxcNEqpcex1CFfO0xp8f3kY8sh8
 xRCLKm7SjA7GrhwcuhYLK26hrtIfepWSOdlzZ3iBfJ0U6VNZJU8YV7A9N9gwD0kXbz+jeg7TY5
 yuqGJr1DoffLK/Rf18Ab4N5C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:15:22 -0700
IronPort-SDR: 4VRWl695KZdHYi3VsQggBnPVVIneZU8A0yxUqX/vxU2FYKCtc7AwAjevA5Z9FOj0SdCFChYI1v
 m8L9mxgI5hSGEGdduiqc+F5agwzf3RBs8yyGcmkZoDd9oZZ9YPY6ZepuqO/92/FdBYcbqL0qqk
 KFXu1QobZdCV6mrU1Zivtcfrif3sgFzboMTwm3iROh4olSwKo7bo+3rlfRV0RpxY+w2MbWp98i
 0+NeII/Pwzzv0hEuPfc3GfDGwIkmrsNjDcSu8nEWAQ/OFusd+wNsxLfOnUxyjJP/JDtjsNh9LE
 h/o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 21:56:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHw1D2ytlz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:56:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1654664192; x=1657256193; bh=CevkZZnhv6j2Mk73ki
        uiXO8Tmh2N1oB2gvlfpnKcSXs=; b=fPYCwaG+BWMsBpnZgkdP1CbR8GsW/MDAi+
        4tYdNSpIVMNyjyP/1+VZsofflPOwnLl3SDplJoLLcAp8FYbuWl1vp2/fUxu9V2mz
        0ySDNygvHnUOx/k4SQebt4RPki39zmy6U595AA+EDcq2uFsCFyamPEVzkvWSQqdI
        NV8/0Nawoo6Z2dqiPxwMA7prejpDfnm43dViXhfx2k9LkIOFGWlqFzaVHARkOj9J
        UcV39qUKKSjQfPPGOxh/15dFi5cPmv+99sIJWtYiVvwoWGdzMLa5JOLXCMzT4QKk
        lFZvUyzKWFhhzpi/SBvzI86IbS4mtA0wBhCcVXGG/+SASn0pXjbA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3LsKR1Ne2NSe for <linux-fsdevel@vger.kernel.org>;
        Tue,  7 Jun 2022 21:56:32 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHw1C3WXpz1Rvlc;
        Tue,  7 Jun 2022 21:56:31 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/3] zonefs: Do not ignore explicit_open with active zone limit
Date:   Wed,  8 Jun 2022 13:56:26 +0900
Message-Id: <20220608045627.142408-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
References: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

