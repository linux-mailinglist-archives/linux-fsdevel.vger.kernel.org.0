Return-Path: <linux-fsdevel+bounces-6952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5081EEBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8551A1F21253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9A446C7;
	Wed, 27 Dec 2023 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="c9Rz5xJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36836446C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-427e8bb6778so3973231cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 04:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1703678715; x=1704283515; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1i4yebbpcapAqhI8IoWwGDeG4KA5THFUdOwfsgrXTo=;
        b=c9Rz5xJUVZcYS7Y3pZMg893ILiLIKRGz3cO9WO/j6ztyJktKZl0Wn+B9RuAuM903Dq
         JuW2FNKVZboHsQTmGi/u/HVGkv8raVirf5zupeE8GMjs720udplh6b1tRVlPuJwqSNY3
         vrGkLAiXZKQaGCmIvJpNA/M/67MGdL6HeX5cEuXZkzVVhpAVLzcVDoxcQVhxppB/Ea5y
         hHIoealfLLYZnWfPUMtSN/GWSs/WEtmZpcLv6VgNcIYonIU8ir8v1VJl1LvZSmbUUwbQ
         rtKzn9jf0A/6qU+tmZOjnrHPqLZfJqrKE22AN7uhUPkAyh/7XQez8U4keQ/b6wVhiT9a
         g+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703678715; x=1704283515;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1i4yebbpcapAqhI8IoWwGDeG4KA5THFUdOwfsgrXTo=;
        b=k+braAIeeUNQ/OUSfcVfH9QxVB6HYEbld/L4rG04MW6gWxxi6sVnr+NKaDpEIYLyD6
         uo1WVVGju0VNwc9Q60sUx9VEh82A9wOwl8iDCPAHTgzTUELJKE45SrD776IHrfW+UpxY
         wPQMCGVasBiPGricW0g/4xIJSg/JuBh/RbrO5xAOBFaTS+bB5Ec01X+7tbQBo9HWfCJp
         8Io6q0YwpqDpZw9hMtu61cWWCr5/8ydhKl6Yu93L/DtpnEbkG04mKPcYnv7PC/HMIPHx
         KLTKicn0YXPjdLMRUAKiHmHlHgWZFi1i8LGrDtWm0WGCKXCBS7yR/ftPWYHaTFuMWkbx
         evlQ==
X-Gm-Message-State: AOJu0Yz1zLGe0Bk2VtBF5eM7qBRNt51k97Dguzxz1JHA8j1Ujz/k8JmU
	f4+v+M6yHZNyfDqmm8c9637TcXMf+jf4LxyNY3VnxROOYEOj9MnOkH04yjHlIQ==
X-Google-Smtp-Source: AGHT+IFPVrUDUxOsiOYW7ye63Z+uFE+Krp6CkzOuPMLJLNadIjPCx5HEA7eEWyAzc3518nmkzYXSDSioE1e/9t0zFjY=
X-Received: by 2002:ac8:7f91:0:b0:427:f246:593d with SMTP id
 z17-20020ac87f91000000b00427f246593dmr164331qtj.112.1703678715057; Wed, 27
 Dec 2023 04:05:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220051348.GY1674809@ZenIV> <20231220053238.GT1674809@ZenIV>
In-Reply-To: <20231220053238.GT1674809@ZenIV>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 27 Dec 2023 07:05:04 -0500
Message-ID: <CAOg9mSR0KtsdkZ+32n4EtMegw-YOO6o11CNPpotPGDw4F+4Kvw@mail.gmail.com>
Subject: Re: [PATCH 21/22] orangefs: saner arguments passing in readdir guts
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Howdy Al... I applied your orangefs patch to 6.7.0-rc6 and found one
xfstests failure that was not there when I ran against
xfstests-6.7.0-rc5. (generic/438)

I'm about to hit the road for a several day motorcycle ride in an hour
or so, I just wanted to give feedback before Ieft. I'll look into it
further when I get back.

-Mike

On Wed, Dec 20, 2023 at 12:33=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> orangefs_dir_fill() doesn't use oi and dentry arguments at all
> do_readdir() gets dentry, uses only dentry->d_inode; it also
> gets oi, which is ORANGEFS_I(dentry->d_inode) (i.e. ->d_inode -
> constant offset).
> orangefs_dir_mode() gets dentry and oi, uses only to pass those
> to do_readdir().
> orangefs_dir_iterate() uses dentry and oi only to pass those to
> orangefs_dir_fill() and orangefs_dir_more().
>
> The only thing it really needs is ->d_inode; moreover, that's
> better expressed as file_inode(file) - no need to go through
> ->f_path.dentry->d_inode.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/orangefs/dir.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/fs/orangefs/dir.c b/fs/orangefs/dir.c
> index 9cacce5d55c1..6d1fbeca9d81 100644
> --- a/fs/orangefs/dir.c
> +++ b/fs/orangefs/dir.c
> @@ -58,10 +58,10 @@ struct orangefs_dir {
>   * first part of the part list.
>   */
>
> -static int do_readdir(struct orangefs_inode_s *oi,
> -    struct orangefs_dir *od, struct dentry *dentry,
> +static int do_readdir(struct orangefs_dir *od, struct inode *inode,
>      struct orangefs_kernel_op_s *op)
>  {
> +       struct orangefs_inode_s *oi =3D ORANGEFS_I(inode);
>         struct orangefs_readdir_response_s *resp;
>         int bufi, r;
>
> @@ -87,7 +87,7 @@ static int do_readdir(struct orangefs_inode_s *oi,
>         op->upcall.req.readdir.buf_index =3D bufi;
>
>         r =3D service_operation(op, "orangefs_readdir",
> -           get_interruptible_flag(dentry->d_inode));
> +           get_interruptible_flag(inode));
>
>         orangefs_readdir_index_put(bufi);
>
> @@ -158,8 +158,7 @@ static int parse_readdir(struct orangefs_dir *od,
>         return 0;
>  }
>
> -static int orangefs_dir_more(struct orangefs_inode_s *oi,
> -    struct orangefs_dir *od, struct dentry *dentry)
> +static int orangefs_dir_more(struct orangefs_dir *od, struct inode *inod=
e)
>  {
>         struct orangefs_kernel_op_s *op;
>         int r;
> @@ -169,7 +168,7 @@ static int orangefs_dir_more(struct orangefs_inode_s =
*oi,
>                 od->error =3D -ENOMEM;
>                 return -ENOMEM;
>         }
> -       r =3D do_readdir(oi, od, dentry, op);
> +       r =3D do_readdir(od, inode, op);
>         if (r) {
>                 od->error =3D r;
>                 goto out;
> @@ -238,9 +237,7 @@ static int fill_from_part(struct orangefs_dir_part *p=
art,
>         return 1;
>  }
>
> -static int orangefs_dir_fill(struct orangefs_inode_s *oi,
> -    struct orangefs_dir *od, struct dentry *dentry,
> -    struct dir_context *ctx)
> +static int orangefs_dir_fill(struct orangefs_dir *od, struct dir_context=
 *ctx)
>  {
>         struct orangefs_dir_part *part;
>         size_t count;
> @@ -304,15 +301,10 @@ static loff_t orangefs_dir_llseek(struct file *file=
, loff_t offset,
>  static int orangefs_dir_iterate(struct file *file,
>      struct dir_context *ctx)
>  {
> -       struct orangefs_inode_s *oi;
> -       struct orangefs_dir *od;
> -       struct dentry *dentry;
> +       struct orangefs_dir *od =3D file->private_data;
> +       struct inode *inode =3D file_inode(file);
>         int r;
>
> -       dentry =3D file->f_path.dentry;
> -       oi =3D ORANGEFS_I(dentry->d_inode);
> -       od =3D file->private_data;
> -
>         if (od->error)
>                 return od->error;
>
> @@ -342,7 +334,7 @@ static int orangefs_dir_iterate(struct file *file,
>          */
>         while (od->token !=3D ORANGEFS_ITERATE_END &&
>             ctx->pos > od->end) {
> -               r =3D orangefs_dir_more(oi, od, dentry);
> +               r =3D orangefs_dir_more(od, inode);
>                 if (r)
>                         return r;
>         }
> @@ -351,17 +343,17 @@ static int orangefs_dir_iterate(struct file *file,
>
>         /* Then try to fill if there's any left in the buffer. */
>         if (ctx->pos < od->end) {
> -               r =3D orangefs_dir_fill(oi, od, dentry, ctx);
> +               r =3D orangefs_dir_fill(od, ctx);
>                 if (r)
>                         return r;
>         }
>
>         /* Finally get some more and try to fill. */
>         if (od->token !=3D ORANGEFS_ITERATE_END) {
> -               r =3D orangefs_dir_more(oi, od, dentry);
> +               r =3D orangefs_dir_more(od, inode);
>                 if (r)
>                         return r;
> -               r =3D orangefs_dir_fill(oi, od, dentry, ctx);
> +               r =3D orangefs_dir_fill(od, ctx);
>         }
>
>         return r;
> --
> 2.39.2
>
>

