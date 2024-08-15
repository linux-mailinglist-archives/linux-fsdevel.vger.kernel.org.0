Return-Path: <linux-fsdevel+bounces-26027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C268952AB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686BF1C21596
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0351A76B3;
	Thu, 15 Aug 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PUPXQEIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075D1993BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709303; cv=none; b=pckTyclv4TTqt3+mnR/1vN3fv9uWy81dj+Rv9Nv4WakmX1RyP0UCq7xRdyO29w+kIu+r8s2/Jhm5LOqtWmT/PwfVTghwSfXw2JA7E3YlPIHc0EofTgxeOlr1YWtict2kfk4a1YSOBheLu+QfZF7SNIgZeOG96zgaqLcD4HITxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709303; c=relaxed/simple;
	bh=+Zd7PLS5h6fj7q4S8XQLSecPTF3PKTeEVSECo0mbYNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQIeuQyGb0s5AxLqTBd/MI8sZLS4lbhJAoMt+C8jL78p4c7Be8OUu72aSMfj5VF1bhYSf/7hhBBeYHEuFiQP2rpPMI8E+bihoQrkQ/y31S1MqQGhKN2pBvcOU84BgrNB7L2Uup6LcYKcBAdYl7KSH3hmRT7iICCIpZwqFCBSR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PUPXQEIU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CBB93F162
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 08:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723709298;
	bh=QwzUdLAd7aHB4wJiWgZPpnda9jdXnSJALlxOCLuXUk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PUPXQEIUZTdiF7i9C+IJVWWN4MJ/J1yIe5Wi/XKVYUpxvr6mvIiHnTdC0q0vtdThO
	 ziwKXtXVH7SUvE6vZnf7Rb9w5Dk7zB4lofqezWoqpDskR7Z0gmMJNOY3cIzCKoGu76
	 ebcPmTDu8Q85p0KZbLlE2LP+PN7ArmofulnQZQC9Ud/g5qB5DD91NhtoqyNYoownhC
	 MurAQ9UlnMzOgYICfTdP8S0HZcxkNTWeFvCqVT29zLvGUTfZkVxTjV3/axK1p0l8H6
	 QVDXNvR69vPfLVZtjRkj/8mFrpEf9cDubcxzttUQKw0/HWqZR2CKiOVnMwWfBbngz/
	 Uoef4cMmm44Mg==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4f8adf118e9so279422e0c.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 01:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723709297; x=1724314097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwzUdLAd7aHB4wJiWgZPpnda9jdXnSJALlxOCLuXUk8=;
        b=qjIaLurYXvbs/qyuSDx4zg23TY04wPCSUn5MmB1QV4Lwi7iaORaDtABCgVNxOSO4ar
         US1Lxc0P5JDrzAEwxUTJ7/6NpBW90tCh/aGxa5OfZV2Kl2Q2//qPjMPSPapvr1Xgbf05
         EUBnngklSkJLhGfgNaT7y7rxlVMg+ozv51a4uOoFyxffTU+b811A9vhWh/dEUQPEvYYz
         HT8JV3KnhsjCxxbsxyRlu5F4v/vqh/Vnxd+bElyQ537mvk8Q2/j3uLprhvYEqut+U0gX
         wM49bdB9f2kD3Rbef5ZnWr7oa9C3vsAze43IFxAv0m98wy9ZFGNQkK8Fy/IHhbrItSV8
         jTng==
X-Forwarded-Encrypted: i=1; AJvYcCVup/0VP6OamVlUBg3an8DwBko4FmRdT3oYppRMCSsZGFwGsZZK8ugfJiw07+t+DUSWGUOzkoPfy1w51MUdytYf3s2CaebMyTbxbfxV3g==
X-Gm-Message-State: AOJu0YzwTnyD2i4gD4tjX6BRw8BSCx6zvtekGT+720XKUr7LuFp0aoNH
	evvn8+czgstNj/YFXCuUZlDlP43IZFSzGcYCK5TzID1WjIeUNew6ndGsx7HZxrGvpGeh8NZw+Va
	laF3I6ZZ54Yu+viv1w+Fe0BVLvE1gpc1Rv5Lx+Zls8DpNzcMLPKSnhgpzesaIWUUd6pK3BV1cgH
	V1FXrgVPmL9SIGwD9mS7puMprJzKDECeFe2c8s2CsLRg0bwgdDUT6ODQ==
X-Received: by 2002:a05:6122:3c49:b0:4f6:a85d:38b3 with SMTP id 71dfb90a1353d-4fad2333ecamr6572748e0c.13.1723709296696;
        Thu, 15 Aug 2024 01:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGFGN8CN0DSqDWCPM1VOUm2IQgxthofz228sV9vN9siAmKC/cV/UuZJl2+ATDIB7LSvUrwIx5kTE1n2/k62gk=
X-Received: by 2002:a05:6122:3c49:b0:4f6:a85d:38b3 with SMTP id
 71dfb90a1353d-4fad2333ecamr6572734e0c.13.1723709296323; Thu, 15 Aug 2024
 01:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
 <20240814114034.113953-10-aleksandr.mikhalitsyn@canonical.com> <20240814-knochen-ersparen-9b3f366caac4@brauner>
In-Reply-To: <20240814-knochen-ersparen-9b3f366caac4@brauner>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 15 Aug 2024 10:08:05 +0200
Message-ID: <CAEivzxeQOY6h2AB+eHpnNPAkHMjVoCdOxG99KmkPZx7MVyjhvQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] fs/fuse: allow idmapped mounts
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Aug 14, 2024 at 01:40:34PM GMT, Alexander Mikhalitsyn wrote:
> > Now we have everything in place and we can allow idmapped mounts
> > by setting the FS_ALLOW_IDMAP flag. Notice that real availability
> > of idmapped mounts will depend on the fuse daemon. Fuse daemon
> > have to set FUSE_ALLOW_IDMAP flag in the FUSE_INIT reply.
> >
> > To discuss:
> > - we enable idmapped mounts support only if "default_permissions" mode =
is enabled,
> > because otherwise we would need to deal with UID/GID mappings in the us=
erspace side OR
> > provide the userspace with idmapped req->in.h.uid/req->in.h.gid values =
which is not
> > something that we probably want to. Idmapped mounts phylosophy is not a=
bout faking
> > caller uid/gid.
> >
> > - We have a small offlist discussion with Christian around adding fs_ty=
pe->allow_idmap
> > hook. Christian pointed that it would be nice to have a superblock flag=
 instead like
> > SB_I_NOIDMAP and we can set this flag during mount time if we see that =
filesystem does not
> > support idmappings. But, unfortunately I didn't succeed here because th=
e kernel will
> > know if the filesystem supports idmapping or not after FUSE_INIT reques=
t, but FUSE_INIT request
> > is being sent at the end of mounting process, so mount and superblock w=
ill exist and
> > visible by the userspace in that time. It seems like setting SB_I_NOIDM=
AP flag in this
> > case is too late as user may do the trick with creating a idmapped moun=
t while it wasn't
> > restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive=
" version SB_I_ALLOWIDMAP

Hi Christian,

>
> Hm, I'm confused why won't the following (uncompiled) work?

I believe that your way should work. Sorry about that. It's my bad that I
didn't consider setting SB_I_NOIDMAP in fill_super and unsetting it
later on once
we had enough information.

Huge thanks for pointing this out!

I'll drop -v3 soon and also add support for virtiofs in the same series.

Kind regards,
Alex

>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ed4c2688047f..8ead1cacdd2f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1346,10 +1346,12 @@ static void process_init_reply(struct fuse_mount =
*fm, struct fuse_args *args,
>                         if (flags & FUSE_OWNER_UID_GID_EXT)
>                                 fc->owner_uid_gid_ext =3D 1;
>                         if (flags & FUSE_ALLOW_IDMAP) {
> -                               if (fc->owner_uid_gid_ext && fc->default_=
permissions)
> +                               if (fc->owner_uid_gid_ext && fc->default_=
permissions) {
>                                         fc->allow_idmap =3D 1;
> -                               else
> +                                       fm->sb->s_iflags &=3D ~SB_I_NOIDM=
AP;
> +                               } else {
>                                         ok =3D false;
> +                               }
>                         }
>                 } else {
>                         ra_pages =3D fc->max_read / PAGE_SIZE;
> @@ -1576,6 +1578,7 @@ static void fuse_sb_defaults(struct super_block *sb=
)
>         sb->s_time_gran =3D 1;
>         sb->s_export_op =3D &fuse_export_operations;
>         sb->s_iflags |=3D SB_I_IMA_UNVERIFIABLE_SIGNATURE;
> +       sb->s_iflags |=3D SB_I_NOIDMAP;
>         if (sb->s_user_ns !=3D &init_user_ns)
>                 sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
>         sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 328087a4df8a..d1702285c915 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4436,6 +4436,10 @@ static int can_idmap_mount(const struct mount_katt=
r *kattr, struct mount *mnt)
>         if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
>                 return -EINVAL;
>
> +       /* The filesystem has turned off idmapped mounts. */
> +       if (m->mnt_sb->s_iflags & SB_I_NOIDMAP)
> +               return -EINVAL;
> +
>         /* We're not controlling the superblock. */
>         if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
>                 return -EPERM;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..185004c41a5e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1189,6 +1189,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range=
 expiry */
>  #define SB_I_RETIRED   0x00000800      /* superblock shouldn't be reused=
 */
>  #define SB_I_NOUMASK   0x00001000      /* VFS does not apply umask */
> +#define SB_I_NOIDMAP   0x00002000      /* No idmapped mounts on this sup=
erblock */
>
>  /* Possible states of 'frozen' field */
>  enum {

