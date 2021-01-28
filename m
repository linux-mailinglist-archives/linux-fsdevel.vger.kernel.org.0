Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE95306FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhA1HjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:39:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57181 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhA1HPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818108; x=1643354108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+nCtEeEc6ftLNfXULXJD9MfOSjGF3wrLBEXOv9oezHI=;
  b=qZ/Yz64PVZQ3vvJYdpiSX1p+dFLu2rIiYRHTb6f7J9Z4VkhhKPXBQnxR
   VzoD6cup92OHj+sRjGkO2qumFczzUBmuUHX+d5P4MsRKjOYKU/mh+8Ts6
   u4GKa4M7u32NGccitcxVfVh2uOjiRYU9RME+j1dBMs6EdTUn+2g6zUD1y
   Qa30C5QD3TPEyLrdgMLxrfasEhOW1wf9RLYY8jnGzsoFw3wRZvrvrMiHN
   SveJhD32q0n3O4k2FAo5CelDBy3kPbbl1NTjHhavBXYgv1dXEHSNBs2OE
   XfE13H+L919H5gZcoyX1xe9+vAkHl7iSvUeDDdeu6DnfFFS5sk4sZfAZ5
   w==;
IronPort-SDR: c2ok0mPY/6Etdqiu4wLr+O5KJbUSrWjFvvaCeugrcoTay+0VD7RMTErfyt8u1ppuvOGANM5vLf
 mT1wH+GIVUvEUHXwuKCZIHOI52exL4VAXyYzwkuLkl56jfslKnlTsoL+1KRdgIXwKGgwzckXhD
 +i+f0kZiZhMs/c4H8MSU1p0xc7/g6UmpdqCiw4tC3fSoo+ArQtZF7NUtphBG+FFxFAhFNLZHEB
 GVI0uK/FCx5zNgc0Kj9y3AhGIhXSvAgW1JbbTP5UOTQ3H7B8QE57XF/GpetyVCXXyf5X06X0Rv
 RP8=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162963301"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:02 +0800
IronPort-SDR: B4W2DPbRXk5KkRaHRrB1OI7mbcRYiIweV3tKD/02NShLL3QdnKu94ITyx5iUC7wZOyJqRLwDfX
 kDUML6AVU8Rie3NPfndFpEXM/sej/SzbH/Tc3WKdTV/3x9IYdsk1URshU31UkSCltyqCDWib/S
 FNMwLkgzfnVuJTODQby/ofQgP4nrbxlodURGEZjV+YZzsdg793Ic8r7o3W9uUdi1uL9A79/FJ+
 ik82vmXVA+uPR39qc6J5YhDdL1B2KLrfm4yNfxJm5TaXcE0r09QKfawMqJIkZVr1a9QOaZi2+j
 43MOjZz7nUiz8HDTPEiihZts
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:58:22 -0800
IronPort-SDR: bKh0CeniWKxunCNm+jG9l29yuZPN3D1Gz/JAN/nXUgFIRD0d9U6vumFzntseHSRI/MX2HRMaPA
 UMPAuzQRLKKctTclKUM2aKzz/TiMAXwUZH3o+WrBdocCIchNR3Uaqkot1vGRPosruVN9zghU/S
 4vOkqxWogelsFgsfoTKuGHPXS0UKS78L+4719OXJlLRXt4xtaxkQvpBhG3tmxGAdTiSRUPHfPH
 NMPtpPqqTRUN1CMc8PtnqpeNKU9vUEZxV6F3t4AwWzk79mqUHtn9Cp1IEV7L86NNsrAMFQsKWR
 ljI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:02 -0800
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
Subject: [RFC PATCH 16/34] fs/direct-io: use bio_new in dio_bio_alloc
Date:   Wed, 27 Jan 2021 23:11:15 -0800
Message-Id: <20210128071133.60335-17-chaitanya.kulkarni@wdc.com>
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
 fs/crypto/bio.c | 2 +-
 fs/direct-io.c  | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 20dab9bdf098..28cd62ce853e 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -148,7 +148,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return -EINVAL;
 
 	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
-	bio = bio_alloc(inode->i_sb->s_bdev, 0, REQ_OP_WRITE, 0, nr_pages,
+	bio = bio_new(inode->i_sb->s_bdev, 0, REQ_OP_WRITE, 0, nr_pages,
 			GFP_NOFS);
 
 	do {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index aa1083ecd623..6aab1bd167bc 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -397,11 +397,9 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
 	 * we request a valid number of vectors.
 	 */
-	bio = bio_alloc(GFP_KERNEL, nr_vecs);
+	bio = bio_new(bdev, first_sector, dio->op, dio->op_flags, nr_vecs,
+		      GFP_KERNEL);
 
-	bio_set_dev(bio, bdev);
-	bio->bi_iter.bi_sector = first_sector;
-	bio_set_op_attrs(bio, dio->op, dio->op_flags);
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
 	else
-- 
2.22.1

