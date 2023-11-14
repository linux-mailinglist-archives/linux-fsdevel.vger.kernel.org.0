Return-Path: <linux-fsdevel+bounces-2856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B007EB807
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B6928137F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 20:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337C82FC25;
	Tue, 14 Nov 2023 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQWf97iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019412C197
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 20:57:48 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D7FB;
	Tue, 14 Nov 2023 12:57:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc3bb4c307so47831195ad.0;
        Tue, 14 Nov 2023 12:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699995467; x=1700600267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByB20yb9wGiRXez/eSin8PX+umJYL4MbxZSfdpoiwcU=;
        b=bQWf97iCN3CQWq87biu6RSOz1Ip4t2+4krq/qPe3qBadiWiv4RsQiJxCNlPjwbaPQq
         qfKFLcLQ9VPKlZAR3fCcqXgBclX696NQBc+7SsbvbEW5azGpZxg5T5ZX/o8x0uzp9GVW
         h39my/kZ5WMo7b81mVN5qGHM4+MdunENNd0dR48ja1UW3PoHlsU+n9pHvJFuMkYW7tUX
         ltcv3MO7VE/6hK6UB7rRO9ubWOXJMwK7oIN3VjVg1JKSMLqT26FyuWNaPlLgnZjujCoR
         edbUoMBYNkeAIX8wIwSpKCV3Ji4yyt9c2kCip9kwY8QfmyvhJoocfFQIZz0zxtk7GwKi
         pFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699995467; x=1700600267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByB20yb9wGiRXez/eSin8PX+umJYL4MbxZSfdpoiwcU=;
        b=jU21n2G2SOc20jRVBjhI4s9J0dxfd0t2jTknacbDSWOZCWhjPRi9+3QR22JNk4m/B/
         z6Krx88BB5dNw5I4X3UY4pfzR49NgNEb8zDI2sVQ+EG9a1HlH7QWLOVtnN3zVZdD3dix
         XGRgtct7O1bkub9oheenkNxqGxu4u3thtrbnATFv2gDGKGyb7zsPO6CU/sK+aoDnOiYv
         1/CuXn924SgmD4kZD1vY3oVg6Etc+eUvbJtRZfthBIShrGo/Q6narpFD2sU1ssedkzSK
         NVnFWr7kwjm+aqZapfbboHuDbMPOjtm7yMGS6brNLaR8kQkmja9+7XzG/+Y43S/1D7Lj
         wsmw==
X-Gm-Message-State: AOJu0YxVL4/47OxFlrIwH98pgXkqvgLzzQhbT6U1ZkzuNoZBlGwJ+r41
	qU70V3HOorB9fekMZqNy3ETqfQ6ZG8/yovZYa3xvQ03bePo=
X-Google-Smtp-Source: AGHT+IGOzRDvH/ZidTAAKoTB2ZuRrBAWpo1zLdeQgI0TVdnwUZC5sv4irL6ta/IIK7SA7wg7RqmRDzwSVxUXdDmoD5o=
X-Received: by 2002:a17:90b:4c85:b0:27d:8fbd:be8c with SMTP id
 my5-20020a17090b4c8500b0027d8fbdbe8cmr9698901pjb.28.1699995466759; Tue, 14
 Nov 2023 12:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
In-Reply-To: <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Nov 2023 15:57:35 -0500
Message-ID: <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > [
> > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > lock_rename()-related followups in another branch, so a pull would be m=
ore
> > convenient for me than cherry-pick.  NOTE: testing and comments would
> > be very welcome - as it is, the patch is pretty much untested beyond
> > "it builds".
> > ]
>
> Hi Al,
>
> I will admit to glossing over the comment above when I merged this
> into the selinux/dev branch last night.  As it's been a few weeks, I'm
> not sure if the comment above still applies, but if it does let me
> know and I can yank/revert the patch in favor of a larger pull.  Let
> me know what you'd like to do.

Seeing this during testsuite runs:

[ 3550.206423] SELinux:  Converting 1152 SID table entries...
[ 3550.666195] ------------[ cut here ]------------
[ 3550.666201] WARNING: CPU: 3 PID: 12300 at fs/inode.c:330 drop_nlink+0x57=
/0x70
[ 3550.666214] Modules linked in: tun af_key crypto_user
scsi_transport_iscsi xt_multiport ip_gre gre ip_tunnel bluetooth
ecdh_generic sctp ip6_udp_tunnel udp_tunnel overlay xt_CONNSECMARK
xt_SECMARK ah6 ah4 vfat fat xt_CHECKSUM xt_MASQUERADE xt_conntrack
ipt_REJECT nf_nat_tftp nf_conntrack_tftp nft_fib_inet bridge
nft_fib_ipv4 nft_fib_ipv6 nft_fib stp llc nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat rfkill
ip6table_nat ip6table_mangle ip6table_raw ip6table_security
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_mangle iptable_raw iptable_security ip_set nf_tables nfnetlink
ip6table_filter iptable_filter vsock_loopback
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
intel_rapl_msr intel_rapl_common isst_if_mbox_msr isst_if_common
vmw_balloon rapl joydev vmw_vmci i2c_piix4 auth_rpcgss loop sunrpc
zram xfs vmwgfx drm_ttm_helper ttm crct10dif_pclmul drm_kms_helper
crc32_pclmul crc32c_intel ghash_clmulni_intel drm vmw_pvscsi vmxnet3
ata_generic
[ 3550.666453]  pata_acpi serio_raw ip6_tables ip_tables
pkcs8_key_parser fuse [last unloaded: setest_module_request(OE)]
[ 3550.666476] CPU: 3 PID: 12300 Comm: load_policy Tainted: G    B
 OE      6.7.0-rc1+ #68
[ 3550.666488] RIP: 0010:drop_nlink+0x57/0x70
[ 3550.666495] Code: 7b 28 e8 9c ab f4 ff 48 8b 5b 28 be 08 00 00 00
48 8d bb 40 07 00 00 e8 c7 be f4 ff f0 48 ff 83 40 07 00 00 5b c3 cc
cc cc cc <0f> 0b c7 43 48 ff ff ff ff 5b c3 cc cc cc cc 66 2e 0f 1f 84
00 00
[ 3550.666502] RSP: 0018:ffff88816efefb78 EFLAGS: 00010246
[ 3550.666508] RAX: 0000000000000000 RBX: ffff8881007e7a48 RCX: dffffc00000=
00000
[ 3550.666513] RDX: 0000000000000003 RSI: ffffffff9a6f30b6 RDI: ffff8881007=
e7a90
[ 3550.666518] RBP: ffff88816efefbf0 R08: 0000000000000000 R09: 00000000000=
00000
[ 3550.666523] R10: ffffffff9d8952e7 R11: 0000000000000000 R12: 00000000655=
3dd4c
[ 3550.666527] R13: ffff8881007e7a48 R14: ffff8881d014a8c8 R15: ffff888319e=
42e68
[ 3550.666533] FS:  00007fa567f7fc40(0000) GS:ffff888dfed80000(0000)
knlGS:0000000000000000
[ 3550.666538] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3550.666542] CR2: 00007f48f4049024 CR3: 00000001f8174003 CR4: 00000000007=
706f0
[ 3550.666569] PKRU: 55555554
[ 3550.666573] Call Trace:
[ 3550.666576]  <TASK>
[ 3550.666580]  ? __warn+0xa5/0x200
[ 3550.666590]  ? drop_nlink+0x57/0x70
[ 3550.666598]  ? report_bug+0x1b2/0x1e0
[ 3550.666612]  ? handle_bug+0x79/0xa0
[ 3550.666621]  ? exc_invalid_op+0x17/0x40
[ 3550.666629]  ? asm_exc_invalid_op+0x1a/0x20
[ 3550.666643]  ? drop_nlink+0x16/0x70
[ 3550.666651]  ? drop_nlink+0x57/0x70
[ 3550.666659]  ? drop_nlink+0x16/0x70
[ 3550.666666]  simple_recursive_removal+0x405/0x430
[ 3550.666683]  sel_write_load+0x668/0xf30
[ 3550.666727]  ? __pfx_sel_write_load+0x10/0x10
[ 3550.666735]  ? __call_rcu_common.constprop.0+0x30b/0x980
[ 3550.666747]  ? __might_sleep+0x2b/0xb0
[ 3550.666756]  ? __pfx_lock_acquire+0x10/0x10
[ 3550.666764]  ? inode_security+0x6d/0x90
[ 3550.666775]  ? selinux_file_permission+0x1e4/0x220
[ 3550.666787]  vfs_write+0x18f/0x700
[ 3550.666799]  ? __pfx_vfs_write+0x10/0x10
[ 3550.666809]  ? do_sys_openat2+0xcb/0x110
[ 3550.666817]  ? __pfx_do_sys_openat2+0x10/0x10
[ 3550.666827]  ? __fget_light+0xdf/0x100
[ 3550.666838]  ksys_write+0xb7/0x140
[ 3550.666847]  ? __pfx_ksys_write+0x10/0x10
[ 3550.666856]  ? lockdep_hardirqs_on_prepare+0x12/0x200
[ 3550.666864]  ? syscall_enter_from_user_mode+0x24/0x80
[ 3550.666875]  do_syscall_64+0x43/0xf0
[ 3550.666882]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[ 3550.666889] RIP: 0033:0x7fa56811c154
[ 3550.666920] Code: 89 02 48 c7 c0 ff ff ff ff eb bd 66 2e 0f 1f 84
00 00 00 00 00 90 f3 0f 1e fa 80 3d 8d b4 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20
48 89
[ 3550.666926] RSP: 002b:00007fffe6bdf948 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 3550.666933] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fa5681=
1c154
[ 3550.666938] RDX: 000000000038f3d2 RSI: 00007fa55a400000 RDI: 00000000000=
00004
[ 3550.666942] RBP: 00007fffe6be0980 R08: 0000000000000073 R09: 00000000000=
00001
[ 3550.666947] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa55a4=
00000
[ 3550.666951] R13: 000000000038f3d2 R14: 0000000000000003 R15: 00007fa5682=
230a0
[ 3550.666965]  </TASK>
[ 3550.666969] irq event stamp: 0
[ 3550.666972] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 3550.666982] hardirqs last disabled at (0): [<ffffffff9a15878c>]
copy_process+0x114c/0x3580
[ 3550.666990] softirqs last  enabled at (0): [<ffffffff9a15878c>]
copy_process+0x114c/0x3580
[ 3550.666997] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 3550.667007] ---[ end trace 0000000000000000 ]---

