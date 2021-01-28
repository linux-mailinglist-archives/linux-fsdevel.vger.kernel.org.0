Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D4D306EEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhA1HUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:20:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16412 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhA1HSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818300; x=1643354300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mX0lBXgZV5dDDUNO5/xUPQTxA6WXojrnDbaB4rJIAQ4=;
  b=UK3xJc9Kn5/HSinlww6nzCs/tKuhxqRKodiCtpnJoCPY0TE6ieP/wMSo
   QOi6ZRGelo9Bwop4R+gTYy6+Ar2jTl2CNF7F49z+9l0WEVwWmemw1iRTp
   RhHI6vAomRNSROk2hK/lv0QA7c2QJ7pn2jdKbsJPCw1xdhkmu59Z96W9c
   o9M+jF777WFB5DTNfhM6juMhHEH41PSjzYrrQVXLOsyCgI2nvXQaBHJYu
   hqK5QJHdQVI+tHoYg/QC6gP/dlUAi1vnP+2t1oET/HfA2J85uNH+F/SYr
   MVU7zBVwIjzut/Xi/f/7dFwVaIxZQ7Sr0hYI3wivzRwK5xmWha2uybFz0
   A==;
IronPort-SDR: IP02B0t48+ZS6eTsMOy5CC4RvdEC+J4WI9rOgdDEL6i+HX6ygrGDYLvMrfBXB2nTQ5LpDFtVWv
 gMdNsHFU2JezHpKEkqwybnwgmcuI798F/kciBpPZolNLi9bp8xTa+4HfW6fHo1GbxKRjrxMjfp
 7eQRFkGemN5ylmzRa/Ukp+ERpUbpL99IpOCxK/EX5Pa3CE9GzgMFXlFqRpWaaSm/bzJFEde46p
 hhsPPIEmSkbCxIhNlqeNlH1u1W9MFYS+buMJDv/j50PjkY5wwj3vJBsqGN6j6S9bsklmwl3iDU
 TzU=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518438"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:39 +0800
IronPort-SDR: 4Shp0a9OlbAOH2CLBuUtXbd+Bd5iM/1YmLPuWzuCX8Y3r04Ee/2cIPh0Zs23g6TRb0TXi4GG7g
 JNHZPStpg0g3A4hGYg+hkzLSApvbGQqHQhvj/pG9ufJK7xcXmdUr5+s8gCA9VYUPlFQ13d69+8
 FWvE2wiURnHEUwCGdMXd1g966XZn5RFqVeDduSg0FzqH10abFQxea6BhWdkpq4oI1C1AaRvc1h
 SbylIYTBak8uc2nt1vQ0wghyDCCwhFzdt31mVfM2BnQxSElL0yLvkVA7PVmdz3MmyvJGE8J09a
 9dKJ64EPHArlVy0q24EEbj/h
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:59:59 -0800
IronPort-SDR: +tiKd6++/IklFSy7iDJaHbayhG5AQMYy46sQaNwq7O80dac1IZ8ZNlxjx4DxYbXvKYV6ua9+Jn
 RJlpIO7cWN3eoJjRXIKMWDgWPb2hxGv4A2WF6qkOCUmJWGu679NggrholDw0Y/zhUvvPmDPwT6
 YMwbiHmVzfz4ihKs4Lc84G8Ml2oUugQkKwA3saHG7RouPgTCEOWIbUjZGA0E7lav6RMiRyuWgb
 NQVibBmtLzaPM7sNDSYSURpVt5muhPgCfKQdUKPwhH4mY9hUDkI5QyIoSDd8h2S0Ai5kAfU9pn
 AHM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:39 -0800
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
Subject: [RFC PATCH 29/34] power/swap: use bio_new in hib_submit_io
Date:   Wed, 27 Jan 2021 23:11:28 -0800
Message-Id: <20210128071133.60335-30-chaitanya.kulkarni@wdc.com>
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
 kernel/power/swap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c73f2e295167..e92e36c053a6 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -271,13 +271,12 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
 		struct hib_bio_batch *hb)
 {
 	struct page *page = virt_to_page(addr);
+	sector_t sect = page_off * (PAGE_SIZE >> 9);
 	struct bio *bio;
 	int error = 0;
 
-	bio = bio_alloc(GFP_NOIO | __GFP_HIGH, 1);
-	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio_set_dev(bio, hib_resume_bdev);
-	bio_set_op_attrs(bio, op, op_flags);
+	bio = bio_new(hib_resume_bdev, sect, op, op_flags, 1,
+		      GFP_NOIO | __GFP_HIGH);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		pr_err("Adding page to bio failed at %llu\n",
-- 
2.22.1

