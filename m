Return-Path: <linux-fsdevel+bounces-74296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DABD392CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABAE0301516C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 04:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE62EAB61;
	Sun, 18 Jan 2026 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEhSwYsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76723EA92
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712062; cv=none; b=lijESVAIA8HFvLYCSoru470yz14DqHMcrLKNwc37Xxj0giAjeEWjMJmCMSsFkqt+F+IXtZhTCPIzVJ8qDiRewsME3CMO1BWxoTOm12UlBKaW7bt8JOfmD8yLnQmFaQC+y7+L+nZO56z01Zyg9RzCcEpycjRwxX2Ka1SAZjK2nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712062; c=relaxed/simple;
	bh=56tlQLHc7Abm6d5SMyel8R8m/+tAQ/McB8/0EqZh1zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRknD9kR57qwXF3nm2YLBy+sGWNDKjHsFmz0feD0LV0SBGWads3LF1D6xsy/hZ2pJYuwMTDNuR860KG6mwL6EtAKoXf8awQsWOWRfVOi2jHVxxKXQtD+Ivl7F+hYV5CN4ppThiaH4xCdOmTfxF2B+lYg28hk85ypaOHx+Yb9n0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEhSwYsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8902FC19425
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 04:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712061;
	bh=56tlQLHc7Abm6d5SMyel8R8m/+tAQ/McB8/0EqZh1zw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KEhSwYsMGC+XmuNLvG/ZeculruOgrJ2I/IJcoIqqa1lTZn7KCv3vd0hZyg0vJicHt
	 jXhEI2Q0qVJQwk1/3qTG8ZDlB+KggYKyTGJBhPlX4dJlNRpOw0pKsWEryTwJhKfcA3
	 G4pryIUK9/1yvgsjrodFGEaOExMb0JjChxnd30Ap1Q0BUEeLb++kvbRyLwo9v2Twlp
	 nPhG+xdLOG55Q98WRW6Fmf+nVacgH2p3SD27pwvUkYrt9+eT0ryeVvOXGdcozw8/ge
	 NRhAhuFl51hnI7ZQCwjI8TheP62MO/bNQAc7durSD6vICRlIoJkMpxTDpl7bdVpREh
	 prEY6Icjb/jgw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so5519881a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 20:54:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUVA+g5stIfr01lamskJcGhD1Wi/BbDUGP5wMG8PCOJMvQ5cnBIo9r7RJY6fWVaNPGB+qQXup5Z7C9JOKg@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgdYqLBDdpuLMl82rv+rAddXeTwUd/Hk/12v79NDagRDFKfvz
	ubpeXzuXZSJwJo1JwaGrIPftxHWQRqYsb39B0AByVgUO4xdqA1VYjECVGCjjzaakVE+AMryS5kb
	8Mw1Dm6dNz66WRadM3MhDhnPC4RSgob8=
X-Received: by 2002:a05:6402:510b:b0:64d:4e22:1fda with SMTP id
 4fb4d7f45d1cf-65452cd8c70mr5638426a12.30.1768712060063; Sat, 17 Jan 2026
 20:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-3-linkinjeon@kernel.org>
 <20260116082352.GB15119@lst.de>
In-Reply-To: <20260116082352.GB15119@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 13:54:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9SeJYhBOOK6rZ+0c4G42wvFZkjJ9vGnSrythsz55WLwA@mail.gmail.com>
X-Gm-Features: AZwV_Qi3BCexNw5FGofgpbBcCwJ3O8NV0W7cOfO6HZDO6rvdRZBK67Cav0KF0bk
Message-ID: <CAKYAXd9SeJYhBOOK6rZ+0c4G42wvFZkjJ9vGnSrythsz55WLwA@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] ntfs: update in-memory, on-disk structures and headers
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:23=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 11, 2026 at 11:03:32PM +0900, Namjae Jeon wrote:
> > This updates in-memory, on-disk structures, headers and documentation.
>
> A little bit of a description of what is updated would be very
> useful.  In fact to review all of the patches except for the first
> and the last three would probably easier at least as far as the actual
> code is concerned (documentation makes sence to be standalone obviously).
Okay.
>
> Anyway, I'll chime in here with a few random bits, mostly cosmetic:
Okay, Thanks.
>
> > +The new ntfs is an implementation that supports write and the current
> > +trends(iomap, no buffer-head) based on read-only classic NTFS.
> >
> > +The old read-only ntfs code is much cleaner, with extensive comments,
> > +offers readability that makes understanding NTFS easier.
> > +The target is to provide current trends(iomap, no buffer head, folio),
> > +enhanced performance, stable maintenance, utility support including fs=
ck.
>
> All of this makes sense in a commit message, but not really in persistent
> documentation, where all of this, including the "new" gets stale very
> quickly.  Also please add a whitespace before the opening brace.
Okay.
>
> > +- Write support:
> > +   Implement write support on classic read-only NTFS. Additionally,
> > +   integrate delayed allocation to enhance write performance through
> > +   multi-cluster allocation and minimized fragmentation of cluster bit=
map.
>
> I'd drop the comparisons with classic NTFS, future readers will barely
> have any idea what this is about.
Okay.
>
> > +
> > +- Switch to using iomap:
> > +   Use iomap for buffered IO writes, reads, direct IO, file extent map=
ping,
> > +   readpages, writepages operations.
> > +
> > +- Stop using the buffer head:
> > +   The use of buffer head in old ntfs and switched to use folio instea=
d.
> > +   As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig=
.
> > +
> > +- Performance Enhancements:
> > +  write, file list browsing, mount performance are improved with
> > +  the following.
>
> ...
>
> > +- Stability improvement:
>
> ...
>
> Similarly, all this is commit message information, not really
> for persistent documentation in the source tree.
Okay.
>
> > - * attrib.h - Defines for attribute handling in NTFS Linux kernel driv=
er.
> > - *         Part of the Linux-NTFS project.
> > + * Defines for attribute handling in NTFS Linux kernel driver.
> > + * Part of the Linux-NTFS project.
>
> Does the Linux-NTFS project still exists, and in what form is this
> part of it?  Sorry for the sneaky question, but that statement feels
> a bit weird here.
The Linux-NTFS project appears to have been discontinued long ago. I
checked the project's mailing list and found no activity. And that
line is a carryover from older headers and is no longer relevant as
this is a new implementation. I will remove the reference to the
'Linux-NTFS project' to avoid confusion.
>
> >   *
> >   * Set @count bits starting at bit @start_bit in the bitmap described =
by the
> >   * vfs inode @vi to @value, where @value is either 0 or 1.
> > - *
> > - * Return 0 on success and -errno on error.
> >   */
>
> Any reason for dropping these Return documentations?  From a quick
> looks the remove statements still seen to be correct with your
> entire series applied.
I will check the history, but it seems those lines were removed by
mistake. I will restore them and also check the comments in the entire
patch series again.
>
> > +     struct runlist runlist; /*
> > +                              * If state has the NI_NonResident bit se=
t,
> > +                              * the runlist of the unnamed data attrib=
ute
> > +                              * (if a file) or of the index allocation
> > +                              * attribute (directory) or of the attrib=
ute
> > +                              * described by the fake inode (if NInoAt=
tr()).
> > +                              * If runlist.rl is NULL, the runlist has=
 not
> > +                              * been read in yet or has been unmapped.=
 If
> > +                              * NI_NonResident is clear, the attribute=
 is
> > +                              * resident (file and fake inode) or ther=
e is
> > +                              * no $I30 index allocation attribute
> > +                              * (small directory). In the latter case
> > +                              * runlist.rl is always NULL.
> > +                              */
>
> Maybe it's just be, but I think if you write this detailed comments
> for fields in a structure, move them above so that you get a lot more
> screen real estate and make it more readable.  The same applies
> to a lot of places in thee series, and also to bit definitions
> (i.e. the NI_* bits very close in the patch here).
I agree. I will move the long comments above the definitions and check
the entire series for similar cases.
>
> >  /*
> >   * The full structure containing a ntfs_inode and a vfs struct inode. =
Used for
> >   * all real and fake inodes but not for extent inodes which lack the v=
fs struct
> >   * inode.
> >   */
> > -typedef struct {
> > -     ntfs_inode ntfs_inode;
> > +struct big_ntfs_inode {
> > +     struct ntfs_inode ntfs_inode;
> >       struct inode vfs_inode;         /* The vfs inode structure. */
> > -} big_ntfs_inode;
> > +};
>
> It seem like big_ntfs_inode is literally only used in the conversion
> helpers below.  Are there are a lot of these "extent inode" so that
> not having the vfs inode for them is an actual saving?
Right, In NTFS, a base MFT record (represented by the base ntfs_inode)
requires a struct inode to interact with the VFS. However, a single
file can have multiple extent MFT records to store additional
attributes. These extent inodes are managed internally by the base
inode and do not need to be visible to the VFS.
>
> (Not an action item for getting this merged, just thinking out loud).
Okay.
>
> >  /**
> >   * NTFS_I - return the ntfs inode given a vfs inode
> > @@ -223,22 +269,18 @@ typedef struct {
> >   *
> >   * NTFS_I() returns the ntfs inode associated with the VFS @inode.
> >   */
> > -static inline ntfs_inode *NTFS_I(struct inode *inode)
> > +static inline struct ntfs_inode *NTFS_I(struct inode *inode)
> >  {
> > -     return (ntfs_inode *)container_of(inode, big_ntfs_inode, vfs_inod=
e);
> > +     return (struct ntfs_inode *)container_of(inode, struct big_ntfs_i=
node, vfs_inode);
>
> Both the old and new version here aren't good.  Instead of the casts
> just dereference the ntfs_inode field in the big_inode:
>
>         return container_of(inode, struct ntfs_big_inode, vfs_inode)->ntf=
s_inode;
Okay.
>
> > -static inline struct inode *VFS_I(ntfs_inode *ni)
> > +static inline struct inode *VFS_I(struct ntfs_inode *ni)
> >  {
> > -     return &((big_ntfs_inode *)ni)->vfs_inode;
> > +     return &((struct big_ntfs_inode *)ni)->vfs_inode;
>
> Same here, please don't cast:
>
>         return container_of(ni, struct ntfs_big_inode, ntfs_inode)->vf_in=
ode;
Okay, I will change it like this.
>
>
> >  static inline void *__ntfs_malloc(unsigned long size, gfp_t gfp_mask)
> >  {
> >       if (likely(size <=3D PAGE_SIZE)) {
> > -             BUG_ON(!size);
> > +             if (!size)
> > +                     return NULL;
> >               /* kmalloc() has per-CPU caches so is faster for now. */
> > -             return kmalloc(PAGE_SIZE, gfp_mask & ~__GFP_HIGHMEM);
> > +             return kmalloc(PAGE_SIZE, gfp_mask);
> >               /* return (void *)__get_free_page(gfp_mask); */
> >       }
> >       if (likely((size >> PAGE_SHIFT) < totalram_pages()))
> > @@ -49,7 +50,7 @@ static inline void *__ntfs_malloc(unsigned long size,=
 gfp_t gfp_mask)
> >   */
> >  static inline void *ntfs_malloc_nofs(unsigned long size)
> >  {
> > -     return __ntfs_malloc(size, GFP_NOFS | __GFP_HIGHMEM);
> > +     return __ntfs_malloc(size, GFP_NOFS | __GFP_ZERO);
> >  }
>
> This whole ntfs_malloc machinery is pretty outdata in many ways.
> I think you're better implementing is using kvmalloc and friends,
> and using the _nofs scope where needed.
Okay.
>
> > +static inline void *ntfs_realloc_nofs(void *addr, unsigned long new_si=
ze,
> > +             unsigned long cpy_size)
>
> ... and kvrealloc here.
Okay.
>
> > +#define NTFS_DEF_PREALLOC_SIZE               (64*1024*1024)
> > +
> > +#define STANDARD_COMPRESSION_UNIT    4
> > +#define MAX_COMPRESSION_CLUSTER_SIZE 4096
>
> Please throw in comments explaining these magic constants.
Okay, Thanks for the review!


>
> > +#define UCHAR_T_SIZE_BITS 1
>
> Why not use sizeof(unsigned char) in the one place using it?
>
> > +#define NTFS_B_TO_CLU(vol, b) ((b) >> (vol)->cluster_size_bits)
> > +#define NTFS_CLU_TO_B(vol, clu) ((u64)(clu) << (vol)->cluster_size_bit=
s)
> > +#define NTFS_B_TO_CLU_OFS(vol, clu) ((u64)(clu) & (vol)->cluster_size_=
mask)
> > +
> > +#define NTFS_MFT_NR_TO_CLU(vol, mft_no) (((u64)mft_no << (vol)->mft_re=
cord_size_bits) >> \
> > +                                      (vol)->cluster_size_bits)
> > +#define NTFS_MFT_NR_TO_PIDX(vol, mft_no) (mft_no >> (PAGE_SHIFT - \
> > +                                       (vol)->mft_record_size_bits))
> > +#define NTFS_MFT_NR_TO_POFS(vol, mft_no) (((u64)mft_no << (vol)->mft_r=
ecord_size_bits) & \
> > +                                       ~PAGE_MASK)
>
> A lot of this is pretty unreadable.  At least break the line after
> the macro definition, e.g.:
>
> #define NTFS_MFT_NR_TO_POFS(vol, mft_no) \
>         (((u64)mft_no << (vol)->mft_record_size_bits) & \ ~PAGE_MASK)
>
> But inline functions with proper typing would help a lot.  As would
> comments explaining what this does given the not very descriptive
> names.
>
> > +/*
> > + * ntfs-specific ioctl commands
> > + */
> > +#define NTFS_IOC_SHUTDOWN _IOR('X', 125, __u32)
>
> This isn't really NTFS-specific, but really something originating
> in XFS and then copied to half a dozen file systems.  Maybe start
> adding it to uapi/linux/fs.h as a start, and then we'll slowly
> migrate the other file system over to it?
>

