Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9823BCEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgHDPDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHDPAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:00:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E5C06174A;
        Tue,  4 Aug 2020 08:00:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e11so6579110otk.4;
        Tue, 04 Aug 2020 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IaNLxJ1/WlvDLv3w/w1llfejQsijIQCGiwCc3+/r9KI=;
        b=XnDFHAHn2g9C2MR8ZRaL13rYndbckI3ZGTLXFJUu3N1b9L/zHfW+5wja/WoFbxdrLP
         ZgoUl8KD7T0Y2PlzBRTrHhSe2Ktf7Ule69RwGzXM7FWItptX6XcTKrIfDXOYmv6a4qHm
         CFBEXRsJhvbtd/V6kOiUA3Bwnkv3YCW3eL01YjWA+kuI98WdABfK81WKx5lbpdwN9DJJ
         AcVxOA+Kg3Ti3dth1GLJg6qVowpcVxFBKxhv2vorzJKCxf466lInxSSbWW6Q9jzP+gdM
         XmQ3ySKuqKTaaBUvDO335eKZvuRqR1eV69ZvpkvrKlW4Raqwbl3gt/dqUrWqtAdDrZal
         9ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IaNLxJ1/WlvDLv3w/w1llfejQsijIQCGiwCc3+/r9KI=;
        b=O2HiAtchKYLfqVeT8C4h/CmpK0lJ/ThyXXf5Sh0r3xhHYC6zmUu8lWO55C6jizAmjj
         BYc3EDWmCca3F7/iqc9y4UzCjTIY6NGGsDYDE9s2TmZ4MK2gw0KaXK/RtCzM9ONn2c+J
         M/B946cqE0yu+b7ZTREM9tQdk6ehaZX+ToftGyC91D7Xnz1NEywIhR7eY/VrnOrnHegT
         jn8nSJwhLGM1BwmqLDsWcwsWOfcrtadjoTb2Q5JzRUD5gxk8Emh/ju9FEWLD4diCSrY9
         94bDuyHIoy66/IlGRzlMC7Q3fpPjKMVRJT6i80BGGKtI5TpALgGo35JiK4ePZ4lyZMtO
         2xWw==
X-Gm-Message-State: AOAM533qHp0tb1aXQ2AQaJ43H92bp6n3mdYEN810R71TtxpHQbKNyFYX
        ns5oQq+cFvE0IpDlj63ZhUTQt9HXXLwuUKFB5+Q5j56HQM8=
X-Google-Smtp-Source: ABdhPJwfQiVbIWerhpofmsk6XOXt3poc8oqAEZouH2TKDdVMM6pu1x65uvdYOxbbU2diHF6AiXahTHry2nFgb6qp1vA=
X-Received: by 2002:a9d:4e6:: with SMTP id 93mr18890630otm.308.1596553200893;
 Tue, 04 Aug 2020 08:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANsGL8PFnEvBcfLV7eKZQCONoork3EQ7x_RdtkFPXuWZQbK=qg@mail.gmail.com>
 <20200804111913.GA15856@quack2.suse.cz>
In-Reply-To: <20200804111913.GA15856@quack2.suse.cz>
From:   nirinA raseliarison <nirina.raseliarison@gmail.com>
Date:   Tue, 4 Aug 2020 17:59:42 +0300
Message-ID: <CANsGL8Oe-4ZO3K2vxwv+Sh2GgZUwcxyQM+0N7jTC6hTA+086oA@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:531!
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hello!
no issue yet with 5.8:

Linux version 5.8.0.20200803 (nirina@supernova.org) (gcc (GCC) 10.2.0,
GNU ld version 2.33.1-slack15) #1 SMP Mon Aug 3 16:17:10 EAT 2020

it seems that the bug was triggered when i ran programs compiled
against gcc-9.3.0 under kernel build with gcc-10.1.0, but not sure if
that is the real problem. running the programs under the same compiler
doesn't exhibit the bug and since i rebuilt the programs with
gcc-10.1.0, i no longer hit the issue.

here is my /proc/mounts :

/dev/root / ext4 rw,relatime 0 0
devtmpfs /dev devtmpfs rw,relatime,size=3D3927496k,nr_inodes=3D981874,mode=
=3D755 0 0
proc /proc proc rw,relatime 0 0
sysfs /sys sysfs rw,relatime 0 0
tmpfs /run tmpfs rw,nosuid,nodev,noexec,relatime,size=3D32768k,mode=3D755 0=
 0
devpts /dev/pts devpts rw,relatime,gid=3D5,mode=3D620,ptmxmode=3D000 0 0
tmpfs /dev/shm tmpfs rw,relatime 0 0
cgroup_root /sys/fs/cgroup tmpfs rw,relatime,size=3D8192k,mode=3D755 0 0
cpuset /sys/fs/cgroup/cpuset cgroup rw,relatime,cpuset 0 0
cpu /sys/fs/cgroup/cpu cgroup rw,relatime,cpu 0 0
cpuacct /sys/fs/cgroup/cpuacct cgroup rw,relatime,cpuacct 0 0
blkio /sys/fs/cgroup/blkio cgroup rw,relatime,blkio 0 0
memory /sys/fs/cgroup/memory cgroup rw,relatime,memory 0 0
devices /sys/fs/cgroup/devices cgroup rw,relatime,devices 0 0
freezer /sys/fs/cgroup/freezer cgroup rw,relatime,freezer 0 0
net_cls /sys/fs/cgroup/net_cls cgroup rw,relatime,net_cls 0 0
perf_event /sys/fs/cgroup/perf_event cgroup rw,relatime,perf_event 0 0
/dev/sda3 /mnt/sda3 ext4 rw,relatime 0 0
/dev/sda5 /usr/local ext4 rw,relatime 0 0
/dev/sda6 /mnt/big ext4 rw,relatime 0 0
/dev/sda1 /mnt/sda1 ext4 rw,relatime 0 0
tmpfs /var/run tmpfs rw,nosuid,nodev,noexec,relatime,size=3D32768k,mode=3D7=
55 0 0
nfsd /proc/fs/nfs nfsd rw,relatime 0 0
nfsd /proc/fs/nfsd nfsd rw,relatime 0 0
devpts /dev/pts devpts rw,relatime,gid=3D5,mode=3D620,ptmxmode=3D000 0 0
none /var/run/user/1000 tmpfs rw,relatime,size=3D102400k,mode=3D700,uid=3D1=
000 0 0
none /run/user/1000 tmpfs rw,relatime,size=3D102400k,mode=3D700,uid=3D1000 =
0 0
none /var/run/user/0 tmpfs rw,relatime,size=3D102400k,mode=3D700 0 0
none /run/user/0 tmpfs rw,relatime,size=3D102400k,mode=3D700 0 0
nirina:/mnt/sda6 /mnt/sda6 nfs
rw,relatime,vers=3D3,rsize=3D262144,wsize=3D262144,namlen=3D255,hard,proto=
=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D192.168.100.2,mountver=
s=3D3,mountport=3D37772,mountproto=3Dudp,local_lock=3Dnone,addr=3D192.168.1=
00.2
0 0
nirina:/mnt/sda14 /mnt/sda14 nfs
rw,relatime,vers=3D3,rsize=3D262144,wsize=3D262144,namlen=3D255,hard,proto=
=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D192.168.100.2,mountver=
s=3D3,mountport=3D37772,mountproto=3Dudp,local_lock=3Dnone,addr=3D192.168.1=
00.2
0 0
nirina:/mnt/sda15 /mnt/sda15 nfs
rw,relatime,vers=3D3,rsize=3D262144,wsize=3D262144,namlen=3D255,hard,proto=
=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D192.168.100.2,mountver=
s=3D3,mountport=3D37772,mountproto=3Dudp,local_lock=3Dnone,addr=3D192.168.1=
00.2
0 0
nirina:/mnt/sda16 /mnt/sda16 nfs
rw,relatime,vers=3D3,rsize=3D262144,wsize=3D262144,namlen=3D255,hard,proto=
=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D192.168.100.2,mountver=
s=3D3,mountport=3D37772,mountproto=3Dudp,local_lock=3Dnone,addr=3D192.168.1=
00.2
0 0


Le mar. 4 ao=C3=BBt 2020 =C3=A0 14:19, Jan Kara <jack@suse.cz> a =C3=A9crit=
 :
>
> Hello!
>
> On Wed 27-05-20 21:05:55, nirinA raseliarison wrote:
> > i hit again this bug with:
> >
> > $ cat /proc/version
> > Linux version 5.7.0-rc7.20200525 (nirina@supernova.org) (gcc version
> > 10.1.0 (GCC), GNU ld version 2.33.1-slack15) #1 SMP Mon May 25
> > 02:49:28 EAT 2020
>
> Thanks for report! I see this didn't get any reply. Can you still hit thi=
s
> issue with 5.8? If yes, what workload do you run on the machine to trigge=
r
> this? Can you send contents of /proc/mounts please? Thanks!
>
>                                                                 Honza
>
> >
> >
> > [99390.044690] ------------[ cut here ]------------
> > [99390.044695] kernel BUG at fs/inode.c:531!
> > [99390.044702] invalid opcode: 0000 [#1] SMP PTI
> > [99390.044705] CPU: 0 PID: 149 Comm: kswapd0 Not tainted 5.7.0-rc7.2020=
0525 #1
> > [99390.044706] Hardware name: To be filled by O.E.M. To be filled by
> > O.E.M./ONDA H61V Ver:4.01, BIOS 4.6.5 01/07/2013
> > [99390.044712] RIP: 0010:clear_inode+0x75/0x80
> > [99390.044714] Code: a8 20 74 2a a8 40 75 28 48 8b 83 28 01 00 00 48
> > 8d 93 28 01 00 00 48 39 c2 75 17 48 c7 83 98 00 00 00 60 00 00 00 5b
> > c3 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 90 0f 1f 44 00 00 53 ba 48 02
> > 00 00
> > [99390.044716] RSP: 0018:ffffc900004c7b50 EFLAGS: 00010006
> > [99390.044717] RAX: 0000000000000000 RBX: ffff88808c5f9e38 RCX: 0000000=
000000000
> > [99390.044718] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888=
08c5f9fb8
> > [99390.044719] RBP: ffff88808c5f9e38 R08: ffffffffffffffff R09: ffffc90=
0004c7cd8
> > [99390.044720] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888=
08c5f9fb0
> > [99390.044721] R13: ffff888215658000 R14: ffff888215658070 R15: 0000000=
00000014c
> > [99390.044723] FS:  0000000000000000(0000) GS:ffff888217600000(0000)
> > knlGS:0000000000000000
> > [99390.044724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [99390.044725] CR2: 00000006f9004000 CR3: 00000001511da001 CR4: 0000000=
0001606f0
> > [99390.044726] Call Trace:
> > [99390.044732]  ext4_clear_inode+0x16/0x80
> > [99390.044736]  ext4_evict_inode+0x58/0x4c0
> > [99390.044738]  evict+0xbf/0x180
> > [99390.044740]  prune_icache_sb+0x7e/0xb0
> > [99390.044743]  super_cache_scan+0x161/0x1e0
> > [99390.044746]  do_shrink_slab+0x146/0x290
> > [99390.044749]  shrink_slab+0xac/0x2a0
> > [99390.044752]  ? __switch_to_asm+0x40/0x70
> > [99390.044754]  shrink_node+0x16f/0x660
> > [99390.044757]  balance_pgdat+0x2cf/0x5b0
> > [99390.044759]  kswapd+0x1dc/0x3a0
> > [99390.044762]  ? __schedule+0x217/0x710
> > [99390.044764]  ? wait_woken+0x80/0x80
> > [99390.044766]  ? balance_pgdat+0x5b0/0x5b0
> > [99390.044768]  kthread+0x118/0x130
> > [99390.044770]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [99390.044772]  ret_from_fork+0x35/0x40
> > [99390.044773] Modules linked in: 8021q garp stp mrp llc rtl8192cu
> > rtl_usb rtl8192c_common rtlwifi mac80211 cfg80211 uas usb_storage
> > nct6775 hwmon_vid ipv6 rfkill nf_defrag_ipv6 snd_pcm_oss snd_mixer_oss
> > fuse hid_generic usbhid hid snd_hda_codec_hdmi snd_hda_codec_realtek
> > snd_hda_codec_generic i2c_dev coretemp hwmon i915 x86_pkg_temp_thermal
> > intel_powerclamp kvm_intel kvm i2c_algo_bit irqbypass drm_kms_helper
> > evdev r8169 snd_hda_intel syscopyarea snd_intel_dspcfg realtek
> > snd_hda_codec libphy crc32_pclmul sysfillrect serio_raw sysimgblt
> > snd_hwdep fb_sys_fops snd_hda_core drm snd_pcm fan thermal
> > drm_panel_orientation_quirks snd_timer intel_gtt 8250 agpgart snd
> > 8250_base ehci_pci serial_core button ehci_hcd video soundcore
> > i2c_i801 lpc_ich mfd_core mei_me mei loop
> > [99390.044800] ---[ end trace 2ca57858c52a0ad4 ]---
> >
> > --
> > nirinA
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
