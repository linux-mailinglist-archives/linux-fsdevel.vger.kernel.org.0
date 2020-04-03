Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4D19D4D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbgDCKNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56746 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390591AbgDCKNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908794; x=1617444794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zp8Fvp7+ys681iufOgo7VTs31ay4WvSMoXUToPrkYmw=;
  b=RubCzKklemnx+1oQQEjYk9psfOHosBg/BYnEspjNQKULRjm32/POjtlJ
   a6qEhAA1GmWj1+t9GczMhHJvzXL1YJ7iHP3WGgKLQW8EmmNVsP6LN1R/s
   1OVyuG8ddtcdtRlbHl+fTt197JaDTGXYJ0PkAWPQ7oIA17KJtiqOT1F2u
   fb1JSVlijnCQw+KQ4mUhfC3qYxYYgklosN4p8ZOJtorgemGVyDhKT+Vqx
   bGIOrGKW8tVAOTEzBXnXyuVAlrhFuRd1ymCqk4dPeHU0qvhiMqbD7HZVd
   k+Ds7Gl5txTNKGjz00gCiUob202rgQonZa7I8T2GLpndW6IUQZFpaRqJJ
   A==;
IronPort-SDR: ZQB0f32jAYhL8euGmv5e9341re0Zr+VYi5snnNFWMS1hkMEgF+HZcIolvQy9JYMe3dMXz2aHoR
 rGTwl4IA5vY5Eq4tNENVTwMvOaITxWCxWOeFo8BOqMzu9ubnEpyeh7aZtGaDxACC80x0kxcNI5
 mav7ZMLCOB2vrYGUCAymmB0hap3PKIJHrnoPp+SSge5qg+8qYg8SOCDIkYTj1EqMpmZJh1uatc
 Mx38sbZzDucdkprGeoRlV4KB5bQIkz4ya1xA6LTyYzSx3vbp9yxjybMb2Ju4VarmZ7vYGxdWK1
 peU=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956047"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:14 +0800
IronPort-SDR: 8yQQSnkT3vsn/DFd06LClb6c9hXvJ5Llf6jaH6U7u56/4gbVKhjaipt/3gEJAcXAVXI33Kq2eb
 k00BykAjkhWJCf7Mskg3wqblPi0MmfruFV7w/531FF7n0/O2yDoYk/LtEkbFYYlEW8nrt+EAdk
 77yO8O6HAcng3BTTjTrn8hAmHvGe5DxgK1HCtH5OeVaYTP8h+3GigK8N4Ir6rIheycKKnwQUvn
 fbhFZRO218ul5dbipSnlomDYiUjabSPEm+2q7ryeViSDF3APbypPT+YqIQcP7TNwQDCguekpfg
 e1n9KKvmOy6QvsKb6lU3UfLL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:04:03 -0700
IronPort-SDR: P1V+9SY1KgNIdJZX3X4r2ZiRz03o+myYlHzqTVlimbyPBwOGrAinoCJOENjjGrk93yOsrUZky9
 rphgK14sabn0grbQIAnNiG+OSYBecY6F5EBRjK4ESD8DMi3X73Ac1MXAn91YBid6ZC+kVdWpaa
 2HjueYdp6S5/89Fcjd9+obHP+cILfpEokLiL6erFMPtiW8yR4NMKjGjYSQG2ALbyJ6PV1gJ7OI
 nL+SoWFpZafQPTFAawUjKcXeXZx72gaV29DznXLmQ1mXL6wQneAT51TH4n++C+dVkPhQTB9+rz
 5+E=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 09/10] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Fri,  3 Apr 2020 19:12:49 +0900
Message-Id: <20200403101250.33245-10-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export bio_release_pages and bio_iov_iter_get_pages, so they can be used
from modular code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v3:
- Use EXPORT_SYMBOL_GPL
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index e8c9273884a6..7819b01d269c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -929,6 +929,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		put_page(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_release_pages);
 
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1050,6 +1051,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 	return bio->bi_vcnt ? 0 : ret;
 }
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
-- 
2.24.1

