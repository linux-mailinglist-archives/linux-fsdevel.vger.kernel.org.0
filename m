Return-Path: <linux-fsdevel+bounces-16307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4B89AE07
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A311F21B0F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9631876;
	Sun,  7 Apr 2024 02:20:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CBEDC;
	Sun,  7 Apr 2024 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712456449; cv=none; b=UCCfcq6dFg5OrRhC+hiBmIIwUmuhIlNmGBoRKqYtQCLlETTh5yEdvWQ+RoGvIfMvRgAqiT7QwuuBORSpt5blnniThf/64gq8OWEOG4RAbH4Dq8Morow9qFFOjzyj0bTB2A7KYgqv+xPDhU4pWazXh4QfB62cyO8d8w4GrFYjHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712456449; c=relaxed/simple;
	bh=/NbU8Esu/Ayh9Uho+69oGdyfF1hUItW69DWT12bs6WE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Gm24ubchWt0iapnW8u4OKncir0ZE0Y6WHY0+t0MzRJqrdOHIFDfkqAos1lKgPzfmanxw35IXiqdVUOhoUdR+bBm8zQIwAU7XnJF0z2CeTh0sDuyrIS3QI4LYNu/jKULgLBXVCAZqZRH4iBfMoeC67YY6hAPCtqXz9gsUUlyuQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBwtZ1V2qz4f3lX3;
	Sun,  7 Apr 2024 10:20:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 85B7C1A0D2F;
	Sun,  7 Apr 2024 10:20:42 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RH3AhJmynY0JQ--.29804S3;
	Sun, 07 Apr 2024 10:20:41 +0800 (CST)
Subject: Re: [PATCH vfs.all 00/26] fs & block: remove bdev->bd_inode
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 gustavoars@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <227a872d-51e9-babc-0489-7fcc7112c0e6@huaweicloud.com>
Date: Sun, 7 Apr 2024 10:20:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RH3AhJmynY0JQ--.29804S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyftw4xWry5Zr1DWry5CFg_yoWfAFW8pr
	9xKFZakr1jkryUZayxu3WUGa4Sywn7G3y5Gr1Ivw1SvFyUZryaqw4kKayrCFW7WryFvry3
	X3WUJw1UCr1rCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Christian!
Hi, Jan!
+CC Gustavo

While testing this set, I found that the branch vfs.all seems broken,
xfstests report success while lots of BUG is reported in dmesg:

[22709.079704] 
=============================================================================^M
[22709.082404] BUG kmalloc-16 (Not tainted): Right Redzone overwritten^M
[22709.084148] 
-----------------------------------------------------------------------------^M
[22709.084148] ^M
[22709.086784] 0xffff88817d52e7a0-0xffff88817d52e7a7 @offset=1952. First 
byte 0x0 instead of 0xcc^M
[22709.089169] Allocated in do_handle_open+0x97/0x440 age=10 cpu=13 
pid=814795^M
[22709.091158]  __kmalloc+0x41d/0x5e0^M
[22709.092153]  do_handle_open+0x97/0x440^M
[22709.093240]  __x64_sys_open_by_handle_at+0x23/0x30^M
[22709.094482]  do_syscall_64+0xb1/0x210^M
[22709.095316]  entry_SYSCALL_64_after_hwframe+0x6c/0x74^M
[22709.096414] Freed in kvfree+0x4c/0x60 age=43560 cpu=15 pid=813506^M
[22709.097719]  kfree+0x31c/0x530^M
[22709.098396]  kvfree+0x4c/0x60^M
[22709.099048]  ext4_mb_release+0x29c/0x570^M
[22709.099901]  ext4_put_super+0x17f/0x590^M
[22709.100735]  generic_shutdown_super+0xba/0x240^M
[22709.101698]  kill_block_super+0x22/0x70^M
[22709.102525]  ext4_kill_sb+0x2a/0x70^M
[22709.103297]  deactivate_locked_super+0x4f/0xe0^M
[22709.104261]  deactivate_super+0x81/0x90^M
[22709.104876]  cleanup_mnt+0xe0/0x1b0^M
[22709.105419]  __cleanup_mnt+0x1a/0x30^M
[22709.105964]  task_work_run+0x88/0x100^M
[22709.106531]  syscall_exit_to_user_mode+0x3cc/0x3e0^M
[22709.107263]  do_syscall_64+0xc5/0x210^M
[22709.107820]  entry_SYSCALL_64_after_hwframe+0x6c/0x74^M

While digging this problem, I found that commit 1b43c4629756 ("fs:
Annotate struct file_handle with __counted_by() and use struct_size()")
might made a mistake, and I verified following patch can fix the
problem.

Thanks,
Kuai

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 53ed54711cd2..bcfecac2dc54 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -201,8 +201,7 @@ static int handle_to_path(int mountdirfd, struct 
file_handle __user *ufh,
         /* copy the full handle */
         *handle = f_handle;
         if (copy_from_user(&handle->f_handle,
-                          &ufh->f_handle,
-                          struct_size(ufh, f_handle, 
f_handle.handle_bytes))) {
+                          &ufh->f_handle, f_handle.handle_bytes)) {
                 retval = -EFAULT;
                 goto out_handle;
         }

ÔÚ 2024/04/06 17:09, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Hi, Jens!
> Hi, Jan!
> Hi, Christoph!
> Hi, Christian!
> Hi, AL!
> 
> Sorry for the delay(I was overwhelmed with other work stuff). Main changes
> from last version is patch 22(modified based on [1]), the idea is that
> stash a 'bdev_file' in 'bd_inode->i_private' while opening bdev the first
> time, and release it when last opener close the bdev.
> 
> The patch to use bdev and bdev_file as union for iomap/buffer_head is
> dropped and changes for iomap/buffer is splitted to patch 23-26.
> 
> I tested this set in my VM with blktests for virtio-scsi and xfstests
> for ext4/xfs for one round now, no regerssions are found yet.
> 
> Please let me know what you think!
> 
> [1] https://lore.kernel.org/all/c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com/
> 
> Changes from RFC v4:
>   - respin on the top of vfs.all branch from vfs tree;
>   - add review tag, patches that are not reviewed: patch 19-26;
>   - add patch 21, fix a module reference problem;
>   - instead of using a union of bdev(for raw block device) and
>   bdev_file(for filesystems), add patch 22 to stash a bdev_file to
>   bd_inode->i_private, so that iomap and buffer_head for raw block device
>   can convert to use bdev_file as well;
>   - split the huge path for iomap/buffer into 4 patches, 21-24;
> 
> Changes from RFC v3:
>   - respin on the top of linux-next, based on Christian's patchset to
>   open bdev as file. Most of patches from v3 is dropped and change to use
>   file_inode(bdev_file) to get bd_inode or bdev_file->f_mapping to get
>   bd_inode->i_mapping.
> 
> Changes from RFC v2:
>   - remove bdev_associated_mapping() and patch 12 from v1;
>   - add kerneldoc comments for new bdev apis;
>   - rename __bdev_get_folio() to bdev_get_folio;
>   - fix a problem in erofs that erofs_init_metabuf() is not always
>   called.
>   - add reviewed-by tag for patch 15-17;
> 
> Changes from RFC v1:
>   - remove some bdev apis that is not necessary;
>   - pass in offset for bdev_read_folio() and __bdev_get_folio();
>   - remove bdev_gfp_constraint() and add a new helper in fs/buffer.c to
>   prevent access bd_indoe() directly from mapping_gfp_constraint() in
>   ext4.(patch 15, 16);
>   - remove block_device_ejected() from ext4.
> 
> Yu Kuai (26):
>    block: move two helpers into bdev.c
>    block: remove sync_blockdev_nowait()
>    block: remove sync_blockdev_range()
>    block: prevent direct access of bd_inode
>    block: add a helper bdev_read_folio()
>    bcachefs: remove dead function bdev_sectors()
>    cramfs: prevent direct access of bd_inode
>    erofs: prevent direct access of bd_inode
>    nilfs2: prevent direct access of bd_inode
>    gfs2: prevent direct access of bd_inode
>    btrfs: prevent direct access of bd_inode
>    ext4: remove block_device_ejected()
>    ext4: prevent direct access of bd_inode
>    jbd2: prevent direct access of bd_inode
>    s390/dasd: use bdev api in dasd_format()
>    bcache: prevent direct access of bd_inode
>    block2mtd: prevent direct access of bd_inode
>    scsi: use bdev helper in scsi_bios_ptable()
>    dm-vdo: convert to use bdev_file
>    block: factor out a helper init_bdev_file()
>    block: fix module reference leakage from bdev_open_by_dev error path
>    block: stash a bdev_file to read/write raw blcok_device
>    iomap: add helpers helpers to get and set bdev
>    iomap: convert to use bdev_file
>    buffer: add helpers to get and set bdev
>    buffer: convert to use bdev_file
> 
>   block/bdev.c                              | 262 ++++++++++++++++------
>   block/blk-zoned.c                         |   4 +-
>   block/blk.h                               |   2 +
>   block/fops.c                              |   6 +-
>   block/genhd.c                             |   9 +-
>   block/ioctl.c                             |   8 +-
>   block/partitions/core.c                   |   8 +-
>   drivers/md/bcache/super.c                 |   7 +-
>   drivers/md/dm-vdo/dedupe.c                |   7 +-
>   drivers/md/dm-vdo/dm-vdo-target.c         |   9 +-
>   drivers/md/dm-vdo/indexer/config.c        |   2 +-
>   drivers/md/dm-vdo/indexer/config.h        |   4 +-
>   drivers/md/dm-vdo/indexer/index-layout.c  |   6 +-
>   drivers/md/dm-vdo/indexer/index-layout.h  |   2 +-
>   drivers/md/dm-vdo/indexer/index-session.c |  18 +-
>   drivers/md/dm-vdo/indexer/index.c         |   4 +-
>   drivers/md/dm-vdo/indexer/index.h         |   2 +-
>   drivers/md/dm-vdo/indexer/indexer.h       |   6 +-
>   drivers/md/dm-vdo/indexer/io-factory.c    |  17 +-
>   drivers/md/dm-vdo/indexer/io-factory.h    |   4 +-
>   drivers/md/dm-vdo/indexer/volume.c        |   4 +-
>   drivers/md/dm-vdo/indexer/volume.h        |   2 +-
>   drivers/md/dm-vdo/vdo.c                   |   2 +-
>   drivers/md/md-bitmap.c                    |   2 +-
>   drivers/mtd/devices/block2mtd.c           |   6 +-
>   drivers/s390/block/dasd_ioctl.c           |   5 +-
>   drivers/scsi/scsicam.c                    |   3 +-
>   fs/affs/file.c                            |   2 +-
>   fs/bcachefs/util.h                        |   5 -
>   fs/btrfs/disk-io.c                        |  17 +-
>   fs/btrfs/disk-io.h                        |   4 +-
>   fs/btrfs/inode.c                          |   2 +-
>   fs/btrfs/super.c                          |   2 +-
>   fs/btrfs/volumes.c                        |  25 ++-
>   fs/btrfs/zoned.c                          |  20 +-
>   fs/btrfs/zoned.h                          |   4 +-
>   fs/buffer.c                               | 104 ++++-----
>   fs/cramfs/inode.c                         |   2 +-
>   fs/direct-io.c                            |   4 +-
>   fs/erofs/data.c                           |  22 +-
>   fs/erofs/internal.h                       |   1 +
>   fs/erofs/zmap.c                           |   2 +-
>   fs/exfat/fatent.c                         |   2 +-
>   fs/ext2/inode.c                           |   4 +-
>   fs/ext2/xattr.c                           |   2 +-
>   fs/ext4/dir.c                             |   2 +-
>   fs/ext4/ext4_jbd2.c                       |   2 +-
>   fs/ext4/inode.c                           |   2 +-
>   fs/ext4/mmp.c                             |   2 +-
>   fs/ext4/page-io.c                         |   5 +-
>   fs/ext4/super.c                           |  30 +--
>   fs/ext4/xattr.c                           |   2 +-
>   fs/f2fs/data.c                            |  10 +-
>   fs/f2fs/f2fs.h                            |   1 +
>   fs/fat/inode.c                            |   2 +-
>   fs/fuse/dax.c                             |   2 +-
>   fs/gfs2/aops.c                            |   2 +-
>   fs/gfs2/bmap.c                            |   2 +-
>   fs/gfs2/glock.c                           |   2 +-
>   fs/gfs2/meta_io.c                         |   2 +-
>   fs/gfs2/ops_fstype.c                      |   2 +-
>   fs/hpfs/file.c                            |   2 +-
>   fs/iomap/buffered-io.c                    |   8 +-
>   fs/iomap/direct-io.c                      |  11 +-
>   fs/iomap/swapfile.c                       |   2 +-
>   fs/iomap/trace.h                          |   6 +-
>   fs/jbd2/commit.c                          |   2 +-
>   fs/jbd2/journal.c                         |  34 +--
>   fs/jbd2/recovery.c                        |   9 +-
>   fs/jbd2/revoke.c                          |  14 +-
>   fs/jbd2/transaction.c                     |   8 +-
>   fs/mpage.c                                |  18 +-
>   fs/nilfs2/btnode.c                        |   4 +-
>   fs/nilfs2/gcinode.c                       |   2 +-
>   fs/nilfs2/mdt.c                           |   2 +-
>   fs/nilfs2/page.c                          |   4 +-
>   fs/nilfs2/recovery.c                      |  27 ++-
>   fs/nilfs2/segment.c                       |   2 +-
>   fs/ntfs3/fsntfs.c                         |  10 +-
>   fs/ntfs3/inode.c                          |   4 +-
>   fs/ntfs3/super.c                          |   6 +-
>   fs/ocfs2/journal.c                        |   2 +-
>   fs/reiserfs/fix_node.c                    |   2 +-
>   fs/reiserfs/journal.c                     |  10 +-
>   fs/reiserfs/prints.c                      |   4 +-
>   fs/reiserfs/reiserfs.h                    |   6 +-
>   fs/reiserfs/stree.c                       |   2 +-
>   fs/reiserfs/tail_conversion.c             |   2 +-
>   fs/sync.c                                 |   9 +-
>   fs/xfs/xfs_iomap.c                        |   4 +-
>   fs/zonefs/file.c                          |   4 +-
>   include/linux/blk_types.h                 |   2 +-
>   include/linux/blkdev.h                    |  19 +-
>   include/linux/buffer_head.h               |  81 ++++---
>   include/linux/iomap.h                     |  13 +-
>   include/linux/jbd2.h                      |  18 +-
>   include/trace/events/block.h              |   2 +-
>   97 files changed, 620 insertions(+), 440 deletions(-)
> 


