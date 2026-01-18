Return-Path: <linux-fsdevel+bounces-74298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18125D392D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EADA930136E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 04:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C531328B;
	Sun, 18 Jan 2026 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfCGJNlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB78286D53
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712229; cv=none; b=RZRnHBdoMO5WYfWDT9nhM6AaYimjWIdvDHoCuXvTVY3n5m/5drFuPj/jmjE988ojYmDyETYnEesDoVfS72yNe9KMn1wfr7U6f7ffBgfXYJp3guFUOcPkjd0dRMB43iVkwkzxUWW35XdWnUDQfZT+6Fqptc0oRV8QFDdGe9nivik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712229; c=relaxed/simple;
	bh=KHsof9UAxrVhNudEZwlfmHLYXYcs9D9cvCRfw1S5AJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb55dDLyYtKaBMoz9Mo/r2iM5ESJi6SuFGhRbBmPzIOwY18ketzGbXwcgdN3rnHTGvMsOd5zvVdeToiebDSvRE99LYiylbP8cK4Iel1rNYs4AF8mM1cXQRatx0P8pbVL0lU2GDZx4LlBzVkLfF3dK41qdrffzAV6sXM4DT5RLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfCGJNlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8DCC2BCB6
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 04:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712229;
	bh=KHsof9UAxrVhNudEZwlfmHLYXYcs9D9cvCRfw1S5AJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rfCGJNljvcNZpJyN/XOiytmmj21g8Ta6D/T3y+zCKJ2A3I8Cl4Nf+svg62nOiAPMq
	 8Qb0Q16DHvrKt49VrpWqkJqOSQ0bhBRg5/3Y0XsEaAamlkxZYjtD5XBAEOueUYOukT
	 lJel21NqUGbf6cLM5Ysonmzgdg7FhynObcdm0pCaW9WWXvXIhSMUQV9pdrPrvd3Rnz
	 IBlamLOoPUNtYALmXynmxwXaMrsk+vUzuZhfU22F5ft/QGEDrA7gfDOKBmE4V/HSpB
	 r7BtMIUe4tcszAFx17Of45wdijGaAPvKMTV0pUqXh7+cyECV1hqG60c7J99N1+kUtS
	 LGflcZ0gz5cgg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so5012582a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 20:57:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWefmy8h4RCB9yy3FaEdUNndkicpECYjZy09qAw7FYSToXT9pSYG+711oAXtrgY9xK+oy49d4G4GP4p4Fe5@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHrfREXruySiJMjYOnIhQkmKuU4u8bWInX9xtX0Y8IhqryEj8
	rCIYlLYrRYpDDFMqNEUs+aVPBXpf0vjFjCh7qxRqhUIonYmCdTTYQ9RZa7EeQ2f4B/ulgXsNyGF
	ykWjG6qPwh8CHR4jmBf3hANI5Sf0azxw=
X-Received: by 2002:a05:6402:5208:b0:647:54ba:6c42 with SMTP id
 4fb4d7f45d1cf-654524d1c93mr5943497a12.4.1768712227837; Sat, 17 Jan 2026
 20:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-7-linkinjeon@kernel.org>
 <20260116085359.GD15119@lst.de>
In-Reply-To: <20260116085359.GD15119@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 13:56:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_RoJi5HqQV2NPvmkOTrx9AbSbuCmi=BKieENcLVW0FZg@mail.gmail.com>
X-Gm-Features: AZwV_QhqVNkex3dmwsLBp_KDn8BtY4_HfLnXfqd1ShNpd--wjBv0XC2JRWjfsHU
Message-ID: <CAKYAXd_RoJi5HqQV2NPvmkOTrx9AbSbuCmi=BKieENcLVW0FZg@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] ntfs: update file operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 11, 2026 at 11:03:36PM +0900, Namjae Jeon wrote:
> >  /**
> > + * ntfs_setattr - called from notify_change() when an attribute is bei=
ng changed
> > + * @idmap:   idmap of the mount the inode was found from
> > + * @dentry:  dentry whose attributes to change
> > + * @attr:    structure describing the attributes and the changes
> >   *
> > + * We have to trap VFS attempts to truncate the file described by @den=
try as
> > + * soon as possible, because we do not implement changes in i_size yet=
.  So we
> > + * abort all i_size changes here.
> >   *
> > + * We also abort all changes of user, group, and mode as we do not imp=
lement
> > + * the NTFS ACLs yet.
>
> This comment isn't actually true, is it?  Also having kerneldoc comments
> for something that implements VFS methods isn't generally very useful,
> they should have their API documentation in the VFS documentation.  You
> can comment anything special in a normal code comment if it applies.
Right. Those comments were outdated carryovers and no longer reflect
the current implementation.
I will update them.
>
> > +     if (ia_valid & ATTR_SIZE) {
> > +             if (NInoCompressed(ni) || NInoEncrypted(ni)) {
> > +                     ntfs_warning(vi->i_sb,
> > +                                  "Changes in inode size are not suppo=
rted yet for %s files, ignoring.",
> > +                                  NInoCompressed(ni) ? "compressed" : =
"encrypted");
> > +                     err =3D -EOPNOTSUPP;
>
> This is still quite a limitation.  But I also think you need a goto
> to exit early here instead allowing the other attribute changes to
> be applied?
Right. I missed the early exit there. I will fix it.
>
> Also experience from other file systems suggests splitting the ATTR_SIZE
> handling into a separate helper tends to really help structuring the
> code in general.
Okay, I will check it.
>
> > +int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> > +             struct kstat *stat, unsigned int request_mask,
> > +             unsigned int query_flags)
> >  {
>
> Can you add support DIO alignment reporting here?  Especially with
> things like compressed files this would be very useful.
Okay. I will add it.

>
> > +static loff_t ntfs_file_llseek(struct file *file, loff_t offset, int w=
hence)
> >  {
> > +     struct inode *vi =3D file->f_mapping->host;
> > +
> > +     if (whence =3D=3D SEEK_DATA || whence =3D=3D SEEK_HOLE) {
>
> I'd stick to the structure of the XFS and ext4 llseek implementation
> here and switch on whence and call the fitting helpers as needed.
Okay.
>
> Talking about helpers, why does iomap_seek_hole/iomap_seek_data
> not work for ntfs?
Regarding iomap_seek_hole/iomap_seek_data, the default iomap
implementation treats IOMAP_UNWRITTEN extents as holes unless they
have dirty pages in the page cache. However, in ntfs iomap begin, the
region between initialized_size and i_size (EOF) is mapped as
IOMAP_UNWRITTEN. Since NTFS requires any pre-allocated regions before
initialized_size to be physically zeroed, NTFS must treat all
pre-allocated regions as DATA.

>
> > +             file_accessed(iocb->ki_filp);
> > +             ret =3D iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, NULL=
, IOMAP_DIO_PARTIAL,
>
> Why do you need IOMAP_DIO_PARTIAL?  That's mostly a workaround
> for "interesting" locking in btrfs and gfs2.  If ntfs has similar
> issues, it would be helpful to add a comment here.  Also maybe fix
> the overly long line.
Regarding the use of IOMAP_DIO_PARTIAL, I was not aware that it was a
workaround for specific locking issues in some filesystems. I
incorrectly assumed it was a flag to enable partial success when a DIO
request exceeds the actual data length. I will remove this flags and
fix it.
>
> > +     if (NInoNonResident(ni) && (iocb->ki_flags & IOCB_DIRECT) &&
> > +         ((iocb->ki_pos | ret) & (vi->i_sb->s_blocksize - 1))) {
> > +             ret =3D -EINVAL;
> > +             goto out_lock;
> > +     }
>
> iomap_dio_rw now has a IOMAP_DIO_FSBLOCK_ALIGNED to do these
> checks.  Also please throw in a comment why ntrfs needs fsblock
> alignment.
Okay.
>
> > +     if (iocb->ki_pos + ret > old_data_size) {
> > +             mutex_lock(&ni->mrec_lock);
> > +             if (!NInoCompressed(ni) && iocb->ki_pos + ret > ni->alloc=
ated_size &&
> > +                 iocb->ki_pos + ret < ni->allocated_size + vol->preall=
ocated_size)
> > +                     ret =3D ntfs_attr_expand(ni, iocb->ki_pos + ret,
> > +                                     ni->allocated_size + vol->preallo=
cated_size);
> > +             else if (NInoCompressed(ni) && iocb->ki_pos + ret > ni->a=
llocated_size)
> > +                     ret =3D ntfs_attr_expand(ni, iocb->ki_pos + ret,
> > +                             round_up(iocb->ki_pos + ret, ni->itype.co=
mpressed.block_size));
> > +             else
> > +                     ret =3D ntfs_attr_expand(ni, iocb->ki_pos + ret, =
0);
> > +             mutex_unlock(&ni->mrec_lock);
> > +             if (ret < 0)
> > +                     goto out;
> > +     }
>
> What is the reason to do the expansion here instead of in the iomap_begin
> handler when we know we are committed to write to range?
We can probably move it to iomap_begin(). Let me check it.
>
> > +     if (NInoNonResident(ni) && iocb->ki_flags & IOCB_DIRECT) {
>
> Mayube split this direct I/O branch which is quite huge into a separate
> helper, similar to what a lof of other file systems are doing?
Okay, I will split it.
>
> >       }
> > +out:
> > +     if (ret < 0 && ret !=3D -EIOCBQUEUED) {
> > +out_err:
> > +             if (ni->initialized_size !=3D old_init_size) {
> > +                     mutex_lock(&ni->mrec_lock);
> > +                     ntfs_attr_set_initialized_size(ni, old_init_size)=
;
> > +                     mutex_unlock(&ni->mrec_lock);
> > +             }
> > +             if (ni->data_size !=3D old_data_size) {
> > +                     truncate_setsize(vi, old_data_size);
> > +                     ntfs_attr_truncate(ni, old_data_size);
> > +             }
>
> Don't you also need to this in dio I/O completion handler for async
> writes?  (actually I guess they aren't supported, I'll try to find the
> code for that).
I will check it.
>
> > +static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
> >  {
> > +     vm_fault_t ret;
> > +
> > +     if (unlikely(IS_IMMUTABLE(inode)))
> > +             return VM_FAULT_SIGBUS;
>
> I don't think the VM ever allows write faults on files not opened for
> writing, which can't be done for IS_IMMUTABLE files.  If you could ever
> hit this we have a huge problem in the upper layers that needs fixing.
Okay, I will remove this.
>
> > +static int ntfs_ioctl_fitrim(struct ntfs_volume *vol, unsigned long ar=
g)
> > +{
> > +     struct fstrim_range __user *user_range;
> > +     struct fstrim_range range;
> > +     struct block_device *dev;
> >       int err;
> >
> > +static long ntfs_fallocate(struct file *file, int mode, loff_t offset,=
 loff_t len)
> >  {
> > +     struct inode *vi =3D file_inode(file);
> > +     struct ntfs_inode *ni =3D NTFS_I(vi);
> > +     struct ntfs_volume *vol =3D ni->vol;
> > +     int err =3D 0;
> > +     loff_t end_offset =3D offset + len;
> > +     loff_t old_size, new_size;
> > +     s64 start_vcn, end_vcn;
> > +     bool map_locked =3D false;
> > +
> > +     if (!S_ISREG(vi->i_mode))
> > +             return -EOPNOTSUPP;
>
> ntfs_fallocate is only wired up in ntfs_file_ops, so this can't
> happen.
Right, I will remove it.
>
> > +     inode_dio_wait(vi);
> > +     if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
> > +                 FALLOC_FL_INSERT_RANGE)) {
> > +             filemap_invalidate_lock(vi->i_mapping);
> > +             map_locked =3D true;
> > +     }
> > +
> > +     if (mode & FALLOC_FL_INSERT_RANGE) {
>
> This would benefit a lot from being structured like __xfs_file_fallocate,
> that is switch on mode & FALLOC_FL_MODE_MASK for the operation, and
> then have a helper for each separate operation type.  The current
> huge function is pretty unreadable.
Okay, I will update them.
Thanks for the review!
>

