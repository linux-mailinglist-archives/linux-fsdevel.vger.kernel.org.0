Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8214F306E8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhA1HPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:15:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhA1HOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818173; x=1643354173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebUREFacDD1ljG2MqWB5dUmMjUM91D8UhGi2M79Y0SA=;
  b=FdbFsRi8aPHIvnVYN0nor7Mx6o6KjTthZFg62zi8AryvpaZ3xe4tMk0F
   LaPts8xr6x2oBPscqas7rEdlxLbpkpKTgVAqCnrq6UdsuYb7fzeSa2F8Z
   eEEYLIWmHt1wiwx+EzA2i14YTCpLO2YYjXk5Fr5vtLOXkBc2cO2eawoQ/
   4OlR6rYRiQ37X0fMVh6vjETUFyBPWJB15ixWjuCdEWDtbw25DzPCA6PSU
   jLXWhjUZohsLqbP4XOxRLBTaaRQi4hR+FWJubBfOY1ry2n2l/nK1KdtQm
   JtkJ5v9uGPjbo1NEE41wJWAX6a3TNQCnxJnoeO+2RiZ2HUkz0wTCyRY7e
   Q==;
IronPort-SDR: HzPerQaiztFUEasMSGBL7pufEwyW6IIqPAvQBON6N3S3qbv2A/1T6LTjYaiTF4Ys5SbmFbwQh7
 YPboUWym3b+HtkZAcFyRMxwHIjXcO7RpDGDJAVRLx1zi5Z+hea9ap6MZHbNrBvN3ce/90zv1hm
 mIxPdZZeQKw+DHdc0Im435VhTXy3E8CO66bwvyOJouUTqtibzAJ4057uiZNbkkpHGWJsx42QEA
 /ACZSERNohlfRoHrjMf+9mSJqoiwlyDPkzzEvQLbMJnnhfI0QqL/5HXAUxEUTzIH6vdwczF1Nr
 yds=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262548946"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:34 +0800
IronPort-SDR: QDmlDniK+Qg2wmCIrPidpFhBCW4Gs2rBnZVvp0UJtmX7iw51NrOfmxDB3vABBV5Y///TftVWbw
 C3vN34g0s+vhOOj9aMfsP0NCmUMxrAD3hvvdvhIxqmnY28R2IZVjEOstkF8aMK69VBp/PrmZeN
 lB6462D1Snv0shDe59MOlVfNEX1cQuVxfcQtx1amHQ7IxaIjPZXOsWYWZysqq99Yx3mxiAim+f
 NQsJGXf011KB06lmXp3si6yLr25GGmDlwo39F0ICU5r9LyIjhQ35O6E+JpFcUhSstH/8se00Sx
 kKtuVS1qJi2PkmFdrn+EONtS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:55:11 -0800
IronPort-SDR: PY5y9iQTPaVno0Uv+vDzXalBIBo52CYeNhdpn1c7TxoOle28qWYUG06GBXepBaS7SSBSs9yjco
 7juMCiLNAFC5Fl7+86T3v8dT5wViZ/r3nWsFgtnjfanPUZXEs47a6Ez/SVmFCas+uBcEU4K0rz
 829GMnmof7Vria8o+CPxuoND3CfaQPgb+QYuf0lvO7BAPoDvQAY10VoO7lep1Qta/l6nA5+vbg
 ht+uppfjRckOmE5ekZUsc4vMGzhgqqwVxG/dC7eG99G+et4hw+q4h30FxFyz73HjopgItSw/2N
 PHA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:12:53 -0800
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
Subject: [RFC PATCH 08/34] dm-zoned: use bio_new in get_mblock_slow
Date:   Wed, 27 Jan 2021 23:11:07 -0800
Message-Id: <20210128071133.60335-9-chaitanya.kulkarni@wdc.com>
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
index 039d17b28938..e6252f48a49c 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -550,7 +550,8 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	if (!mblk)
 		return ERR_PTR(-ENOMEM);
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_new(dev->bdev, dmz_blk2sect(block), REQ_OP_READ,
+		      REQ_META | REQ_PRIO, 1, GFP_NOIO);
 	if (!bio) {
 		dmz_free_mblock(zmd, mblk);
 		return ERR_PTR(-ENOMEM);
@@ -577,11 +578,8 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	spin_unlock(&zmd->mblk_lock);
 
 	/* Submit read BIO */
-	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
-- 
2.22.1

