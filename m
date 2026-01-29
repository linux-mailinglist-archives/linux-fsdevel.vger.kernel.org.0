Return-Path: <linux-fsdevel+bounces-75907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JhY1I3TVe2lBIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:47:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB6B50CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31777308298C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077C364E90;
	Thu, 29 Jan 2026 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrSMPSI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CB361DC8
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723022; cv=pass; b=T9okYStCftDWchhV81aWf/Vr+tRwb1OvHS5xI8T8C71m9FZHxpbU1bMStBqjecgRjBO9E3QeLwigjAq9pmsygP0WaJl8ffkBd17p3BAD7leHA7yiO6R23P0PJxHUpzhckxKJp3g0izlOJeUJnQPVZeJUDUhN1zqcSwuobgGuCwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723022; c=relaxed/simple;
	bh=y6XWMs1r4hckqtW7c34PktfaqJpQcexMz1w5IT3tDqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js8RiAgh+CxDFUngEU8YodWcoBA0uQleLUD8kuuwHm1mkLM0A/wSR4TdQk227Rbe+LZGCJ+arNuHeF1v8XYWV6aydUjGgiW3OHBzJJNQbgfVte5cDd1DvYESe58XIeiIAAiyC/UW5g+VnojK/jsh4GR0PkF7TOWqo2y+vT7usCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrSMPSI4; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c2f335681so732594a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769723020; cv=none;
        d=google.com; s=arc-20240605;
        b=MCWmMllWleozQ+UfB26TVnMRQa1ufSZIoMqMItTDTM7yNDfvaBx+Idv+24n+NjWbol
         a6b1OQodxMlQ7VHTojQbGdBeD8JB1+AOZkXQzH6e90JZOFTsyr00EFxtOkScyVZfcBkD
         aH3mUbcnb2A+c7QMlQ5DTibHT1qygmIcTbIYhJT7A/ZPj9wp1rEDEabe0Qww5CKaf5SQ
         WpvNOM8JPYNmSy77Zb43vkj7P96/Tq2jrxbHgpmlwqFvTO+G2KkiYCGUp8e+vsHfLDit
         IzhOjT6rC8u397v6OXXbg8lf6f6VOVrh6/dMqWc+UgB95EV2XbJdZwRCrB30BGy3eT9k
         qkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2gb09q6P8bpGuxTLEw0ruU1CQYj/z7WcdS0uDTFHvoE=;
        fh=k2VmCZWMhKy+hv5fdnaN8coA6iNwjWPzsmjrKJmMd9I=;
        b=O6nPf8PXktqLpkKr5Z+sNh/IU+kD9ojHbU2ZqDkOi3RCICFjZuW4u1Wgrnc9SKcwhe
         lOoRfQnKfviLvQYViAP2INS/36ICSDfPw5QuEVFUVW7KHgZ4wsc3nvwaArdawU1/EvU+
         BOPZiSCm+owAg7cMjT9Ewg6+VKODX/vOHsWw1801Sdj3Icn7FiE4Y88x+DfyirU54ZdT
         StJ8HwwJXiUHJlW+bfZgzc/ZjJENpxDXUGpLlhVeGxoCz7qaIkjZ8wK54K2EFca/iEQ3
         ZBGcmWWlsajxlYcZJBPZ/qWfGBYalAR5AkvXddsZoyui7UWNOgb7RRM11tqpwTDMTY0V
         HYtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723020; x=1770327820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gb09q6P8bpGuxTLEw0ruU1CQYj/z7WcdS0uDTFHvoE=;
        b=JrSMPSI461R85bFT2KI+LFzPwdq/To8hjSwqKTCh1l1gIE9hEp5I/t5yDJG644/NhB
         +LsDFhpkFqK/olTievuGaKPYc9f4AMmJaJWXrVmjiz5i6trMJRragtKgSyIiAzt4jNIV
         sNjMzfXh1sgWR56Sz6+8Xyw356wt7Z32ciOINb8XOzziaM0wcR6jGnG/rp9eWJyphO1k
         7pLIrlgNkV+HEk+8LZu/ePctSyZSVde8kzwMGXsGA9HSg1gmmi+BxaLMN7iSVXOxDUFn
         a0dB3K6m1aQK+sXPQdy0gD26x2UbGH6aBAYCx1CAvlLZMceYfoKBixg4k6E/Z55j9eWu
         awHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723020; x=1770327820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gb09q6P8bpGuxTLEw0ruU1CQYj/z7WcdS0uDTFHvoE=;
        b=fATJPRPiR9GdhojNUfm5tSLyRMgKFvKVlygZtfGYNrPfRrl4Bc0whAixN1GS/ymAtZ
         MF/A4UzEPGn6JNbaoiUvjlU5g2965PNw/47RR3ljFgfmWzssgYHpY8lT0h3IKMF263Jz
         CpzZ8LRgruIxXEzAc5TTYgruNdip6Qeo16fSX7wvmRf4eKlupqHDs6uQ4nfYXLEaPdNk
         oR8INPZ1TSOJUIr4D2vLa4rVy1OXJU6JfknTNNo8bokmcUvX/hg1LBi+jS415imziUhI
         ANrfVYjSb2/D/lOJOjDRhXDjwNtxtJddyjPmBhb914gDv22yVruEB1uzYW/8OhWgGh+F
         xxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmUj9qcjtuhO174AvRAfSab9BUlxOR0KqQZjfJbUb2LHN1wxPA49cMfP7qUi+hKl7UBuOKcZ4zWs+AvXTU@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRCA4hseeheg4ohIx8KfDnSzz6NzqhJN97oM4D1cd+NVfmPTM
	ZgWtKq8XldiFOx233qARC++6MQhc3oYGosCLTPNDw94QN3KCOXkH5GlNlNNRdsaZ6e35r6Yg53U
	hO9lgk5XAMiinJE1kdPi8I7iHPYAJgvA=
X-Gm-Gg: AZuq6aIwRW7j2ypmjnfORI+727GxrvvWLbi/Ss3dYTo5To9HaIp8dmIUYFq0F/X2S18
	+wC+U4FFJdDWATk4fXqKoDuR8dy5zwiIn5i6T0uT6ePFWbYdhPjV25W74/FRZb9gC4xo7dTqVkP
	ccnWSYzfwz7pYa3J+8W/8bte13xhM2QoIchGHRqqsu5AFM1mo2pQKx3kEqws+Xyr26nGzwtRtN9
	dGNn51Y0mniCZ4ogibr+ba91fHeODxqgj3vvqODZW5sKYtF5fmZGiNCA/V2y3Jk6pp1e1weFqUG
	x4xsCH0LzSiG1o8U/Wp9SQ==
X-Received: by 2002:a17:90b:28c5:b0:341:c964:125b with SMTP id
 98e67ed59e1d1-3543b3b0416mr615755a91.31.1769723020161; Thu, 29 Jan 2026
 13:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org> <CAJuCfpETSCvD8m+q5upFKb5pCf2P7ffMMJs8p-y=V9fjdh73GQ@mail.gmail.com>
In-Reply-To: <CAJuCfpETSCvD8m+q5upFKb5pCf2P7ffMMJs8p-y=V9fjdh73GQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Jan 2026 13:43:27 -0800
X-Gm-Features: AZwV_Qjmq-o4gruq32Jt_kJNZlusLMF_UzzkH3pmRCDmhIFboAuwX-4OB_1XhYo
Message-ID: <CAEf4BzazUY0deKN9HOWNbazuC3tnk0OgV_p-UzA1bDUqPKVq9g@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75907-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 07EB6B50CB
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 9:51=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 28, 2026 at 10:32=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_l=
ock or
> > per-VMA lock, whichever was used to lock VMA under question, to avoid d=
eadlock
> > reported by syzbot:
> >
> >  -> #1 (&mm->mmap_lock){++++}-{4:4}:
> >         __might_fault+0xed/0x170
> >         _copy_to_iter+0x118/0x1720
> >         copy_page_to_iter+0x12d/0x1e0
> >         filemap_read+0x720/0x10a0
> >         blkdev_read_iter+0x2b5/0x4e0
> >         vfs_read+0x7f4/0xae0
> >         ksys_read+0x12a/0x250
> >         do_syscall_64+0xcb/0xf80
> >         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >  -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> >         __lock_acquire+0x1509/0x26d0
> >         lock_acquire+0x185/0x340
> >         down_read+0x98/0x490
> >         blkdev_read_iter+0x2a7/0x4e0
> >         __kernel_read+0x39a/0xa90
> >         freader_fetch+0x1d5/0xa80
> >         __build_id_parse.isra.0+0xea/0x6a0
> >         do_procmap_query+0xd75/0x1050
> >         procfs_procmap_ioctl+0x7a/0xb0
> >         __x64_sys_ioctl+0x18e/0x210
> >         do_syscall_64+0xcb/0xf80
> >         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >  other info that might help us debug this:
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    rlock(&mm->mmap_lock);
> >                                 lock(&sb->s_type->i_mutex_key#8);
> >                                 lock(&mm->mmap_lock);
> >    rlock(&sb->s_type->i_mutex_key#8);
> >
> >   *** DEADLOCK ***
> >
> > To make this safe, we need to grab file refcount while VMA is still loc=
ked, but
> > other than that everything is pretty straightforward. Internal build_id=
_parse()
> > API assumes VMA is passed, but it only needs the underlying file refere=
nce, so
> > just add another variant build_id_parse_file() that expects file passed
> > directly.
> >
> > Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API f=
or /proc/<pid>/maps")
> > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> One nit below, otherwise LGTM.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> >  fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++---------------
> >  include/linux/buildid.h |  3 +++
> >  lib/buildid.c           | 34 +++++++++++++++++++++++++--------
> >  3 files changed, 56 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 480db575553e..dd3b5cf9f0b7 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, v=
oid __user *uarg)
> >         struct proc_maps_locking_ctx lock_ctx =3D { .mm =3D mm };
> >         struct procmap_query karg;
> >         struct vm_area_struct *vma;
> > +       struct file *vm_file =3D NULL;
> >         const char *name =3D NULL;
> >         char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
> >         __u64 usize;
> > @@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct *mm, =
void __user *uarg)
> >                 karg.inode =3D 0;
> >         }
> >
> > -       if (karg.build_id_size) {
> > -               __u32 build_id_sz;
> > -
> > -               err =3D build_id_parse(vma, build_id_buf, &build_id_sz)=
;
> > -               if (err) {
> > -                       karg.build_id_size =3D 0;
> > -               } else {
> > -                       if (karg.build_id_size < build_id_sz) {
> > -                               err =3D -ENAMETOOLONG;
> > -                               goto out;
> > -                       }
> > -                       karg.build_id_size =3D build_id_sz;
> > -               }
> > -       }
> > -
> >         if (karg.vma_name_size) {
> >                 size_t name_buf_sz =3D min_t(size_t, PATH_MAX, karg.vma=
_name_size);
> >                 const struct path *path;
> > @@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct *mm,=
 void __user *uarg)
> >                 karg.vma_name_size =3D name_sz;
> >         }
> >
> > +       if (karg.build_id_size && vma->vm_file)
> > +               vm_file =3D get_file(vma->vm_file);
> > +
> >         /* unlock vma or mmap_lock, and put mm_struct before copying da=
ta to user */
> >         query_vma_teardown(&lock_ctx);
> >         mmput(mm);
> >
> > +       if (karg.build_id_size) {
> > +               __u32 build_id_sz;
> > +
> > +               if (vm_file)
> > +                       err =3D build_id_parse_file(vm_file, build_id_b=
uf, &build_id_sz);
> > +               else
> > +                       err =3D -ENOENT;
>
> Before this change we returned EINVAL when vma->vm_file=3D=3DNULL, now we
> return ENOENT. Probably not critical but is there a reason for this
> change?
>

This error code is not returned to the caller. Even if build ID
parsing returns an error, all we do is `karg.build_id_size =3D 0;` and
proceed (successfully). So -ENOENT doesn't matter, but it felt like
"there is no file -> ENOENT" as the internal signal made more sense.
I'll keep it as is, I still think it makes sense.

> > +               if (err) {
> > +                       karg.build_id_size =3D 0;
> > +               } else {
> > +                       if (karg.build_id_size < build_id_sz) {
> > +                               err =3D -ENAMETOOLONG;
> > +                               goto out;
> > +                       }
> > +                       karg.build_id_size =3D build_id_sz;
> > +               }
> > +       }
> > +
> > +       if (vm_file)
> > +               fput(vm_file);
> > +
> >         if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma=
_name_addr),
> >                                                name, karg.vma_name_size=
)) {
> >                 kfree(name_buf);

[...]

