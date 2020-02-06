Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD68F1540CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 10:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgBFJBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 04:01:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34199 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBFJBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580979700; x=1612515700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jyukHLzx/SqnY96ipPKUJPFOqUXXKjo4PmPngWi2Ufo=;
  b=gZCPL3NTJA5a+YqtpWu0LnGrSNIePAxD6DmYfDvMed3mHlZEE0Gk3B0T
   IiyedpR7TH7KO3vlgJgcXZDI5GxvMzYU4HEz6bCQCLlBPrL0sdV1gWJc6
   gc2hEgE8S2MYFrktkYWwwr3r+Nsa3YN9jWD4yAqMCxleI7esqUupgCztm
   YLe0087y+EjggX0AEuz7UCwQfjPZ0Ff/hB+zWpB78tCJsZYnj4vxQNgH4
   IH2Lov90tzl10hkYdtDBfZMJiSeDqQtzWgTUlqRfwhRfst9y0lb7XQxg1
   z475OLAiI6AjYc0AYHVBA94ARMX/kMWfOYxy5WMeQ7RMSLryyPOCjN9S6
   Q==;
IronPort-SDR: USVcpT9LlBY9JrXC+pUNI87jPZQFnqfipfYb+6LO5as0uT1Xb/O4vJzfDQIrKiaW2OaXpf+fvK
 42SNgG5SZO1LF/zoZoeMOr1U++dsnsj2/jknxhXgOewGOKG4qqKv3UFDKBBktjD9CUSgesWTBn
 u3NmjbWQkNp6H9DMM3WPEABJd9ES38rRc47Q/MpW5eB1+iZtzgzpDkagqPVH9wt3Z2WeBw1mVy
 PWNt2Qjqdm+gLhxD45pxCWOCz68vOZzzFfcwb6fj1vBas/6LJHUhuaJBHiGMM1Z6OktGI5ISuy
 OHc=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="230982163"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 17:01:40 +0800
IronPort-SDR: Zbr3UHb/kX4ZYqbVpXlLSAiIsLjNqTyhpKwnhoyg5w7SI4+fQls6t0APxK3l02GqtLBAqraLTB
 vlNvw3vsJXTZ3yzgMsAkKrv6ndRhlUNi9VH0Hd2XZQcygWC4ac5TyAGYpOF2qcv12PcgOD3r7f
 EUTYatniOVvvn48xNA8J7mEdINQrG4eUk+pePwCHVJ6M365ezbsVs78u/hpqSTD24sDNzOi6cZ
 oSBXoBAp9FRaxBuk6Mj1VxwkZb+Zhi/PXTwC12WONUgal72LcjHcMsHLQvAHZBJbLJWmIBe4kD
 4fxJtam5N3ZPtrbqWCqQQCoq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 00:54:37 -0800
IronPort-SDR: Nnr8gP60QL8Me5dL4F4Z3MMvUbXStUGVcMAyvRG0YOj536Dq+jRSFvDXzwT57KG188SrJz7b0p
 s7vP+TI7tacCglslg+R2miLVkuGesuhQQYdxM3jnAU3IIeilKsM/en+GzbhfVRrppHHiPFDwwI
 3wMGwntDaM8cBtj8X+bNwMxfMbojnfGnGs1IFXhLAnqiaTpS2gxg7zDFhTrG+uof4AydHZ3qoG
 8beXMXXSCtTFKe2x4E2nwjp4qQErtOYs/O9Juyzg4lWC0h+XFbPVqyTuts26cRm0w2RNHnGJFd
 IEg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 01:01:37 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] mm, swap: move inode_lock out of claim_swapfile
Date:   Thu,  6 Feb 2020 18:01:32 +0900
Message-Id: <20200206090132.154869-1-naohiro.aota@wdc.com>
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

This commit fixes this issue by moving the inode_lock() and IS_SWAPFILE
check out of claim_swapfile(). The inode is unlocked in
"bad_swap_unlock_inode" section, so that the inode is ensured to be
unlocked at "bad_swap". Thus, error handling codes after the locking now
jumps to "bad_swap_unlock_inode" instead of "bad_swap".

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
Changelog:
- Avoid taking inode lock in claim_swapfile()
- Change error handling
  - Add "bad_swap_unlock_inode" section to ensure the inode is unlocked at
    "bad_swap"
---
 mm/swapfile.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bb3261d45b6a..2c4c349e1101 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2899,10 +2899,6 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 		p->bdev = inode->i_sb->s_bdev;
 	}
 
-	inode_lock(inode);
-	if (IS_SWAPFILE(inode))
-		return -EBUSY;
-
 	return 0;
 }
 
@@ -3157,36 +3153,41 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	mapping = swap_file->f_mapping;
 	inode = mapping->host;
 
-	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
 	error = claim_swapfile(p, inode);
 	if (unlikely(error))
 		goto bad_swap;
 
+	inode_lock(inode);
+	if (IS_SWAPFILE(inode)) {
+		error = -EBUSY;
+		goto bad_swap_unlock_inode;
+	}
+
 	/*
 	 * Read the swap header.
 	 */
 	if (!mapping->a_ops->readpage) {
 		error = -EINVAL;
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 	}
 	page = read_mapping_page(mapping, 0, swap_file);
 	if (IS_ERR(page)) {
 		error = PTR_ERR(page);
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 	}
 	swap_header = kmap(page);
 
 	maxpages = read_swap_header(p, swap_header, inode);
 	if (unlikely(!maxpages)) {
 		error = -EINVAL;
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 	}
 
 	/* OK, set up the swap map and apply the bad block list */
 	swap_map = vzalloc(maxpages);
 	if (!swap_map) {
 		error = -ENOMEM;
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 	}
 
 	if (bdi_cap_stable_pages_required(inode_to_bdi(inode)))
@@ -3211,7 +3212,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 					GFP_KERNEL);
 		if (!cluster_info) {
 			error = -ENOMEM;
-			goto bad_swap;
+			goto bad_swap_unlock_inode;
 		}
 
 		for (ci = 0; ci < nr_cluster; ci++)
@@ -3220,7 +3221,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
 		if (!p->percpu_cluster) {
 			error = -ENOMEM;
-			goto bad_swap;
+			goto bad_swap_unlock_inode;
 		}
 		for_each_possible_cpu(cpu) {
 			struct percpu_cluster *cluster;
@@ -3234,13 +3235,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	error = swap_cgroup_swapon(p->type, maxpages);
 	if (error)
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 
 	nr_extents = setup_swap_map_and_extents(p, swap_header, swap_map,
 		cluster_info, maxpages, &span);
 	if (unlikely(nr_extents < 0)) {
 		error = nr_extents;
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 	}
 	/* frontswap enabled? set up bit-per-page map for frontswap */
 	if (IS_ENABLED(CONFIG_FRONTSWAP))
@@ -3280,7 +3281,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	error = init_swap_address_space(p->type, maxpages);
 	if (error)
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 
 	/*
 	 * Flush any pending IO and dirty mappings before we start using this
@@ -3290,7 +3291,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	error = inode_drain_writes(inode);
 	if (error) {
 		inode->i_flags &= ~S_SWAPFILE;
-		goto bad_swap;
+		goto bad_swap_unlock_inode;
 	}
 
 	mutex_lock(&swapon_mutex);
@@ -3315,6 +3316,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	error = 0;
 	goto out;
+bad_swap_unlock_inode:
+	inode_unlock(inode);
 bad_swap:
 	free_percpu(p->percpu_cluster);
 	p->percpu_cluster = NULL;
@@ -3322,6 +3325,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		set_blocksize(p->bdev, p->old_block_size);
 		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
 	}
+	inode = NULL;
 	destroy_swap_extents(p);
 	swap_cgroup_swapoff(p->type);
 	spin_lock(&swap_lock);
@@ -3333,13 +3337,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	kvfree(frontswap_map);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
-	if (swap_file) {
-		if (inode) {
-			inode_unlock(inode);
-			inode = NULL;
-		}
+	if (swap_file)
 		filp_close(swap_file, NULL);
-	}
 out:
 	if (page && !IS_ERR(page)) {
 		kunmap(page);
-- 
2.25.0

