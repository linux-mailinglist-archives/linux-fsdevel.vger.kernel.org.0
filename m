Return-Path: <linux-fsdevel+bounces-75953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ/TM2DjfGkQPQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 17:59:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A08CBCC00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97D5F3011C5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30BA3542E3;
	Fri, 30 Jan 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxYbheue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE37260A;
	Fri, 30 Jan 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792345; cv=none; b=hT1K+/7X2LPPxJ6cJGpf1nZ0l4PMiJBK9v8E5ejkH1FQDUfc5LjHNS1RBOvPKDmBQ2wwMQiMFBq0VNHjqa1+gi/XcVonTzPznEIJmT6AvR9xDRF0+EBTLOXgKWO58X89aFzSu2bX1LSIhQY6ZWhAwcesbZE76+MG3RFNC4MqtUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792345; c=relaxed/simple;
	bh=cUrkIzDDTezjkboeBKyDgO0TKRNuDY51DVikFFzM37c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGSE6H9fZjgaxTcqeydq4ySaCGctfewc9uciT5oBpzb4IqLUC6XCE1rMIE6+g0VoyUgn2PV0sFFfxDeaVuyRKHy4sIWQ+dgV0luWWdUmd349aVsvtWUk6PQ5rGftLMhcVnqQuD+YQqI9jjRoI7ssxUswqjIf04/ba8626SR8esA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxYbheue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76471C4CEF7;
	Fri, 30 Jan 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769792345;
	bh=cUrkIzDDTezjkboeBKyDgO0TKRNuDY51DVikFFzM37c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxYbheueQ4CDJFteeoaGoo6eDu7Tl1YabtkO2Ke7hUQo1oyMc+tWu9Wh5ThCzo5oP
	 F+f7Lz7PuUq8qHxirTI+FYmnf9Y97SWfDC5lNHGVSJQu9On6kkiIGCNsmEzu+4Xpiw
	 S4tzjDBtD4uUOjaf0WEaTie2mGtYNvlrfGgr4nYfLd+RVR+DClzNJVghMbewE03CvS
	 SuDy8sG48SrMLT5SSZfyTJy+pJ3L+IUEMur2ls2WJjl8BwV+U79K9q28vaRQ5FqCfV
	 EY2Z8rGTK/xuN3ABHfkg9nJfEBDpABC6Vqgr95A1vliZsi9HFvBWGIMUIq1AMCH/uh
	 VVqJuWvD4z4UQ==
Date: Fri, 30 Jan 2026 17:59:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  313c47f4fe:
 BUG:kernel_hang_in_test_stage
Message-ID: <20260130-badeunfall-flaggen-d4df12bcb501@brauner>
References: <202601270735.29b7c33e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202601270735.29b7c33e-lkp@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75953-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,pengar:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A08CBCC00
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:26:09PM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "BUG:kernel_hang_in_test_stage" on:
>=20
> commit: 313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ("fs: use nullfs uncondi=
tionally as the real rootfs")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
> [test failed on linux-next/master ca3a02fda4da8e2c1cb6baee5d72352e9e2cfae=
a]
>=20
> in testcase: trinity
> version:=20
> with following parameters:
>=20
> 	runtime: 300s
> 	group: group-00
> 	nr_groups: 5
>=20
>=20
>=20
> config: x86_64-kexec
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 3=
2G
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)

The reproducer doesn't work:

ubuntu@pengar:~/data/kernel/linux/MODULES/lkp-tests$ sudo bin/lkp qemu -k .=
=2E/../vmlinux -m ./modules.cgz job-script # job-script
result_root: /home/ubuntu/.lkp//result/trinity/group-00-5-300s/vm-snb/yocto=
-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429=
a66ad331fe2b3b6f/15
downloading initrds ...
skip downloading /home/ubuntu/.lkp/cache/osimage/yocto/yocto-x86_64-minimal=
-20190520.cgz
19270 blocks
/usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 http=
s://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-20180403.cgz=
/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz -N -P /home/ubuntu/=
=2Elkp/cache/osimage/pkg/debian-x86_64-20180403.cgz
Failed to download osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-x8=
6_64-x86_64-1c734c75-1_2020-01-06.cgz
cat: '': No such file or directory
exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev local,=
id=3Dtest_dev,path=3D/home/ubuntu/.lkp//result/trinity/group-00-5-300s/vm-s=
nb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb=
2969f429a66ad331fe2b3b6f/15,security_model=3Dnone -device virtio-9p-pci,fsd=
ev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel ../../vmlinux -append roo=
t=3D/dev/ram0 RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm-snb/yocto-x8=
6_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66=
ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec/clang-20/313c47f4fe4d0=
7eb2969f429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d branch=
=3Dinternal-devel/devel-hourly-20260124-050739 job=3D/lkp/jobs/scheduled/vm=
-meta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4=
fe4d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_6=
4-kexec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f intremap=3Dposted=
_msi watchdog_thresh=3D240 rcuperf.shutdown=3D0 rcuscale.shutdown=3D0 refsc=
ale.shutdown=3D0 audit=3D0 kunit.enable=3D0 ia32_emulation=3Don max_uptime=
=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_enabl=
ed rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don=
 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ram=
disk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ig=
nore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115=
200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount -initrd /ho=
me/ubuntu/.lkp/cache/final_initrd -smp 2 -m 12872M -no-reboot -device i6300=
esb -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet=
0 -display none -monitor null -serial stdio
qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note

The paths for the downloads in the job script are wrong or don't work.
Even if I manually modify the above path I still get in the next step:

/usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 http=
s://download.01.org/0day-ci/lkp-qemu/modules.cgz -N -P /home/ubuntu/.lkp/ca=
che
Failed to download modules.cgz
cat: '': No such file or directory

I need a way to reproduce the issue to figure out exactly what is
happening.

>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202601270735.29b7c33e-lkp@intel.=
com
>=20
>=20
>=20
> [   27.746952][ T1793] /lkp/lkp/src/monitors/meminfo: line 25: /lkp/lkp/s=
rc/bin/event/wait: not found
> [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: dmesg: =
not found
> [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: grep: n=
ot found
> [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 25: /lkp/lk=
p/src/bin/event/wait: not found
> [   65.744824][ T4974] trinity-main[4974]: segfault at 0 ip 0000000000000=
000 sp 00007ffe08d2ec08 error 15 likely on CPU 0 (core 0, socket 0)
> [   65.746308][ T4974] Code: Unable to access opcode bytes at 0xfffffffff=
fffffd6.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> /etc/rc5.d/S77lkp-bootstrap: line 79: sleep: not found
> BUG: kernel hang in test stage
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260127/202601270735.29b7c33e-lk=
p@intel.com
>=20
>=20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20

