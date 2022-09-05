Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46C5ACD44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiIEIAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiIEIAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:00:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F17C6582;
        Mon,  5 Sep 2022 01:00:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b16so10184907wru.7;
        Mon, 05 Sep 2022 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=VaWJ/ARhAOBGNuUeehNxEZSalc/K693ceMetl/r8zM0=;
        b=SnJhQQZLPDQoJOp4A6JgHJxbKXZb9XVqvdh2cpuymb/xL6glfU9k9AIRC1OC4q567m
         WeGvKxSbv3ypSaMKi2ZaAquvKuuxVYsCUzdP6BUR7FLo68gDZt6Pvk68EcBVWzCVJjwG
         0iJ1ksTQhC9Peq8UKLS6K5Xdwrt22abbzta8YQBRVkHZg8DiJAUE7T4zjNj154crQmo2
         fVAwwe3YrMejDL4szCZfXaeRP49E3aqQT0fWguEpC05mSB07XUvtyyuVwRmxCsiU5Lr5
         keXZohZ4yQjL7FidpcZL5DrAGN+0vTOSZsCbo0y43Lq/WvLBGVPfvcn6Z2AtVOUBLyIc
         NoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VaWJ/ARhAOBGNuUeehNxEZSalc/K693ceMetl/r8zM0=;
        b=B3n5GHgAIXAnL/Z+hUgfICIjSytCB/b+a24dnEIQ7RBbgcwDMOl73nWBsW3X68xHGx
         y+bWMS+nxy1XGE2Q86C7iIvgHcXHgXIE64tT+CQWSJJsQB1SQJaUn3UGyYLD4MfNtVcv
         brrxfVYw7+Ilji0fSTkbaD0h0s4jeZ08QjcydZR95KoAR4yay6KPkFxhxfQCb70Pqlcy
         PalEixgtPnhqDdwYx5BZbvXKR55BdkfTt29tZx2LNbvTTXq1L0bPvftLkfXwEDeCXv1l
         XnSLT0srMb4rmI9v6ZoCmRsez1RqbF6hxr+8x33pK1c/Tx7e3LS80m5DKA6yNjRopnMD
         xBKA==
X-Gm-Message-State: ACgBeo0qizifqRG0W+ZypKdxPt4n83RJ3kyXdvarMXrWzwTXRmFN84Dm
        /QtGyxtFNbfgSuYE8hmroRrWLzaNFXg=
X-Google-Smtp-Source: AA6agR60M9DbGesrt7BIBrBnQOq6chv1b4N5FjBbhGVwQjqOFSOuMcViNY3ntJmPvfXnH/oAQukyzg==
X-Received: by 2002:a5d:64ab:0:b0:226:d997:ad5c with SMTP id m11-20020a5d64ab000000b00226d997ad5cmr20049042wrp.602.1662364833934;
        Mon, 05 Sep 2022 01:00:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id l20-20020a05600c089400b003a30fbde91dsm15646478wmp.20.2022.09.05.01.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:00:33 -0700 (PDT)
Date:   Mon, 5 Sep 2022 10:00:29 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: WARNING: inconsistent lock state when doing fdisk -l
Message-ID: <YxWsnc1JlNemcXfA@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello

On a jetson-tk1 I got today:
[   39.582103] ================================
[   39.586361] WARNING: inconsistent lock state
[   39.590618] 6.0.0-rc3-next-20220901-00130-gb6b3fb681f34-dirty #8 Not tainted
[   39.597649] --------------------------------
[   39.601907] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-R} usage.
[   39.607897] rngd/218 [HC0[0]:SC1[1]:HE0:SE0] takes:
[   39.612763] c284dba4 (&inode->i_size_seqcount){+.+-}-{0:0}, at: end_bio_bh_io_sync+0x30/0x4c
[   39.621198] {SOFTIRQ-ON-W} state was registered at:
[   39.626061]   simple_write_end+0x1e8/0x2a4
[   39.630154]   page_symlink+0xb0/0x158
[   39.633808]   ramfs_symlink+0x50/0xcc
[   39.637466]   vfs_symlink+0x80/0xf0
[   39.640944]   init_symlink+0x54/0x88
[   39.644512]   do_symlink+0x54/0x88
[   39.647905]   write_buffer+0x28/0x3c
[   39.651470]   flush_buffer+0x40/0x98
[   39.655035]   __gunzip+0x2c4/0x35c
[   39.658427]   gunzip+0x2c/0x34
[   39.661470]   unpack_to_rootfs+0x18c/0x2b4
[   39.665556]   do_populate_rootfs+0x78/0x1cc
[   39.669728]   async_run_entry_fn+0x24/0xb0
[   39.673817]   process_one_work+0x288/0x774
[   39.677904]   worker_thread+0x54/0x51c
[   39.681643]   kthread+0xf8/0x12c
[   39.684862]   ret_from_fork+0x14/0x2c
[   39.688513]   0x0
[   39.690430] irq event stamp: 19119
[   39.693820] hardirqs last  enabled at (19118): [<c010145c>] __do_softirq+0xdc/0x598
[   39.701460] hardirqs last disabled at (19119): [<c0d0afb0>] _raw_read_lock_irqsave+0x84/0x88
[   39.709883] softirqs last  enabled at (19108): [<c01016b4>] __do_softirq+0x334/0x598
[   39.717609] softirqs last disabled at (19117): [<c012bdb0>] __irq_exit_rcu+0x124/0x1a8
[   39.725511] 
[   39.725511] other info that might help us debug this:
[   39.732021]  Possible unsafe locking scenario:
[   39.732021] 
[   39.737924]        CPU0
[   39.740360]        ----
[   39.742796]   lock(&inode->i_size_seqcount);
[   39.747056]   <Interrupt>
[   39.749665]     lock(&inode->i_size_seqcount);
[   39.754098] 
[   39.754098]  *** DEADLOCK ***
[   39.754098] 
[   39.760001] 1 lock held by rngd/218:
[   39.763566]  #0: c284d950 (&ni->size_lock){...-}-{2:2}, at: ntfs_end_buffer_async_read+0x68/0x458
[   39.772432] 
[   39.772432] stack backtrace:
[   39.776777] CPU: 0 PID: 218 Comm: rngd Not tainted 6.0.0-rc3-next-20220901-00130-gb6b3fb681f34-dirty #8
[   39.786149] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   39.792401]  unwind_backtrace from show_stack+0x10/0x14
[   39.797618]  show_stack from dump_stack_lvl+0x58/0x70
[   39.802660]  dump_stack_lvl from mark_lock.part.0+0xb80/0x1298
[   39.808482]  mark_lock.part.0 from __lock_acquire+0xa70/0x29fc
[   39.814304]  __lock_acquire from lock_acquire+0x11c/0x3c8
[   39.819691]  lock_acquire from ntfs_end_buffer_async_read+0xac/0x458
[   39.826033]  ntfs_end_buffer_async_read from end_bio_bh_io_sync+0x30/0x4c
[   39.832809]  end_bio_bh_io_sync from blk_update_request+0x158/0x57c
[   39.839064]  blk_update_request from scsi_end_request+0x1c/0x3d4
[   39.845059]  scsi_end_request from scsi_io_completion+0x38/0x688
[   39.851053]  scsi_io_completion from blk_complete_reqs+0x54/0x60
[   39.857047]  blk_complete_reqs from __do_softirq+0x134/0x598
[   39.862694]  __do_softirq from __irq_exit_rcu+0x124/0x1a8
[   39.868083]  __irq_exit_rcu from irq_exit+0x8/0x28
[   39.872866]  irq_exit from call_with_stack+0x18/0x20
[   39.877824]  call_with_stack from __irq_usr+0x7c/0xa0
[   39.882868] Exception stack(0xf0c69fb0 to 0xf0c69ff8)
[   39.887906] 9fa0:                                     553c47b7 41bd9715 553c47b7 b6b5e9d8
[   39.896065] 9fc0: b6b5ea40 00000000 00000000 b62046a0 0000000a b635f000 beefcbf4 b6b5e924
[   39.904223] 9fe0: 0000001d b6b5e910 b6f448ec b6f44900 80000010 ffffffff

The command leading to this is a simple fdisk -l
It is not clear to me if the problem came from NTFS or ramfs.

The full output is:
fdisk -l
Disk /dev/ram0: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram1: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram2: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram3: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram4: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram5: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram6: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram7: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram8: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram9: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram10: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram11: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram12: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512[   39.577565] 
[   39.582103] ================================
[   39.586361] WARNING: inconsistent lock state
[   39.590618] 6.0.0-rc3-next-20220901-00130-gb6b3fb681f34-dirty #8 Not tainted
[   39.597649] --------------------------------
[   39.601907] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-R} usage.
[   39.607897] rngd/218 [HC0[0]:SC1[1]:HE0:SE0] takes:
[   39.612763] c284dba4 (&inode->i_size_seqcount){+.+-}-{0:0}, at: end_bio_bh_io_sync+0x30/0x4c
[   39.621198] {SOFTIRQ-ON-W} state was registered at:
[   39.626061]   simple_write_end+0x1e8/0x2a4
[   39.630154]   page_symlink+0xb0/0x158
[   39.633808]   ramfs_symlink+0x50/0xcc
[   39.637466]   vfs_symlink+0x80/0xf0
[   39.640944]   init_symlink+0x54/0x88
[   39.644512]   do_symlink+0x54/0x88
[   39.647905]   write_buffer+0x28/0x3c
[   39.651470]   flush_buffer+0x40/0x98
[   39.655035]   __gunzip+0x2c4/0x35c
[   39.658427]   gunzip+0x2c/0x34
[   39.661470]   unpack_to_rootfs+0x18c/0x2b4
[   39.665556]   do_populate_rootfs+0x78/0x1cc
[   39.669728]   async_run_entry_fn+0x24/0xb0
[   39.673817]   process_one_work+0x288/0x774
[   39.677904]   worker_thread+0x54/0x51c
[   39.681643]   kthread+0xf8/0x12c
[   39.684862]   ret_from_fork+0x14/0x2c
[   39.688513]   0x0
[   39.690430] irq event stamp: 19119
[   39.693820] hardirqs last  enabled at (19118): [<c010145c>] __do_softirq+0xdc/0x598
[   39.701460] hardirqs last disabled at (19119): [<c0d0afb0>] _raw_read_lock_irqsave+0x84/0x88
[   39.709883] softirqs last  enabled at (19108): [<c01016b4>] __do_softirq+0x334/0x598
[   39.717609] softirqs last disabled at (19117): [<c012bdb0>] __irq_exit_rcu+0x124/0x1a8
[   39.725511] 
[   39.725511] other info that might help us debug this:
[   39.732021]  Possible unsafe locking scenario:
[   39.732021] 
[   39.737924]        CPU0
[   39.740360]        ----
[   39.742796]   lock(&inode->i_size_seqcount);
[   39.747056]   <Interrupt>
[   39.749665]     lock(&inode->i_size_seqcount);
[   39.754098] 
[   39.754098]  *** DEADLOCK ***
[   39.754098] 
[   39.760001] 1 lock held by rngd/218:
[   39.763566]  #0: c284d950 (&ni->size_lock){...-}-{2:2}, at: ntfs_end_buffer_async_read+0x68/0x458
[   39.772432] 
[   39.772432] stack backtrace:
[   39.776777] CPU: 0 PID: 218 Comm: rngd Not tainted 6.0.0-rc3-next-20220901-00130-gb6b3fb681f34-dirty #8
[   39.786149] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   39.792401]  unwind_backtrace from show_stack+0x10/0x14
[   39.797618]  show_stack from dump_stack_lvl+0x58/0x70
[   39.802660]  dump_stack_lvl from mark_lock.part.0+0xb80/0x1298
[   39.808482]  mark_lock.part.0 from __lock_acquire+0xa70/0x29fc
[   39.814304]  __lock_acquire from lock_acquire+0x11c/0x3c8
[   39.819691]  lock_acquire from ntfs_end_buffer_async_read+0xac/0x458
[   39.826033]  ntfs_end_buffer_async_read from end_bio_bh_io_sync+0x30/0x4c
[   39.832809]  end_bio_bh_io_sync from blk_update_request+0x158/0x57c
[   39.839064]  blk_update_request from scsi_end_request+0x1c/0x3d4
[   39.845059]  scsi_end_request from scsi_io_completion+0x38/0x688
[   39.851053]  scsi_io_completion from blk_complete_reqs+0x54/0x60
[   39.857047]  blk_complete_reqs from __do_softirq+0x134/0x598
[   39.862694]  __do_softirq from __irq_exit_rcu+0x124/0x1a8
[   39.868083]  __irq_exit_rcu from irq_exit+0x8/0x28
[   39.872866]  irq_exit from call_with_stack+0x18/0x20
[   39.877824]  call_with_stack from __irq_usr+0x7c/0xa0
[   39.882868] Exception stack(0xf0c69fb0 to 0xf0c69ff8)
[   39.887906] 9fa0:                                     553c47b7 41bd9715 553c47b7 b6b5e9d8
[   39.896065] 9fc0: b6b5ea40 00000000 00000000 b62046a0 0000000a b635f000 beefcbf4 b6b5e924
[   39.904223] 9fe0: 0000001d b6b5e910 b6f448ec b6f44900 80000010 ffffffff
 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram13: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/ram14: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optima[   39.951621] ntfs: volume version 3.1.
l): 4096 bytes / 4096 bytes
Disk /dev/ram15: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk /dev/mmcblk1: 14.68 GiB, 15758000128 bytes, 30777344 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 00F7EF05-A1E9-E53A-CA0B-CBD0484764BD
Device            Start      End  Sectors  Size Type
/dev/mmcblk1p1    49152 29908991 29859840 14.2G Linux filesystem
/dev/mmcblk1p2 29908992 29917183     8192    4M Microsoft basic data
/dev/mmcblk1p3 29917184 30048255   131072   64M Microsoft basic data
/dev/mmcblk1p4 30048256 30056447     8192    4M Microsoft basic data
/dev/mmcblk1p5 30056448 30064639     8192    4M Microsoft basic data
/dev/mmcblk1p6 30064640 30072831     8192    4M Microsoft basic data
/dev/mmcblk1p7 30072832 30081023     8192    4M Microsoft basic data
/dev/mmcblk1p8 30081024 30773247   692224  338M Microsoft basic data
Disk /dev/mmcblk1boot0: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk /dev/mmcblk1boot1: 4 MiB, 4194304 bytes, 8192 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk /dev/sda: 149.05 GiB, 160041885696 bytes, 312581808 sectors
Disk model: WDC WD1600BEVS-6
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x40aa40aa
Device     Boot     Start       End   Sectors   Size Id Type
/dev/sda1  *           63 296929394 296929332 141.6G  7 HPFS/NTFS/exFAT
/dev/sda2       296929395 312576704  15647310   7.5G  7 HPFS/NTFS/exFAT

Regards
