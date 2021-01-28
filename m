Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E92306F40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhA1HZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:25:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51578 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhA1HQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818385; x=1643354385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oh6V4IvaBATnJjcr0mcg+O0k1fwwkwTxUMEnAmiYk7w=;
  b=X6+QMWAiSR1TCOJM5sz73jA3bHP7cp9aN9wNGfgzawOfjh/Wyj19ouy2
   gOOYuQ0mxI7qTGg8+bduASWRV7Y+1ryjWR+DT/5fHixjM8I5P8umf+ovN
   M/rO4Ep5PRcrfKKUZCsEJhN3odnWo/Gr6ekLX8AlQzAKi1/vIU4gNhlxH
   boll1YKWXZz88NcockjCneIjSPdEFRVButgFAjY1mtobj6YCvyzShE2ga
   UTT9F5fq+IP4QSRnOuPn0HGuuoC0IrMfbQ6Hh5OnomKnwZORj+PmqrxcL
   KmqTDVBa4uvHiNaxJkd6qrcmwuugPtf/Ca1+RZPNLercfet30tvcp7pqb
   w==;
IronPort-SDR: mFtXVhLYDzsj0s4DnvH7kzwjb09ccFARGIH93uyNaJXXfrD2r66+GyGlO6woLLfcDvdmahjMy1
 dPXNVP/3ChVa0clnZ8xrC+sYVRWT4vaG+E5xoybgL2gKUMtItyVzCQU+pLzBf4yP3CiC8R8e/c
 wiUGYaX53zPSXCRkA51C93TW6t02EAmLaFoXLqOTa1AQ/uonTiothsUXN63+JxfIT8qxGdNaRB
 rDN2R/ei+fbZayUiLxigHcLA1nf6ZUbfpl/oOsFzWkMQREicUZD0xZoLYDntmnOYSyex25DGwS
 pdg=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262549164"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:18:09 +0800
IronPort-SDR: XRMR2wwM8sSEjQX8p8sT+99d5tP+AyQDrEk+cNbZPgHsXjni6m7rK0wIiUmu1I7AtJklKcNtrv
 oFeUHxNkkK8s0KIUiSzFyiLwUj+6xRN75vizaJOm4kDfRCQOzH3q0ZPfbqien4qei2cGT48Qgr
 GRVEOZ0U67NDUxomM9294n/8xaIChwPTRhPp04HWQN3RQSw7I0pVe9KHITBLndS2wg0lwx2ObI
 NqxFGaji1VchosnyLU3kcteyYZ19MlJgztz2y/hmUz4ZX4JQUaJ6GM596CFuCPROqRSDSMmYPI
 i+lU0P3fcDstWn2fIMhsJL3u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:57:34 -0800
IronPort-SDR: VKPK85FFDQ0ubYH9k6Rw6wieHrPcfl4K1hBg1VEjOVVMtv+Wn9OrY3VfBreYbEOSh7D7aOPUjq
 dJWJ6VlQs6sIYpC3Ssc6YP0uwWxx1b9TT9J1h3Z9GJWPAkbpd7nwyEHzf2X7DKDqvOlXI3kZN0
 S1wmdVHTrX+2YjnNZtTeKY+gTEIX2ZCvjrzBqJLi0bsvbsghiV571IsEQgaSLG4TZiYK5W8fXC
 DCDkO56zOq766cZD9jubbH+fYuelJGqJtYeO7naSGnNxMZmGQNaOGjq3DEnkrTfIYty+jvU6Mh
 VMc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:16 -0800
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
Subject: [RFC PATCH 26/34] xfs: use bio_new in xfs_rw_bdev
Date:   Wed, 27 Jan 2021 23:11:25 -0800
Message-Id: <20210128071133.60335-27-chaitanya.kulkarni@wdc.com>
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
 fs/xfs/xfs_bio_io.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index e2148f2d5d6b..e4644f22ebe6 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -26,11 +26,8 @@ xfs_rw_bdev(
 	if (is_vmalloc && op == REQ_OP_WRITE)
 		flush_kernel_vmap_range(data, count);
 
-	bio = bio_alloc(GFP_KERNEL, bio_max_vecs(left));
-	bio_set_dev(bio, bdev);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_opf = op | REQ_META | REQ_SYNC;
-
+	bio = bio_new(bdev, sector, op, REQ_META | REQ_SYNC, bio_max_vecs(left),
+		      GFP_KERNEL);
 	do {
 		struct page	*page = kmem_to_page(data);
 		unsigned int	off = offset_in_page(data);
-- 
2.22.1

