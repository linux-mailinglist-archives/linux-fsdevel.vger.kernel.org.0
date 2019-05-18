Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAC2211A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfERBKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 21:10:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33758 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfERBKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 21:10:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id y3so4118094plp.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UtqBDhgZSxRsvgyaEKOg8hsLb7u2xZnA9wyebHltq34=;
        b=G3VMolpTrrd4Yv5umrCdeC38pW25lS+p5HGu1XUo8F4XclE2xxl0znlPbumeJo7NHU
         Y7nrGArtuAGyukjAb8E/1WhLPNpN9FlA38tic1z8L1iEXcQdkawqazs8zcqJJA7Izf5u
         wF3ejkf080G3Y0vN9ODV5KckdhdvsUk/x/q7WDXhCA8pbf8mPxSjeC6QuhaC8VgGSZlQ
         TmReMYwXKe37iXj9kF9otUPTTGG5nsW0AhHz14gZkOd2vvvuaNj+lYeuV0RTBwDn4e9j
         6y/M+F4153GeRmyItfmRcmX1ulYUZlYJ8c7ZSNna15CY0siWBcqgiueBO2qW4JVQCr2J
         sBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UtqBDhgZSxRsvgyaEKOg8hsLb7u2xZnA9wyebHltq34=;
        b=JNb0hz1UW5SZrQFADej5VH/vN93UrehWZ9Asn466HgX3idEZ+NvROuncRkfU1dHQUu
         gWo3SDayW9JqlwiLbhjvZswUomSYYnrWbxudcf5c3svdKbXze/Gq+b5LX0L1y1hhbOEl
         y77T11TUOF00Kow1PUMCWpoLPSXK+eNkHdMf4f9KcfX4v+FuQBbcymBkvzIQcEQVKr/f
         5wTQ8llffz2pfcXQqGaFX9/qW54eWk6G+KUXCJDLBZSFX5s54ypxTrgXwmKM05nkH+Hw
         hE6D69+P5sH0nzNe43qkyBRlCklNgeYm+c94LQWZyB7t+Q+hBqmWhgbfxV9Npt4bOlhi
         itfQ==
X-Gm-Message-State: APjAAAU655UHZF+inkVfrczdHKEndDRqc8+HeNY3OSHXwc0sj6UT4WEO
        gb9vF01RSqomdVgtrjftgJF3+Q==
X-Google-Smtp-Source: APXvYqyW6IsxNgeo0m9f4F41CWO5GF4BQUa1tfa3jRDGYk0obEgrMO15GmTcJC724lEmmPB0PLAjaQ==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr58666645plf.327.1558141815934;
        Fri, 17 May 2019 18:10:15 -0700 (PDT)
Received: from jstaron2.mtv.corp.google.com ([2620:15c:202:201:b94f:2527:c39f:ca2d])
        by smtp.gmail.com with ESMTPSA id e14sm11933415pff.60.2019.05.17.18.10.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 18:10:14 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jack@suse.cz, mst@redhat.com,
        jasowang@redhat.com, david@fromorbit.com, lcapitulino@redhat.com,
        adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com,
        zwisler@kernel.org, aarcange@redhat.com,
        dave jiang <dave.jiang@intel.com>,
        darrick wong <darrick.wong@oracle.com>,
        vishal l verma <vishal.l.verma@intel.com>, david@redhat.com,
        willy@infradead.org, hch@infradead.org, jmoyer@redhat.com,
        nilal@redhat.com, lenb@kernel.org, kilobyte@angband.pl,
        riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
        stefanha@redhat.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com,
        tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        cohuck@redhat.com, rjw@rjwysocki.net, imammedo@redhat.com
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
 <c06514fd-8675-ba74-4b7b-ff0eb4a91605@google.com>
 <1954162775.29408078.1558071358974.JavaMail.zimbra@redhat.com>
From:   =?UTF-8?Q?Jakub_Staro=c5=84?= <jstaron@google.com>
Message-ID: <5e27fa73-53f5-007a-e0c1-f32f83e5764f@google.com>
Date:   Fri, 17 May 2019 18:10:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1954162775.29408078.1558071358974.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/16/19 10:35 PM, Pankaj Gupta wrote:
> Can I take it your reviewed/acked-by? or tested-by tag? for the virtio patch :)I don't feel that I have enough expertise to give the reviewed-by tag, but you can
take my acked-by + tested-by.

Acked-by: Jakub Staron <jstaron@google.com>
Tested-by: Jakub Staron <jstaron@google.com>

No kernel panics/stalls encountered during testing this patches (v9) with QEMU + xfstests.
Some CPU stalls encountered while testing with crosvm instead of QEMU with xfstests
(test generic/464) but no repro for QEMU, so the fault may be on the side of crosvm.


The dump for the crosvm/xfstests stall:
[ 2504.175276] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 2504.176681] rcu:     0-...!: (1 GPs behind) idle=9b2/1/0x4000000000000000 softirq=1089198/1089202 fqs=0 
[ 2504.178270] rcu:     2-...!: (1 ticks this GP) idle=cfe/1/0x4000000000000002 softirq=1055108/1055110 fqs=0 
[ 2504.179802] rcu:     3-...!: (1 GPs behind) idle=1d6/1/0x4000000000000002 softirq=1046798/1046802 fqs=0 
[ 2504.181215] rcu:     4-...!: (2 ticks this GP) idle=522/1/0x4000000000000002 softirq=1249063/1249064 fqs=0 
[ 2504.182625] rcu:     5-...!: (1 GPs behind) idle=6da/1/0x4000000000000000 softirq=1131036/1131047 fqs=0 
[ 2504.183955]  (detected by 3, t=0 jiffies, g=1232529, q=1370)
[ 2504.184762] Sending NMI from CPU 3 to CPUs 0:
[ 2504.186400] NMI backtrace for cpu 0
[ 2504.186401] CPU: 0 PID: 6670 Comm: 464 Not tainted 5.1.0+ #1
[ 2504.186401] Hardware name: ChromiumOS crosvm, BIOS 0 
[ 2504.186402] RIP: 0010:queued_spin_lock_slowpath+0x1c/0x1e0
[ 2504.186402] Code: e7 89 c8 f0 44 0f b1 07 39 c1 75 dc f3 c3 0f 1f 44 00 00 ba 01 00 00 00 8b 07 85 c0 75 0a f0 0f b1 17 85 c0 75 f2 f3 c3 f3 90 <eb> ec 81 fe 00 01 00 00 0f 84 ab 00 00 00 81 e6 00 ff ff ff 75 44
[ 2504.186403] RSP: 0018:ffffc90000003ee8 EFLAGS: 00000002
[ 2504.186404] RAX: 0000000000000001 RBX: 0000000000000246 RCX: 0000000000404044
[ 2504.186404] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff8244a280
[ 2504.186405] RBP: ffffffff8244a280 R08: 00000000000f4200 R09: 0000024709ed6c32
[ 2504.186405] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8244a280
[ 2504.186405] R13: 0000000000000009 R14: 0000000000000009 R15: 0000000000000000
[ 2504.186406] FS:  0000000000000000(0000) GS:ffff8880cc600000(0000) knlGS:0000000000000000
[ 2504.186406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2504.186406] CR2: 00007efd6b0f15d8 CR3: 000000000260a006 CR4: 0000000000360ef0
[ 2504.186407] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2504.186407] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2504.186407] Call Trace:
[ 2504.186408]  <IRQ>
[ 2504.186408]  _raw_spin_lock_irqsave+0x1d/0x30
[ 2504.186408]  rcu_core+0x3b6/0x740
[ 2504.186408]  ? __hrtimer_run_queues+0x133/0x280
[ 2504.186409]  ? recalibrate_cpu_khz+0x10/0x10
[ 2504.186409]  __do_softirq+0xd8/0x2e4
[ 2504.186409]  irq_exit+0xa3/0xb0
[ 2504.186410]  smp_apic_timer_interrupt+0x67/0x120
[ 2504.186410]  apic_timer_interrupt+0xf/0x20
[ 2504.186410]  </IRQ>
[ 2504.186410] RIP: 0010:unmap_page_range+0x47a/0x9b0
[ 2504.186411] Code: 0f 46 46 10 49 39 6e 18 49 89 46 10 48 89 e8 49 0f 43 46 18 41 80 4e 20 08 4d 85 c9 49 89 46 18 0f 84 68 ff ff ff 49 8b 51 08 <48> 8d 42 ff 83 e2 01 49 0f 44 c1 f6 40 18 01 75 38 48 ba ff 0f 00
[ 2504.186411] RSP: 0018:ffffc900036cbcc8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[ 2504.186412] RAX: ffffffffffffffff RBX: 800000003751d045 RCX: 0000000000000001
[ 2504.186413] RDX: ffffea0002e09288 RSI: 000000000269b000 RDI: ffff8880b6525e40
[ 2504.186413] RBP: 000000000269c000 R08: 0000000000000000 R09: ffffea0000dd4740
[ 2504.186413] R10: ffffea0001755700 R11: ffff8880cc62d120 R12: 0000000002794000
[ 2504.186414] R13: 000000000269b000 R14: ffffc900036cbdf0 R15: ffff8880572434d8
[ 2504.186414]  ? unmap_page_range+0x420/0x9b0
[ 2504.186414]  ? release_pages+0x175/0x390
[ 2504.186414]  unmap_vmas+0x7c/0xe0
[ 2504.186415]  exit_mmap+0xa4/0x190
[ 2504.186415]  mmput+0x3b/0x100
[ 2504.186415]  do_exit+0x276/0xc10
[ 2504.186415]  do_group_exit+0x35/0xa0
[ 2504.186415]  __x64_sys_exit_group+0xf/0x10
[ 2504.186416]  do_syscall_64+0x43/0x120
[ 2504.186416]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2504.186416] RIP: 0033:0x7efd6ae10618
[ 2504.186416] Code: Bad RIP value.
[ 2504.186417] RSP: 002b:00007ffcac9bde38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[ 2504.186417] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efd6ae10618
[ 2504.186418] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[ 2504.186418] RBP: 00007efd6b0ed8e0 R08: 00000000000000e7 R09: ffffffffffffff98
[ 2504.186418] R10: 00007ffcac9bddb8 R11: 0000000000000246 R12: 00007efd6b0ed8e0
[ 2504.186419] R13: 00007efd6b0f2c20 R14: 0000000000000060 R15: 000000000070e705
[ 2504.186421] NMI backtrace for cpu 3
[ 2504.226980] CPU: 3 PID: 6596 Comm: xfs_io Not tainted 5.1.0+ #1
[ 2504.227661] Hardware name: ChromiumOS crosvm, BIOS 0 
[ 2504.228261] Call Trace:
[ 2504.228552]  <IRQ>
[ 2504.228795]  dump_stack+0x46/0x5b
[ 2504.229180]  nmi_cpu_backtrace+0x89/0x90
[ 2504.229649]  ? lapic_can_unplug_cpu+0x90/0x90
[ 2504.230157]  nmi_trigger_cpumask_backtrace+0x82/0xc0
[ 2504.230751]  rcu_dump_cpu_stacks+0x8b/0xb7
[ 2504.231222]  rcu_sched_clock_irq+0x6f6/0x720
[ 2504.231726]  ? tick_sched_do_timer+0x50/0x50
[ 2504.232214]  update_process_times+0x23/0x50
[ 2504.232693]  tick_sched_handle+0x2f/0x40
[ 2504.233144]  tick_sched_timer+0x32/0x70
[ 2504.233594]  __hrtimer_run_queues+0x103/0x280
[ 2504.234092]  hrtimer_interrupt+0xe0/0x240
[ 2504.234580]  smp_apic_timer_interrupt+0x5d/0x120
[ 2504.235152]  apic_timer_interrupt+0xf/0x20
[ 2504.235627]  </IRQ>
[ 2504.235879] RIP: 0010:__memcpy_flushcache+0x4b/0x180
[ 2504.236452] Code: 8d 5d e0 4c 8d 62 20 48 89 f7 48 29 d7 48 89 d9 48 83 e1 e0 4c 01 e1 48 8d 04 17 4c 8b 02 4c 8b 4a 08 4c 8b 52 10 4c 8b 5a 18 <4c> 0f c3 00 4c 0f c3 48 08 4c 0f c3 50 10 4c 0f c3 58 18 48 83 c2
[ 2504.238592] RSP: 0018:ffffc90003ae38e8 EFLAGS: 00010286 ORIG_RAX: ffffffffffffff13
[ 2504.239467] RAX: ffff888341800000 RBX: 0000000000000fe0 RCX: ffff88801bd22000
[ 2504.240277] RDX: ffff88801bd21000 RSI: ffff888341800000 RDI: 0000000325adf000
[ 2504.241092] RBP: 0000000000001000 R08: cdcdcdcdcdcdcdcd R09: cdcdcdcdcdcdcdcd
[ 2504.241908] R10: cdcdcdcdcdcdcdcd R11: cdcdcdcdcdcdcdcd R12: ffff88801bd21020
[ 2504.242751] R13: ffff8880b916b600 R14: ffff888341800000 R15: ffffea00006f4840
[ 2504.243602]  write_pmem+0x61/0x90
[ 2504.244002]  pmem_do_bvec+0x178/0x2c0
[ 2504.244469]  ? chksum_update+0xe/0x20
[ 2504.244908]  pmem_make_request+0xf7/0x270
[ 2504.245509]  generic_make_request+0x199/0x3f0
[ 2504.246179]  ? submit_bio+0x67/0x130
[ 2504.246710]  submit_bio+0x67/0x130
[ 2504.247117]  ext4_io_submit+0x44/0x50
[ 2504.247556]  ext4_writepages+0x621/0xe80
[ 2504.248028]  ? 0xffffffff81000000
[ 2504.248418]  ? do_writepages+0x46/0xd0
[ 2504.248880]  ? ext4_mark_inode_dirty+0x1d0/0x1d0
[ 2504.249417]  do_writepages+0x46/0xd0
[ 2504.249833]  ? release_pages+0x175/0x390
[ 2504.250290]  ? __filemap_fdatawrite_range+0x7c/0xb0
[ 2504.250879]  __filemap_fdatawrite_range+0x7c/0xb0
[ 2504.251427]  ext4_release_file+0x67/0xa0
[ 2504.251897]  __fput+0xb1/0x220
[ 2504.252260]  task_work_run+0x79/0xa0
[ 2504.252676]  do_exit+0x2ca/0xc10
[ 2504.253063]  ? __switch_to_asm+0x40/0x70
[ 2504.253530]  ? __switch_to_asm+0x34/0x70
[ 2504.253995]  ? __switch_to_asm+0x40/0x70
[ 2504.254446]  do_group_exit+0x35/0xa0
[ 2504.254865]  get_signal+0x14e/0x7a0
[ 2504.255281]  ? __switch_to_asm+0x34/0x70
[ 2504.255749]  ? __switch_to_asm+0x40/0x70
[ 2504.256224]  do_signal+0x2b/0x5e0
[ 2504.256619]  ? __switch_to_asm+0x40/0x70
[ 2504.257086]  ? __switch_to_asm+0x34/0x70
[ 2504.257552]  ? __switch_to_asm+0x40/0x70
[ 2504.258022]  ? __switch_to_asm+0x34/0x70
[ 2504.258488]  ? __schedule+0x253/0x530
[ 2504.258943]  ? __switch_to_asm+0x34/0x70
[ 2504.259398]  exit_to_usermode_loop+0x87/0xa0
[ 2504.259900]  do_syscall_64+0xf7/0x120
[ 2504.260326]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2504.260923] RIP: 0033:0x7faf347e28bd
[ 2504.261348] Code: Bad RIP value.
[ 2504.261727] RSP: 002b:00007faf33fc5f40 EFLAGS: 00000293 ORIG_RAX: 0000000000000022
[ 2504.262594] RAX: fffffffffffffdfe RBX: 0000000000000000 RCX: 00007faf347e28bd
[ 2504.263416] RDX: 8b9da1f4246cdb38 RSI: 0000000000000000 RDI: 0000000000000000
[ 2504.264215] RBP: 0000000000000000 R08: 00007faf33fc6700 R09: 00007faf33fc6700
[ 2504.265061] R10: 000000000000012d R11: 0000000000000293 R12: 00007ffdf142327e
[ 2504.266082] R13: 00007ffdf142327f R14: 00007faf337c6000 R15: 0000000000000003

Arch: x86_64
Kernel: stable top with virtio-pmem v9 patches applied
Distro: Debian Stretch

But as I said, it may be just a problem with crosvm.


Thank you,
Jakub Staron
