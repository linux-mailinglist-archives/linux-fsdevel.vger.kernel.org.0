Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A66D71A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfJOI7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 04:59:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39741 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfJOI7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571129947; x=1602665947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ABJ/rSB7KNqHg+mL12hjg8Dv/xkM6l7ADv2N2ztBvs=;
  b=hT/WaXIScfqZB8cEQb/QhDvF6tV1Am1Lf/hMiMboYFohIobJ0Z68gtfC
   0MQeFVSk6bjo0KeSP6WRyHiSIaC0yFR0hN4laTlFp8j1E20vkWvzaaPzf
   +Y7258UdTZmD/mpc2FmZrWUQXjnowUs6Ee9cJHzt7L5drMEgXnlgwrJFG
   GUwlnry1Nz8ZHuznBWtGEPuKXK5jjoER7W4/g0vxPllhUhj9XV5eUJpCZ
   GkW5f+qGDPZQHSQGHpbmuSSBPoQC1LiW85hC6BKMB8Jxf/qAlwa8JFIIb
   xObjv9oqKFoZFUVCb2PjLErTYziZT3d14atAXGInwFf2D7j+a7NXY0h7b
   Q==;
IronPort-SDR: HF8WYaNlPNtkAq1AdczAi5XRDxEL/I47k21y5sjvLDN/mM6ZrBpcMyzWLrcAD1K2qxEZEDnVPi
 Uuh9Mvvc+mfrdIAfZnZtB/KdWMpYhCDejz2wcFQ5F8Pm3D5SUk7ydUzhfMeTMSNN6kQxZO7g0/
 VYLxzgSV71Z5rgrCGkKi+yHhyBU6ieWdHoeEtsrxPRNiewUmr2CZl3oV2vFaBA5jNardwknw/c
 SH+gPwZQv6cVki56dn1CUUPuVvInv608xCiRUM8ZMiF5rhPvvT0BYLpqkltMu5K694qRuqZQzz
 skk=
X-IronPort-AV: E=Sophos;i="5.67,298,1566835200"; 
   d="scan'208";a="120567432"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2019 16:59:07 +0800
IronPort-SDR: o8PluVUshqPgluITN7aSOthGG+iwObtTzYauw4JVRc3GGa5mFCaPAfxg+iDGKUL4SZQ8beAYza
 sqOjLHV/rjQAQCp5p5DUq4uPjMjhsOQ8pwBfkhjaYBJi9WrKrzwLnbXdevF6AQJlpsZkpAaeYC
 Awv7rjdbXQNN286RfckeclVNd+E+Bn6VRT6Y80kwKOu/xbJ748D9GA0REbkpOjCeErorwTIv2o
 ECV1iZP4RYVnGPGRDVc4e84BXv1Fp6ePolYQO+aX14m3MvUZ0oRuWCD2m7WJfPodY/ld0NtnDJ
 qkJ6IeNz1IMKqsRB7QeFCDn3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 01:54:56 -0700
IronPort-SDR: ++tfugDXIq0n1EdYbqNhqnw0Z+6CedmpSMgWCqEaZZh3BpgtC9AWvj8ZQGjDhErmoDkhhyoO5P
 1b9ODiPVdx8k23KHhAgavN6NG745eLYYSMTwfmLlzOX3QWRASJzUEjhz5zXyYOlKIaOF2VaMrr
 l4RoP0S+/kzzYMeVpM+SXmth4DL3NFXPyszAh/gVWeC6W4f4gCGHSoguqaUBileHpbau0/6Kpe
 SbIv9bZHw7NbAcP8d7ssSEurSVQ2lfnrIjE/+3ivFU2FYr1Ve9igU0ztkywEApYykeptduSuTs
 G/U=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2019 01:59:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] mm, swap: disallow swapon() on zoned block devices
Date:   Tue, 15 Oct 2019 17:58:14 +0900
Message-Id: <20191015085814.637837-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015043827.160444-1-naohiro.aota@wdc.com>
References: <20191015043827.160444-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A zoned block device consists of a number of zones. Zones are either
conventional and accepting random writes or sequential and requiring that
writes be issued in LBA order from each zone write pointer position. For
the write restriction, zoned block devices are not suitable for a swap
device. Disallow swapon on them.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
v2: add comments according to Christoph's feedback, reformat chengelog.
---
 mm/swapfile.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index dab43523afdd..f2c4224d1f8a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2887,6 +2887,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 		error = set_blocksize(p->bdev, PAGE_SIZE);
 		if (error < 0)
 			return error;
+		/*
+		 * Zoned block device contains zones that have
+		 * sequential write only restriction. For the restriction,
+		 * zoned block devices are not suitable for a swap device.
+		 * Disallow them here.
+		 */
+		if (blk_queue_is_zoned(p->bdev->bd_queue))
+			return -EINVAL;
 		p->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
 		p->bdev = inode->i_sb->s_bdev;
-- 
2.23.0

