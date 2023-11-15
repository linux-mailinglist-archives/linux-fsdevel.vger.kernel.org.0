Return-Path: <linux-fsdevel+bounces-2880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CAB7EBC8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 05:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED63B20986
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 04:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D74B3C0A;
	Wed, 15 Nov 2023 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yQR6nzx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F1623A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 04:11:47 +0000 (UTC)
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86463E1;
	Tue, 14 Nov 2023 20:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1700021503; bh=RA57FQbfVrfMORXDKhQVrul5fdtCHBm9TYDgxIXn/OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yQR6nzx2Kt6gBZyamSCfx/Q2crJeHtgYfOEnwBLEqFMq6ngzQ3AgDPr+BbRQt1JJl
	 FexTwztuYUKDSQk1K2DRJW5qxZ4jIuaAHwafwCBMq0oNZCbBXOlP8T08iubZJHKWlE
	 FApNRYjx6ChQekuOUR7J3fakVdHYpEqBfXlwb7NI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 163050D2; Wed, 15 Nov 2023 12:05:35 +0800
X-QQ-mid: xmsmtpt1700021135t9fq618ed
Message-ID: <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
X-QQ-XMAILINFO: NuWjKG3yjDiph0VaR59Bst0VsifbZ6XBMmFp1LhmvGqQIGyby29inU5ZuA4FZ9
	 I1vW4gRQEaWn8DhFgsr6cv0Pm3jKPjznMZLwXr4EKN+7BrPJABcD4m50swL7PuPDf8W5a2iV5e+r
	 P1/fskxwjrcJzUhJYZQ/+jaclIamcnpxwyF4TaJKFkBukWCoybrxeTYt7XfAwj4x41fST6Z4Cmye
	 4y0DIDqzZ3J/BpiJS+1ijNCEWm0YqzJEXe3ltqCUGjy0sTXqu06eayuOchPTWCYJGhgyxwR/Cwi7
	 cTiEtdr6Hg5VT8g3N3qMz+V6WTcF3wPFYx9qwn0NC7N3KcH40hNTHFev8M9A1Gvmtym+rH27nWjZ
	 NFPZdNLt1ypIwSIs4v79pVhL+KVqUzrLuB8MufCHEv8QCtE0VkLaNPOTmW/o8GVQ13l0XV/IvPnL
	 Zub/mZ07opnut7DQeAzaEOZC69tbZjZvWNr5uDpssewq6NW0m79KPKI34NCo6bgTX3vsOIF1ovfN
	 VkJjfhtpLgwFspNXdDIXN8F3gvLiRB2Do+ghpU4WSELUwWFFOOBu+w837AuNDig9wRQqUA6ALZrK
	 rPKPQZBxNk4FcOeUbYaHo5ZUzZZM+iRfxopNtxNcKoJKDQ5wI7K+us8/0Mihqul8UU/MjWX5xTAg
	 h/ZIZrgxiZ1tU0S4xLgOJV2rGwPgmuJDt8+ywMT9vw8yNUy4dmDqdVCN/Gnramt3kbj5+iMj4DWP
	 chrEN+BQsYOPtihFfEh1QHmXP0x0hbGhHOD6k5ejFWvoFMjdQxFKC2VnN4PkHmqEbi04NhWyYGTj
	 O6aJQP12MlWwPfMdbjcHMksZrrnz9umvi0H8dBYT70LND1+ZQmx0r+peE7yfelnuI/3r06GxQWrx
	 WurbqcEODhBuEJte9dM2nqLhBDIzU5UOGbHy5MnL4yUwGAa7VR0zoT/3lif52ZxQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] squashfs: fix oob in squashfs_readahead
Date: Wed, 15 Nov 2023 12:05:35 +0800
X-OQ-MSGID: <20231115040534.54533-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000b1fda20609ede0d1@google.com>
References: <000000000000b1fda20609ede0d1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

[Syz log]
SQUASHFS error: Failed to read block 0x6fc: -5
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
==================================================================
BUG: KASAN: slab-out-of-bounds in __readahead_batch include/linux/pagemap.h:1364 [inline]
BUG: KASAN: slab-out-of-bounds in squashfs_readahead+0x9a6/0x20d0 fs/squashfs/file.c:569
Write of size 8 at addr ffff88801e393648 by task syz-executor100/5067

CPU: 1 PID: 5067 Comm: syz-executor100 Not tainted 6.6.0-syzkaller-15156-g13d88ac54ddd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 __readahead_batch include/linux/pagemap.h:1364 [inline]
 squashfs_readahead+0x9a6/0x20d0 fs/squashfs/file.c:569
 read_pages+0x183/0x830 mm/readahead.c:160
 page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
 page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
 filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
 filemap_read+0x42b/0x10b0 mm/filemap.c:2593
 __kernel_read+0x425/0x8b0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xad1/0x1b30 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x554/0xb30 security/integrity/ima/ima_api.c:290
 process_measurement+0x1373/0x21c0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x2893/0x3280 fs/namei.c:3779

[Bug]
path_openat() called open_last_lookups() before calling do_open() and 
open_last_lookups() will eventually call squashfs_read_inode() to set 
inode->i_size, but before setting i_size, it is necessary to obtain file_size 
from the disk.

However, during the value retrieval process, the length of the value retrieved
from the disk was greater than output->length, resulting(-EIO) in the failure of 
squashfs_read_data(), further leading to i_size has not been initialized, 
i.e. its value is 0.

This resulted in the failure of squashfs_read_data(), where "SQUASHFS error: 
Failed to read block 0x6fc: -5" was output in the syz log.
This also resulted in the failure of squashfs_cache_get(), outputting "SQUASHFS
error: Unable to read metadata cache entry [6fa]" in the syz log.

[Fix]
Before performing a read ahead operation in squashfs_read_folio() and 
squashfs_readahead(), check if i_size is not 0 before continuing.

Optimize the return value of squashfs_read_data() and return -EFBIG when the 
length is greater than output->length(or (index + length) >
msblk->bytes_used).

Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/squashfs/block.c | 2 +-
 fs/squashfs/file.c  | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 581ce9519339..d335f28c822c 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -323,7 +323,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	}
 	if (length < 0 || length > output->length ||
 			(index + length) > msblk->bytes_used) {
-		res = -EIO;
+		res = length < 0 ? -EIO : -EFBIG;
 		goto out;
 	}
 
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 8ba8c4c50770..5472ddd3596c 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -461,6 +461,11 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
 				page->index, squashfs_i(inode)->start);
 
+	if (!file_end) {
+		res = -EINVAL;
+		goto out;
+	}
+
 	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
 					PAGE_SHIFT))
 		goto out;
@@ -547,6 +552,9 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	int i, file_end = i_size_read(inode) >> msblk->block_log;
 	unsigned int max_pages = 1UL << shift;
 
+	if (!file_end)
+		return;
+
 	readahead_expand(ractl, start, (len | mask) + 1);
 
 	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
-- 
2.25.1


