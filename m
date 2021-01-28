Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F49307040
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhA1Hwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:52:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20080 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhA1HNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818030; x=1643354030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAiSNZxQXn+fhhqJHg770cKqGnQ7j5esbXKR/QGBS14=;
  b=VNfBQASV3ynBBt52wrcWE0FE4vzZyWsYS5j6gA4lUIiqFEkJ0cCkstTa
   n6rSkZReCdLLi5nJ7LB7iG8Pz7W4SOxL9GEqpVH8GjAm4ksiWySBmxG/b
   qyijG59O1cmb4+Zab5/fIQe2z8V4M6mO+UxdOfSKOO+iQgoFoqafaT2FT
   fIQfj/HuCEiRAW6Jk1OprQ+wcdGL5JUv7xp+5JO/JzQBxZp5hjdZ3Jvvg
   iL6T5ITh2woNPLrFqlQ3HL3nW7kuP46IS6wlGFrtEXs7I+kOh+6qIghaV
   QXmX7W5aGT6ui69moIAL/WzUQ9U4Q8TdEsGAihFk4gkzKkQArb5zz57N3
   A==;
IronPort-SDR: iNuOwcin1x6ju9QcP0vYOZIUKIW6R1DQIxJJtr2EP0Rmhzavj4wN7iMwYLpkUp4xJSr+XguHBN
 MLtJhMX3ruWIq0snFK0hXyXSzae3/DbVruj2MIKA5scucbrAXrcwEu858JJ+SMdXIhRuqb3v20
 fN85o1l0zK0mhiZi3vg+nGexv/wzXbxuTr07wxsA40Vmvw5IaKTgEDviQsrXGW92iEkRQ0DFd3
 zZhbGVTZLFRnKBSpOQIN7eaUpdI3riQxx7qQg4H6xE6riXh408VnOP7rgZhcDeqLkNvU5ANv0k
 qZ0=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="159693772"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:12:36 +0800
IronPort-SDR: WMh/HqQLjbTmJYpJSwfBpOTpWN6VFfSuxpZ+VHhvR6RV9F1hRsB/mrrtslmOhQtPO7h4pqVdsZ
 8v/mcoQ4qAHs8kWJFldiPCo8xoD3CdXa6EvuU1+Bk0yARqpdbZ632nvWjNmosMzw6cUH42JogU
 PAtRhHSKg5lZ/1WhDCuIQjGr6I66ssyoWPWGb0vnuuvdKmXt8PUpyQg8c+nO9lSbHpfE3HQvAb
 lXbkT8a2bLvKt+CinaMno2KWOFHNmlcwoFszCy/Kvj89bJq4xCciEKqMwmUDxtp9qtp/GVXysw
 5pbNfau0lP4gEFjMHvTGHi6L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:54:54 -0800
IronPort-SDR: Luc6lg4Pa+bVHOb4HzkXJiWLGqMg6JC6Nyg0Lqb88ZIBDNylXDUPHvAGuri+ui5nWB8hV8jug9
 qFWTXFaOWHAL0oehOyPdERabJ1LaG9aVOt3b6RTgmVCVF9xZaJrmkG+mjzow98LgNG5t1Hjoni
 gqXmojTILo9AyCGo2PpCozas3remWiyjnR1rz1m7Heq2aoYdQ+f2mWDUtJhIIR3UJyQKknW4V+
 XZO06It7hG6XcBrRwkAZf9a8HSkB5bDSC1ddzu75XBYoKVtN9lipurMfP/HgqVuXVuz/kSCAwn
 InQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:12:36 -0800
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
Subject: [RFC PATCH 06/34] zram: use bio_new
Date:   Wed, 27 Jan 2021 23:11:05 -0800
Message-Id: <20210128071133.60335-7-chaitanya.kulkarni@wdc.com>
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
 drivers/block/zram/zram_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d7018543842e..5d744e528d4f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -587,12 +587,11 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_ATOMIC, 1);
+	bio = bio_alloc(zram->bdev, entry * (PAGE_SIZE >> 9), 0, 0,
+			1, GFP_ATOMIC);
 	if (!bio)
 		return -ENOMEM;
 
-	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
-	bio_set_dev(bio, zram->bdev);
 	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len, bvec->bv_offset)) {
 		bio_put(bio);
 		return -EIO;
-- 
2.22.1

