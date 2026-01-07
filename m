Return-Path: <linux-fsdevel+bounces-72565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AECCFB9DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 02:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5494E3071575
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 01:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E21C8626;
	Wed,  7 Jan 2026 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk4J5NVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF352139C9
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750069; cv=none; b=M8xORGsQAy8Uw+8trgOyt8zv+2WzkgtRKFULml89e1dLrSKox5aI9FgT9ViUeipbd68EAriMzi0iksev/NatPgbHe/DNGzPFZHXCgZ4mihtVDYARSYTQMdAMgMY9jLCw32y3ALRBr6PDossj5VAe49fAIN9OdyiDxsWcIeoH9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750069; c=relaxed/simple;
	bh=Lru6R9nlRiwf0yhbOXh1cJUquJnoklnH47vkGFSI6qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lxz92NoZyAzu88uOdeMyic3uj6HJaLE6/R3V1mQJut1KTzOtWL/APFcPK0PVivQTYPu21KOCZdmMxylqqzBiemIppLUqqdB6e8LewC2dDD4YYTM5nzbRduracGiNKACkBlC7qv2Wpr6LVza7RVg4t8ksi6rZjdE7F5wJpgH7XDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk4J5NVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E2BC2BC87
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750069;
	bh=Lru6R9nlRiwf0yhbOXh1cJUquJnoklnH47vkGFSI6qE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kk4J5NVjX+XAUN6Pi50BmCnRqr+wfBJEhf9EpWBHZ9YoKDZthmAtLGnjFjBc14YB7
	 Hi8lh+2eTr1mzoSjyc+rTFSIOiKWbTbqVTEm9cKsQ+gO7dR+0zTg7t5vtwMqr8tgw1
	 uW7MdW4JFJRzI2n7kMltw+611v5hiyondYgdA9RgGFHPd62iE6rFouVW38bFaK6Hlt
	 e+l5mzIIOuaNKHevBM8mjOs5CkChZoZXgiMvyi6i9VwATfbMEDKYhusRWrg0AqIhbS
	 qeg5Ex030krwOS2mPSam0VuUNu15NiwB59G1oe95AoYhq3bqW/PTzGIR3nKTE+dQZK
	 LTd90M1JAiV7g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so2330222a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 17:41:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6aOEQLMNQelw5m/2QcKBNyXbiT9bqvva1/zto3VW+6v6554cTahfPGjrKznAJXlLJMM/ckZKaS7kBw7aI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QEd25yiXz9Y9scj94R9s6grnlKOfxb1zlxF5NXpGGm7nSTrt
	LywmTLD9bqqQHY6OYDqzsVBfaAYbTfJipFxGLTfrGeT7lbnIJAtr31wHbLGsQ31hrJnPExweL2o
	6kOQ1e0bKq6hd9o6w/mkKsPt68O46V44=
X-Google-Smtp-Source: AGHT+IG4NIDwquwjcsVqOscLYWtiVNcmUmenPdqOwJ49EycNiC+NEP2AJcCBotlh6zpdltOdcDT2rZvQsRMNV/anp6M=
X-Received: by 2002:a17:907:3e18:b0:b7d:3728:7d11 with SMTP id
 a640c23a62f3a-b84453d8cfcmr88619966b.50.1767750067478; Tue, 06 Jan 2026
 17:41:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106131110.46687-1-linkinjeon@kernel.org> <20260106131110.46687-8-linkinjeon@kernel.org>
 <aV2ALM3uLrd7C3Nm@casper.infradead.org>
In-Reply-To: <aV2ALM3uLrd7C3Nm@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 7 Jan 2026 10:40:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-bwou_-hnJZV5Br_MuRCp9gbSH7xUb=-pCKMSQNre5fA@mail.gmail.com>
X-Gm-Features: AQt7F2oreTHw4Z7Y0hpeYdPbGWx6SOWpkjZ1xaHjq0D0F9dH5P8g2UdKAdIvpYg
Message-ID: <CAKYAXd-bwou_-hnJZV5Br_MuRCp9gbSH7xUb=-pCKMSQNre5fA@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] ntfs: update iomap and address space operations
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:35=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, Jan 06, 2026 at 10:11:03PM +0900, Namjae Jeon wrote:
> > +++ b/fs/ntfs/aops.c
> > @@ -1,354 +1,36 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> > -/*
> > - * aops.c - NTFS kernel address space operations and page cache handli=
ng.
> > +/**
>
> Why did you turn this into a kernel-doc comment?
It was probably a mistake. I will fix it.
>
> > +static s64 ntfs_convert_folio_index_into_lcn(struct ntfs_volume *vol, =
struct ntfs_inode *ni,
> > +             unsigned long folio_index)
>
> This is a pretty bad function name.  lcn_from_index() would be better.
> It's also better to wrap at 80 columns if reasonable.
>
> > @@ -358,8 +40,8 @@ static int ntfs_read_block(struct folio *folio)
> >   *
> >   * For non-resident attributes, ntfs_read_folio() fills the @folio of =
the open
> >   * file @file by calling the ntfs version of the generic block_read_fu=
ll_folio()
> > - * function, ntfs_read_block(), which in turn creates and reads in the=
 buffers
> > - * associated with the folio asynchronously.
> > + * function, which in turn creates and reads in the buffers associated=
 with
> > + * the folio asynchronously.
>
> Is this comment still true?
I will update the comment.
>
> > +static int ntfs_write_mft_block(struct ntfs_inode *ni, struct folio *f=
olio,
> > +             struct writeback_control *wbc)
> >  {
> > +     struct inode *vi =3D VFS_I(ni);
> > +     struct ntfs_volume *vol =3D ni->vol;
> > +     u8 *kaddr;
> > +     struct ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
> > +     int nr_locked_nis =3D 0, err =3D 0, mft_ofs, prev_mft_ofs;
> > +     struct bio *bio =3D NULL;
> > +     unsigned long mft_no;
> > +     struct ntfs_inode *tni;
> > +     s64 lcn;
> > +     s64 vcn =3D NTFS_PIDX_TO_CLU(vol, folio->index);
> > +     s64 end_vcn =3D NTFS_B_TO_CLU(vol, ni->allocated_size);
> > +     unsigned int folio_sz;
> > +     struct runlist_element *rl;
> > +
> > +     ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, folio =
index 0x%lx.",
> > +                     vi->i_ino, ni->type, folio->index);
> > +
> > +     lcn =3D ntfs_convert_folio_index_into_lcn(vol, ni, folio->index);
> > +     if (lcn <=3D LCN_HOLE) {
> > +             folio_start_writeback(folio);
> > +             folio_unlock(folio);
> > +             folio_end_writeback(folio);
> > +             return -EIO;
> >       }
> >
> > +     /* Map folio so we can access its contents. */
> > +     kaddr =3D kmap_local_folio(folio, 0);
> > +     /* Clear the page uptodate flag whilst the mst fixups are applied=
. */
> > +     folio_clear_uptodate(folio);
> > +
> > +     for (mft_ofs =3D 0; mft_ofs < PAGE_SIZE && vcn < end_vcn;
> > +          mft_ofs +=3D vol->mft_record_size) {
> > +             /* Get the mft record number. */
> > +             mft_no =3D (((s64)folio->index << PAGE_SHIFT) + mft_ofs) =
>>
> > +                     vol->mft_record_size_bits;
> > +             vcn =3D NTFS_MFT_NR_TO_CLU(vol, mft_no);
> > +             /* Check whether to write this mft record. */
> > +             tni =3D NULL;
> > +             if (ntfs_may_write_mft_record(vol, mft_no,
> > +                                     (struct mft_record *)(kaddr + mft=
_ofs), &tni)) {
> > +                     unsigned int mft_record_off =3D 0;
> > +                     s64 vcn_off =3D vcn;
> >
> > +                      * Skip $MFT extent mft records and let them bein=
g written
> > +                      * by writeback to avioid deadlocks. the $MFT run=
list
> > +                      * lock must be taken before $MFT extent mrec_loc=
k is taken.
> >                        */
> > +                     if (tni && tni->nr_extents < 0 &&
> > +                             tni->ext.base_ntfs_ino =3D=3D NTFS_I(vol-=
>mft_ino)) {
> > +                             mutex_unlock(&tni->mrec_lock);
> > +                             atomic_dec(&tni->count);
> > +                             iput(vol->mft_ino);
> >                               continue;
> >                       }
> >                       /*
> > +                      * The record should be written.  If a locked ntf=
s
> > +                      * inode was returned, add it to the array of loc=
ked
> > +                      * ntfs inodes.
> >                        */
> > +                     if (tni)
> > +                             locked_nis[nr_locked_nis++] =3D tni;
> >
> > +                     if (bio && (mft_ofs !=3D prev_mft_ofs + vol->mft_=
record_size)) {
> > +flush_bio:
> > +                             flush_dcache_folio(folio);
> > +                             submit_bio_wait(bio);
>
> Do you really need to wait for the bio to complete synchronously?
> That seems like it'll stall writeback unnecessarily.  Can't you just
> fire it off and move on to the next bio?
I will replace it with submit_bio().
>
> > +                             bio_put(bio);
> > +                             bio =3D NULL;
> > +                     }
> >
> > +                     if (vol->cluster_size < folio_size(folio)) {
> > +                             down_write(&ni->runlist.lock);
> > +                             rl =3D ntfs_attr_vcn_to_rl(ni, vcn_off, &=
lcn);
> > +                             up_write(&ni->runlist.lock);
> > +                             if (IS_ERR(rl) || lcn < 0) {
> > +                                     err =3D -EIO;
> > +                                     goto unm_done;
> > +                             }
> >
> > +                             if (bio &&
> > +                                (bio_end_sector(bio) >> (vol->cluster_=
size_bits - 9)) !=3D
> > +                                 lcn) {
> > +                                     flush_dcache_folio(folio);
> > +                                     submit_bio_wait(bio);
> > +                                     bio_put(bio);
> > +                                     bio =3D NULL;
> > +                             }
> > +                     }
> >
> > +                     if (!bio) {
> > +                             unsigned int off;
> >
> > +                             off =3D ((mft_no << vol->mft_record_size_=
bits) +
> > +                                    mft_record_off) & vol->cluster_siz=
e_mask;
> > +
> > +                             bio =3D bio_alloc(vol->sb->s_bdev, 1, REQ=
_OP_WRITE,
> > +                                             GFP_NOIO);
> > +                             bio->bi_iter.bi_sector =3D
> > +                                     NTFS_B_TO_SECTOR(vol, NTFS_CLU_TO=
_B(vol, lcn) + off);
> >                       }
> > +
> > +                     if (vol->cluster_size =3D=3D NTFS_BLOCK_SIZE &&
> > +                         (mft_record_off ||
> > +                          rl->length - (vcn_off - rl->vcn) =3D=3D 1 ||
> > +                          mft_ofs + NTFS_BLOCK_SIZE >=3D PAGE_SIZE))
> > +                             folio_sz =3D NTFS_BLOCK_SIZE;
> > +                     else
> > +                             folio_sz =3D vol->mft_record_size;
> > +                     if (!bio_add_folio(bio, folio, folio_sz,
> > +                                        mft_ofs + mft_record_off)) {
> > +                             err =3D -EIO;
> > +                             bio_put(bio);
> > +                             goto unm_done;
> >                       }
> > +                     mft_record_off +=3D folio_sz;
> > +
> > +                     if (mft_record_off !=3D vol->mft_record_size) {
> > +                             vcn_off++;
> > +                             goto flush_bio;
> >                       }
> > +                     prev_mft_ofs =3D mft_ofs;
> >
> >                       if (mft_no < vol->mftmirr_size)
> >                               ntfs_sync_mft_mirror(vol, mft_no,
> > +                                             (struct mft_record *)(kad=
dr + mft_ofs));
> >               }
> > +
> >       }
> > +
> > +     if (bio) {
> > +             flush_dcache_folio(folio);
> > +             submit_bio_wait(bio);
> > +             bio_put(bio);
> >       }
> > +     flush_dcache_folio(folio);
> >  unm_done:
> > +     folio_mark_uptodate(folio);
> > +     kunmap_local(kaddr);
> > +
> > +     folio_start_writeback(folio);
> > +     folio_unlock(folio);
> > +     folio_end_writeback(folio);
> > +
> >       /* Unlock any locked inodes. */
> >       while (nr_locked_nis-- > 0) {
> > +             struct ntfs_inode *base_tni;
> > +
> >               tni =3D locked_nis[nr_locked_nis];
> > +             mutex_unlock(&tni->mrec_lock);
> > +
> >               /* Get the base inode. */
> >               mutex_lock(&tni->extent_lock);
> >               if (tni->nr_extents >=3D 0)
> >                       base_tni =3D tni;
> > +             else
> >                       base_tni =3D tni->ext.base_ntfs_ino;
> >               mutex_unlock(&tni->extent_lock);
> >               ntfs_debug("Unlocking %s inode 0x%lx.",
> >                               tni =3D=3D base_tni ? "base" : "extent",
> >                               tni->mft_no);
> >               atomic_dec(&tni->count);
> >               iput(VFS_I(base_tni));
> >       }
> > +
> > +     if (unlikely(err && err !=3D -ENOMEM))
> >               NVolSetErrors(vol);
> >       if (likely(!err))
> >               ntfs_debug("Done.");
> >       return err;
> >  }
>
> Woof, that's a long function.  I'm out of time now.
Thanks for your review!

