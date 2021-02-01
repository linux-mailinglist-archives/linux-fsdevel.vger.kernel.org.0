Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002FF30A39B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhBAIxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 03:53:23 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59326 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhBAIxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612169601; x=1643705601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JH4g8QXC5N+LounA8q1jKJ7hA2hoBw530oLqRpmKiA0=;
  b=L/1VBoemcJi3qTItO7il8PhEo9dNrzIKTCGm60fTv5QwMrDiKj9zC0eZ
   yqosYD6ltvig+TBSVMTrZOdHxRReUpL15EzlfeUyg8YDU9yLA7/grnRG4
   MQKHUHit9QlIE47a0auf/NB3lB99gjimbR/bCORFU2javcqdnkQstfMF2
   kzOEWxy3YiZL/cdbZZdEfPXrUEhrZpghgqMhlqKFRqHoaCoA5JmNhcC0M
   teOqw/W1aXugNMOR/d5toVTQ5e4iYo00nVdCaVW5cHNpaBNYZUsGJQZXf
   hWNKPslqv25A4ZANgzx/hSHpMPJ/+X0uuBNGDZjh4f2n0XyxrzDd1+iUK
   w==;
IronPort-SDR: wgUWbMj+I6Zs9jCxydJIk8C1g0GupSDZOSLkuZYWridxyk7qsR8qSAya/FhG3IPyCUP95k3WtN
 302NwVjGLswt12oNbPRuVk+HKb09d65+bc0Fsv2VGJYQpKJcNxadvM9JwcQUuU8Mj7nUsHnit8
 fYr69jOQB7ee7I3WuUQrKMkvV82hx2OCLZWCpMCu4hCiRTbFNllaTWufogM3YaMek0M23OHdeQ
 YtLO5FObu/hYT+YEg/NXz0NVLO/mJnsJPS2hPtlAvoPFCq2/dYXyECrFsGnUjmFp95Z6NKPCjv
 06I=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; 
   d="scan'208";a="158797700"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 16:52:16 +0800
IronPort-SDR: ssyOYXFxRZcgAogUrR2z44LgUdmoXuJuIDXTpVHcD35eI76tQOVOYyzHnJwdOdKZsM/dnXTluK
 RFKIxKdr1veG8pQGIz9AQ+nI1JIKTHhlVgbaUzEaVatvV7BU7w1hx24tgkhBC2WDqo8rIvnSB5
 temZ5V2Io7DFuPTMixojQILyLKLinOKUpIy1G67RHj+A2eSPUFaOpbQxFCU/Dhp9nBuqfeKihf
 jZ03GB2M2H31L62pt2ql1ObvCb3xnAvOaEoTueoGkiTii8ZQrlyh0LtvOMThDfDoaRuOWNDQlA
 Vd6YlSyXF/8TVpvk/Z3N6etp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 00:36:26 -0800
IronPort-SDR: 8Rxi08S0tlHq5KwUWWX0xEJR9rnAVTRJdxjJrkp9TfGE57/FOD2AW62XDazX+1GdxCToXjoefO
 613zsiTBM8Jwixd1QGH9ACCiNXMYbD9qZ9KRrCFurGCIXIKxQCtyL1/Vd7BCcYMYRA3n/W/toW
 EC7OzKRNIYS5DQLPcYm/DC5FcA3yIAcgY9UaXnEpJAPRJDruDfF2R/qMnUElRW3iOuFgSztZiS
 8x4C4pr6DH0ph9mICPyTjZbEPg5BJPA4xr7RHEQDolVuWa9LJX7iaTjkG0jylGTAvS5MEufJKL
 /Jk=
WDCIronportException: Internal
Received: from 7459l3apk6t.hitachigst.global (HELO naota-xeon.wdc.com) ([10.84.71.70])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Feb 2021 00:52:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next 1/3] btrfs: fix to return bool instead of int
Date:   Mon,  1 Feb 2021 17:52:02 +0900
Message-Id: <20210201085204.700090-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201085204.700090-1-naohiro.aota@wdc.com>
References: <20210201085204.700090-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variable "changed" in dev_extent_hole_check_zoned() is using int
(0/1) to track if the hole is changed. Change it to bool to match the
definition of the function.

Fixes: 69e81c8e2824 ("btrfs: implement zoned chunk allocator")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fe2ed5f80804..102dc6636833 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1433,7 +1433,7 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 	u64 zone_size = device->zone_info->zone_size;
 	u64 pos;
 	int ret;
-	int changed = 0;
+	bool changed = false;
 
 	ASSERT(IS_ALIGNED(*hole_start, zone_size));
 
@@ -1444,7 +1444,7 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 		if (pos != *hole_start) {
 			*hole_size = *hole_start + *hole_size - pos;
 			*hole_start = pos;
-			changed = 1;
+			changed = true;
 			if (*hole_size < num_bytes)
 				break;
 		}
@@ -1459,12 +1459,12 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 		if (ret == -ERANGE) {
 			*hole_start += *hole_size;
 			*hole_size = 0;
-			return 1;
+			return true;
 		}
 
 		*hole_start += zone_size;
 		*hole_size -= zone_size;
-		changed = 1;
+		changed = true;
 	}
 
 	return changed;
-- 
2.30.0

