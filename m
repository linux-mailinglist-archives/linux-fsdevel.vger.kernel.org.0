Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0031B64D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 10:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBOJR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 04:17:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21198 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhBOJR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613380675; x=1644916675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7y2izleM35CFVNGAxGJJlXECouLNTefd9rurtUGcNfs=;
  b=qedxiS1Wo3+Ob9Rhl2hViX+SlV24hxUpbw8nehUf+wcv5SvuKHEvKeMx
   /9pEuWCs6zc7fQ6i8rjl4TOuOycQizmnADwf9TqlNSer4mPVaAqXGUexo
   rEb2EnPVCacoQx781OreRHCjKmWxrXDnv/wj9p+sB0gDT7WmFz4CtakPz
   D8GXhEqhHbCJQr97Ulqy/JijOckiWUC+st9k3rm9F5pdnoJMGJLEZ7m4S
   T078v3n4B1gPERjoklb+6NWPRkhsRYk8+FpLkUrSR8iff10u/GWiq0qP5
   wPJq5DpcbrvDq6R3jqegrmotECr3j7plp93g/ciuYy+Q9DoIhK9kiFqvN
   A==;
IronPort-SDR: hX9h9Aqiv3T/YCsNHOoTW77JKtZOSYmK6MkWqlFrI+xvmM/AjJD8iPhk3WHx+djuX7KsXGvWM4
 CWFZ1R/YwYw5tEo+EylcBR8GvVSpms+XueFDkNxJwRR3x9Er2g8xJM0jO60kQLAgNGh051zfn+
 /xpaTDYjAqzB0o1oVZ1EKiCz4itv3SBY4QrcC4THAEA7FYfAwu96RgpctCADvvXR/KDm/Cr1Lc
 SjL2a7NrnSDfPX58NUTXS5YVTEUkSfIxUsqu37x04GS4EzWtBgU2XJIXs+Tism9JXTQgY004cw
 i/8=
X-IronPort-AV: E=Sophos;i="5.81,180,1610380800"; 
   d="scan'208";a="161147454"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2021 17:16:49 +0800
IronPort-SDR: u3leuAvi9+5u0qvVPIlKPNY8qhjOe8isojVYfqf+Fxi90K+R/9tNEVglfVNfsgRGCsDQp1EQWb
 X/rLUiJbYo1CAXBq0Mnh5CVyJtbH7UcXKdSWsDbAUbpFHFUweeFPk4HOuIEPQz3JUoNUNnIjXY
 lGWY5oKf7ce7wq8DGK6caXnMyq5xWns6Mw0woJfrksWttsOpsDPpfEgvf1FR+Nl2oa/KWIEGM0
 veYBFoPXeqR65IeCGttnXMPqwveKshnhRhPyuuNOxSEvne2iXZf5zsNRqBHGqRvJ609NqHqAvL
 M4nivQQnArzQZ7i75f6QZGKR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 00:58:35 -0800
IronPort-SDR: Xfk652Gu7fYrrfKok81posvgiNNP+uHIfwSkGnw9cQQ3ftG4ugTNJBUsYfZUN9Mj/HSPLYaB7q
 uA1SKm6HOD0HP+1Yec836PcgmJiIXz2+cm7L0BwYxrxBVZbh9uPp9LwxV3rT1OfTETXQ8F9qn6
 Im702yVKDbprvB3FQFf/KA17eVrpTR7BI8m3W4+ka/ZFUH5Uz/VGsSIlZhWKqrGdmYrwDy3eIL
 AS8+3LgLNhNNlqvj+Sc53MHZu/j7fxMi4BEdmY9KQ4WB+fKV7x+0S7HDcdruCAOLkKn2BnJGzj
 FVo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Feb 2021 01:16:49 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] zonefs: fix build warning for s390 in tracepoints
Date:   Mon, 15 Feb 2021 18:16:29 +0900
Message-Id: <d3378bec918aab6090def490784fb0de5a336388.1613380577.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

s390 (and alpha) define __kernel_ino_t and thus ino_t as unsigned int
instead of unsigned long like the other architectures do.

Zonefs' tracepoints use the %lu format specifier for unsigned long
generating a build warning. So cast inode numbers to (unsigned long) when
printing to get rid of the build warning, like other filesystems do as well.

Fixes: 6716b125b339 ("zonefs: add tracepoints for file operations")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/trace.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
index 26b9370a9235..f369d7d50303 100644
--- a/fs/zonefs/trace.h
+++ b/fs/zonefs/trace.h
@@ -38,7 +38,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
 				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
 	    ),
 	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
-		      show_dev(__entry->dev), __entry->ino,
+		      show_dev(__entry->dev), (unsigned long)__entry->ino,
 		      blk_op_str(__entry->op), __entry->sector,
 		      __entry->nr_sectors
 	    )
@@ -64,8 +64,9 @@ TRACE_EVENT(zonefs_file_dio_append,
 			   __entry->ret = ret;
 	    ),
 	    TP_printk("bdev=(%d, %d), ino=%lu, sector=%llu, size=%zu, wpoffset=%llu, ret=%zu",
-		      show_dev(__entry->dev), __entry->ino, __entry->sector,
-		      __entry->size, __entry->wpoffset, __entry->ret
+		      show_dev(__entry->dev), (unsigned long)__entry->ino,
+		      __entry->sector, __entry->size, __entry->wpoffset,
+		      __entry->ret
 	    )
 );
 
@@ -87,8 +88,8 @@ TRACE_EVENT(zonefs_iomap_begin,
 			   __entry->length = iomap->length;
 	    ),
 	    TP_printk("bdev=(%d,%d), ino=%lu, addr=%llu, offset=%llu, length=%llu",
-		      show_dev(__entry->dev), __entry->ino, __entry->addr,
-		      __entry->offset, __entry->length
+		      show_dev(__entry->dev), (unsigned long)__entry->ino,
+		      __entry->addr, __entry->offset, __entry->length
 	    )
 );
 
-- 
2.26.2

