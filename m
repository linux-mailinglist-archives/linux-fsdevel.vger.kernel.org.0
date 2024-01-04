Return-Path: <linux-fsdevel+bounces-7405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C898247CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2474282B89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3EC28DBE;
	Thu,  4 Jan 2024 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISUYcC5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4482286BF;
	Thu,  4 Jan 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbd5b96b12eso742801276.2;
        Thu, 04 Jan 2024 09:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704390599; x=1704995399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+37izvXEeXVtoNiX+JUfL8hj331igySy/Mhbwc1rQU=;
        b=ISUYcC5fVq1WIUtK/agw1dIF9s+6CB4jOukHGlnR7dlF4k65AA6D8SKhcFCbenSpdt
         zRBEHbRhSxR3/z4sj8FcTSexdmY0DUnlfY5H0Ih30wo2Glh1JJJh6BZsZDI+VQnDOfDL
         pUR0C+bMrd+YS8PaZlFrYxanyMf6wHX4ClG940UVGFZ40Vk2cz6TRyURN6F93/ZIjKEj
         OTvUHtsba/IAEd3gcZwmva0gINPa+aWlceZd/FJ7HS0HdOcb7SzCEaM0fGbRWkTH1SWV
         UILkFdbISjaZtsdIba9prbpqibToQ1vEMTFz058eOpTzTM0v9hLcSR/uGi9RMglw5zrF
         X64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704390599; x=1704995399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+37izvXEeXVtoNiX+JUfL8hj331igySy/Mhbwc1rQU=;
        b=vh5q6pjzZvwKzOEHn4RRlHmlu9GTZmBvf0tklozWuUmFM6O6z/fepPbZ/VJwK5K8hh
         0z8nDts+XaMSwd1JmWENUtqrw/sXvYHHQ1Up4T/XdrEvfLwODZ9zxIH6P8z9tsa8C6FB
         wC04sfpLN2D7V7mHN2ETbEKbCigYylOTEsv1RMUXpkL7tJeorN08fjvL7bvvJMbAQP7/
         ADF21utzJ3bJoPulG9hrNCerE3o0x+aXkZUrNHV/3FC5KatRl44QccBlc595/Ic+reiU
         3VjvD+zxVCzIA/xcGtLVB7RIEcGzjV061Qqz6sYt+SVjzGaU2SKDSiBlBkxoLlUUZTHo
         jMag==
X-Gm-Message-State: AOJu0YyrUdOx0L/JE354sT5h21f3CB0jowqDAXiQM8jxVc/rYabnlsEV
	3oGrPYOY6k/KPexRXxzjcQea7Kc8AcpImet78kU=
X-Google-Smtp-Source: AGHT+IHBUFJSviuPospZIVv2OpIi0ss5sY3pA+e0b1l3FCLFxw47TgV821zZPI9PSbRDYHiVvuprzEaMk57NaWhp1XM=
X-Received: by 2002:a25:8681:0:b0:dbd:bc92:f932 with SMTP id
 z1-20020a258681000000b00dbdbc92f932mr767124ybk.64.1704390598629; Thu, 04 Jan
 2024 09:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170438430288.129184.6116374966267668617.stgit@bazille.1015granger.net>
 <170438514228.129184.8854845947814287856.stgit@bazille.1015granger.net>
In-Reply-To: <170438514228.129184.8854845947814287856.stgit@bazille.1015granger.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Jan 2024 19:49:47 +0200
Message-ID: <CAOQ4uxgC0ysNtgfLL1MOdrok_4WhBW6qvJ+c-MJpzjsYZBrmVg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fs: Create a generic is_dot_dotdot() utility
To: Chuck Lever <cel@kernel.org>
Cc: jlayton@redhat.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, trondmy@hammerspace.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:19=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> De-duplicate the same functionality in several places by hoisting
> the is_dot_dotdot() utility function into linux/fs.h.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/crypto/fname.c    |    8 +-------
>  fs/ecryptfs/crypto.c |   10 ----------
>  fs/exportfs/expfs.c  |    4 +---
>  fs/f2fs/f2fs.h       |   11 -----------
>  fs/namei.c           |    6 ++----
>  include/linux/fs.h   |   15 +++++++++++++++
>  6 files changed, 19 insertions(+), 35 deletions(-)
>
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 7b3fc189593a..0ad52fbe51c9 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -74,13 +74,7 @@ struct fscrypt_nokey_name {
>
>  static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
>  {
> -       if (str->len =3D=3D 1 && str->name[0] =3D=3D '.')
> -               return true;
> -
> -       if (str->len =3D=3D 2 && str->name[0] =3D=3D '.' && str->name[1] =
=3D=3D '.')
> -               return true;
> -
> -       return false;
> +       return is_dot_dotdot(str->name, str->len);
>  }
>
>  /**
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index 03bd55069d86..2fe0f3af1a08 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1949,16 +1949,6 @@ int ecryptfs_encrypt_and_encode_filename(
>         return rc;
>  }
>
> -static bool is_dot_dotdot(const char *name, size_t name_size)
> -{
> -       if (name_size =3D=3D 1 && name[0] =3D=3D '.')
> -               return true;
> -       else if (name_size =3D=3D 2 && name[0] =3D=3D '.' && name[1] =3D=
=3D '.')
> -               return true;
> -
> -       return false;
> -}
> -
>  /**
>   * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher te=
xt name to decoded plaintext
>   * @plaintext_name: The plaintext name
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 84af58eaf2ca..07ea3d62b298 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -255,9 +255,7 @@ static bool filldir_one(struct dir_context *ctx, cons=
t char *name, int len,
>                 container_of(ctx, struct getdents_callback, ctx);
>
>         buf->sequence++;
> -       /* Ignore the '.' and '..' entries */
> -       if ((len > 2 || name[0] !=3D '.' || (len =3D=3D 2 && name[1] !=3D=
 '.')) &&
> -           buf->ino =3D=3D ino && len <=3D NAME_MAX) {
> +       if (buf->ino =3D=3D ino && len <=3D NAME_MAX && !is_dot_dotdot(na=
me, len)) {
>                 memcpy(buf->name, name, len);
>                 buf->name[len] =3D '\0';
>                 buf->found =3D 1;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9043cedfa12b..322a3b8a3533 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3368,17 +3368,6 @@ static inline bool f2fs_cp_error(struct f2fs_sb_in=
fo *sbi)
>         return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
>  }
>
> -static inline bool is_dot_dotdot(const u8 *name, size_t len)
> -{
> -       if (len =3D=3D 1 && name[0] =3D=3D '.')
> -               return true;
> -
> -       if (len =3D=3D 2 && name[0] =3D=3D '.' && name[1] =3D=3D '.')
> -               return true;
> -
> -       return false;
> -}
> -
>  static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
>                                         size_t size, gfp_t flags)
>  {
> diff --git a/fs/namei.c b/fs/namei.c
> index 71c13b2990b4..2386a70667fa 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2667,10 +2667,8 @@ static int lookup_one_common(struct mnt_idmap *idm=
ap,
>         if (!len)
>                 return -EACCES;
>
> -       if (unlikely(name[0] =3D=3D '.')) {
> -               if (len < 2 || (len =3D=3D 2 && name[1] =3D=3D '.'))
> -                       return -EACCES;
> -       }
> +       if (is_dot_dotdot(name, len))
> +               return -EACCES;
>
>         while (len--) {
>                 unsigned int c =3D *(const unsigned char *)name++;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..750c95a2b572 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2846,6 +2846,21 @@ extern bool path_is_under(const struct path *, con=
st struct path *);
>
>  extern char *file_path(struct file *, char *, int);
>
> +/**
> + * is_dot_dotdot - returns true only if @name is "." or ".."
> + * @name: file name to check
> + * @len: length of file name, in bytes
> + *
> + * Coded for efficiency.
> + */
> +static inline bool is_dot_dotdot(const char *name, size_t len)
> +{
> +       if (unlikely(name[0] =3D=3D '.'))
> +               if (len < 2 || (len =3D=3D 2 && name[1] =3D=3D '.'))
> +                       return true;
> +       return false;
> +}

I hate to nag, but these double ifs look really odd in the
context of a helper.
Also, not sure if all callers guarantee the len > 0
I did not check.
Like this?

static inline bool is_dot_dotdot(const char *name, size_t len)
{
       return len && unlikely(name[0] =3D=3D '.') &&
                 (len < 2 || (len =3D=3D 2 && name[1] =3D=3D '.');
}

Thanks,
Amir.

