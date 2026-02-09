Return-Path: <linux-fsdevel+bounces-76716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBhzBXcSimlrGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 17:59:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FD112CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 17:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA2A930659D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BD385530;
	Mon,  9 Feb 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUrlY4fW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094B374162
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656183; cv=pass; b=PSBydHpciZgGIh+XuxagnJ/HPDVeAyiHxYND3VbSpu+uihLOkTyVsRp62+8jYOunbexxE5DJnxuXqS07M7wIUyasXIlrwDNzY8gcYn52lpLLVFYrDYRsBjof/5ZUKm1NnE5ffUDXsx467FzhwgE6P/5YBLi0o3F02bTG8IFOaKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656183; c=relaxed/simple;
	bh=7VLUPy/Lxm2q2ECyY2cKwiK3lsrHHNZHwH7Z2z8gn0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm3hN8t9Fhadu4UAwwqTp8DsngBLxDXKFBcbPHaeZxXlJdZkcxN1u14E7hgJngWKv6OU0vYdWY20LREJlCvJQQEf33ZXUNk864mVy86lD+kpnC91R/QmBIgAy/0mpF/prMpr0w+wq2eeV9o227a/gX8mq1PWiN+/giCIY7MM8QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUrlY4fW; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-897002b7576so13159716d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 08:56:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770656182; cv=none;
        d=google.com; s=arc-20240605;
        b=PzbdhMcW8sNBOowmZ7uDWj5rTI0s+mlffUZVwtSoPnPr2x2H7CnnU0ubFPZ1CjaB34
         cZa71XjG2GjctHuFhgkQd9HnOrq69hzQ5/7ctjlxuFPGmE2GnDsx1OjnKrJIEBF4IpRZ
         WH8LVkkAogFoHEDdIb4VZ0Z4+XhHKXNYbMw0phSE8CKqiZg0j7pnTPWFQCryvZ+qjmN7
         omfi+AXVLNfd4VZtiQjGYNSVnbV3lg36n8fVlnXS7OrCxQ4A4zW7hAvf3JIwwHYaCwvg
         bkZfC9M1kClXUdm9FCGEoVE4TVMhco6yGIiYY81ROAJc6OR1h6XzQQsjclpb2V3Jb1hy
         /XOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9gE/GnxbaquR/Jky0u1nc/LFQnx0zYTsDuMfOKy0HSo=;
        fh=buG3HReL5RNtEG8JIY+whQidCe1IuKdd50kR+o1co9I=;
        b=QkkA9QYYNUoGUCAuiDhScsoZApw+9j04+r8CwGU1tmNnf5raZzLX7aSEXkj6igSZlm
         qZjSQqDhwhZ6CPYyKqAl+r1dcPYvDzAU/nSw1DtbwDnSW6A0f9NibtCStRf6I1G3b+J8
         1vg2X5p2eHsE15J+sE0dnEk9kB8d6Bn3v+4CMSYUGYixVlqUxWd689BrTiRb42vTKIcd
         q7KATfnQJZTj25QVWcMgFrjFf8XXGfjqaVXRcDKEh7ffJaIloDRNm/OQDNNesiv8oMsy
         NZEtsrKPNLX06C2QhK3pHZ92w1wuNBBW44sAZ82iJFY+Iw3mmhmuA5ZgnRHZjs8v0J24
         dNnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770656182; x=1771260982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gE/GnxbaquR/Jky0u1nc/LFQnx0zYTsDuMfOKy0HSo=;
        b=OUrlY4fWXaTTWc1g5c3VV5Il1UfBWVIDzSUWMSNgB6qVpW8lTboWs5W4kFp1dCgqo2
         Eh3n5tLsmA/g9nXtPjW0/9cFV4K12osMhCc235M8/Wn8+2zm1YtL3ZbfvYTMZfmjEgIk
         ObmdGid5Tq2aHgu2dKCqDRIXDSFNE7P51SafTO2DEnKYOOVciUoPRigUKlCKcZZxEIoG
         5FsOsRKjFd8qZNVsGv8kQkvKHJbwozKFiiAHtdMUJVd6zyp5c7QKTPfyDK04yzQyOMj6
         HliO4O3OGlpihdb5YlXg8kHZUxIvBOvaBlB/YpyyB2qLRUt5TVqP9l9/AP1Z2vfYcUw6
         tRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770656182; x=1771260982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9gE/GnxbaquR/Jky0u1nc/LFQnx0zYTsDuMfOKy0HSo=;
        b=qEJPdW/wy7+54qiS/uZlsTURNRL/lZEwfzEJqo6BrR7VqhOdJcw1erGRSomtV3bKyS
         HmkcibJxVsOFDlJzHL2dweLY/5v1RgkzS7zQyD97VRp4TeHpByCcOar3gJRWewxACKt6
         IwyWOquclxuacjoB9cQxNXi5Y1emxaBLgOz+wAKO+eP7yinOrBby2te9Wqq+QD9XzEze
         +XESQ9yjRhXpDocFEtrsiVDS+OvRSmZ1+Rt/Nl5jr4xXQVpyKmeZjvXlrXBXCzXNV+Mm
         VEd2WKB2tka71APLNdjVqxstJ7xxKOTJEbWgeXR2A3fA1yD1fzOp5lkypRsqxHUWmqYM
         YrMw==
X-Forwarded-Encrypted: i=1; AJvYcCWxDlNIEk6Zi+G0hGW/rbFDIx4tnpUnybYwfGNoEm7DTc9cH3qKz5nVmlpdwcn9dSFkVhXWZSwGgLDhsxlm@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOQUyHGoVE38a9K0H99KK6PPF8bPQGV45UmZt1TKd+v13ktXy
	dV7htE6vB4PyfduXj4QVytm2XL1VZoCCyErKF0rtLMmGea3kNmmvhwBCZfO4cG1nj5zzg42Ypkn
	3uDKFiCviENbOVMJ/gd2ARZ78P1LYvDo=
X-Gm-Gg: AZuq6aJk3chQkDzosSxeMHtMKZumu7SU3uGcgSWmlsk15GuDK+paDSqj0Eq5jTobja3
	+PP8UlxJJjGlMFwIuloOWel3GJv/kXkXRdQ0I2jEh5aZWP6zpm0oAQZM1wECN1IDJ8G+6MBzzYr
	4WHuCPAh1+fBPeaMq+Z/CeMdGJ4hxn8ldZrWz/Fd1gt07IZ4QRsfd0AgFzqdXMptGOIpjjqSbwm
	3qPOG9v5/H7gvmUXxnzS6BKPQBYDqY+cadOpO6kaYACiVPNmYLXBqxIRDvWMbkKPLTQBMLgOx3s
	ExTQ
X-Received: by 2002:a05:622a:24f:b0:501:453e:bb34 with SMTP id
 d75a77b69052e-50639995bf6mr139450531cf.63.1770656182247; Mon, 09 Feb 2026
 08:56:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6989f0f2.a00a0220.34fa92.0047.GAE@google.com>
In-Reply-To: <6989f0f2.a00a0220.34fa92.0047.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Feb 2026 08:56:11 -0800
X-Gm-Features: AZwV_Qh99pe2lEvylN_7wH92Hz38dScLErHXd7OQR-VvW36k9zihYCjtVb-hPDQ
Message-ID: <CAJnrk1bfZH=rJm3_7=0_JHN810akMTJsYkDsVs_fd1CSjjm3QQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] possible deadlock in writeout_period
To: syzbot <syzbot+d38b792a5cbd941006fc@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8a8594efdc14f07a];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76716-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url,googlegroups.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d38b792a5cbd941006fc];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5F3FD112CB5
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 6:37=E2=80=AFAM syzbot
<syzbot+d38b792a5cbd941006fc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    59e4d31a0470 Merge branches 'for-next/core' and 'for-next=
/..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14454b2258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8a8594efdc14f=
07a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd38b792a5cbd941=
006fc
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/746a1d5c4188/dis=
k-59e4d31a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2eefade79f10/vmlinu=
x-59e4d31a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/140624ef24ed/I=
mage-59e4d31a.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d38b792a5cbd941006fc@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible irq lock inversion dependency detected
> syzkaller #0 Not tainted
> --------------------------------------------------------
> syz-executor/6572 just changed the state of lock:
> ffff800097626150 (&p->sequence){+.-.}-{0:0}, at: writeout_period+0x94/0x1=
1c mm/page-writeback.c:615
> but this lock was taken by another, HARDIRQ-safe lock in the past:
>  (&xa->xa_lock#10){-.-.}-{3:3}
>
>
> and interrupts could create inverse lock ordering between them.
>
>
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&p->sequence);
>                                local_irq_disable();
>                                lock(&xa->xa_lock#10);
>                                lock(&p->sequence);
>   <Interrupt>
>     lock(&xa->xa_lock#10);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor/6572:
>  #0: ffff800097bd7c40 ((&dom->period_timer)){+.-.}-{0:0}, at: lockdep_cop=
y_map include/linux/lockdep.h:41 [inline]
>  #0: ffff800097bd7c40 ((&dom->period_timer)){+.-.}-{0:0}, at: call_timer_=
fn+0xd4/0x814 kernel/time/timer.c:1738
>
> the shortest dependencies between 2nd lock and 1st lock:
>  -> (&xa->xa_lock#10){-.-.}-{3:3} {
>     IN-HARDIRQ-W at:
>                       lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5=
868
>                       __raw_spin_lock_irqsave include/linux/spinlock_api_=
smp.h:110 [inline]
>                       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spi=
nlock.c:162
>                       __folio_end_writeback+0x10c/0x6f8 mm/page-writeback=
.c:2990
>                       folio_end_writeback_no_dropbehind+0xd0/0x204 mm/fil=
emap.c:1661
>                       folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
>                       end_buffer_async_write+0x20c/0x350 fs/buffer.c:419
>                       end_bio_bh_io_sync+0xb0/0x184 fs/buffer.c:2776
>                       bio_endio+0x8d4/0x910 block/bio.c:1675
>                       blk_complete_request block/blk-mq.c:908 [inline]
>                       blk_mq_end_request_batch+0x49c/0x105c block/blk-mq.=
c:1202
>                       nvme_complete_batch drivers/nvme/host/nvme.h:802 [i=
nline]
>                       nvme_pci_complete_batch drivers/nvme/host/pci.c:134=
8 [inline]
>                       nvme_irq+0x1ec/0x240 drivers/nvme/host/pci.c:1450
>                       __handle_irq_event_percpu+0x20c/0x8e4 kernel/irq/ha=
ndle.c:211
>                       handle_irq_event_percpu kernel/irq/handle.c:248 [in=
line]
>                       handle_irq_event+0x9c/0x1d0 kernel/irq/handle.c:265
>                       handle_fasteoi_irq+0x328/0x8d8 kernel/irq/chip.c:76=
4
>                       generic_handle_irq_desc include/linux/irqdesc.h:172=
 [inline]
>                       handle_irq_desc kernel/irq/irqdesc.c:669 [inline]
>                       generic_handle_domain_irq+0xe0/0x140 kernel/irq/irq=
desc.c:725
>                       __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [=
inline]
>                       __gic_handle_irq_from_irqson drivers/irqchip/irq-gi=
c-v3.c:876 [inline]
>                       gic_handle_irq+0x6c/0x18c drivers/irqchip/irq-gic-v=
3.c:920
>                       call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry=
.S:891
>                       do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/e=
ntry-common.c:135
>                       __el1_irq arch/arm64/kernel/entry-common.c:497 [inl=
ine]
>                       el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-com=
mon.c:510
>                       el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/ent=
ry-common.c:515
>                       el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>                       __daif_local_irq_restore arch/arm64/include/asm/irq=
flags.h:175 [inline]
>                       arch_local_irq_restore arch/arm64/include/asm/irqfl=
ags.h:195 [inline]
>                       kasan_quarantine_put+0xbc/0x1c8 mm/kasan/quarantine=
.c:234
>                       __kasan_slab_free+0x8c/0xa4 mm/kasan/common.c:295
>                       kasan_slab_free include/linux/kasan.h:235 [inline]
>                       slab_free_hook mm/slub.c:2540 [inline]
>                       slab_free_after_rcu_debug+0x120/0x2f8 mm/slub.c:672=
9
>                       rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>                       rcu_core+0x848/0x1774 kernel/rcu/tree.c:2857
>                       rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2874
>                       handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
>                       run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
>                       smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
>                       kthread+0x5fc/0x75c kernel/kthread.c:463
>                       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:8=
44
>     IN-SOFTIRQ-W at:
>                       lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5=
868
>                       __raw_spin_lock_irqsave include/linux/spinlock_api_=
smp.h:110 [inline]
>                       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spi=
nlock.c:162
>                       __folio_end_writeback+0x10c/0x6f8 mm/page-writeback=
.c:2990
>                       folio_end_writeback_no_dropbehind+0xd0/0x204 mm/fil=
emap.c:1661
>                       folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
>                       end_buffer_async_write+0x20c/0x350 fs/buffer.c:419
>                       end_bio_bh_io_sync+0xb0/0x184 fs/buffer.c:2776
>                       bio_endio+0x8d4/0x910 block/bio.c:1675
>                       blk_complete_request block/blk-mq.c:908 [inline]
>                       blk_mq_end_request_batch+0x49c/0x105c block/blk-mq.=
c:1202
>                       nvme_complete_batch drivers/nvme/host/nvme.h:802 [i=
nline]
>                       nvme_pci_complete_batch drivers/nvme/host/pci.c:134=
8 [inline]
>                       nvme_irq+0x1ec/0x240 drivers/nvme/host/pci.c:1450
>                       __handle_irq_event_percpu+0x20c/0x8e4 kernel/irq/ha=
ndle.c:211
>                       handle_irq_event_percpu kernel/irq/handle.c:248 [in=
line]
>                       handle_irq_event+0x9c/0x1d0 kernel/irq/handle.c:265
>                       handle_fasteoi_irq+0x328/0x8d8 kernel/irq/chip.c:76=
4
>                       generic_handle_irq_desc include/linux/irqdesc.h:172=
 [inline]
>                       handle_irq_desc kernel/irq/irqdesc.c:669 [inline]
>                       generic_handle_domain_irq+0xe0/0x140 kernel/irq/irq=
desc.c:725
>                       __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [=
inline]
>                       __gic_handle_irq_from_irqson drivers/irqchip/irq-gi=
c-v3.c:876 [inline]
>                       gic_handle_irq+0x6c/0x18c drivers/irqchip/irq-gic-v=
3.c:920
>                       call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry=
.S:891
>                       do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/e=
ntry-common.c:135
>                       __el1_irq arch/arm64/kernel/entry-common.c:497 [inl=
ine]
>                       el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-com=
mon.c:510
>                       el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/ent=
ry-common.c:515
>                       el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>                       __daif_local_irq_restore arch/arm64/include/asm/irq=
flags.h:175 [inline]
>                       arch_local_irq_restore arch/arm64/include/asm/irqfl=
ags.h:195 [inline]
>                       kasan_quarantine_put+0xbc/0x1c8 mm/kasan/quarantine=
.c:234
>                       __kasan_slab_free+0x8c/0xa4 mm/kasan/common.c:295
>                       kasan_slab_free include/linux/kasan.h:235 [inline]
>                       slab_free_hook mm/slub.c:2540 [inline]
>                       slab_free_after_rcu_debug+0x120/0x2f8 mm/slub.c:672=
9
>                       rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>                       rcu_core+0x848/0x1774 kernel/rcu/tree.c:2857
>                       rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2874
>                       handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
>                       run_ksoftirqd+0x70/0xc0 kernel/softirq.c:1063
>                       smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
>                       kthread+0x5fc/0x75c kernel/kthread.c:463
>                       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:8=
44
>     INITIAL USE at:
>                      lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:58=
68
>                      __raw_spin_lock_irq include/linux/spinlock_api_smp.h=
:119 [inline]
>                      _raw_spin_lock_irq+0x58/0x70 kernel/locking/spinlock=
.c:170
>                      spin_lock_irq include/linux/spinlock.h:376 [inline]
>                      shmem_add_to_page_cache+0x564/0xa24 mm/shmem.c:904
>                      shmem_alloc_and_add_folio+0x758/0x10c4 mm/shmem.c:19=
58
>                      shmem_get_folio_gfp+0x4d4/0x159c mm/shmem.c:2556
>                      shmem_read_folio_gfp+0x8c/0xf0 mm/shmem.c:5970
>                      drm_gem_get_pages+0x1cc/0x7c0 drivers/gpu/drm/drm_ge=
m.c:654
>                      drm_gem_shmem_get_pages_locked+0x1d4/0x364 drivers/g=
pu/drm/drm_gem_shmem_helper.c:240
>                      drm_gem_shmem_pin_locked+0x1f8/0x410 drivers/gpu/drm=
/drm_gem_shmem_helper.c:301
>                      drm_gem_shmem_vmap_locked+0x3cc/0x658 drivers/gpu/dr=
m/drm_gem_shmem_helper.c:405
>                      drm_gem_shmem_object_vmap+0x28/0x38 include/drm/drm_=
gem_shmem_helper.h:245
>                      drm_gem_vmap_locked drivers/gpu/drm/drm_gem.c:1273 [=
inline]
>                      drm_gem_vmap+0x104/0x1d8 drivers/gpu/drm/drm_gem.c:1=
315
>                      drm_client_buffer_vmap+0x68/0xb0 drivers/gpu/drm/drm=
_client.c:355
>                      drm_fbdev_shmem_driver_fbdev_probe+0x1f4/0x700 drive=
rs/gpu/drm/drm_fbdev_shmem.c:159
>                      drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb=
_helper.c:1562 [inline]
>                      __drm_fb_helper_initial_config_and_unlock+0x108c/0x1=
728 drivers/gpu/drm/drm_fb_helper.c:1741
>                      drm_fb_helper_initial_config+0x3c/0x58 drivers/gpu/d=
rm/drm_fb_helper.c:1828
>                      drm_fbdev_client_hotplug+0x154/0x22c drivers/gpu/drm=
/clients/drm_fbdev_client.c:66
>                      drm_client_register+0x13c/0x1d4 drivers/gpu/drm/drm_=
client.c:143
>                      drm_fbdev_client_setup+0x194/0x3d0 drivers/gpu/drm/c=
lients/drm_fbdev_client.c:168
>                      drm_client_setup+0x114/0x228 drivers/gpu/drm/clients=
/drm_client_setup.c:46
>                      vkms_create+0x370/0x420 drivers/gpu/drm/vkms/vkms_dr=
v.c:211
>                      vkms_init+0x64/0x9c drivers/gpu/drm/vkms/vkms_drv.c:=
239
>                      do_one_initcall+0x248/0x9b4 init/main.c:1378
>                      do_initcall_level+0x128/0x1c4 init/main.c:1440
>                      do_initcalls+0x70/0xd0 init/main.c:1456
>                      do_basic_setup+0x78/0x8c init/main.c:1475
>                      kernel_init_freeable+0x268/0x39c init/main.c:1688
>                      kernel_init+0x24/0x1dc init/main.c:1578
>                      ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:84=
4
>   }
>   ... key      at: [<ffff80009764a620>] xa_init_flags.__key+0x0/0x20
>   ... acquired at:
>    seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
>    fprop_fraction_percpu+0xf0/0x270 lib/flex_proportions.c:155
>    __fprop_add_percpu_max+0x130/0x1f4 lib/flex_proportions.c:186
>    wb_domain_writeout_add mm/page-writeback.c:562 [inline]
>    __wb_writeout_add+0xbc/0x27c mm/page-writeback.c:586
>    __folio_end_writeback+0x380/0x6f8 mm/page-writeback.c:2997
>    folio_end_writeback_no_dropbehind+0xd0/0x204 mm/filemap.c:1661
>    folio_end_writeback+0xd8/0x248 mm/filemap.c:1687
>    iomap_finish_folio_write+0x1c0/0x2a4 fs/iomap/buffered-io.c:1713
>    fuse_writepage_finish fs/fuse/file.c:1903 [inline]
>    fuse_writepage_end+0x238/0x454 fs/fuse/file.c:2003
>    fuse_request_end+0x898/0xc10 fs/fuse/dev.c:507
>    fuse_dev_end_requests fs/fuse/dev.c:2415 [inline]
>    fuse_abort_conn+0xe88/0x10a0 fs/fuse/dev.c:2513
>    fuse_dev_release+0x430/0x4c8 fs/fuse/dev.c:2556
>    __fput+0x340/0x75c fs/file_table.c:468
>    fput_close_sync+0x100/0x264 fs/file_table.c:573
>    __do_sys_close fs/open.c:1573 [inline]
>    __se_sys_close fs/open.c:1558 [inline]
>    __arm64_sys_close+0x7c/0x118 fs/open.c:1558
>    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>    invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
>    el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
>    do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>    el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
>    el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
>    el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
>
> -> (&p->sequence){+.-.}-{0:0} {
>    HARDIRQ-ON-W at:
>                     lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:586=
8
>                     do_write_seqcount_begin_nested include/linux/seqlock.=
h:477 [inline]
>                     do_write_seqcount_begin include/linux/seqlock.h:503 [=
inline]
>                     fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:7=
4
>                     writeout_period+0x94/0x11c mm/page-writeback.c:615
>                     call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
>                     expire_timers kernel/time/timer.c:1799 [inline]
>                     __run_timers kernel/time/timer.c:2373 [inline]
>                     __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
>                     run_timer_base kernel/time/timer.c:2394 [inline]
>                     run_timer_softirq+0x11c/0x194 kernel/time/timer.c:240=
5
>                     handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
>                     __do_softirq+0x14/0x20 kernel/softirq.c:656
>                     ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
>                     call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S=
:891
>                     do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.=
c:73
>                     invoke_softirq kernel/softirq.c:503 [inline]
>                     __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
>                     irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
>                     __el1_irq arch/arm64/kernel/entry-common.c:498 [inlin=
e]
>                     el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-commo=
n.c:510
>                     el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry=
-common.c:515
>                     el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>                     __daif_local_irq_enable arch/arm64/include/asm/irqfla=
gs.h:26 [inline]
>                     arch_local_irq_enable arch/arm64/include/asm/irqflags=
.h:48 [inline]
>                     preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7=
189
>                     raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry=
/common.c:173
>                     irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
>                     exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry=
-common.c:58
>                     __el1_irq arch/arm64/kernel/entry-common.c:500 [inlin=
e]
>                     el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-commo=
n.c:510
>                     el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry=
-common.c:515
>                     el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>                     __daif_local_irq_restore arch/arm64/include/asm/irqfl=
ags.h:175 [inline]
>                     arch_local_irq_restore arch/arm64/include/asm/irqflag=
s.h:195 [inline]
>                     class_irqsave_destructor include/linux/irqflags.h:266=
 [inline]
>                     __free_object+0x514/0x720 lib/debugobjects.c:524
>                     free_object lib/debugobjects.c:532 [inline]
>                     debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
>                     destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [i=
nline]
>                     hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2=
178
>                     common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:13=
52
>                     __do_sys_clock_nanosleep kernel/time/posix-timers.c:1=
398 [inline]
>                     __se_sys_clock_nanosleep kernel/time/posix-timers.c:1=
375 [inline]
>                     __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/p=
osix-timers.c:1375
>                     __invoke_syscall arch/arm64/kernel/syscall.c:35 [inli=
ne]
>                     invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c=
:49
>                     el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c=
:132
>                     do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>                     el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:7=
24
>                     el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/ent=
ry-common.c:743
>                     el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:59=
6
>    IN-SOFTIRQ-W at:
>                     lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:586=
8
>                     do_write_seqcount_begin_nested include/linux/seqlock.=
h:477 [inline]
>                     do_write_seqcount_begin include/linux/seqlock.h:503 [=
inline]
>                     fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:7=
4
>                     writeout_period+0x94/0x11c mm/page-writeback.c:615
>                     call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
>                     expire_timers kernel/time/timer.c:1799 [inline]
>                     __run_timers kernel/time/timer.c:2373 [inline]
>                     __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
>                     run_timer_base kernel/time/timer.c:2394 [inline]
>                     run_timer_softirq+0x11c/0x194 kernel/time/timer.c:240=
5
>                     handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
>                     __do_softirq+0x14/0x20 kernel/softirq.c:656
>                     ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
>                     call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S=
:891
>                     do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.=
c:73
>                     invoke_softirq kernel/softirq.c:503 [inline]
>                     __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
>                     irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
>                     __el1_irq arch/arm64/kernel/entry-common.c:498 [inlin=
e]
>                     el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-commo=
n.c:510
>                     el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry=
-common.c:515
>                     el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>                     __daif_local_irq_enable arch/arm64/include/asm/irqfla=
gs.h:26 [inline]
>                     arch_local_irq_enable arch/arm64/include/asm/irqflags=
.h:48 [inline]
>                     preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7=
189
>                     raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry=
/common.c:173
>                     irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
>                     exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry=
-common.c:58
>                     __el1_irq arch/arm64/kernel/entry-common.c:500 [inlin=
e]
>                     el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-commo=
n.c:510
>                     el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry=
-common.c:515
>                     el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>                     __daif_local_irq_restore arch/arm64/include/asm/irqfl=
ags.h:175 [inline]
>                     arch_local_irq_restore arch/arm64/include/asm/irqflag=
s.h:195 [inline]
>                     class_irqsave_destructor include/linux/irqflags.h:266=
 [inline]
>                     __free_object+0x514/0x720 lib/debugobjects.c:524
>                     free_object lib/debugobjects.c:532 [inline]
>                     debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
>                     destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [i=
nline]
>                     hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2=
178
>                     common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:13=
52
>                     __do_sys_clock_nanosleep kernel/time/posix-timers.c:1=
398 [inline]
>                     __se_sys_clock_nanosleep kernel/time/posix-timers.c:1=
375 [inline]
>                     __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/p=
osix-timers.c:1375
>                     __invoke_syscall arch/arm64/kernel/syscall.c:35 [inli=
ne]
>                     invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c=
:49
>                     el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c=
:132
>                     do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>                     el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:7=
24
>                     el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/ent=
ry-common.c:743
>                     el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:59=
6
>    INITIAL READ USE at:
>                         lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c=
:5868
>                         seqcount_lockdep_reader_access include/linux/seql=
ock.h:72 [inline]
>                         fprop_fraction_percpu+0xac/0x270 lib/flex_proport=
ions.c:155
>                         __wb_calc_thresh+0xfc/0x3b0 mm/page-writeback.c:9=
13
>                         wb_bg_dirty_limits mm/page-writeback.c:2130 [inli=
ne]
>                         domain_over_bg_thresh+0xb8/0x1f0 mm/page-writebac=
k.c:2144
>                         wb_over_bg_thresh+0xf8/0x17c mm/page-writeback.c:=
2165
>                         wb_check_background_flush fs/fs-writeback.c:2278 =
[inline]
>                         wb_do_writeback fs/fs-writeback.c:2376 [inline]
>                         wb_workfn+0xa30/0xdc0 fs/fs-writeback.c:2403
>                         process_one_work+0x7c0/0x1558 kernel/workqueue.c:=
3257
>                         process_scheduled_works kernel/workqueue.c:3340 [=
inline]
>                         worker_thread+0x958/0xed8 kernel/workqueue.c:3421
>                         kthread+0x5fc/0x75c kernel/kthread.c:463
>                         ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S=
:844
>  }
>  ... key      at: [<ffff800097b9a340>] fprop_global_init.__key.1+0x0/0x20
>  ... acquired at:
>    mark_lock+0x170/0x1d0 kernel/locking/lockdep.c:4753
>    mark_usage kernel/locking/lockdep.c:4662 [inline]
>    __lock_acquire+0x9a0/0x30a4 kernel/locking/lockdep.c:5191
>    lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
>    do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
>    do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
>    fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
>    writeout_period+0x94/0x11c mm/page-writeback.c:615
>    call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
>    expire_timers kernel/time/timer.c:1799 [inline]
>    __run_timers kernel/time/timer.c:2373 [inline]
>    __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
>    run_timer_base kernel/time/timer.c:2394 [inline]
>    run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
>    handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
>    __do_softirq+0x14/0x20 kernel/softirq.c:656
>    ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
>    call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
>    do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
>    invoke_softirq kernel/softirq.c:503 [inline]
>    __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
>    irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
>    __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
>    el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
>    el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
>    el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>    __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
>    arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
>    preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7189
>    raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry/common.c:173
>    irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
>    exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry-common.c:58
>    __el1_irq arch/arm64/kernel/entry-common.c:500 [inline]
>    el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-common.c:510
>    el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
>    el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>    __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline=
]
>    arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
>    class_irqsave_destructor include/linux/irqflags.h:266 [inline]
>    __free_object+0x514/0x720 lib/debugobjects.c:524
>    free_object lib/debugobjects.c:532 [inline]
>    debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
>    destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [inline]
>    hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2178
>    common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:1352
>    __do_sys_clock_nanosleep kernel/time/posix-timers.c:1398 [inline]
>    __se_sys_clock_nanosleep kernel/time/posix-timers.c:1375 [inline]
>    __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/posix-timers.c:137=
5
>    __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>    invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
>    el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
>    do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>    el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
>    el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
>    el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
>
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 6572 Comm: syz-executor Not tainted syzkaller #0 PREEM=
PT
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/03/2025
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
>  __dump_stack+0x30/0x40 lib/dump_stack.c:94
>  dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
>  dump_stack+0x1c/0x28 lib/dump_stack.c:129
>  print_irq_inversion_bug+0x1f8/0x1fc kernel/locking/lockdep.c:4125
>  mark_lock_irq+0x3b4/0x47c kernel/locking/lockdep.c:-1
>  mark_lock+0x170/0x1d0 kernel/locking/lockdep.c:4753
>  mark_usage kernel/locking/lockdep.c:4662 [inline]
>  __lock_acquire+0x9a0/0x30a4 kernel/locking/lockdep.c:5191
>  lock_acquire+0x140/0x2e0 kernel/locking/lockdep.c:5868
>  do_write_seqcount_begin_nested include/linux/seqlock.h:477 [inline]
>  do_write_seqcount_begin include/linux/seqlock.h:503 [inline]
>  fprop_new_period+0x3b8/0x718 lib/flex_proportions.c:74
>  writeout_period+0x94/0x11c mm/page-writeback.c:615
>  call_timer_fn+0x19c/0x814 kernel/time/timer.c:1748
>  expire_timers kernel/time/timer.c:1799 [inline]
>  __run_timers kernel/time/timer.c:2373 [inline]
>  __run_timer_base+0x51c/0x76c kernel/time/timer.c:2385
>  run_timer_base kernel/time/timer.c:2394 [inline]
>  run_timer_softirq+0x11c/0x194 kernel/time/timer.c:2405
>  handle_softirqs+0x31c/0xc88 kernel/softirq.c:622
>  __do_softirq+0x14/0x20 kernel/softirq.c:656
>  ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
>  call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
>  do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
>  invoke_softirq kernel/softirq.c:503 [inline]
>  __irq_exit_rcu+0x1b0/0x478 kernel/softirq.c:723
>  irq_exit_rcu+0x14/0x84 kernel/softirq.c:739
>  __el1_irq arch/arm64/kernel/entry-common.c:498 [inline]
>  el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:510
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
>  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P=
)
>  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
>  preempt_schedule_irq+0x78/0x188 kernel/sched/core.c:7189 (P)
>  raw_irqentry_exit_cond_resched+0x30/0x44 kernel/entry/common.c:173
>  irqentry_exit+0x1b0/0x308 kernel/entry/common.c:216
>  exit_to_kernel_mode+0x10/0x1c arch/arm64/kernel/entry-common.c:58
>  __el1_irq arch/arm64/kernel/entry-common.c:500 [inline]
>  el1_interrupt+0x4c/0x60 arch/arm64/kernel/entry-common.c:510
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:515
>  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:592
>  __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] =
(P)
>  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P=
)
>  class_irqsave_destructor include/linux/irqflags.h:266 [inline] (P)
>  __free_object+0x514/0x720 lib/debugobjects.c:524 (P)
>  free_object lib/debugobjects.c:532 [inline]
>  debug_object_free+0x298/0x3e4 lib/debugobjects.c:976
>  destroy_hrtimer_on_stack kernel/time/hrtimer.c:448 [inline]
>  hrtimer_nanosleep+0x214/0x2a4 kernel/time/hrtimer.c:2178
>  common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:1352
>  __do_sys_clock_nanosleep kernel/time/posix-timers.c:1398 [inline]
>  __se_sys_clock_nanosleep kernel/time/posix-timers.c:1375 [inline]
>  __arm64_sys_clock_nanosleep+0x334/0x370 kernel/time/posix-timers.c:1375
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
>  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
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

#syz fix: flex_proportions: make fprop_new_period() hardirq safe

This was fixed by Jan a few weeks ago (commit dd9e2f5b38f1f in the
linux-next tree) [1]. I think Jan's fix just hasn't been
pulled into the arm64 tree yet [2].

Thanks,
Joanne

[1] https://lore.kernel.org/all/20260121112729.24463-2-jack@suse.cz/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?qt=
=3Dauthor&q=3DJan+Kara

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

