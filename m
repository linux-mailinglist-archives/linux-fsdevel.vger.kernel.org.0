Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76591324AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBYHKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:10:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4544 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhBYHIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236916; x=1645772916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMNdpWTlLEM3dM1FX5uUB+nf43YofWvX3hWgSz3vKQQ=;
  b=m4QL6RXSwpER+bs2UTWuEjjOzShmt4W1RjiJuKj1DukQ0ALyQVMS12r6
   Oq1/jGXn2zaieTAq3vUvQBTqJLHLufAGDoJBbqmzKzofy1FClxfHP76K5
   Ui5rM9gEglIUDXb87MRboa8mE2Tq4soirM6pEE4X0AnuCuq3ggFGqpEDq
   vkArKQiRmVrAvAJeHrF795sM54UvJVwO1S4KKpud+jI34qP4yVeKKNhPd
   Fw7Eh3jeAa8hhOUhP+gvTyp2KqIXbygCflqvtnWN8VpSM2CBLqDa8xegN
   WEpdqoKHebgm1znLWdEnvnjjRClEvLfKh+h5jOD4wArQ/jwnj5J3uCOxk
   Q==;
IronPort-SDR: rVsQeEgz8ow6a8m+LaKiCdM0D5wK5Z4/GjkCn2N2VbTJeUzQ6rhZn7KQWm8Ia0TX6BEnrclG+z
 nrAsuox7E3VbqqKnlY62765wYM7sweg7hZpGgrBcrzCJLWk7+VUYRszMwcnhNhZYLeBtcEzgPN
 Oa1AYGSkBytWaSg+6TaXvqjpnzo2oIlDELxAlnh8tTaOfLp+ThA6rnYugj2DSwT2FVJB6DlNJ/
 3maFJU4r8KMcc0pYm0nt6tpnkAJz7isULRVzmBF7JakDaJMbxh7+w4tHrMbHwUrJlMoF59K/L5
 ieU=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="271319267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:31 +0800
IronPort-SDR: dDyziYqBNpAZh1uVVAYJTDRXKnGFiW+ZWVCoa48v9rPZ9RHQCVckbRTnR7JH2keSZvQ+n+UFYv
 Pmjquil+Mb4rs6Veq9cI1iKKWghe8Omu+fUBk/66sGZ5KPH+wID07HM07vFwT7dHfAqIDy0RKp
 F6pZ8hPb9z0HqtYpwc5W0mnEfrOtI/8ZDu7NLjBhpEWboBMyvr1aljR8+QLkErfcbArKgZASSy
 akRGQ4vpuwdX8yLXz/boY3cBYA1psZgR7Kryn6r0MLZPIXyGwYxg8kG8wxRWTQ9JZ97qpDPrGY
 ENKbeaPcSoeyk/XXxa4hx4RR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:50:46 -0800
IronPort-SDR: Lg8JC040IaD4Bis3lI841Kfg7JXF+70Ehi6NqJwDicoXTGuOQCTtN6gBA5Ri/WEE9v3dCANpBA
 FG9UkQzlG0pkT+6LWRKzZEFi5wbICyRkSBUAXRMQ8z/Xo2I8ptl3L58ra5IjPGUjEAJ6VgDMl7
 pKo6CQaS00ESCz9dcpp4NUPvgYPKMEcsDANqMW5gp4kXj+YzSQwvy+fikyU3opROXfDvZMcdAX
 Uq6hcXbHxk/erH+MNpclbvKri0dFOJPS1+nv1rUQsQ2W6xuVJjetFobHza83KNe/TjmwYNHPg/
 cxA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:31 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 35/39] block: update blkdev_ioctl with new trace ioctls
Date:   Wed, 24 Feb 2021 23:02:27 -0800
Message-Id: <20210225070231.21136-36-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add newly intoduce IOCTLs so that userspace tools can call them.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index ff241e663c01..9d5e742ce8be 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -509,6 +509,10 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
+	case BLKTRACESETUP_EXT:
+	case BLKTRACESTART_EXT:
+	case BLKTRACESTOP_EXT:
+	case BLKTRACETEARDOWN_EXT:
 		return blk_trace_ioctl(bdev, cmd, argp);
 	case IOC_PR_REGISTER:
 		return blkdev_pr_register(bdev, argp);
-- 
2.22.1

