Return-Path: <linux-fsdevel+bounces-59434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A8B38A43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748B2172001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA892EC576;
	Wed, 27 Aug 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="MAXhAEkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339801C84AE;
	Wed, 27 Aug 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323425; cv=none; b=UHTeH2xkLGoiLo7UIyhMeeOOqrEhypA4/Bm5/PBZnT7ZWE/elCExfZgY9B1coGQWilwdjGKRzK0zWM7c/Gke8r7TxUUvIfQ99vJPrUT9VNRrHrs8Ch4fE48rHHS/zA1AaRBY/a0oSzwCW7LDvuR8AcJtP/Rtb/j0zVadIqdBVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323425; c=relaxed/simple;
	bh=NOtAehosKrZDnd4AdHlCC4u+Hq6giD42PGJQL0DxHXA=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=hEWOEsIQompi+p4fkVnAz2kb+yip9MwOjdl7kxI5y5fOgPe1s4Nr9pYOAKkITOMyBS9mTJdSGHHvdJZym+OF/3eAZY4AjIRwKE69848+Ar6dQqQnouq2pxyPJ/JLdu9r8YU9ERtrQHcwc0TyGMlq71hvhSDTnQc1rYF4mOKELOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=MAXhAEkM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756323413; x=1756928213; i=toralf.foerster@gmx.de;
	bh=187WRJmCML5YtAwRqk1T/SdrX+H65skijlyqH4foSQg=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:To:
	 Cc:From:Subject:cc:content-transfer-encoding:content-type:date:
	 from:message-id:mime-version:reply-to:subject:to;
	b=MAXhAEkMGQxPAYuLMZmnFliYZPbf5bWHvkd1fNClrvro6hio+ICDV99/Y0K0hyF2
	 2qLwHydSQllq2dsjaAqjPOsj/36Svd9GSWc4lPWur5uc7diIZ2RtqJZUJiBHNnhgA
	 An/8WqkcmbHdC+ka3RUkDz/9wZHe3v2suhw/tlod6dIzerSrY+KE5J6b4koP11Aka
	 kdmb5/mFNIo6N4qwn4Hp1hzKzFboD5+ZScIhXcZHb81uZ06gnw2Ffppl31SqSy0Jd
	 7uxldQrXyHT2wcTHJd+abbOefc+Ytn55AcMedWP6kNbaVEdCETVN6WCliVZ/1qSs2
	 dOvXeOLXemuklh2NWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([95.113.179.254]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1uTESr0noO-00w0kA; Wed, 27
 Aug 2025 21:36:53 +0200
Content-Type: multipart/mixed; boundary="------------DiWbWfWNJrd6ZbormcodNT1e"
Message-ID: <9dafd91d-3f90-4b01-ab02-34135c9b58fb@gmx.de>
Date: Wed, 27 Aug 2025 21:36:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org,
 Jan Kara <jack@suse.cz>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: 6.16.4-rc1 oopses under an Ubuntu at an AMD
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
X-Provags-ID: V03:K1:h81LA2r2H9tioo9oWSdDKs+cyTAaAUf4xU+3vE2WQ8VXhDaLcXX
 4GjaZjff7KM65ivqckM+rb7uZGvp9s7kvFDMPXc9+LxODPuMfXvyf0HKzI+U+Y5YQX9XV/j
 NV168lNARv3w91pKfzOPDiVd/JJTg879fu484bm26hCSiy/BPhKI54S22VJdTqIEccvRi+L
 KfPgvGx5qzrcKWhnBOneQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Hi0qLDd6vU=;PN1XQTcIT33kdbBtJdAFMPAWCAA
 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

This is a multi-part message in MIME format.
--------------DiWbWfWNJrd6ZbormcodNT1e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

I got the attached oops while testing that rc at a tiny cloud instance.


=2D-=20
Toralf

--------------DiWbWfWNJrd6ZbormcodNT1e
Content-Type: chemical/x-gaussian-log; name="common-trace-full.log"
Content-Disposition: attachment; filename="common-trace-full.log"
Content-Transfer-Encoding: quoted-printable

# TRACE BEGIN     BOOT_IMAGE=3D/boot/vmlinuz-6.16.4-rc1-g48e90cb06f98
#    hi-u-amd-stablerc    Ubuntu 24.04.3 LTS    2025-08-27 18:54:08
Aug 26 19:25:37 hi-u-amd-stablerc kernel:     BOOT_IMAGE=3D/boot/vmlinuz-6=
.16.4-rc1-g48e90cb06f98
Aug 26 19:25:37 hi-u-amd-stablerc kernel: ------------[ cut here ]--------=
=2D---
Aug 26 19:25:37 hi-u-amd-stablerc kernel: WARNING: CPU: 0 PID: 128 at fs/p=
idfs.c:1055 pidfs_get_pid+0x2f/0x40
Aug 26 19:25:37 hi-u-amd-stablerc kernel: Modules linked in: aesni_intel
Aug 26 19:25:37 hi-u-amd-stablerc kernel: CPU: 0 UID: 0 PID: 128 Comm: ude=
vadm Not tainted 6.16.4-rc1-g48e90cb06f98 #11 PREEMPT(voluntary)=20
Aug 26 19:25:37 hi-u-amd-stablerc kernel: virtio_net virtio1 enp1s0: renam=
ed from eth0
Aug 26 19:25:37 hi-u-amd-stablerc kernel: Hardware name: Hetzner vServer/S=
tandard PC (Q35 + ICH9, 2009), BIOS 20171111 11/11/2017
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RIP: 0010:pidfs_get_pid+0x2f/0x4=
0
Aug 26 19:25:37 hi-u-amd-stablerc kernel: Code: 48 85 ff 74 1c 55 48 83 c7=
 30 48 89 e5 e8 29 31 fe ff 48 85 c0 74 13 5d 31 c0 31 ff e9 2a b6 9f 00 3=
1 c0 31 ff e9 21 b6 9f 00 <0f> 0b 5d 31 c0 31 ff e9 15 b6 9f 00 0f 1f 44 0=
0 00 90 90 90 90 90
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RSP: 0018:ffffce1b4036fac8 EFLAG=
S: 00010246
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RAX: 0000000000000000 RBX: ffff8=
d72c76adb58 RCX: 0000000000000000
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RDX: 0000000000000000 RSI: 00000=
00000000003 RDI: 0000000000000000
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RBP: ffffce1b4036fac8 R08: 00000=
00000000000 R09: 0000000000000000
Aug 26 19:25:37 hi-u-amd-stablerc kernel: R10: 0000000000000000 R11: 00000=
00000000000 R12: ffff8d72c76ada50
Aug 26 19:25:37 hi-u-amd-stablerc kernel: R13: ffff8d72c76ad800 R14: ffff8=
d72c2c6f240 R15: ffff8d72c76af000
Aug 26 19:25:37 hi-u-amd-stablerc kernel: FS:  000078870c9ed8c0(0000) GS:f=
fff8d737d806000(0000) knlGS:0000000000000000
Aug 26 19:25:37 hi-u-amd-stablerc kernel: CS:  0010 DS: 0000 ES: 0000 CR0:=
 0000000080050033
Aug 26 19:25:37 hi-u-amd-stablerc kernel: CR2: 00005aa422e56db0 CR3: 00000=
0000734c000 CR4: 0000000000350ef0
Aug 26 19:25:37 hi-u-amd-stablerc kernel: Call Trace:
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  <TASK>
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  unix_stream_connect+0x603/0x870
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  __sys_connect_file+0x56/0x90
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  __sys_connect+0xa8/0xe0
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? xas_load+0x17/0x100
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  __x64_sys_connect+0x18/0x30
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  x64_sys_call+0x2583/0x2660
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  do_syscall_64+0x7b/0x2c0
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? __x64_sys_socket+0x17/0x30
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? do_fault+0x2c0/0x6a0
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? __handle_mm_fault+0x72c/0x121=
0
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? user_path_at+0x45/0x60
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? count_memcg_events+0x180/0x20=
0
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? handle_mm_fault+0xbc/0x300
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? do_user_addr_fault+0x1cd/0x8c=
0
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? irqentry_exit_to_user_mode+0x=
2a/0x200
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? irqentry_exit+0x43/0x50
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  ? exc_page_fault+0x7c/0x170
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  entry_SYSCALL_64_after_hwframe+=
0x76/0x7e
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RIP: 0033:0x78870d1b6974
Aug 26 19:25:37 hi-u-amd-stablerc kernel: Code: 00 f7 d8 64 89 01 48 83 c8=
 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 f6 0d 00 00 7=
4 13 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e=
5 48 83 ec 10 89 55
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RSP: 002b:00007ffe1dfa83d8 EFLAG=
S: 00000202 ORIG_RAX: 000000000000002a
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RAX: ffffffffffffffda RBX: 00005=
aa43a9efa50 RCX: 000078870d1b6974
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RDX: 0000000000000014 RSI: 00005=
aa43a9efa60 RDI: 0000000000000003
Aug 26 19:25:37 hi-u-amd-stablerc kernel: RBP: 00007ffe1dfa8510 R08: 35353=
22d76656475 R09: 0000000000000000
Aug 26 19:25:37 hi-u-amd-stablerc kernel: R10: 0000000000000001 R11: 00000=
00000000202 R12: 00007ffe1dfa83e0
Aug 26 19:25:37 hi-u-amd-stablerc kernel: R13: 0000000000000000 R14: 00005=
aa422e77d40 R15: 000078870d37d000
Aug 26 19:25:37 hi-u-amd-stablerc kernel:  </TASK>
Aug 26 19:25:37 hi-u-amd-stablerc kernel: ---[ end trace 0000000000000000 =
]---
# TRACE END     BOOT_IMAGE=3D/boot/vmlinuz-6.16.4-rc1-g48e90cb06f98

--------------DiWbWfWNJrd6ZbormcodNT1e--

