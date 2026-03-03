Return-Path: <linux-fsdevel+bounces-79289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPzSMoBip2lvhAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:36:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6165F1F80CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DE083043965
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68936370D69;
	Tue,  3 Mar 2026 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaJgAHuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B781A683D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577406; cv=pass; b=C3O8qZcPzI9fmGC3GL1z6rij1PHIqxsFUMN8Wm1479pc1U70QapJmIv09hMfWh+qCD5xO2ZqnZ3RPWUFOvC72GWQbBY3qLUsixwwXN9loTnWn0K09JBR3GuMe3NmC1YVk5uPg4IEmG1Oh/kaNsxwh4F8jr6N53NEQygDDUncVNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577406; c=relaxed/simple;
	bh=BVRwGA81gb3UoPcGsUY5FR/2nsdij3rIdtt8sHNLKqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TL73+DbABYIXGqEqtu4iWxbIKKciEnRJpYzxDxcqiK7r9ixOkquL21WH82XIJKup1gszS1CsxakIdhgKhxx3TgaULkAbifQQ7PMAYLPru0+LC+nchhRW6hlJ5aigtKrtN2HmaTdPrju+PWXEWU2YdpZ/k7BN9jLk+Ow8yfCqMzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaJgAHuS; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3825b0fbso594921385a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 14:36:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772577403; cv=none;
        d=google.com; s=arc-20240605;
        b=cPz465VlzNNvDDHBKRPybokbzJp4GxaaRMld9mEtL62YwUCv0m6ZIydy8s5cUxz4aY
         DtCJ7bP2q7GaJ/xZv0QkxdN0UJbyOXsZG71eehIpdIuCmFpiEdZYdmv6g/Gph4gzoWRO
         JvmyOtIed4VFZXvgd0zIYzPAJweGJHgibZwUn6+kxB0bJhAFgmlDWjf3ajnb8YLe25cw
         57RsSUTJ+/RgLBp1H2CXTH6QPc6FODaucsRevBjAZeWlseM06JRazr1diMzFxHnzK7lo
         WG/WW2PjbqYY6OpY+S23mGGAl4/UtjhjzJX6cSaN+p/sstI7kq7jjJPiwn/OoMv5O8wp
         IxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u+Pa29acVeqCQJ3H6qeAie4BTk9oEkEbqKMULR9kLzQ=;
        fh=YI9OZujKO0g/HUXvBseTMemFL3Kghbz2oDB5r+MTTe0=;
        b=AiMEZ9uxj9j5itKdZzS7H7K8jvmbXmaPngPU6OiqZbJEqEtctTa1NOvyMQKIPxYbV+
         nJPeKJMYaXoEmiqlKLKjxWII5u4LTu698O86+X/unsBhZot8H8rHoVqzvivyVIISfp6p
         Fx1ktTheWMsC/+CeuvoTEBv6NygV4vcfhGHwggmvxjXikYanwpaTefRbxsBUtyhw81S5
         qZmyiMncxrOkWRSCY/dI47IyO0AyIKnefIjJeKcgKXJBIEN7iK/QDUVMEc2eNCucnQ4L
         1HkF1XCimNeRA+kkRP2giWoh5N79Rug2//qZFmX9W5ljV36QlhKh+XqAAunuqcSggh3i
         Rq4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772577403; x=1773182203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+Pa29acVeqCQJ3H6qeAie4BTk9oEkEbqKMULR9kLzQ=;
        b=HaJgAHuS9r23YR5uGJKHYws7z0i3DHXd2n9dRWEcjtYlaUyoQ2aeRdjrpoMFPnVbW+
         Ls6Wef0VcmFyvz4ZkcEMqEtKMBGKo3bFV7svtb7bLljP5abVXjDsTSCM5dwf+akByYvE
         aiQYNyby+hoQkHkUHug604jaFKbAf8o3D+tjrmhIeEUUOw6ltsMPIlpwnb/YT8iVVpwN
         Ydxiq2fm7xeutgr4vk1qe0+fAFRwHp4JkklT2orWqUFNi+2ASdPWnPH1NFxHlB7K1WD1
         10wh3A0Mb+MAuDLI8SElbH3KG4mXXGXkNutMZqSkPockvXlRPmTXQo5BiruuvPMI0b/4
         yuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577403; x=1773182203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u+Pa29acVeqCQJ3H6qeAie4BTk9oEkEbqKMULR9kLzQ=;
        b=TSLcSL4BBXYVyswfGcfgxISBd0rC45RWu8URrPLCgk4mUzLX351t6vxeqrn8t8ero2
         3SeGF6xYISo9vDn+pSgkltJ0ZVswToAzdqTgHzE6HdQisoDQu39kIoWWlTFpvtigkKMS
         TU1jiMjxlUSrvMGrNPpY9o6JZWjWviCJnRTkeqwwTl631Hl8hm5JYubK8tl5rI9uqWq3
         n51y27i6q70wHyogjFgGSyDvhcB4QZj0V2QdxzI6hLRdTyN+BUaNYXcOMTLj2gq9JaXq
         299VQdUMJvhr458nqGbmxqxNxGVnNEENvTezzLskquWtldwwgm5VZcPlGFiMIb65QHtT
         jPlg==
X-Gm-Message-State: AOJu0Yz7IDNYvIh7rpeFJ+5FWQKYgvEVxIvGBJH9HUc6rlKJomuuX04S
	s5dqD/GkjcCfh201lNQXueCUhr8naIbKwTAzECBgJdJ6nU6RByw6zgJnO3RuKdXxBCWMv7m5MPK
	AWh0rqzXg7cZ9DjNQq3jCwNt6OI8MStk=
X-Gm-Gg: ATEYQzx9RDEm34cUUofpyU5CDsdWa5DETv6XnJ4+qZcp5bbO2byZph9X5SZkBinTO4j
	RLDG7S5Vc0mcrj0ugi0yGvKFo7EAHwLP7jOGM0GRMjkBzlrqGxG/hjXpvkQdHxrceMczLPc1B0n
	H9Imhvmrq12+/dNlw6PkHti54Zpl+r6B1iu2pfG+G0Dz0hDBkUEWSrnyVa0gMI7Ls5/dnmpPAqP
	h/Jfkooon3SGcM8i4gvOjMKhpYsO3El8UA/SiCaKuo3DZ2fkflyecKl6lFdwnqR7mIqVyHbjK/Q
	3qzy6A==
X-Received: by 2002:a05:620a:25cf:b0:8c6:a034:9224 with SMTP id
 af79cd13be357-8cd5af77931mr2696985a.47.1772577403429; Tue, 03 Mar 2026
 14:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69a75f9b.a70a0220.b118c.0013.GAE@google.com>
In-Reply-To: <69a75f9b.a70a0220.b118c.0013.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Mar 2026 14:36:32 -0800
X-Gm-Features: AaiRm53OkZqqbLCp78jAQe6CJYI69EKrsDcCYw4Sx3OgFsrKEdsX6fv9A7xb6mo
Message-ID: <CAJnrk1YQMZBHE+EhhDbxM9nAzCeBDkpr-w4128fSXVPNj03aPg@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] KASAN: use-after-free Write in fuse_copy_do
To: syzbot <syzbot+23299dfcac137a96834a@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6165F1F80CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=54b410fabe2a4318];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79289-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,goo.gl:url,appspotmail.com:email,syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email,storage.googleapis.com:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-fsdevel,23299dfcac137a96834a];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 2:24=E2=80=AFPM syzbot
<syzbot+23299dfcac137a96834a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c025f6cf4209 Add linux-next specific files for 20260303
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D135770ba58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D54b410fabe2a4=
318
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D23299dfcac137a9=
6834a
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1671b006580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1166bb5a58000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e2497bde352d/dis=
k-c025f6cf.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/36827cb45429/vmlinu=
x-c025f6cf.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7ebf1ed6bb73/b=
zImage-c025f6cf.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+23299dfcac137a96834a@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in fuse_copy_do+0x193/0x380 fs/fuse/dev.c:-1
> Write of size 2 at addr ffff888070528fff by task syz.0.17/6005
>
> CPU: 0 UID: 0 PID: 6005 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/12/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xba/0x230 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
>  __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
>  fuse_copy_do+0x193/0x380 fs/fuse/dev.c:-1
>  fuse_copy_folio+0xefc/0x1b00 fs/fuse/dev.c:1166
>  fuse_notify_store fs/fuse/dev.c:1821 [inline]

I think this is a fallout from the misordered lines detected in
https://lore.kernel.org/all/202603031522.e4lroM3J-lkp@intel.com/T/#u

>  fuse_notify fs/fuse/dev.c:2109 [inline]
>  fuse_dev_do_write+0x2b9d/0x4060 fs/fuse/dev.c:2205
>  fuse_dev_write+0x177/0x220 fs/fuse/dev.c:2289
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x61d/0xb90 fs/read_write.c:688
>  ksys_write+0x150/0x270 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe8c659c799
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe8c7476028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fe8c6815fa0 RCX: 00007fe8c659c799
> RDX: 000000000000002a RSI: 0000200000000080 RDI: 0000000000000003
> RBP: 00007fe8c6632bd9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fe8c6816038 R14: 00007fe8c6815fa0 R15: 00007ffd95eaba38
>  </TASK>
>
> The buggy address belongs to the physical page:
> page: refcount:3 mapcount:0 mapping:ffff88805c1c4f20 index:0x7 pfn:0x7052=
8
> memcg:ffff88802ce3a880
> aops:empty_aops ino:1 dentry name(?):"/"
> flags: 0xfff00000000005(locked|referenced|node=3D0|zone=3D1|lastcpupid=3D=
0x7ff)
> raw: 00fff00000000005 0000000000000000 dead000000000122 ffff88805c1c4f20
> raw: 0000000000000007 0000000000000000 00000003ffffffff ffff88802ce3a880
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(G=
FP_HIGHUSER_MOVABLE|__GFP_COMP), pid 6005, tgid 6004 (syz.0.17), ts 1039482=
79019, free_ts 103868818778
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x231/0x280 mm/page_alloc.c:1892
>  prep_new_page mm/page_alloc.c:1900 [inline]
>  get_page_from_freelist+0x23a1/0x2440 mm/page_alloc.c:3965
>  __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5253
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
>  alloc_frozen_pages_noprof mm/mempolicy.c:2555 [inline]
>  alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2575
>  folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2585
>  filemap_alloc_folio_noprof+0x111/0x470 mm/filemap.c:1013
>  __filemap_get_folio_mpol+0x3fc/0xb00 mm/filemap.c:2011
>  __filemap_get_folio include/linux/pagemap.h:774 [inline]
>  filemap_grab_folio include/linux/pagemap.h:854 [inline]
>  fuse_notify_store fs/fuse/dev.c:1813 [inline]
>  fuse_notify fs/fuse/dev.c:2109 [inline]
>  fuse_dev_do_write+0x298b/0x4060 fs/fuse/dev.c:2205
>  fuse_dev_write+0x177/0x220 fs/fuse/dev.c:2289
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x61d/0xb90 fs/read_write.c:688
>  ksys_write+0x150/0x270 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 6002 tgid 6002 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  __free_pages_prepare mm/page_alloc.c:1436 [inline]
>  free_unref_folios+0xd71/0x1530 mm/page_alloc.c:3043
>  folios_put_refs+0x9ff/0xb40 mm/swap.c:1008
>  free_pages_and_swap_cache+0x2e7/0x5b0 mm/swap_state.c:401
>  __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
>  tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
>  tlb_flush_mmu+0x6d3/0xa30 mm/mmu_gather.c:424
>  tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:549
>  exit_mmap+0x498/0xa10 mm/mmap.c:1315
>  __mmput+0x118/0x430 kernel/fork.c:1179
>  exit_mm+0x18e/0x250 kernel/exit.c:581
>  do_exit+0x8b9/0x2580 kernel/exit.c:962
>  do_group_exit+0x21b/0x2d0 kernel/exit.c:1116
>  __do_sys_exit_group kernel/exit.c:1127 [inline]
>  __se_sys_exit_group kernel/exit.c:1125 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1125
>  x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888070528f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888070528f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888070529000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff888070529080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff888070529100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index da2e0f348890..2c16b94357d5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1815,8 +1815,8 @@ static int fuse_notify_store(struct fuse_conn
*fc, unsigned int size,
                if (IS_ERR(folio))
                        goto out_iput;

-               nr_bytes =3D min(num, folio_size(folio) - folio_offset);
                folio_offset =3D offset_in_folio(folio, pos);
+               nr_bytes =3D min(num, folio_size(folio) - folio_offset);

                err =3D fuse_copy_folio(cs, &folio, folio_offset, nr_bytes,=
 0);
                if (!folio_test_uptodate(folio) && !err && folio_offset =3D=
=3D 0 &&

>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

