Return-Path: <linux-fsdevel+bounces-8036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFA82EB3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C1B1F24129
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4421125D9;
	Tue, 16 Jan 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJHz/uxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F510782;
	Tue, 16 Jan 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680a13af19bso60737736d6.0;
        Tue, 16 Jan 2024 01:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705395863; x=1706000663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWDRecvJH/tBfBcAESVK7bhkquoB7rKpSpOtLZHAkmI=;
        b=XJHz/uxTVccqxXc10c9YAwijh6zQMggb2Rh23pRqe50E9h9Z0wQ+oZuR47Oszrf1o7
         //KHCMudYE9LeKDc7K1/lLQ/i2tMTgcILyAqmwke733WOcKYqMupQQy6YdbsvS4XRi4w
         nAqLd1LRykoVjVbfSg2hpVqMJGI2GXu5OWtR/C8GRS+PPBKQZ8CRNxZ8rVecaF5BPR/e
         E2vIGzS+FRAwS5Y2FJtEcZzXpAiFUdCBcl027vbVFbmK6KEcHgyl7Zp8IFr0hCYJKtxF
         T5CpwktsnPFDjxNI6NC7VjcH2UVR8hB473FDVdd2rfXjNcNGHnhEFV5t61BJL8nFMKG6
         uISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705395863; x=1706000663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWDRecvJH/tBfBcAESVK7bhkquoB7rKpSpOtLZHAkmI=;
        b=BRY79LsY2KsRJZ4bb+hEHn6lkBywzXivq7ZEzScU7S74lF5d8x/SMcPKLsZ4uqZu2u
         Uckp+TavTuqp47Z2ZwV6toNajsZX2CnqXHpPfPYd1h/o0k4mdqh/c1FJ9k8ranpT7tQS
         GytvRKYu5YjmaMhsNPpN/tiTV/0BmbfAsYKKq4/mASoOufybeVx+K3A53eKASBuYJD4X
         fmwiQHAiGcHK3o44ijoomctFmpr7ne0yJKEnmhuRQW1jnai5oStPJGvhtnsigrw3sEiM
         VXx0VYG9G60x30xUmMNakmPEd//84z6Tes4ACEZB6SeVyM0eoKkdaYy2bYBAQaRafxNe
         +9+A==
X-Gm-Message-State: AOJu0Yyhx0fWwyPoFo0sU4kjUEi2fI/Fu2sl5kkaztM/zCa+bNSoNDVX
	yrnTQ+0BRhLpxC0KqvDtwtkj7zBL9Z6VCVbKlfo=
X-Google-Smtp-Source: AGHT+IGWKyufLse5EGJdpy8ol/yrNSirXSN+1lIVNC17PLfzyN9+ty3GRnNxFXtaHlcfbAOD1P+pzX+ag9nf4PZ+BR8=
X-Received: by 2002:ad4:5c49:0:b0:67f:2ab2:d8b3 with SMTP id
 a9-20020ad45c49000000b0067f2ab2d8b3mr10157636qva.30.1705395863540; Tue, 16
 Jan 2024 01:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115232611.209265-1-sashal@kernel.org> <20240115232611.209265-12-sashal@kernel.org>
In-Reply-To: <20240115232611.209265-12-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Jan 2024 11:04:12 +0200
Message-ID: <CAOQ4uxgGY1949dr0-rt5wuNu-LH=DiRSZrJnamD9bgUtGM9hKQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 12/14] add unique mount ID
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>, Ian Kent <raven@themaw.net>, 
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 1:46=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> [ Upstream commit 98d2b43081972abeb5bb5a087bc3e3197531c46e ]
>
> If a mount is released then its mnt_id can immediately be reused.  This i=
s
> bad news for user interfaces that want to uniquely identify a mount.
>

Sasha,

This is a new API, not a bug fix.
Maybe AUTOSEL was triggered by the words "This is bad news for user...."?

You have also selected this to other 6.*.y kernels.

Thanks,
Amir.


> Implementing a unique mount ID is trivial (use a 64bit counter).
> Unfortunately userspace assumes 32bit size and would overflow after the
> counter reaches 2^32.
>
> Introduce a new 64bit ID alongside the old one.  Initialize the counter t=
o
> 2^32, this guarantees that the old and new IDs are never mixed up.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Link: https://lore.kernel.org/r/20231025140205.3586473-2-mszeredi@redhat.=
com
> Reviewed-by: Ian Kent <raven@themaw.net>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/mount.h                | 3 ++-
>  fs/namespace.c            | 4 ++++
>  fs/stat.c                 | 9 +++++++--
>  include/uapi/linux/stat.h | 1 +
>  4 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/mount.h b/fs/mount.h
> index 130c07c2f8d2..a14f762b3f29 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -72,7 +72,8 @@ struct mount {
>         struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
>         __u32 mnt_fsnotify_mask;
>  #endif
> -       int mnt_id;                     /* mount identifier */
> +       int mnt_id;                     /* mount identifier, reused */
> +       u64 mnt_id_unique;              /* mount ID unique until reboot *=
/
>         int mnt_group_id;               /* peer group identifier */
>         int mnt_expiry_mark;            /* true if marked for expiry */
>         struct hlist_head mnt_pins;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e04a9e9e3f14..12c8e2eeda91 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -68,6 +68,9 @@ static u64 event;
>  static DEFINE_IDA(mnt_id_ida);
>  static DEFINE_IDA(mnt_group_ida);
>
> +/* Don't allow confusion with old 32bit mount ID */
> +static atomic64_t mnt_id_ctr =3D ATOMIC64_INIT(1ULL << 32);
> +
>  static struct hlist_head *mount_hashtable __read_mostly;
>  static struct hlist_head *mountpoint_hashtable __read_mostly;
>  static struct kmem_cache *mnt_cache __read_mostly;
> @@ -130,6 +133,7 @@ static int mnt_alloc_id(struct mount *mnt)
>         if (res < 0)
>                 return res;
>         mnt->mnt_id =3D res;
> +       mnt->mnt_id_unique =3D atomic64_inc_return(&mnt_id_ctr);
>         return 0;
>  }
>
> diff --git a/fs/stat.c b/fs/stat.c
> index ef50573c72a2..a003e891a682 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -232,8 +232,13 @@ static int vfs_statx(int dfd, struct filename *filen=
ame, int flags,
>
>         error =3D vfs_getattr(&path, stat, request_mask, flags);
>
> -       stat->mnt_id =3D real_mount(path.mnt)->mnt_id;
> -       stat->result_mask |=3D STATX_MNT_ID;
> +       if (request_mask & STATX_MNT_ID_UNIQUE) {
> +               stat->mnt_id =3D real_mount(path.mnt)->mnt_id_unique;
> +               stat->result_mask |=3D STATX_MNT_ID_UNIQUE;
> +       } else {
> +               stat->mnt_id =3D real_mount(path.mnt)->mnt_id;
> +               stat->result_mask |=3D STATX_MNT_ID;
> +       }
>
>         if (path.mnt->mnt_root =3D=3D path.dentry)
>                 stat->attributes |=3D STATX_ATTR_MOUNT_ROOT;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7cab2c65d3d7..2f2ee82d5517 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -154,6 +154,7 @@ struct statx {
>  #define STATX_BTIME            0x00000800U     /* Want/got stx_btime */
>  #define STATX_MNT_ID           0x00001000U     /* Got stx_mnt_id */
>  #define STATX_DIOALIGN         0x00002000U     /* Want/got direct I/O al=
ignment info */
> +#define STATX_MNT_ID_UNIQUE    0x00004000U     /* Want/got extended stx_=
mount_id */
>
>  #define STATX__RESERVED                0x80000000U     /* Reserved for f=
uture struct statx expansion */
>
> --
> 2.43.0
>
>

