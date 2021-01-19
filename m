Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8FF2FB071
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbhASF0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:26:17 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34800 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbhASFKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033035; x=1642569035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+Yd1/4O9mwEd1BMH1dhU7y2A0Eiek2poS1YnEOWuVY=;
  b=fWNXSCAhcbItckwvIt5qRRy/ag9+6VYA5VsCk2g7hpN94LG8mgXBZXtP
   Of30sUjN7DylpCZqlzSYcaZU8CHwwpVXkBmB6ZKagcEWbbwNFqSpqo1WX
   I9mYBz+E8jv7Hoill6On+gt1uWNJWCWU1bA3LXMWwxH3f1FY2gUkGMKN2
   0O8EiSQOfsCdWrlfQqJ9sAaahjG/wqGPdAhELQzXwm0K0ZcNk1GoRr+9B
   9dEjOQ4hVw+wBbWkcu74fOip/LZ9L7ijdzn2Q22nJTQo09Zdp7VT9QIR0
   1oAVkvJzea154Gx/6ZUxBM6ObIGbFxoVrvZV3l/7GUGYWfn64+ET0DVah
   A==;
IronPort-SDR: jC+O6nP/MAMdwui1af7Ikv1CzMbDn2XFYy9w37pA05PchpgXfW0iTXpZSI+zPQ0pj6l9svGRmL
 EeeG8gqBkJeLameM4gGQj1HtaIUf+BucXOvvOvvYDnmpSTJSZapjTkTP/oxKLlMvl+bjJP8FC5
 A04cqqq36Itlfmt8ovHQqqNVJM8MAci+zkzpXEuRaH7N3DOVDQIt51ktEeNZRptGsNPS9G4o5n
 QaYpfhZ6QzjqllRaJnL5GvkaPqrH6cBVDFZwsSJ6e3wXYxthLRhmzk/njFoGnIS/kC777+I1QN
 MwQ=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268081142"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:09:29 +0800
IronPort-SDR: WCdxvo6o/R9U8QtkcOsbeYEcSpfvlbUY82JvNgxd8EyLC3KfSNrguHpu817u4mB/itkKIwjKbj
 nJdP/tT9aDu0cE8Ez/n5ndSV3K166wwObOEYwK6srJ98RK72x+M/1hsPHgsEKdc8i0iMTeCPjb
 yGt83Q6B0OT1CN3CBEJpnJYT4c3oay1ImWN0Gquerkr65/i4Cv43QG2laqb6MFnMtWdV30iuk+
 7Jtz4h2lb5262gPNnmJxqQEA1aBgnJATmNGrqoMhC2Rz9s9Xr5KOejiAIN20QpBgaCH2sngZw/
 OVdm2EtNwFv796HkL1cvnOAj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:54:07 -0800
IronPort-SDR: X2W/WReUXrAfluwkD7se2dZ1819ju1OynW28uTSvDSLN2ps3wO1qXeL0GJaXlJKwpIqaALDMhb
 kimb7jLOr+gpWYj06rWyhvZYDu9+2JsUCLwbEquhMfnoBM1g23E7vbj6QE5tFPT0RXTnWA/1bR
 1HmN0UVHZv2jYDXSsFNmf+lCI3bFpzj7XxZ5y9GFacGpyfKADcPO/cyDwrim/4xYtJ4n8KmXYm
 LOaLwIRAOFVmRCvuPUSpoWyGGLooeoj1II+Syix9yI2u6Xeh/1MmoJBsJ6CUrYMQLVvvA0Jyzk
 ZqE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:29 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 24/37] dm-zoned: use bio_init_fields target
Date:   Mon, 18 Jan 2021 21:06:18 -0800
Message-Id: <20210119050631.57073-25-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/md/dm-zoned-target.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 697f9de37355..8b232b9e3386 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -129,14 +129,11 @@ static int dmz_submit_bio(struct dmz_target *dmz, struct dm_zone *zone,
 	if (!clone)
 		return -ENOMEM;
 
-	bio_set_dev(clone, dev->bdev);
 	bioctx->dev = dev;
-	clone->bi_iter.bi_sector =
-		dmz_start_sect(dmz->metadata, zone) + dmz_blk2sect(chunk_block);
 	clone->bi_iter.bi_size = dmz_blk2sect(nr_blocks) << SECTOR_SHIFT;
-	clone->bi_end_io = dmz_clone_endio;
-	clone->bi_private = bioctx;
-
+	bio_init_fields(clone, dev->bdev,
+			dmz_start_sect(dmz->metadata, zone) + dmz, bioctx,
+			dmz_clone_endio, 0, 0);
 	bio_advance(bio, clone->bi_iter.bi_size);
 
 	refcount_inc(&bioctx->ref);
-- 
2.22.1

