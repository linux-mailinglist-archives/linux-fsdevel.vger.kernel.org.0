Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DAA7760B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 04:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfG0ClC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 22:41:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55128 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfG0ClB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:41:01 -0400
Received: by mail-io1-f70.google.com with SMTP id n8so60705193ioo.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 19:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xdl8h64j/K1tXZR8aKApilqPTXjq2LDepoEk1JnRv9A=;
        b=iQ2HG9gcw+94rXxKRLfRMDg4yJ44vDhWUXYIFQ1dJNe0/uKfbuKz40dDtVhM37tFs4
         otN8t9MEcQvi0KSy/PeixmXTP2IPVhernfbDXCIClqjXW6muY4+cRE05i913wi3CdfG+
         s77Gtai4kONYpBdxyPaUAgk0bljK3uvp9hREt4B9z1x8yxB61K+/05IuoEksvHyrc4A/
         n0Y+TUF6WMH21Ev6zku8c73DXILLfQTaziy+hvTmyZQLLcoJlFllDqxPHjFoQonDgL0F
         E1QUHrcAdnV7oDc+7xM7q3V6QzZ9bxDmgHe8579+Vv6giD9lyCNroBfyJ41C1VYjAY0g
         6Mxg==
X-Gm-Message-State: APjAAAX3tC6RSordcSik+lMY68EK/XTaH0LriczOHBr3/d1em3GYPFPq
        +H7gFz/Fecyi1bZc0ytmkVwEpPc8WUMiwxSHGWkuNlKKTpMW
X-Google-Smtp-Source: APXvYqxFzOTpPwfbcfha2kXgWEOmQpqpehaaEzod6CgMxkVSxGE893Kxq6hno6Njx8Nsiu/hIzr+vywCVP2/nGClR61Rjg0uIjWF
MIME-Version: 1.0
X-Received: by 2002:a02:ccd2:: with SMTP id k18mr100452955jaq.3.1564195260809;
 Fri, 26 Jul 2019 19:41:00 -0700 (PDT)
Date:   Fri, 26 Jul 2019 19:41:00 -0700
In-Reply-To: <CAOQ4uxi1w0uJkJzJOMQgeoQXZ0aQqYpwSLyQQmB779DjdY3D_Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e14b0b058ea0961d@google.com>
Subject: Re: WARNING in ovl_real_fdget_meta
From:   syzbot <syzbot+032bc63605089a199d30@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

vmalloc)
[    6.623186][    T1] TCP established hash table entries: 65536 (order: 7,  
524288 bytes, vmalloc)
[    6.629001][    T1] TCP bind hash table entries: 65536 (order: 10,  
4194304 bytes, vmalloc)
[    6.633571][    T1] TCP: Hash tables configured (established 65536 bind  
65536)
[    6.635510][    T1] UDP hash table entries: 4096 (order: 7, 655360  
bytes, vmalloc)
[    6.637367][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360  
bytes, vmalloc)
[    6.639861][    T1] NET: Registered protocol family 1
[    6.642372][    T1] RPC: Registered named UNIX socket transport module.
[    6.643458][    T1] RPC: Registered udp transport module.
[    6.644319][    T1] RPC: Registered tcp transport module.
[    6.645199][    T1] RPC: Registered tcp NFSv4.1 backchannel transport  
module.
[    6.647753][    T1] NET: Registered protocol family 44
[    6.648732][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    6.649837][    T1] PCI: CLS 0 bytes, default 64
[    6.654238][    T1] PCI-DMA: Using software bounce buffering for IO  
(SWIOTLB)
[    6.655433][    T1] software IO TLB: mapped [mem 0xaa800000-0xae800000]  
(64MB)
[    6.660080][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed  
counters, 10737418240 ms ovfl timer
[    6.663698][    T1] kvm: already loaded the other module
[    6.664750][    T1] clocksource: tsc: mask: 0xffffffffffffffff  
max_cycles: 0x212735223b2, max_idle_ns: 440795277976 ns
[    6.666833][    T1] clocksource: Switched to clocksource tsc
[    6.667884][    T1] mce: Machine check injector initialized
[    6.672842][    T1] check: Scanning for low memory corruption every 60  
seconds
[    6.784695][    T1] Initialise system trusted keyrings
[    6.786453][    T1] workingset: timestamp_bits=40 max_order=21  
bucket_order=0
[    6.788062][    T1] zbud: loaded
[    6.793680][    T1] DLM installed
[    6.795747][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    6.799822][    T1] FS-Cache: Netfs 'nfs' registered for caching
[    6.802062][    T1] NFS: Registering the id_resolver key type
[    6.803162][    T1] Key type id_resolver registered
[    6.804299][    T1] Key type id_legacy registered
[    6.805300][    T1] nfs4filelayout_init: NFSv4 File Layout Driver  
Registering...
[    6.806905][    T1] Installing knfsd (copyright (C) 1996  
okir@monad.swb.de).
[    6.811461][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    6.813297][    T1] fuse: init (API version 7.31)
[    6.816259][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[    6.826202][    T1] SGI XFS with ACLs, security attributes, realtime, no  
debug enabled
[    6.832172][    T1] 9p: Installing v9fs 9p2000 file system support
[    6.833515][    T1] FS-Cache: Netfs '9p' registered for caching
[    6.838070][    T1] gfs2: GFS2 installed
[    6.841163][    T1] FS-Cache: Netfs 'ceph' registered for caching
[    6.842969][    T1] ceph: loaded (mds proto 32)
[    6.850819][    T1] NET: Registered protocol family 38
[    6.852584][    T1] async_tx: api initialized (async)
[    6.853585][    T1] Key type asymmetric registered
[    6.854272][    T1] Asymmetric key parser 'x509' registered
[    6.855126][    T1] Asymmetric key parser 'pkcs8' registered
[    6.855903][    T1] Key type pkcs7_test registered
[    6.856598][    T1] Asymmetric key parser 'tpm_parser' registered
[    6.857618][    T1] Block layer SCSI generic (bsg) driver version 0.4  
loaded (major 246)
[    6.859381][    T1] io scheduler mq-deadline registered
[    6.860444][    T1] io scheduler kyber registered
[    6.861501][    T1] io scheduler bfq registered
[    6.866618][    T1] input: Power Button as  
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    6.869055][    T1] ACPI: Power Button [PWRF]
[    6.870629][    T1] input: Sleep Button as  
/devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    6.872202][    T1] ACPI: Sleep Button [SLPF]
[    6.877520][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    6.889497][    T1] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    6.890599][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for  
legacy driver
[    6.903444][    T1] PCI Interrupt Link [LNKD] enabled at IRQ 10
[    6.904470][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for  
legacy driver
[    7.222239][    T1] HDLC line discipline maxframe=4096
[    7.223063][    T1] N_HDLC line discipline registered.
[    7.223876][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing  
enabled
[    7.247483][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =  
115200) is a 16550A
[    7.273815][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud =  
115200) is a 16550A
[    7.299513][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud =  
115200) is a 16550A
[    7.325004][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud =  
115200) is a 16550A
[    7.335983][    T1] Non-volatile memory driver v1.3
[    7.337472][    T1] Linux agpgart interface v0.103
[    7.346738][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on  
minor 0
[    7.349029][    T1] [drm] Supports vblank timestamp caching Rev 2  
(21.10.2013).
[    7.350502][    T1] [drm] Driver supports precise vblank timestamp query.
[    7.354001][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on  
minor 1
[    7.355696][    T1] usbcore: registered new interface driver udl
[    7.404586][    T1] brd: module loaded
[    7.438411][    T1] loop: module loaded
[    7.503377][    T1] zram: Added device: zram0
[    7.509773][    T1] null: module loaded
[    7.515580][    T1] nfcsim 0.2 initialized
[    7.518129][    T1] Loading iSCSI transport class v2.0-870.
[    7.540589][    T1] scsi host0: Virtio SCSI HBA
[    7.575807][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs  
256
[    7.578700][  T329] kasan: CONFIG_KASAN_INLINE enabled
[    7.580010][  T329] kasan: GPF could be caused by NULL-ptr deref or user  
memory access
[    7.580030][  T329] general protection fault: 0000 [#1] SMP KASAN
[    7.582310][    T1] kobject: 'sd' (000000007348a90e): kobject_uevent_env
[    7.583865][  T329] CPU: 1 PID: 329 Comm: kworker/u4:5 Not tainted  
5.3.0-rc1+ #1
[    7.586388][    T1] kobject: 'sd' (000000007348a90e): fill_kobj_path:  
path = '/bus/scsi/drivers/sd'
[    7.588218][  T329] Hardware name: Google Google Compute Engine/Google  
Compute Engine, BIOS Google 01/01/2011
[    7.588218][  T329] Workqueue: events_unbound async_run_entry_fn
[    7.588218][  T329] RIP: 0010:dma_direct_max_mapping_size+0x7c/0x1a7
[    7.588218][  T329] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 23 01  
00 00 49 8b 9c 24 38 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1  
ea 03 <80> 3c 02 00 0f 85 0a 01 00 00 49 8d bc 24 48 03 00 00 48 8b 1b 48
[    7.588218][  T329] RSP: 0000:ffff8880a8e9f768 EFLAGS: 00010246
[    7.591132][    T1] kobject: 'sr' (000000004b6a2965):  
kobject_add_internal: parent: 'drivers', set: 'drivers'
[    7.588218][  T329] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:  
ffffffff816007b1
[    7.595790][    T1] kobject: 'sr' (000000004b6a2965): kobject_uevent_env
[    7.588218][  T329] RDX: 0000000000000000 RSI: ffffffff816007d0 RDI:  
ffff8882195030b8
[    7.602756][    T1] kobject: 'sr' (000000004b6a2965): fill_kobj_path:  
path = '/bus/scsi/drivers/sr'
[    7.588218][  T329] RBP: ffff8880a8e9f780 R08: ffff8880a8e8c000 R09:  
ffffed10146244ec
[    7.607121][    T1] kobject: 'scsi_generic' (000000007500b938):  
kobject_add_internal: parent: 'class', set: 'class'
[    7.588218][  T329] R10: ffffed10146244eb R11: ffff8880a312275f R12:  
ffff888219502d80
[    7.588218][  T329] R13: ffff888219502d80 R14: ffff88821930e4f0 R15:  
0000000000000200
[    7.588218][  T329] FS:  0000000000000000(0000)  
GS:ffff8880ae900000(0000) knlGS:0000000000000000
[    7.588218][  T329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.588218][  T329] CR2: 0000000000000000 CR3: 0000000008c6d000 CR4:  
00000000001406e0
[    7.610920][    T1] kobject: 'scsi_generic' (000000007500b938):  
kobject_uevent_env
[    7.588218][  T329] Call Trace:
[    7.615395][    T1] kobject: 'scsi_generic' (000000007500b938):  
fill_kobj_path: path = '/class/scsi_generic'
[    7.588218][  T329]  dma_max_mapping_size+0xba/0x100
[    7.621502][    T1] kobject: 'nvme-wq' (0000000069c1aed7):  
kobject_add_internal: parent: 'workqueue', set: 'devices'
[    7.620612][  T329]  __scsi_init_queue+0x1cb/0x580
[    7.624658][    T1] kobject: 'nvme-wq' (0000000069c1aed7):  
kobject_uevent_env
[    7.620612][  T329]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[    7.628596][    T1] kobject: 'nvme-wq' (0000000069c1aed7):  
kobject_uevent_env: uevent_suppress caused the event to drop!
[    7.620612][  T329]  scsi_mq_alloc_queue+0xd2/0x180
[    7.632674][    T1] kobject: 'nvme-wq' (0000000069c1aed7):  
kobject_uevent_env
[    7.620612][  T329]  scsi_alloc_sdev+0x837/0xc60
[    7.635988][    T1] kobject: 'nvme-wq' (0000000069c1aed7):  
fill_kobj_path: path = '/devices/virtual/workqueue/nvme-wq'
[    7.620612][  T329]  scsi_probe_and_add_lun+0x2440/0x39f0
[    7.640733][    T1] kobject: 'nvme-reset-wq' (00000000e89bea04):  
kobject_add_internal: parent: 'workqueue', set: 'devices'
[    7.620612][  T329]  ? __kasan_check_read+0x11/0x20
[    7.643507][    T1] kobject: 'nvme-reset-wq' (00000000e89bea04):  
kobject_uevent_env
[    7.620612][  T329]  ? mark_lock+0xc0/0x11e0
[    7.647798][    T1] kobject: 'nvme-reset-wq' (00000000e89bea04):  
kobject_uevent_env: uevent_suppress caused the event to drop!
[    7.620612][  T329]  ? scsi_alloc_sdev+0xc60/0xc60
[    7.620612][  T329]  ? mark_held_locks+0xa4/0xf0
[    7.620612][  T329]  ? _raw_spin_unlock_irqrestore+0x67/0xd0
[    7.620612][  T329]  ? __pm_runtime_resume+0x11b/0x180
[    7.620612][  T329]  ? _raw_spin_unlock_irqrestore+0x67/0xd0
[    7.651058][    T1] kobject: 'nvme-reset-wq' (00000000e89bea04):  
kobject_uevent_env
[    7.620612][  T329]  ? lockdep_hardirqs_on+0x418/0x5d0
[    7.654901][    T1] kobject: 'nvme-reset-wq' (00000000e89bea04):  
fill_kobj_path: path = '/devices/virtual/workqueue/nvme-reset-wq'
[    7.620612][  T329]  ? trace_hardirqs_on+0x67/0x220
[    7.659728][    T1] kobject: 'nvme-delete-wq' (000000005f49ee41):  
kobject_add_internal: parent: 'workqueue', set: 'devices'
[    7.620612][  T329]  ? __kasan_check_read+0x11/0x20
[    7.662725][    T1] kobject: 'nvme-delete-wq' (000000005f49ee41):  
kobject_uevent_env
[    7.620612][  T329]  ? __pm_runtime_resume+0x11b/0x180
[    7.666955][    T1] kobject: 'nvme-delete-wq' (000000005f49ee41):  
kobject_uevent_env: uevent_suppress caused the event to drop!
[    7.620612][  T329]  __scsi_scan_target+0x29a/0xfa0
[    7.620612][  T329]  ? __pm_runtime_resume+0x11b/0x180
[    7.620612][  T329]  ? __kasan_check_read+0x11/0x20
[    7.620612][  T329]  ? mark_lock+0xc0/0x11e0
[    7.620612][  T329]  ? scsi_probe_and_add_lun+0x39f0/0x39f0
[    7.669473][    T1] kobject: 'nvme-delete-wq' (000000005f49ee41):  
kobject_uevent_env
[    7.620612][  T329]  ? mark_held_locks+0xa4/0xf0
[    7.672293][    T1] kobject: 'nvme-delete-wq' (000000005f49ee41):  
fill_kobj_path: path = '/devices/virtual/workqueue/nvme-delete-wq'
[    7.620612][  T329]  ? _raw_spin_unlock_irqrestore+0x67/0xd0
[    7.676309][    T1] kobject: 'nvme' (00000000c0971fdf):  
kobject_add_internal: parent: 'class', set: 'class'
[    7.620612][  T329]  ? __pm_runtime_resume+0x11b/0x180
[    7.680625][    T1] kobject: 'nvme' (00000000c0971fdf):  
kobject_uevent_env
[    7.620612][  T329]  ? _raw_spin_unlock_irqrestore+0x67/0xd0
[    7.684795][    T1] kobject: 'nvme' (00000000c0971fdf): fill_kobj_path:  
path = '/class/nvme'
[    7.620612][  T329]  ? lockdep_hardirqs_on+0x418/0x5d0
[    7.688010][    T1] kobject: 'nvme-subsystem' (00000000670d508f):  
kobject_add_internal: parent: 'class', set: 'class'
[    7.620612][  T329]  ? trace_hardirqs_on+0x67/0x220
[    7.620612][  T329]  scsi_scan_channel.part.0+0x11a/0x190
[    7.620612][  T329]  scsi_scan_host_selected+0x313/0x450
[    7.620612][  T329]  ? scsi_scan_host+0x450/0x450
[    7.620612][  T329]  do_scsi_scan_host+0x1ef/0x260
[    7.620612][  T329]  ? scsi_scan_host+0x450/0x450
[    7.692543][    T1] kobject: 'nvme-subsystem' (00000000670d508f):  
kobject_uevent_env
[    7.620612][  T329]  do_scan_async+0x41/0x500
[    7.695135][    T1] kobject: 'nvme-subsystem' (00000000670d508f):  
fill_kobj_path: path = '/class/nvme-subsystem'
[    7.620612][  T329]  ? scsi_scan_host+0x450/0x450
[    7.698176][    T1] kobject: 'nvme' (000000005d460dc8):  
kobject_add_internal: parent: 'drivers', set: 'drivers'
[    7.620612][  T329]  async_run_entry_fn+0x124/0x570
[    7.620612][  T329]  process_one_work+0x9af/0x16d0
[    7.620612][  T329]  ? pwq_dec_nr_in_flight+0x320/0x320
[    7.620612][  T329]  ? lock_acquire+0x190/0x400
[    7.701606][    T1] kobject: 'drivers' (00000000924ddeb2):  
kobject_add_internal: parent: 'nvme', set: '<NULL>'
[    7.620612][  T329]  worker_thread+0x98/0xe40
[    7.705786][    T1] kobject: 'nvme' (000000005d460dc8):  
kobject_uevent_env
[    7.620612][  T329]  kthread+0x361/0x430
[    7.709956][    T1] kobject: 'nvme' (000000005d460dc8): fill_kobj_path:  
path = '/bus/pci/drivers/nvme'
[    7.620612][  T329]  ? process_one_work+0x16d0/0x16d0
[    7.713199][    T1] kobject: 'ahci' (0000000029da3508):  
kobject_add_internal: parent: 'drivers', set: 'drivers'
[    7.620612][  T329]  ? kthread_cancel_delayed_work_sync+0x20/0x20
[    7.717072][    T1] kobject: 'drivers' (00000000357f3c8d):  
kobject_add_internal: parent: 'ahci', set: '<NULL>'
[    7.620612][  T329]  ret_from_fork+0x24/0x30
[    7.620612][  T329] Modules linked in:
[    7.718371][  T329] ---[ end trace bbfdfa526202cca4 ]---
[    7.721471][    T1] kobject: 'ahci' (0000000029da3508):  
kobject_uevent_env
[    7.722768][  T329] RIP: 0010:dma_direct_max_mapping_size+0x7c/0x1a7
[    7.724195][    T1] kobject: 'ahci' (0000000029da3508): fill_kobj_path:  
path = '/bus/pci/drivers/ahci'
[    7.725517][  T329] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 23 01  
00 00 49 8b 9c 24 38 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1  
ea 03 <80> 3c 02 00 0f 85 0a 01 00 00 49 8d bc 24 48 03 00 00 48 8b 1b 48
[    7.727823][    T1] kobject: 'ata_piix' (000000002393ac60):  
kobject_add_internal: parent: 'drivers', set: 'drivers'
[    7.729067][  T329] RSP: 0000:ffff8880a8e9f768 EFLAGS: 00010246
[    7.730452][    T1] kobject: 'drivers' (00000000071486d0):  
kobject_add_internal: parent: 'ata_piix', set: '<NULL>'
[    7.732312][  T329] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:  
ffffffff816007b1
[    7.733561][    T1] kobject: 'ata_piix' (000000002393ac60):  
kobject_uevent_env
[    7.736086][  T329] RDX: 0000000000000000 RSI: ffffffff816007d0 RDI:  
ffff8882195030b8
[    7.737341][    T1] kobject: 'ata_piix' (000000002393ac60):  
fill_kobj_path: path = '/bus/pci/drivers/ata_piix'
[    7.739867][  T329] RBP: ffff8880a8e9f780 R08: ffff8880a8e8c000 R09:  
ffffed10146244ec
[    7.741306][    T1] kobject: 'pata_amd' (0000000066b08d7f):  
kobject_add_internal: parent: 'drivers', set: 'drivers'
[    7.742561][  T329] R10: ffffed10146244eb R11: ffff8880a312275f R12:  
ffff888219502d80
[    7.743976][    T1] kobject: 'drivers' (00000000b292806e):  
kobject_add_internal: parent: 'pata_amd', set: '<NULL>'
[    7.745038][  T329] R13: ffff888219502d80 R14: ffff88821930e4f0 R15:  
0000000000000200
[    7.747615][    T1] kobject: 'pata_amd' (0000000066b08d7f):  
kobject_uevent_env
[    7.748706][  T329] FS:  0000000000000000(0000)  
GS:ffff8880ae900000(0000) knlGS:0000000000000000
[    7.750475][    T1] kobject: 'pata_amd' (0000000066b08d7f):  
fill_kobj_path: path = '/bus/pci/drivers/pata_amd'
[    7.751516][  T329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.753904][    T1] kobject: 'pata_oldpiix' (00000000cf9a5442):  
kobject_add_internal: parent: 'drivers', set: 'drivers'
[    7.755108][  T329] CR2: 0000000000000000 CR3: 0000000008c6d000 CR4:  
00000000001406e0
[    7.757783][    T1] kobject: 'drivers' (00000000ec356fca):  
kobject_add_internal: parent: 'pata_oldpiix', set: '<NULL>'
[    7.759296][  T329] Kernel panic - not syncing: Fatal exception
[    7.761994][    T1] kobject: 'pata_oldpiix' (00000000cf9a5442):  
kobject_uevent_env
[    7.765044][  T329] Kernel Offset: disabled
[    7.769264][  T329] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=16eae0e8600000


Tested on:

commit:         a4a6f143 ovl: detect overlapping layers with nested lower ..
git tree:       https://github.com/amir73il/linux.git  
ovl-check-nested-overlap
kernel config:  https://syzkaller.appspot.com/x/.config?x=da585491c5226246
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

