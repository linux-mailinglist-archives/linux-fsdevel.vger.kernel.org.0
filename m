Return-Path: <linux-fsdevel+bounces-4330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA877FE932
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 07:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E65281D94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B4020DC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdb8h9U3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B610C6;
	Wed, 29 Nov 2023 22:23:41 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67a34fbaf12so3516906d6.3;
        Wed, 29 Nov 2023 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701325420; x=1701930220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnFNpITeBzIeWAB6/djyDlgB+xngZbEudW6ZwqboSBc=;
        b=Kdb8h9U3zgOhqUkVO0UKU5XITYIl1JWjKJgusWKFxeo3amFzRidVeqxiFGCb/k0MfU
         5+Dc1HsYCqVR2XmJ8DanRXoTHAgRt7qENItT3P9dFyYFG4Of6Z4aUFPDf4i9vXUJyGDE
         2fBRGBHsjVEkFiw8r3GkIg1eWbbPZtPSTCTdVNUJU1q6El+ia4dRQW/X09c91o3KCRNP
         R12z7QViEesfPOymzNoFudYfcfbm64DLx/CrTDK1Rs5W310tM8TzoBUi9/Ic4eYzVUvK
         WPazwsfqb+TCf5jylLFxb72Jt3jZRsfmIE0sP6JAvTkoZOoPVl+nvGI7e7f8GvyqYTQt
         D9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701325420; x=1701930220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnFNpITeBzIeWAB6/djyDlgB+xngZbEudW6ZwqboSBc=;
        b=bcrujGvBcRsAplosPX04RPhaxXaSQ+P0ZW7JRs/cBY8TpWY8H+gDlHUflhdPSiduBX
         MdWyxyLMxWmsJdqp5QTLzDQfSGSiO3zdgQjEeZyE7Lf94l2y/78ovYC5pF1EIfkdThkM
         CUEh2/givZp8uj7s/T+5K31X+uxpprlf64L2/2ib9ci514acigj0fddDglPaotBT9d5v
         rwcGsc8Zvqa2wNLEf/5AKHhHciM3cuuZsNGR5vAkG0oPmWcGMYsr1JNAk2ET5Bz6vpWH
         jLOBbz3SqJqKdJyUKG4IngQgybxY684wl/UZTLkL9wH8Wagq3XLg9dfmGc6ZDSNbicc8
         vH9Q==
X-Gm-Message-State: AOJu0YzLusRmIj1FIz6O2HBM9JDNMcXYFdxGdCPqOmx4sEUa1GCtrsv/
	Ert69UVWoeuiE2THdO54wrTlnzG13sIMpFVEyLOvwCAAEVI=
X-Google-Smtp-Source: AGHT+IH0SyX76kONcdWlvcKAlac9MgRsSZANFwgwnZgOBET2afx9W8YCZCQZK6E4xmMv+OhaN7H7BE0osBZD2D+BqhA=
X-Received: by 2002:ad4:5f0a:0:b0:67a:3967:4b09 with SMTP id
 fo10-20020ad45f0a000000b0067a39674b09mr19186344qvb.8.1701325420254; Wed, 29
 Nov 2023 22:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org> <20231129-idmap-fscap-refactor-v1-12-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-12-da5a26058a5b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 08:23:28 +0200
Message-ID: <CAOQ4uxj=oR+yj19rUm0E6cHTiStniqvebtZSDhV3XZC1qz6n6A@mail.gmail.com>
Subject: Re: [PATCH 12/16] ovl: use vfs_{get,set}_fscaps() for copy-up
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:50=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> Using vfs_{get,set}xattr() for fscaps will be blocked in a future
> commit, so convert ovl to use the new interfaces. Also remove the now
> unused ovl_getxattr_value().
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

You may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I am assuming that this work is destined to be merged via the vfs tree?
Note that there is already a (non-conflicting) patch to copy_up.c on
Christian's vfs.rw branch.

I think it is best that all the overlayfs patches are tested together by
the vfs maintainer in preparation for the 6.8 merge window, so I have
a feeling that the 6.8 overlayfs PR is going to be merged via the vfs tree =
;-)

Thanks,
Amir.

> ---
>  fs/overlayfs/copy_up.c | 72 ++++++++++++++++++++++++++------------------=
------
>  1 file changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 4382881b0709..b43af5ce4b21 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -73,6 +73,23 @@ static int ovl_copy_acl(struct ovl_fs *ofs, const stru=
ct path *path,
>         return err;
>  }
>
> +static int ovl_copy_fscaps(struct ovl_fs *ofs, const struct path *oldpat=
h,
> +                          struct dentry *new)
> +{
> +       struct vfs_caps capability;
> +       int err;
> +
> +       err =3D vfs_get_fscaps(mnt_idmap(oldpath->mnt), oldpath->dentry,
> +                            &capability);
> +       if (err) {
> +               if (err =3D=3D -ENODATA || err =3D=3D -EOPNOTSUPP)
> +                       return 0;
> +               return err;
> +       }
> +
> +       return vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), new, &capability,=
 0);
> +}
> +
>  int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, s=
truct dentry *new)
>  {
>         struct dentry *old =3D oldpath->dentry;
> @@ -130,6 +147,14 @@ int ovl_copy_xattr(struct super_block *sb, const str=
uct path *oldpath, struct de
>                         break;
>                 }
>
> +               if (!strcmp(name, XATTR_NAME_CAPS)) {
> +                       error =3D ovl_copy_fscaps(OVL_FS(sb), oldpath, ne=
w);
> +                       if (!error)
> +                               continue;
> +                       /* fs capabilities must be copied */
> +                       break;
> +               }
> +
>  retry:
>                 size =3D ovl_do_getxattr(oldpath, name, value, value_size=
);
>                 if (size =3D=3D -ERANGE)
> @@ -1006,61 +1031,40 @@ static bool ovl_need_meta_copy_up(struct dentry *=
dentry, umode_t mode,
>         return true;
>  }
>
> -static ssize_t ovl_getxattr_value(const struct path *path, char *name, c=
har **value)
> -{
> -       ssize_t res;
> -       char *buf;
> -
> -       res =3D ovl_do_getxattr(path, name, NULL, 0);
> -       if (res =3D=3D -ENODATA || res =3D=3D -EOPNOTSUPP)
> -               res =3D 0;
> -
> -       if (res > 0) {
> -               buf =3D kzalloc(res, GFP_KERNEL);
> -               if (!buf)
> -                       return -ENOMEM;
> -
> -               res =3D ovl_do_getxattr(path, name, buf, res);
> -               if (res < 0)
> -                       kfree(buf);
> -               else
> -                       *value =3D buf;
> -       }
> -       return res;
> -}
> -
>  /* Copy up data of an inode which was copied up metadata only in the pas=
t. */
>  static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct path upperpath;
>         int err;
> -       char *capability =3D NULL;
> -       ssize_t cap_size;
> +       struct vfs_caps capability;
> +       bool has_capability =3D false;
>
>         ovl_path_upper(c->dentry, &upperpath);
>         if (WARN_ON(upperpath.dentry =3D=3D NULL))
>                 return -EIO;
>
>         if (c->stat.size) {
> -               err =3D cap_size =3D ovl_getxattr_value(&upperpath, XATTR=
_NAME_CAPS,
> -                                                   &capability);
> -               if (cap_size < 0)
> +               err =3D vfs_get_fscaps(mnt_idmap(upperpath.mnt), upperpat=
h.dentry,
> +                                    &capability);
> +               if (!err)
> +                       has_capability =3D 1;
> +               else if (err !=3D -ENODATA && err !=3D EOPNOTSUPP)
>                         goto out;
>         }
>
>         err =3D ovl_copy_up_data(c, &upperpath);
>         if (err)
> -               goto out_free;
> +               goto out;
>
>         /*
>          * Writing to upper file will clear security.capability xattr. We
>          * don't want that to happen for normal copy-up operation.
>          */
>         ovl_start_write(c->dentry);
> -       if (capability) {
> -               err =3D ovl_do_setxattr(ofs, upperpath.dentry, XATTR_NAME=
_CAPS,
> -                                     capability, cap_size, 0);
> +       if (has_capability) {
> +               err =3D vfs_set_fscaps(mnt_idmap(upperpath.mnt), upperpat=
h.dentry,
> +                                    &capability, 0);
>         }
>         if (!err) {
>                 err =3D ovl_removexattr(ofs, upperpath.dentry,
> @@ -1068,13 +1072,11 @@ static int ovl_copy_up_meta_inode_data(struct ovl=
_copy_up_ctx *c)
>         }
>         ovl_end_write(c->dentry);
>         if (err)
> -               goto out_free;
> +               goto out;
>
>         ovl_clear_flag(OVL_HAS_DIGEST, d_inode(c->dentry));
>         ovl_clear_flag(OVL_VERIFIED_DIGEST, d_inode(c->dentry));
>         ovl_set_upperdata(d_inode(c->dentry));
> -out_free:
> -       kfree(capability);
>  out:
>         return err;
>  }
>
> --
> 2.43.0
>

