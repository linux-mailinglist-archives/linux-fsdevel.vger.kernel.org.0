Return-Path: <linux-fsdevel+bounces-7443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660E9824F3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB4E1F2353C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365E20B0E;
	Fri,  5 Jan 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW5SQIgq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4E2032A;
	Fri,  5 Jan 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7815aad83acso25259185a.0;
        Thu, 04 Jan 2024 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704440223; x=1705045023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/w5eJtCLO9gyzG6a3HPEPuxuRzY98TrfAvqmGNhpoA=;
        b=GW5SQIgqS+qt8Ug/S+tlqTmqhq8dH72q7YgTQ0AC3gb56kaOe/ezw/ioR0BNKYKUAq
         QJAK2qf4HYUPvyA2me+wnEHzBhg627xKAc9OKJrQaixC9mq2zeop+hQxgUoe2iDF0yIj
         JlHvocU3qN5LvuJDJkP9xGi0tN5lEf4MSb6fnUNsLZ5+HEOnhp/ZzbNb6eKCGT/ghn/g
         2SoqAfcm0ILPFnu67SsTqqSFynCFZD2ENGRrmLb17SYmV00I+H7lWxjhoIK/EpUbnQOP
         btwAnrAzFAeRx5yyZl4+WDbjOqDbo7+MedwacDs62h9+0F0MooRgaKbYEWTa79GIkoEV
         /vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704440223; x=1705045023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/w5eJtCLO9gyzG6a3HPEPuxuRzY98TrfAvqmGNhpoA=;
        b=Q/JDcUgvpOfGiYM2K+iqczEBnNo1SHmIsrPK7g9m9neVf/44XmQ0ZQ3eTEjpoU/nfV
         efXaX8qpzNTUipQqTzoYHRXBouot3bfD+zuSupNZllN3WnsJPomnU7RAGtR4eNLnggHC
         R3Kl7Du3ejjrVdIRvq9UtvZU2QKZ8hmS275sqP66+cIr/bweY/mvcqbmVkixJ86a6LX9
         6lX4TGvWDg2tDipef4B+SlCSBrVHWyORFZ+EK2i3BgvoBubaSeezcXbz/najaHTV15JL
         FHftahvJIV1brjRpNqERArG5xWR0mpNzF27IpXIyCceI3pvVYh5z8aNbxIYWF7G5pJUH
         3BGA==
X-Gm-Message-State: AOJu0YyXZ2fi4CPXEV+GamVyjdDBtt6Qf7PYTJdFeuysEtfxnixn9gP9
	EYdMHw/43CpZhAoP2hDAvoeG+NA+Spu5ToB0SLk=
X-Google-Smtp-Source: AGHT+IHBCcbuLeRImH2jx+ovSBg0hgv5cSxZyu/VnUbjeW8foQ8V0JXs3m0L07ACEU2Elum/hTORiOYAYnRg3pAhPfg=
X-Received: by 2002:ad4:5def:0:b0:680:d159:ca5b with SMTP id
 jn15-20020ad45def000000b00680d159ca5bmr2804839qvb.50.1704440222871; Thu, 04
 Jan 2024 23:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170440153940.204613.6839922871340228115.stgit@bazille.1015granger.net>
 <170440173389.204613.14502976575665083984.stgit@bazille.1015granger.net>
In-Reply-To: <170440173389.204613.14502976575665083984.stgit@bazille.1015granger.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jan 2024 09:36:51 +0200
Message-ID: <CAOQ4uxhCQ2UrMJZCCTdn5=HtEDPV=ibP4XvGgbwVroepFbLk4g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fs: Create a generic is_dot_dotdot() utility
To: Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk
Cc: jlayton@redhat.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, trondmy@hammerspace.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:55=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> De-duplicate the same functionality in several places by hoisting
> the is_dot_dotdot() utility function into linux/fs.h.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/crypto/fname.c    |    8 +-------
>  fs/ecryptfs/crypto.c |   10 ----------
>  fs/exportfs/expfs.c  |    4 +---
>  fs/f2fs/f2fs.h       |   11 -----------
>  fs/namei.c           |    6 ++----
>  include/linux/fs.h   |   13 +++++++++++++
>  6 files changed, 17 insertions(+), 35 deletions(-)
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
> index 98b7a7a8c42e..53dd58a907e0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2846,6 +2846,19 @@ extern bool path_is_under(const struct path *, con=
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
> +       return len && unlikely(name[0] =3D=3D '.') &&
> +               (len < 2 || (len =3D=3D 2 && name[1] =3D=3D '.'));
> +}
> +

Looking back at the version that I suggested, (len < 2
here is silly and should be (len =3D=3D 1 || ...

But let's wait for inputs from other developers on this helper,
especially Al.

Thanks,
Amir.

