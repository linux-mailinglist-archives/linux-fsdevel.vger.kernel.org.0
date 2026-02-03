Return-Path: <linux-fsdevel+bounces-76187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHO2ABTxgWnkMwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 13:59:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC9FD980E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 13:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36BFB301912F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF86345CA3;
	Tue,  3 Feb 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvaSzOoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5A3446A7;
	Tue,  3 Feb 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123436; cv=none; b=TnHvTY9JXZALKr6+JDJTWY7c+5AmdAWiDyNAqSZiGFVZ/3dM5qhqZNQeIT1CenjGdaO0P+r/5iW30LLaONeU+W2/EtOMWiljBM6QBqUCWIuJoIcwyDppqGVLctSHywx0Z0pEbqy8PMnftMuWPNbSeCf0QFWImlDukolvJvY+t14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123436; c=relaxed/simple;
	bh=6GFUfYtoKHy55EZcUs9ojwoaABxPUQGH/pkHIMwTj0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsgak+9h+0d58pusnG4v2fnDKcZoksOS7hHoCn+VO4OAcgtq2hUgrPhvxCVxC8KPpcTgtVBprLo75QCG6R0pjhsqfCUMuQNhTnGxBVk+99+hviEc2FANq4Vt09GbXz2YlgpfKsXnjozwaqjNhIDHXU92JKkw2bi5en0ghro1hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvaSzOoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8F4C19421;
	Tue,  3 Feb 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123436;
	bh=6GFUfYtoKHy55EZcUs9ojwoaABxPUQGH/pkHIMwTj0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvaSzOoYe5wHCmKGYm38XkP4QWBOWCfr0+XQNyOyIeooL1gQ2GYh2bUTB4mt01fNA
	 Ma3ykQG7mvyAw/FyTHEUP8uB9ba9YfgXRjYosi1aGNWLEeL88IFfOIfj/M015BstWQ
	 //wkcQULl1+Xtz2cn2vlqTnqa0D1UxVTvQjge6sE7QJbOr5XvLU6W/ZpnuptoXx2+6
	 8xf3sQrvWbnqgLEFQvDedz/58UGi66zwQhTy8i011PZhPXpXgkbWF6myCOWgs13Fwe
	 7mGg8dsVsWxM5azmy6+xafRKm6F3lYx35iWoabf0kaKuFtM3Akx5devoPvCbNXPp2v
	 kx71Wx8S80bGA==
Date: Tue, 3 Feb 2026 13:57:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  313c47f4fe:
 BUG:kernel_hang_in_test_stage
Message-ID: <20260203-galopp-wachdienst-02c010334a81@brauner>
References: <202601270735.29b7c33e-lkp@intel.com>
 <20260130-badeunfall-flaggen-d4df12bcb501@brauner>
 <20260131-dahin-nahtlos-06f69134584a@brauner>
 <aYFPw4WeItF84APy@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aYFPw4WeItF84APy@xsang-OptiPlex-9020>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76187-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 0AC9FD980E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 09:30:43AM +0800, Oliver Sang wrote:
> hi, Christian Brauner,
>=20
> sorry for late. it cost us some time to double confirm.
>=20
> On Sat, Jan 31, 2026 at 12:41:12PM +0100, Christian Brauner wrote:
> > On Fri, Jan 30, 2026 at 05:59:00PM +0100, Christian Brauner wrote:
> > > On Tue, Jan 27, 2026 at 02:26:09PM +0800, kernel test robot wrote:
> > > >=20
> > > >=20
> > > > Hello,
> > > >=20
> > > > kernel test robot noticed "BUG:kernel_hang_in_test_stage" on:
> > > >=20
> > > > commit: 313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ("fs: use nullfs u=
nconditionally as the real rootfs")
> > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git ma=
ster
> > > >=20
> > > > [test failed on linux-next/master ca3a02fda4da8e2c1cb6baee5d72352e9=
e2cfaea]
> > > >=20
> > > > in testcase: trinity
> > > > version:=20
> > > > with following parameters:
> > > >=20
> > > > 	runtime: 300s
> > > > 	group: group-00
> > > > 	nr_groups: 5
> > > >=20
> > > >=20
> > > >=20
> > > > config: x86_64-kexec
> > > > compiler: clang-20
> > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp =
2 -m 32G
> > > >=20
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >=20
> > > The reproducer doesn't work:
> > >=20
> > > ubuntu@pengar:~/data/kernel/linux/MODULES/lkp-tests$ sudo bin/lkp qem=
u -k ../../vmlinux -m ./modules.cgz job-script # job-script
> > > result_root: /home/ubuntu/.lkp//result/trinity/group-00-5-300s/vm-snb=
/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb29=
69f429a66ad331fe2b3b6f/15
> > > downloading initrds ...
> > > skip downloading /home/ubuntu/.lkp/cache/osimage/yocto/yocto-x86_64-m=
inimal-20190520.cgz
> > > 19270 blocks
> > > /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-=
8 https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-201804=
03.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz -N -P /home/u=
buntu/.lkp/cache/osimage/pkg/debian-x86_64-20180403.cgz
> > > Failed to download osimage/pkg/debian-x86_64-20180403.cgz/trinity-sta=
tic-x86_64-x86_64-1c734c75-1_2020-01-06.cgz
> > > cat: '': No such file or directory
> > > exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev =
local,id=3Dtest_dev,path=3D/home/ubuntu/.lkp//result/trinity/group-00-5-300=
s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe=
4d07eb2969f429a66ad331fe2b3b6f/15,security_model=3Dnone -device virtio-9p-p=
ci,fsdev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel ../../vmlinux -appe=
nd root=3D/dev/ram0 RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm-snb/yo=
cto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f=
429a66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec/clang-20/313c47f=
4fe4d07eb2969f429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d br=
anch=3Dinternal-devel/devel-hourly-20260124-050739 job=3D/lkp/jobs/schedule=
d/vm-meta-17/trinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c=
47f4fe4d-20260126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx=
86_64-kexec commit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f intremap=3Dpo=
sted_msi watchdog_thresh=3D240 rcuperf.shutdown=3D0 rcuscale.shutdown=3D0 r=
efscale.shutdown=3D0 audit=3D0 kunit.enable=3D0 ia32_emulation=3Don max_upt=
ime=3D7200 LKP_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_en=
abled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=
=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic loa=
d_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3De=
rr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS=
0,115200 vga=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount -initr=
d /home/ubuntu/.lkp/cache/final_initrd -smp 2 -m 12872M -no-reboot -device =
i6300esb -rtc base=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=
=3Dnet0 -display none -monitor null -serial stdio
> > > qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF=
 Note
> > >=20
> > > The paths for the downloads in the job script are wrong or don't work.
> > > Even if I manually modify the above path I still get in the next step:
> > >=20
> > > /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-=
8 https://download.01.org/0day-ci/lkp-qemu/modules.cgz -N -P /home/ubuntu/.=
lkp/cache
> > > Failed to download modules.cgz
> > > cat: '': No such file or directory
> > >=20
> > > I need a way to reproduce the issue to figure out exactly what is
> > > happening.
> >=20
> > Ok, I got it all working and can run the reproducer.
>=20
> not sure how you solve it? from above log, the problem is caused by
> trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz, do you have any l=
og?
> internally, it's a soft link pointing to a debian version, so maybe there=
 are
> some code issue for uploading to https://download.01.org/0day-ci.
>=20
> if you could share more information with us, we could check further to im=
prove
> our process and reproducer. thanks a lot!
>=20
> we will also check by ourselves, so no problem at all if you ignore this.

I manually edited the job-script file to point to something existing on
the server. If I delete everything that I did and restart the test using
just the parameters and the job-script provided with your link then I
run into the issues I mentioned in my first mail again...

        ubuntu@pengar:~/data/kernel/linux/MODULES/lkp-tests$ sudo bin/lkp q=
emu -k ~/data/repro.nullfs/lkp/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d -m ~/=
data/repro.nullfs/lkp/modules-313c47f4fe4d.cgz job-script
        The approx. disk space requirements are

        10M             simple boot test in rootfs openwrt
        50M             simple boot test in rootfs debian
        1G              plan to run a number of different tests
        100G or more    IO tests

        Please enter a dir with enough disk space, or simply press Enter to=
 accept the default.
        You may still symlink /home/ubuntu/.lkp to a more suitable place in=
 future.
        /home/ubuntu/.lkp =3D> /home/ubuntu/data/lkp/
        ~/data/kernel/linux/MODULES/lkp-tests/programs/lkp-src/pkg ~/data/k=
ernel/linux/MODULES/lkp-tests
        x86_64
        =3D=3D> Making package: lkp-src 0-1 (Tue Feb  3 10:27:03 UTC 2026)
        =3D=3D> Checking runtime dependencies...
        =3D=3D> Checking buildtime dependencies...
        =3D=3D> WARNING: Using existing $srcdir/ tree
        =3D=3D> Removing existing $pkgdir/ directory...
        =3D=3D> Starting build()...
        make: Entering directory '/home/ubuntu/data/kernel/linux/MODULES/lk=
p-tests/bin/event'
        gcc  -D_FORTIFY_SOURCE=3D2  -c -o wakeup.o wakeup.c
        gcc  -Wl,-O1,--sort-common,--as-needed,-z,relro -static -o wakeup w=
akeup.o
        rm -f wakeup.o
        strip wakeup
        make: Leaving directory '/home/ubuntu/data/kernel/linux/MODULES/lkp=
-tests/bin/event'
        =3D=3D> Entering fakeroot environment...
        x86_64
        =3D=3D> Starting package()...
        =3D=3D> Creating package "lkp-src"...
        10999 blocks
        renamed '/home/ubuntu/.lkp/cache/lkp-x86_64.cgz.tmp' -> '/home/ubun=
tu/.lkp/cache/lkp-x86_64.cgz'
        =3D=3D> Leaving fakeroot environment.
        =3D=3D> Finished making: lkp-src 0-1 (Tue Feb  3 10:27:05 UTC 2026)
        ~/data/kernel/linux/MODULES/lkp-tests
        result_root: /home/ubuntu/.lkp//result/trinity/group-00-5-300s/vm-s=
nb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb=
2969f429a66ad331fe2b3b6f/0
        downloading initrds ...
        use local modules: /home/ubuntu/.lkp/cache/modules-313c47f4fe4d.cgz
        /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUT=
F-8 https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-x86_64-min=
imal-20190520.cgz -N -P /home/ubuntu/.lkp/cache/osimage/yocto
        19270 blocks
        /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUT=
F-8 https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-2018=
0403.cgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz -N -P /home=
/ubuntu/.lkp/cache/osimage/pkg/debian-x86_64-20180403.cgz
        Failed to download osimage/pkg/debian-x86_64-20180403.cgz/trinity-s=
tatic-x86_64-x86_64-1c734c75-1_2020-01-06.cgz
        cat: '': No such file or directory
        exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsde=
v local,id=3Dtest_dev,path=3D/home/ubuntu/.lkp//result/trinity/group-00-5-3=
00s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4=
fe4d07eb2969f429a66ad331fe2b3b6f/0,security_model=3Dnone -device virtio-9p-=
pci,fsdev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel /home/ubuntu/data/=
repro.nullfs/lkp/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d -append root=3D/dev=
/ram0 RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm-snb/yocto-x86_64-min=
imal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a66ad331fe2=
b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f=
429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d branch=3Dinterna=
l-devel/devel-hourly-20260124-050739 job=3D/lkp/jobs/scheduled/vm-meta-17/t=
rinity-group-00-5-300s-yocto-x86_64-minimal-20190520.cgz-313c47f4fe4d-20260=
126-53110-19zhjsh-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-kexec co=
mmit=3D313c47f4fe4d07eb2969f429a66ad331fe2b3b6f intremap=3Dposted_msi watch=
dog_thresh=3D240 rcuperf.shutdown=3D0 rcuscale.shutdown=3D0 refscale.shutdo=
wn=3D0 audit=3D0 kunit.enable=3D0 ia32_emulation=3Don max_uptime=3D7200 LKP=
_LOCAL_RUN=3D1 selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate=
=2Ercu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D=
-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 =
prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_logl=
evel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=
=3Dnormal rw  ip=3Ddhcp result_service=3D9p/virtfs_mount -initrd /home/ubun=
tu/.lkp/cache/final_initrd -smp 2 -m 12169M -no-reboot -device i6300esb -rt=
c base=3Dlocaltime -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0 -disp=
lay none -monitor null -serial stdio
        early console in setup code
        No EFI environment detected.
        early console in extract_kernel
        input_data: 0x00000000031ee2c4
        input_len: 0x0000000000ce259d
        output: 0x0000000001000000
        output_len: 0x0000000002e81808
        kernel_total_size: 0x0000000002c28000
        needed_size: 0x0000000003000000
        trampoline_32bit: 0x0000000000000000

        Decompressing Linux... Parsing ELF... done.
        Booting the kernel (entry_offset: 0x0000000002718ff0).

So I edit job-script and do:

        # export bm_initrd=3D'/osimage/pkg/debian-x86_64-20180403.cgz/trini=
ty-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'
        export bm_initrd=3D'/osimage/pkg/debian-13-x86_64-20250902.cgz/trin=
ity-x86_64-294c4652-1_20251011.cgz'

but that doesn't work because the glibc version is too old for the
trinity test thing. So I switch to another bm_initrd:

        # original: export bm_initrd=3D'/osimage/pkg/debian-x86_64-20180403=
=2Ecgz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'
        # export bm_initrd=3D'/osimage/pkg/debian-13-x86_64-20250902.cgz/tr=
inity-x86_64-294c4652-1_20251011.cgz'
        export bm_initrd=3D'/osimage/pkg/yocto-x86_64-minimal-20190520.cgz/=
trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz'

And that one got it working and I managed to reproduce the issue.

The tests executes random VFS system calls including pivot_root(). I
added debugging output into that system call:

And then it becomes clear:

        [   21.185641][ T5251] VFS: BEFORE PIVOT ROOT FROM /var/volatile/tm=
p to /var/volatile/tmp
        [   21.185645][ T5251] pivot_root: overmounts from nullfs BEFORE PI=
VOT ROOT (nullfs):
        [   21.185646][ T5251]   [0] ffff88816a4e3c80 (rootfs)
        [   21.185709][ T5251] VFS: AFTER PIVOT ROOT FROM / to /
        [   21.192478][ T5251] pivot_root: overmounts from nullfs AFTER PIV=
OT ROOT (nullfs):
        [   21.192480][ T5251]   [0] ffff88816a4e2d80 (tmpfs)
        [   21.201027][ T5251]   [1] ffff88816a4e3c80 (rootfs)

        <snip>

        [   29.328721][ T5250] VFS: BEFORE PIVOT ROOT FROM /var/volatile/tm=
p to /var/volatile/tmp
        [   29.331584][ T5250] pivot_root: overmounts from nullfs BEFORE PI=
VOT ROOT (nullfs):
        [   29.334168][ T5250]   [0] ffff88810ca52300 (rootfs)
        [   29.335742][ T5250] VFS: AFTER PIVOT ROOT FROM / to /
        [   29.337399][ T5250] pivot_root: overmounts from nullfs AFTER PIV=
OT ROOT (nullfs):
        [   29.339935][ T5250]   [0] ffff88811efba300 (tmpfs)
        [   29.341133][ T5250]   [1] ffff88810ca52300 (rootfs)

        <snip>

        [   30.507784][ T1768] /lkp/lkp/src/monitors/meminfo: line 45: date=
: not found
        [   30.507784][ T1768] /lkp/lkp/src/monitors/meminfo: line 46: cat:=
 not found
        [   30.507784][ T1768] /lkp/lkp/src/monitors/meminfo: line 25: /lkp=
/lkp/src/bin/event/wait: not found

During random system call execution
pivot_root("/var/volatile/tmp", "/var/volatile/tmp")
is called. This makes the "/var/volatile/tmp" tmpfs mount the rootfs for
everyone and mounts the old rootfs on top of the new rootfs. That means
as soon as anything is called that relies on binaries that are located
in the old rootfs they won't find it anymore as the fs root of all
tasks has been set to /var/volatile/tmp

Before nullfs that pivot_root() call would have failed because the
initramfs mount had no parent mount. nullfs makes that finally work.

I would like to try and enable nullfs unconditional before we resort to
making it a boot option. pivot_root() is inherently destructive for a
test setup so I would just do:

diff --git a/syscalls/pivot_root.c b/syscalls/pivot_root.c
index 3a33fcc5..13c00b07 100644
--- a/syscalls/pivot_root.c
+++ b/syscalls/pivot_root.c
@@ -11,4 +11,5 @@ struct syscallentry syscall_pivot_root =3D {
        .arg2name =3D "put_old",
        .arg2type =3D ARG_ADDRESS,
        .group =3D GROUP_VFS,
+       .flags =3D AVOID_SYSCALL, /* May end up switching everyone's rootfs=
=2E */
 };

You would see the same problem if instead of running from the initramfs
mount you'd be running from a separate rootfs. In other words running
these tests with a rootfs would surface the same error.

I'd appreciate it if you would patch trinity with my diff above (no
attribution needed). I suspect people generally don't run system call
fuzzers in their workloads so I'd like to move forward and only revert
if we have to.

