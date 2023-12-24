Return-Path: <linux-fsdevel+bounces-6864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2D81D8D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 12:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1DE1F21536
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E32106;
	Sun, 24 Dec 2023 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldh/vF+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40320F5
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f85d29d14so22960486d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703416495; x=1704021295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac7gSmA9uIm3hbzysUJveVOCzIOogR7XhzsA7tyT1nw=;
        b=ldh/vF+K92EcOo7+rkWXbGgxXzDjWUR1iTOqRiK83bviHFPIfsITi7wi87OEeWjqpc
         nA+5CQQ2xJKxLQ++xZbkw6yNXpQENQ2XYQQ0AhYrYLrqw8mL+1F6kFzt8jJwVqYdNo0b
         SyCmkm29Ox1Jqgas65arukBInWFJ4yiwuRFt7LHJbREM/YEZEoDXoDO1ZczDWJIlrnt9
         x+CaQdlhkh7hXI7Dtdm2GdzjfixfTpVQOH+Xl4oWVem2OvtNni9c5RlW624p4rjMOYQS
         +jJq46y3bUcxrHnSrm1aiM1Cn/qiJIoEPVfZKbkZEHoDYNiC97+xexAWuvPZ1VxvYn/V
         98Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703416495; x=1704021295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac7gSmA9uIm3hbzysUJveVOCzIOogR7XhzsA7tyT1nw=;
        b=bvQHqkEOEvOS4ttVpItJFl4FBkApHjVK0LzxhyxmdFXdvxnSMOE1HjpIt2ky8kQKgY
         RZfyT4B1NqfFMvmTQXueLhqAzsOpLfjFVWIwPQNeXbpOpARBsnn+Ecb0TlIH1EOvknzx
         FPmWiHIeOo10kpxsSpqy6YILCgdIh/+4U6ropRWq1ngtEJde5ebvHnd4wV97l6F9nAHV
         iNm6ZZAFWSUENq+ZUBYknUZQXgW1sHJsX2B4dLhwuFrAVzaw7SxENllGIUm/rKTkjsg6
         j1zQyNkoS0DxuJupVi6RbjAnNh2KSD0B3lhAItgVUXdykDsD8Mv0ag5n4aBZ2yLOvJkj
         jldQ==
X-Gm-Message-State: AOJu0Yzoaep92uj6/o012SkJTE45QtYN5pXr5sx2nl2DowI/cYqb4o3h
	Pudeqg9JOVrknP0ExvVebs/QubKyFVRHQk3wJAhp9qJhcLE=
X-Google-Smtp-Source: AGHT+IEVrT2zHmNyT50qPyn0Tqd3jhOqV0q3mauNuCVd54GMEyOIGxQfHkKuPFhYJtHAh5kVQWMtYX7HdXfqd9Na3Nw=
X-Received: by 2002:a05:6214:88:b0:67f:d236:5c21 with SMTP id
 n8-20020a056214008800b0067fd2365c21mr1448484qvr.105.1703416495531; Sun, 24
 Dec 2023 03:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224104914.49316-1-bschubert@ddn.com> <20231224104914.49316-3-bschubert@ddn.com>
In-Reply-To: <20231224104914.49316-3-bschubert@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Dec 2023 13:14:44 +0200
Message-ID: <CAOQ4uxgxG4FinVmPoQmbmcFoioOetrKSD2ZkGKykyiaJQqoT3g@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: Create helper function if DIO write needs
 exclusive lock
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	miklos@szeredi.hu, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 12:49=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> This makes the code a bit easier to read and allows to more
> easily add more conditions when an exclusive lock is needed.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/file.c | 64 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 19 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 174aa16407c4b..546254aaab19f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1298,6 +1298,45 @@ static ssize_t fuse_perform_write(struct kiocb *io=
cb, struct iov_iter *ii)
>         return res;
>  }
>
> +static bool fuse_io_past_eof(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +
> +       return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
> +}
> +
> +/*
> + * @return true if an exclusive lock for direct IO writes is needed
> + */
> +static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_it=
er *from)
> +{
> +       struct file *file =3D iocb->ki_filp;
> +       struct fuse_file *ff =3D file->private_data;
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +
> +       /* server side has to advise that it supports parallel dio writes=
 */
> +       if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
> +               return true;
> +
> +       /* append will need to know the eventual eof - always needs an
> +        * exclusive lock
> +        */
> +       if (iocb->ki_flags & IOCB_APPEND)
> +               return true;
> +
> +       /* combination opf page access and direct-io difficult, shared
> +        * locks actually introduce a conflict.
> +        */
> +       if (get_fuse_conn(inode)->direct_io_allow_mmap)
> +               return true;
> +
> +       /* parallel dio beyond eof is at least for now not supported */
> +       if (fuse_io_past_eof(iocb, from))
> +               return true;
> +
> +       return false;
> +}
> +
>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
>  {
>         struct file *file =3D iocb->ki_filp;
> @@ -1557,26 +1596,12 @@ static ssize_t fuse_direct_read_iter(struct kiocb=
 *iocb, struct iov_iter *to)
>         return res;
>  }
>
> -static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
> -                                              struct iov_iter *iter)
> -{
> -       struct inode *inode =3D file_inode(iocb->ki_filp);
> -
> -       return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
> -}
> -
>  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_ite=
r *from)
>  {
>         struct inode *inode =3D file_inode(iocb->ki_filp);
> -       struct file *file =3D iocb->ki_filp;
> -       struct fuse_file *ff =3D file->private_data;
>         struct fuse_io_priv io =3D FUSE_IO_PRIV_SYNC(iocb);
>         ssize_t res;
> -       bool exclusive_lock =3D
> -               !(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
> -               get_fuse_conn(inode)->direct_io_allow_mmap ||
> -               iocb->ki_flags & IOCB_APPEND ||
> -               fuse_direct_write_extending_i_size(iocb, from);
> +       bool exclusive_lock =3D fuse_dio_wr_exclusive_lock(iocb, from);
>
>         /*
>          * Take exclusive lock if
> @@ -1590,10 +1615,10 @@ static ssize_t fuse_direct_write_iter(struct kioc=
b *iocb, struct iov_iter *from)
>         else {
>                 inode_lock_shared(inode);
>
> -               /* A race with truncate might have come up as the decisio=
n for
> -                * the lock type was done without holding the lock, check=
 again.
> +               /*
> +                * Previous check was without any lock and might have rac=
ed.
>                  */
> -               if (fuse_direct_write_extending_i_size(iocb, from)) {
> +               if (fuse_dio_wr_exclusive_lock(iocb, from)) {
>                         inode_unlock_shared(inode);
>                         inode_lock(inode);
>                         exclusive_lock =3D true;
> @@ -2467,7 +2492,8 @@ static int fuse_file_mmap(struct file *file, struct=
 vm_area_struct *vma)
>                 return fuse_dax_mmap(file, vma);
>
>         if (ff->open_flags & FOPEN_DIRECT_IO) {
> -               /* Can't provide the coherency needed for MAP_SHARED
> +               /*
> +                * Can't provide the coherency needed for MAP_SHARED
>                  * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
>                  */
>                 if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow=
_mmap)
> --
> 2.40.1
>

