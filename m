Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE917CF57
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCGQxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 11:53:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44306 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCGQxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 11:53:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id n7so5932748wrt.11;
        Sat, 07 Mar 2020 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1EWnUUllOXwYaTO48MzLbffkHDyanL4aumr0r6LKgDM=;
        b=KpYXx+ftoCvUens3hT7ZA9tUlFK3BlS/d9JpYrKkBDEyKy/O7xILk/8JwbkVczOCuW
         nyHar/y+UYqN9aXNtMquxw+n2vH+k5ITH8YeiqEcwn0dCpd/LK92YefiBQNh83Mnj7xv
         WU0qPFFcJSik9DFqm9/sd1bWOdOuOntmvR2rLje9ac1RJiSAKT5crqqcocfjYkvgYWIt
         lFNipo+BGmbjLs0nK3eiTyXdOzHmL8n824P8yqZaGTFYPU7y2WqrYL5iSJhX1EwRbrpx
         IOLcDr22fUkXUN3m3pvOtOixygQDkQQDCZBVq3LUppz40QkjJ3EIZrr66QF4gEfuIaLy
         m9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1EWnUUllOXwYaTO48MzLbffkHDyanL4aumr0r6LKgDM=;
        b=HVf1G+pQncpQRAfI8rsONkoCx0SyrXzfkSm66o1osLY7xfRuMKZb9uvMK4oB9ARbpO
         NzYnyZrnFX4sPJ8fjR+dOAZOriIsFda+TFGrW5WwxltGIUXhpdmSXKvlwZLaWLazNK5k
         C05oSYFo9s2huOV8JfKEj4ZoEwvsFdugcQVtH06MAWWMuiG3Bvm1zmuNckFoAJFC1jp/
         v/vcuLuXVSYzRivGMsxM5gwo1Oe6jA7xweS70KmLOHE5vR6rHREgg0k6io3igwmPQ/Kl
         0MtsfO3Wg2YFkRXfn01EXSxkaXwhAuGPu1rfFpw6X+RgO16dzG8XwvMjFD5WXwR6KJpJ
         v8zw==
X-Gm-Message-State: ANhLgQ2aR+Wdscz1MYv2yX2xvQJjHU4Wc2p9WKFehJXRvNADKPGn5Gbk
        nWu0oFM7QNflYdzc6ACbVnsI2QkI
X-Google-Smtp-Source: ADFU+vtuIeav5KnRQyl1buHT31C82xAv3imtM6CPIlugq7lQQndxL17IMhDQ59uJCUvIK7xWZY0ENg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr10591901wrq.334.1583599994925;
        Sat, 07 Mar 2020 08:53:14 -0800 (PST)
Received: from gatosaldo (net-31-27-176-207.cust.vodafonedsl.it. [31.27.176.207])
        by smtp.gmail.com with ESMTPSA id f3sm18396681wml.24.2020.03.07.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 08:53:14 -0800 (PST)
Date:   Sat, 7 Mar 2020 17:53:12 +0100 (CET)
From:   Enrico Mioso <mrkiko.rs@gmail.com>
X-X-Sender: mrkiko@localhost.localdomain
To:     linux-fsdevel@vger.kernel.org
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: [stable kernel 4.19.107] general protection fault in
 vcs_read+0x45e/0x600
In-Reply-To: <alpine.LNX.2.21.99999.353.2003051619040.8178@mStation.localdomain>
Message-ID: <alpine.LNX.2.21.99999.382.2003071751580.18591@localhost.localdomain>
References: <alpine.LNX.2.21.99999.353.2003051619040.8178@mStation.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello guys!
Any ideas and help would be greatly apreciated. I forgot to mention I am not part of the list, so please keep me in CC! :)

Thanks,

enrico


On Thu, 5 Mar 2020, Enrico Mioso wrote:

> Date: Thu, 5 Mar 2020 16:30:39
> From: Enrico Mioso <mrkiko.rs@gmail.com>
> To: linux-fsdevel@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Dave Mielke <Dave@mielke.cc>,
>     linux-kernel@vger.kernel.org
> Subject: [stable kernel 4.19.107] general protection fault in
>     vcs_read+0x45e/0x600
> 
> Hello all, Hello Al, Hello Dave.
>
> here I am reporting an especially important issue, at least for me, since it 
> involves the VCS support, the code used by
> e.g. the BRLTTY daemon to obtain informations about the screen (e.g.: its 
> content, ...).
>
>
> After this crash occurs I am not able to use the system anymore, the brltty 
> daemon becomes a zombie. the process disappears at
> some time.
>
> Find my dmesg appended. Currently I can interact with the system over SSH, 
> since my braille display won't probably work as well
> right now.
> Dave, I CC'ed you since you may already have hard about this. Or am I the 
> only / first person experiencing this?
>
> Setup: brltty talks to my braille display over a PL2303 USB->RS232 converter, 
> you can see I unplugged it afte the crash.
> I was using This Apple Alluminum keyboard to type, but seems system doesn't 
> react to keypresses: can't confirm that since I have no monitor connected 
> right now (it's a desktop machine).
>
> Thank you very very much guys.
>
> Enrico
> [    0.000000] Linux version 4.19.107 (mrkiko@atlantide2) (gcc version 9.2.1 
> 20200130 (Arch Linux 9.2.1+20200130-2)) #1 SMP Sat Feb 29 21:02:18 CET 2020
> [    0.000000] Command line: auto BOOT_IMAGE=myarch ro root=822 
> mitigations=off nospectre_v2 pti=off l1tf=off 
> kvm-intel.vmentry_l1d_flush=never nospec_store_bypass_disable mds=off
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e4000-0x00000000000fffff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007f79ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007f7a0000-0x000000007f7adfff] ACPI 
> data
> [    0.000000] BIOS-e820: [mem 0x000000007f7ae000-0x000000007f7dffff] ACPI 
> NVS
> [    0.000000] BIOS-e820: [mem 0x000000007f7e0000-0x000000007f7fffff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] 
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fff80000-0x00000000ffffffff] 
> reserved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.4 present.
> [    0.000000] DMI: System manufacturer System Product Name/P5GC-MX/1333, 
> BIOS 0310    12/24/2007
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2527.994 MHz processor
> [    0.006479] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.006480] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.006484] last_pfn = 0x7f7a0 max_arch_pfn = 0x400000000
> [    0.006488] MTRR default type: uncachable
> [    0.006489] MTRR fixed ranges enabled:
> [    0.006490]   00000-9FFFF write-back
> [    0.006490]   A0000-DFFFF uncachable
> [    0.006491]   E0000-EFFFF write-through
> [    0.006492]   F0000-FFFFF write-protect
> [    0.006492] MTRR variable ranges enabled:
> [    0.006494]   0 base 000000000 mask F80000000 write-back
> [    0.006495]   1 base 07F800000 mask FFF800000 uncachable
> [    0.006495]   2 disabled
> [    0.006496]   3 disabled
> [    0.006496]   4 disabled
> [    0.006497]   5 disabled
> [    0.006497]   6 disabled
> [    0.006497]   7 disabled
> [    0.007639] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT [ 
> 0.007792] Kernel/User page tables isolation: disabled on command line.
> [    0.007797] BRK [0x26601000, 0x26601fff] PGTABLE
> [    0.007798] BRK [0x26602000, 0x26602fff] PGTABLE
> [    0.007800] BRK [0x26603000, 0x26603fff] PGTABLE
> [    0.007822] BRK [0x26604000, 0x26604fff] PGTABLE
> [    0.007825] BRK [0x26605000, 0x26605fff] PGTABLE
> [    0.007907] BRK [0x26606000, 0x26606fff] PGTABLE
> [    0.007929] ACPI: Early table checksum verification disabled
> [    0.008126] ACPI: RSDP 0x00000000000FB030 000014 (v00 ACPIAM)
> [    0.008130] ACPI: RSDT 0x000000007F7A0000 000038 (v01 A_M_I_ OEMRSDT 
> 12000724 MSFT 00000097)
> [    0.008135] ACPI: FACP 0x000000007F7A0200 000084 (v02 A_M_I_ OEMFACP 
> 12000724 MSFT 00000097)
> [    0.008140] ACPI: DSDT 0x000000007F7A05C0 006909 (v01 A0798  A0798000 
> 00000000 INTL 20051117)
> [    0.008144] ACPI: FACS 0x000000007F7AE000 000040
> [    0.008146] ACPI: APIC 0x000000007F7A0390 00006C (v01 A_M_I_ OEMAPIC 
> 12000724 MSFT 00000097)
> [    0.008149] ACPI: MCFG 0x000000007F7A0400 00003C (v01 A_M_I_ OEMMCFG 
> 12000724 MSFT 00000097)
> [    0.008152] ACPI: OEMB 0x000000007F7AE040 000080 (v01 A_M_I_ AMI_OEM 
> 12000724 MSFT 00000097)
> [    0.008156] ACPI: HPET 0x000000007F7A6ED0 000038 (v01 A_M_I_ OEMHPET 
> 12000724 MSFT 00000097)
> [    0.008165] ACPI: Local APIC address 0xfee00000
> [    0.008182] Zone ranges:
> [    0.008183]   DMA32    [mem 0x0000000000001000-0x000000007f79ffff]
> [    0.008185]   Normal   empty
> [    0.008186] Movable zone start for each node
> [    0.008186] Early memory node ranges
> [    0.008187]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.008188]   node   0: [mem 0x0000000000100000-0x000000007f79ffff]
> [    0.008235] Zeroed struct page in unavailable ranges: 2242 pages
> [    0.008236] Initmem setup node 0 [mem 
> 0x0000000000001000-0x000000007f79ffff]
> [    0.008238] On node 0 totalpages: 522046
> [    0.008239]   DMA32 zone: 8159 pages used for memmap
> [    0.008240]   DMA32 zone: 21 pages reserved
> [    0.008241]   DMA32 zone: 522046 pages, LIFO batch:63
> [    0.027476] Reserving Intel graphics memory at [mem 0x7f800000-0x7fffffff]
> [    0.027615] ACPI: PM-Timer IO Port: 0x808
> [    0.027617] ACPI: Local APIC address 0xfee00000
> [    0.027634] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> [    0.027638] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.027641] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.027642] ACPI: IRQ0 used by override.
> [    0.027643] ACPI: IRQ9 used by override.
> [    0.027645] Using ACPI (MADT) for SMP configuration information
> [    0.027646] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.027653] smpboot: 4 Processors exceeds NR_CPUS limit of 2
> [    0.027654] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> [    0.027671] [mem 0x80000000-0xfedfffff] available for PCI devices
> [    0.027676] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 
> 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.109832] random: get_random_bytes called from start_kernel+0x88/0x3fc 
> with crng_init=0
> [    0.109840] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 
> nr_node_ids:1
> [    0.110583] percpu: Embedded 45 pages/cpu s143960 r8192 d32168 u1048576
> [    0.110589] pcpu-alloc: s143960 r8192 d32168 u1048576 alloc=1*2097152
> [    0.110591] pcpu-alloc: [0] 0 1 [    0.110612] Built 1 zonelists, mobility 
> grouping on.  Total pages: 513866
> [    0.110616] Kernel command line: auto BOOT_IMAGE=myarch ro root=822 
> mitigations=off nospectre_v2 pti=off l1tf=off 
> kvm-intel.vmentry_l1d_flush=never nospec_store_bypass_disable mds=off
> [    0.111371] Dentry cache hash table entries: 262144 (order: 9, 2097152 
> bytes)
> [    0.111674] Inode-cache hash table entries: 131072 (order: 8, 1048576 
> bytes)
> [    0.133432] Memory: 2035008K/2088184K available (8200K kernel code, 363K 
> rwdata, 1728K rodata, 824K init, 884K bss, 53176K reserved, 0K cma-reserved)
> [    0.133444] random: get_random_u64 called from 
> __kmem_cache_create+0x2b/0x360 with crng_init=0
> [    0.133497] random: get_random_u64 called from 
> cache_random_seq_create+0x77/0x130 with crng_init=0
> [    0.133543] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.133610] rcu: Hierarchical RCU implementation.
> [    0.133627] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
> [    0.136257] Console: colour VGA+ 80x50
> [    0.139442] console [tty0] enabled
> [    0.139491] ACPI: Core revision 20180810
> [    0.139714] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, 
> max_idle_ns: 133484882848 ns
> [    0.139796] hpet clockevent registered
> [    0.139803] APIC: Switch to symmetric I/O mode setup
> [    0.140209] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.144801] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 
> 0x2470867647e, max_idle_ns: 440795206160 ns
> [    0.144891] Calibrating delay loop (skipped), value calculated using timer 
> frequency.. 5055.98 BogoMIPS (lpj=2527994)
> [    0.144968] pid_max: default: 32768 minimum: 301
> [    0.145079] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.145147] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 
> bytes)
> [    0.145453] CPU0: Thermal monitoring enabled (TM2)
> [    0.145502] process: using mwait in idle threads
> [    0.145551] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
> [    0.145598] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
> [    0.145648] Speculative Store Bypass: Vulnerable
> [    0.145890] Freeing SMP alternatives memory: 24K
> [    0.230392] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     E7200  @ 2.53GHz 
> (family: 0x6, model: 0x17, stepping: 0x6)
> [    0.230593] Performance Events: PEBS fmt0+, Core2 events, Intel PMU 
> driver.
> [    0.230650] ... version:                2
> [    0.230696] ... bit width:              40
> [    0.230741] ... generic registers:      2
> [    0.230786] ... value mask:             000000ffffffffff
> [    0.230832] ... max period:             000000007fffffff
> [    0.230877] ... fixed-purpose events:   3
> [    0.230877] ... event mask:             0000000700000003
> [    0.230877] rcu: Hierarchical SRCU implementation.
> [    0.230877] smp: Bringing up secondary CPUs ...
> [    0.230877] x86: Booting SMP configuration:
> [    0.230877] .... node  #0, CPUs:      #1
> [    0.231909] smp: Brought up 1 node, 2 CPUs
> [    0.231976] smpboot: Max logical packages: 2
> [    0.232022] smpboot: Total of 2 processors activated (10111.97 BogoMIPS)
> [    0.233046] devtmpfs: initialized
> [    0.233086] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
> max_idle_ns: 1911260446275000 ns
> [    0.233086] futex hash table entries: 512 (order: 3, 32768 bytes)
> [    0.233879] NET: Registered protocol family 16
> [    0.233977] cpuidle: using governor menu
> [    0.233977] ACPI: bus type PCI registered
> [    0.234049] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 
> 0xf0000000-0xf3ffffff] (base 0xf0000000)
> [    0.234049] PCI: not using MMCONFIG
> [    0.234049] PCI: Using configuration type 1 for base access
> [    0.237296] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.237376] ACPI: Added _OSI(Module Device)
> [    0.237376] ACPI: Added _OSI(Processor Device)
> [    0.237376] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.237376] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.237376] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.237376] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.240507] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    0.241491] ACPI: Dynamic OEM Table Load:
> [    0.241541] ACPI: SSDT 0xFFFF993C7C40C000 0001D2 (v01 AMI    CPU1PM 
> 00000001 INTL 20051117)
> [    0.241843] ACPI: Dynamic OEM Table Load:
> [    0.241947] ACPI: SSDT 0xFFFF993C7C40CC00 000143 (v01 AMI    CPU2PM 
> 00000001 INTL 20051117)
> [    0.242448] ACPI: Interpreter enabled
> [    0.242498] ACPI: (supports S0 S5)
> [    0.242548] ACPI: Using IOAPIC for interrupt routing
> [    0.242628] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 
> 0xf0000000-0xf3ffffff] (base 0xf0000000)
> [    0.243636] PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in ACPI 
> motherboard resources
> [    0.243722] PCI: Using host bridge windows from ACPI; if necessary, use 
> "pci=nocrs" and report a bug
> [    0.244061] ACPI: Enabled 11 GPEs in block 00 to 1F
> [    0.249118] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.249172] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments 
> MSI]
> [    0.249224] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND)
> [    0.249273] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 
> [bus 00-3f] only partially covers this bridge
> [    0.249413] PCI host bridge to bus 0000:00
> [    0.249460] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.249509] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.249558] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff 
> window]
> [    0.249608] pci_bus 0000:00: root bus resource [mem 0x7f810000-0xffffffff 
> window]
> [    0.249657] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.249713] pci 0000:00:00.0: [8086:2770] type 00 class 0x060000
> [    0.249809] pci 0000:00:02.0: [8086:2772] type 00 class 0x030000
> [    0.249819] pci 0000:00:02.0: reg 0x10: [mem 0xdfd00000-0xdfd7ffff]
> [    0.249823] pci 0000:00:02.0: reg 0x14: [io  0x8800-0x8807]
> [    0.249827] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff pref]
> [    0.249831] pci 0000:00:02.0: reg 0x1c: [mem 0xdfd80000-0xdfdbffff]
> [    0.249936] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300
> [    0.249954] pci 0000:00:1b.0: reg 0x10: [mem 0xdfdf8000-0xdfdfbfff 64bit]
> [    0.250016] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.250087] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400
> [    0.250152] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.250230] pci 0000:00:1c.1: [8086:27d2] type 01 class 0x060400
> [    0.250294] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    0.250373] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300
> [    0.250411] pci 0000:00:1d.0: reg 0x20: [io  0x9000-0x901f]
> [    0.250490] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300
> [    0.250527] pci 0000:00:1d.1: reg 0x20: [io  0x9400-0x941f]
> [    0.250606] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300
> [    0.250643] pci 0000:00:1d.2: reg 0x20: [io  0x9800-0x981f]
> [    0.250723] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300
> [    0.250760] pci 0000:00:1d.3: reg 0x20: [io  0xa000-0xa01f]
> [    0.250845] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320
> [    0.250863] pci 0000:00:1d.7: reg 0x10: [mem 0xdfdffc00-0xdfdfffff]
> [    0.250935] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    0.251003] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
> [    0.251111] pci 0000:00:1f.0: [8086:27b8] type 00 class 0x060100
> [    0.251184] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6 
> ACPI/GPIO/TCO
> [    0.251238] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by ICH6 
> GPIO
> [    0.251290] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0290 
> (mask 0007)
> [    0.251426] pci 0000:00:1f.1: [8086:27df] type 00 class 0x01018a
> [    0.251441] pci 0000:00:1f.1: reg 0x10: [io  0x0000-0x0007]
> [    0.251448] pci 0000:00:1f.1: reg 0x14: [io  0x0000-0x0003]
> [    0.251456] pci 0000:00:1f.1: reg 0x18: [io  0x0000-0x0007]
> [    0.251463] pci 0000:00:1f.1: reg 0x1c: [io  0x0000-0x0003]
> [    0.251471] pci 0000:00:1f.1: reg 0x20: [io  0xffa0-0xffaf]
> [    0.251487] pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io 
> 0x01f0-0x01f7]
> [    0.251536] pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.251880] pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io 
> 0x0170-0x0177]
> [    0.251928] pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.252044] pci 0000:00:1f.2: [8086:27c0] type 00 class 0x01018f
> [    0.252059] pci 0000:00:1f.2: reg 0x10: [io  0xb800-0xb807]
> [    0.252065] pci 0000:00:1f.2: reg 0x14: [io  0xb400-0xb403]
> [    0.252071] pci 0000:00:1f.2: reg 0x18: [io  0xb000-0xb007]
> [    0.252077] pci 0000:00:1f.2: reg 0x1c: [io  0xa800-0xa803]
> [    0.252084] pci 0000:00:1f.2: reg 0x20: [io  0xa400-0xa40f]
> [    0.252889] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.252955] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500
> [    0.253004] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
> [    0.253120] pci 0000:00:1c.0: PCI bridge to [bus 03]
> [    0.253170] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
> [    0.253224] pci 0000:02:00.0: [1969:2048] type 00 class 0x020000
> [    0.253253] pci 0000:02:00.0: reg 0x10: [mem 0xdffc0000-0xdfffffff 64bit]
> [    0.253300] pci 0000:02:00.0: reg 0x30: [mem 0xdffa0000-0xdffbffff pref]
> [    0.253356] pci 0000:02:00.0: PME# supported from D3hot D3cold
> [    0.253416] pci 0000:00:1c.1: PCI bridge to [bus 02]
> [    0.253465] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
> [    0.253468] pci 0000:00:1c.1:   bridge window [mem 0xdff00000-0xdfffffff]
> [    0.253486] pci_bus 0000:01: extended config space not accessible
> [    0.253555] pci 0000:01:00.0: [10ec:8169] type 00 class 0x020000
> [    0.253570] pci 0000:01:00.0: reg 0x10: [io  0xc400-0xc4ff]
> [    0.253579] pci 0000:01:00.0: reg 0x14: [mem 0xdfeffc00-0xdfeffcff]
> [    0.253615] pci 0000:01:00.0: reg 0x30: [mem 0xdfee0000-0xdfeeffff pref]
> [    0.253641] pci 0000:01:00.0: supports D1 D2
> [    0.253643] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.253686] pci 0000:01:01.0: [1102:0007] type 00 class 0x040100
> [    0.253701] pci 0000:01:01.0: reg 0x10: [io  0xc800-0xc81f]
> [    0.253767] pci 0000:01:01.0: supports D1 D2
> [    0.253830] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive decode)
> [    0.253881] pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
> [    0.253884] pci 0000:00:1e.0:   bridge window [mem 0xdfe00000-0xdfefffff]
> [    0.253889] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] 
> (subtractive decode)
> [    0.253890] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] 
> (subtractive decode)
> [    0.253892] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff 
> window] (subtractive decode)
> [    0.253893] pci 0000:00:1e.0:   bridge window [mem 0x7f810000-0xffffffff 
> window] (subtractive decode)
> [    0.253907] pci_bus 0000:00: on NUMA node 0
> [    0.254548] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 
> 15)
> [    0.254647] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 
> 15)
> [    0.254745] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 
> 15)
> [    0.254842] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 
> 15)
> [    0.254926] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 
> 15)
> [    0.255023] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 
> 15)
> [    0.255120] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 
> 15) *0, disabled.
> [    0.255219] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 
> 15)
> [    0.255430] SCSI subsystem initialized
> [    0.255533] libata version 3.00 loaded.
> [    0.255533] ACPI: bus type USB registered
> [    0.255533] usbcore: registered new interface driver usbfs
> [    0.255533] usbcore: registered new interface driver hub
> [    0.255533] usbcore: registered new device driver usb
> [    0.255882] PCI: Using ACPI for IRQ routing
> [    0.256884] PCI: pci_cache_line_size set to 64 bytes
> [    0.256884] Expanded resource Reserved due to conflict with PCI Bus 
> 0000:00
> [    0.256884] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    0.256884] e820: reserve RAM buffer [mem 0x7f7a0000-0x7fffffff]
> [    0.256945] HPET: 3 timers in total, 0 timers will be used for per-cpu 
> timer
> [    0.257000] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.257052] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
> [    0.258891] clocksource: Switched to clocksource tsc-early
> [    0.259008] pnp: PnP ACPI init
> [    0.259109] system 00:00: [mem 0xfed13000-0xfed19fff] has been reserved
> [    0.259164] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.259204] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.259426] pnp 00:02: [dma 2]
> [    0.259467] pnp 00:02: Plug and Play ACPI device, IDs PNP0700 (active)
> [    0.259719] pnp 00:03: [dma 3]
> [    0.259819] pnp 00:03: Plug and Play ACPI device, IDs PNP0401 (active)
> [    0.259873] system 00:04: [io  0x0290-0x0297] has been reserved
> [    0.259927] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.260066] system 00:05: [io  0x04d0-0x04d1] has been reserved
> [    0.260115] system 00:05: [io  0x0800-0x087f] has been reserved
> [    0.260162] system 00:05: [io  0x0480-0x04bf] has been reserved
> [    0.260211] system 00:05: [io  0x0900-0x091f] has been reserved
> [    0.260259] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.260308] system 00:05: [mem 0xfed20000-0xfed8ffff] has been reserved
> [    0.260356] system 00:05: [mem 0xffb00000-0xffbfffff] could not be 
> reserved
> [    0.260406] system 00:05: [mem 0xfff00000-0xffffffff] could not be 
> reserved
> [    0.260459] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.260566] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 PNP030b 
> (active)
> [    0.260647] system 00:07: [mem 0xfec00000-0xfec00fff] could not be 
> reserved
> [    0.260697] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.260750] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.260927] pnp 00:08: [dma 0 disabled]
> [    0.260977] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.261045] system 00:09: [mem 0xffc00000-0xfff7ffff] has been reserved
> [    0.261099] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.261152] system 00:0a: [mem 0xf0000000-0xf3ffffff] has been reserved
> [    0.261206] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.261335] system 00:0b: [mem 0x00000000-0x0009ffff] could not be 
> reserved
> [    0.261385] system 00:0b: [mem 0x000c0000-0x000dffff] could not be 
> reserved
> [    0.261433] system 00:0b: [mem 0x000e0000-0x000fffff] could not be 
> reserved
> [    0.261482] system 00:0b: [mem 0x00100000-0x7f7fffff] could not be 
> reserved
> [    0.261536] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.261646] pnp: PnP ACPI: found 12 devices
> [    0.267729] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, 
> max_idle_ns: 2085701024 ns
> [    0.267819] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 
> 64bit pref] to [bus 03] add_size 200000 add_align 100000
> [    0.267822] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to 
> [bus 03] add_size 200000 add_align 100000
> [    0.267839] pci 0000:00:1c.0: BAR 8: assigned [mem 0x80000000-0x801fffff]
> [    0.267890] pci 0000:00:1c.0: BAR 9: assigned [mem 0x80200000-0x803fffff 
> 64bit pref]
> [    0.267942] pci 0000:00:1c.0: PCI bridge to [bus 03]
> [    0.267989] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
> [    0.268041] pci 0000:00:1c.0:   bridge window [mem 0x80000000-0x801fffff]
> [    0.268092] pci 0000:00:1c.0:   bridge window [mem 0x80200000-0x803fffff 
> 64bit pref]
> [    0.268144] pci 0000:00:1c.1: PCI bridge to [bus 02]
> [    0.268192] pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
> [    0.268242] pci 0000:00:1c.1:   bridge window [mem 0xdff00000-0xdfffffff]
> [    0.268296] pci 0000:00:1e.0: PCI bridge to [bus 01]
> [    0.268343] pci 0000:00:1e.0:   bridge window [io  0xc000-0xcfff]
> [    0.268392] pci 0000:00:1e.0:   bridge window [mem 0xdfe00000-0xdfefffff]
> [    0.268446] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.268448] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.268449] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.268451] pci_bus 0000:00: resource 7 [mem 0x7f810000-0xffffffff window]
> [    0.268452] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
> [    0.268454] pci_bus 0000:03: resource 1 [mem 0x80000000-0x801fffff]
> [    0.268455] pci_bus 0000:03: resource 2 [mem 0x80200000-0x803fffff 64bit 
> pref]
> [    0.268457] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
> [    0.268458] pci_bus 0000:02: resource 1 [mem 0xdff00000-0xdfffffff]
> [    0.268459] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
> [    0.268461] pci_bus 0000:01: resource 1 [mem 0xdfe00000-0xdfefffff]
> [    0.268462] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7 window]
> [    0.268464] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff window]
> [    0.268465] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.268467] pci_bus 0000:01: resource 7 [mem 0x7f810000-0xffffffff window]
> [    0.268541] NET: Registered protocol family 2
> [    0.268741] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 
> 16384 bytes)
> [    0.268805] TCP established hash table entries: 16384 (order: 5, 131072 
> bytes)
> [    0.268912] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
> [    0.269080] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.269177] UDP hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.269240] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.269328] NET: Registered protocol family 1
> [    0.269378] NET: Registered protocol family 44
> [    0.269435] pci 0000:00:02.0: Video device with shadowed ROM at [mem 
> 0x000c0000-0x000dffff]
> [    0.270072] PCI: CLS 16 bytes, default 64
> [    0.270460] Initialise system trusted keyrings
> [    0.270541] workingset: timestamp_bits=46 max_order=19 bucket_order=0
> [    0.272800] Key type asymmetric registered
> [    0.272851] Asymmetric key parser 'x509' registered
> [    0.272910] Block layer SCSI generic (bsg) driver version 0.4 loaded 
> (major 252)
> [    0.272962] io scheduler noop registered
> [    0.273030] io scheduler cfq registered (default)
> [    0.273477] input: Power Button as 
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    0.273531] ACPI: Power Button [PWRB]
> [    0.273618] input: Power Button as 
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> [    0.273668] ACPI: Power Button [PWRF]
> [    0.274126] ata_piix 0000:00:1f.1: version 2.13
> [    0.275055] scsi host0: ata_piix
> [    0.275196] scsi host1: ata_piix
> [    0.275273] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 
> 14
> [    0.275322] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 
> 15
> [    0.275447] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> [    0.276586] scsi host2: ata_piix
> [    0.276707] scsi host3: ata_piix
> [    0.276786] ata3: SATA max UDMA/133 cmd 0xb800 ctl 0xb400 bmdma 0xa400 irq 
> 23
> [    0.276835] ata4: SATA max UDMA/133 cmd 0xb000 ctl 0xa800 bmdma 0xa408 irq 
> 23
> [    0.276913] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.276964] ehci-pci: EHCI PCI platform driver
> [    0.277108] ehci-pci 0000:00:1d.7: EHCI Host Controller
> [    0.277163] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus 
> number 1
> [    0.277221] ehci-pci 0000:00:1d.7: debug port 1
> [    0.281178] ehci-pci 0000:00:1d.7: cache line size of 16 is not supported
> [    0.281189] ehci-pci 0000:00:1d.7: irq 20, io mem 0xdfdffc00
> [    0.288049] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> [    0.288138] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, 
> bcdDevice= 4.19
> [    0.288189] usb usb1: New USB device strings: Mfr=3, Product=2, 
> SerialNumber=1
> [    0.288239] usb usb1: Product: EHCI Host Controller
> [    0.288285] usb usb1: Manufacturer: Linux 4.19.107 ehci_hcd
> [    0.288332] usb usb1: SerialNumber: 0000:00:1d.7
> [    0.288472] hub 1-0:1.0: USB hub found
> [    0.288522] hub 1-0:1.0: 8 ports detected
> [    0.288727] uhci_hcd: USB Universal Host Controller Interface driver
> [    0.288836] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> [    0.288887] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus 
> number 2
> [    0.288956] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00009000
> [    0.289037] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, 
> bcdDevice= 4.19
> [    0.289091] usb usb2: New USB device strings: Mfr=3, Product=2, 
> SerialNumber=1
> [    0.289139] usb usb2: Product: UHCI Host Controller
> [    0.289186] usb usb2: Manufacturer: Linux 4.19.107 uhci_hcd
> [    0.289233] usb usb2: SerialNumber: 0000:00:1d.0
> [    0.289357] hub 2-0:1.0: USB hub found
> [    0.289407] hub 2-0:1.0: 2 ports detected
> [    0.289585] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> [    0.289636] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus 
> number 3
> [    0.289712] uhci_hcd 0000:00:1d.1: irq 17, io base 0x00009400
> [    0.289792] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, 
> bcdDevice= 4.19
> [    0.289842] usb usb3: New USB device strings: Mfr=3, Product=2, 
> SerialNumber=1
> [    0.289892] usb usb3: Product: UHCI Host Controller
> [    0.289937] usb usb3: Manufacturer: Linux 4.19.107 uhci_hcd
> [    0.289985] usb usb3: SerialNumber: 0000:00:1d.1
> [    0.290107] hub 3-0:1.0: USB hub found
> [    0.290157] hub 3-0:1.0: 2 ports detected
> [    0.290342] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> [    0.290393] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus 
> number 4
> [    0.290466] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009800
> [    0.290546] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, 
> bcdDevice= 4.19
> [    0.290598] usb usb4: New USB device strings: Mfr=3, Product=2, 
> SerialNumber=1
> [    0.290646] usb usb4: Product: UHCI Host Controller
> [    0.290693] usb usb4: Manufacturer: Linux 4.19.107 uhci_hcd
> [    0.290741] usb usb4: SerialNumber: 0000:00:1d.2
> [    0.290864] hub 4-0:1.0: USB hub found
> [    0.290920] hub 4-0:1.0: 2 ports detected
> [    0.291127] uhci_hcd 0000:00:1d.3: UHCI Host Controller
> [    0.291180] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus 
> number 5
> [    0.291254] uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000a000
> [    0.291353] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, 
> bcdDevice= 4.19
> [    0.291403] usb usb5: New USB device strings: Mfr=3, Product=2, 
> SerialNumber=1
> [    0.291452] usb usb5: Product: UHCI Host Controller
> [    0.291498] usb usb5: Manufacturer: Linux 4.19.107 uhci_hcd
> [    0.291545] usb usb5: SerialNumber: 0000:00:1d.3
> [    0.291669] hub 5-0:1.0: USB hub found
> [    0.291724] hub 5-0:1.0: 2 ports detected
> [    0.291917] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> [    0.291967] i8042: PNP: PS/2 appears to have AUX port disabled, if this is 
> incorrect please boot with i8042.nopnp
> [    0.292542] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.292719] rtc_cmos 00:01: RTC can wake from S4
> [    0.292901] rtc_cmos 00:01: registered as rtc0
> [    0.292948] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram, hpet 
> irqs
> [    0.293222] mce: Using 6 MCE banks
> [    0.293291] microcode: sig=0x10676, pf=0x1, revision=0x606
> [    0.293376] microcode: Microcode Update Driver: v2.2.
> [    0.293381] sched_clock: Marking stable (287299540, 6069763)->(325638638, 
> -32269335)
> [    0.294673] Loading compiled-in X.509 certificates
> [    0.294933] Key type big_key registered
> [    0.295114] rtc_cmos 00:01: setting system clock to 2020-03-05 10:03:16 
> UTC (1583402596)
> [    0.449532] ata3.00: ATA-7: MAXTOR STM3250310AS, 3.AAF, max UDMA/133
> [    0.449582] ata3.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 0/32)
> [    0.453214] ata1.00: ATA-7: Maxtor 6Y080L0, YAR41BW0, max UDMA/133
> [    0.453266] ata1.00: 160086528 sectors, multi 16: LBA [    0.454865] 
> ata1.01: ATA-7: Maxtor 6L300R0, BAJ41G20, max UDMA/133
> [    0.454914] ata1.01: 586114704 sectors, multi 16: LBA48 [    0.467630] 
> scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y080L0   1BW0 PQ: 0 ANSI: 5
> [    0.467832] sd 0:0:0:0: [sda] 160086528 512-byte logical blocks: (82.0 
> GB/76.3 GiB)
> [    0.467835] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    0.467891] sd 0:0:0:0: [sda] Write Protect is off
> [    0.467979] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    0.468004] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, 
> doesn't support DPO or FUA
> [    0.468044] scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6L300R0   1G20 
> PQ: 0 ANSI: 5
> [    0.468317] sd 0:0:1:0: Attached scsi generic sg1 type 0
> [    0.468511] scsi 2:0:0:0: Direct-Access     ATA      MAXTOR STM325031 F 
> PQ: 0 ANSI: 5
> [    0.468694] sd 2:0:0:0: Attached scsi generic sg2 type 0
> [    0.468718] sd 2:0:0:0: [sdc] 488397168 512-byte logical blocks: (250 
> GB/233 GiB)
> [    0.468805] sd 2:0:0:0: [sdc] Write Protect is off
> [    0.468853] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    0.468873] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, 
> doesn't support DPO or FUA
> [    0.472954]  sda: sda1
> [    0.472993] sd 0:0:1:0: [sdb] 586114704 512-byte logical blocks: (300 
> GB/279 GiB)
> [    0.473068] sd 0:0:1:0: [sdb] Write Protect is off
> [    0.473118] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> [    0.473161] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, 
> doesn't support DPO or FUA
> [    0.473215] sd 0:0:0:0: [sda] Attached SCSI disk
> [    0.475852]  sdc: sdc1 sdc2
> [    0.476100] sd 2:0:0:0: [sdc] Attached SCSI disk
> [    0.491277]  sdb: sdb1
> [    0.491520] sd 0:0:1:0: [sdb] Attached SCSI disk
> [    0.503254] EXT4-fs (sdc2): mounting ext2 file system using the ext4 
> subsystem
> [    0.511257] EXT4-fs (sdc2): mounted filesystem without journal. Opts: 
> (null)
> [    0.511313] VFS: Mounted root (ext2 filesystem) readonly on device 8:34.
> [    0.532748] devtmpfs: mounted
> [    0.533514] Freeing unused kernel image memory: 824K
> [    0.536845] Write protecting the kernel read-only data: 12288k
> [    0.537745] Freeing unused kernel image memory: 2020K
> [    0.537956] Freeing unused kernel image memory: 320K
> [    0.538151] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.538199] Run /sbin/init as init process
> [    0.622243] usb 1-5: new high-speed USB device number 2 using ehci-pci
> [    0.758896] usb 1-5: New USB device found, idVendor=05ac, idProduct=1006, 
> bcdDevice=96.15
> [    0.758956] usb 1-5: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=3
> [    0.759005] usb 1-5: Product: Keyboard Hub
> [    0.759052] usb 1-5: Manufacturer: Apple, Inc.
> [    0.759097] usb 1-5: SerialNumber: 000000000000
> [    0.759428] hub 1-5:1.0: USB hub found
> [    0.759519] hub 1-5:1.0: 3 ports detected
> [    1.063129] usb 4-2: new full-speed USB device number 2 using uhci_hcd
> [    1.214017] usb 4-2: New USB device found, idVendor=067b, idProduct=2303, 
> bcdDevice= 3.00
> [    1.214076] usb 4-2: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [    1.214124] usb 4-2: Product: USB-Serial Controller
> [    1.214171] usb 4-2: Manufacturer: Prolific Technology Inc.
> [    1.219006] random: fast init done
> [    1.323890] tsc: Refined TSC clocksource calibration: 2527.968 MHz
> [    1.323948] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
> 0x24706e26170, max_idle_ns: 440795270702 ns
> [    1.324034] clocksource: Switched to clocksource tsc
> [    1.538176] random: crng init done
> [    1.538229] random: 216 get_random_xx warning(s) missed due to 
> ratelimiting
> [    1.707889] usb 1-5.2: new low-speed USB device number 4 using ehci-pci
> [    1.793766] usb 1-5.2: New USB device found, idVendor=05ac, 
> idProduct=0250, bcdDevice= 0.74
> [    1.793825] usb 1-5.2: New USB device strings: Mfr=1, Product=2, 
> SerialNumber=0
> [    1.793874] usb 1-5.2: Product: Apple Keyboard
> [    1.793924] usb 1-5.2: Manufacturer: Apple Inc.
> [    3.891993] systemd[1]: Inserted module 'autofs4'
> [    3.959525] NET: Registered protocol family 10
> [    4.135715] Segment Routing with IPv6
> [    4.235266] systemd[1]: systemd 244.3-1-arch running in system mode. (+PAM 
> +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT 
> +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 
> default-hierarchy=hybrid)
> [    4.255911] systemd[1]: Detected architecture x86-64.
> [    4.292356] systemd[1]: Set hostname to <atlantide2>.
> [    6.359031] systemd[1]: Created slice system-getty.slice.
> [    6.359478] systemd[1]: Created slice system-modprobe.slice.
> [    6.359859] systemd[1]: Created slice system-netctl.slice.
> [    6.360291] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [    6.360667] systemd[1]: Created slice User and Session Slice.
> [    6.360937] systemd[1]: Started Dispatch Password Requests to Console 
> Directory Watch.
> [    6.361203] systemd[1]: Started Forward Password Requests to Wall 
> Directory Watch.
> [    6.361594] systemd[1]: Set up automount Arbitrary Executable File Formats 
> File System Automount Point.
> [    6.361871] systemd[1]: Reached target Local Encrypted Volumes.
> [    6.362111] systemd[1]: Reached target Paths.
> [    6.362328] systemd[1]: Reached target Remote File Systems.
> [    6.362546] systemd[1]: Reached target Slices.
> [    6.362821] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [    6.369329] systemd[1]: Listening on LVM2 metadata daemon socket.
> [    6.383435] systemd[1]: Listening on LVM2 poll daemon socket.
> [    6.386446] systemd[1]: Listening on Process Core Dump Socket.
> [    6.386713] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [    6.406892] systemd[1]: Condition check resulted in Journal Audit Socket 
> being skipped.
> [    6.407096] systemd[1]: Listening on Journal Socket (/dev/log).
> [    6.407426] systemd[1]: Listening on Journal Socket.
> [    6.407723] systemd[1]: Listening on udev Control Socket.
> [    6.408000] systemd[1]: Listening on udev Kernel Socket.
> [    6.409144] systemd[1]: Mounting Huge Pages File System...
> [    6.409446] systemd[1]: Condition check resulted in POSIX Message Queue 
> File System being skipped.
> [    6.409654] systemd[1]: Condition check resulted in Kernel Debug File 
> System being skipped.
> [    6.410531] systemd[1]: Starting Braille Console Driver...
> [    6.411730] systemd[1]: Starting Create list of static device nodes for 
> the current kernel...
> [    6.412907] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots 
> etc. using dmeventd or progress polling...
> [    6.593912] systemd[1]: Condition check resulted in Set Up Additional 
> Binary Formats being skipped.
> [    6.595031] systemd[1]: Starting File System Check on Root Device...
> [    6.596657] systemd[1]: Starting Journal Service...
> [    6.652279] systemd[1]: Starting Load Kernel Modules...
> [    6.653331] systemd[1]: Starting udev Coldplug all Devices...
> [    6.655046] systemd[1]: Mounted Huge Pages File System.
> [    6.719204] systemd[1]: Started Create list of static device nodes for the 
> current kernel.
> [    6.904557] systemd[1]: Started Load Kernel Modules.
> [    6.905063] systemd[1]: Condition check resulted in FUSE Control File 
> System being skipped.
> [    6.905177] systemd[1]: Condition check resulted in Kernel Configuration 
> File System being skipped.
> [    6.907155] systemd[1]: Starting Apply Kernel Variables...
> [    7.293167] systemd[1]: Started Journal Service.
> [    9.040859] EXT4-fs (sdc2): re-mounted. Opts: nobarrier,noauto_da_alloc
> [    9.653374] systemd-journald[755]: Received client request to flush 
> runtime journal.
> [   25.350503] parport_pc 00:03: reported by Plug and Play ACPI
> [   25.350640] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
> [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
> [   25.441982] parport_pc parport_pc.956: Unable to set coherent dma mask: 
> disabling DMA
> [   25.442124] parport_pc parport_pc.888: Unable to set coherent dma mask: 
> disabling DMA
> [   25.442234] parport_pc parport_pc.632: Unable to set coherent dma mask: 
> disabling DMA
> [   25.515042] Atheros(R) L2 Ethernet Driver - version 2.2.3
> [   25.515098] Copyright (c) 2007 Atheros Corporation.
> [   25.551420] intel_rng: FWH not detected
> [   25.598381] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> [   25.618986] 00:08: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 
> 16550A
> [   25.825246] usbcore: registered new interface driver pl2303
> [   25.825314] usbserial: USB Serial support registered for pl2303
> [   25.825383] pl2303 4-2:1.0: pl2303 converter detected
> [   25.838123] usb 4-2: pl2303 converter now attached to ttyUSB0
> [   25.856101] atl2 0000:02:00.0 enp2s0: renamed from eth0
> [   25.894735] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [   25.894864] iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, 
> TCOBASE=0x0860)
> [   25.895296] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [   26.048224] ppdev: user-space parallel port driver
> [   26.357866] hidraw: raw HID events driver (C) Jiri Kosina
> [   26.384083] r8169 0000:01:00.0: not PCI Express
> [   26.386121] libphy: r8169: probed
> [   26.386369] r8169 0000:01:00.0 eth0: RTL8169sb/8110sb, 00:0e:2e:d3:54:61, 
> XID 10000000, IRQ 17
> [   26.386450] r8169 0000:01:00.0 eth0: jumbo features [frames: 7152 bytes, 
> tx checksumming: ok]
> [   26.388608] r8169 0000:01:00.0 enp1s0: renamed from eth0
> [   26.486301] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC662 rev1: 
> line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> [   26.486390] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 
> (0x0/0x0/0x0/0x0/0x0)
> [   26.486447] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 
> (0x1b/0x0/0x0/0x0/0x0)
> [   26.486496] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [   26.486545] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
> [   26.486593] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [   26.486641] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
> [   26.486689] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
> [   26.486737] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
> [   26.500105] input: HDA Intel Front Mic as 
> /devices/pci0000:00/0000:00:1b.0/sound/card0/input3
> [   26.500296] input: HDA Intel Rear Mic as 
> /devices/pci0000:00/0000:00:1b.0/sound/card0/input4
> [   26.500440] input: HDA Intel Line as 
> /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
> [   26.500594] input: HDA Intel Line Out as 
> /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
> [   26.500757] input: HDA Intel Front Headphone as 
> /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
> [   26.561836] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> [   26.752591] usbcore: registered new interface driver usbhid
> [   26.752649] usbhid: USB HID core driver
> [   26.874048] snd_ca0106 0000:01:01.0: Model 100a Rev 00000000 Serial 
> 100a1102
> [   26.940769] input: Apple Inc. Apple Keyboard as 
> /devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5.2/1-5.2:1.0/0003:05AC:0250.0001/input/input8
> [   26.993041] apple 0003:05AC:0250.0001: input,hidraw0: USB HID v1.11 
> Keyboard [Apple Inc. Apple Keyboard] on usb-0000:00:1d.7-5.2/input0
> [   26.993411] input: Apple Inc. Apple Keyboard as 
> /devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5.2/1-5.2:1.1/0003:05AC:0250.0002/input/input9
> [   27.045118] apple 0003:05AC:0250.0002: input,hidraw1: USB HID v1.11 Device 
> [Apple Inc. Apple Keyboard] on usb-0000:00:1d.7-5.2/input1
> [   27.685012] Adding 1959892k swap on /dev/sdc1.  Priority:-2 extents:1 
> across:1959892k [   28.042293] EXT4-fs (sda1): mounted filesystem without 
> journal. Opts: nobarrier,noauto_da_alloc
> [   28.092339] EXT4-fs (sdb1): mounted filesystem without journal. Opts: 
> nobarrier,noauto_da_alloc
> [   30.215173] w83627ehf: Found W83627DHG chip at 0x290
> [   30.215333] ACPI Warning: SystemIO range 
> 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 
> 0x0000000000000290-0x0000000000000299 (\_SB.PCI0.SBRG.SIOR.HWRE) 
> (20180810/utaddress-204)
> [   30.215458] ACPI: If an ACPI driver is available for this device, you 
> should use it instead of the native driver
> [   31.280077] IPv6: ADDRCONF(NETDEV_UP): enp2s0: link is not ready
> [   31.280289] atl2: enp2s0 NIC Link is Up<100 Mbps Full Duplex>
> [   31.280358] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0: link becomes ready
> [  435.474188] fuse init (API version 7.27)
> [14896.856900] general protection fault: 0000 [#1] SMP NOPTI
> [14896.856904] CPU: 0 PID: 1150 Comm: brltty Not tainted 4.19.107 #1
> [14896.856905] Hardware name: System manufacturer System Product 
> Name/P5GC-MX/1333, BIOS 0310    12/24/2007
> [14896.856912] RIP: 0010:__memcpy+0x12/0x20
> [14896.856915] Code: e2 20 48 09 c2 48 31 d1 eb b8 90 90 90 90 90 90 90 90 90 
> 90 90 90 90 90 66 66 90 66 90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 
> a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
> [14896.856916] RSP: 0018:ffffaad880623d30 EFLAGS: 00010246
> [14896.856918] RAX: ffff993c76345000 RBX: 0000000000000001 RCX: 
> 0000000000000028
> [14896.856920] RDX: 0000000000000000 RSI: 00400000000000c0 RDI: 
> ffff993c76345000
> [14896.856921] RBP: 0000000000000140 R08: 0000000000000000 R09: 
> 0000000000000050
> [14896.856922] R10: 0000000000000000 R11: 0000000000000000 R12: 
> ffff993c76345140
> [14896.856924] R13: ffff993c00086800 R14: 0000000000000050 R15: 
> 0000000000001000
> [14896.856926] FS:  00007f69955fc800(0000) GS:ffff993c7d200000(0000) 
> knlGS:0000000000000000
> [14896.856927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14896.856929] CR2: 000055affebcad18 CR3: 000000007b7f6000 CR4: 
> 00000000000006f0
> [14896.856930] Call Trace:
> [14896.856937]  vcs_read+0x45e/0x600
> [14896.856942]  __vfs_read+0x32/0x170
> [14896.856945]  vfs_read+0x98/0x110
> [14896.856948]  ksys_pread64+0x5c/0x90
> [14896.856952]  do_syscall_64+0x67/0x330
> [14896.856955]  ? __do_page_fault+0x19d/0x3b0
> [14896.856957]  ? schedule+0x2d/0x80
> [14896.856960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14896.856962] RIP: 0033:0x7f6997946fcf
> [14896.856965] Code: 08 89 3c 24 48 89 4c 24 18 e8 ed f3 ff ff 4c 8b 54 24 18 
> 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d 
> 00 f0 ff ff 77 2d 44 89 c7 48 89 04 24 e8 1d f4 ff ff 48 8b
> [14896.856966] RSP: 002b:00007ffd959cf220 EFLAGS: 00000293 ORIG_RAX: 
> 0000000000000011
> [14896.856968] RAX: ffffffffffffffda RBX: 00007ffd959cf3c0 RCX: 
> 00007f6997946fcf
> [14896.856970] RDX: 0000000000004000 RSI: 0000562330a27e40 RDI: 
> 0000000000000010
> [14896.856971] RBP: 0000000000000010 R08: 0000000000000000 R09: 
> 0000000000000000
> [14896.856972] R10: 0000000000000000 R11: 0000000000000293 R12: 
> 0000000000004000
> [14896.856973] R13: 0000562330a27e40 R14: 0000000000000000 R15: 
> 00005623309bc5d8
> [14896.856975] Modules linked in: fuse hwmon_vid input_leds led_class 
> hid_apple hid_generic snd_ca0106 snd_ac97_codec usbhid ac97_bus snd_rawmidi 
> snd_seq_device i2c_i801 snd_hda_codec_realtek snd_hda_codec_generic 
> snd_hda_intel snd_hda_codec snd_hda_core r8169 snd_pcm hid i2c_core realtek 
> libphy ppdev snd_timer snd soundcore coretemp iTCO_wdt lpc_ich mfd_core 
> pl2303 usbserial 8250 8250_base serial_core acpi_cpufreq processor rng_core 
> atl2 asus_atk0110 hwmon parport_pc parport crypto_user ip_tables x_tables 
> mcryptd sha1_ssse3 sha1_generic ipv6 autofs4
> [14896.857010] ---[ end trace 68ba5b1bc09956c1 ]---
> [14896.857013] RIP: 0010:__memcpy+0x12/0x20
> [14896.857015] Code: e2 20 48 09 c2 48 31 d1 eb b8 90 90 90 90 90 90 90 90 90 
> 90 90 90 90 90 66 66 90 66 90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 
> a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
> [14896.857016] RSP: 0018:ffffaad880623d30 EFLAGS: 00010246
> [14896.857018] RAX: ffff993c76345000 RBX: 0000000000000001 RCX: 
> 0000000000000028
> [14896.857019] RDX: 0000000000000000 RSI: 00400000000000c0 RDI: 
> ffff993c76345000
> [14896.857020] RBP: 0000000000000140 R08: 0000000000000000 R09: 
> 0000000000000050
> [14896.857022] R10: 0000000000000000 R11: 0000000000000000 R12: 
> ffff993c76345140
> [14896.857023] R13: ffff993c00086800 R14: 0000000000000050 R15: 
> 0000000000001000
> [14896.857025] FS:  00007f69955fc800(0000) GS:ffff993c7d200000(0000) 
> knlGS:0000000000000000
> [14896.857027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14896.857028] CR2: 000055affebcad18 CR3: 000000007b7f6000 CR4: 
> 00000000000006f0
> [15189.410304] usb 1-5: USB disconnect, device number 2
> [15189.410309] usb 1-5.2: USB disconnect, device number 4
> [15190.771204] usb 4-2: USB disconnect, device number 2
> [15190.773248] pl2303 ttyUSB0: error sending break = -19
> [15190.773358] pl2303 ttyUSB0: pl2303 converter now disconnected from ttyUSB0
> [15190.773384] pl2303 4-2:1.0: device disconnected
>
