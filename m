Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035AA2FB214
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 07:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390453AbhASFae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:30:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51850 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388577AbhASFMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033169; x=1642569169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjsJb5PcJFfs7EA4rzkbsgQNMxTmWsRroHWsaZepkNU=;
  b=I9KSf8wjo/zWfv0fQhi1nO28hgdLbV8GpCZEXAfZv1U7ZMr7NvGg3Ejn
   44u2fJnV5XATxkFJQaLRiHykwcpoD7IWfYf6KNITDeiW5mP4M1sKtE5D9
   m1DwJGm1+Dqj7ECDeYrXrJDz6M3gNEjk0Ee0jcOE43SXuDnmuxEBw2agO
   e/W48pFnisc7nHXPnWzimS1zPPnW7RWzXqMFLsbjPRoeABw6kyMyOPPZ2
   LrFpXIhVGoM29MoPimhru3ULGDy6H0y53gDsnHt1BA3tjNTKrZYCHDXdT
   2riYZ3hT3NGWZMmS+Yk+ffxq4FbX1aiiCaKoLG86O9Gl+lVt6yabluLVW
   A==;
IronPort-SDR: EzNX6BKmiwjVAJApifaXrPg9vpHLMgnmIQd8FMGBazegESIBfuy7d0GH4TuOTCpk+7ROnhzCpq
 WiGXE6CRU2Bj5xtXbzSopm+mgazwxMsccGRAo2sCfgP/aYbVFQjkmaP5FmyOjUmaSAio5Uxq3L
 emjArYBp4S3UapmtdZglY+6doOmxqSKLCRY+C9Fi2eEQHDvqnEDtpUnNq37udDmj/XHiVAXZCq
 tcIeYPKoz9Mtx+awNrQa1bzQMWHVYKKYLLF4NH7RKGTw9hrc8Za/kt/g9yp3lYhSXcIHM/xQjX
 aag=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157764063"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:11 +0800
IronPort-SDR: vYdla0T3CEB4c3aA0F5ZqWmHZmptTcDkVTzWOe6n5BjR05hceD017iEFwAnCilYePCQNn7S3Zl
 8H6LZU8y5mPZCGuFmmxNzG4OFOW+zMVbWpiRybZZY+cdx0UZQqHcx6YhLhqJkocloPLiML/LpJ
 H/2aAgp9z8q7kgel8W5oq0MNuc1M4V8hRBf0TudEdZJ0VUBlKiKn4k0MthQEq0CNLBwjok54ie
 wjTW81AcwNeuXxvBVVnRQa7apYm1TulPBbxeCmYYmC5JTjJN8W54Tb1y6uJF+uX6Or+7zsO+Or
 q/b/GMRczKH0MM2Kglspg+vf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:54:48 -0800
IronPort-SDR: sUJEXVVGtr6hdXWriU6va4OHVDFOeCqexBkNQgHd29bupqR1FAk1FagKslaqLW3ZUUxGQzR8Ug
 NtO68JgANUVdRxpoSQWII/hxMhExDp+a994ofqnoDT8BbVyZ1XbW5GYb7r0UZsyIyvfIjO50yw
 MZh/UChC09g0/v2Fmm2Ka8Iym4W7jfv3l61pY/GYFfEKqEthOGPxecFMe1viLbkfMh+TmPOZOJ
 niLv3X9jvTg8OiAwbkqtrE2GRDLktY9HmYFpEeDkaOstLITBHpJmhuyQTx4ICZPfsDRpeUTWvU
 THQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:11 -0800
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
Subject: [RFC PATCH 30/37] fs: use bio_init_fields in buffer
Date:   Mon, 18 Jan 2021 21:06:24 -0800
Message-Id: <20210119050631.57073-31-chaitanya.kulkarni@wdc.com>
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
 fs/buffer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 32647d2011df..32e9f780e134 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3027,16 +3027,13 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
-	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-	bio_set_dev(bio, bh->b_bdev);
+	bio_init_fields(bio, bh->b_bdev, bh->b_blocknr * (bh->b_size >> 9),
+			bh, end_bio_bh_io_sync, 0, 0);
 	bio->bi_write_hint = write_hint;
 
 	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
 
-	bio->bi_end_io = end_bio_bh_io_sync;
-	bio->bi_private = bh;
-
 	if (buffer_meta(bh))
 		op_flags |= REQ_META;
 	if (buffer_prio(bh))
-- 
2.22.1

