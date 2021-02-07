Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA35312723
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBGTHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:07:07 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38248 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhBGTG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612725738; x=1644261738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X5WW6UV6FqDYJmbiL6yKTiQZQYZsZ0lHrvx/ZJ7Pr8o=;
  b=PzD2vK+Vg0jOIhPJfsltbJRxQFQrAYNpjlw1xGTVY4duAPkGwhfGqBpb
   toZeWUfdEFYWSo0Zz5qQEYyKJIScLKD9/FWBmvjsrg8HRx5ErCmzWmg0K
   0EyvxWi7aeYBU3iiMU2rX2Fol2UwSlqXUkwtaQG7JRiXeE5PQgnvaF6Gd
   Z7smanLFI1dXcAd6R/fyXNZl1UNhZQTrSHxOw/Ifai6/1594t4+kLzYWC
   PgknU2a6SZat2wLdWQ+SiNLL5os738xEi25gXS1+lt7J06Pqa0lab5G5D
   ndw94xKEQySeISggH7Mfcg2veH4otI8uPChyZvYVNO2LMFTk/gRoM626M
   Q==;
IronPort-SDR: QxUzXNWJRnrPDrU6Qa8fPqpFpxrmhnGv8SZrAw/piMlNhSNzDBjIvArwnNKGaD2DerDiT+P4DH
 hEzKKztMOgYu+XxCLsCJH/NrDJ47cnXPu+fcEcVv32kY/Ih6Ltual0GBY7cKip0SOWvQaePiFD
 d1ZlINI716xF2achmCqf2MUyPyjTSoqTPYU4subx4fJC1z6HvBWdkY64O7x/A5tcj4Nczy4uHF
 CS6zJHeIhQSTKrYAzDLjOHkigpdDHPglmlt2OlefkS+QhHQ6RHqLPah6DzgUSb7tYe7b5//ijZ
 KXs=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="263497401"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:21:00 +0800
IronPort-SDR: 1xQQe7mQqWV1A44BD9I2B3dfdI5zcFJVsE+7u2RQCW5ZL0zWX9rWN7cyaB0R+zVasgKs0cfhtx
 IrVPpqz9+OhNWf2fMUELvRTJfi3yLj7XGe3TnU7+8UlYcUFFuecER8MW5XlyF9ROZHwvoX75pG
 GiOwVsrYqO7lRpH6vfQ2Zres08hdtEWuMqs7YxMOkvsFkq+lWgEw7qcZTzvQA6HGIClHlz1qEl
 B1hUqqLybGI4GRaPGCsq4casiHcCE9uQzDzS6s3Kj4xbeBALlcATbdQLoFv9+Vek43Wnh5EkVn
 y/eU+pqnPF88X2kuOacwY3tY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:50:00 -0800
IronPort-SDR: eyQcbbPL+QE6lR4V/WtfUglic+gwcpaSMs80dOnTDv4VmXGl6LWoRb6mk/guyFq9if3KfEA4Y7
 +tXG9BYvfbMPOgq037oqaHmEsxLw9V2PI5yErlrc6L+Mh7JJRASNpQxBfRv1jha4D9cZKuX2NR
 CEtpkb5dd411Mei9z3RfYAwX5MHsi5Vi8Lbnj8j8d6gvT1bJ8mcdu5dS6zyy6dputIXiXA8OjF
 EAX3KlQYEoDQohdZGm9+Ljm8wP8nr0e3RDoa13Z+INL4FM6854rdwUGB35CmhKO2Y25D1ePrlH
 8Ts=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:06:07 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Cc:     axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, bvanassche@acm.org,
        chaitanya.kulkarni@wdc.com, dongli.zhang@oracle.com, clm@fb.com,
        ira.weiny@intel.com, dsterba@suse.com, ebiggers@kernel.org,
        hch@infradead.org, dave.hansen@intel.com
Subject: [RFC PATCH 8/8] f2fs: use memcpy_to_page() in pagecache_write()
Date:   Sun,  7 Feb 2021 11:04:25 -0800
Message-Id: <20210207190425.38107-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/f2fs/verity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 44e057bdc416..ca019685a944 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -79,7 +79,6 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
 		void *fsdata;
-		void *addr;
 		int res;
 
 		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
@@ -87,9 +86,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		if (res)
 			return res;
 
-		addr = kmap_atomic(page);
-		memcpy(addr + offset_in_page(pos), buf, n);
-		kunmap_atomic(addr);
+		memcpy_to_page(page, offset_in_page(pos) buf, n);
 
 		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
 					  page, fsdata);
-- 
2.22.1

