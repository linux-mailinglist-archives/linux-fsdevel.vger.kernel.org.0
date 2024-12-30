Return-Path: <linux-fsdevel+bounces-38266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E534C9FE4D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC9F162233
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778181A2550;
	Mon, 30 Dec 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VWCIbrjr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C6146A69;
	Mon, 30 Dec 2024 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735550989; cv=none; b=eH7uEV0FhteGZVjUYxpkSieTbH5ApY1YRJ+MRxWoESj/6b88QFcInzYHxEcIzvjPX7fyRFdvhLfGnci7DfHDI0bXOuE3xTJBRVVicRfZGxAOPdMHz8BKSL6TohI+s78Pk65XXwP4RiqFO8puTdC9xiA0QUzIW29K7ozkfg+gPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735550989; c=relaxed/simple;
	bh=19mEbpuQpyiB+oR5kE48j404+kNhDCdhQK1doe7xZe0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=plI6yA8H/LYsE5JBAykzL7Wx2Tao8r2cAG1FzI8Sii1nYdFCscA09wQnDAEM+EcZKJzj3Z1tyomCaBn7Ek626l6xRcZZ8Ev177J6R18NZfnOxXoio8HsHVwB+0BHBC3Tcd9pA6kCUlvQStq4C2RwJG1VL0F/j1bhKFmpHWOxpBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VWCIbrjr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1735550984; x=1736155784; i=quwenruo.btrfs@gmx.com;
	bh=FpXYl3FWnUwOzJBz2i5WEeuq4SIbVKARfpXQOz3N+xY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VWCIbrjrXdzMvjd1MqArOAqphk9ZjQCMQX93Nl+bO2zifdiBrgI6fBncYsTupQ10
	 ioK9sKXKAbx2N5HwFEHASuukC1/ZnaX3eYA83PewyILGkGwcMjGuHVaPS0mqHLOVg
	 5G/JMLiLFSG72rBqAKrJ0pbR3S+OkQKTwMfCPKwIJqH5ufIPZ2BsQExBrpWYgT/zF
	 FEaBTyGbMWuLJFaMOUrLfmJNe4+dvljumWpv6bBbCrWaa1FtC9ZJWPAffEf6TtveT
	 8TUW1YXqy/MfCCARGWPcud9sp7WHgttNgctsleJNgKgRyq6TsWlv414zNPqyZUxy8
	 j9oSdYdW5FAf5Eitkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof57-1tqmTx1IMb-00ppuW; Mon, 30
 Dec 2024 10:29:44 +0100
Message-ID: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
Date: Mon, 30 Dec 2024 19:59:41 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: mnt_list corruption triggered during btrfs/326
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SiqzN9WUKs1I9TS+Jh1M2NJuaJ6+vznjaFacWh1uXAwRnT9Zom5
 K8dY2FvysJBlYgHMr2lGEOBMXmyA+gfB4hNpw1ijdcRvLg8aDGJkE5v/qtxoidLsU2ekUbO
 UL8xHoKNs2lciGn++4j7uSumFge968D0QPKtCrXsnivFE4EZAZxfz8w0r1sKD9U2+Nn4Mt5
 Knpn2c92RL6rLHHWVPKgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NqSC/m5aazI=;SZsPhpbhvr9Vn/XS3Y1UYdtd4vt
 Yoym7orRVnOa8ObmLRAYfpIQOYjWZyUqSYfabjTW1VPK+ZDYv33i6QGGq+TxAbaMj7SNjQgKO
 6Ps2obx2eYek5wbTLc93uBJQriMGjjuDq2kLOiVQPdeakhkaM0oKt73iH1bJjOSzBYVi2vmWV
 HY438hvt1C2Eas6MYLREid6qr6kKhixn9jgBU6DLNoR/VzDPGL9wzbb1DI+O11qsrgGrBWVoi
 Dz7Vf9tKWKo7Y/ftc8NaSn2lhILYfRkHqL9dOTsqFt3vbwFiu+kp73Y2209Kp+u5xnPSGDFrn
 /LZM05JPweNFjhyO8r9lVbjTzGUSCkygRN/519rflF/FuOpFJVZugl37ToSksA9RRxDeTCF3U
 5IDjJ5MXBYZQnPlNQZPDcwAQYx1NA7bd3TIRcT0tM8gnuwN3xiEP1VutavEwY6QV+nUzQ+P7d
 8nA5l+AywN51UYQUDAKB+E1YoSzqjld9/TfEbPpFpUgjiq0k2JzSJI8Lsz01qIEYY01ws9X3S
 j0wbGikn2Ix5PFh1r/LTNADXPPVfnU/oDzcuM5YMff048AaA9TlAczujdlh+YOJghxcgPdtNU
 LjOpWlKqxdmJFz+QQCQJfdyaCyhwwUTIZ02i2BiyX08vjpfy3aJzCPjmHFQSoO/8pvUsu53nO
 fq3WuQYQ+P9WHVhmagVVtj9RxwTC3+McIVi2jaOYUVDdQKfJNm4rXsDIrclCzpj2ReroBAnIU
 p+RtrH6vJZVuco1k1TjB7HuCi+Qg3ZfUXxyQvgvn35wvfHkQpBonRwb2oi3bi5gLY6lWo3Xni
 Guur0Y9+ynh7kL7cQBNLkY3FiJ38RzPW2OEZ9PJz//hVeqs4vENKQULMK3RP/wU7Ld7ICsd4g
 vQcM+dxga3tE60XW0agiHfevfeC1AmqVtWPwYw9pJ757nmCCwZ8onCQkRYPnVz6oX8mEne0lf
 QTwPp3OdHpc8b1fTnzn+6rrVJUjsJ0GSsS++RCBBf8DUjPySBXcv/QWbyVhU6WJeHIJz7sQ4Q
 ZJqb5Pug02VzuDPc0l6NwR1Md3SRu7Ci+Xj5zlri6Jq4MRCznWDBSVO/dGHVt2Jb82zK7nPwc
 VYltriaARZr6MR+3dyHwJYPYjdfFA2

Hi,

Although I know it's triggered from btrfs, but the mnt_list handling is
out of btrfs' control, so I'm here asking for some help.

[BUG]
With CONFIG_DEBUG_LIST and CONFIG_BUG_ON_DATA_CORRUPTION, and an
upstream 6.13-rc kernel, which has commit 951a3f59d268 ("btrfs: fix
mount failure due to remount races"), I can hit the following crash,
with varied frequency (from 1/4 to hundreds runs no crash):

[  303.356328] BTRFS: device fsid 6fd8eb6f-1ea5-40aa-9857-05c64efe6d43
devid 1 transid 9 /dev/mapper/test-scratch1 (253:2) scanned by mount
(358060)
[  303.358614] BTRFS info (device dm-2): first mount of filesystem
6fd8eb6f-1ea5-40aa-9857-05c64efe6d43
[  303.359475] BTRFS info (device dm-2): using crc32c (crc32c-intel)
checksum algorithm
[  303.360134] BTRFS info (device dm-2): using free-space-tree
[  313.264317] list_del corruption, ffff8fd48a7b2c90->prev is NULL
[  313.264966] ------------[ cut here ]------------
[  313.265402] kernel BUG at lib/list_debug.c:54!
[  313.265847] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
[  313.266335] CPU: 4 UID: 0 PID: 370457 Comm: mount Kdump: loaded Not
tainted 6.13.0-rc4-custom+ #8
[  313.267252] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
Arch Linux 1.16.3-1-1 04/01/2014
[  313.268147] RIP: 0010:__list_del_entry_valid_or_report.cold+0x6d/0x6f
[  313.268777] Code: 05 77 a0 e8 4b 10 fd ff 0f 0b 48 89 fe 48 c7 c7 90
05 77 a0 e8 3a 10 fd ff 0f 0b 48 89 fe 48 c7 c7 60 05 77 a0 e8 29 10 fd
ff <0f> 0b 4c 89 ea be 01 00 00 00 4c 89 44 24 48 48 c7 c7 20 7c 2b a1
[  313.270493] RSP: 0018:ffffa7620d2b3a38 EFLAGS: 00010246
[  313.270960] RAX: 0000000000000033 RBX: ffff8fd48a7b2c00 RCX:
0000000000000000
[  313.271565] RDX: 0000000000000000 RSI: ffff8fd5f7c21900 RDI:
ffff8fd5f7c21900
[  313.272226] RBP: ffff8fd48a7b2c00 R08: 0000000000000000 R09:
0000000000000000
[  313.272895] R10: 74707572726f6320 R11: 6c65645f7473696c R12:
ffffa7620d2b3a58
[  313.273521] R13: ffff8fd48a7b2c00 R14: 0000000000000000 R15:
ffff8fd48a7b2c90
[  313.274138] FS:  00007f04740d4800(0000) GS:ffff8fd5f7c00000(0000)
knlGS:0000000000000000
[  313.274864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.275392] CR2: 00007f0473ff6000 CR3: 000000011a8eb000 CR4:
0000000000750ef0
[  313.276084] PKRU: 55555554
[  313.276327] Call Trace:
[  313.276551]  <TASK>
[  313.276752]  ? __die_body.cold+0x19/0x28
[  313.277102]  ? die+0x2e/0x50
[  313.277699]  ? do_trap+0xc6/0x110
[  313.278033]  ? do_error_trap+0x6a/0x90
[  313.278401]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
[  313.278941]  ? exc_invalid_op+0x50/0x60
[  313.279308]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
[  313.279850]  ? asm_exc_invalid_op+0x1a/0x20
[  313.280241]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
[  313.280777]  ? __list_del_entry_valid_or_report.cold+0x6d/0x6f
[  313.281285]  umount_tree+0xed/0x3c0
[  313.281589]  put_mnt_ns+0x51/0x90
[  313.281886]  mount_subtree+0x92/0x130
[  313.282205]  btrfs_get_tree+0x343/0x6b0 [btrfs]
[  313.282785]  vfs_get_tree+0x23/0xc0
[  313.283089]  vfs_cmd_create+0x59/0xd0
[  313.283406]  __do_sys_fsconfig+0x4eb/0x6b0
[  313.283764]  do_syscall_64+0x82/0x160
[  313.284085]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
[  313.284598]  ? __fs_parse+0x68/0x1b0
[  313.284929]  ? btrfs_parse_param+0x64/0x870 [btrfs]
[  313.285381]  ? vfs_parse_fs_param_source+0x20/0x90
[  313.285825]  ? __do_sys_fsconfig+0x1b8/0x6b0
[  313.286215]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
[  313.286719]  ? syscall_exit_to_user_mode+0x10/0x200
[  313.287151]  ? do_syscall_64+0x8e/0x160
[  313.287498]  ? vfs_fstatat+0x75/0xa0
[  313.287835]  ? __do_sys_newfstatat+0x56/0x90
[  313.288240]  ? syscall_exit_to_user_mode_prepare+0x15a/0x190
[  313.288749]  ? syscall_exit_to_user_mode+0x10/0x200
[  313.289188]  ? do_syscall_64+0x8e/0x160
[  313.289544]  ? do_syscall_64+0x8e/0x160
[  313.289892]  ? do_syscall_64+0x8e/0x160
[  313.290253]  ? syscall_exit_to_user_mode+0x10/0x200
[  313.290692]  ? do_syscall_64+0x8e/0x160
[  313.291034]  ? exc_page_fault+0x7e/0x180
[  313.291380]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  313.291845] RIP: 0033:0x7f04742a919e
[  313.292182] Code: 73 01 c3 48 8b 0d 72 3c 0f 00 f7 d8 64 89 01 48 83
c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 42 3c 0f 00 f7 d8 64 89 01 48
[  313.293830] RSP: 002b:00007ffc3df08df8 EFLAGS: 00000246 ORIG_RAX:
00000000000001af
[  313.294529] RAX: ffffffffffffffda RBX: 000056407e37aa00 RCX:
00007f04742a919e
[  313.295201] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
0000000000000003
[  313.295864] RBP: 00007ffc3df08f40 R08: 0000000000000000 R09:
0000000000000001
[  313.296602] R10: 0000000000000000 R11: 0000000000000246 R12:
00007f0474423b00
[  313.297416] R13: 0000000000000000 R14: 000056407e37cbe0 R15:
00007f0474418561
[  313.298242]  </TASK>
[  313.298832] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables binfmt_misc btrfs xor raid6_pq zstd_compress iTCO_wdt
intel_pmc_bxt iTCO_vendor_support i2c_i801 i2c_smbus virtio_net joydev
net_failover lpc_ich virtio_balloon failover loop dm_multipath nfnetlink
vsock_loopback vmw_vsock_virtio_transport_common vsock zram
crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
polyval_generic ghash_clmulni_intel virtio_console sha512_ssse3
sha256_ssse3 bochs sha1_ssse3 virtio_blk serio_raw scsi_dh_rdac
scsi_dh_emc scsi_dh_alua fuse qemu_fw_cfg
[  313.304504] Dumping ftrace buffer:
[  313.304876]    (ftrace buffer empty)

[EARLY ANALYZE]

The offending line is the list_move() call inside unmount_tree().

With crash core dump, the offending mnt_list is totally corrupted:

crash> struct list_head ffff8fd48a7b2c90
struct list_head {
   next =3D 0x1,
   prev =3D 0x0
}

umount_tree() should be protected by @mount_lock seqlock, and
@namespace_sem rwsem.

I also checked other mnt_list users:

- commit_tree()
- do_umount()
- copy_tree()

They all hold write @mount_lock at least.

The only caller doesn't hold @mount_lock is iterate_mounts() but that's
only called from audit, and I'm not sure if audit is even involved in
this case.

So I ran out of ideas why this mnt_list can even happen.

Even if it's some btrfs' abuse, all mnt_list users are properly
protected thus it should not lead to such list corruption.

Any advice would be appreciated.

Thanks,
Qu

