Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF79151856
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 11:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgBDKBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 05:01:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58808 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgBDKBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580810480; x=1612346480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ycNjUinQ2vTFmehHApNSB68O+VxNJ/WdRiNvk28URno=;
  b=WbAv2X28DdD74ss9xrP0RD2V3oM5nX3wzeEyxeTr2SPE/tXI+Mp5BMPK
   4mUGrgqTXFRASKwcb7JyYS6ZSK10LTFCKwQa1I3069Llv35Byq0dPPa5e
   nOjYGnpeai+KT2WC/EfzU+dc3b0F8Aovrf0KdQIBMTI0O0/X3oF7rTdVc
   lDXWUThs3BWi2ce64OiycoVg2ms1x+1uvzW94CBUoCzZ7Vw1nuchSNccw
   lavig9RNA0aJCFs9kvQoLIXQddr8tsCW2d8W1wnCO00Ei8/dPGa8zjijw
   lGOU2ongq8RFGtWm92XUvLx0wvS6Da01O26MapkPfVSOFVWOJnRw8TqwN
   w==;
IronPort-SDR: qZIcDd03G7wlzSzMaYxQDIveN3f/c7wfGjDdXG+Td/1EFBG6DouYqr1ChV6kCuuq1E0R19J/la
 yVN55huDdLeDp0bMU56JV4BBgfqbILTzKM8l3t4MguIHzD9zVMA3jgGeZGeHs/kPEjlsbzqXIA
 INmdCWccLX0xfhwCyUEYBXZ9EbesL2ZHIrNhl8tZD7sHMsg8FocDNHXLYZGlJzTuppMlDq7aLo
 PT9qWjG9n3xA3bo4YudzEJDuYd07Mc8ccQx9N/8WnvBlpNF/2TeQ9ALmvQ2qjoPOXB92e925ig
 rtg=
X-IronPort-AV: E=Sophos;i="5.70,401,1574092800"; 
   d="scan'208";a="129596636"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2020 18:01:20 +0800
IronPort-SDR: ytIi5BgYMhedGV9AyGqYO71adp+NbjYSYXC8igzvHDEo/fqsbwNLMJI74gPLfwsbPcYSZmybxF
 3wglg3SLp5NT2vHO92sDLfX7KJhb0OEQhvkHdGGBlj23WBUuu0RJvlFfZCmGqoh6BGgEj6+QBv
 LpFlaGBV16gbJmdMpt35ziGr2Jj74RRFjlfvzposax3pKOlIpgKVX9+S00ue7hBRUQi5Ydivwd
 rbLHrOLgVlw5RcBAcPpdBAiFeaYxbMmxla2U32aP2uIMAlU6NIj8VNhdS3AzKI5kflyrGpVoYP
 /pFXiTaHorT/q62/9eA9mi91
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 01:54:22 -0800
IronPort-SDR: LEtxxlxr9gYJqYRD/PQ4/XS1ngt1jBOnY/DRDWX8M3ICedVSCnkU3g5I5As6/2Z8mmzUSoH8p/
 uTYBhW7EHNnZvdws/30MMJ57HWoWDhkjbcjV0yI2TnGElgBQNte7fh8t21H8vfK2J7d/TVCmRu
 tyzGVhva2peocJNwnHMOeWTjt0KNadUtoX9wAMqnD+9p7v3ekYu43LckfbAFuBk6BeFMdyxm1p
 AbUTdpCEXu6Z7R1Pt7bLxD1NPgpWcxNdY6tCU+ezUIpBKbTk1eD2Y3/3CPozbU/8dDgTI7py6Y
 d+c=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Feb 2020 02:01:19 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] mm, swap: unlock inode in error path of claim_swapfile
Date:   Tue,  4 Feb 2020 18:59:43 +0900
Message-Id: <20200204095943.727666-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

claim_swapfile() currently keeps the inode locked when it is successful, or
the file is already swapfile (with -EBUSY). And, on the other error cases,
it does not lock the inode.

This inconsistency of the lock state and return value is quite confusing
and actually causing a bad unlock balance as below in the "bad_swap"
section of __do_sys_swapon().

This commit fixes this issue by unlocking the inode on the error path. It
also reverts blocksize and releases bdev, so that the caller can safely
forget about the inode.

    =====================================
    WARNING: bad unlock balance detected!
    5.5.0-rc7+ #176 Not tainted
    -------------------------------------
    swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
    [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
    but there are no more locks to release!

    other info that might help us debug this:
    no locks held by swapon/4294.

    stack backtrace:
    CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
    Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
    Call Trace:
     dump_stack+0xa1/0xea
     ? __do_sys_swapon+0x94b/0x3550
     print_unlock_imbalance_bug.cold+0x114/0x123
     ? __do_sys_swapon+0x94b/0x3550
     lock_release+0x562/0xed0
     ? kvfree+0x31/0x40
     ? lock_downgrade+0x770/0x770
     ? kvfree+0x31/0x40
     ? rcu_read_lock_sched_held+0xa1/0xd0
     ? rcu_read_lock_bh_held+0xb0/0xb0
     up_write+0x2d/0x490
     ? kfree+0x293/0x2f0
     __do_sys_swapon+0x94b/0x3550
     ? putname+0xb0/0xf0
     ? kmem_cache_free+0x2e7/0x370
     ? do_sys_open+0x184/0x3e0
     ? generic_max_swapfile_size+0x40/0x40
     ? do_syscall_64+0x27/0x4b0
     ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
     ? lockdep_hardirqs_on+0x38c/0x590
     __x64_sys_swapon+0x54/0x80
     do_syscall_64+0xa4/0x4b0
     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    RIP: 0033:0x7f15da0a0dc7

Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mm/swapfile.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bb3261d45b6a..dd5d7fa42282 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2886,24 +2886,37 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 		p->old_block_size = block_size(p->bdev);
 		error = set_blocksize(p->bdev, PAGE_SIZE);
 		if (error < 0)
-			return error;
+			goto err;
 		/*
 		 * Zoned block devices contain zones that have a sequential
 		 * write only restriction.  Hence zoned block devices are not
 		 * suitable for swapping.  Disallow them here.
 		 */
-		if (blk_queue_is_zoned(p->bdev->bd_queue))
-			return -EINVAL;
+		if (blk_queue_is_zoned(p->bdev->bd_queue)) {
+			error = -EINVAL;
+			goto err;
+		}
 		p->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
 		p->bdev = inode->i_sb->s_bdev;
 	}
 
 	inode_lock(inode);
-	if (IS_SWAPFILE(inode))
-		return -EBUSY;
+	if (IS_SWAPFILE(inode)) {
+		inode_unlock(inode);
+		error = -EBUSY;
+		goto err;
+	}
 
 	return 0;
+
+err:
+	if (S_ISBLK(inode->i_mode)) {
+		set_blocksize(p->bdev, p->old_block_size);
+		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+	}
+
+	return error;
 }
 
 
@@ -3157,10 +3170,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	mapping = swap_file->f_mapping;
 	inode = mapping->host;
 
-	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
+	/* do inode_lock(inode); */
 	error = claim_swapfile(p, inode);
-	if (unlikely(error))
+	if (unlikely(error)) {
+		inode = NULL;
 		goto bad_swap;
+	}
 
 	/*
 	 * Read the swap header.
-- 
2.25.0

