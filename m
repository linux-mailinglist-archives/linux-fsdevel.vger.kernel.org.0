Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B08B306F3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhA1HZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:25:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16178 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhA1HQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818185; x=1643354185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OE6wZQGKF5NjVuNViqgkr5UqZUb/ZMMrnmgRjBTexFA=;
  b=NkEKxW/GndDOFjRVGHBMcrqRlOorSIi71kWRtlx4W7bs2l11IcJCI8rp
   k1Xb+jRWcvcKc+AaMsVMHSWFNgZewxoL294AnQNpYxUMrCBLLT+o/+VYj
   euQ7pPxBH899BRtwaOEucpb71W7HMqzpRCUlP3VCSuw/8OGIiO6Lzs2j8
   h6GAk3nfp3MB6AD7+3+YUeBDUOqsJqphG/lKvivHjnRbfHLd8lyzzg0Du
   sLznVKvE/HB4u8qtm1B+OIMqtjsgo0kok6l6mk3A80zJaQAvfJomcxgF2
   pVrIJNgHIgSSWHe6wZZCMR4h08SbIO66rxG8uyh0AI2J6pYSza9u3iSI6
   g==;
IronPort-SDR: WPH/VwlJRHBYT/KgsHBsSN8VotVLhrIhxcKLXIbHjAbyQRu9nf2B/LNw6x8f5RhzueHJB9lrj6
 +ttgsV2WuNeE7WYVe2+JTHNqDb5M9rsNZvtUwtoIVZ+fYvm9CR7u/LasM0dky3KUNyELZHFSl2
 AnDGkqDQmWQUTCfOG9gtqcBTwHWp2VZvyjg09dzI1C725OX7QXvRFfIMeJOClHcVijL04NC03Q
 XfoOlQF7v0ura6pd3ITu+g9DUIk738fvDFp84LTCyuaDUIthcX/ZuaoAOAQhXSw+ihDZnH6ZVC
 SIc=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518403"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:24 +0800
IronPort-SDR: y0iwli7z4iWiTL1J3buBSjtIOLGpktZdscaKqzXq0avtmySwZMkM/DMoNosx3FbugDPsg7p1YN
 0u1D15sXgCRvUl+AYqdnTrgXXqRikk3eKekD8el61bQ5Fje3cn/HBjjtGDA6s5HKliqLSwASoY
 3X/pMQt2ygx/XywKJiuzecAkj/60nmg/oqFXCYKeMq89z1NUIUuw4Etvx70Q/k8GQrNK1Gmp5m
 9D7z9Od2YRyH7URH2Y0uTiXOaN3M2ETI680ala6MyOioHNDACjKUfPyFFWCWKCbqOFYM/D1IjS
 HDbE2eeVRwRt5kJ1l7sONJNE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:57:42 -0800
IronPort-SDR: AdKYJH34AY4CiVzOXrR15FurWGZi/qDC6z/alYko7jfVcX/SfFhaxUFqHY45DLkP4HiXq60mY4
 qy4n2aJHjpVtmV4fSh3ShuNif1qvectRI2b9x90Cd2PVCzWhg42ZluTJX4mv+bwQtY61xYcAp/
 v9bG8JoB/eY2HEcD52Jlws++S0SYBgnZiIiDuQlpbjK+vhOG1JlBdY+QSI5Hl4fkjAcjiES8aY
 m35tunBPrJVbQ/UTOrTX0lDDjwM/GyWBlapp84/HLby91yE2yFuR9fqy9YimXKC2AojA6XdL7Z
 KBU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:24 -0800
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
Subject: [RFC PATCH 27/34] xfs: use bio_new in xfs_buf_ioapply_map
Date:   Wed, 27 Jan 2021 23:11:26 -0800
Message-Id: <20210128071133.60335-28-chaitanya.kulkarni@wdc.com>
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
 fs/xfs/xfs_buf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index f8400bbd6473..3ff6235e4f94 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1507,12 +1507,10 @@ xfs_buf_ioapply_map(
 	atomic_inc(&bp->b_io_remaining);
 	nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
 
-	bio = bio_alloc(GFP_NOIO, nr_pages);
-	bio_set_dev(bio, bp->b_target->bt_bdev);
-	bio->bi_iter.bi_sector = sector;
+	bio = bio_new(bp->b_target->bt_bdev, sector, op, 0, nr_pages,
+		      GFP_NOIO);
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
-	bio->bi_opf = op;
 
 	for (; size && nr_pages; nr_pages--, page_index++) {
 		int	rbytes, nbytes = PAGE_SIZE - offset;
-- 
2.22.1

