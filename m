Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747D12414C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 04:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHKCDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 22:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgHKCDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:03:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78357C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 19:03:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so10392636qkk.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 19:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n6w7AedUzKNoG5yNf5WngxBbptMIjeyr30damMxLi38=;
        b=UtUSG9CkbKVXvOYIVulxf27t8zNeNvdSQAV+G9P//BUcp5qnuLJcrJoS3Q6FZ0cbca
         4jJWPF7zFOVe1ZdSVgLoWWxRiTE/SAvPFuvef1zl22jtaNb/CJyvrXIDQnriAOn/pZRY
         fBn69vxe7lGTGD1bxzCdlfATR66WPs5Nn/ehPOG2hK4YcU7J2LgSBfSVmtygHRya/YZt
         3F5HIKRimtpdjQZQ28fL4iV5VI97uKLfXV+rQNGjwQf4DWQlqw19/ZxuHyT8LmGWZocE
         Z43xoR8XtqFg20xhYEc/IVicXCtFV4Jzq9iPGoXMf5jx+Rx8YJVApmfpVK+otCwVwjrT
         67mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6w7AedUzKNoG5yNf5WngxBbptMIjeyr30damMxLi38=;
        b=q8N7JcngayS0p5Ga7SNYTiSDqPX6DKewUoP9sVVBxUzTjsasAsVL/Q6EVd77H2mkTv
         OYA0xREEtvZu69IX5LyKgD/V7tGVHE1IzI3RiEFbmbfFYUcMBDAn9eHDHQ5l9jg+Fr0L
         2pTxAePkmBmiSqaYLEnvTQNNxzGeCv5zMa5XlC2LGPONWT4VYnDBMFMetjwDBLa8e0GI
         rv8NsL3xlNBNOy2FRzaZQl8VwiQ12aMlxieLXgR18tLZKLcB/4ESev0prZFccVUkG35i
         Uzyi8rNoyEXUyke7ubtiBrtxNdWF8loAQ8AG23ZBGPhFg4gjIzYlAU52S03QJef5V0O6
         TxBw==
X-Gm-Message-State: AOAM533CI6N7nidphBWZLpfKnvvD8d3d9UEdkZPfGzIKvP/T1ztRYLig
        5y7QYuDBcMIfTRhIq0nS7dty9Q==
X-Google-Smtp-Source: ABdhPJyKlW905TrWERlopxviweYlTeA8W3IPWegBCxKgTIF10gsrOHqQaRtMIvyB9kH58Dt1fINlbg==
X-Received: by 2002:a37:d4c:: with SMTP id 73mr27437642qkn.445.1597111386334;
        Mon, 10 Aug 2020 19:03:06 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 139sm15631918qkl.13.2020.08.10.19.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 19:03:05 -0700 (PDT)
Date:   Mon, 10 Aug 2020 22:03:03 -0400
From:   Qian Cai <cai@lca.pw>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, khlebnikov@yandex-team.ru
Subject: Re: WARN_ON_ONCE(1) in iomap_dio_actor()
Message-ID: <20200811020302.GD5307@lca.pw>
References: <20200619211750.GA1027@lca.pw>
 <20200620001747.GC8681@bombadil.infradead.org>
 <20200724182431.GA4871@lca.pw>
 <20200726152412.GA26614@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726152412.GA26614@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 04:24:12PM +0100, Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 02:24:32PM -0400, Qian Cai wrote:
> > On Fri, Jun 19, 2020 at 05:17:47PM -0700, Matthew Wilcox wrote:
> > > On Fri, Jun 19, 2020 at 05:17:50PM -0400, Qian Cai wrote:
> > > > Running a syscall fuzzer by a normal user could trigger this,
> > > > 
> > > > [55649.329999][T515839] WARNING: CPU: 6 PID: 515839 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x29c/0x420
> > > ...
> > > > 371 static loff_t
> > > > 372 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> > > > 373                 void *data, struct iomap *iomap, struct iomap *srcmap)
> > > > 374 {
> > > > 375         struct iomap_dio *dio = data;
> > > > 376
> > > > 377         switch (iomap->type) {
> > > > 378         case IOMAP_HOLE:
> > > > 379                 if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
> > > > 380                         return -EIO;
> > > > 381                 return iomap_dio_hole_actor(length, dio);
> > > > 382         case IOMAP_UNWRITTEN:
> > > > 383                 if (!(dio->flags & IOMAP_DIO_WRITE))
> > > > 384                         return iomap_dio_hole_actor(length, dio);
> > > > 385                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > > 386         case IOMAP_MAPPED:
> > > > 387                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > > 388         case IOMAP_INLINE:
> > > > 389                 return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> > > > 390         default:
> > > > 391                 WARN_ON_ONCE(1);
> > > > 392                 return -EIO;
> > > > 393         }
> > > > 394 }
> > > > 
> > > > Could that be iomap->type == IOMAP_DELALLOC ? Looking throught the logs,
> > > > it contains a few pread64() calls until this happens,
> > > 
> > > It _shouldn't_ be able to happen.  XFS writes back ranges which exist
> > > in the page cache upon seeing an O_DIRECT I/O.  So it's not supposed to
> > > be possible for there to be an extent which is waiting for the contents
> > > of the page cache to be written back.
> > 
> > Okay, it is IOMAP_DELALLOC. We have,
> 
> Can you share the fuzzer?  If we end up with delalloc space here we
> probably need to fix a bug in the cache invalidation code.

Here is a simple reproducer (I believe it can also be reproduced using xfstests
generic/503 on a plain xfs without DAX when SCRATCH_MNT == TEST_DIR),

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random 14
- start: mmap_collision
wrote 20480/20480 bytes at offset 0
20 KiB, 5 ops; 0.0000 sec (673.491 MiB/sec and 172413.7931 ops/sec)
wrote 20480/20480 bytes at offset 0
20 KiB, 5 ops; 0.0000 sec (697.545 MiB/sec and 178571.4286 ops/sec)
wrote 20480/20480 bytes at offset 0
20 KiB, 5 ops; 0.0000 sec (723.380 MiB/sec and 185185.1852 ops/sec)
pread: Input/output error

[ 8944.905010][ T6995] ------------[ cut here ]------------
[ 8944.911193][ T6995] WARNING: CPU: 4 PID: 6995 at fs/iomap/direct-io.c:392 iomap_dio_actor+0x319/0x480
[ 8944.920498][ T6995] Modules linked in: nls_ascii nls_cp437 vfat fat kvm_amd ses enclosure kvm irqbypass efivars acpi_cpufreq efivarfs ip_tables x_tables sd_mod smartpqi scsi_transport_sas tg3 mlx5_core libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
[ 8944.943950][ T6995] CPU: 4 PID: 6995 Comm: random Not tainted 5.8.0-next-20200810+ #2
[ 8944.951855][ T6995] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
[ 8944.961162][ T6995] RIP: 0010:iomap_dio_actor+0x319/0x480
[ 8944.966622][ T6995] Code: 24 f6 43 27 40 0f 84 62 ff ff ff 48 83 c4 20 48 89 d9 48 89 ea 4c 89 e6 5b 4c 89 ff 5d 41 5c 41 5d 41 5e 41 5f e9 07 ef ff ff <0f> 0b 48 83 c4 20 48 c7 c0 fb ff ff ff 5b 5d 41 5c 41 5d 41 5e 41
[ 8944.986232][ T6995] RSP: 0018:ffffc90007d1f8d0 EFLAGS: 00010202
[ 8944.992203][ T6995] RAX: 0000000000000001 RBX: ffff88861b681c00 RCX: ffff88861b681c00
[ 8945.000105][ T6995] RDX: 1ffff92000fa3f33 RSI: 0000000000000000 RDI: ffffc90007d1f998
[ 8945.008014][ T6995] RBP: 0000000000001000 R08: ffffc90007d1f980 R09: ffffc90007d1f980
[ 8945.015920][ T6995] R10: ffffffffa72e72a7 R11: fffffbfff4e5ce54 R12: 0000000000000000
[ 8945.023805][ T6995] R13: ffff8888060e1388 R14: ffffffffa1f2e080 R15: ffff8888060e1388
[ 8945.031705][ T6995] FS:  00007fa50e389700(0000) GS:ffff88905ec00000(0000) knlGS:0000000000000000
[ 8945.040562][ T6995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8945.047063][ T6995] CR2: 00007fa50eb93000 CR3: 00000005ad9f2000 CR4: 00000000003506e0
[ 8945.054952][ T6995] Call Trace:
[ 8945.058147][ T6995]  iomap_apply+0x25a/0xb73
[ 8945.062453][ T6995]  ? iomap_dio_bio_actor+0xde0/0xde0
[ 8945.067650][ T6995]  ? generic_perform_write+0x410/0x410
[ 8945.073003][ T6995]  ? trace_event_raw_event_iomap_apply+0x420/0x420
[ 8945.079424][ T6995]  ? filemap_check_errors+0x51/0xe0
[ 8945.084514][ T6995]  iomap_dio_rw+0x644/0x1298
[ 8945.089011][ T6995]  ? iomap_dio_bio_actor+0xde0/0xde0
[ 8945.094192][ T6995]  ? iomap_dio_bio_end_io+0x4a0/0x4a0
[ 8945.099474][ T6995]  ? down_read_nested+0x10e/0x430
[ 8945.104391][ T6995]  ? downgrade_write+0x3a0/0x3a0
[ 8945.109237][ T6995]  ? rcu_read_lock_sched_held+0xaa/0xd0
[ 8945.114680][ T6995]  ? xfs_file_dio_aio_read+0x1d5/0x4c0
[ 8945.120051][ T6995]  xfs_file_dio_aio_read+0x1d5/0x4c0
[ 8945.125253][ T6995]  xfs_file_read_iter+0x3e3/0x6b0
[ 8945.130173][ T6995]  new_sync_read+0x39b/0x600
[ 8945.134648][ T6995]  ? vfs_dedupe_file_range+0x5f0/0x5f0
[ 8945.140022][ T6995]  ? __fget_files+0x1cb/0x300
[ 8945.144588][ T6995]  ? lock_downgrade+0x730/0x730
[ 8945.149346][ T6995]  ? rcu_read_lock_held+0xaa/0xc0
[ 8945.154265][ T6995]  vfs_read+0x226/0x450
[ 8945.158323][ T6995]  ksys_pread64+0x116/0x140
[ 8945.162714][ T6995]  ? __x64_sys_write+0xa0/0xa0
[ 8945.167386][ T6995]  ? syscall_enter_from_user_mode+0x20/0x210
[ 8945.173269][ T6995]  ? trace_hardirqs_on+0x20/0x1b5
[ 8945.178202][ T6995]  do_syscall_64+0x33/0x40
[ 8945.182512][ T6995]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 8945.188323][ T6995] RIP: 0033:0x7fa50e75e4b7
[ 8945.192628][ T6995] Code: 41 54 49 89 d4 55 48 89 f5 53 89 fb 48 83 ec 18 e8 3e f3 ff ff 4d 89 ea 4c 89 e2 48 89 ee 41 89 c0 89 df b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 74 f3 ff ff 48
[ 8945.212238][ T6995] RSP: 002b:00007fa50e388e70 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
[ 8945.220584][ T6995] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fa50e75e4b7
[ 8945.228489][ T6995] RDX: 0000000000004000 RSI: 00007fa50eb90000 RDI: 0000000000000004
[ 8945.236392][ T6995] RBP: 00007fa50eb90000 R08: 0000000000000000 R09: 00007fa50e746260
[ 8945.244278][ T6995] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000004000
[ 8945.252177][ T6995] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fa50e388fc0
[ 8945.260084][ T6995] irq event stamp: 8871
[ 8945.264129][ T6995] hardirqs last  enabled at (8879): [<ffffffffa0866c8f>] console_unlock+0x75f/0xaf0
[ 8945.273427][ T6995] hardirqs last disabled at (8888): [<ffffffffa086677d>] console_unlock+0x24d/0xaf0
[ 8945.282728][ T6995] softirqs last  enabled at (8236): [<ffffffffa1c0070f>] __do_softirq+0x70f/0xa9f
[ 8945.291857][ T6995] softirqs last disabled at (7067): [<ffffffffa1a00ec2>] asm_call_on_stack+0x12/0x20
[ 8945.301246][ T6995] ---[ end trace 2deaef5e80c278a7 ]---
