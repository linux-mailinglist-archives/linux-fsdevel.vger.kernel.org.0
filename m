Return-Path: <linux-fsdevel+bounces-75910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COAKK9bVe2klIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:49:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BE5B510C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9672B301487C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E1364EBE;
	Thu, 29 Jan 2026 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAsMQtFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945D361DBB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723341; cv=pass; b=nY9paTYnzpeoHDfHcg6hLB50D4QBQmdPoYdS60AWboKTSaMN0zZ3zWcvjyPRd5quJSWOxwivia3YY+sYvI2a/IF37iIU83QDoDmcyJ+CDz5Lrj+4XyprhVD0cTxMRnvu+rDEHejryDsaZL1IfJvhBS34d7hpSrd0h1c3rXDZBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723341; c=relaxed/simple;
	bh=J3z1OJ5N8wkaoonfU031DzjD8V4gRpQkebv/CwLhKr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVu/MM4dozz+f+4u6gxHl+5KSrEeoUZl599Em+mCYH9y0ngasSqtUWwkIOrkVsZAjVi3xvNMQ6d+h+/h1LwiQE03/FEsO78Zu0oyFeMDDtN14JYBMV3crDY5z0DFUhJ1+Lhigjui2Ci3pVvPi3rYx0WDKUyON+Y8QKsNa+ciZVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAsMQtFY; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso870224b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769723340; cv=none;
        d=google.com; s=arc-20240605;
        b=gPzQdndKbQ//JigWxWJyULWCpftbFo08+Xw9wksrL5gPyzKvM8bCSFSo0srT5v12CB
         nRXSI88XfaFZ/t4KLcWCIcEgpgsS7ORVaNpnplCzQBdzAH6T4K3eceqXzqumuJX9utHe
         5lx66zaeuNg0Ws45LxMAMJ9/olPxxpWqd2Y0FSwds3kTJeBk1f0Ex1JOjqiWVZeVkHlS
         vjpNCbQPXNYwIR6btcnAI8lHKv2WocixRA+MRMg3JThID9a9jCXtnRDV1KEqEdk+FX3H
         AlOnuwmMcpfcWkDKLeZcUYB7cSy6r6fSk68216NtUEtaCEfNoJOQ51gXZ+iXVBdrYcAE
         0Ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=httfifXiFd5uWoo/mGZ7s9cURALbGmXfpP+U9cGf6QY=;
        fh=xl08CUdh8prvA1q2bqUnG5jeLbqYocmcqHmhfYHQ74k=;
        b=NMJp+JhEtoYZr2GbNn9xVJ0NpT84Lx0VsuUcYkw/6XzCxQbVdOlCee2avlAHTW8Rhs
         t0osu8QVey7h9tictNrsBDV6EQ0IjM+FOGwWveoJ92dbt/6AI5fh4AUqnAEx4z6sjO9T
         HudoY9z2yAvEu+77R2TXYAivPBkdPjPJeWROyJ4aGYWbLk2z4FQhguXOsiqjw3wihwcc
         vmAU+WlZH5zowwYiRC7ux1LX2RvEFyp9bAexrDf1h0twDrNGYQWTk9uM1FqfQaOGM0cn
         aaMomUQhyqtsTQgUU6UeoB363Pmh3dU7V8N2++Go8ki7eKg6o3SYvhCsu6izPIQ+i9sT
         P/IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723340; x=1770328140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=httfifXiFd5uWoo/mGZ7s9cURALbGmXfpP+U9cGf6QY=;
        b=IAsMQtFYqnW49cu/IIgfqNGFPeMdAhN8Fmwu0SQ59+UIdW/3XOPKu6H/dZPcIfu/2I
         5QJssLIT85jZxBNJEcaLztSVaFBt9v2X/llImvXJfWyM6+WWkFrpIBlBk+/LVp2OhC2A
         KvQ+MCv0QwEQnnh2a2INtBHv7sAQTz+24JhDbnuNSuK1o+dXFWguOMrpqP6SNEQ3WDhs
         nAqanHKVmXvlb39cQMHEGl3UFzppWwrN5c3J/rVA22CkMZKXbw7QY2YfYqWGJ9ATtpPL
         FGosyL5MqK02lxAOv9YLgji4r9hJhy9f7eOFrr7M1TFWtAuTclQBneVL4+eVwAwdCT8h
         D85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723340; x=1770328140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=httfifXiFd5uWoo/mGZ7s9cURALbGmXfpP+U9cGf6QY=;
        b=Nn6IwxBhGI/mrqR0BJ0poSJUNj0Lt3eB+BHybnK3mMImSljuCkZiXrdDM6xNbuI7q/
         krrcCtQqrg69WeR3CNlJ19TnXRLqpytU85TDozCb5wwTYPxTNmnHdd+TKz2VtBQwGaap
         L+j6xI0+a5UqMUJ5+s8u62Q6FOE0ij6XNSLm7M3FnboTaMootXasXqRUtqm7d+jviqxI
         cMIjPAvtq4D8px9B57d6mju6cBRPxq1p9pC7T4VcjeXxA2g7POfOP2KwSOQLElyftFah
         7TbGu2wM5J0Hqv0WWZFaKf8xyIsAdBsXwzp/ySb06y6rELZEfK2U65B+9m75AFzNy3VS
         R5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4DNn82Hydwh5GjZ2siT6TpqbYjxa28aSiee1gOftF/L3q5cr8Ke6K8bn5jvLVOi9U7fdV40dVRZ+nrm60@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8Sr717iRICXlwZu0vWzdiwsv1d0P3vCMlU5GQONgbT+D15on
	UiQMdohZsoa2fBsjPevyifg2jApM0FlFTGSrvDkQwd3J+rQ5UROTuT9Pwc44ydPz8PiF94vDlpn
	moaJlD1F0DGRjciL+BuyW31o+WelmSrI=
X-Gm-Gg: AZuq6aIJImRvznnzwb5RMDTaKqOqGeHacfUslCN8XpRhLfzS/XlJiR5KS80NIuwoSiR
	W8EpePuBKrD7oX/HF/NC3iVZKQWsAya+kjKoB/3b5NoL+jhfJo64kV9Wee8/DIRZGUHmPSJDOst
	EjNbZLG4zPPMEiRgTTRh/qjF55OUqHBVARDRebNKUrxpVVbLTOVyDKfg1I95CtE5BAnq0EIukZr
	2suGGkXmMaEBWsl9AYcLJfIsPvqD3SRb/cL6qz0D2dZmhnH0X+xNLWAOhyT4KCya8pL4XAzmz6L
	9t6rn/2rMhM=
X-Received: by 2002:a05:6a21:9f17:b0:387:9522:b667 with SMTP id
 adf61e73a8af0-392e01a9ba9mr436688637.78.1769723339613; Thu, 29 Jan 2026
 13:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org> <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
In-Reply-To: <a1214f2e-dbf7-41d9-ad8a-703193c84b67@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Jan 2026 13:48:47 -0800
X-Gm-Features: AZwV_QjLHC0kasaHM3AkD2XKoLB6u8t98t0cWiOvnfOHfn8IRgpugerxu8FUGsk
Message-ID: <CAEf4BzbvQ2wAaf61kGF7Wa2UUk4FvXBMxv2S4qReZ8Pr2eQW_g@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75910-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 25BE5B510C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 7:52=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 1/28/26 10:32 AM, Andrii Nakryiko wrote:
> > Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_l=
ock or
> > per-VMA lock, whichever was used to lock VMA under question, to avoid d=
eadlock
> > reported by syzbot:
> >
> >   -> #1 (&mm->mmap_lock){++++}-{4:4}:
> >          __might_fault+0xed/0x170
> >          _copy_to_iter+0x118/0x1720
> >          copy_page_to_iter+0x12d/0x1e0
> >          filemap_read+0x720/0x10a0
> >          blkdev_read_iter+0x2b5/0x4e0
> >          vfs_read+0x7f4/0xae0
> >          ksys_read+0x12a/0x250
> >          do_syscall_64+0xcb/0xf80
> >          entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >   -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
> >          __lock_acquire+0x1509/0x26d0
> >          lock_acquire+0x185/0x340
> >          down_read+0x98/0x490
> >          blkdev_read_iter+0x2a7/0x4e0
> >          __kernel_read+0x39a/0xa90
> >          freader_fetch+0x1d5/0xa80
> >          __build_id_parse.isra.0+0xea/0x6a0
> >          do_procmap_query+0xd75/0x1050
> >          procfs_procmap_ioctl+0x7a/0xb0
> >          __x64_sys_ioctl+0x18e/0x210
> >          do_syscall_64+0xcb/0xf80
> >          entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> >   other info that might help us debug this:
> >
> >    Possible unsafe locking scenario:
> >
> >          CPU0                    CPU1
> >          ----                    ----
> >     rlock(&mm->mmap_lock);
> >                                  lock(&sb->s_type->i_mutex_key#8);
> >                                  lock(&mm->mmap_lock);
> >     rlock(&sb->s_type->i_mutex_key#8);
> >
> >    *** DEADLOCK ***
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
> > ---
> >   fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++--------------=
-
> >   include/linux/buildid.h |  3 +++
> >   lib/buildid.c           | 34 +++++++++++++++++++++++++--------
> >   3 files changed, 56 insertions(+), 23 deletions(-)
> >

[...]

> >   /*
> > @@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct *=
vma, unsigned char *build_id,
> >    */
> >   int build_id_parse(struct vm_area_struct *vma, unsigned char *build_i=
d, __u32 *size)
> >   {
> > -     return __build_id_parse(vma, build_id, size, true /* may_fault */=
);
> > +     if (!vma->vm_file)
> > +             return -EINVAL;
> > +
> > +     return __build_id_parse(vma->vm_file, build_id, size, true /* may=
_fault */);
> > +}
> > +
> > +/*
> > + * Parse build ID of ELF file
> > + * @vma:      file object
>
> Should this be
>       @file:    file object
> ?
>

yep, thanks, fixed

> > + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> > + * @size:     returns actual build id size in case of success
> > + *
> > + * Assumes faultable context and can cause page faults to bring in fil=
e data
> > + * into page cache.
> > + *
> > + * Return: 0 on success; negative error, otherwise
> > + */
> > +int build_id_parse_file(struct file *file, unsigned char *build_id, __=
u32 *size)
> > +{
> > +     return __build_id_parse(file, build_id, size, true /* may_fault *=
/);
> >   }
> >
> >   /**
>

