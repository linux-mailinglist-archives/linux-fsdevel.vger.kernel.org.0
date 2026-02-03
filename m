Return-Path: <linux-fsdevel+bounces-76197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIUJHDMBgmmYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:07:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D27DA588
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A3DD30D3DC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503853A63EE;
	Tue,  3 Feb 2026 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFS7dI/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366C3A4F4E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127556; cv=none; b=r/NxwsjWgB+TcjIQX9rJvMhbnLM8OH0CCtmSPO2wYNPHCZ9iF/W1Od/tQzypPCc1TzWTjtL1bm9qCLIvbTw3Clm3neIEpN+LQdhOvSvixepfq4KVAT3Jv/dkemvA9k9rYkTDhyslcHPZ5JWQwljSEHTWHTzPjYaA8eaC4M7pQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127556; c=relaxed/simple;
	bh=FCPvV2/JcbyDSL8X6u62zcRDs6ZDF7tyDAOuqkGRa3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4RWlFxdKf6MyqJRB8Q6tsryavtyhjIVvGZHKL7UFBq4JKsmrKSowkEzjzGieLUSmRgWvZgKePDucqcZSImxcnpRU/W1GlbZhk7ISZRlzBkA7yrFoYf4X1VcQgvQk3lXkbwnkT/P9T08DSAqoR8zJL2DuazD1iUZ82tCBLuEYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFS7dI/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99241C2BCB0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770127556;
	bh=FCPvV2/JcbyDSL8X6u62zcRDs6ZDF7tyDAOuqkGRa3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bFS7dI/5iO2U/AHjjGKZ/BZURfG9Gnzn1Z7dwu2MEaILYPhEyX9jeze0yfpdmrqLy
	 OoYII7xuwb6faNd1weFrSBHD2C/A8lSusbWpbaS17wNQxQeKmESSvnKq639B0nYuyc
	 VKhYsatELaYRCFvzQ3bfoZrxOty65l/HrvEWyIdCbxSzrITehvteIgb3tK06nJarja
	 dYoJp3KhFm/oYNIhT8TWrWqWOCU73Cto3l3uFMSDPfjKgtMWNm1SQucMBFvm302yqx
	 BlK5x2e1rbqSU1hJZDBe9k1L1PTdBXXWQLRpsTO5wvEW3wDzil7YoWGoUYaywyleMT
	 rlrFlwVKsPR3g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso8552789a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 06:05:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXW+p4uJRrl6JCNFNAwgDQzSAKCPMQEpEwNeyKzhezmmKRHZYf9GY9TOPASKQET10r+575kS6JEvD4YU0tF@vger.kernel.org
X-Gm-Message-State: AOJu0YxJosIQXAEYYg5Slp9kF8HpoaEv764a0zkd1659t+6ImFxNaOPs
	lzGg9zhetF1LssFnGqW00zKeb0NG+bvj8qb67gHl4QmOs4W8ylzO+W/EPynNc6OckCeQmx7eULo
	IaKSQ2Svu+S5zE0Pi9CcFXs00N9rmk5s=
X-Received: by 2002:a17:907:9342:b0:b87:c92:25bf with SMTP id
 a640c23a62f3a-b8dff72c9edmr1005622866b.33.1770127554782; Tue, 03 Feb 2026
 06:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-10-linkinjeon@kernel.org>
 <20260203062018.GF16426@lst.de>
In-Reply-To: <20260203062018.GF16426@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 23:05:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9PMncz+dK+AJ6aLfMiQ6-xHMuT=zG8qXtE_JOjbtKcig@mail.gmail.com>
X-Gm-Features: AZwV_QjnDbSwWr6Xfl3cn5MylyZb6gthGM1XDOZ31ZIzHDfjxOiDHhmMpCphaf0
Message-ID: <CAKYAXd9PMncz+dK+AJ6aLfMiQ6-xHMuT=zG8qXtE_JOjbtKcig@mail.gmail.com>
Subject: Re: [PATCH v6 09/16] ntfs: update iomap and address space operations
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76197-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8D27DA588
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:20=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Suggested commit message:
>
> Update the address space operations to use the iomap framework,
> replacing legacy buffer-head based code.
Okay, I will use it in the next version.
>
> > +#include <linux/mpage.h>
>
> This include should not be needed (same in iomap.c).
Okay.
>
> > +#include <linux/uio.h>
>
> This should not be needed either (same in iomap.c).
Okay.
>
> > -};
> > +static void ntfs_readahead(struct readahead_control *rac)
> > +{
> > +     struct address_space *mapping =3D rac->mapping;
> > +     struct inode *inode =3D mapping->host;
> > +     struct ntfs_inode *ni =3D NTFS_I(inode);
> >
> > +     if (!NInoNonResident(ni) || NInoCompressed(ni)) {
> > +             /* No readahead for resident and compressed. */
>
> As-is this comment is useless ads it states the obvious.  If you
> want to make it useful add why it is not implemented.
Okay, I will improve this comment.
>
> > +static int ntfs_writepages(struct address_space *mapping,
> > +             struct writeback_control *wbc)
> > +{
> > +     struct inode *inode =3D mapping->host;
> > +     struct ntfs_inode *ni =3D NTFS_I(inode);
> > +     struct iomap_writepage_ctx wpc =3D {
> > +             .inode          =3D mapping->host,
> > +             .wbc            =3D wbc,
> > +             .ops            =3D &ntfs_writeback_ops,
> > +     };
> > +
> > +     if (NVolShutdown(ni->vol))
> > +             return -EIO;
> >
> > +     if (!NInoNonResident(ni))
> > +             return 0;
> >
> > +     /* If file is encrypted, deny access, just like NT4. */
>
> I don't understand this comment.
Okay, I will update it.
>
> > +void mark_ntfs_record_dirty(struct folio *folio)
> > +{
> > +     iomap_dirty_folio(folio->mapping, folio);
> > +}
>
> Should this be in mft.c and have a mft_ compoenent in the name?
Okay, I will move it with renaming.
>
> > +     if (!NInoNonResident(ni))
> > +             goto out;
>
> Split the resident handling into a helper to keep the method
> simple?
Okay.
>
> > +static int __ntfs_read_iomap_begin(struct inode *inode, loff_t offset,=
 loff_t length,
> > +             unsigned int flags, struct iomap *iomap, struct iomap *sr=
cmap,
> > +             bool need_unwritten)
> > +{
> > +     struct ntfs_inode *ni =3D NTFS_I(inode);
> > +     int ret;
> > +
> > +     if (NInoNonResident(ni))
> > +             ret =3D ntfs_read_iomap_begin_non_resident(inode, offset,=
 length,
> > +                             flags, iomap, need_unwritten);
> > +     else
> > +             ret =3D ntfs_read_iomap_begin_resident(inode, offset, len=
gth,
> > +                             flags, iomap);
> > +
> > +     return ret;
>
> This could be simplified to:
>
>         if (NInoNonResident(NTFS_I(inode)))
>                 return ntfs_read_iomap_begin_non_resident(inode, offset, =
length,
>                                 flags, iomap, need_unwritten);
>         return ntfs_read_iomap_begin_resident(inode, offset, length, flag=
s,
>                         iomap);
Okay, I will update it like this.
>
> > +int ntfs_zero_range(struct inode *inode, loff_t offset, loff_t length,=
 bool bdirect)
> > +{
> > +     if (bdirect) {
> > +             if ((offset | length) & (SECTOR_SIZE - 1))
> > +                     return -EINVAL;
> > +
> > +             return  blkdev_issue_zeroout(inode->i_sb->s_bdev,
> > +                                          offset >> SECTOR_SHIFT,
> > +                                          length >> SECTOR_SHIFT,
> > +                                          GFP_NOFS,
> > +                                          BLKDEV_ZERO_NOUNMAP);
> > +     }
> > +
> > +     return iomap_zero_range(inode,
> > +                             offset, length,
> > +                             NULL,
> > +                             &ntfs_zero_read_iomap_ops,
> > +                             &ntfs_zero_iomap_folio_ops,
> > +                             NULL);
> > +}
>
> This really should be two separate helpers.
Okay.
>
> > +     if (NInoNonResident(ni)) {
>
> As separate non-resident helper would be useful here.
Okay.
>
> > +             if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
> > +                     ret =3D ntfs_write_iomap_begin_non_resident(inode=
, offset,
> > +                                     length, iomap);
> > +             else
> > +                     ret =3D ntfs_write_da_iomap_begin_non_resident(in=
ode,
> > +                                     offset, length, flags, iomap,
> > +                                     ntfs_iomap_flags);
> > +     } else {
> > +             mutex_lock(&ni->mrec_lock);
> > +             ret =3D ntfs_write_iomap_begin_resident(inode, offset, io=
map);
> > +     }
> > +
> > +     return ret;
>
> But eveven without that, direct returns would really help here:
>
>         if (!NInoNonResident(ni)) {
>                 mutex_lock(&ni->mrec_lock);
>                 return ntfs_write_iomap_begin_resident(inode, offset, iom=
ap);
>         }
>
>         ...
>
>         if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
>                 return ntfs_write_iomap_begin_non_resident(inode, offset,
>                                 length, iomap);
>         return ntfs_write_da_iomap_begin_non_resident(inode, offset, leng=
th,
>                         flags, iomap,
Okay, I will update it like this.
>
> > +static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_=
t length,
> > +             ssize_t written, unsigned int flags, struct iomap *iomap)
> > +{
> > +     if (iomap->type =3D=3D IOMAP_INLINE) {
>
> A separate inline helper would help here as well.
Okay, I will do that.
Thanks for the review!
>

