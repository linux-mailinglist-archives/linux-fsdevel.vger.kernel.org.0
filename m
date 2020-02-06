Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F2154238
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgBFKoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgBFKox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985893; x=1612521893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDZkS49hYzcItRCk4G6j0kg9y63mQvjVa9rjC3nk5tU=;
  b=hi1yKpKR+RXLJI5LZGHXt7hGYZNri46SIpoOzfPYdPuB7yLB/m1CLOwR
   Ol5UUsWGNA8TaCpE0Urr+EXDLg3I3bfeT5CV3rGJQHHFjLjSAacFbUW1A
   kQ9wW01L/+hhDPZ5UE2FZQ3cf4AkQdtOlnbVWGgf++Kn/PwyptKSq5PaZ
   0okjxLn9j11m/yXkN9QjyK6TR5IU457GNLxacBXB+P7DRtkb03KXn4PzA
   NH7GObP/vyKMdeQAIrR+3KEWVvmRQ3NAJBIl+iZn0wJHSX7p047m1x32l
   YHegRXNEzNsMqc07uqd/nX9pf3xwm6O5XRwpUlyeyjRPltgVfk0NlI+/G
   A==;
IronPort-SDR: nvLjbxHBp1J/TzmMeg1BfzDoaP/s8TaA+EFIB3toiY7BTagqPaAsjb5hI5w2LdYCJUFnd/NtF8
 sytdVvhr/XsP4ygluv5f7P4WWdDkO6D35L6FwpwIVQ66a5hVN79iezdaRWdY4IDTNVmuLIkZsY
 GtOfKJGIyYTPpPR9ZSRLLNLjRDyGLViSXwAsMh5CWZyM0mQWa1v237ij7izkp70lKkKnbzcK4V
 MwIxLdHECQEG35Qr1v+M669s1D7tiRLAglt77ssu3vtMZ83JxzLSatk99juqHHuVi2vZLlcaoj
 cqY=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209564"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:52 +0800
IronPort-SDR: 1U6ryMMAlur7AQrZZfKa4igbtfZgzAGxN+iDKhOY8JO7MCSOGvnla+heAl7y0bRn1NEG4SYC5H
 BhPPDexbDT5ffvOrA68gkl1UxfLIKe7VWWlyqVHNE+GrsuLYdfffCoZvK4KXPIxA8UmNsIgxqw
 FGKSRl+y3KaTQjciaUsawL061jcZ7V9HneGuKOMwwkiqhw7Ufsdi/iACYGfGFHyA8+u3POAAIj
 oCLkKb93cw7xw4WuYZ3btnxeGJ8ykJJQlWxMZC2JNGv2JZOO1Ts2oHjykYb1O8ayrKEEOwwRgD
 vJmMYWJ0qNLEqBElCZarqmzN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:52 -0800
IronPort-SDR: ELlpSVK11kZFKPTvsRTjlMiHjYiPQf/Er9R3MbV6bQDZVZanplBI3FowIBQe4ZUdiRG0+Z6+Iv
 cOUfIKiCewEPbchu9pUcFIPie6Z2va99Kct/pXGqPONJ3Eb9CEW+cHtG6oc25uCNVyt46wRUiT
 P+yGRdFZ8e6VZ8+GfJwuJbrSwl2xX7DSvIxNfiTh53h032bX3HVowJ8AGCFu4xwVJSq3X6EBAA
 FXoEHGaO2dXGxYGzJ0w0hGeauc7aedy3RoGKFQgTKmEK4Tyep0alPc/zo+UyvPwHyQIYpnMRbO
 1Ls=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 18/20] btrfs: factor out chunk_allocation_failed()
Date:   Thu,  6 Feb 2020 19:42:12 +0900
Message-Id: <20200206104214.400857-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out chunk_allocation_failed() from find_free_extent_update_loop().
This function is called when it failed to allocate a chunk. The function
can modify "ffe_ctl->loop" and return 0 to continue with the next stage.
Or, it can return -ENOSPC to give up here.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 03d17639d975..123b1a4e797a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3763,6 +3763,21 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	}
 }
 
+static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		/*
+		 * If we can't allocate a new chunk we've already looped through
+		 * at least once, move on to the NO_EMPTY_SIZE case.
+		 */
+		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
+		return 0;
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3835,19 +3850,12 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE);
 
-			/*
-			 * If we can't allocate a new chunk we've already looped
-			 * through at least once, move on to the NO_EMPTY_SIZE
-			 * case.
-			 */
 			if (ret == -ENOSPC)
-				ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
+				ret = chunk_allocation_failed(ffe_ctl);
 
 			/* Do not bail out on ENOSPC since we can do more. */
 			if (ret < 0 && ret != -ENOSPC)
 				btrfs_abort_transaction(trans, ret);
-			else
-				ret = 0;
 			if (!exist)
 				btrfs_end_transaction(trans);
 			if (ret)
-- 
2.25.0

