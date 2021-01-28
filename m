Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24310306EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhA1HSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:18:44 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22642 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhA1HQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818198; x=1643354198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cXmRF2Su1ZKio9gUSME8BeoE9pXLYvn976s4DXPYmio=;
  b=VaRBQ6YxKGKjVtoTNFVcQ5uwyV87uSnQ7g1GH2DOTzYIUnvDgh/3pnKE
   /6qmQKjJI29qIF9h0U2L37C1hAnmLD3TkRAOOYS5JCmnTEOs7xjEZ3zi3
   wxMmAwn5P9qVLYDSBNIZJjzsCDc3x/xaBMb6DEWAoSfK4/eX5nFPatvJX
   oFthhgRjSiESz2YFRw3k/XxdWHWXVFaHKlvD0mlbyLp7dkA9a5wdP8YMS
   Flpov46QwiAUkh+6kTZ+pwvIpz+myS3O2hQ8MF0BVAN1UAgAoDYS/s7Uz
   4IddvzOz00DNCLhF6mQ3+AGfHzdAjrSt+lNIQrzgBF8SnvVnuloqBu6Q/
   Q==;
IronPort-SDR: qouX7FEWYku/EIcaLeSvDRO+nyGygc86CJQZ/lACj5d19vSYhuJ2gxYOfp9F/nXKdgSYK92iTr
 J6AE7z08It9HOwE2pVMP+g9PqCSufiBc29kc0/jOxhuL6J4VAwA2/ChXsqwlAOXViWOs6J81VX
 ESOTyhs79gzXc/mAzlsUWoqdKioxtVzk40e0opML6S2FMalHHgK+OiHrpOvLELog3no8jQyqnH
 OtFcCx32NR++XVsPwWMLlZJ/rif6zEzrLNqw7opEEeRPOPP0a9sBViXLeVMkCHThUiLTtm8YGu
 RtM=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158517539"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:32 +0800
IronPort-SDR: F7D+JzTIMNuOM9rJE9rzREWmu3a0T7ckKAGVF47FdUVeiVjpgSf0x03/GemY2eE2EGoGHzHnSA
 WKHWnPkM9aQPHSnKTf5Ke7RvxvdU7Xd6iU6jFQJ/LM9Hse5xpvBepv5X6uPX5msmvWG6EcMU0s
 Hk+bWOzZJAyWfOsrGVj6WjTEUd7skZ4DGKzt9TkRgMQ6JLgsbCpCupvMVhRFNVwIh10oQopAfs
 2lhR9odEZL1hzlV1xJmQRPgoI76/vIBgJgI5JpeWn4dwqLrq1gqKR9eo4A79TAeA+VZoXGsFQY
 oVbd22FYkDwLZU1ciz2nNIJf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:57:50 -0800
IronPort-SDR: m+UU9TJBIXCvSyFz/7O2vaYmlOCexk8ewW0e2kOKkWSuwpQEVFGI+DHENO7Q1Bf8IQzN352Mi5
 5dDETfg3/zd0aL0yHDjcbUD/eS6byN5dveWHS0JlUn01j5YdJYnuzvRhCyGEwEvsPLeiwlo6h7
 h47UPjLb7UDOPAPFC4EqcqtJYlkeHUwpVqBF6C8WUdWbiBbzIaj0jcLgB21R8kA1PJHycwAnr3
 51c0CVR8EMmKQ6pEvymjZcIoINYcADZvl3xn96JSQjk6KW59eeMqwpBFLuZiCrCp4Zkdz1bD1j
 kZU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:32 -0800
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
Subject: [RFC PATCH 28/34] zonefs: use bio_new
Date:   Wed, 27 Jan 2021 23:11:27 -0800
Message-Id: <20210128071133.60335-29-chaitanya.kulkarni@wdc.com>
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
 fs/zonefs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ab68e27bb322..620d67965a22 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -661,6 +661,7 @@ static const struct iomap_dio_ops zonefs_write_dio_ops = {
 
 static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 {
+	unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct block_device *bdev = inode->i_sb->s_bdev;
@@ -678,15 +679,12 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	if (!nr_pages)
 		return 0;
 
-	bio = bio_alloc(GFP_NOFS, nr_pages);
+	bio = bio_new(bdev, zi->i_zsector, op, 0, GFP_NOFS, nr_pages);
 	if (!bio)
 		return -ENOMEM;
 
-	bio_set_dev(bio, bdev);
-	bio->bi_iter.bi_sector = zi->i_zsector;
 	bio->bi_write_hint = iocb->ki_hint;
 	bio->bi_ioprio = iocb->ki_ioprio;
-	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	if (iocb->ki_flags & IOCB_DSYNC)
 		bio->bi_opf |= REQ_FUA;
 
-- 
2.22.1

