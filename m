Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B9195B77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgC0QuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2564 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgC0QuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327819; x=1616863819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NchUkm7LiVI+SxmCSpPmzzlAW5apjiaxdbNPeI6W/yk=;
  b=JH5HDC7QNjRMpmS/YNJ+ZVxbyTW8B+1+RCxjyKzP4Df4Tv9pTFxvxge4
   5rb+EzQ6neuGT1Gm4nQuA6t0wZ2x3cmQeKKbk0LtCErq4qpgKLB+wgXYL
   CPuf05+O4/o8OctUwrBteUEqdVE87uYiGRQCPkJ7tlIi3oH7cWyGMqYiM
   tLg2sTZKC3LCT2iGQ6aGnkJYdB/AWGD+zfPl/5klcMfDPx45ga8h4EvGD
   dEcn3P9neOVv2IQO0brT+mw3JSQw/Ge3Rdf38/1xLFXPietrRseJ4V85/
   4okMPi/Ik48AdqAH1QQN0D09yhpTWE/zg9OQGuC4r9XDhxh7XmBHtsjf3
   g==;
IronPort-SDR: LBBNERc2MlTMeWR2ZNIjeZRckooVuFFKp/KQZ7FykBaPWs+JX2nlrWkcQtT0HkVH0ak3KHNRHr
 3l+otFF1jQth1/qRmy9yUkbc3L8wfgl9TsRSIAnZNI4WO7I3TWu/iUcqiBbh1S+Rb4L1EXV9uh
 XQNZPpnWbucvIiPOCZPnOZXwz2pUyyXDhPNFBcFm0+tGdIxNYvicTEEvw1134YY2z6klFSnH1J
 8QazSp1QHMEJ6h3rulqtQ+PzHOSeshlbAvPb51ZpNaa8Uj1kGvLT8o6TkrBjzRkJlfbmgFtT16
 Hu0=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210437"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:18 +0800
IronPort-SDR: wMWQfbTSmK5BRnEDqTrOuSo+nXMAkvH6Neyg8Oxqw87NaT0Ejv1w/tFcpN+XjTLG97oEC9hm9Q
 queMeLLpwJvYNR/TrRXIE05tPoJgmXLr0YY9uuYeBx48IX+Wbz+R7XapOF2qCJtF0M/sISHUkH
 KLdXzAFCSp23SFzzsTk78OeDcQ1Q5B0MS/YaHdk/1hwKHeQsAIi1XLzpfjfiUVpleSn2gExnSu
 I7EhBp6xcZt/SVD8Hk9MZFROUg/pqcHRggA9PTtQZTotDWm4sHjTZVDI+61uiAu4mAa9mTK/f+
 cpW3Y7L5qr+zSVINoIaX8cSw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:41:53 -0700
IronPort-SDR: PbzSbmgRNHkbiNSMXWYrU8ZaSXH3+bIIJzS9zjQ4OqoLxv0H99t95QttXTeA0hRa3bTmiJjlNH
 nCXmDQ0EUm/TehQhbyh61EzYd7rWbhLhPxJ+D5JrTj1GMG0r1djgbj/GwMCI1CF9Z8lRpVgfvM
 iEXNCS6bPK+q+YuwND8+rl3W4c5snEZKg9U4urEW+zWbuF0OcyGW+DBHylRaoTvr4gVwLzm/6Z
 zh/vQ3/mvNheNB5cngxEgRqkxPa6Bjx/gtUh+XzlbdmfJdIpHPzD6CQnIYzALMfCkQpceSSPKV
 4nQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:17 -0700
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
Subject: [PATCH v3 01/10] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Sat, 28 Mar 2020 01:50:03 +0900
Message-Id: <20200327165012.34443-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
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
index 53a1325efbc3..cda34e0f94d3 100644
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

