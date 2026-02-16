Return-Path: <linux-fsdevel+bounces-77296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BteHtQpk2kI2AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:29:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D08144ADC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B9C3062F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F03115B0;
	Mon, 16 Feb 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qr5KTnyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8F310625
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251936; cv=pass; b=OQg3f0uOiNy6OKVyO8c2I8D7jI7tlEQxXaFh7qqzPr2BTfaIBjsvhTJpX2gTgR8lER4XjGiwbj7KFZySr89ze9AtZWLApv7kOwNK5wF3sgjuG6YAXxGDWId2jEGOnQxnWiSCWv85wktIxtKiYvxwyDd2TX3Q/XANmQzWanXjdCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251936; c=relaxed/simple;
	bh=dUUjj507gFBKAA762cItZhvHTFLM1tVDOAutpHxzge8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+1RtXRiXK9kLEbqIRM0S7uaKN3yTKRIQLO4zA8cferFyY9bFBzMoNkRth7XffsPVsjzAqopAUIoXkQAwKyffRSNuTywbSj1Q+3nZIEsoGzU8a9WIaFXuSOYw1ahcnmQ/On581fNYAdNXjTxbM9pFsyc2K2z6IoCNC8odXaMsq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qr5KTnyG; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38707d4c8b9so31498781fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 06:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771251933; cv=none;
        d=google.com; s=arc-20240605;
        b=Bw/Sxa8qjeKK8Et5f81N8w7e0xwEHFyBAFrVsjX4igh2rZgQMqCWkVaCdxmewdzp9y
         9TC3I4wByyXUWeyDz+b722bOaXtox+rmfwmifUc7nxy5qkMXD2nDWMR3576BZmHYJwU9
         gE5dEUiw4ARxoaKep6rkQgz/1CD5CN6vOzHCHBPypY57vSXE9n/OQnamWr3UyF4S30rE
         O7v0I9F+Q6pOcPACwFCq3M/mynhgklGHk72mysSKxTZzWvB4ScOge1R4FnMOu20A4k2U
         W1K8xZHXzqaadJnQHHMZlbPppOAI2+0XYtFMCDztszH6sXOKEAbempmusTQAvsruEDdV
         3zXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H4HN4LV1jYlNdKdrU5JV5T502Hs2O5cmrKvKuJfSIVY=;
        fh=q1bzOU8qEorlb8W23lNf9Uv8j/H1jjld3VU3Rd7Pl+Q=;
        b=P8d01GmEbdpFU1zskkpdFCGTmTu5fUm1dPN9GSDYIWLgklB499PcP6Vw1MazQKl9AQ
         eabAeAlHHidxwciasfVufZtRQL0c82q4PmTu1rkmQbj+4YFpL5ipoJyda/R30/PTf1Bs
         zfibcV0ohUwVXz+asqqB8vNd514a5nR3g3eqNcP+0RzTRXWvMkwsG83/TJ6LwcBSql5j
         bHo0bp8tw806OCh7XncwwLOoyFYpC3sjqoCZfreoCRZ95ApwRXCqyTBsat6Y/v54gWxm
         UD/UQEwA9bfH7tEKi+0EBAhZlfkv9n0mMe3MJqM5oUPyTSioKkPIONGpZNF9e8xYmLBX
         mZDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771251933; x=1771856733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H4HN4LV1jYlNdKdrU5JV5T502Hs2O5cmrKvKuJfSIVY=;
        b=Qr5KTnyGSofRyZXwB16ip5eheljOe3at17ThP0pXBVmU8urq51eML9uGGW8x9uMfck
         N+a8+sdJcS/sMJ3ahby+7VKL0v3NYxOspdoyNfVY7BBlyMcUuwk/i5+jtEFrDomcg+83
         CCLuokPMdT2LNGmqeV1DGCwRQ4HkkFm9y7dCRnNTuXxtt3H19erGUBJU3s7mSSubMiyH
         Dac7GkS5GBsZmfxn14rnsP5M/TCDwgrMJTzzgCUEV9ZM6Lz32i+3p9M0rF+EbdJA2PpQ
         9mspCP8qYU1wvxReEeH87QvUl2i2vAsmzDIz2VyFpRComZJziUpRIEzt5J/FkxZTqTrd
         nB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251933; x=1771856733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4HN4LV1jYlNdKdrU5JV5T502Hs2O5cmrKvKuJfSIVY=;
        b=SWAWSkQxBFgZsOrKrZuHSWlrnU+yom7bNLUAXZEXRXCH+hUSkrN1do1LrfqVNz646X
         UHJD57PQQ1fFyPRFp2nUgt1o9vXDCdk97yT+7LaPgtq55oAkWHH8PGnqw6KiHI+1fkhL
         ChvS6WnE3UVC6IeYvby/44a81erLQ5Oyf5U7k+qcf0I7lUn34TiLrkBdzEFzFmih/sdI
         MHBnynhUDNYO1Rac4nfujcWeSTdo3i3+lasQOsJ58USXT+zJVvE7tHL4fNXjL/lUvskE
         c1D7ZT4/ss0irQi3NkNGLuoZV7HcHl22BWKOCcWSyX6m+5QRUzTHXpad/yC7dhOIuOGh
         qY1w==
X-Forwarded-Encrypted: i=1; AJvYcCXmGl57cmrtxO8oAPS5UI6QRZXqhfLevCUovOqr8E6Miiao3zlamzThzYS8pxHOWPKfd7YS7NsDvft4099i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/l6jqeBbFsFkeeum9Nd8cP4WGIa/p4I33Ka/Toavct3xh3tc
	gcetqpqpq9p5M68FyFv/gTWLut9j2s6ZC2tmJniCsZEHtB4ct1v+ziatAnEFhgIlGAO01H7fNey
	BFoiusXQkt9+fCPCd+btdkkXcsY/cEMREbhOEd3AT
X-Gm-Gg: AZuq6aKAgoUkRjkCTicSI/mK0Zy1GdydNWvIHu98sIB7hfhRRercYZTvfSNcWrjDLQT
	ldla7MS4J1yVEcttRLLjdlc5aEL4yCN8bJ9kjBwYpy/OtBKfg1uMZB9bSl0S9Mr1RExTjcrpP8V
	F1bUmC6P8AkLNpB80iaTEbeLZpfFqInzN4HLLZOHfesM8yA2OIb/VqSUz4SDlG+NcI0P5/okEO2
	IusZoE+O5JX+zr3YdUIJ2p7E8Z8JuPX6dETz+NeckqutFK6rEgdE3VtcRJ98x+r7aq75R+e5ZXi
	6w7m1gfrIZba9M4UOBTk70OYcoEPly81ygYfJg==
X-Received: by 2002:a2e:a991:0:b0:387:810:bb17 with SMTP id
 38308e7fff4ca-3881b8c19afmr20824831fa.10.1771251932436; Mon, 16 Feb 2026
 06:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69858d8b.050a0220.3b3015.0031.GAE@google.com> <87h5rue2vd.fsf@mail.parknet.co.jp>
In-Reply-To: <87h5rue2vd.fsf@mail.parknet.co.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Feb 2026 15:25:20 +0100
X-Gm-Features: AaiRm52qkj1LzPW3B3uBy2ALNx3ePy0knuiLVDCH5glcbTxWgf-D6KdDxqxX-dY
Message-ID: <CACT4Y+aZjVNH7ueY2nXfD8XMLnNpKkNuw8SA4qGNLgjPxgEcnQ@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] KCSAN: data-race in fat12_ent_put / fat_mirror_bhs
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: syzbot <syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com>, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77296-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,googlegroups.com:email,appspotmail.com:email,syzkaller.appspot.com:url,parknet.co.jp:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-fsdevel,51b4c65bb770155d058f];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: D0D08144ADC
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 at 08:40, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> syzbot <syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com> writes:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    de0674d9bc69 Merge tag 'for-6.19-rc8-tag' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15f240aa580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
> > dashboard link: https://syzkaller.appspot.com/bug?extid=51b4c65bb770155d058f
> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/bfedab2f6279/disk-de0674d9.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f012a4cb8d82/vmlinux-de0674d9.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/acb727c49110/bzImage-de0674d9.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com
>
> This looks like same with the following thread.
>
>   https://lore.kernel.org/all/20250902081727.7146-1-anmuxixixi@gmail.com/
>
> And this temporary inconsistency will be fixed until unmount, so it
> should be no corruption by this race. Let me know if corruption remained
> after unmount.

Thanks for the link. I don't have means to test that, but the
explanation in the thread you referenced looks reasonable. So let's
just keep an AI to properly annotate the race according to LKMM rules.


> > ==================================================================
> > BUG: KCSAN: data-race in fat12_ent_put / fat_mirror_bhs
> >
> > read-write to 0xffff888129151032 of 1 bytes by task 4937 on cpu 1:
> >  fat12_ent_put+0xc4/0x170 fs/fat/fatent.c:165
> >  fat_ent_write+0x6c/0xe0 fs/fat/fatent.c:417
> >  fat_chain_add+0x16c/0x490 fs/fat/misc.c:136
> >  fat_add_cluster fs/fat/inode.c:113 [inline]
> >  __fat_get_block fs/fat/inode.c:155 [inline]
> >  fat_get_block+0x46c/0x5e0 fs/fat/inode.c:190
> >  __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
> >  block_write_begin fs/buffer.c:2256 [inline]
> >  cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
> >  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
> >  generic_perform_write+0x183/0x490 mm/filemap.c:4314
> >  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
> >  generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
> >  new_sync_write fs/read_write.c:593 [inline]
> >  vfs_write+0x5a6/0x9f0 fs/read_write.c:686
> >  ksys_write+0xdc/0x1a0 fs/read_write.c:738
> >  __do_sys_write fs/read_write.c:749 [inline]
> >  __se_sys_write fs/read_write.c:746 [inline]
> >  __x64_sys_write+0x40/0x50 fs/read_write.c:746
> >  x64_sys_call+0x2847/0x3000 arch/x86/include/generated/asm/syscalls_64.h:2
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff888129151000 of 512 bytes by task 4940 on cpu 0:
> >  fat_mirror_bhs+0x1df/0x320 fs/fat/fatent.c:395
> >  fat_alloc_clusters+0xb48/0xc50 fs/fat/fatent.c:543
> >  fat_add_cluster fs/fat/inode.c:108 [inline]
> >  __fat_get_block fs/fat/inode.c:155 [inline]
> >  fat_get_block+0x258/0x5e0 fs/fat/inode.c:190
> >  __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
> >  block_write_begin fs/buffer.c:2256 [inline]
> >  cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
> >  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
> >  generic_perform_write+0x183/0x490 mm/filemap.c:4314
> >  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
> >  generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
> >  __kernel_write_iter+0x319/0x590 fs/read_write.c:619
> >  dump_emit_page fs/coredump.c:1298 [inline]
> >  dump_user_range+0xa7d/0xdb0 fs/coredump.c:1372
> >  elf_core_dump+0x21a2/0x2330 fs/binfmt_elf.c:2111
> >  coredump_write+0xacf/0xdf0 fs/coredump.c:1049
> >  do_coredump fs/coredump.c:1126 [inline]
> >  vfs_coredump+0x26bc/0x3120 fs/coredump.c:1200
> >  get_signal+0xd7b/0xf60 kernel/signal.c:3019
> >  arch_do_signal_or_restart+0x96/0x450 arch/x86/kernel/signal.c:337
> >  __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
> >  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
> >  irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
> >  irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
> >  irqentry_exit+0xf7/0x510 kernel/entry/common.c:196
> >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 UID: 0 PID: 4940 Comm: syz.3.398 Not tainted syzkaller #0 PREEMPT(voluntary)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > ==================================================================
> > syz.3.398 (4940) used greatest stack depth: 8696 bytes left
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

