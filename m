Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50FC41BE77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 06:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbhI2Eqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 00:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243949AbhI2Eqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 00:46:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A1C06161C;
        Tue, 28 Sep 2021 21:45:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y186so1496272pgd.0;
        Tue, 28 Sep 2021 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YsU7ZhT+rluSy+wUpfWMbC0oCvAGTAQ9i/VLdumPV1Q=;
        b=nHSrWT9bWwawrg68rY5Vss1vCA59DdtrerGEfEagoupMYz78rAH1XFGyivUISbtaM5
         bkguw8I0OkKynEk2i2X0NwLaLuKCmRyAaDKaWSYRcXNPzex4wg9y+6D/GRK1uQMA/RpK
         DOkqz6aoTzMRgw/J6ZF24BVWbcWahIozvPExMypEZsXMWwRHx/RrTrcd5IJaEMAI+/UT
         1xNqz9T4fl6w2S9l2LBzYd919shCzSeYchAFcebIv4IxVJZzKOjhv1eggdpNc/jDPf8m
         kAzQXxxAxKOFwjp9NbmgyBnd1PSYZtogmFnG7F/vpVroiNnKMp4cpDFUOcAxML7aDGfC
         Cqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YsU7ZhT+rluSy+wUpfWMbC0oCvAGTAQ9i/VLdumPV1Q=;
        b=0T2YCH78hr4uG0G0BTTdojjN9J4AAxiGxQVexJOdfyV4E2fCxmI2bdNna9jdmJaTY+
         lb5Kd5cKaYKZbVxZJLHPUhxFhZiDM7GtOjFKUNpPMq/6gua1EGGsgQbpJ1gq65JIBHZ2
         +6zckCZT4V41mvnLpbLvZFbAYcLe1hYQMUnKU7TPy9q2fqTzTdKbYNF+aLqd8bykcjlW
         1LyIMgG+b4vkdFmF6eZegohKrNACsawBryOyjQGPHPUZsPwHCSLLHadV3+uGtlth3pMa
         dZY4HfE1DTFgaSMd93ksJVrBGlpo7X/dHqmf1FJ5AFoBx8i68RDrKu8R6hU+kGgTJ4dz
         YqhQ==
X-Gm-Message-State: AOAM531Q5cuiRVvkrg+CXTs8lSeRDrMFaLU0dM2yEbkMp4r4uWUjjmM/
        GkX1ZMO5M9NvFgHwtZ8SJISIksQu6e/sQA==
X-Google-Smtp-Source: ABdhPJzDj36dBl6WBIiuP3BcHPvTa78jUeH0WUzBTEtJOo9HpYygchFIkVHIQaTDv/W/KpZx8VyLIg==
X-Received: by 2002:a62:1857:0:b0:44a:e385:a8fe with SMTP id 84-20020a621857000000b0044ae385a8femr9168974pfy.3.1632890702597;
        Tue, 28 Sep 2021 21:45:02 -0700 (PDT)
Received: from [10.44.201.164] ([154.21.212.187])
        by smtp.gmail.com with ESMTPSA id z24sm865241pgu.54.2021.09.28.21.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 21:45:02 -0700 (PDT)
To:     stephenackerman16@gmail.com
Cc:     djwong@kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <2b5ca6d3-fa7b-5e2f-c353-f07dcff993c1@gmail.com>
Subject: Re: kvm crash in 5.14.1?
From:   Stephen <stephenackerman16@gmail.com>
Message-ID: <16c7a433-6e58-4213-bc00-5f6196fe22f5@gmail.com>
Date:   Tue, 28 Sep 2021 21:44:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2b5ca6d3-fa7b-5e2f-c353-f07dcff993c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I got this crash again on 5.14.7 in the early morning of the 27th.
Things hung up shortly after I'd gone to bed. Uptime was 1 day 9 hours 9
minutes.

I've rolled back to 5.13.19 for now; since this bug seems to effect my
system every day to few days. Please let me know if there's any
additional useful information I can provide.

The VMs that I'm running include a Gitlab server + runner, Matrix
Synapse server, and a Minecraft server.

The Minecraft server seems to keep 1 core maxed out fairly regularly;
otherwise they all have fairly low CPU load. The Minecraft server keeps
memory usage maxed out; the other two VMs seem to use ~50-75% of RAM as
reported by the Virtual Machine Manager UI and maybe a few % of CPU time
at any given point.


--------------------

BUG: kernel NULL pointer dereference, address: 0000000000000068
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 21 PID: 8494 Comm: CPU 7/KVM Tainted: G            E     5.14.7 #32
Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE WIFI/X570
AORUS ELITE WIFI, BIOS F35 07/08/2021
RIP: 0010:internal_get_user_pages_fast+0x738/0xda0
Code: 84 24 a0 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 54 06 00 00 48
81 c4 a8 00 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 78
68 a0 a3 >
RSP: 0018:ffffb31845c43b40 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffe8499635d580 RCX: ffffe8499635d5b4
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffe8499635d580
RBP: 00007f230d9c2000 R08: 0000000000000000 R09: ffffe8499635d580
R10: 0000000000000000 R11: 000000000000000c R12: ffff8f54d1bbbe00
R13: 000000ffffffffff R14: 0000000000080005 R15: 800000058d756867
FS:  00007f22795fa640(0000) GS:ffff8f617ef40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 000000022a4a0000 CR4: 0000000000350ee0
Call Trace:
 get_user_pages_fast_only+0x13/0x20
 __direct_pte_prefetch+0x12d/0x240 [kvm]
 ? mmu_set_spte+0x335/0x4d0 [kvm]
 ? kvm_mmu_max_mapping_level+0xf0/0x100 [kvm]
 direct_page_fault+0x850/0xab0 [kvm]
 ? kvm_mtrr_check_gfn_range_consistency+0x61/0x120 [kvm]
 kvm_check_async_pf_completion+0x9a/0x110 [kvm]
 kvm_arch_vcpu_ioctl_run+0x1667/0x16a0 [kvm]
 kvm_vcpu_ioctl+0x267/0x650 [kvm]
 __x64_sys_ioctl+0x83/0xb0
 do_syscall_64+0x3b/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f238d1be957
Code: 3c 1c 48 f7 d8 4c 39 e0 77 b9 e8 24 ff ff ff 85 c0 78 be 4c 89 e0
5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01
f0 ff ff >
RSP: 002b:00007f22795f9528 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f238d1be957
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001c
RBP: 000055e40b2f9870 R08: 000055e40aa305b8 R09: 000000000000002c
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 000055e40ae7b020 R14: 0000000000000000 R15: 0000000000000000
Modules linked in: md4(E) nls_utf8(E) cifs(E) dns_resolver(E) fscache(E)
netfs(E) libdes(E) ufs(E) qnx4(E) hfsplus(E) hfs(E) minix(E) msdos(E)
jfs(E) xf>
 binfmt_misc(E) intel_rapl_msr(E) intel_rapl_common(E) btusb(E) btrtl(E)
edac_mce_amd(E) btbcm(E) btintel(E) kvm_amd(E) uvcvideo(E) bluetooth(E)
videobu>
 sunrpc(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E)
crc16(E) mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) zstd_compress(E)
raid10(E) ra>
CR2: 0000000000000068
---[ end trace ce417e1d9ee841db ]---
RIP: 0010:internal_get_user_pages_fast+0x738/0xda0
Code: 84 24 a0 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 54 06 00 00 48
81 c4 a8 00 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 78
68 a0 a3 >
RSP: 0018:ffffb31845c43b40 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffe8499635d580 RCX: ffffe8499635d5b4
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffe8499635d580
RBP: 00007f230d9c2000 R08: 0000000000000000 R09: ffffe8499635d580
R10: 0000000000000000 R11: 000000000000000c R12: ffff8f54d1bbbe00
R13: 000000ffffffffff R14: 0000000000080005 R15: 800000058d756867
FS:  00007f22795fa640(0000) GS:ffff8f617ef40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 000000022a4a0000 CR4: 0000000000350ee0
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:         9-....: (5233 ticks this GP) idle=5d2/1/0x4000000000000000
softirq=8121851/8121851 fqs=2619
        (t=5250 jiffies g=17211713 q=5567)
Sending NMI from CPU 9 to CPUs 7:
NMI backtrace for cpu 7
CPU: 7 PID: 8492 Comm: CPU 5/KVM Tainted: G      D     E     5.14.7 #32
Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE WIFI/X570
AORUS ELITE WIFI, BIOS F35 07/08/2021
RIP: 0010:native_queued_spin_lock_slowpath+0x19c/0x1d0
Code: c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6 48 05 00 d7 02 00
48 03 04 f5 80 2a 19 b6 48 89 10 8b 42 08 85 c0 75 09 f3 90 <8b> 42 08
85 c0 74 >
RSP: 0018:ffffb31845be3cb0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffb31847e45000 RCX: 0000000000200000
RDX: ffff8f617ebed700 RSI: 000000000000000c RDI: ffffb31847e45004
RBP: ffffb31847e45004 R08: 0000000000200000 R09: ffffb31845be3d0c
R10: 8000000000000000 R11: 000000000000000c R12: 0000000000000000
R13: 0000000111bd11c0 R14: 0000000000000000 R15: ffff8f55d0e60000
FS:  00007f227a5fc640(0000) GS:ffff8f617ebc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f87754dd9a8 CR3: 000000022a4a0000 CR4: 0000000000350ee0
Call Trace:
 queued_write_lock_slowpath+0x73/0x80
 direct_page_fault+0x639/0xab0 [kvm]
 ? kvm_mtrr_check_gfn_range_consistency+0x61/0x120 [kvm]
 kvm_check_async_pf_completion+0x9a/0x110 [kvm]
 kvm_arch_vcpu_ioctl_run+0x1667/0x16a0 [kvm]
 kvm_vcpu_ioctl+0x267/0x650 [kvm]
 __x64_sys_ioctl+0x83/0xb0
 do_syscall_64+0x3b/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f238d1be957
Code: 3c 1c 48 f7 d8 4c 39 e0 77 b9 e8 24 ff ff ff 85 c0 78 be 4c 89 e0
5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01
f0 ff ff >
RSP: 002b:00007f227a5fb528 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f238d1be957
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001a
RBP: 000055e40b2de890 R08: 000055e40aa305b8 R09: c000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 000055e40ae7b020 R14: 0000000000000001 R15: 0000000000000000
NMI backtrace for cpu 9
CPU: 9 PID: 8493 Comm: CPU 6/KVM Tainted: G      D     E     5.14.7 #32
Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE WIFI/X570
AORUS ELITE WIFI, BIOS F35 07/08/2021
Call Trace:
 <IRQ>
 dump_stack_lvl+0x46/0x5a
 nmi_cpu_backtrace.cold+0x32/0x69
 ? lapic_can_unplug_cpu+0x80/0x80
 nmi_trigger_cpumask_backtrace+0xd7/0xe0
 rcu_dump_cpu_stacks+0xc1/0xef
 rcu_sched_clock_irq.cold+0xc7/0x1e9
 update_process_times+0x8c/0xc0
 tick_sched_handle+0x22/0x60
 tick_sched_timer+0x7a/0xd0
 ? tick_do_update_jiffies64.part.0+0xa0/0xa0
 __hrtimer_run_queues+0x12a/0x270
 hrtimer_interrupt+0x110/0x2c0
 __sysvec_apic_timer_interrupt+0x5c/0xd0
 sysvec_apic_timer_interrupt+0x6d/0x90
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:queued_write_lock_slowpath+0x56/0x80
Code: 0d 48 89 ef c6 07 00 0f 1f 40 00 5b 5d c3 f0 81 0b 00 01 00 00 ba
ff 00 00 00 b9 00 01 00 00 8b 03 3d 00 01 00 00 74 0b f3 90 <8b> 03 3d
00 01 00 >
RSP: 0018:ffffb31845c1bc28 EFLAGS: 00000206
RAX: 00000000000001ff RBX: ffffb31847e45000 RCX: 0000000000000100
RDX: 00000000000000ff RSI: 0000000000000000 RDI: ffffb31847e45000
RBP: ffffb31847e45004 R08: 0000000000000007 R09: ffffb31845c1bc7c
R10: 8000000000000000 R11: 000fffffffe00000 R12: 0000000000000000
R13: 0000000111bc0010 R14: 0000000000000000 R15: ffff8f55d0e62290
 direct_page_fault+0x639/0xab0 [kvm]
<snip>

Thanks,
    Stephen

