Return-Path: <linux-fsdevel+bounces-76549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAhKAS6PhWkODgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:50:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C675FAC2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E091A302F42D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F42335577;
	Fri,  6 Feb 2026 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgMPwFS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC0313555
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360604; cv=pass; b=qpJDEPSuGyKnr7hE44sgz4U9S+Q4mZZxJcjorBJuH57fzDQPvl1NUA1LkgQHMLRAytdyqQEFbNWrU+V/ilMC8I95QVLEiyhmsvZQz8nG59jv+NHLiUkzZxM/rsUu97C24ncmN2Olv4RUIsXl0eDyoKElyO2tzVtnS01RrwBOTp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360604; c=relaxed/simple;
	bh=1aVglKH6qMbDO+KlufYySLXakkFAs2i9XR9mOVukRAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVx6Mf4rYwoT7sRATRqyWuVWO3aS+g1lwWjjsTleCmHTi8oCMp/s7NZo2YlakmccaH9rzPRo5aIsO5uB/NUz/RgBnTvKstV6SLlfiwPdhj+ZlodRY9FSeWUyvMflKs5QLvpXV+MckJxs24a1PrWF/emOWuYCVrxNzE4GNpcQGpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgMPwFS/; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59de6abf324so1330552e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 22:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770360601; cv=none;
        d=google.com; s=arc-20240605;
        b=YfP0CDnQXzNmJznAFnQEwbq1Z8FzAFAxYEaMqC5rSBCsW1nzlwipkhyOmLxMhNXK5U
         mrMBVvCj9g8ixY8zy8Gk7/ecfmBmmY7EK9t5bpj+xJE2J5v7rI60qgbW9js5CcFjQWrt
         e+mAcuMXAhaZtWnY8FmE2/cDRfGdwKUhBpNYLKpuRxG3Q2KRv7q/Idy9X+NpLpZunoAy
         1Od/jgtr6u6R9T1I7509mjLczhbH58H3i5i01w6M0Bx+n5JWYikW+LKfkqF1hAb3ZDWq
         yTfautSMcMZ48McJpMQMrsPfoh1MNuRFglMYz3EambKm7fCNbEFCLA9PlrXsl99AO7A2
         lXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W5belD2aFgWQUkZz7BxTgWTJ5yS1XiGJg0vQKb58kss=;
        fh=gAcLKl82f7xVtoO1eXv/bw4NaJcOx4osWqNWOvL4dpw=;
        b=jBEhZmTO0NqVRCwlYFymgD+o3ZZVnrrJw/EKpoJTBYIzi/+SlfAyeZtHyxLkBz8802
         +BRNLEstB1hyXRUpX1OFooWn/ZofDtL/pjztPJaEd9ZYhuH/PFkSRQPvsPwtkD3M4nuw
         GQg7X2nHu6Xf82MPgC1VZp2JauWH9pyF/jBwmP4u10iAIkkX5h4bHVqCLn0C5aFKuSF2
         DmleQbO9we25q3hNlySLO3zI81d/kkZ7XabNStVPkY7UKkWjmSggHbluhsgpH3K6l2ah
         CnvEMTMcRoBG1WBoKZ2nFj5WYHtwYkXheAsDehSTHwqgCKblvu/ARw9Q42rq7FfGTND2
         YyrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770360601; x=1770965401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W5belD2aFgWQUkZz7BxTgWTJ5yS1XiGJg0vQKb58kss=;
        b=AgMPwFS/0XpR7rzVr8tgtQ+UYB4XK2QLh6I+K9VwtCMEgG8lvRxEMdcOmf6sSkBhv3
         lswtvWmZUkwmOhGXKRQR8h5JiQbI0jfQORhxk20KMbZHZVbd1qM24km2s8RMpIDyOQKw
         vy+iktWdF25Wrhhj87yGgIxlyQWICet2w9pLrtqGEU9/VlKYv8TWoPwzrdNrwhEbtpBU
         RNkWbfWnGyNU96YxOpqhhXg7VIEeE2G3KCw7bweKq8pTUPw/G+s1Tpou/ThNAlIieLzt
         l87sDMiYkXqL7/JpLCtw+gXecbwKhi1GCw//3CYFk/vxPhLsZ2m8E4AsVGvAfWNNM2Xu
         VI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770360601; x=1770965401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5belD2aFgWQUkZz7BxTgWTJ5yS1XiGJg0vQKb58kss=;
        b=WXK48C4gI77jtUKELScuWKhfx3yvfDrJ63dx8pl/r0bCpneCHoQ0hw4xnvovOpGClt
         xl5jHakRJrwC2/gLh9pufXBaq6PdTuOsE99jOAgjh6cII3hCW/OUgSnz7+Thv+Tqjfzu
         5m6jS63XDAKvGZEGZv2bdzEVoILC8eaHMzJfDTW8ys2T5gaziQ/zpxJgKm/2q5MH6aG/
         NhDJGVrMAVJkk+qSTfh5Lbo3v5p2fMHuPzwgkVBXV9qDu21vtsUjDU1ivWhrvZExjNi6
         cP1/xJQvpjWXvS1D43P7ap1PWk9xq80SRMizJahvd8G1dLM6gO5aRz8UvtTUY7wFKk3S
         21JA==
X-Forwarded-Encrypted: i=1; AJvYcCVJYvkkZi2doEtQ5XQJWMcgtX02HQ1mo+GPlAosSPPJmF8fVl/k3KuDVyFqrVBbY1Gasw3mnKCWeSzqHEMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyBASGWEVOsWb7Nm3iku1dZFD8IQch0+/+pUcAXvJsPb5uczvoc
	/Ml2bQgjQOXdsgmwFgpz/MGLcMtkhuw3/7it9flcv2JFm4O3Ls2atlwd2hkCogwSGQ3NkVJ/J7I
	oVVUwmhfk/1uMLwDKVoDlefjt51SrzorDFq5BVoci
X-Gm-Gg: AZuq6aJZ5rjaO7LAVXs1glSvRp4vyByrK5A35fBKZtcx9XNdqZR/xVqVkIql+B4Q+4s
	oSt5wQJtW94WTo5KM5MfcHHhNxHDsYPp2+r7Cl79bBWODIH5f+KfNey1/iDVhN29SQo7SIatq+r
	4OqiG0ZEGDd56i8n25VKYV6+poD2xEXEYwz4CEl1fhJqdZngAl812ewp1BLi+HNZh9C6ApN9eFW
	7svQaGMBfjffeiQi2ncKvq5Y6CYs6SXLJ+Flk1FeBCXoBt6H952mL70IE/CMzs5fWOhJlUUJeqy
	bgMEC1CsTMizRxY7OAqWNppBONhM
X-Received: by 2002:a05:6512:3a8e:b0:59e:3652:c267 with SMTP id
 2adb3069b0e04-59e45170114mr439079e87.46.1770360601193; Thu, 05 Feb 2026
 22:50:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69858d8b.050a0220.3b3015.0031.GAE@google.com>
In-Reply-To: <69858d8b.050a0220.3b3015.0031.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Feb 2026 07:49:49 +0100
X-Gm-Features: AZwV_Qjv_hTeYfruFrr0EFkx8ynMjRCGU51kGTzRV0hNBfbBFIga0SWFo_gaeYE
Message-ID: <CACT4Y+Yg0+u6Xq2WTYKmuJj0eGnXw=iYo7yqTZhZWfWpvZJDCQ@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] KCSAN: data-race in fat12_ent_put / fat_mirror_bhs
To: syzbot <syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com>
Cc: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76549-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url,mail.gmail.com:mid];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,51b4c65bb770155d058f];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 4C675FAC2D
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 at 07:43, syzbot
<syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    de0674d9bc69 Merge tag 'for-6.19-rc8-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f240aa580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
> dashboard link: https://syzkaller.appspot.com/bug?extid=51b4c65bb770155d058f
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bfedab2f6279/disk-de0674d9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f012a4cb8d82/vmlinux-de0674d9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/acb727c49110/bzImage-de0674d9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+51b4c65bb770155d058f@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in fat12_ent_put / fat_mirror_bhs
>
> read-write to 0xffff888129151032 of 1 bytes by task 4937 on cpu 1:
>  fat12_ent_put+0xc4/0x170 fs/fat/fatent.c:165
>  fat_ent_write+0x6c/0xe0 fs/fat/fatent.c:417
>  fat_chain_add+0x16c/0x490 fs/fat/misc.c:136
>  fat_add_cluster fs/fat/inode.c:113 [inline]
>  __fat_get_block fs/fat/inode.c:155 [inline]
>  fat_get_block+0x46c/0x5e0 fs/fat/inode.c:190
>  __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
>  block_write_begin fs/buffer.c:2256 [inline]
>  cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
>  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
>  generic_perform_write+0x183/0x490 mm/filemap.c:4314
>  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
>  generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x5a6/0x9f0 fs/read_write.c:686
>  ksys_write+0xdc/0x1a0 fs/read_write.c:738
>  __do_sys_write fs/read_write.c:749 [inline]
>  __se_sys_write fs/read_write.c:746 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:746
>  x64_sys_call+0x2847/0x3000 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888129151000 of 512 bytes by task 4940 on cpu 0:
>  fat_mirror_bhs+0x1df/0x320 fs/fat/fatent.c:395
>  fat_alloc_clusters+0xb48/0xc50 fs/fat/fatent.c:543
>  fat_add_cluster fs/fat/inode.c:108 [inline]
>  __fat_get_block fs/fat/inode.c:155 [inline]
>  fat_get_block+0x258/0x5e0 fs/fat/inode.c:190
>  __block_write_begin_int+0x400/0xf90 fs/buffer.c:2145
>  block_write_begin fs/buffer.c:2256 [inline]
>  cont_write_begin+0x5fe/0x970 fs/buffer.c:2594
>  fat_write_begin+0x4f/0xe0 fs/fat/inode.c:230
>  generic_perform_write+0x183/0x490 mm/filemap.c:4314
>  __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4431
>  generic_file_write_iter+0x8d/0x310 mm/filemap.c:4457
>  __kernel_write_iter+0x319/0x590 fs/read_write.c:619
>  dump_emit_page fs/coredump.c:1298 [inline]
>  dump_user_range+0xa7d/0xdb0 fs/coredump.c:1372
>  elf_core_dump+0x21a2/0x2330 fs/binfmt_elf.c:2111
>  coredump_write+0xacf/0xdf0 fs/coredump.c:1049
>  do_coredump fs/coredump.c:1126 [inline]
>  vfs_coredump+0x26bc/0x3120 fs/coredump.c:1200
>  get_signal+0xd7b/0xf60 kernel/signal.c:3019
>  arch_do_signal_or_restart+0x96/0x450 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
>  irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
>  irqentry_exit+0xf7/0x510 kernel/entry/common.c:196
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 4940 Comm: syz.3.398 Not tainted syzkaller #0 PREEMPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> ==================================================================


FWIW this is how LLM explained why this race is harmful. It does not
look totally bogus to me.

=======

The data race occurs between `fat12_ent_put()` and `fat_mirror_bhs()`
in the FAT filesystem implementation.

### Analysis:
1.  **Task 1 (`fat12_ent_put`)**: This function is responsible for
updating a 12-bit FAT entry. Because FAT12 entries are 1.5 bytes long
and can span byte boundaries, updating an entry involves a
read-modify-write on two bytes. This is protected by the
`fat12_entry_lock` spinlock to ensure atomicity against other FAT12
entry updates. In the reported stack trace, it is called from
`fat_alloc_clusters()`, which also holds the `lock_fat` mutex.
2.  **Task 2 (`fat_mirror_bhs`)**: This function copies the "main" FAT
blocks (held in `buffer_head`s) to the backup FAT copies (mirrors) on
the disk. It uses `memcpy()` to copy the entire block data. In the
reported stack trace, it is called from `fat_alloc_clusters()`.
3.  **The Race**: In `fat_alloc_clusters()`, the `lock_fat` mutex is
released *before* calling `fat_mirror_bhs()`. This allows another task
(like Task 1) to acquire the `lock_fat` mutex and begin modifying the
same FAT block that Task 2 is currently mirroring. Since
`fat_mirror_bhs()` does not take the `fat12_entry_lock` spinlock, and
`memcpy()` is not atomic, Task 2 can read a FAT entry in a partially
updated (torn) state.
4.  **Impact**: If a torn FAT entry is copied to the mirror FAT and
subsequently written to disk, the filesystem metadata becomes
corrupted. In FAT12, a torn read can result in a cluster pointer that
is neither the old nor the new value, potentially pointing to a random
cluster. This leads to cross-linked files, lost data, or filesystem
inconsistency. While the main FAT might eventually be updated
correctly, there is a window where the mirror is corrupted on disk,
and if a crash occurs, the filesystem is left in an inconsistent
state. A similar race condition exists for `fat_sync_bhs()`, which
flushes the main FAT block to disk.

### Conclusion:
This data race is **harmful**. It involves concurrent access to shared
filesystem metadata without sufficient synchronization, leading to the
possibility of writing inconsistent/corrupted metadata to the disk.
Filesystem metadata integrity is critical, and torn writes are a
well-known source of serious filesystem corruption. The inconsistency
in locking between `fat_free_clusters()` (which holds the lock during
mirroring) and `fat_alloc_clusters()` (which does not) further
indicates that this is an unsafe oversight.

