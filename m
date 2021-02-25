Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE19C324B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhBYHLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:11:20 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50748 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhBYHIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236936; x=1645772936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cJQvU0rRFxDr7whJauE5NqjCq8pb+jrxymeltC/I/EM=;
  b=p0yvmUKB29zcJ8n8XK8opHBvEN+wAUjUAm1pwOfNPCR6ro1i5NKorR9u
   xjyO5Vkfjn9jpakvZeQxovmflb4i3/DompdLDJq8aVsu7+qlgsTdXTinl
   CEJ5Me5QTie2cwX3KR6iU9jBYrTjmhTtRGdnOKBiWXzKFzlpcQaF44a2x
   zWYgaAQevnuORtfDq2g9T7At1v1EHHAuQLKV2xAm4JtkEEqfO7iC63Ksw
   L2GYv8EvoGlYveM2mgxwwbnM/TYwKr+gU07zrpp4GzBrQLDYGAalMrKAH
   J78GaV34EV3EsL4OqMkBxdhekfbhdkGjYyYTh3fEkqXch/2nX5SGvWagq
   w==;
IronPort-SDR: sWtl5nE+GbJJODQCE6oW3F8NQ2OmeWzffAusN6pMVSoSUYl9q6Wip5kGndsIMnji5jniup1g+7
 cO61581qHu+AMctAuzfedol/5YODrdUWSP0hvL6YPrJar2J54ihXk2JtgAG3Cs9ttzN6zEHcOo
 g8Ldq6lfg1kq0JIo7l3ldoloJe1Zug95BKKxdJ7hFSO72v7JWSvWsq/E0pwpZ1L974h6DFG3BP
 aKbY8nM+niqfmrXfXg/245bfUFR/ZGAilD049/KmhAHQFoU+vzY956BbAQMpLfdvIxuYlP8E96
 cKQ=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="161931681"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:47 +0800
IronPort-SDR: Uz9WINJxeRxXr1CSYmHMx+9pPkkikVTLcnyGqSlUcc4JAZZoZQ7zfBbTjz+0SVCrmKEL4109gc
 345osgHqL9EEyDp7u5e8Aamrf6ttDR1VHQN26jfFgLSdu6O3VlKnra50IrQ/gFna2F0GTL0jmN
 /tDkOQR5WtL9EgzzRYqryvFMtPJp62BCTHcCPQMz/WmoZbYhp2orhCf9wsaUBG09cTeGiEcWwL
 3MTYazelKkTjb2omZWJHXPq6DJry9RZst49NYvtY3RPaIs4chQFfcBK90U4CRtNd75YGLDLntd
 gtLinU5A6DPDl1XC42uU6sjF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:49:08 -0800
IronPort-SDR: 1Ai/00Lm2cIyeyrSTjldjAq0K/s6INxGPiOcn+Ipc9i/4uq4e+yBU6GBdKWHv6+F7KSEF646yX
 NjFdYYumwkHZYhnsg3aqsZrX133zslPqldO6zMJCTyx8/JSod8KGZmpaZCDROA3TpXi+8JDDAZ
 rfxvV+W3/qoKQA7y59W9tjzMEpDWRJFnnLls3mM8wbbGo7Nfv1I9TNUFpAj37w/Dtf5PVuAExn
 sfmEZCoPMN3njd5YnCHgiHJ1g9F/mby4pJ9/67Tw1E6jBSF35lk5/J5/ajJCe8V7eJ5+zAuf1q
 rBI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:46 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 37/39] blktrace: update blk_fill_rwbs() with new requests
Date:   Wed, 24 Feb 2021 23:02:29 -0800
Message-Id: <20210225070231.21136-38-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6759ac7bc6c7..32100c5db7a6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -3184,6 +3184,35 @@ void blk_fill_rwbs(char *rwbs, unsigned int op)
 	case REQ_OP_READ:
 		rwbs[i++] = 'R';
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
+		break;
+	case REQ_OP_ZONE_RESET:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+		break;
+	case REQ_OP_ZONE_APPEND:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+		break;
+	case REQ_OP_ZONE_OPEN:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+		break;
+	case REQ_OP_ZONE_FINISH:
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+		break;
 	default:
 		rwbs[i++] = 'N';
 	}
-- 
2.22.1

