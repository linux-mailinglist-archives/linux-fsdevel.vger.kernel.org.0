Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A447A612F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 04:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJaDNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJaDNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:13:09 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC899589
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 20:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667185988; x=1698721988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P35oXbYwdRybJuHtRHFnGImLVJ2SHHeelzlhzjrVCys=;
  b=BpC5JmM9SdMzlj4DV10blKJ6uz36+mLql4+Ik2ZYRKpcQWFV0cYuiM/+
   tZ1rg616IN8OTAFrqNiQH/5oBTyuKpGc/SMaDoGqsZ1cwOvdHGV9LfCiw
   V2WjosRtoBKAd1E1GBKtTUHzLzgiKxlu5mYFRlkzkpDWLyBVx15M8SUpL
   d7Udy9mmavL/OnbOqklILDS9gYLPwXttKf+fPzjT3xXkyHTd8EWUk/Egz
   RGNINaceELpnBcrp4tTLE0LvrCPgBlFCx0HdRXcalrO8NGfVOhTdivMKx
   LolgghuOC0SChzG67rn+eqa0UpwXLRNuhU1ICFeQ56FCgRncQtjiLhjXb
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="220250884"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 11:13:06 +0800
IronPort-SDR: M2a/deFKLQ3CAAOOlryv9MSPt5pr6YzA6tLakvmg2m1Wf26oBK4Ij7KXoDvc93UTR0FDw114Ga
 6SdAEFCVvSSR+dNdUPIALv2KxWpbDmi+/7XDlXs77M8VqCC1vF1lXuI+BJ1qiXv+UzhVtnSfl6
 XpQlUiCnQoEqL3FR7TCaSQeg6dOzUgHHJh6GvJ4C4UpgLKbqUDqz6ePC6QBC8e0212rroleC3B
 nn8wSHHNMCQODt+GLBtzsxXIZxnq4mM030TgFYM99zXjmJxamnuA2me2R9plEvoo9rHUhKk/nJ
 9A2Tb+7TTA3XQgsxywF9dyEp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:32:23 -0700
IronPort-SDR: 9vhGAnvxqfyAsianhpSjWGJSNtenw/6wDvt5oR5GV2hFePB1jEEHKUd1VbNUhI8CdP+lVTL94d
 v25xacSalWGZ1z3gy879tADmB4qkExvKCdlpKucrL4FslH4+M6x+f7W7CPacLoj8aJ5k22hJaT
 ZmQpqvoqxFmAehPc6hL43s1JfPCF8st7GzP8YoH9bCI39CSSuAaAOdRwRSOUfnYKKnH99vjQ+r
 DmruKrtQU0l1iQNfp2+EYz3CSKkAzXGYQq9jtYneyST+q870h2Xw3f7n5k8VwEOmfx4MVYI8e0
 Nas=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 20:13:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0yZ245kVz1Rwrq
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 20:00:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667185210; x=1669777211; bh=P35oXbYwdRybJuHtRH
        FnGImLVJ2SHHeelzlhzjrVCys=; b=XRTWEdMJu3eOTV5M2N/KWBbxCuvC5E28/B
        3vc1q9fsBTa+VoZNenInm2DzRtPsm2tzsyeTjGKTg6/igSDMHbChibRfL7fB4uvH
        po+AUWav1snotPJqQ/jfDNVSNbKV0jXO1vjMi+U4ssoyM6LfidTongH31oj+VA5e
        grOJbB+EgjmirN5SbzPJniilyHDk+Emzg6YC2p/+GCVoxkRRh1UyVsleBihQGBfJ
        Jrpp7DskCTkunqkj1YaYNZZ3RCXYqTIlClqAUo5ifG/Xv7uEnD2J3jou14D9hfC0
        UI4jl0fiGV2j9WLkBIkmrDFA+2VUBfM2cDN1FIxvHf1m+i0phXrg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7dlLvPDID_yr for <linux-fsdevel@vger.kernel.org>;
        Sun, 30 Oct 2022 20:00:10 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0yZ15bylz1RvTp;
        Sun, 30 Oct 2022 20:00:09 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] zonefs: fix zone report size in __zonefs_io_error()
Date:   Mon, 31 Oct 2022 12:00:06 +0900
Message-Id: <20221031030007.468313-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
References: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
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

When an IO error occurs, the function __zonefs_io_error() is used to
issue a zone report to obtain the latest zone information from the
device. This function gets a zone report for all zones used as storage
for a file, which is always 1 zone except for files representing
aggregated conventional zones.

The number of zones of a zone report for a file is calculated in
__zonefs_io_error() by doing a bit-shift of the inode i_zone_size field,
which is equal to or larger than the device zone size. However, this
calculation does not take into account that the last zone of a zoned
device may be smaller than the zone size reported by bdev_zone_sectors()
(which is used to set the bit shift size). As a result, if an error
occurs for an IO targetting such last smaller zone, the zone report will
ask for 0 zones, leading to an invalid zone report.

Fix this by using the fact that all files require a 1 zone report,
except if the inode i_zone_size field indicates a zone size larger than
the device zone size. This exception case corresponds to aggregated
conventional zone files.

Fixes: e3c3155bc95a ("zonefs: add zone-capacity support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..f689bd3596cf 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -478,14 +478,22 @@ static void __zonefs_io_error(struct inode *inode, =
bool write)
 	struct super_block *sb =3D inode->i_sb;
 	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
 	unsigned int noio_flag;
-	unsigned int nr_zones =3D
-		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+	unsigned int nr_zones =3D 1;
 	struct zonefs_ioerr_data err =3D {
 		.inode =3D inode,
 		.write =3D write,
 	};
 	int ret;
=20
+	/*
+	 * The only files that have more than one zone are conventional zone
+	 * files with aggregated conventional zones, for which the inode zone
+	 * size is always larger than the device zone size.
+	 */
+	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
+		nr_zones =3D zi->i_zone_size >>
+			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
 	 * reclaim which may in turn cause a recursion into zonefs as well as
--=20
2.38.1

