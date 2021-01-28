Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EEC306EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhA1HSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:18:06 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16439 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhA1HPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818153; x=1643354153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pvsXY5ThsGIWZu3d1vhsE8XvMocy29CAsL/BvlC2XE=;
  b=k0xDEqyVDLLTpxvdjwuVtjpRBmKRsGkKxRyWtWMPXIApr4GHtoFNLzr8
   dG6BESBC/3bhlI/mh9kMlhR5jqcO3JvVkp/nLR8mrDWa/dh7xvo+dS+oZ
   9EkodtaK08adZnh+V4RM5H6RKUVJO719XVf59N4d7MEWk/qxmAf5NwaGi
   tkt7CRXUu3cc4esg0F4dUp6gFlPpXJ6k/oWVijnPFj2rNnrSmppdheXWb
   6bZVC1LISRNyVVVabqsRWcub6pWlc7rTsoq+2vbq6+QUYwOv6vBNMy+OO
   0vRST6SKJ+sCljgywapPwv1789neiFpK80BxS0F9zS4JqVBGnEnQyc1nO
   w==;
IronPort-SDR: YEoIii2ZthT6i7JpK2sMDIzzLD7y9BL2JpCJtQZbh6rT1O4EH4IZb8eA2B3uVQXaGxGzkNsCqd
 yxyKDdaB7Fpy8udq5g3ElqfqFl5Trm9H6lhrZoOLgv5nPUbMjtgJLnFQLe5pwc34fgRs/GMmvn
 X+hTp4EKVkdPfyNFhYmdN4E6p6067VtKlF2Qt2zelEv96nVPqSR/XSio14INQoBe1pfvYAH+06
 lQOHVOQm5ubDRyfZw8yXjMKkJ7oogNLwgWshyigeu+l3vZ1lf7CsnHwJou+7EgABZUwYKrcwJe
 fBY=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518329"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:48 +0800
IronPort-SDR: Rz0OpD4u8hlapJ5ocF0eqvIRRJvMVQ44nAAhRmQ2oO7zemQbwQZbMR6334NCkNVqX7kWi27Jmx
 j5lNASgA7NdQQQegJQwcSxiWQr3AM1IEmI7wEN/B3qdZ6Gi89TZkRz7776ovxvXsl7wcLTN0z/
 etDxr0f2RpP2xSOaWfwYLf0OYdG/OADnfYUEdBhFYhqLB74sXTyTfLOaUrGBGciSQt8Z3fxbis
 71hDmdHVaLQuNz3YfYlh+lzxQqFzcEL1nG0b85GQ9v57QYU/dsN1U8o5seGcHNPpUrwJMOwtt4
 y5DFjOhcqQmk41ZrJS+mw9fD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:59:07 -0800
IronPort-SDR: /NPjYa5/vzKcQxwITziayqgew/xym2P+2wPZ/H6tqOBM0Xhb9g154b50VotcIn3s/gPeO6yJQj
 jaDu5T7BNEIYITi6TAhnovFoYzPUstLQt0EGdLi5t/kGP6Y/bNfbV9+olcDvctAzlPCNttcR2B
 XcI2j3jvNIAhA1FsWohm0Q1E2hEvaC5Uto6Y7wmXZKJ1CZQCBzspE+8o3ZgyvyjFSagVsi+kvR
 d3gH64xpw3ry94057Mia9wtqUGJtdB9qbq+w9vxtVohjFozpBIeHLdl7QNCYcftS3gwSjr5dcQ
 UPU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:47 -0800
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
Subject: [RFC PATCH 22/34] fs/jfs/jfs_metapage.c: use bio_new in metapage_readpage
Date:   Wed, 27 Jan 2021 23:11:21 -0800
Message-Id: <20210128071133.60335-23-chaitanya.kulkarni@wdc.com>
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
 fs/jfs/jfs_metapage.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 3fa09d9a0b94..c7be3a2773bf 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -495,13 +495,11 @@ static int metapage_readpage(struct file *fp, struct page *page)
 			if (bio)
 				submit_bio(bio);
 
-			bio = bio_alloc(GFP_NOFS, 1);
-			bio_set_dev(bio, inode->i_sb->s_bdev);
-			bio->bi_iter.bi_sector =
-				pblock << (inode->i_blkbits - 9);
+			bio = bio_new(inode->i_sb->s_bdev,
+					pblock << (inode->i_blkbits - 9),
+					REQ_OP_READ, 0, 1, GFP_NOFS);
 			bio->bi_end_io = metapage_read_end_io;
 			bio->bi_private = page;
-			bio_set_op_attrs(bio, REQ_OP_READ, 0);
 			len = xlen << inode->i_blkbits;
 			offset = block_offset << inode->i_blkbits;
 			if (bio_add_page(bio, page, len, offset) < len)
-- 
2.22.1

