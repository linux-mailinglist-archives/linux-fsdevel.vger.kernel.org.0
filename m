Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE60566413E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 14:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjAJNIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbjAJNIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:36 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7062B574D8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356115; x=1704892115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RYUAzG87APGa/vdsWUavzvnYwE2WHcvSfbZzACOXQv4=;
  b=AoHgmeFGPnUkIXuJkksn8gRW3C/uRWVM29h2Sp+p9KEObPUoSrAAy07q
   /jj4X1IF1XHWG24+xfRcAgcnIJiYk1ySpSVmlccmiaJ5KVe+0u8g0/t0T
   SRqGZdXyLDsb+S3ZbnuRrvEdZcHCk48HuWOH6pwEdZAiQm183XgtVhJ58
   qNxI6N/RGo0/JpQJX67LypVtZJAB24yYMt7MsupZ1ox39EMhD4IQuuo2D
   sJFxZWzAwpeUB46Z70arQ93IW69a7/tQzH/s1swpOWE409FaASkex0/Va
   hHNVbV/DNLk/D/mI50KOqO1g/yoJoBfIoFQoNFqmewUmBh4IY/ZfyOnbc
   w==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740558"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:08:34 +0800
IronPort-SDR: PS85gWTEx183WpljWdoy3VYJaP3/Q7t0YKKqbnNFr7rSv3UrFZV8P6T2rS/bxJKhchWCewPEig
 c1ELbXvVj/YKLVfbUSUniCb3vxWQSa0YakOzy1x5lXa1sZOy9IJdtRquL4d4zzq8RrWsdIqKuP
 Nn+1M2Q3tyZMzFVTCusr5GbeXGasLuoR/iPIQQDISixb1TbuayB0bXeXRWB+VSRXoaPjULviKB
 p/CDVeLB/UfYPdPa12QJZbZDsUnTOv9f+w9Cs9tvk9WNS33ryNiHnzZDDRcrlWPvv7n4cpF3bY
 VMo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:20:39 -0800
IronPort-SDR: EjFXQgNQBZHr/5GP2jC6Mfb1B8n8QFYD1J2/7xVyca5/Bh53gBMimNGHy9xupT7XNEVi4zeN6+
 yCUSFDsqUJOGIhcqyW6eV0XBSZPW557qlvy608mrxlBJKcfljIMvYuRjYLsNSw9Ez2GF61IS3L
 bXqBiePLssazqAxBinpY/wAvlm1ersDgc0GqyulgGlLI5wkDIcS4t6KPAtpuwaBOMozKBBbtQv
 hlU56ekthkrZfbcV1Qes4RlKizhMs6Nh83qKHBFtpY41fkctGYmIMOULUwiAt9J1zZZM5AqPFw
 zLw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:08:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrrjF6vZrz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 05:08:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356113; x=1675948114; bh=RYUAzG87APGa/vdsWU
        avzvnYwE2WHcvSfbZzACOXQv4=; b=NIAFSWrNhv9jhnYD8AXW4fDBQlCUSYtzyi
        VcWQVcv9SQ0EMd7/HcpqM3O0jedBECno30C8CHTJkbbGrMFBmDE3QXljRNVq3L+P
        V/Lsb3MFTXdKmtB9yLYDIOHnmswLYFK/Dzhz+Y3PCKNjGdSBzY30PXSuZGRdg15x
        buHCci67qZBJvsmL9Fv6Psn+yRKjV/9PFOm51gB/OCOD7NHEDKgiXsiwY10WI2b1
        sMTzy2cbtiYABulJFeu79klmBLJnSk9dWBVoZxO2YD/2bbVzsgGO22kDkrPZjTXl
        pO+mrDfLRBZP5gxrn/DZUZL5fCokPRqs09XJqj8Uk1efn4HKx6Ig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id byPxtvcH7UL5 for <linux-fsdevel@vger.kernel.org>;
        Tue, 10 Jan 2023 05:08:33 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrrjF0WH3z1RvTp;
        Tue, 10 Jan 2023 05:08:32 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jorgen Hansen <Jorgen.Hansen@wdc.com>
Subject: [PATCH 1/7] zonefs: Detect append writes at invalid locations
Date:   Tue, 10 Jan 2023 22:08:24 +0900
Message-Id: <20230110130830.246019-2-damien.lemoal@opensource.wdc.com>
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

Using REQ_OP_ZONE_APPEND operations for synchronous writes to sequential
files succeeds regardless of the zone write pointer position, as long as
the target zone is not full. This means that if an external (buggy)
application writes to the zone of a sequential file underneath the file
system, subsequent file write() operation will succeed but the file size
will not be correct and the file will contain invalid data written by
another application.

Modify zonefs_file_dio_append() to check the written sector of an append
write (returned in bio->bi_iter.bi_sector) and return -EIO if there is a
mismatch with the file zone wp offset field. This change triggers a call
to zonefs_io_error() and a zone check. Modify zonefs_io_error_cb() to
not expose the unexpected data after the current inode size when the
errors=3Dremount-ro mode is used. Other error modes are correctly handled
already.

Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 2c53fbb8d918..a9c5c3f720ad 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -442,6 +442,10 @@ static int zonefs_io_error_cb(struct blk_zone *zone,=
 unsigned int idx,
 			data_size =3D zonefs_check_zone_condition(inode, zone,
 								false, false);
 		}
+	} else if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_RO &&
+		   data_size > isize) {
+		/* Do not expose garbage data */
+		data_size =3D isize;
 	}
=20
 	/*
@@ -805,6 +809,24 @@ static ssize_t zonefs_file_dio_append(struct kiocb *=
iocb, struct iov_iter *from)
=20
 	ret =3D submit_bio_wait(bio);
=20
+	/*
+	 * If the file zone was written underneath the file system, the zone
+	 * write pointer may not be where we expect it to be, but the zone
+	 * append write can still succeed. So check manually that we wrote wher=
e
+	 * we intended to, that is, at zi->i_wpoffset.
+	 */
+	if (!ret) {
+		sector_t wpsector =3D
+			zi->i_zsector + (zi->i_wpoffset >> SECTOR_SHIFT);
+
+		if (bio->bi_iter.bi_sector !=3D wpsector) {
+			zonefs_warn(inode->i_sb,
+				"Corrupted write pointer %llu for zone at %llu\n",
+				wpsector, zi->i_zsector);
+			ret =3D -EIO;
+		}
+	}
+
 	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
 	trace_zonefs_file_dio_append(inode, size, ret);
=20
--=20
2.39.0

