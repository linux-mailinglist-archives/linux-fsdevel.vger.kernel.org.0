Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81ED2FB054
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbhASFYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:24:18 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47326 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032948; x=1642568948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GM24flI6Tk6w3xkQ30UJmV4QFWXT/JYAetQgeL9KGII=;
  b=VB3+3LaHpoeSfUb/VWWsUl46G51uDMgiLjnJrzGW0UC9LCoSss+PZs8B
   6X7tfM4BFkL7xgyCOeEriKs3aPgTp5JYsD9P3PctrWkTlEalNZhBn9sxL
   kl7h1HDrrvgKJw6by2KfGrOnzVqPBjk9x0FUgh9i1eVSlSeoJqArFCIaD
   YeDkGIGgIxxvlL4Vw3QTPVzeFhG0pl+bOyYzW4GI2Gx+wxz83cPraPcHS
   h6K3F1KUpTGK2WA8Jwsfskj2x5gT8+Sn+dTDBxPvxGe9RnlhpQuwCxn8n
   zx8oszU4X0trgU2s4mc7RG5bHrnQwkSDBskJS7RdLm2uCz0sutNaqocvW
   A==;
IronPort-SDR: xc42VD/MkSEUznWoBIe4Qn7wDkR5Anv2juolQZgTe/+zBdTLV7r92vcfuOIOQ/TExcLFREzCz4
 c/CDv6F+PyYQAuMEo1FVNoX18yFqUO5NGI7MNEyTusiDpUddrbyBlhXGaS36s8RdaEsEqxG3cl
 Kd9Xz5SvNLZ9aG8Vxth2mfnsB2AOTFBLX6F6kqmOA7XB+h0z5uHoa5ekYsQ2Djp5zfZUw2g3BM
 NHDBXaAGVQSZYivKC679KWWUp7ksqz+d1nDPMswowDdZJrPTGkC8qvQQkb1CfP+jbWZ04YomHZ
 /gM=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="158940510"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:07:48 +0800
IronPort-SDR: gY6Y2u4YAd7IJOXfNi26qS7SoA4FR4kno7jfjsXv0FpatEXyGqe/dKHmqnD2f874QguNhph5CS
 YAsJW0UhXzlGPhDDK3JNks+/S7DaJt7b+8k86RAaT6dOopfKXZaLoweou3t74JZzngxjeuqTvf
 ZGLmEaz6ztSICksFzVxlZeIewMZ1s3GaBv/R6Qeps1bQvpA9ZnhSX81rUv+l+wototDebEjLuB
 UyejvN7P0xNUcfkhk1M0RckJ+TBEucmtuOW2DXyqUcGAKFwOuonudzQzNEDIfhICzI2ykObNcQ
 m92WMEHFDecr4nfdYz1Xi/Ma
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:24 -0800
IronPort-SDR: z0ZW9dyPTLw53eARwPq8+5nuJJ+yGnb1S3afLxWS5cRMuD3GO8FzJcyb/494viUnLZ93FPHi6a
 3MdikG0yU2ucYS4a+pszMPxdsf3jMw5J2ahGcJgTTzK3LHcPj0MYZR0Q1pR6fYTjIlk5jXhiBg
 wsBVE9/ViYCXjpOk05UySgjB2d/pwdD0R6sXtZQT/+GSCaDzW5cIOqfqIiFsiuqf2/hNL4trLe
 wWdFviDzfdU8EZetm7X+/kphay2DvflOFtCnqYvJIkQCp+kSJnhyMAhfqOGFMVkkVdPhO/0qgy
 FxQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:47 -0800
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
Subject: [RFC PATCH 10/37] iomap: use bio_init_fields in direct-io
Date:   Mon, 18 Jan 2021 21:06:04 -0800
Message-Id: <20210119050631.57073-11-chaitanya.kulkarni@wdc.com>
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
 fs/iomap/direct-io.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..3756dbf51909 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -190,10 +190,8 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, iomap->bdev);
-	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-	bio->bi_private = dio;
-	bio->bi_end_io = iomap_dio_bio_end_io;
+	bio_init_fields(bio, iomap->bdev, iomap_sector(iomap, pos), dio,
+			iomap_dio_bio_end_io, 0, 0);
 
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
@@ -272,12 +270,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
-		bio_set_dev(bio, iomap->bdev);
-		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-		bio->bi_write_hint = dio->iocb->ki_hint;
-		bio->bi_ioprio = dio->iocb->ki_ioprio;
-		bio->bi_private = dio;
-		bio->bi_end_io = iomap_dio_bio_end_io;
+		bio_init_fields(bio, iomap->bdev, iomap_sector(iomap, pos), dio,
+				iomap_dio_bio_end_io, dio->iocb->ki_ioprio,
+				dio->iocb->ki_hint);
 
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
-- 
2.22.1

