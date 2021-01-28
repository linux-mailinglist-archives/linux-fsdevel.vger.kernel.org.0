Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF51F307011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhA1HrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:47:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51578 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhA1HOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818200; x=1643354200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Co0rYGelfI2tueL8o6ihJdxL5NS5pM4BZ/hI8135Y8w=;
  b=GRHRSEj9iWZoWvwzfPQ4GQHot6+83YlmNuccno6M39bclyyrH6IZ7lRj
   gYpeSESDSiw8TcIO1A1H4/UL0PI8JIuVBTffG+t5Eye3aLklM1l+sJCIN
   EyQH1ZzEuiznHbbN3AZW/GUmZE9iDlOm+sKOOsCDEX70C2f88KuHsYy+O
   NqMwkgRGj39G8z2kYrOCO6sXtZUh2slTXP2eJDrej6/alfSg3PAT1pRyk
   QPn4cuIT4EbLQBO1zQDLoXfSlbflueAfmZzLnpAN53RGKcw55ePRqENt/
   BLDmxFykJ23ddconMBMwnuWqFpAbb3nEfvaojLlLcXOlk8Z9wplbyVxaB
   Q==;
IronPort-SDR: 4mTvy6atMVPrxp+VZDCUWD5gfpeJakwr73UVh4xU8Bk3fpPykw9wpyk6DsB67i7YAA8KWGgXjd
 9/Rq8MAkYowfKPrdhk87R8uwMnkgc1+C8Q+AbSmEWta4dTEOk6LAqgEPlSBhETemQydix+h/Eh
 bMluRnN/kH5OPNxlcOHwP+kS9dOqD2Jl+pKNfSyORIpZWvCWx9I/BmX2qG7eIfdaNg3Gkbrf90
 7XLgyJRzeQkw2IGpIw2sAuCgE1MBw0kKMJtUSiM68QN+qdNDJzfO9JlblV8fR6WD4PLiCJgu6a
 HDE=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262548967"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:00 +0800
IronPort-SDR: LBIoJUPnqINs82cn9PprWfmulee+VR4Oe0d+OBed5wwmAkhbNzS9HgRbFZC54ThWruo9a3y1n9
 q55ZeV0ZAEPAlDKCzGuWZlsieXWWux+fLW7dNDbMq3GlWR9bS9Vf+PzO3HMOGTvQR6UPqCDIYi
 TO/Or6Ow3pc+q1TXKs1Fb0qxSkTJVKAOvRPM36mRvhUVMY7uYRfHBVitDh4ZYymH4SZx18lELK
 iGt5vUVrviwu9nyYhzgOS+SGJVdqzuF+olLIfcnWYyrJAIpC2qWlaD/o/7hbhED6hfWgmF1aSz
 /Ejjql1VCPRjpPMhzhUvTSZi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:55:29 -0800
IronPort-SDR: B3g2yURiLlkRDJQjiSw5Axb2Dh2vXpaNrKE/QAQl3YC0d9KYF6ZY/2WEGrs8Ad4s6CTMSYijlI
 As81DRh7fxTUcG6XscFZ0dEUGMxghLXCUSNbFTul1lhg8N84M173b0zoMSc59+C6RPGCZyVbXT
 e5q9NGchuukS+6n/XolnPl9CgZkf3lpSTdPe2xwj7IsZkLY+Q3H2m4972b6vr4aHe8P7F7VrjW
 YTjKY9EpCmYYdyolrCzI7bP6MpRPHgjkbRdfoyYEpwC7inxXY41c/i8ke9uNT4EC8+Q8lA/Kgh
 6rI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:13:11 -0800
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
Subject: [RFC PATCH 10/34] dm-zoned: use bio_new in dmz_rdwr_block
Date:   Wed, 27 Jan 2021 23:11:09 -0800
Message-Id: <20210128071133.60335-11-chaitanya.kulkarni@wdc.com>
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
 drivers/md/dm-zoned-metadata.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index fa0ee732c6e9..5b5ed5fce2ed 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -755,13 +755,11 @@ static int dmz_rdwr_block(struct dmz_dev *dev, int op,
 	if (dmz_bdev_is_dying(dev))
 		return -EIO;
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_new(dev->bdev, dmz_blk2sect(block), op,
+		      REQ_SYNC | REQ_META | REQ_PRIO, 1, GFP_NOIO);
 	if (!bio)
 		return -ENOMEM;
 
-	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
-	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);
 	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
-- 
2.22.1

