Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0E2FB068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbhASF0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:26:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57027 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732722AbhASFJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032987; x=1642568987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJI+K9IAfdXiGgzdG/XtuzZQkA1HDrbS/80BpuWpCHY=;
  b=Rm+0dr24/kfcoNFJgVHQw4oFel2Aj0hkwXftevi6XU1HaK6IR+Wljfiv
   O5gvThKabIOzotyNlOnI8kXVQXatvhkEzbJRTbrsZbUlQS+fFpfRhPHuk
   ODvA1xe3vdYIDO04C5nOIxq81KpFcrFA86Y2krX59KGOsFFjcMbzvkG1b
   6SpC9sSUr9H2l56oLz7bRloFR77Uwc94cJ37ZXLrTU/odJoYrIb0wkr3l
   m+Dk1RcBgCiu8orbYSkouoCC1HseLPYYVG+HG8nAG64k0mW8i/q+NXbMy
   xjT7KPzg//bGc/fUQDCWysMwSZHKHgLjYupdKXJRQMEsuyE0/bedKxyfB
   g==;
IronPort-SDR: QT9D2AUqCA7Ie3vaTp4y+REkY77H/PASaExnY1zirA2y1KpqVBYp05NxGqTC2/EH349g9HuzT7
 yOcgad4PSo+uZiJhxg7lRdrMI1U90M4hodKMhz2ystuEJ6vGuCNu7ILfgZzWtns9EYBducS+t+
 7YcKZNY4x6eOme0kyF/VBg9F+HZEnJRe+K3QPS0pc4jiUiAEOCeJl/d2oqN7Zpot7memMTqXgx
 saimzItEjUcxtrgPKxjIZltPMTWseLXOx8gHWU1e+nhfhD3Zp7S6z2zImcz75J2wUVMRvNyDSg
 VzY=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="162201091"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:37 +0800
IronPort-SDR: 0f3iqY9yu6J7dfI1WmfXL1LyertLrubnhr6/CD1FQx5DWyFOC6F4xwXxYvbOaq6FtJsaiDF5cK
 vJeWa1z9a13Z6K4Zng+hLHuN54VGNGfX0oJncwgM2kRqNu4V5C7bDopkZ0DLsk191/C8nb0AaM
 cYojU7+vjtALmP/5Bo3w9XvR3tCjVX+e7/bLqdReyHEU37rLRbkLLE6Gt4Pa5A9MMHPlhZKrOx
 euMBBQaBuBK1ZfnvnnBds1CiMEo9aJepHEUummjoOBAkbTs7U2oW/U2qVoCk/5JkiuClHttoJK
 tkg84wsKPnHqLVFio17teXbi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:15 -0800
IronPort-SDR: JlGfCHshT1mK+XacVyirUo0rFyjPWt2f31VZ3z2J1Z+1bAsxbYaQqDfkpztEmemcjkFKSqFtBW
 eEHx4MKVO6uhGP44oLoJjur9xUH9E+nf+FFdLDlrYS2WxbXcD7sJerBxjAL9tpVS6iMx+k6Ygk
 O6RIIA/q4UYqrDznEz4/cneeqCBOoZihS6qjthtpQtFPN4aYc3uvtGPOTbAR+UEONOX62l4CZO
 swheoC8AcejSmyN7MaD5wpht27eshQMMdBz4TnpekpmQcRnvSAFWabxuH6D+W4HdmuEhyRgLHS
 mSA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:37 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 17/37] pktcdvd: use bio_init_fields
Date:   Mon, 18 Jan 2021 21:06:11 -0800
Message-Id: <20210119050631.57073-18-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/pktcdvd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b8bb8ec7538d..47eb4e0bd4c3 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1028,10 +1028,8 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 
 		bio = pkt->r_bios[f];
 		bio_reset(bio);
-		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
-		bio_set_dev(bio, pd->bdev);
-		bio->bi_end_io = pkt_end_io_read;
-		bio->bi_private = pkt;
+		bio_init_fields(bio, pd->bdev, pkt->sector + f * (CD_FRAMESIZE >> 9), pkt,
+				pkt_end_io_read, 0, 0);
 
 		p = (f * CD_FRAMESIZE) / PAGE_SIZE;
 		offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
@@ -1208,10 +1206,8 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	int f;
 
 	bio_reset(pkt->w_bio);
-	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
-	bio_set_dev(pkt->w_bio, pd->bdev);
-	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
-	pkt->w_bio->bi_private = pkt;
+	bio_init_fields(pkt->w_bio, pd->bdev, pkt->sector, pkt,
+			pkt_end_io_packet_write, 0, 0);
 
 	/* XXX: locking? */
 	for (f = 0; f < pkt->frames; f++) {
-- 
2.22.1

