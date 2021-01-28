Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2170306EB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhA1HR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:17:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16412 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhA1HPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818138; x=1643354138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WN34YNrFVBX2exPMiNFaWJshviC5HdAH5Y1CjLjlB3Y=;
  b=gu2R79oyGjJXD9iczICLbJBZCJH0EDaijfnAKJ5bfVmPEGaLkoINWiqo
   i8DiH9paTxCaJI8EIMUmOQT2F7YziETK8SCf4gNjhOP5ed9vGCpG02SC0
   4CHhDc+GeXiEUbfki8rdnNWHf1bh+uDoND9Gnk75JemxS12O90Ho6ytk2
   xUgUC1+b3QreLIgNBldf9MUyGvS84K+14seeka4GnTKAw9YdAh4/d37uq
   UucLSM2nvzm71KA3R35spDMD3DBnjm3i82MDXQvga/UxbDnhdj4tutoWn
   QCpONVeaQZmRMt5vdVoXG3QQM80kvViSsaSkLzZHZwi4Hy2hnt2JGrouW
   A==;
IronPort-SDR: uz6OEYSli3AmsSPFTu0gCBYV6JYxHS4hKVOmwwZvXJiHolrRaWS9NsatlouBnKDPxtbRtpGN2+
 HxbuaIZsVPE5dfl6ihVH0705dAszDfD51p+c50jCjFa3MHIWswWMiHK3oy2zzrFNQvIiaLmp/F
 vXMD7Ygsma7Klmt6IqJH4KrJ+hxa1JOLQHYlWf1xxvlP8aJV5LtRU1Xcgk3ONHd0iKudUqdizp
 +KQDwLGC6z/tmdufX7TsJI4eytfm8/Mu7f0s0Xar7NxPNieuABX0cMM7gRLmnkBZ7eQI2JeXGf
 p8Y=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518294"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:33 +0800
IronPort-SDR: tyKx+JEt60HSUOvq8KjigYSP3ohs1YcMjkZuWhbeC59R0sSzTK+W/awH0hOjzSAl/8+7llNpBf
 0Aa65iRnpMB8jmmZat4ei2JLFXY4vV3TP737DweEdxlykXnNiywAles1ZlSrY5bPdeFuQu+s2S
 oXdnYhS3evEYpZzncmEZin95yIVpNjRux5Cmz4K/1v7GgiCHRZnnwVebY1/gVd+IK6DIeH6dCN
 5mRdOQ+2mYWckGFa7eX/xtp4pXsXeJ4n4nYF96Q2fTfO1jjJzDEm4Mgr6vtkDwDMhLflAkjdiq
 XLURwHc6JM4b0KL5sqh0omfF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:56:51 -0800
IronPort-SDR: hgdemKPG/3HHgXRADNUaRfIeto8NmW8LEHR468JLI5qNdwJ9I/Vz7EOVIHe6ux2OR8aMkXbCb+
 hHmOp4ZL4+H3N5KG2012DyI6S+0eAji83o59kSvMRJsf1lkWorl0McE4AqjKkZANcW6TxQu0db
 Rg6QKY68t8KKdoDxgIWM8St6Q8n+pLj6fbsJ1LpjtPi/SVOVdnUNhjzT9HNr2ak6ECZBXsF3YT
 a/oz2zpRpm0NjKofMt8jO2sCHWsfpktQx0L5tGvTxbU6SR20ACdGgmG00/Fl2WObQ2KsI7nqdc
 S2A=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:33 -0800
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
Subject: [RFC PATCH 20/34] fs/jfs/jfs_logmgr.c: use bio_new in lbmStartIO
Date:   Wed, 27 Jan 2021 23:11:19 -0800
Message-Id: <20210128071133.60335-21-chaitanya.kulkarni@wdc.com>
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
 fs/jfs/jfs_logmgr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 4481f3e33a3f..bb25737d52f6 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2121,16 +2121,14 @@ static void lbmStartIO(struct lbuf * bp)
 
 	jfs_info("lbmStartIO");
 
-	bio = bio_alloc(GFP_NOFS, 1);
-	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
+	bio = bio_new(log->bdev, bp->l_blkno << (log->l2bsize - 9),
+			REQ_OP_WRITE | REQ_SYNC, 0, 1, GFP_NOFS);
 
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
-	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 
 	/* check if journaling to disk has been disabled */
 	if (log->no_integrity) {
-- 
2.22.1

