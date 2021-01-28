Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532F3306F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhA1HXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:23:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16439 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhA1HSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818314; x=1643354314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxHF3VRS1HdpvW1dkgXeP6+bfyoqSsbsdMU7tIvbgNk=;
  b=OKiQWOaHlo4CcwOp9RhQhpkKeQodGO0SDW4aSGYtfRZ5kujvkw1XwCnV
   p80Ke+c5vNvKo86eTE9M2rIid29RV/r0H/7hbXEsfWQz+c22vMdS2dLkp
   061CzJJODGEGbUduKCJTrxM3obRUIIc2VWi7o21bXAgspKedaL3H1vUFT
   VS0cHTCWMxQFboTOHTaqYE/pmucm3D/DyanJoakQ7Qyzes+hFrwn+mkmR
   AT3Tz03MnpVUHNJpsu0XLjsK43lTrBz7I1HlILdEuwsB8x5o99zsFxC9J
   8hsDOnIOLLHSlJwvjLta4rK0sPOv/GAiin5IQn5nJwt2AaUSPH1z7FhBX
   w==;
IronPort-SDR: kU/TcTjD0qOIe9DpiQYG58Bm+/Ccv1VR9q9MbSLYCJcDxsYXg58FfJ4IRt58B4NxkNVfDbdytj
 s21PwC89VDuF5hS+RafTlPP8t3P0suk3Y5VwLjnZXD+i+5d9jSZDXND+GRBjxULUZ3c85u6o04
 JqO3W0GPKxx+cl7kMZenjscbcuCeL/fcTQqLhS7uti1TzTZ48JB1sz48+vAlXlB4eotNg1OuoF
 n6rJC4yVRodam4I2q5bXC8ms8McaKidH/DFT28Z7lpl6i4Vf5OCt1ulYcSIc4zJNyictnHYxw4
 D5Y=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518505"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:16:19 +0800
IronPort-SDR: 4Eotcj4z9YpFY9deAZB5+4sr0HDyIwAZNjbeLXmEavSawhZPY/y6XnAa8vDeqSOTKGFjR38nm6
 3qkvQpcXaKYGeQThmlMM0WHSAHl77pQizT1kVoCqb70Me9Z+PjHnRkTw/0XOuFVuLrnVZx2mHZ
 I/fqIiSyUOSA3sl3fcn+ZmUjtnc6HbUqJ6Bgh0GOh3dJhh+7SU0mDbkLAS0Nksz1espajrZkfz
 /e40rOubOfy7vP7Jn+0uBVZWIPhiWNomkanA5v3cGRit8hCf5wRPgu+1g+RYURtCx6/hXBTrKZ
 qSEx0hPktBUkYL+5FCCieJmx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:58:37 -0800
IronPort-SDR: e2VgktU8Igp+G/4kwCau3Wofn5lcroMY0YPC7tNcu39YNL7JBNMa1+cKXT86WcuzihvSj94J7W
 8sv8AfyOojzHeLFV1vgVT8Pm71/iwcQAmabu9Ufd/jwBkzWKoKpTzhJn2DWIwNp2e8mqIx3G5A
 LS7tN5JWZnYOGTkwZ/LMhdAEhsm6g9R10Edu6WiLHx+xz1R0nO/OSJcMH5j4uo+XVYn8ORNhbv
 mynrcW4WJ2Z8dThUFTylCCg25lF4TIegFSZNE+eSh2Iz0rquG/Dk4lImC2ZggxF5isWDJ8MWSG
 Bw0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:16:19 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, djwong@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: [RFC PATCH 34/34] mm: add swap_bio_new common bio helper
Date:   Wed, 27 Jan 2021 23:11:33 -0800
Message-Id: <20210128071133.60335-35-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 mm/page_io.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 7579485ccb5e..cc30c9a0b0a7 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -287,6 +287,17 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 #define bio_associate_blkg_from_page(bio, page)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
+static inline struct bio *swap_bio_new(struct block_device *dev,
+		unsigned op, unsigned opf, gfp_t gfp, struct page *p,
+		bio_end_io_t *end_io)
+{
+	struct bio *bio = bio_new(dev, swap_page_sector(p), op, opf, 1, gfp);
+
+	bio->bi_end_io = end_io;
+	bio_add_page(bio, p, thp_size(p), 0);
+	return bio;
+}
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
@@ -342,11 +353,9 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	bio = bio_new(sis->bdev, swap_page_sector(page), REQ_OP_WRITE,
-			REQ_SWAP | wbc_to_write_flags(wbc), 1, GFP_NOIO);
-	bio->bi_end_io = end_write_func;
-	bio_add_page(bio, page, thp_size(page), 0);
-
+	bio = swap_bio_new(sis->bdev, REQ_OP_WRITE,
+			REQ_SWAP | wbc_to_write_flags(wbc), GFP_KERNEL,
+			page, end_write_func);
 	bio_associate_blkg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
@@ -406,11 +415,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	ret = 0;
-	bio = bio_new(sis->bdev, swap_page_sector(page), REQ_OP_READ, 0, 1,
-			GFP_KERNEL);
-	bio->bi_end_io = end_swap_bio_read;
-	bio_add_page(bio, page, thp_size(page), 0);
-
+	bio = swap_bio_new(sis->bdev, REQ_OP_READ, 0, GFP_KERNEL, page,
+			end_swap_bio_read);
 	disk = bio->bi_bdev->bd_disk;
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
-- 
2.22.1

