Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC29D6E4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 06:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfJOEio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 00:38:44 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44625 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfJOEin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 00:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571114323; x=1602650323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gDSqX501OhSu6g48JSoPoR2a3uxDz2ElT9166R/rHPM=;
  b=TupAv1AppP4g4jbKNX5hPK44eVhbOUB9joUXOs3Ec443vcevqdnIsK08
   nKalDhULf8/mAMh5+T8xq19I5qYAer4zct8q3OuV9BkowfJ3LNRQiND68
   iasflBc66UmHL2wRZhjEwBLxNWZkC39v6KVJdyiZThmQdvLisUtVGOonT
   drlvS/ijgzBhvDP8/5NDJBqhvh41bR2WSGdFp3ounN45N7UaGId5JoHUI
   2jGK7PKraC5OMT5y/RrgDVXQz39rMEt8wwvJ9VgcxGojsnn7vKeDOc8LC
   23VxRha9+aemc7vB1NuZYkyXeTLPbWt3ig46CfqanG0a352TqS2m/KT6y
   w==;
IronPort-SDR: GB9Ss6WaVoyV5R6AEkXHhFBrgaGzYnn7xkVGDRakccL2z9cOU6JYDeqszQ9A2OOcG3rkg5gdII
 RGhFQRi6JO2P5ehpfDqwhaCxI6PvsC9gUYCtoMkXYXbI5xRAyS4/X5+U95cUlYU7Z+xEKzQ71d
 Y4UWVMuY+DdXIrJAz+9lcxKidIQ/DlHhXJiRhn60ZL8r0BCTpiX6/b9+HAIpD2S+tfNz3MfTT1
 BpaBpXiVrxd2NEXN2sdxuuds+nhWSlPzK7bvKwsh4Yu8CZcu3mqdi5PMVL77J/R0OjBR8OdMJE
 al8=
X-IronPort-AV: E=Sophos;i="5.67,297,1566835200"; 
   d="scan'208";a="227591551"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2019 12:38:30 +0800
IronPort-SDR: v25K94eaE3Rd4J97m6O1BmcjkFLwrUU3qvVpKFBaLk0Zz2rr0jfX/BSiMe4DV3twA+oZkXzcsX
 LT0GeI2ITnaIRBX9IUS2gxkYnKdNpxhNaaNxrlPp7Hl1W5T8bComaG7M3R70ULDhuxNqpF/s+5
 tt3auNf2W6F2x09uvXB5QAAmVnRBsED1/UCA6oyqh/qTBKBYVHfw+QZ9s2XnX1cLKYQ9c/pw4L
 8Aff4rIwUz7WpEH7fSBeO5iWq7kGeFi1hovMVlUl9hcM1QtWtK8oBGrOC4VIG0F/wmtQvSy4Zi
 o95TgIiRo4HBYgFchj9PrE6H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 21:34:20 -0700
IronPort-SDR: UPN8Ssg25fhiIzxy+9ii1rkN3BxsQUiAyhRmmcuvGmruxDrp84oOI6HkHNrtP0frtOOQCxWhqH
 qPclCmfow5hbTFflQLX18xFlwbzGPK2sFrjQcs2oED2DR4ymAdbcTUZOXcwNsQtWgS7NgVmE1D
 x7EfqdKqTQI4ckLOlHqV7IgUgZ34UrjXyH++Ln5yugT/cdnHnjULcwQ3GcnUiZszFmJCxqbEJX
 b7WLFdSV5m/VYTjmHYkzBBD33WDn1oJcB4XiBN9GHM8GR18uQuM+D3gIu1F6ZPanAYHRw4OhIU
 9EE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Oct 2019 21:38:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] mm, swap: disallow swapon() on zoned block devices
Date:   Tue, 15 Oct 2019 13:38:27 +0900
Message-Id: <20191015043827.160444-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A zoned block device consists of a number of zones. Zones are
eitherconventional and accepting random writes or sequential and
requiringthat writes be issued in LBA order from each zone write
pointerposition. For the write restriction, zoned block devices are
notsuitable for a swap device. Disallow swapon on them.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mm/swapfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index dab43523afdd..a9da20739017 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2887,6 +2887,8 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 		error = set_blocksize(p->bdev, PAGE_SIZE);
 		if (error < 0)
 			return error;
+		if (blk_queue_is_zoned(p->bdev->bd_queue))
+			return -EINVAL;
 		p->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
 		p->bdev = inode->i_sb->s_bdev;
-- 
2.23.0

