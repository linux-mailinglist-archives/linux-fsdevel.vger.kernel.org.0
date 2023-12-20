Return-Path: <linux-fsdevel+bounces-6592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065F81A15D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 15:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CC6B2517E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4303D992;
	Wed, 20 Dec 2023 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxBtZ0UE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88B3D965
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso2005563fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703083587; x=1703688387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y++I0Gx82rJKrJAFBgw9+Ki2GTokw+3W4FjoUun6UW8=;
        b=CxBtZ0UEy8/eE2HHu2lrOtsjRScWSLa+mj9r6bzQyEDvx9ZdekyBa7F5m0cP8+XH8r
         YgFhl3qpJgqz8O8brwEleVspUTGV3p9nNsjqNlENFbVAB9HxYQVsvcQocCoCjoHVnmMq
         cKmEbLYe+bYfbLTl5CHLH1fkmxu8mZqPLh8jqx5cAdiUM5oarrg0kUjrqJ9wWQgYqjKt
         fzYEVpckAPzSOZvx/GgDDBS8373S4AvuIO7ZA/rBtYiZT7NvvhX9wFgyfuCUHeEJ9wO6
         V2eWUFwayYr4A2XBTtZyvKUpu4PGv9rjE9mZh1uV1/fPeMKyiQou1dVo+e2nmb8PxFAZ
         lqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083587; x=1703688387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y++I0Gx82rJKrJAFBgw9+Ki2GTokw+3W4FjoUun6UW8=;
        b=m+olzsjJ7JqTzoSbxsXjvMdVv6nnzEh/Vc40XKIuRSyQNbbZ1NN31pgn9Jhz6AS1xP
         wmbWa1h61Etx9WSscBNHwPW7JJnZqeTY2IeJOPiLkOlIedxDssI+PkfX8AjtNsC040EG
         IxOsHxiQq7koMd4xCtLUDRuicWPXbRPe7ledu7evFy3F/Cu3mTdhO+yGcIJviPRdjHjn
         wGhftgC6qal3DnYZU61+OPssWURX1kMF04hL41UTp3dSmWfcl9nlBRvvWYmCEALKP0fQ
         B8KRYJ/RRdbP/8AEfhtu6kNlyelBho4DNWzAVbxcEBdkKyziY+ovPYHfpFFuQt1wAQqA
         nyYA==
X-Gm-Message-State: AOJu0YzrdwvHNJLxOzslhDA36sJjlopQsOS8QHeEk97EpAXblHy5VpVu
	FCYHwBqdukHirOXmLRcWuNTdDnvImeGeNfF4+ye3IwUzklw=
X-Google-Smtp-Source: AGHT+IElDyNZOdmgS0pNccji9nh+MS2YjxJN4ICDjK0T1lNWAUgPEEBhjBXgWuFzc05+MAl7Ev0wBjhZ9cuffOG8WYY=
X-Received: by 2002:a05:6870:8289:b0:203:85cc:5da4 with SMTP id
 q9-20020a056870828900b0020385cc5da4mr4339443oae.88.1703083586820; Wed, 20 Dec
 2023 06:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220051348.GY1674809@ZenIV> <20231220052310.GI1674809@ZenIV>
In-Reply-To: <20231220052310.GI1674809@ZenIV>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 20 Dec 2023 23:46:09 +0900
Message-ID: <CAKFNMokkfSaiR+8R0JRgeMJTtkhSr6AuvsgZsvjkRb3H=MTYKw@mail.gmail.com>
Subject: Re: nilfs2: d_obtain_alias(ERR_PTR(...)) will do the right thing...
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 2:23=E2=80=AFPM Al Viro wrote:
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/nilfs2/namei.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
> index 2a4e7f4a8102..8e8c7c981a7a 100644
> --- a/fs/nilfs2/namei.c
> +++ b/fs/nilfs2/namei.c
> @@ -439,7 +439,6 @@ static int nilfs_rename(struct mnt_idmap *idmap,
>  static struct dentry *nilfs_get_parent(struct dentry *child)
>  {
>         unsigned long ino;
> -       struct inode *inode;
>         struct nilfs_root *root;
>
>         ino =3D nilfs_inode_by_name(d_inode(child), &dotdot_name);
> @@ -448,11 +447,7 @@ static struct dentry *nilfs_get_parent(struct dentry=
 *child)
>
>         root =3D NILFS_I(d_inode(child))->i_root;
>
> -       inode =3D nilfs_iget(child->d_sb, root, ino);
> -       if (IS_ERR(inode))
> -               return ERR_CAST(inode);
> -
> -       return d_obtain_alias(inode);
> +       return d_obtain_alias(nilfs_iget(child->d_sb, root, ino));
>  }
>
>  static struct dentry *nilfs_get_dentry(struct super_block *sb, u64 cno,
> --
> 2.39.2
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

