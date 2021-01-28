Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78AD307004
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhA1HNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:13:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51464 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhA1HNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818102; x=1643354102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUCaPFeDv057fdkiILPSRkCuXPSAzqxSiECC+FKJaMI=;
  b=biP6TdjZ4OfabPui3GqKLBHV3MMX8fYi+zJB43kPQxC6MnV5keOr9WC7
   KaC4GJWrRBrnaTluFxH6tpTvegjhfroIvyt4XoV9+Ki5/x4e+q3Ewwrmi
   Hz85jhhFGk7WM4auuLmjOlXnTCrNPcf6etTAwBoAX3iPcBvDPBO2WV5f4
   H5txwas2MKN8r/WvjTCqY69aOWtMO6KvK5nhYwpc7zCNTQDTFxafHlJBI
   Vi/+AZFCOUVzguQyOP0qoGYWZKMO92bRoZOp8Mgmm+9j1CLLHBT1yQPuK
   yeEi0j7cReQT+e71msxkklCn+udpMf58l54JomUqcYQLtLNJaWGwnsVVq
   Q==;
IronPort-SDR: 1f55ggMT/kZcqqqIxPkJGjSgnEpKl8hKnpar1NIcBUfLymW0NcBXultaR0ePnq4ZoJGNqNlLTX
 XbYvaGFakpQ1JWKy5OGGyb6x/NF6GQGxPV6Ngn93THiUyAK774snLcVyDfkp8mLXj0KQIPjH6/
 h6skd9RU8wzN0AMpoxO6qYfZlhHi5AM6Qft6CFwMjaDT9q2RwPEfZFpW3IJzmcSa5Q+TzXEFCe
 mFF2cZhMDiiI5k44JLCZzljnvB9b/m7HqoW6n3DVytqAUTUfp+OCeY1IQg4m5aRW5cyozP4m/Y
 mEY=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262548876"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:13:22 +0800
IronPort-SDR: YLSWWJBxJVHqvJkONdlBKuOj/kP4YYZ8cDftupYIf/4vCLMdms2NNRB12aQGHVWc8U8yT2G6Bl
 fo5Tzxr7r4QaZnb81plYSJdBrlwkCqaN4E3aTElQ6xTZxbV3xeDX5lpgkXDBgQn8fljQmTCzMk
 oOvJHzmm4Ba/1+Y6mv8M5dbQyvtBMxPj62g8KYDT/3ETleYhPwsCMlDkwSsc6ftsZjy+qlVHsT
 n61Mfj+WCzIqBChTJF3NNHE/bWxB04K4WvtpGr9feUZN+b0nV72Vu+N9kUPOJAPAT5X1dF211s
 VV/X2ON9CBIt54SYSo9G37OH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:56:26 -0800
IronPort-SDR: d5xTirF8Ys37shQjxL90xQdmAvrvSyaDd23k+ldZQk6g8Gmyh3lDvEoGm16xcyp5mSBaZTpxOa
 PvC1PFp6twA2TpPlG+Ql+/AG65S9RMLgGFawcQCbg9J6k/x2AMPUiKYtsSCC84Z+EGYfmFKoID
 N3xp6Srvi9c6y+EZp98pFBd59WcY1NGSO1F5aHMorlNIT26uZMyL8pegMXpgjACziNosRf/+TT
 qFeHE9fwJbeXCBkPpJ7sXhYMSQdfV8ojzZIb3gXAYZT1zkKG2mcOAVOk/sf7gRxWJd9WgQISSA
 lhk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:12:06 -0800
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
Subject: [RFC PATCH 03/34] drdb: use bio_new in drdb
Date:   Wed, 27 Jan 2021 23:11:02 -0800
Message-Id: <20210128071133.60335-4-chaitanya.kulkarni@wdc.com>
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
 drivers/block/drbd/drbd_receiver.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 09c86ef3f0fd..e1cd3427b28b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1643,6 +1643,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	struct bio *bio;
 	struct page *page = peer_req->pages;
 	sector_t sector = peer_req->i.sector;
+	struct block_device *bdev = device->ldev->backing_bdev;
 	unsigned data_size = peer_req->i.size;
 	unsigned n_bios = 0;
 	unsigned nr_pages = (data_size + PAGE_SIZE -1) >> PAGE_SHIFT;
@@ -1687,15 +1688,12 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	 * generated bio, but a bio allocated on behalf of the peer.
 	 */
 next_bio:
-	bio = bio_alloc(GFP_NOIO, nr_pages);
+	bio = bio_new(bdev, sector, op, op_flags, GFP_NOIO, nr_pages);
 	if (!bio) {
 		drbd_err(device, "submit_ee: Allocation of a bio failed (nr_pages=%u)\n", nr_pages);
 		goto fail;
 	}
 	/* > peer_req->i.sector, unless this is the first bio */
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, device->ldev->backing_bdev);
-	bio_set_op_attrs(bio, op, op_flags);
 	bio->bi_private = peer_req;
 	bio->bi_end_io = drbd_peer_request_endio;
 
-- 
2.22.1

