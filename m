Return-Path: <linux-fsdevel+bounces-48882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2D3AB538D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA4F867FB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9328CF41;
	Tue, 13 May 2025 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKmdsx9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600C28C863
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134780; cv=none; b=W9Vb4cpQdfIxwkgaWab2ZZKMj7/UjtWoviul4RRQSz2HDz4jPtK6iL7IPzN7/1ZxCoIK8p8KvpsNnuo9Wi6Yo+ZuxDK+PuetgXp/RdfK7VLx9GdJuZvsmMqKv6JNk5+MXccNXVB4FURMdhX5UrFKw6N96N4wUAExlctxZI6PgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134780; c=relaxed/simple;
	bh=c5pKvbqk0wON6Txh6pfz7sPN5K7HpGri1axsvVCYGYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYmyLa7J4YbVTtEsmp/k2sran3uLNuR+LsPiTcmAJxonWf716zhWtbaawo3gYgc5lCtWfLZtqGGiN05jW2hemarga2EpBB4yicvpvs//KEaJNl1EDlAklwf7waPQPEMqvr0qw25yiPVx6msgt7eAQQY2bWRMdUGSpYWBH27AbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKmdsx9m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747134780; x=1778670780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c5pKvbqk0wON6Txh6pfz7sPN5K7HpGri1axsvVCYGYs=;
  b=BKmdsx9mV4LTcx/3Ypm80j5IE1Knda3kci2MnfdzB6Fm6y/WhFHCf15F
   EpC3E80b3aj8PX2WxlMsLd5P3lzS6YIzmSBPpTGH/r1GWmBqAUfU/gyWx
   AzcLufyDxT5gPffJdnuyJd5NhMWCIBYzF7KIfGj7LblM5bsflv4A5Aolh
   6afb1zy0ubuTTxsBKUE/Jlu9rf1DrkXlh/Zrt6kGAkTfo8K7MG87faqI/
   j2t9jBK2MLboaGEs8NIIe272YDN/mTKAoIiYchaJK1BO2BOLOOTX0NeEB
   QELUgHSb6BPq+l47A9azJHrATIAHANcDwKY98b6pP6KNeOQsNwLu4dbeW
   Q==;
X-CSE-ConnectionGUID: UoGzqiRsS1GybiDH9B/j8Q==
X-CSE-MsgGUID: ZZ/d0gCvQB6w2vRblV2igw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49053765"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="49053765"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 04:12:59 -0700
X-CSE-ConnectionGUID: VPnPcek8RsSVQuIG+qgqZg==
X-CSE-MsgGUID: TakqPYYGR46hkygh+UvRLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="137711547"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.35.3])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 04:12:57 -0700
Date: Tue, 13 May 2025 19:03:14 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, yi1.lai@intel.com
Subject: Re: [PATCH 3/4] do_move_mount(): don't leak MNTNS_PROPAGATING on
 failures
Message-ID: <aCMm8r48BuZ8+DTo@ly-workstation>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200211.GF2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508200211.GF2023217@ZenIV>

Hi Al Viro,

Greetings!

I used Syzkaller and found that there is general protection fault in do_move_mount in linux v6.15-rc6.

After bisection and the first bad commit is:
"
267fc3a06a37 do_move_mount(): don't leak MNTNS_PROPAGATING on failures
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250513_095133_do_move_mount/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250513_095133_do_move_mount/bzImage_82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250513_095133_do_move_mount/bzImage_82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3

"
[   17.307248] ==================================================================
[   17.307611] BUG: KASAN: slab-use-after-free in ip6_route_info_create+0xb84/0xc30
[   17.307993] Read of size 1 at addr ffff8880100b8a94 by task repro/727
[   17.308291] 
[   17.308389] CPU: 0 UID: 0 PID: 727 Comm: repro Not tainted 6.15.0-rc4-next-20250428-33035b665157 #1 PREEMPT(voluntary) 
[   17.308397] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.308405] Call Trace:
[   17.308412]  <TASK>
[   17.308414]  dump_stack_lvl+0xea/0x150
[   17.308439]  print_report+0xce/0x660
[   17.308469]  ? ip6_route_info_create+0xb84/0xc30
[   17.308475]  ? kasan_complete_mode_report_info+0x80/0x200
[   17.308482]  ? ip6_route_info_create+0xb84/0xc30
[   17.308489]  kasan_report+0xd6/0x110
[   17.308496]  ? ip6_route_info_create+0xb84/0xc30
[   17.308504]  __asan_report_load1_noabort+0x18/0x20
[   17.308509]  ip6_route_info_create+0xb84/0xc30
[   17.308516]  ip6_route_add+0x32/0x320
[   17.308524]  ipv6_route_ioctl+0x414/0x5a0
[   17.308530]  ? __pfx_ipv6_route_ioctl+0x10/0x10
[   17.308539]  ? __might_fault+0xf1/0x1b0
[   17.308556]  inet6_ioctl+0x265/0x2b0
[   17.308568]  ? __pfx_inet6_ioctl+0x10/0x10
[   17.308573]  ? do_anonymous_page+0x4b5/0x1b30
[   17.308579]  ? register_lock_class+0x49/0x4b0
[   17.308597]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   17.308616]  sock_do_ioctl+0xde/0x260
[   17.308628]  ? __pfx_sock_do_ioctl+0x10/0x10
[   17.308634]  ? __lock_acquire+0x410/0x2260
[   17.308640]  ? __lock_acquire+0x410/0x2260
[   17.308649]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   17.308656]  sock_ioctl+0x23e/0x6a0
[   17.308665]  ? __pfx_sock_ioctl+0x10/0x10
[   17.308671]  ? __this_cpu_preempt_check+0x21/0x30
[   17.308683]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   17.308694]  ? lockdep_hardirqs_on+0x89/0x110
[   17.308703]  ? trace_hardirqs_on+0x51/0x60
[   17.308717]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   17.308723]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   17.308729]  ? ktime_get_coarse_real_ts64+0xad/0xf0
[   17.308737]  ? __pfx_sock_ioctl+0x10/0x10
[   17.308744]  __x64_sys_ioctl+0x1bc/0x220
[   17.308765]  x64_sys_call+0x122e/0x2150
[   17.308774]  do_syscall_64+0x6d/0x150
[   17.308783]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.308789] RIP: 0033:0x7f75a8c3ee5d
[   17.308797] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   17.308803] RSP: 002b:00007ffe7620af68 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[   17.308814] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f75a8c3ee5d
[   17.308818] RDX: 00000000200015c0 RSI: 000000000000890b RDI: 0000000000000003
[   17.308821] RBP: 00007ffe7620af80 R08: 0000000000000800 R09: 0000000000000800
[   17.308825] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffe7620b098
[   17.308828] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007f75a8fc3000
[   17.308835]  </TASK>
[   17.308837] 
[   17.320668] Allocated by task 653:
[   17.320836]  kasan_save_stack+0x2c/0x60
[   17.321028]  kasan_save_track+0x18/0x40
[   17.321217]  kasan_save_alloc_info+0x3c/0x50
[   17.321430]  __kasan_slab_alloc+0x62/0x80
[   17.321627]  kmem_cache_alloc_noprof+0x13d/0x430
[   17.321855]  getname_kernel+0x5c/0x390
[   17.322044]  kern_path+0x29/0x90
[   17.322203]  unix_find_other+0x11b/0x880
[   17.322395]  unix_stream_connect+0x4f5/0x1a50
[   17.322604]  __sys_connect_file+0x159/0x1d0
[   17.322805]  __sys_connect+0x176/0x1b0
[   17.322986]  __x64_sys_connect+0x7b/0xc0
[   17.323180]  x64_sys_call+0x1bc7/0x2150
[   17.323371]  do_syscall_64+0x6d/0x150
[   17.323555]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.323793] 
[   17.323876] Freed by task 653:
[   17.324024]  kasan_save_stack+0x2c/0x60
[   17.324212]  kasan_save_track+0x18/0x40
[   17.324405]  kasan_save_free_info+0x3f/0x60
[   17.324606]  __kasan_slab_free+0x3d/0x60
[   17.324799]  kmem_cache_free+0x2ea/0x520
[   17.324987]  putname.part.0+0x132/0x180
[   17.325175]  kern_path+0x74/0x90
[   17.325335]  unix_find_other+0x11b/0x880
[   17.325526]  unix_stream_connect+0x4f5/0x1a50
[   17.325736]  __sys_connect_file+0x159/0x1d0
[   17.325941]  __sys_connect+0x176/0x1b0
[   17.326122]  __x64_sys_connect+0x7b/0xc0
[   17.326316]  x64_sys_call+0x1bc7/0x2150
[   17.326504]  do_syscall_64+0x6d/0x150
[   17.326687]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.326929] 
[   17.327013] The buggy address belongs to the object at ffff8880100b8000
[   17.327013]  which belongs to the cache names_cache of size 4096
[   17.327572] The buggy address is located 2708 bytes inside of
[   17.327572]  freed 4096-byte region [ffff8880100b8000, ffff8880100b9000)
[   17.328121] 
[   17.328204] The buggy address belongs to the physical page:
[   17.328461] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100b8
[   17.328831] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   17.329184] flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
[   17.329508] page_type: f5(slab)
[   17.329670] raw: 000fffffc0000040 ffff88800d72cdc0 dead000000000100 dead000000000122
[   17.330022] raw: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
[   17.330381] head: 000fffffc0000040 ffff88800d72cdc0 dead000000000100 dead000000000122
[   17.330738] head: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
[   17.331094] head: 000fffffc0000003 ffffea0000402e01 00000000ffffffff 00000000ffffffff
[   17.331454] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[   17.331807] page dumped because: kasan: bad access detected
[   17.332066] 
[   17.332150] Memory state around the buggy address:
[   17.332374]  ffff8880100b8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.332703]  ffff8880100b8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.333031] >ffff8880100b8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.333361]                          ^
[   17.333545]  ffff8880100b8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.333874]  ffff8880100b8b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   17.334201] ==================================================================
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Thu, May 08, 2025 at 09:02:11PM +0100, Al Viro wrote:
> as it is, a failed move_mount(2) from anon namespace breaks
> all further propagation into that namespace, including normal
> mounts in non-anon namespaces that would otherwise propagate
> there.
> 
> Fixes: 064fe6e233e8 ("mount: handle mount propagation for detached mount trees")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d8a344d0a80a..04a9bb9f31fa 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3715,15 +3715,14 @@ static int do_move_mount(struct path *old_path,
>  	if (err)
>  		goto out;
>  
> -	if (is_anon_ns(ns))
> -		ns->mntns_flags &= ~MNTNS_PROPAGATING;
> -
>  	/* if the mount is moved, it should no longer be expire
>  	 * automatically */
>  	list_del_init(&old->mnt_expire);
>  	if (attached)
>  		put_mountpoint(old_mp);
>  out:
> +	if (is_anon_ns(ns))
> +		ns->mntns_flags &= ~MNTNS_PROPAGATING;
>  	unlock_mount(mp);
>  	if (!err) {
>  		if (attached) {
> -- 
> 2.39.5
> 

