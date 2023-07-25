Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80E761B36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGYOUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 10:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjGYOUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBFD1FDF
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 07:15:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ccc462deca6so6275812276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690294522; x=1690899322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2y/0et/hDK5MbA1/YetJr3Y79vEo1Y3H27oSNVsI3o=;
        b=Zhrmr2tvNyf7Zx8RLZtfNHQQUu5emGAQ5f/GIOx11ohzaXM2w9TTWizTzPAoA3J6G5
         Q4H+7D0WbrEGm0i0uTsbqTxMhmpRVitDvHjbiaXBxBGGHXN5Y9sFjXXYwTUwvXPu8cNH
         BxJk8FQ2MQQijqVGOiHo3Ow8Gi+CwaVTmSriP6v/OCSKeDqw4c9uv5J3XCno9DFS9oyq
         pry++gXN5GueqKXIEHeovnuC5ykAzfog6LbPMTrPL8nfIolVUFijfWMJRWBBM2BfSHIC
         OBNgwVCPmSTiQx5/5i8UgYRyOury9PMQbS0jcYb7aWu/7xxQxbHRbjaVvH1bdwo0RlzL
         ekxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690294522; x=1690899322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2y/0et/hDK5MbA1/YetJr3Y79vEo1Y3H27oSNVsI3o=;
        b=Ohc4l3cdrLnhNkJyvMN0o0Z29rlI0DnZxb3fXBDpvI6p1bcOH9uZkPw6xTgDT9gIKJ
         tGxwNpY6Zo6rsYn4sKkIN6BBbCDDyQNK6wdiPl9a6EqIEXGzt736+Su8L3FW503tqOML
         1aJkPd1hSYW08bw3VNsT3PVwqdbZMSwk3aeiulpNDaYbFvxzb/asJ/r18Ci2WsphNhwF
         3l3E3ZYh9pj2diqIG6ZIEB8evy0llhcrLNABCguJ7iiTIU2Nq3Sa8gie0kbepRqxapOc
         gCxLqvC/u6EWUMSejE4STpV9dtJ29/Pcr+tl1Ou01vlljiv35E1e7wl4V643mUeVa9/Y
         JkmA==
X-Gm-Message-State: ABy/qLa901Q9XjzS5LJAIR4UIlHgrpec4Xvs8lOzuKZ3JwxsL+i0vOyg
        s8u5RJ696LhvP6rTqWfdhZOmFNpuW0fpAR06xoAErQ==
X-Google-Smtp-Source: APBJJlEEIF2uxklR5rovDKm9gMChvCWi3NyFN/RKsakHIVH51/jY6oDoGRyqGmplnOqX134s0N53TEHsPk8xGtp5wuQ=
X-Received: by 2002:a5b:c0e:0:b0:d12:94bd:3355 with SMTP id
 f14-20020a5b0c0e000000b00d1294bd3355mr4560828ybq.65.1690294522354; Tue, 25
 Jul 2023 07:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230724185410.1124082-1-willy@infradead.org> <20230724185410.1124082-3-willy@infradead.org>
 <20230725-anaconda-that-ac3f79880af1@wendy>
In-Reply-To: <20230725-anaconda-that-ac3f79880af1@wendy>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 25 Jul 2023 07:15:08 -0700
Message-ID: <CAJuCfpEUn=pycn-69-zUGbF-Exb2M1kDrsMPmA-BtAUkH2dKjQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] mm: Allow per-VMA locks on file-backed VMAs
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 5:58=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey,
>
> On Mon, Jul 24, 2023 at 07:54:02PM +0100, Matthew Wilcox (Oracle) wrote:
> > Remove the TCP layering violation by allowing per-VMA locks on all VMAs=
.
> > The fault path will immediately fail in handle_mm_fault().  There may b=
e
> > a small performance reduction from this patch as a little unnecessary w=
ork
> > will be done on each page fault.  See later patches for the improvement=
.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Arjun Roy <arjunroy@google.com>
> > Cc: Eric Dumazet <edumazet@google.com>
>
> Unless my bisection has gone awry, this is causing boot failures for me
> in today's linux-next w/ a splat like so.

This patch requires [1] to work correctly. It follows the rule
introduced in [1] that anyone returning VM_FAULT_RETRY should also do
vma_end_read(). [1] is merged into mm-unstable but has not reached
linux-next yet, it seems.

[1] https://lore.kernel.org/all/20230630211957.1341547-4-surenb@google.com/

> Full log and bisection log below, it reproduces on this hardware using
> the standard riscv 64-bit defconfig, although my bisection was done with
> some more debugging stuff enabled.
>
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         WARNING: bad unlock balance detected!
>         6.5.0-rc3-next-20230725 #1 Not tainted
>         -------------------------------------
>         modprobe/58 is trying to release lock (&vma->vm_lock->lock) at:
>         [<ffffffff8000dcfa>] vma_end_read+0x60/0xb8
>         but there are no more locks to release!
>
>         other info that might help us debug this:
>         1 lock held by modprobe/58:
>          #0: ffffffff8169daa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_a=
cquire+0x0/0x2e
>
>         stack backtrace:
>         CPU: 3 PID: 58 Comm: modprobe Not tainted 6.5.0-rc3-next-20230725=
 #1
>         Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
>         Call Trace:
>         [<ffffffff80006b48>] show_stack+0x2c/0x38
>         [<ffffffff80b49bb2>] dump_stack_lvl+0x60/0x82
>         [<ffffffff80b49be8>] dump_stack+0x14/0x1c
>         [<ffffffff80089d5a>] print_unlock_imbalance_bug+0x1cc/0x1d6
>         [<ffffffff80085e4a>] lock_release+0x236/0x3ae
>         [<ffffffff8007e464>] up_read+0x16/0x26
>         [<ffffffff8000dcfa>] vma_end_read+0x60/0xb8
>         [<ffffffff8000d9ca>] handle_page_fault+0x19e/0x3a4
>         [<ffffffff80b4a18c>] do_page_fault+0x20/0x56
>         [<ffffffff80004434>] ret_from_exception+0x0/0x64
>         ------------[ cut here ]------------
>         DEBUG_RWSEMS_WARN_ON(tmp < 0): count =3D 0xffffffffffffff00, magi=
c =3D 0xffffffe7c63c1558, owner =3D 0x1, curr 0xffffffe7c0add600, list empt=
y
>         WARNING: CPU: 3 PID: 58 at kernel/locking/rwsem.c:1348 __up_read+=
0x1c2/0x224
>         Modules linked in:
>         CPU: 3 PID: 58 Comm: modprobe Not tainted 6.5.0-rc3-next-20230725=
 #1
>         Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
>         epc : __up_read+0x1c2/0x224
>          ra : __up_read+0x1c2/0x224
>         epc : ffffffff8007e636 ra : ffffffff8007e636 sp : ffffffc8002b3df=
0
>          gp : ffffffff818ad0f0 tp : ffffffe7c0add600 t0 : ffffffc8002b3ab=
8
>          t1 : 0000000000000044 t2 : 5357525f47554245 s0 : ffffffc8002b3e2=
0
>          s1 : ffffffffffffff00 a0 : b32cfaf25517f300 a1 : b32cfaf25517f30=
0
>          a2 : b32cfaf25517f300 a3 : c0000000ffffefff a4 : 00000fff0000000=
0
>          a5 : 0000000000000004 a6 : ffffffff81643e90 a7 : 000000000000003=
8
>          s2 : ffffffe7c63c1560 s3 : ffffffff81ae3578 s4 : ffffffe7c63c155=
8
>          s5 : ffffffc8002b3ee0 s6 : 0000000000000254 s7 : ffffffe7c63c05a=
0
>          s8 : 0000003f97687780 s9 : ffffffffeffffef5 s10: 000000006474e55=
3
>          s11: 0000000000000000 t3 : ffffffff8259430f t4 : ffffffff8259430=
f
>          t5 : ffffffff82594310 t6 : ffffffff8259430f
>         status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000=
000000003
>         [<ffffffff8007e636>] __up_read+0x1c2/0x224
>         [<ffffffff8007e46a>] up_read+0x1c/0x26
>         [<ffffffff8000dcfa>] vma_end_read+0x60/0xb8
>         [<ffffffff8000d9ca>] handle_page_fault+0x19e/0x3a4
>         [<ffffffff80b4a18c>] do_page_fault+0x20/0x56
>         [<ffffffff80004434>] ret_from_exception+0x0/0x64
>         irq event stamp: 371
>         hardirqs last  enabled at (371): [<ffffffff8000d862>] handle_page=
_fault+0x36/0x3a4
>         hardirqs last disabled at (370): [<ffffffff80b4aef6>] irqentry_en=
ter+0x16/0x4c
>         softirqs last  enabled at (180): [<ffffffff80b56566>] __do_softir=
q+0x57e/0x66e
>         softirqs last disabled at (173): [<ffffffff8001f288>] __irq_exit_=
rcu+0x8c/0x14c
>         ---[ end trace 0000000000000000 ]---
>
> Thanks,
> Conor.
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5] Linux 6.5-rc1
> git bisect good 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> # status: waiting for bad commit, 1 good commit known
> # bad: [1e25dd7772483f477f79986d956028e9f47f990a] Add linux-next specific=
 files for 20230725
> git bisect bad 1e25dd7772483f477f79986d956028e9f47f990a
> # bad: [73002c8a551db94daa4124dbe61a3340999c556e] Merge branch 'master' o=
f git://linuxtv.org/mchehab/media-next.git
> git bisect bad 73002c8a551db94daa4124dbe61a3340999c556e
> # bad: [c37659958e0ff5aaffae86df9e696638f58cd3a3] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
> git bisect bad c37659958e0ff5aaffae86df9e696638f58cd3a3
> # good: [bdd1d82e7d02bd2764a68a5cc54533dfc2ba452a] Merge tag 'io_uring-6.=
5-2023-07-21' of git://git.kernel.dk/linux
> git bisect good bdd1d82e7d02bd2764a68a5cc54533dfc2ba452a
> # good: [d7b4fea201483d40b7cb1f522915531c6e6b168b] mm/page_io: convert co=
unt_swpout_vm_event() to take in a folio
> git bisect good d7b4fea201483d40b7cb1f522915531c6e6b168b
> # good: [46dce626e248cc91b0612f7c6c31b15f48899465] Merge branch 'fixes' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
> git bisect good 46dce626e248cc91b0612f7c6c31b15f48899465
> # bad: [e3fb201f858b63a7abf71b5bb563923b6424b98a] Merge branch 'mm-nonmm-=
unstable' into mm-everything
> git bisect bad e3fb201f858b63a7abf71b5bb563923b6424b98a
> # good: [1e0fb16464b68936b1b901a7b908c37d6f587b7c] arm64: smccc: replace =
custom COUNT_ARGS() & CONCATENATE() implementations
> git bisect good 1e0fb16464b68936b1b901a7b908c37d6f587b7c
> # good: [de32a89e11bab2e9c8c881fbbbad84a492d5ce9c] mm: set up vma iterato=
r for vma_iter_prealloc() calls
> git bisect good de32a89e11bab2e9c8c881fbbbad84a492d5ce9c
> # bad: [add29438034569277ab967199af39fe42a4d858c] mm: handle PUD faults u=
nder the VMA lock
> git bisect bad add29438034569277ab967199af39fe42a4d858c
> # good: [ecc821b0404e19eebf393f7a5a73d80c3faa69e4] maple_tree: reduce res=
ets during store setup
> git bisect good ecc821b0404e19eebf393f7a5a73d80c3faa69e4
> # good: [4e9c4f4a2949a2b47917647283799bb5952f2290] mm: remove CONFIG_PER_=
VMA_LOCK ifdefs
> git bisect good 4e9c4f4a2949a2b47917647283799bb5952f2290
> # bad: [9a709e2cca6097f66aaba411bd8758cf43a39eb9] mm: move FAULT_FLAG_VMA=
_LOCK check from handle_mm_fault()
> git bisect bad 9a709e2cca6097f66aaba411bd8758cf43a39eb9
> # bad: [78b696bb953cb0b553e1cf9084a6e09580aa4e2a] mm: allow per-VMA locks=
 on file-backed VMAs
> git bisect bad 78b696bb953cb0b553e1cf9084a6e09580aa4e2a
> # first bad commit: [78b696bb953cb0b553e1cf9084a6e09580aa4e2a] mm: allow =
per-VMA locks on file-backed VMAs
>
> [    0.000000] Linux version 6.5.0-rc3-00283-g78b696bb953c (conor@wendy) =
(ClangBuiltLinux clang version 15.0.7 (/home/
> conor/stuff/dev/llvm/clang 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a), Cla=
ngBuiltLinux LLD 15.0.7) #1 SMP PREEMPT @666
> [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> [    0.000000] SBI specification v1.0 detected
> [    0.000000] SBI implementation ID=3D0x1 Version=3D0x10002
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI SRST extension detected
> [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options =
'115200n8')
> [    0.000000] printk: bootconsole [ns16550a0] enabled
> [    0.000000] printk: debug: skip boot console de-registration.
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffffff (=
4096 KiB) nomap non-reusable region@BFC00000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000bfbfffff]
> [    0.000000]   node   0: [mem 0x00000000bfc00000-0x00000000bfffffff]
> [    0.000000]   node   0: [mem 0x0000001040000000-0x000000107fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000107ff=
fffff]
> [    0.000000] SBI HSM extension detected
> [    0.000000] CPU with hartid=3D0 is not available
> [    0.000000] riscv: base ISA extensions acdfim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 30 pages/cpu s84320 r8192 d30368 u122880
> [    0.000000] Kernel command line: earlycon keep_bootcon root=3D/dev/mmc=
blk1p2 rootdelay=3D10 reboot=3Dcold
> [    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152=
 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 =
bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 517=
120
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:=
off
> [    0.000000] software IO TLB: area num 4.
> [    0.000000] software IO TLB: mapped [mem 0x00000000bbc00000-0x00000000=
bfc00000] (64MB)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0xffffffc6fea00000 - 0xffffffc6ff000000   (=
6144 kB)
> [    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (=
  16 MB)
> [    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (=
4096 MB)
> [    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (=
  64 GB)
> [    0.000000]      modules : 0xffffffff025d4000 - 0xffffffff80000000   (=
2010 MB)
> [    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffe800000000   (=
  64 GB)
> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (=
2047 MB)
> [    0.000000] Memory: 1913560K/2097152K available (11570K kernel code, 5=
054K rwdata, 4096K rodata, 6069K init, 11226K
>  bss, 183592K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4,=
 Nodes=3D1
> [    0.000000] trace event string verifier disabled
> [    0.000000] Running RCU self tests
> [    0.000000] Running RCU synchronous self tests
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU lockdep checking is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_=
ids=3D4.
> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> [    0.000000]  Trampoline variant of Tasks RCU enabled.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D4
> [    0.000000] Running RCU synchronous self tests
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interru=
pt-controller
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts =
with 4 handlers for 9 contexts.
> [    0.000000] riscv: providing IPIs using SBI IPI extension
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff m=
ax_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> [    0.000003] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps =
every 2199023255500ns
> [    0.010570] Console: colour dummy device 80x25
> [    0.015820] printk: console [tty0] enabled
> [    0.020660] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc=
., Ingo Molnar
> [    0.029527] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.034262] ... MAX_LOCK_DEPTH:          48
> [    0.039096] ... MAX_LOCKDEP_KEYS:        8192
> [    0.044121] ... CLASSHASH_SIZE:          4096
> [    0.049148] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.054277] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.059407] ... CHAINHASH_SIZE:          32768
> [    0.064539]  memory used by lock dependency info: 6493 kB
> [    0.070744]  memory used for stack traces: 4224 kB
> [    0.076263]  per task-struct memory footprint: 1920 bytes
> [    0.082662] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 2.00 BogoMIPS (lpj=3D4000)
> [    0.094225] pid_max: default: 32768 minimum: 301
> [    0.100802] Mount-cache hash table entries: 4096 (order: 3, 32768 byte=
s, linear)
> [    0.109469] Mountpoint-cache hash table entries: 4096 (order: 3, 32768=
 bytes, linear)
> [    0.125003] Running RCU synchronous self tests
> [    0.130214] Running RCU synchronous self tests
> [    0.137709] CPU node for /cpus/cpu@0 exist but the possible cpu range =
is :0-3
> [    0.155633] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adj=
ust=3D1.
> [    0.164714] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_=
cb_adjust=3D1.
> [    0.174340] Running RCU-tasks wait API self tests
> [    0.286157] riscv: ELF compat mode unsupported
> [    0.286208] ASID allocator disabled (0 bits)
> [    0.296532] Callback from call_rcu_tasks_trace() invoked.
> [    0.304124] rcu: Hierarchical SRCU implementation.
> [    0.309791] rcu:     Max phase no-delay instances is 1000.
> [    0.321671] EFI services will not be available.
> [    0.329990] smp: Bringing up secondary CPUs ...
> [    0.354947] smp: Brought up 1 node, 4 CPUs
> [    0.365578] devtmpfs: initialized
> [    0.410073] Running RCU synchronous self tests
> [    0.416094] Running RCU synchronous self tests
> [    0.421843] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
> [    0.433116] futex hash table entries: 1024 (order: 5, 131072 bytes, li=
near)
> [    0.442918] pinctrl core: initialized pinctrl subsystem
> [    0.456687] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.468413] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic alloc=
ations
> [    0.476749] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for at=
omic allocations
> [    0.492183] cpuidle: using governor menu
> [    0.558914] Callback from call_rcu_tasks() invoked.
> [    0.613189] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> [    0.621137] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.635532] ACPI: Interpreter disabled.
> [    0.659634] SCSI subsystem initialized
> [    0.667627] usbcore: registered new interface driver usbfs
> [    0.674440] usbcore: registered new interface driver hub
> [    0.680969] usbcore: registered new device driver usb
> [    0.690490] FPGA manager framework
> [    0.703508] vgaarb: loaded
> [    0.708569] clocksource: Switched to clocksource riscv_clocksource
> [    0.723150] pnp: PnP ACPI: disabled
> [    0.809949] NET: Registered PF_INET protocol family
> [    0.818618] IP idents hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
> [    0.839293] tcp_listen_portaddr_hash hash table entries: 1024 (order: =
4, 73728 bytes, linear)
> [    0.850714] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
> [    0.859721] TCP established hash table entries: 16384 (order: 5, 13107=
2 bytes, linear)
> [    0.872260] TCP bind hash table entries: 16384 (order: 9, 2359296 byte=
s, linear)
> [    0.902395] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.911840] UDP hash table entries: 1024 (order: 5, 163840 bytes, line=
ar)
> [    0.921420] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes,=
 linear)
> [    0.932233] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.943727] RPC: Registered named UNIX socket transport module.
> [    0.950879] RPC: Registered udp transport module.
> [    0.956374] RPC: Registered tcp transport module.
> [    0.961926] RPC: Registered tcp-with-tls transport module.
> [    0.968707] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.976198] PCI: CLS 0 bytes, default 64
> [    0.985222] Unpacking initramfs...
> [    1.000909] workingset: timestamp_bits=3D62 max_order=3D19 bucket_orde=
r=3D0
> [    1.016047] NFS: Registering the id_resolver key type
> [    1.022604] Key type id_resolver registered
> [    1.027625] Key type id_legacy registered
> [    1.032619] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
..
> [    1.040698] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regi=
stering...
> [    1.050868] 9p: Installing v9fs 9p2000 file system support
> [    1.059351] NET: Registered PF_ALG protocol family
> [    1.065759] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 246)
> [    1.074615] io scheduler mq-deadline registered
> [    1.079954] io scheduler kyber registered
> [    1.084855] io scheduler bfq registered
> [    2.691196] String selftests succeeded
> [    2.695696] test_string_helpers: Running tests...
> [    2.735759] microchip-pcie 3000000000.pcie: host bridge /pcie@30000000=
00 ranges:
> [    2.744646] microchip-pcie 3000000000.pcie:      MEM 0x3008000000..0x3=
087ffffff -> 0x0008000000
> [    2.754854] microchip-pcie 3000000000.pcie:   IB MEM 0x0000000000..0x0=
0ffffffff -> 0x0000000000
> [    2.793603] microchip-pcie 3000000000.pcie: ECAM at [mem 0x3000000000-=
0x3007ffffff] for [bus 00-7f]
> [    2.806599] microchip-pcie 3000000000.pcie: PCI host bridge to bus 000=
0:00
> [    2.814622] pci_bus 0000:00: root bus resource [bus 00-7f]
> [    2.821060] pci_bus 0000:00: root bus resource [mem 0x3008000000-0x308=
7ffffff] (bus address [0x08000000-0x87ffffff]
> )
> [    2.833923] pci 0000:00:00.0: [11aa:1556] type 01 class 0x000604
> [    2.841032] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff 64b=
it pref]
> [    2.850230] pci 0000:00:00.0: supports D1 D2
> [    2.855282] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
> [    2.918454] pci_bus 0000:01: busn_res: [bus 01-7f] end is updated to 0=
1
> [    2.926316] pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000=
 64bit pref]
> [    2.935124] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x8000=
0000 64bit pref]
> [    2.944337] pci 0000:00:00.0: BAR 8: assigned [mem 0x3008000000-0x3008=
1fffff]
> [    2.952729] pci 0000:00:00.0: BAR 9: assigned [mem 0x3008200000-0x3008=
3fffff 64bit pref]
> [    2.962291] pci 0000:00:00.0: BAR 7: no space for [io  size 0x1000]
> [    2.969658] pci 0000:00:00.0: BAR 7: failed to assign [io  size 0x1000=
]
> [    2.977402] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.983258] pci 0000:00:00.0:   bridge window [mem 0x3008000000-0x3008=
1fffff]
> [    2.991555] pci 0000:00:00.0:   bridge window [mem 0x3008200000-0x3008=
3fffff 64bit pref]
> [    3.012105] CCACHE: 4 banks, 16 ways, sets/bank=3D512, bytes/block=3D6=
4
> [    3.019534] CCACHE: Index of the largest way enabled: 11
> [    3.553216] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    3.599227] 20100000.serial: ttyS1 at MMIO 0x20100000 (irq =3D 53, bas=
e_baud =3D 9375000) is a 16550A
> [    3.610933] printk: console [ttyS1] enabled
> [    3.610933] printk: console [ttyS1] enabled
> [    3.635869] 20102000.serial: ttyS2 at MMIO 0x20102000 (irq =3D 54, bas=
e_baud =3D 9375000) is a 16550A
> [    3.670527] 20104000.serial: ttyS3 at MMIO 0x20104000 (irq =3D 55, bas=
e_baud =3D 9375000) is a 16550A
> [    3.706515] 20106000.serial: ttyS0 at MMIO 0x20106000 (irq =3D 56, bas=
e_baud =3D 9375000) is a 16550A
> [    3.823007] loop: module loaded
> [    3.839186] zram: Added device: zram0
> [    3.867557] microchip-corespi 20108000.spi: Registered SPI controller =
0
> [    3.887509] microchip-corespi 20109000.spi: Registered SPI controller =
1
> [    5.062117] macb 20110000.ethernet eth0: Cadence GEM rev 0x0107010c at=
 0x20110000 irq 60 (00:04:a3:bf:d2:70)
> [    6.106111] Freeing initrd memory: 25480K
> [    6.124243]
> [    6.127470] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    6.137414] WARNING: bad unlock balance detected!
> [    6.147364] 6.5.0-rc3-next-20230725 #1 Not tainted
> [    6.157500] -------------------------------------
> [    6.167447] modprobe/58 is trying to release lock (&vma->vm_lock->lock=
) at:
> [    6.182194] [<ffffffff8000dcfa>] vma_end_read+0x60/0xb8
> [    6.193279] but there are no more locks to release!
> [    6.203590]
> [    6.203590] other info that might help us debug this:
> [    6.217392] 1 lock held by modprobe/58:
> [    6.225516]  #0: ffffffff8169daa0 (rcu_read_lock){....}-{1:2}, at: rcu=
_lock_acquire+0x0/0x2e
> [    6.243441]
> [    6.243441] stack backtrace:
> [    6.252662] CPU: 3 PID: 58 Comm: modprobe Not tainted 6.5.0-rc3-next-2=
0230725 #1
> [    6.268319] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> [    6.281383] Call Trace:
> [    6.286563] [<ffffffff80006b48>] show_stack+0x2c/0x38
> [    6.297274] [<ffffffff80b49bb2>] dump_stack_lvl+0x60/0x82
> [    6.308723] [<ffffffff80b49be8>] dump_stack+0x14/0x1c
> [    6.319417] [<ffffffff80089d5a>] print_unlock_imbalance_bug+0x1cc/0x1d=
6
> [    6.333417] [<ffffffff80085e4a>] lock_release+0x236/0x3ae
> [    6.344867] [<ffffffff8007e464>] up_read+0x16/0x26
> [    6.355013] [<ffffffff8000dcfa>] vma_end_read+0x60/0xb8
> [    6.366072] [<ffffffff8000d9ca>] handle_page_fault+0x19e/0x3a4
> [    6.378415] [<ffffffff80b4a18c>] do_page_fault+0x20/0x56
> [    6.389656] [<ffffffff80004434>] ret_from_exception+0x0/0x64
> [    6.401771] ------------[ cut here ]------------
> [    6.411655] DEBUG_RWSEMS_WARN_ON(tmp < 0): count =3D 0xffffffffffffff0=
0, magic =3D 0xffffffe7c63c1558, owner =3D 0x1, curr 0xffffffe7c0add600, li=
st empty
> [    6.439789] WARNING: CPU: 3 PID: 58 at kernel/locking/rwsem.c:1348 __u=
p_read+0x1c2/0x224
> [    6.439840] Modules linked in:
> [    6.439855] CPU: 3 PID: 58 Comm: modprobe Not tainted 6.5.0-rc3-next-2=
0230725 #1
> [    6.439884] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> [    6.439896] epc : __up_read+0x1c2/0x224
> [    6.439923]  ra : __up_read+0x1c2/0x224
> [    6.439947] epc : ffffffff8007e636 ra : ffffffff8007e636 sp : ffffffc8=
002b3df0
> [    6.439966]  gp : ffffffff818ad0f0 tp : ffffffe7c0add600 t0 : ffffffc8=
002b3ab8
> [    6.439986]  t1 : 0000000000000044 t2 : 5357525f47554245 s0 : ffffffc8=
002b3e20
> [    6.440004]  s1 : ffffffffffffff00 a0 : b32cfaf25517f300 a1 : b32cfaf2=
5517f300
> [    6.440023]  a2 : b32cfaf25517f300 a3 : c0000000ffffefff a4 : 00000fff=
00000000
> [    6.440042]  a5 : 0000000000000004 a6 : ffffffff81643e90 a7 : 00000000=
00000038
> [    6.440060]  s2 : ffffffe7c63c1560 s3 : ffffffff81ae3578 s4 : ffffffe7=
c63c1558
> [    6.440079]  s5 : ffffffc8002b3ee0 s6 : 0000000000000254 s7 : ffffffe7=
c63c05a0
> [    6.440098]  s8 : 0000003f97687780 s9 : ffffffffeffffef5 s10: 00000000=
6474e553
> [    6.440117]  s11: 0000000000000000 t3 : ffffffff8259430f t4 : ffffffff=
8259430f
> [    6.440136]  t5 : ffffffff82594310 t6 : ffffffff8259430f
> [    6.440151] status: 0000000200000120 badaddr: 0000000000000000 cause: =
0000000000000003
> [    6.440169] [<ffffffff8007e636>] __up_read+0x1c2/0x224
> [    6.440201] [<ffffffff8007e46a>] up_read+0x1c/0x26
> [    6.440229] [<ffffffff8000dcfa>] vma_end_read+0x60/0xb8
> [    6.440255] [<ffffffff8000d9ca>] handle_page_fault+0x19e/0x3a4
> [    6.440282] [<ffffffff80b4a18c>] do_page_fault+0x20/0x56
> [    6.440309] [<ffffffff80004434>] ret_from_exception+0x0/0x64
> [    6.440339] irq event stamp: 371
> [    6.440347] hardirqs last  enabled at (371): [<ffffffff8000d862>] hand=
le_page_fault+0x36/0x3a4
> [    6.440377] hardirqs last disabled at (370): [<ffffffff80b4aef6>] irqe=
ntry_enter+0x16/0x4c
> [    6.440407] softirqs last  enabled at (180): [<ffffffff80b56566>] __do=
_softirq+0x57e/0x66e
> [    6.440453] softirqs last disabled at (173): [<ffffffff8001f288>] __ir=
q_exit_rcu+0x8c/0x14c
> [    6.440494] ---[ end trace 0000000000000000 ]---
