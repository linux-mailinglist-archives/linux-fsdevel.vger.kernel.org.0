Return-Path: <linux-fsdevel+bounces-5440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D280BC39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 17:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB5FB20A19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572E18B08;
	Sun, 10 Dec 2023 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVL4YL0q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD4F5;
	Sun, 10 Dec 2023 08:42:04 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a948922aaso25526186d6.3;
        Sun, 10 Dec 2023 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702226523; x=1702831323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0lrZcnXtGyQm/QMIPVbNtLua11zuI47QiJurNMFZ1o=;
        b=jVL4YL0qmHRswmEa+HuW3r3TTfypYAf1tKa4jUS6xxD2BFE03NuG3JFj8VLJ+56jWo
         5DV6H1zMsWFfuGITdWK56eTneH1zvXBzzlUSgjgiMKu1V/kc4MhpPyeyhxw5+5risPO/
         IrtK7vzUzS7OHGsHf7H1pj6DvyxopeTxLNmPRuxnTj1llD3pyGZ38hd5/SvDgApRLGhk
         2gksLZVi4A+W1M0dTy1FwTUiO/wXRk4J+yHaszbXq4ZHR3xbcDsqOU+avPcYvG+ge7Ta
         A1bc68it6gM4Ynq7PqMW+Ypiq8a1C0nQBTOdh59jjsR7EtYQwf1tQLhC1jsV86TGeh8z
         s+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702226523; x=1702831323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0lrZcnXtGyQm/QMIPVbNtLua11zuI47QiJurNMFZ1o=;
        b=GDdeU8cJHIIutAY/bkt3H5c2ETZSHNHyCCyxIx2vL64DowKM8/ZWkCxT0L1vEzp7t0
         qhQcR5iIz0fpfOS15zfyK923mRTdwOw5XSiVqtDLWX3N1G8edxDEtt9HcmBP9kRwugCl
         s0ij+bnvtkjrEINAXYdVxfXvfbnBVJsMFC1GRBNcCjIneM3jcqrUqMPShjTDjNzaZMmE
         /mVxTt58mnmuCrHh3an7ZF2zR7Br46cG9rIIvB+HkFRvtGeV6O+v3unsnFhpZhCA8cc2
         nlxeggn3ze8wBbp+pEbUHaslcxosDBsixleK1WZoK40xxYcZSp4Ugd/pu/vxVhOVM5cs
         wXow==
X-Gm-Message-State: AOJu0YzUnZl1DYISCBtWF2+Lvl0rX4kWzJmQHYC+kuarqUSG4LWbnW7Z
	kqhUECLd0vlc3JSyhL+GT3SyTZR5bQMa/aAC5bhkDKD/60A=
X-Google-Smtp-Source: AGHT+IFlVeOQUiWtpd0w0fAcibx30vf9EiQ3pz90L9Uvaz9+6/o+1u7RBzxGVZQrrvAkoWzvQgopyfvAGOsN7T5J4wo=
X-Received: by 2002:a05:6214:17c9:b0:67a:a721:e12d with SMTP id
 cu9-20020a05621417c900b0067aa721e12dmr3567441qvb.90.1702226523168; Sun, 10
 Dec 2023 08:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-9-da5a26058a5b@kernel.org>
 <20231201-reintreten-gehalt-435a960f80ed@brauner> <ZWojWE7/HRnByRb+@do-x1extreme>
 <ZXHZ8uNEg1IK5WMW@do-x1extreme>
In-Reply-To: <ZXHZ8uNEg1IK5WMW@do-x1extreme>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Dec 2023 18:41:52 +0200
Message-ID: <CAOQ4uxhMYPZGQ+ogStYOZYMU+Lvj+2M_HkWF7eFFReb6hDoV_g@mail.gmail.com>
Subject: Re: [PATCH 09/16] fs: add vfs_set_fscaps()
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:43=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> [Adding Mimi for insights on EVM questions]
>
> On Fri, Dec 01, 2023 at 12:18:00PM -0600, Seth Forshee (DigitalOcean) wro=
te:
> > On Fri, Dec 01, 2023 at 06:39:18PM +0100, Christian Brauner wrote:
> > > > +/**
> > > > + * vfs_set_fscaps - set filesystem capabilities
> > > > + * @idmap: idmap of the mount the inode was found from
> > > > + * @dentry: the dentry on which to set filesystem capabilities
> > > > + * @caps: the filesystem capabilities to be written
> > > > + * @flags: setxattr flags to use when writing the capabilities xat=
tr
> > > > + *
> > > > + * This function writes the supplied filesystem capabilities to th=
e dentry.
> > > > + *
> > > > + * Return: 0 on success, a negative errno on error.
> > > > + */
> > > > +int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > +            const struct vfs_caps *caps, int flags)
> > > > +{
> > > > + struct inode *inode =3D d_inode(dentry);
> > > > + struct inode *delegated_inode =3D NULL;
> > > > + struct vfs_ns_cap_data nscaps;
> > > > + int size, error;
> > > > +
> > > > + /*
> > > > +  * Unfortunately EVM wants to have the raw xattr value to compare=
 to
> > > > +  * the on-disk version, so we need to pass the raw xattr to the
> > > > +  * security hooks. But we also want to do security checks before
> > > > +  * breaking leases, so that means a conversion to the raw xattr h=
ere
> > > > +  * which will usually be reduntant with the conversion we do for
> > > > +  * writing the xattr to disk.
> > > > +  */
> > > > + size =3D vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps=
,
> > > > +                          sizeof(nscaps));
> > > > + if (size < 0)
> > > > +         return size;
> > >
> > > Oh right, I remember that. Slight eyeroll. See below though...
> > >
> > > > +
> > > > +retry_deleg:
> > > > + inode_lock(inode);
> > > > +
> > > > + error =3D xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRI=
TE);
> > > > + if (error)
> > > > +         goto out_inode_unlock;
> > > > + error =3D security_inode_setxattr(idmap, dentry, XATTR_NAME_CAPS,=
 &nscaps,
> > > > +                                 size, flags);
> > > > + if (error)
> > > > +         goto out_inode_unlock;
> > >
> > > For posix acls I added dedicated security hooks that take the struct
> > > posix_acl stuff and then plumb that down into the security modules. Y=
ou
> > > could do the same thing here and then just force EVM and others to do
> > > their own conversion from in-kernel to xattr format, instead of forci=
ng
> > > the VFS to do this.
> > >
> > > Because right now we make everyone pay the price all the time when
> > > really EVM should pay that price and this whole unpleasantness.
> >
> > Good point, I'll do that.
>
> I've been reconsidering various approaches here. One thing I noticed is
> that for the non-generic case (iow overlayfs) I missed calling
> security_inode_post_setxattr(), where EVM also wants the raw xattr, so
> that would require another conversion. That got me wondering whether the
> setxattr security hooks really matter when writing fscaps to overlayfs.
> And it seems like they might not: the LSMs only look for their own
> xattrs, and IMA doesn't do anything with fscaps xattrs. EVM does, but
> what it does for a xattr write to an overlayfs indoe seems at least
> partially if not completely redundant with what it will do when the
> xattr is written to the upper filesystem.
>
> So could we push these security calls down to the generic fscaps
> implementations just before/after writing the raw xattr data and just
> skip them for overlayfs? If so we can get away with doing the vfs_caps
> to xattr conversion only once.
>
> The trade offs are that filesystems which implement fscaps inode
> operations become responsible for calling the security hooks if needed,
> and if something changes such that we need to call those security hooks
> for fscaps on overlayfs this solution would no longer work.

Hi Seth,

I was trying to understand the alternative proposals, but TBH,
I cannot wrap my head about overlayfs+IMA/EVM and I do not
fully understand the use case.

Specifically, I do not understand why the IMA/EVM attestation on
the upper and lower fs isn't enough to make overlayfs tamper proof.
I never got an explanation of the threat model for overlayfs+IMA/EVM.

I know that for SELinux and overlayfs a lot of work was done by Vivek.
I was not involved in this work, but AKAIF, it did not involve any conversi=
on
of selinux xattrs.

Thanks,
Amir.

