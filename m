Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3111247B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLDIUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:12 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfLDIUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447611; x=1606983611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wM+B0/NBtyNeSYyvcUDDv5lBZhJIyM6EuqhnCymFNz0=;
  b=qTfIzgOJycYF412m5Bj7I+bcezpNF7JnuhkpRII0IiZjteSTcHkvefnz
   eh6AuaQkjxnv2HG+iKSQ9/8hMHMxsN123RXpbBDhcb7bxZTTxV6FcpIX5
   rIhKWV8jP2cQJ4hJI9FbIfScUAg80J9G10qd1xd/Ienr7ErRT7XYQjnlw
   FE1hiVX34L98G5fdj+Dvik0ZcWMvmCaWeNEDqlBe7Iemi5kOafkwHFCLh
   4AR+MMHoAGEXNbhZ1i7ukBPwywE9hKaJ1TNitBrVPGbWOZ/7o2WLYcLbn
   xMOB3h8/3I2GaMvG/SuLqOWuvmTzt/islfdHqmt8hLoh5jdrlQA+h7YSg
   A==;
IronPort-SDR: vtJA/w1y61P6Okiu82SPlXf8uyRzZ6JZG8MqHVft4Sa1os781CVjBUPpHK0VoNOb/WSreQ3KP4
 n1pCYIw7gCHcGyczsa2C/gVFzEitHLAqlvWTTMG+Hc5QiLl2cJ8CagZJZd1HSM7K15BsEG4teK
 7hub+u4Y3tt1WPV3WXhY63p//TkMgRybKNzcCODT8tHi2Nl0gYuOn6Y8sMWE9cI2dyrMqBm7aK
 SaBakj8L8ItSXFIIdLvXRFbh+YctPU3TeCV+wPLwj/H68bbrWi89wYRy1Zc3NKb6Z65dfo2qIn
 Ues=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355106"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:11 +0800
IronPort-SDR: IpDogbzwwAyKWAZMxcqnRI3WN+ks5hs7yyryhdKNu/weClGSMG7XyCQA9X4+rbtJH0DMnEQ7dB
 2YjLMerYw46eFaf5p0V2C/Q2HhNeNRxdC5uSn8h9K0LQQowjGirv+6IbKGA/8ldWUMDjaMjU7Y
 kQE4JopzAC+AaMm7swrRAo+Q0SNWMsJZNO+wipmIVOQAyNs1xYdUtcmXZk4YYBvKK7eIgg/YpR
 wu6BG2P7pHYhU6uHD8zX4B8MAQsPVmh4qsk5+sB12ZPKlwTHRdMZnpTzKUCWPSYNhdEdsGiRu3
 +/KjzbuGF6A0qo4gUYaR5mjZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:36 -0800
IronPort-SDR: 7l5s7htt58Vmo8tVXvKjG+T6+hNLlLCZmv0Ppavy70bI2Cqc6HcCXzIhw9OO6HITjaEPFlysll
 T1cdCPc7pjrGKyJFsX2O/chncZP5xKB9wg5boyi65su9n3p2sJbJn6eHBbDbk+LqNEyCvUubjS
 BCz3GHZbHaqSziiCnUi2s81G5Bbpl8p12g2Kvy+J8WtAXElmPXFiRfREnwqA1EPtqRd02fF1s+
 ICg67AVpcsLf/RuuSLdFY8otRTghMNB1JRiSiikusHdd64iIvRX//Qzu/kiz7Ymq+wSkdL0UHm
 iy0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:08 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 21/28] btrfs: disallow mixed-bg in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:28 +0900
Message-Id: <20191204081735.852438-22-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Placing both data and metadata in a block group is impossible in HMZONED
mode. For data, we can allocate a space for it and write it immediately
after the allocation. For metadata, however, we cannot do so, because the
logical addresses are recorded in other metadata buffers to build up the
trees. As a result, a data buffer can be placed after a metadata buffer,
which is not written yet. Writing out the data buffer will break the
sequential write rule.

This commit check and disallow MIXED_BG with HMZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index ee9d9cd54664..1fdc5946715a 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -311,6 +311,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info,
+			  "HMZONED mode is not allowed for mixed block groups");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
 out:
-- 
2.24.0

