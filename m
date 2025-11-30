Return-Path: <linux-fsdevel+bounces-70282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4053C95483
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF7F4E06A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F52C21DB;
	Sun, 30 Nov 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Tdi5FGDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828532C15A6
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764534878; cv=none; b=bRqWcKdlL0MEhqRbWxyGW+TcqJNNMwxUSXB3NvycpxnNRatQBh5Cb5Zy1Bh0lehr7hgooT5iR3KVrLsZQMAGRfIyoXdQ4ApLYsEBE4SJsZ+t04pml5wT8i4xXxeKJdGRLLtmdW1yJgE5ykI0+ym5nWyPRKHVGayPeZv4MTBhOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764534878; c=relaxed/simple;
	bh=xro5UKYy0RNzL2qpVpF3XVNttjBTY3SWgP1GzpnBxyo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AiHbtRkVII+cxAYCn3rSejMsBSUUQ+KLnkjImQk64eTdVBR79/FO3vafzntWxifx42Ch5j54wsZHnxZJ87BztGXKVzC/ulwhsE28yn62QvfSn3X0mwp/zcaTVW13vMSTaXXDo5Vg0GsS+Vn6QMSnPlkjC5Dy5idIcFVSPvvfTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Tdi5FGDo; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 781b5565-ce2c-11f0-9e68-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 781b5565-ce2c-11f0-9e68-005056994fde;
	Sun, 30 Nov 2025 21:38:03 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f6ea55d5-ce2b-11f0-83ca-00505699891e;
	Sun, 30 Nov 2025 21:34:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=dpEdZTgrTK01HOPuVCxKo1agm0EEBzAi08O/K5qLJlw=;
	b=Tdi5FGDo2+MUGWldisAQtP0ngJdzMGQDlrw71FnNbHsL3lr9LQ+PIdNjP1jg1AER45RL80UQKZ61r
	 LGXii6+ci/PtZxvaGVD690jDcx2TjZz6LS1MJBGyHR7+wXUPhv2tZ7y/m+38QQlFuoJyO6q7d3fpIA
	 QqJmZbZpGdHYUDgzC5EiYRy0KxVvTnTErIlxdIsga8B4TEaRwNofBscFADGJeWO2DTyOyCDRYqxjkR
	 D5jnOd8QCW5Ik9P0Fh2ptB4lqSQOwkc+dYXDrmSrq/dX6cuBPv/zUia48ilNSa1ToA6s8nSseFFan8
	 RKPzZiCx6bD5/d2fCRiA5MJnVW+BwVQ==
X-KPN-MID: 33|EF+LAFmvFd0OVc24SSFECi3zav45PsBz7QHc4xahRfHqE8Zq8UJ0OIYKZ7iNd+J
 /RuU1nvw0hKlqZV7NjPKFJxbP8hdoCQSAz7IzYHHbaCo=
X-CMASSUN: 33|CiTcFiW5380r3pXr3ugXjKmOmyg/44DC1StAF1R6sRYDJEXewHV9PMd/ub4PiUY
 sfd0ClA2yA4VkuXKzvulpew==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f6d98db6-ce2b-11f0-94b1-00505699eff2;
	Sun, 30 Nov 2025 21:34:26 +0100 (CET)
Date: Sun, 30 Nov 2025 21:34:26 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
 <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Message-ID: <299926848.3375545.1764534866882@kpc.webmail.kpnmail.nl>
In-Reply-To: <18cf065cbc331fd2f287c4baece3a33cd1447ef6.camel@ibm.com>
References: <20251125211329.2835801-1-jkoolstra@xs4all.nl>
 <18cf065cbc331fd2f287c4baece3a33cd1447ef6.camel@ibm.com>
Subject: Re: [PATCH v2] hfs: replace BUG_ONs with error handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal

Hi Viachslav,

Thanks for your time to write such a detailed answer. Your comments are ver=
y useful
to someone like me starting out in the linux kernel. I really appreciate it=
.

> > @@ -264,9 +264,9 @@ static int hfs_remove(struct inode *dir, struct den=
try *dentry)
> >  =09=09return res;
> >  =09clear_nlink(inode);
> >  =09inode_set_ctime_current(inode);
> > -=09hfs_delete_inode(inode);
> > +=09res =3D hfs_delete_inode(inode);
> >  =09mark_inode_dirty(inode);
> > -=09return 0;
> > +=09return res;
>=20
> This modification doesn't look good, frankly speaking. The hfs_delete_ino=
de()
> will return error code pretty at the beginning of execution. So, it doesn=
't make
> sense to call mark_inode_dirty() then. However, we already did a lot of a=
ctivity
> before hfs_delete_inode() call:
>=20
> static int hfs_remove(struct inode *dir, struct dentry *dentry)
> {
> =09struct inode *inode =3D d_inode(dentry);
> =09int res;
>=20
> =09if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
> =09=09return -ENOTEMPTY;
> =09res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
> =09if (res)
> =09=09return res;
> =09clear_nlink(inode);
> =09inode_set_ctime_current(inode);
> =09hfs_delete_inode(inode);
> =09mark_inode_dirty(inode);
> =09return 0;
> }
>=20
> So, not full executing of hfs_delete_inode() makes situation really bad.
> Because, we deleted record from Catalog File but rejected of execution of
> hfs_delete_inode() functionality.
>=20
> I am thinking that, maybe, better course of action is to check HFS_SB(sb)=
-
> >folder_count and HFS_SB(sb)->file_count at the beginning of hfs_remove()=
:
>=20
> static int hfs_remove(struct inode *dir, struct dentry *dentry)
> {
> =09struct inode *inode =3D d_inode(dentry);
> =09int res;
>=20
> =09if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
> =09=09return -ENOTEMPTY;
>=20
> <<-- Check it here and return error
>=20
> =09res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
> =09if (res)
> =09=09return res;
> =09clear_nlink(inode);
> =09inode_set_ctime_current(inode);
> =09hfs_delete_inode(inode);
> =09mark_inode_dirty(inode);
> =09return 0;
> }
>=20

That sounds good. But maybe we should do the check even before the ENOTEMPT=
Y check,
as corruption detection is perhaps more interesting than informing that the=
 operation
cannot complete because of some other (less acute) reason.

> In such case, we reject to make the removal, to return error and no activ=
ity
> will happened. Let's move the check from hfs_delete_inode() to hfs_remove=
(). We
> can ignore hfs_create() [1] and hfs_mkdir() [2] because these methods sim=
ply
> processing erroneous situation.
>=20

One thing we can also do is what happens in ext4. We introduce an errors=3D=
 mount option
which can be set to readonly, panic, or continue depending on the desired b=
ehavior in
case of serious error (like corruption). I already implemented this for min=
ix fs, and
the patch was fine. However, the people responsible for minix felt that it =
was more
sensible to deprecate minix and write a FUSE driver for it. [1]

> > +#define EFSCORRUPTED=09EUCLEAN=09=09/* Filesystem is corrupted */
>=20
> I don't think that rename existing error code is good idea. Especially, b=
ecause
> we will not need the newly introduce error code's name. Please, see my co=
mments
> below.
>=20

For context, I took this from ext4.

> > --- a/fs/hfs/inode.c
> > +++ b/fs/hfs/inode.c
> > @@ -186,16 +186,22 @@ struct inode *hfs_new_inode(struct inode *dir, co=
nst struct qstr *name, umode_t
> >  =09s64 next_id;
> >  =09s64 file_count;
> >  =09s64 folder_count;
> > +=09int err =3D -ENOMEM;
> > =20
> >  =09if (!inode)
> > -=09=09return NULL;
> > +=09=09goto out_err;
> > +
> > +=09err =3D -EFSCORRUPTED;
>=20
> In 99% of cases, this logic will be called for file system internal logic=
 when
> mount was successful. So, file system volume is not corrupted. Even if we
> suspect that volume is corrupted, then potential reason could be failed r=
ead (-
> EIO). It needs to run FSCK tool to be sure that volume is really corrupte=
d.
>=20

I get your point, maybe just warn for possible corruption?

> > =20
> >  =09mutex_init(&HFS_I(inode)->extents_lock);
> >  =09INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
> >  =09spin_lock_init(&HFS_I(inode)->open_dir_lock);
> >  =09hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_i=
no, name);
> >  =09next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
> > -=09BUG_ON(next_id > U32_MAX);
> > +=09if (next_id > U32_MAX) {
> > +=09=09pr_err("next CNID exceeds limit =E2=80=94 filesystem corrupted. =
It is recommended to run fsck\n");
>=20
> File system volume is not corrupted here. Because, it is only error of fi=
le
> system logic. And we will not store this not correct number to the volume=
,
> anyway. At minimum, we should protect the logic from doing this. And it d=
oesn't
> need to recommend to run FSCK tool here.

What if e.g. next_id is not U32_MAX, but some other slightly smaller value,=
 that's still
not possible, correct? And then we find out not at mount time (at least not=
 right now).
Maybe we should just check at mount time and when the mdb is written if the=
 values like
file/folder_count and next_id make any sense. I think they indicate corrupt=
ion even for
much smaller values than U32_MAX, but I could not really distill that.

If we have this, then the other BUG_ONs should not indicate corruption but =
implementation
logic issues. Correct?

>=20
> Probably, it makes sense to decrement erroneous back.
>=20
> Potentially, if we have such situation, maybe, it makes sense to consider=
 to
> make file system READ-ONLY. But I am not fully sure.
>=20

See my comment above.

Thanks,
Jori.

[1] https://lkml.org/lkml/2025/10/28/1786

