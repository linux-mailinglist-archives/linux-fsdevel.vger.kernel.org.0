Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F69019143D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgCXPZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgCXPZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063506; x=1616599506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EvmkpZ0dKDsiRcbVAy5MDx85HPrJ0hxuLDJvq95gdds=;
  b=es/A+tgP0pNEyvrHONXVpKy7v3T9UBpnUWKrOHwE+xq9pkJBQHxYIJIc
   1Ge5zXeI4YvRQCU5fGHXhNkdMIxCgobQQ89hWeBI7rnSstHpIYPexJHop
   ilqDv4ZPuxMtId6iNk2Fi5xyxBUS9yeSzMga20NhfV/u65mDJrj5h77Jn
   TCK7QdqQov4HFvHpf5hPf0mNudvd8di+2C2ptY0JiWttzE34OZbT/D28C
   G5vXZe5Io8VSutrthSS225PBr2hy4CmQit9h6aFVJIikVWeMurdWxM5Zh
   Vvudwm+u+QOGcvxYoIk8uJwWi9ZbiLU48sCgwIeZRAkJVQqQ67zYi2XVe
   A==;
IronPort-SDR: z/IBjiCItNrYYHJUxqGD+tESSW9oyzd0KgdfBgwJtp5X+ccHHWLizhGLVE8oulftrRi2uwBkYg
 wlpNFOe8/RPQ98XqxCbLsYY/CoyHCR/5/fghb0VyLN6YlQcNW3G7CxWcCAwibZO/1bOVtECexy
 jOIMSkeNCFqKwSh/OziVLQna6aYgEygjUzhYUk/k7YbcPDt5fPGNHyo6+n1aRNz6CfM2L05Uwu
 7KXRvFUWSnuqtaErqdVnh22bkzSq8GpYpjugeWs4EIwlISjUdrPEVgzIqnDNnwP1YiQzSYuxVv
 bus=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371555"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:05 +0800
IronPort-SDR: zvw+w/j1sDF+TdpxXMV8qfBammf/0HuT8S2kWP+QI4/CJ0RfP9TI2bF5WjzFvFH+9gH04iSHfl
 VlB8zcwDgaeglmTOH+5RH3DTTIvwCdtw2tL1XKGjnD770Ixhs7ELFRuZUlVOAqYnVYGRabGs9U
 /wTL59g/KQYveztYFYn4zDbsns0XbYo0LkmThaFpGSU0AuZI29GAvbQybCmjAFilvO6voI/5to
 gqGnTE47WPWUfhbmYzQYRGsr/goTfLrK0Q8bZd4k5UiN5IucoDSb++kYcwHmKZ6gUSoIL+ggnR
 Ipn0HBKnKRdaiXpm7vmEDmWa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:45 -0700
IronPort-SDR: nqkn4GmcL7VW2al1a2jJaF346nEWfw1h91FkqXz3Obumt6UK4BbkIsPLK3/zDwza8lrG63GubK
 VUpXLJUDEkF1pdDPHUI255bSq3s4esNTlF6BmGvCrB2GpojI8ipVBqM8x+m5wtTH+Wn5smQVNj
 k72gq7GVNEgSjxqmXdMgxTn3xzkxJJ0XVcnDeIJg000KiMwl5EpcZ0JRG35xYFpi14K/mvQ160
 qt5y3RcrlfOvJYjXsqnGXYvjUwyyMf1EIR2uv6knsbS8jkkSJd338jrm2u4lwPd1I3uLoeugOA
 ako=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 02/11] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Wed, 25 Mar 2020 00:24:45 +0900
Message-Id: <20200324152454.4954-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blk_queue_zone_is_seq() and blk_queue_zone_no() have not been called with
CONFIG_BLK_DEV_ZONED disabled until now.

The introduction of REQ_OP_ZONE_APPEND will change this, so we need to
provide noop fallbacks for the !CONFIG_BLK_DEV_ZONED case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f629d40c645c..25b63f714619 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -729,6 +729,16 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 {
 	return 0;
 }
+static inline bool blk_queue_zone_is_seq(struct request_queue *q,
+					 sector_t sector)
+{
+	return false;
+}
+static inline unsigned int blk_queue_zone_no(struct request_queue *q,
+					     sector_t sector)
+{
+	return 0;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 static inline bool rq_is_sync(struct request *rq)
-- 
2.24.1

