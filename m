Return-Path: <linux-fsdevel+bounces-4328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD787FE930
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 07:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947ACB20BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7A20DC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyEPCNIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D915D66;
	Wed, 29 Nov 2023 21:57:01 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso488380276.0;
        Wed, 29 Nov 2023 21:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701323820; x=1701928620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF8N/2yS25qYTNVl+4j2ofGodrDaTnRxmm0b0qi+LJg=;
        b=GyEPCNIkfCrVtPfpybXJsAUGRGIy3NyygwLB75dQXpXiVW+ZHWrerPwDNZ4gvV/jyY
         9EBg8ncoKM4xpW2PA992fTauBXdIAEUbFMXd2cK3z7SWpSVV5jscRbojGQUQRYP802Sb
         QHrDIvCV9NN+15DOds51719EXSKuOQdb1DDTjjt3B25MK9pjt3PLgMvSpc3Y8Xsg520b
         VlFIQ4QuKJmRsMqPjZzwz+PzGPy2j2Au98wVFnqKXugxLjfg74GUAwb06LY1TRXUttic
         0XFlfGuUmk2c2JdVDp6MYXXXddyjErIz15QjJDu6Xfo3OdszqHvmzIA08jGKx1yYUoe2
         5iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701323820; x=1701928620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF8N/2yS25qYTNVl+4j2ofGodrDaTnRxmm0b0qi+LJg=;
        b=eXepIV+XoeUBX834ob8uRN7TOyEZpXiuzFcGxaEaetU6JBz3nXb5rwPqFlnUmYBnoK
         9ixTe3sc68L5t5m1eF1IW1IPT4U4bbxZoY/wMoKcMrJHSQTBiMCu0Y6hwUYnPlkzx5Sm
         /utcpPvS9/RLUluNkYDnlt9vYxV85d3F0MMiBqYpvf9qHL1h0lySsZfdMRUsFNgXvOHO
         FKzNl6xMPy8Ryd3TecX3blW+BRZnAWLN+fUCJjMJfUnO5m834fiUBWhxQt4aHJAtgav1
         7ITgOctjLHPsZnReAV+xBc4pJjIUkIMdPIRC36n4bna3z6iSP6qhH8BNJF16N/nk4Llf
         aVqQ==
X-Gm-Message-State: AOJu0YwybkOW4sYZkOG9sgmQ9xQ2GOg8dpj+FOiR7zLDi8xjGt+7HWrc
	KPaDvj8BwLGPohw5tDXPXscGsKWrAWbx4gJ74oE=
X-Google-Smtp-Source: AGHT+IE1W4dIMG85oHdeYgswusiIVWFXWfINBgm6GLnZIjcG9hrhOMko1QbmRyxotrxVka0zxkkS8KyVu1cDW0z5LjI=
X-Received: by 2002:a25:ad19:0:b0:db4:5e40:c1f with SMTP id
 y25-20020a25ad19000000b00db45e400c1fmr18114203ybi.41.1701323820273; Wed, 29
 Nov 2023 21:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org> <20231129-idmap-fscap-refactor-v1-11-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-11-da5a26058a5b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 07:56:48 +0200
Message-ID: <CAOQ4uxiuFmvaA6yd59WMGxWAGKc6JBono3oNp4XndYcfWVhUxw@mail.gmail.com>
Subject: Re: [PATCH 11/16] ovl: add fscaps handlers
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
> Add handlers which read fs caps from the lower or upper filesystem and
> write/remove fs caps to the upper filesystem, performing copy-up as
> necessary.
>
> While it doesn't make sense to use fscaps on directories, nothing in the
> kernel actually prevents setting or getting fscaps xattrs for directory
> inodes. If we omit fscaps handlers in ovl_dir_inode_operations then the
> generic handlers will be used. These handlers will use the xattr inode
> operations, bypassing any idmapping on lower mounts, so fscaps handlers
> are also installed for ovl_dir_inode_operations.
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/overlayfs/dir.c       |  3 ++
>  fs/overlayfs/inode.c     | 84 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/overlayfs/overlayfs.h |  6 ++++
>  3 files changed, 93 insertions(+)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index aab3f5d93556..d9ab3c9ce10a 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1303,6 +1303,9 @@ const struct inode_operations ovl_dir_inode_operati=
ons =3D {
>         .get_inode_acl  =3D ovl_get_inode_acl,
>         .get_acl        =3D ovl_get_acl,
>         .set_acl        =3D ovl_set_acl,
> +       .get_fscaps     =3D ovl_get_fscaps,
> +       .set_fscaps     =3D ovl_set_fscaps,
> +       .remove_fscaps  =3D ovl_remove_fscaps,
>         .update_time    =3D ovl_update_time,
>         .fileattr_get   =3D ovl_fileattr_get,
>         .fileattr_set   =3D ovl_fileattr_set,
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index c63b31a460be..82fc6e479d45 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -568,6 +568,87 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dent=
ry *dentry,
>  }
>  #endif
>
> +int ovl_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +                  struct vfs_caps *caps)
> +{
> +       int err;
> +       const struct cred *old_cred;
> +       struct path realpath;
> +
> +       ovl_path_real(dentry, &realpath);
> +       old_cred =3D ovl_override_creds(dentry->d_sb);
> +       err =3D vfs_get_fscaps(mnt_idmap(realpath.mnt), realpath.dentry, =
caps);
> +       revert_creds(old_cred);
> +       return err;
> +}
> +
> +int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +                  const struct vfs_caps *caps, int flags)
> +{
> +       int err;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> +       struct dentry *upperdentry =3D ovl_dentry_upper(dentry);
> +       struct dentry *realdentry =3D upperdentry ?: ovl_dentry_lower(den=
try);
> +       const struct cred *old_cred;
> +
> +       err =3D ovl_want_write(dentry);
> +       if (err)
> +               goto out;
> +
> +       if (!upperdentry) {
> +               err =3D ovl_copy_up(dentry);
> +               if (err)
> +                       goto out_drop_write;
> +
> +               realdentry =3D ovl_dentry_upper(dentry);
> +       }
> +
> +       old_cred =3D ovl_override_creds(dentry->d_sb);
> +       err =3D vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), realdentry, caps=
, flags);
> +       revert_creds(old_cred);
> +
> +       /* copy c/mtime */
> +       ovl_copyattr(d_inode(dentry));
> +
> +out_drop_write:
> +       ovl_drop_write(dentry);
> +out:
> +       return err;
> +}
> +
> +int ovl_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +       int err;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> +       struct dentry *upperdentry =3D ovl_dentry_upper(dentry);
> +       struct dentry *realdentry =3D upperdentry ?: ovl_dentry_lower(den=
try);
> +       const struct cred *old_cred;
> +
> +       err =3D ovl_want_write(dentry);
> +       if (err)
> +               goto out;
> +
> +       if (!upperdentry) {
> +               err =3D ovl_copy_up(dentry);
> +               if (err)
> +                       goto out_drop_write;
> +
> +               realdentry =3D ovl_dentry_upper(dentry);
> +       }
> +

This construct is peculiar.
Most of the operations just do this unconditionally:

err =3D ovl_copy_up(dentry);
if (err)
        goto out_drop_write;

and then use ovl_dentry_upper(dentry) directly, because a modification
will always be done on the upper dentry, regardless of the state before
the operation started.

I was wondering where you copied this from and I found it right above
in ovl_set_or_remove_acl().
In that case, there was also no justification for this construct.

There is also no justification for open coding:
   struct dentry *realdentry =3D upperdentry ?: ovl_dentry_lower(dentry);
when later on, ovl_path_lower(dentry, &realpath) is called anyway.

The only reason to do anything special in ovl_set_or_remove_acl() is:

        /*
         * If ACL is to be removed from a lower file, check if it exists in
         * the first place before copying it up.
         */

Do you not want to do the same for ovl_remove_fscaps()?

Also, the comparison to remove_acl API bares the question,
why did you need to add a separate method for remove_fscaps?
Why not use set_fscaps(NULL), just like setxattr() and set_acl() APIs?

Thanks,
Amir.

