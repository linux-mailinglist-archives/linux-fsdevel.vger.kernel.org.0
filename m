Return-Path: <linux-fsdevel+bounces-75838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANeiIVr1emnDAAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 06:51:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4809AAC188
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 06:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E76C3013022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 05:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD150366059;
	Thu, 29 Jan 2026 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e55rY1cm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A0365A08
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665876; cv=pass; b=VMF8SQK5V6oYmM2A0rjPrIWZpbnskCWYBRk+pIVhp5vw99hYWIk4qRJKyUD/dx0GRr4lvJFV3NDvYwaG58USRrtnp9OMFh6wgF7VT6A0j25n/jhXznvqBqT0REe3eGIXwMeTFG/zlNcawl8s7Oxt5lbgdRHR39JilHB5kjEMtDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665876; c=relaxed/simple;
	bh=DtwpsDvwoifFlfoJ9md916ulMioOuh8cy0bLmld/VEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFJU5V9YjN3GDiNAbUreLKc402QLmbSXjPCtkLP9TF1KjfOz6LZIngQ9uNp0yeKvET/yfVt+fefiGhaibxadsKusdEo3XVr/msXMaJaSSWhv4x5y5768PAeC8VTw2EaixcJQNS5fBKypydRcmYl77xfDrL08JLHggAjeqyHTHTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e55rY1cm; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so199041cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 21:51:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769665868; cv=none;
        d=google.com; s=arc-20240605;
        b=DfZotpgcFku43NsoZflBCqFk3YfoilG5FhSPbS1i6BgyEVz1RVw/ueimF+rfWWv66w
         OKJHwnedcge0x7TTXKcZfnhIKLVZ6LlH9XgP0dO/Iv8g1HgtYrURv6cMtg8qXRBk4wyh
         28YgloOKmYn/uOzSwY0TUWymb51uoMm2AchKr5clDaT5t/f/Ab1MEw63OXm9zmC030c9
         HbHFpfThZVkPwOZqaE58O37XBNbzwhfdOpwuHHEnUB0hevV5ZgKJvOxNMUdU1Z0i6nU8
         JM3qcXF+gCxiSAqsRehA6p9C1SQYjbfw1mUI6YVoXuy9r3eb3bzRpJJHcqBrn10PYm0E
         RNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+I4M1s3j0bMSWuPz3rg0oxzV9B9B+nerZzojLunNls=;
        fh=i3OirWjuFGpzRKmQKshNCc8vrsG2v751DPiTzvhhLd0=;
        b=RZrB3bK6bn0TJdW/icsoPy3zsokR7FNzq7o9Gs0gbypSJvAmvZrzR509VxWEVE2+m/
         z1FAr+wDTLeRB9T+vxZGPUksrOzdpZi663oMq/ZOO8O3Y6e7nrO/ab3vSR7h6gJt/Cu5
         70e2rQnKyXiVa0dqiuNwpWHh7pUvQhVjAW8ClLznndMbPAZ7QZJUz6uEEpSwx+9Rk/tM
         C8cQ+mN3cemMee6QcvmwwfQ4MKp204aTgdIURK2FJ5qQR25q47mphZXgfgHsSH/iu6td
         Vjocx8XpLA2OEDRYP6Hi9hxFYH9RCek2kL2qIkab/Pr1qFU38hl5jRh4WTIBa41y5ELG
         GTUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769665868; x=1770270668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+I4M1s3j0bMSWuPz3rg0oxzV9B9B+nerZzojLunNls=;
        b=e55rY1cmAS/HgFiy/WaLFutsgTjNB3pRYgI+ROnbIr/e45LmNHUkKFWqF0A89XzB/l
         MQyfUMFayvwSBnlOE6Y5mnLzmGyjNMAgo6z22aov03RnwPCqyQyG+jyZqgJw6HrbLlvR
         32hloTQcNecjRnmrvLVZKRzOAzhfFcAjcvM30nIvqHEdQPqVY2UgVzlVhlfay3i/QtT9
         7siGgR6l81HK1ESJpTlEzEPmLfZByOVcSuoGHCYeJsYENVQatTzXdPsVVkl+XCiDPcWw
         gnv0IyS1PvVNwGgmeHuUmS/JhwN+dwQdKJ27TfihTrWANbWNiYNwaf/cijQCAhMj/d6L
         C/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665868; x=1770270668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+I4M1s3j0bMSWuPz3rg0oxzV9B9B+nerZzojLunNls=;
        b=m/IqSAxce3yZHOtWUivvIIYoZ6mNjT1IzWQLxevkG9JHfCX0zaeXjhvibJknFRk0PH
         ellXobqVPwoOCUdMNHUAwuxulgZX7Lvx/v0WDNnGOhdy4Jl+S4luyT4blaP49VR/iUU6
         X4TiRSA7ka6vHIhhoQ5NGiurtNsjeF3PXSHGsXnZmbNczeii9P8OXQ8UpNwNFm6B5VRc
         hAwbXENMnh2dFmPBoe87ZdqW3g0gN7uEIo/co7p9Og4UHNxrPEMICsdf0Q1Lt+YBmjE8
         S6fVSu46hlx/GEYTw9MZymmNLqnxIv/ZSHFQV1cL2ISdagZKEzTzOsKJwZHcsY1YAL3L
         nZAw==
X-Forwarded-Encrypted: i=1; AJvYcCWTtmWrc8oGPPhIW4GZX6VlIkzG2vaX0TLmN4GezVuDQzPjGwZwQe6lMfVQ3KXGJsZLXr8fQFyfPU3SKFs2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gxgsjE2eFyhzVdNe9TWkWWpnj+r7hSGikijC/BRanb7qEAxt
	11aezhUnK0f6HI+eij0AE2lXO583Fhq/cXuI/nBhMf3F1jkSLX5WF5ZYct5cnOEQQMt6wMeAgbD
	Kq99gMQzn5pzdHk+7QOJV6IrtVlhBWPgDajJoI1eLCf0PcUUSszNjNd0yqTY=
X-Gm-Gg: AZuq6aJlcKELZ9d5qDuGd/HAic7SWKkCJ6lJzFd59wVaLU8TRA5t/LDro2iwNfO2li0
	RNeEaQ3UHelk8erTdQdhYIOI0+9IxeF5bt/cj1McFAMj1wlW/Tw9C9Pt9iD/BlcRQWQL0Dm5bgG
	BfNE3+h8b1qlXnQHNlvHog7EaggtLnrdZE5uvnIWHrsIb3InKi2ttHnKY1Z6BTJS35byypBjGv1
	jVdA8BbKdHLnRGPxUiOF5GfHkUQLTFHDFlokt5NNaDhBaMmSJsz2jh0rGpXFcu4+vNuWg==
X-Received: by 2002:a05:622a:1306:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-503b66a55c4mr7810771cf.6.1769665868137; Wed, 28 Jan 2026
 21:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org>
In-Reply-To: <20260128183232.2854138-1-andrii@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Jan 2026 21:50:57 -0800
X-Gm-Features: AZwV_QhnZUXKlUFFOl2DJidKj3WCTCYNluIJH-xXN0ab4mRyISg9ZyWQ5ss0onA
Message-ID: <CAJuCfpETSCvD8m+q5upFKb5pCf2P7ffMMJs8p-y=V9fjdh73GQ@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Andrii Nakryiko <andrii@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75838-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4809AAC188
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:32=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_loc=
k or
> per-VMA lock, whichever was used to lock VMA under question, to avoid dea=
dlock
> reported by syzbot:
>
>  -> #1 (&mm->mmap_lock){++++}-{4:4}:
>         __might_fault+0xed/0x170
>         _copy_to_iter+0x118/0x1720
>         copy_page_to_iter+0x12d/0x1e0
>         filemap_read+0x720/0x10a0
>         blkdev_read_iter+0x2b5/0x4e0
>         vfs_read+0x7f4/0xae0
>         ksys_read+0x12a/0x250
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>         __lock_acquire+0x1509/0x26d0
>         lock_acquire+0x185/0x340
>         down_read+0x98/0x490
>         blkdev_read_iter+0x2a7/0x4e0
>         __kernel_read+0x39a/0xa90
>         freader_fetch+0x1d5/0xa80
>         __build_id_parse.isra.0+0xea/0x6a0
>         do_procmap_query+0xd75/0x1050
>         procfs_procmap_ioctl+0x7a/0xb0
>         __x64_sys_ioctl+0x18e/0x210
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  other info that might help us debug this:
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    rlock(&mm->mmap_lock);
>                                 lock(&sb->s_type->i_mutex_key#8);
>                                 lock(&mm->mmap_lock);
>    rlock(&sb->s_type->i_mutex_key#8);
>
>   *** DEADLOCK ***
>
> To make this safe, we need to grab file refcount while VMA is still locke=
d, but
> other than that everything is pretty straightforward. Internal build_id_p=
arse()
> API assumes VMA is passed, but it only needs the underlying file referenc=
e, so
> just add another variant build_id_parse_file() that expects file passed
> directly.
>
> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for=
 /proc/<pid>/maps")
> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

One nit below, otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++---------------
>  include/linux/buildid.h |  3 +++
>  lib/buildid.c           | 34 +++++++++++++++++++++++++--------
>  3 files changed, 56 insertions(+), 23 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 480db575553e..dd3b5cf9f0b7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, voi=
d __user *uarg)
>         struct proc_maps_locking_ctx lock_ctx =3D { .mm =3D mm };
>         struct procmap_query karg;
>         struct vm_area_struct *vma;
> +       struct file *vm_file =3D NULL;
>         const char *name =3D NULL;
>         char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
>         __u64 usize;
> @@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct *mm, vo=
id __user *uarg)
>                 karg.inode =3D 0;
>         }
>
> -       if (karg.build_id_size) {
> -               __u32 build_id_sz;
> -
> -               err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
> -               if (err) {
> -                       karg.build_id_size =3D 0;
> -               } else {
> -                       if (karg.build_id_size < build_id_sz) {
> -                               err =3D -ENAMETOOLONG;
> -                               goto out;
> -                       }
> -                       karg.build_id_size =3D build_id_sz;
> -               }
> -       }
> -
>         if (karg.vma_name_size) {
>                 size_t name_buf_sz =3D min_t(size_t, PATH_MAX, karg.vma_n=
ame_size);
>                 const struct path *path;
> @@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct *mm, v=
oid __user *uarg)
>                 karg.vma_name_size =3D name_sz;
>         }
>
> +       if (karg.build_id_size && vma->vm_file)
> +               vm_file =3D get_file(vma->vm_file);
> +
>         /* unlock vma or mmap_lock, and put mm_struct before copying data=
 to user */
>         query_vma_teardown(&lock_ctx);
>         mmput(mm);
>
> +       if (karg.build_id_size) {
> +               __u32 build_id_sz;
> +
> +               if (vm_file)
> +                       err =3D build_id_parse_file(vm_file, build_id_buf=
, &build_id_sz);
> +               else
> +                       err =3D -ENOENT;

Before this change we returned EINVAL when vma->vm_file=3D=3DNULL, now we
return ENOENT. Probably not critical but is there a reason for this
change?

> +               if (err) {
> +                       karg.build_id_size =3D 0;
> +               } else {
> +                       if (karg.build_id_size < build_id_sz) {
> +                               err =3D -ENAMETOOLONG;
> +                               goto out;
> +                       }
> +                       karg.build_id_size =3D build_id_sz;
> +               }
> +       }
> +
> +       if (vm_file)
> +               fput(vm_file);
> +
>         if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_n=
ame_addr),
>                                                name, karg.vma_name_size))=
 {
>                 kfree(name_buf);
> @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, voi=
d __user *uarg)
>  out:
>         query_vma_teardown(&lock_ctx);
>         mmput(mm);
> +       if (vm_file)
> +               fput(vm_file);
>         kfree(name_buf);
>         return err;
>  }
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 831c1b4b626c..7acc06b22fb7 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -7,7 +7,10 @@
>  #define BUILD_ID_SIZE_MAX 20
>
>  struct vm_area_struct;
> +struct file;
> +
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, =
__u32 *size);
> +int build_id_parse_file(struct file *file, unsigned char *build_id, __u3=
2 *size);
>  int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *bu=
ild_id, __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf=
_size);
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 818331051afe..dc643a6293c1 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -279,7 +279,7 @@ static int get_build_id_64(struct freader *r, unsigne=
d char *build_id, __u32 *si
>  /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
>  #define MAX_FREADER_BUF_SZ 64
>
> -static int __build_id_parse(struct vm_area_struct *vma, unsigned char *b=
uild_id,
> +static int __build_id_parse(struct file *file, unsigned char *build_id,
>                             __u32 *size, bool may_fault)
>  {
>         const Elf32_Ehdr *ehdr;
> @@ -287,11 +287,7 @@ static int __build_id_parse(struct vm_area_struct *v=
ma, unsigned char *build_id,
>         char buf[MAX_FREADER_BUF_SZ];
>         int ret;
>
> -       /* only works for page backed storage  */
> -       if (!vma->vm_file)
> -               return -EINVAL;
> -
> -       freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fa=
ult);
> +       freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);
>
>         /* fetch first 18 bytes of ELF header for checks */
>         ehdr =3D freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
> @@ -332,7 +328,10 @@ static int __build_id_parse(struct vm_area_struct *v=
ma, unsigned char *build_id,
>   */
>  int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *bu=
ild_id, __u32 *size)
>  {
> -       return __build_id_parse(vma, build_id, size, false /* !may_fault =
*/);
> +       if (!vma->vm_file)
> +               return -EINVAL;
> +
> +       return __build_id_parse(vma->vm_file, build_id, size, false /* !m=
ay_fault */);
>  }
>
>  /*
> @@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct *vm=
a, unsigned char *build_id,
>   */
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, =
__u32 *size)
>  {
> -       return __build_id_parse(vma, build_id, size, true /* may_fault */=
);
> +       if (!vma->vm_file)
> +               return -EINVAL;
> +
> +       return __build_id_parse(vma->vm_file, build_id, size, true /* may=
_fault */);
> +}
> +
> +/*
> + * Parse build ID of ELF file
> + * @vma:      file object
> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> + * @size:     returns actual build id size in case of success
> + *
> + * Assumes faultable context and can cause page faults to bring in file =
data
> + * into page cache.
> + *
> + * Return: 0 on success; negative error, otherwise
> + */
> +int build_id_parse_file(struct file *file, unsigned char *build_id, __u3=
2 *size)
> +{
> +       return __build_id_parse(file, build_id, size, true /* may_fault *=
/);
>  }
>
>  /**
> --
> 2.47.3
>

