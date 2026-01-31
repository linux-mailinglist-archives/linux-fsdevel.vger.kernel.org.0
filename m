Return-Path: <linux-fsdevel+bounces-75992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFwwNmLqfWmMUQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 12:41:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E91C1B99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2BCF3002F61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA75327BE1;
	Sat, 31 Jan 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrVpI7rB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3F2D3ECF;
	Sat, 31 Jan 2026 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769859677; cv=none; b=qIQrTYkHWDNFE41EWFl1zsHcBO+MN6KaesIe34rPIc8/pr6LWPlWyu9roWqtEBsZQ58IGnIW5pkL6L+UTzaJCrUsXqkWzPnN4WFprvj6R5YZlymNcsejf4zYIYOzT6HvE9T6yDwwb97HZP4em5NjRXwDz0VRiXN2GEIVviUMEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769859677; c=relaxed/simple;
	bh=mFtRDbFczihva/ihfO+N/FHXxmdX8/IgH7+zENm+F64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHPpllpAzTk2LEWOHX9EMlkzcP5t0r3BbFXi1SOAkktMn2//Mnl6GPE/fQwvH6HeoIRdCcPsNpiThkqZNWjJ6jaE19spgQjGLnz2VUlyy+MLEwV7icB2y+PdyjIqilTIbHwT6pGu+pFEoiqsgw+QXR2cp9DwifWvdoJnD18QElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrVpI7rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3686BC19422;
	Sat, 31 Jan 2026 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769859676;
	bh=mFtRDbFczihva/ihfO+N/FHXxmdX8/IgH7+zENm+F64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrVpI7rBkqGg71b1sKDrzLmgt3FvV41RMYSxQS/jXSW6XyQgYPOtK0S54VVLHq7aA
	 0rc7mR/N12JD3P+LvU7voQbzI/cC5q6JurV75lARyfvx8QAH+Sw7KV2cHzKojZGtmU
	 T6Z7DSZHqHNI4+VfY+PqyJ0NW/T7aTtcWPoJUfXWmhk/Jt0R7M+c4HxQV2uY5oKuW3
	 xVXkC/XAdB++0SHt/9WmF7T6ZewMoGHXDrzAy8qwa6ldqDd3TDpbXX0x+TdIyz/DkG
	 Sbb9b1mvG3stgdKcQUYNp4YfUZhcUkIeqN4JM4TPRhikwigKwrsIb27gWZQFdZV16V
	 zZfNPBxeY70Lg==
Date: Sat, 31 Jan 2026 12:41:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  313c47f4fe:
 BUG:kernel_hang_in_test_stage
Message-ID: <20260131-dahin-nahtlos-06f69134584a@brauner>
References: <202601270735.29b7c33e-lkp@intel.com>
 <20260130-badeunfall-flaggen-d4df12bcb501@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260130-badeunfall-flaggen-d4df12bcb501@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75992-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,pengar:email]
X-Rspamd-Queue-Id: 35E91C1B99
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 05:59:00PM +0100, Christian Brauner wrote:
> On Tue, Jan 27, 2026 at 02:26:09PM +0800, kernel test robot wrote:
> >=20
> >=20
> > Hello,
> >=20
> > kernel test robot noticed "BUG:kernel_hang_in_test_stage" on:
> >=20
> > commit: 313c47f4fe4d07eb2969f429a66ad331fe2b3b6f ("fs: use nullfs uncon=
ditionally as the real rootfs")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >=20
> > [test failed on linux-next/master ca3a02fda4da8e2c1cb6baee5d72352e9e2cf=
aea]
> >=20
> > in testcase: trinity
> > version:=20
> > with following parameters:
> >=20
> > 	runtime: 300s
> > 	group: group-00
> > 	nr_groups: 5
> >=20
> >=20
> >=20
> > config: x86_64-kexec
> > compiler: clang-20
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 32G
> >=20
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
> The reproducer doesn't work:
>=20
> ubuntu@pengar:~/data/kernel/linux/MODULES/lkp-tests$ sudo bin/lkp qemu -k=
 ../../vmlinux -m ./modules.cgz job-script # job-script
> result_root: /home/ubuntu/.lkp//result/trinity/group-00-5-300s/vm-snb/yoc=
to-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f4=
29a66ad331fe2b3b6f/15
> downloading initrds ...
> skip downloading /home/ubuntu/.lkp/cache/osimage/yocto/yocto-x86_64-minim=
al-20190520.cgz
> 19270 blocks
> /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 ht=
tps://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-20180403.c=
gz/trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06.cgz -N -P /home/ubunt=
u/.lkp/cache/osimage/pkg/debian-x86_64-20180403.cgz
> Failed to download osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-=
x86_64-x86_64-1c734c75-1_2020-01-06.cgz
> cat: '': No such file or directory
> exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev loca=
l,id=3Dtest_dev,path=3D/home/ubuntu/.lkp//result/trinity/group-00-5-300s/vm=
-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07=
eb2969f429a66ad331fe2b3b6f/15,security_model=3Dnone -device virtio-9p-pci,f=
sdev=3Dtest_dev,mount_tag=3D9p/virtfs_mount -kernel ../../vmlinux -append r=
oot=3D/dev/ram0 RESULT_ROOT=3D/result/trinity/group-00-5-300s/vm-snb/yocto-=
x86_64-minimal-20190520.cgz/x86_64-kexec/clang-20/313c47f4fe4d07eb2969f429a=
66ad331fe2b3b6f/0 BOOT_IMAGE=3D/pkg/linux/x86_64-kexec/clang-20/313c47f4fe4=
d07eb2969f429a66ad331fe2b3b6f/vmlinuz-6.19.0-rc1-00006-g313c47f4fe4d branch=
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
> qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note
>=20
> The paths for the downloads in the job script are wrong or don't work.
> Even if I manually modify the above path I still get in the next step:
>=20
> /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 ht=
tps://download.01.org/0day-ci/lkp-qemu/modules.cgz -N -P /home/ubuntu/.lkp/=
cache
> Failed to download modules.cgz
> cat: '': No such file or directory
>=20
> I need a way to reproduce the issue to figure out exactly what is
> happening.

Ok, I got it all working and can run the reproducer. But I cannot
reproduce the error below at all. I've tried vfs.all, vfs-7.0.nullfs,
vfs-7.0.initrd, and I tried ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea. In
all cases:

root@vm-snb:~# which dmesg
/bin/dmesg
root@vm-snb:~# which sleep
/bin/sleep
root@vm-snb:~# which grep
/bin/grep
root@vm-snb:~# /lkp/lkp/src/bin/event/wait
Usage: /lkp/lkp/src/bin/event/wait [-t|--timeout seconds] PIPE_NAME

root      1736  0.0  0.0   4144  1020 ?        S    10:36   0:00 /bin/sh /e=
tc/rc5.d/S77lkp-bootstrap start
root      1738  0.0  0.0   4408  2676 ?        S    10:36   0:00  \_ /bin/s=
h /lkp/lkp/src/bin/lkp-setup-rootfs
root      1771  0.0  0.0   4144  1908 ?        S    10:36   0:00      \_ ta=
il -f /tmp/stderr
root      1853  0.0  0.0   4408  2688 ?        S    10:36   0:00      \_ /b=
in/sh /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-17/trinity-group=
-00-5-300s-yocto-x86_64-minimal-20190520.c
root      1875  0.0  0.0   4144  1932 ?        S    10:36   0:00          \=
_ tail -n 0 -f /tmp/stdout
root      1876  0.0  0.0   4144  1900 ?        S    10:36   0:00          \=
_ tail -n 0 -f /tmp/stderr
root      1877  0.0  0.0   4144  2196 ?        S    10:36   0:00          \=
_ tail -n 0 -f /tmp/stdout /tmp/stderr
root      1930  0.0  0.0   4148  2524 ?        S    10:36   0:00          \=
_ /bin/sh /lkp/jobs/scheduled/vm-meta-17/trinity-group-00-5-300s-yocto-x86_=
64-minimal-20190520.cgz-313c47f4fe4d-20260
root      1943  0.0  0.0   4016  1892 ?        S    10:36   0:00           =
   \_ cat /proc/kmsg
root      1974  0.0  0.0   4016  1856 ?        S    10:36   0:00           =
   |   \_ cat /tmp/lkp/fifo-kmsg
root      1945  0.0  0.0   2476  1732 ?        S    10:36   0:00           =
   \_ vmstat --timestamp -n 10
root      1989  0.0  0.0   4016  1928 ?        S    10:36   0:00           =
   |   \_ cat /tmp/lkp/fifo-heartbeat
root      1948  0.1  0.0   4148  2492 ?        S    10:36   0:00           =
   \_ /bin/sh /lkp/lkp/src/monitors/meminfo
root      1995  0.0  0.0   4280  2120 ?        S    10:36   0:00           =
   |   \_ gzip -c
root      2532  0.0  0.0   1144   832 ?        S    10:39   0:00           =
   |   \_ /lkp/lkp/src/bin/event/wait post-test --timeout 1
root      1952  0.0  0.0   4148  2392 ?        S    10:36   0:00           =
   \_ /bin/sh /lkp/lkp/src/monitors/oom-killer
root      1978  0.0  0.0   4016  1880 ?        S    10:36   0:00           =
   |   \_ cat /tmp/lkp/fifo-oom-killer
root      2523  0.0  0.0   1144   836 ?        S    10:39   0:00           =
   |   \_ /lkp/lkp/src/bin/event/wait post-test --timeout 11
root      1955  0.0  0.0   4148  2140 ?        S    10:36   0:00           =
   \_ /bin/sh /lkp/lkp/src/monitors/plain/watchdog
root      1971  0.0  0.0   1144   832 ?        S    10:36   0:00           =
   |   \_ /lkp/lkp/src/bin/event/wait job-finished --timeout 7200
root      2026  0.0  0.0   4148  2448 ?        S    10:37   0:00           =
   \_ /bin/sh /lkp/lkp/src/programs/trinity/run
root      2049  0.0  0.0   4016  1820 ?        S    10:37   0:00           =
       \_ sleep 300
root      1747  0.0  0.0   4144  2176 ?        Ss   10:36   0:00 /bin/sh /b=
in/start_getty 115200 ttyS0 vt102
root      1794  0.0  0.0   4188  2424 ttyS0    Ss   10:36   0:00  \_ -sh
root      2533  0.0  0.0   3288  2272 ttyS0    R+   10:39   0:00      \_ ps=
 auxf
root      1749  0.0  0.0   4144  2176 tty1     Ss+  10:36   0:00 /sbin/gett=
y 38400 tty1
root      1963  0.0  0.0   1144   324 ?        Ss   10:36   0:00 /lkp/lkp/s=
rc/bin/event/wakeup activate-monitor
root      1968  0.0  0.0   1144   320 ?        Ss   10:36   0:00 /lkp/lkp/s=
rc/bin/event/wakeup pre-test
root      2030  0.0  0.0   4148  1972 ?        S    10:37   0:00 tee -a //r=
esult/trinity/group-00-5-300s/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_=
64-kexec/clang-20/313c47f4fe4d07eb2969f429

Is there any more data you can provide or how much and how reliable this
test fails? Otherwise I have no choice but to discount this for now.

> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202601270735.29b7c33e-lkp@inte=
l.com
> >=20
> >=20
> >=20
> > [   27.746952][ T1793] /lkp/lkp/src/monitors/meminfo: line 25: /lkp/lkp=
/src/bin/event/wait: not found
> > [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: dmesg=
: not found
> > [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 94: grep:=
 not found
> > [   31.757224][ T1793] /lkp/lkp/src/monitors/oom-killer: line 25: /lkp/=
lkp/src/bin/event/wait: not found
> > [   65.744824][ T4974] trinity-main[4974]: segfault at 0 ip 00000000000=
00000 sp 00007ffe08d2ec08 error 15 likely on CPU 0 (core 0, socket 0)
> > [   65.746308][ T4974] Code: Unable to access opcode bytes at 0xfffffff=
fffffffd6.
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > /etc/rc5.d/S77lkp-bootstrap: line 79: sleep: not found
> > BUG: kernel hang in test stage
> >=20
> >=20
> >=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20260127/202601270735.29b7c33e-=
lkp@intel.com
> >=20
> >=20
> >=20
> > --=20
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >=20

