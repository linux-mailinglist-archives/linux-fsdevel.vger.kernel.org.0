Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9038B191456
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgCXPZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39918 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgCXPZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063523; x=1616599523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTqS72FG2poimYVMP6gAUybV97UDe9Ks0Wcf5ugxdUU=;
  b=fjoAv1Ny9o/OcQGtf8lVcmuBOtYzTjyFXwmd4wScGoJYIo6pvIjGiOJl
   NkJL6I1ZIAbsdbYYxI1GpDCDVrKN++cEZdDgO4CnUjJugjF3yuI7XiJp1
   6SBxWxlrGgxJaaJsGDJjT7SgGYiggXaxIcJMRcB0Q4bXEG8HrAl9HgTFu
   jrIkg0jzIqOWTDO5TpdzF/fhrvFTa2OJFrpQbx1cPQ0MWGS7zdPhoSMTj
   gFRe4JweofVPmkeTKu5ihQUYE+Ol0C9pkVsxSk3r4wOYC+w6n9hFhIy5i
   223nS/5WOEc2nkizWx6sJkvECrc/Q323SayyxB4tD5Qzg2iXxUsEEtxu6
   A==;
IronPort-SDR: bSK6L61rEzeHmsOjCE0dmDRVFyisQQNFel8v9UX7bkjk4MgDdMRzlb/nwqQbiyhW0Kc3RK/vCd
 zrAPnNtPaJVAQxVznosiu/tQFHKFuDIH1E1lNi5Wpaw+pYp0YtXVnr6YsAzwg4CPYurFrWSs1L
 VU0WGIIZW18TUR5wTWL0QKXUl3RkMpTVeXS1AvCnpEM4a10Retd7f9YnGW81IBy4wyxPVo6NX3
 qbmireWJ7eTK0XIFSNDXjz5GoHtJA/mpKMDEgRtci9YyN5Nwiw1aRQnt+8anlm7WuSuBIAZWsS
 bHg=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371583"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:23 +0800
IronPort-SDR: X1o71N4n80ftIgsch9VLDSX6aKV3D9K6l+2gekEua9LVrwqUxXOn+aoYGywDkTlf1A/zbKdvX+
 dWYkOOgnDGMVqzav0KepMOsTidZLrw7ckl/CBmpYqa3+6Zqf1gTTBpCQg3bsqAkxZa1O0v2vyV
 EBJdKwmX67XUcXA/mgacNpcVTIpCUQw3TbOeM9Xa0BVvf/5n+Hoq+cKEB/pHKDaEYKiS/ICgWD
 awCUrPaA2BeQYseICs2ivIKmMtti4uOWHgYugcyKNMiMxy0T86ROwhCPABBdtI8kx3HpNguV+m
 2ACHAPUd6xBYOoiSyvTBWTNF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:17:02 -0700
IronPort-SDR: sD4BI3QHBKZZN62acfiUB0ZP1phm3rdJgPzLOJzFeCW5gQKPLTdd/CntC1CoH+V3MdcJqA9TUN
 CWJFbiQcI5Cvl6AYn3t7pCAzKAvTk8sQEVan6LvpGwOSQTR15xBhMhony6keZHMUBHqXncBYKP
 z3beFUJo+hEaXKWUGA70rvlWNYyvVPFWEIiOpT6MQCI3UkpttHWj/ZWTrd2It6gE8epVXVx6gQ
 ntwa0j7hlZG5UGhcsdPEsDhH0WsgiNpkDEWXl5H4b5llMvv+nttOyxn6OoHIAr6wMHB5umA4UH
 S1Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:21 -0700
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
Subject: [PATCH v2 11/11] zonefs: use zone-append for sequential zones
Date:   Wed, 25 Mar 2020 00:24:54 +0900
Message-Id: <20200324152454.4954-12-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 69aee3dfb660..d08d715c99de 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -628,12 +628,17 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		goto inode_unlock;
 	}
 
-	/* Enforce sequential writes (append only) in sequential zones */
 	mutex_lock(&zi->i_truncate_mutex);
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && iocb->ki_pos != zi->i_wpoffset) {
-		mutex_unlock(&zi->i_truncate_mutex);
-		ret = -EINVAL;
-		goto inode_unlock;
+	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
+		/* Enforce sequential writes (append only) */
+		if (iocb->ki_pos != zi->i_wpoffset) {
+			mutex_unlock(&zi->i_truncate_mutex);
+			ret = -EINVAL;
+			goto inode_unlock;
+		}
+		/* Use zone append for sync write */
+		if (is_sync_kiocb(iocb))
+			iocb->ki_flags |= IOCB_ZONE_APPEND;
 	}
 	mutex_unlock(&zi->i_truncate_mutex);
 
-- 
2.24.1

