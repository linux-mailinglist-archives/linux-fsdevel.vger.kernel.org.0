Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8084385E5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfHHJb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbfHHJb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256688; x=1596792688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AA0KI5TsQFQQlLW6JYAZLzzTfRAsTn7wEog+IoFrg74=;
  b=crvKlaHZKHdAuLNS0Ud4BwbnXCJBnAWyYeoUrS52v2BYVjrA+FUHRqCG
   AIHBb3LWt9RKQdktKnpLg/fm8rsdMhVqAofsHtly8I8PsLxmD/+JhI6/5
   J5iMl97vPBPLlvlyyrLggZsD3vLkmCz7Ab4YP/tRWeY94EzQagk5FyJkX
   Po89Ml4T1YCINRC98Oy92HRqOcqMSM8vy0YVtnv2xyDYFbqIdZYM65QYv
   dGCWECmJ51CCOtPfl6Cvl0OLdprs0cF+5pr/MwDp6XHT0368U7/KuhExF
   ZHfW04LNbJNY7euRPjSlrmdOG3KSTOAeZrd0xYnApmAqmYv8obgkBUwLS
   g==;
IronPort-SDR: OP0FrxcFRb7oliVXwM+ooOGpWK3J2Vv5hsI/aNhEUocg/hhB6d3rWEci2IAX1xk3qGxDHpkdmz
 T0SXvfnaxoGyN5InkIUQsOmD3VVn1NgXkSU/yyNFyG6WUCnUd3yKJniOXMXf3ISiOxybUQngkc
 9Bz9HUeFhJc/Ta0537Y6BvdiCndRuroZ2FbrFllM0K7GkhvHAox+KwIZK14hX6Vsl2FhY57pDU
 UlijDx3LxD02TXX5v6mOF2YE9pHZe+s0kLbn0txwLKoeHiLaU9U1+3855uV45GDD5KhemREc9c
 7SI=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363348"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:28 +0800
IronPort-SDR: vQtCN8u7nejT51066FuWpsGhzx02jefAp1cc2jlEwuEY/lVtbqivs8AdW3Nkbi2AvUIIx8O4fS
 M8HMSXm8bIr2VsbtYcSbPnMoNO4B1OcCOCfw9DL52LTyWNYPtrWdqixMd0nIswrcPpmjBAN0Nj
 IsT/Uv2RZhZVtX4/mst/60qdwXP2imwU7mQRQZk+LlL0JQYO4fLnqf6aRyD4KMd1YKBjJKjzyX
 Dx1R3L+KCyh+ELpKo1oukCoxd0E6+PUVm/IlGDov4kNQsZEW0vCFKeBBTE1xmFIq+7GCy/RAlA
 OrZuoeVjz6Z9LBggb/TztNvN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:12 -0700
IronPort-SDR: u0Cd2mGjZ2NzYaHzuzY7uu2z8ynBKWMSIRSg3UehRLv1YSGj5INVymfD0UFEQEedB7duxlVocv
 jf12XPiu1f0+aQmRg/rz49qNaWjmyBerOcvGvsJxX0JEUKjxjEplQR1bKbBPKc7KWebJ/Kttrn
 RR+rujgQ7Eki26OE/l/ESXarVRN/PJWfaKdfMs4giTirj+6Vn7MuPyIcolkwnLsdrUthz/3AIL
 5lKQBu/VmmvHWrX1qLRQhdZEnQ3oRDhkHoEy0fnlHQIW9tIsIPxeLtHR4tlS7rZrVXS7Gtg0gD
 yP0=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 08/27] btrfs: disable fallocate in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:19 +0900
Message-Id: <20190808093038.4163421-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in HMZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in
HMZONED mode by utilizing space_info->bytes_may_use or so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 58a18ed11546..7474010a997d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3023,6 +3023,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in HMZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.22.0

