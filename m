Return-Path: <linux-fsdevel+bounces-38842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5866A08C46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41B23ABA75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9724920B1ED;
	Fri, 10 Jan 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="qBJpg/z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBF1E200F;
	Fri, 10 Jan 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501491; cv=none; b=mfGhidRJKDqKzIxas/qbhgiaAY4/kZeJUSn6nAAXVhspolFdWSwTEycSck9OYkLchXDTKQA+OsiSgkWvz/og1e6OBLQkdfdY04O+X+EXiaeAHLiZ/uMQbUaYYNZGrLhQ0REFGlyjS783BQ7C2S3EUIRj4AdvYvx13zYLZskxl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501491; c=relaxed/simple;
	bh=KlrOHID4z0Uh5MhaglClFM2pyatWqUYnm1bgsHYLo2M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dedmIb2mNaQt3AQziiLBlaxzTL/Le7TPvexdypQXRhl+0KzxcL3pVrY5pz4741B289685yqG8+lhT7lfUUaGtHuGZxK7qZD2CVMvRVQQvHTOB4AyRGcNEBr52wJY2L7DqNfZPMm7+vOEczZqJih0I6eufKm7fvIeN6aI4EZNTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=qBJpg/z/; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736501455;
	bh=SWsnT0feYnCS/GVVOzaOxBYVy5EoL7E4rZJHzw22+zg=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=qBJpg/z/kMhY1yWmKK1FFN4FAzsrvNo/OsABhoymlOERWXQFxRREdQHiCtvWRcBVg
	 NuOfcGTPpb7eJW1eISfxhgVYWU3F5gZsHgocnbBsgVagm06zYaG9MX/Uqu8ys8yCia
	 HM1kFUnE+0ALfWr5ZtD+4aQtUoZCBMZG2p6oDdY0=
X-QQ-mid: bizesmtpip2t1736501449tebe10p
X-QQ-Originating-IP: 2vGcmeXzDzcsP0eIh7dcVk0xCCRWE9bIliz67lBIdlE=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 17:30:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9490470609800888079
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
Date: Fri, 10 Jan 2025 17:30:37 +0800
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
To: linkinjeon@kernel.org,
 sj1557.seo@samsung.com,
 yuezhang.mo@sony.com
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MOfz9TzWtqad7XpGB5C1Palo9Oj8fFUsTNTB2S8uoPiH9pXxprdO1ZZw
	4e0DFyFAF1T+vWO7+78m9bLfhLqwz7ssieScDr3ZbLDrsj92JAdnSUCowo+cYn9O2A8+RkK
	IP8PWDboYbuervtws6rqAEImmqFNf2HqmNQ74Kx1pXSDLZiGE9qex8eBEiP+RJPfg1+MUB2
	GgnwqxV7b8VQY9+0GUPjbtnhjPcmcCyON9mnEfyuMqCV/7btEj/mpR1XQKDwIHYQgw3HVTg
	GkLzHvXXICvJzl1Pc2AbGana06bF7j26fT1YcRT7nfk7ySiovTPeyzov+U+wpqzAXMG5iyd
	mwVVQ4BRMeA7yfJH0ScsMmgTryKzJRsBEYjIi3ZMSZNBxEDgCl5oGzQOpNFd+ElWeuwzQ3J
	oF4FC18QBJ6DLDqdCAX7VOaxidoaFelrV2/W21hvJUggqwBjyZc0hGTYVo6gtpRj4tvpREr
	cViKwtSbE1998RtSH8iBkcpjFRUPFHTCnVNFgBeNEOYJH+LaMqXKQrtMld3oxaon0atPod5
	DqFFdZbvb2QmnXaqBYyHQjTnJu/kdYKjwKixDBZ8Oen4sLUCiW/t/LhpJhWZiT1wJimFg1R
	iqDdVzhdY1xRWSOdxD+9KyXMpKMmBSpdoeG43RVlF6UZOd71cXY6JO2btariVTgbo7Zi7Bb
	+8d8mC44QawtX6EACbsYuEQGnGDbfEoc6S4nb5ONSpKtjUGXxGk2Kqyf6VgY6CyqFV7McVs
	hTOMqLuiI3h80GG59FC01xLOIMkc36SrRCYMCJ1tyF9fCBoGp2+/qHZPEkPxwXRljy2was/
	a6yQXptzZYvHMNCXKjrFGs38t27CTKYOVuVAWejjdLyXry28CDAncZEwr+qhK/d6jVgBOPA
	Tb2UauLhZEbdthNbro6HPnhgsfXFT1glExSI5WeE+A8GcYuqfxwnoCILBYmHTeRtTMECTLI
	oG6UEucaXlaQqEHGZDst8Mwq/agwBLzfpyqu4e83VCBGi1ULWg3kj7laUX/4MLOIUB+R/oq
	h44x9bnlCFehXkPFsaIIltpswzn7s=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B41=E6=9C=886=E6=97=A5 16:45=EF=BC=8CKun Hu =
<huk23@m.fudan.edu.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hello,
>=20
> When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash
> was triggered.
>=20
> HEAD commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> git tree: upstream
> Console output: =
https://drive.google.com/file/d/1aWtDTAUFlAzvMI7YM_TLWbfbyqKFB71i/view?usp=
=3Ddrive_link
> Kernel config: =
https://drive.google.com/file/d/1n2sLNg-YcIgZqhhQqyMPTDWM_N1Pqz73/view?usp=
=3Dsharing
> C reproducer: =
https://drive.google.com/file/d/1oXFZgdxZDCrcZTmyatmI6TeYoHCaIxEA/view?usp=
=3Ddrive_link
> Syzlang reproducer: =
https://drive.google.com/file/d/1KX9cnANDRzXZ1FjKl3uv6rSFC-5kLsko/view?usp=
=3Dsharing
>=20
>=20
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>
>=20
> watchdog: BUG: soft lockup - CPU#1 stuck for 26s! =
[syz-executor140:420]
> Modules linked in:
> irq event stamp: 163590
> hardirqs last  enabled at (163589): [<ffffffff9c4d07eb>] =
irqentry_exit+0x3b/0x90 kernel/entry/common.c:357
> hardirqs last disabled at (163590): [<ffffffff9c4cedbf>] =
sysvec_apic_timer_interrupt+0xf/0xb0 arch/x86/kernel/apic/apic.c:1049
> softirqs last  enabled at (163576): [<ffffffff9450f554>] =
softirq_handle_end kernel/softirq.c:407 [inline]
> softirqs last  enabled at (163576): [<ffffffff9450f554>] =
handle_softirqs+0x544/0x870 kernel/softirq.c:589
> softirqs last disabled at (163555): [<ffffffff9451120e>] __do_softirq =
kernel/softirq.c:595 [inline]
> softirqs last disabled at (163555): [<ffffffff9451120e>] =
invoke_softirq kernel/softirq.c:435 [inline]
> softirqs last disabled at (163555): [<ffffffff9451120e>] =
__irq_exit_rcu kernel/softirq.c:662 [inline]
> softirqs last disabled at (163555): [<ffffffff9451120e>] =
irq_exit_rcu+0xee/0x140 kernel/softirq.c:678
> CPU: 1 UID: 0 PID: 420 Comm: syz-executor140 Not tainted 6.13.0-rc5 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:exfat_clear_bitmap+0x3f1/0x580 fs/exfat/balloc.c:174
> Code: 24 60 01 00 00 b9 40 0c 00 00 4c 89 fa e8 57 10 ff 01 bf a1 ff =
ff ff 89 c3 89 c6 e8 49 52 5f ff 83 fb a1 74 13 48 83 c4 18 5b <5d> 41 =
5c 41 5d 41 5e 41 5f e9 01 50 5f ff e8 fc 4f 5f ff 49 8d b4
> RSP: 0018:ffa00000035f7a90 EFLAGS: 00000286
> RAX: 0000000000000000 RBX: 0000000000006ccc RCX: ffffffff952a4d03
> RDX: 0000000000000011 RSI: ff110000118ba340 RDI: 0000000000000003
> RBP: ff110000131cc000 R08: 0000000000000000 R09: fffffbfff4d5f0ed
> R10: fffffbfff4d5f0ec R11: 0000000000000001 R12: ff110000131ce000
> R13: 0000000000000011 R14: 0000000000000000 R15: 0000000006cccf6b
> FS:  000055556ed2d880(0000) GS:ff11000053a80000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe1b6fdd18 CR3: 000000000db32002 CR4: 0000000000771ef0
> PKRU: 55555554
> Call Trace:
> <IRQ>
> </IRQ>
> <TASK>
> __exfat_free_cluster+0x775/0x980 fs/exfat/fatent.c:192
> exfat_free_cluster+0x7a/0x100 fs/exfat/fatent.c:232
> __exfat_truncate+0x6bf/0x900 fs/exfat/file.c:235
> exfat_evict_inode+0x10d/0x1a0 fs/exfat/inode.c:683
> evict+0x403/0x880 fs/inode.c:796
> iput_final fs/inode.c:1946 [inline]
> iput fs/inode.c:1972 [inline]
> iput+0x51c/0x830 fs/inode.c:1958
> do_unlinkat+0x5c7/0x750 fs/namei.c:4594
> __do_sys_unlink fs/namei.c:4635 [inline]
> __se_sys_unlink fs/namei.c:4633 [inline]
> __x64_sys_unlink+0x40/0x50 fs/namei.c:4633
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff5d82fb1db
> Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe1b6ff558 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff5d82fb1db
> RDX: 00007ffe1b6ff580 RSI: 00007ffe1b6ff580 RDI: 00007ffe1b6ff610
> RBP: 00007ffe1b6ff610 R08: 0000000000000001 R09: 00007ffe1b6ff3e0
> R10: 00000000fffffff7 R11: 0000000000000206 R12: 00007ffe1b700710
> R13: 000055556ed36bb0 R14: 00007ffe1b6ff578 R15: 0000000000000001
> </TASK>
>=20
>=20
> ---------------
> thanks,
> Kun Hu


Hi,

I=E2=80=99m not sure if this is sufficient to help locate the bug? If =
you need additional information, please let me know.

Thanks,
Kun Hu


