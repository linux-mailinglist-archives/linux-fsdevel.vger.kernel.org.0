Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9384A2027E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 04:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgFUCEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 22:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgFUCEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 22:04:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D50C061795
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 19:04:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e3so3765554qts.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HrM/aL+rP+jwpRhmwVKM6lQRKxLRQj24MmhFczrBNmA=;
        b=GOltPwYO5wJXMMXNL3yd397Ul8NGU252WyzZDvNjlBm+PRTC9N7MO8Cr/swUqhlHyQ
         ZnWclFqhb2UZrPTvZrFtCZuvVPc9/5caHs/xrrjTOg8f/ex7VDUBDOr83wvH8YI+9Su5
         BWx3dbSul1CuTEJS4IkEEkf303HQ4aOVNS9i6cnFXt8s2YbafxwoYUW+/9nBJeqGFYuG
         LQTKLZFDuSva0VxN5lcXD5RD1vgMAfGmh2Il/1d2eUADg1Nye/gEHoeaOSCfM6vxXCzU
         XrfVh3nJOMAF+bG8hhe0Y5QE+3Vg+aI5yTf0agt/PRtkwmNc8TTeD/nNqgoLhS235+9e
         7MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrM/aL+rP+jwpRhmwVKM6lQRKxLRQj24MmhFczrBNmA=;
        b=ahYPOA7ECEC47gITUQm7tv2QMqnWdJyzdrQ8Tpfd7HdaSpzR1k+RTM/mnfoLAkEuxV
         tj/NDwn30iNWNPbVwW57dVqquqTIlzdHZykQmvkbngq0dKhmJFO4++8k71oC6NhZyz6D
         NIiwurYaUIOkMQZEdACdCXSg7w66I9wM7Y6Ctu1yNGemlH0gSQYJewV2SNsGsG+jJcOj
         5ahJTwZl7WgHbkMglmTawE2IsBwawO2ma2ron7cZ9gR4lx0DABxRlIdNgdB9gOINJQLX
         J+BBUeVuawF8C+PyHJvPcYMaAOta3mOYsozh6nfunznlj3w8iNEHKR/qLkwzWx21Nz33
         wPLw==
X-Gm-Message-State: AOAM5328HCpGpaxsyCzQyED9jTkykMg3cskGZcDFiEXfI6bQsRj6A+fp
        uj8aBQxJe0uZ7qmAVW8pP+Q0Q6HkTzOTDA==
X-Google-Smtp-Source: ABdhPJxGrm3cdzsa3SNMyJy4IgGi/ke1/52ZpDfhu/iW9BHHidDZV6y7s3D8reiqcEtRtft6yL3hdQ==
X-Received: by 2002:aed:2966:: with SMTP id s93mr9913179qtd.331.1592705082456;
        Sat, 20 Jun 2020 19:04:42 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c27sm1136531qka.23.2020.06.20.19.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 19:04:41 -0700 (PDT)
Date:   Sat, 20 Jun 2020 22:04:32 -0400
From:   Qian Cai <cai@lca.pw>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     darrick.wong@oracle.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: WARN_ON_ONCE(1) in iomap_dio_actor()
Message-ID: <20200621020432.GA1597@lca.pw>
References: <20200619211750.GA1027@lca.pw>
 <20200620001747.GC8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620001747.GC8681@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:17:47PM -0700, Matthew Wilcox wrote:
> On Fri, Jun 19, 2020 at 05:17:50PM -0400, Qian Cai wrote:
> > Running a syscall fuzzer by a normal user could trigger this,
> > 
> > [55649.329999][T515839] WARNING: CPU: 6 PID: 515839 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x29c/0x420
> ...
> > 371 static loff_t
> > 372 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> > 373                 void *data, struct iomap *iomap, struct iomap *srcmap)
> > 374 {
> > 375         struct iomap_dio *dio = data;
> > 376
> > 377         switch (iomap->type) {
> > 378         case IOMAP_HOLE:
> > 379                 if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
> > 380                         return -EIO;
> > 381                 return iomap_dio_hole_actor(length, dio);
> > 382         case IOMAP_UNWRITTEN:
> > 383                 if (!(dio->flags & IOMAP_DIO_WRITE))
> > 384                         return iomap_dio_hole_actor(length, dio);
> > 385                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > 386         case IOMAP_MAPPED:
> > 387                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > 388         case IOMAP_INLINE:
> > 389                 return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> > 390         default:
> > 391                 WARN_ON_ONCE(1);
> > 392                 return -EIO;
> > 393         }
> > 394 }
> > 
> > Could that be iomap->type == IOMAP_DELALLOC ? Looking throught the logs,
> > it contains a few pread64() calls until this happens,
> 
> It _shouldn't_ be able to happen.  XFS writes back ranges which exist
> in the page cache upon seeing an O_DIRECT I/O.  So it's not supposed to
> be possible for there to be an extent which is waiting for the contents
> of the page cache to be written back.

BTW, this is rather easy to reproduce where it happens on x86 as well.

[ 1248.397398] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
[ 1248.418261] flags: 0xbfffc000010200(slab|head)
[ 1248.473270] File: /tmp/trinity-testfile2 (deleted) PID: 18127 Comm: trinity-c33
[ 1248.475128] ------------[ cut here ]------------
[ 1248.475130] WARNING: CPU: 54 PID: 18127 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x319/0x480
[ 1248.475131] Modules linked in: nls_ascii nls_cp437 vfat fat kvm_intel kvm irqbypass efivars efivarfs ip_tables x_tables sd_mod hpsa scsi_transport_sas be2net firmware_class dm_mirror dm_region_hash dm_log dm_mod
[ 1248.475150] CPU: 54 PID: 18127 Comm: trinity-c33 Not tainted 5.8.0-rc1-next-20200618 #1
[ 1248.475151] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 01/22/2018
[ 1248.475152] RIP: 0010:iomap_dio_actor+0x319/0x480
[ 1248.475154] Code: 24 f6 43 27 40 0f 84 62 ff ff ff 48 83 c4 20 48 89 d9 48 89 ea 4c 89 e6 5b 4c 89 ff 5d 41 5c 41 5d 41 5e 41 5f e9 f7 ee ff ff <0f> 0b 48 83 c4 20 48 c7 c0 fb ff ff ff 5b 5d 41 5c 41 5d 41 5e 41
[ 1248.475156] RSP: 0018:ffffc9003041f6f8 EFLAGS: 00010202
[ 1248.475158] RAX: 0000000000000001 RBX: ffff888c5e4bdd00 RCX: ffff888c5e4bdd00
[ 1248.475159] RDX: 1ffff92006083ef9 RSI: 00000000001ff000 RDI: ffffc9003041f7c8
[ 1248.475160] RBP: 0000000000001000 R08: ffffc9003041f7b0 R09: ffffc9003041f7b0
[ 1248.475162] R10: ffff888c678b2e1b R11: ffffed118cf165c3 R12: 00000000001ff000
[ 1248.475163] R13: 00000000001ff000 R14: ffff888c4ded4f08 R15: ffff888c4ded4f08
[ 1248.475164] FS:  00007f34c3897740(0000) GS:ffff888c67880000(0000) knlGS:0000000000000000
[ 1248.475165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1248.475166] CR2: 00007f34c13ff000 CR3: 0000000abd5c0004 CR4: 00000000001606e0
[ 1248.475167] Call Trace:
[ 1248.475168]  iomap_apply+0x258/0xb02
[ 1248.475169]  ? iomap_dio_bio_actor+0xdf0/0xdf0
[ 1248.475170]  ? trace_event_raw_event_iomap_apply+0x420/0x420
[ 1248.475171]  ? generic_write_checks+0x320/0x320
[ 1248.475172]  ? ___ratelimit+0x1c6/0x400
[ 1248.475173]  iomap_dio_rw+0x7ac/0xfe0
[ 1248.475174]  ? iomap_dio_bio_actor+0xdf0/0xdf0
[ 1248.475176]  ? iomap_dio_complete+0x710/0x710
[ 1248.475177]  ? down_read_nested+0x114/0x430
[ 1248.475179]  ? downgrade_write+0x3a0/0x3a0
[ 1248.475181]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 1248.475183]  ? xfs_file_dio_aio_read+0x1d5/0x4c0
[ 1248.475185]  xfs_file_dio_aio_read+0x1d5/0x4c0
[ 1248.475186]  ? lock_downgrade+0x720/0x720
[ 1248.475188]  xfs_file_read_iter+0x3e3/0x6b0
[ 1248.475190]  do_iter_readv_writev+0x472/0x6e0
[ 1248.475192]  ? default_llseek+0x240/0x240
[ 1248.475194]  ? _copy_from_user+0xbe/0x100
[ 1248.475196]  ? lock_acquire+0x1ac/0xaf0
[ 1248.475197]  ? __fdget_pos+0x9c/0xb0
[ 1248.475199]  do_iter_read+0x1eb/0x5a0
[ 1248.475201]  vfs_readv+0xc7/0x130
[ 1248.475203]  ? __mutex_lock+0x4aa/0x1390
[ 1248.475205]  ? rw_copy_check_uvector+0x380/0x380
[ 1248.475206]  ? __fdget_pos+0x9c/0xb0
[ 1248.475208]  ? find_held_lock+0x33/0x1c0
[ 1248.475210]  ? __task_pid_nr_ns+0x1d1/0x3f0
[ 1248.475212]  do_readv+0xfb/0x1e0
[ 1248.475213]  ? vfs_readv+0x130/0x130
[ 1248.475216]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
[ 1248.475217]  ? do_syscall_64+0x24/0x310
[ 1248.475219]  do_syscall_64+0x5f/0x310
[ 1248.475221]  ? asm_exc_page_fault+0x8/0x30
[ 1248.475223]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1248.475225] RIP: 0033:0x7f34c31aa6ed
[ 1248.475226] Code: Bad RIP value.
[ 1248.475228] RSP: 002b:00007ffc2c0bc698 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
[ 1248.475230] RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 00007f34c31aa6ed
[ 1248.475232] RDX: 000000000000008c RSI: 00000000038113c0 RDI: 00000000000001b3
[ 1248.475233] RBP: 0000000000000013 R08: 0000000000010000 R09: fffffffffffffff6
[ 1248.475234] R10: 0000020010120040 R11: 0000000000000246 R12: 0000000000000002
[ 1248.475236] R13: 00007f34c37b0058 R14: 00007f34c38976c0 R15: 00007f34c37b0000
[ 1248.475237] irq event stamp: 191529
[ 1248.475238] hardirqs last  enabled at (191529): [<ffffffff98800ace>] asm_exc_page_fault+0x1e/0x30
[ 1248.475239] hardirqs last disabled at (191528): [<ffffffff98779f6d>] exc_page_fault+0x5dd/0xe90
[ 1248.475241] softirqs last  enabled at (189658): [<ffffffff98a007c2>] __do_softirq+0x7c2/0xb70
[ 1248.475242] softirqs last disabled at (189651): [<ffffffff98800f02>] asm_call_on_stack+0x12/0x20

> 
> > [child21:124180] [17] pread64(fd=353, buf=0x0, count=0x59b5, pos=0xe0e0e0e) = -1 (Illegal seek)
> > [child21:124180] [339] pread64(fd=339, buf=0xffffbcc40000, count=0xbd71, pos=0xff26) = -1 (Illegal seek)
> > [child21:124627] [136] pread64(fd=69, buf=0xffffbd290000, count=0xee42, pos=2) = -1 (Illegal seek)
> > [child21:124627] [196] pread64(fd=83, buf=0x1, count=0x62f8, pos=0x15390000) = -1 (Illegal seek)
> > [child21:125127] [154] pread64(fd=345, buf=0xffffbcc40000, count=9332, pos=0xffbd) = 9332
> > [child21:125169] [188] pread64(fd=69, buf=0xffffbce90000, count=0x4d47, pos=0) = -1 (Illegal seek)
> > [child21:125169] [227] pread64(fd=345, buf=0x1, count=0xe469, pos=1046) = -1 (Bad address)
> > [child21:125569] [354] pread64(fd=87, buf=0xffffbcc50000, count=0x4294, pos=0x16161616) = -1 (Illegal seek)
> > [child21:125569] [655] pread64(fd=341, buf=0xffffbcc70000, count=2210, pos=0xffff) = -1 (Illegal seek)
> > [child21:125569] [826] pread64(fd=343, buf=0x8, count=0xeb22, pos=0xc090c202e598b) = 0
> > [child21:126233] [261] pread64(fd=338, buf=0xffffbcc40000, count=0xe8fe, pos=105) = -1 (Illegal seek)
> > [child21:126233] [275] pread64(fd=190, buf=0x8, count=0x9c24, pos=116) = -1 (Is a directory)
> > [child21:126882] [32] pread64(fd=86, buf=0xffffbcc40000, count=0x7fc2, pos=2) = -1 (Illegal seek)
> > [child21:127448] [14] pread64(fd=214, buf=0x4, count=11371, pos=0x9b26) = 0
> > [child21:127489] [70] pread64(fd=339, buf=0xffffbcc70000, count=0xb07a, pos=8192) = -1 (Illegal seek)
> > [child21:127489] [80] pread64(fd=339, buf=0x0, count=6527, pos=205) = -1 (Illegal seek)
> > [child21:127489] [245] pread64(fd=69, buf=0x8, count=0xbba2, pos=47) = -1 (Illegal seek)
> > [child21:128098] [334] pread64(fd=353, buf=0xffffbcc90000, count=0x4540, pos=168) = -1 (Illegal seek)
> > [child21:129079] [157] pread64(fd=422, buf=0x0, count=0x80df, pos=0xdfef6378b650aa) = 0
> > [child21:134700] [275] pread64(fd=397, buf=0xffffbcc50000, count=0xdee6, pos=0x887b1e74a2) = -1 (Illegal seek)
> > [child21:135042] [7] pread64(fd=80, buf=0x8, count=0xc494, pos=216) = -1 (Illegal seek)
> > [child21:135056] [188] pread64(fd=430, buf=0xffffbd090000, count=0xbe66, pos=0x3a3a3a3a) = -1 (Illegal seek)
> > [child21:135442] [143] pread64(fd=226, buf=0xffffbd390000, count=11558, pos=0x1000002d) = 0
> > [child21:135513] [275] pread64(fd=69, buf=0x4, count=4659, pos=0x486005206c2986) = -1 (Illegal seek)
> > [child21:135513] [335] pread64(fd=339, buf=0xffffbd090000, count=0x90fd, pos=253) = -1 (Illegal seek)
> > [child21:135513] [392] pread64(fd=76, buf=0xffffbcc40000, count=0xf324, pos=0x5d5d5d5d) = -1 (Illegal seek)
> > [child21:135665] [5] pread64(fd=431, buf=0xffffbcc70000, count=10545, pos=16384) = -1 (Illegal seek)
> > [child21:135665] [293] pread64(fd=349, buf=0x4, count=0xd2ad, pos=0x2000000) = -1 (Illegal seek)
> > [child21:135790] [99] pread64(fd=76, buf=0x8, count=0x70d7, pos=0x21000440) = -1 (Illegal seek)
> > [child21:135790] [149] pread64(fd=70, buf=0xffffbd5b0000, count=0x53f3, pos=255) = -1 (Illegal seek)
> > [child21:135790] [301] pread64(fd=348, buf=0x4, count=5713, pos=0x6c00401a) = -1 (Illegal seek)
> > [child21:136162] [570] pread64(fd=435, buf=0x1, count=11182, pos=248) = -1 (Illegal seek)
> > [child21:136162] [584] pread64(fd=78, buf=0xffffbcc40000, count=0xa401, pos=8192) = -1 (Illegal seek)
> > [child21:138090] [167] pread64(fd=339, buf=0x4, count=0x6aba, pos=256) = -1 (Illegal seek)
> > [child21:138090] [203] pread64(fd=348, buf=0xffffbcc90000, count=0x8625, pos=128) = -1 (Illegal seek)
> > [child21:138551] [174] pread64(fd=426, buf=0x0, count=0xd582, pos=0xd7e8674d0a86) = 0
> > [child21:138551] [179] pread64(fd=426, buf=0xffffbce90000, count=0x415a, pos=0x536e873600750b2d) = 0
> > [child21:138988] [306] pread64(fd=436, buf=0x8, count=0x62e6, pos=0x445c403204924c1) = -1 (Illegal seek)
> > [child21:138988] [353] pread64(fd=427, buf=0x4, count=0x993b, pos=176) = 0
