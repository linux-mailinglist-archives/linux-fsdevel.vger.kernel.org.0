Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379F5A4838
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfIAHya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 03:54:30 -0400
Received: from sonic313-21.consmr.mail.gq1.yahoo.com ([98.137.65.84]:41816
        "EHLO sonic313-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728617AbfIAHya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 03:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567324468; bh=J79Y2G0I1TVmLSwHXC2+aHwiZC3n4iAsXF26Qi7Ltf0=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=BAZ6J2wQqaturspfP9wEbdbIUBOw6uu3evfEmM/odzvUE02SzB1pthpkbT4SAz4QAgLhOauNApdTpQxLCfDj/b3339ticFXo0WAZE+x/QhlCwCT2wzx01vKs63ER4QCRDPQxg8JsEAe5y8NG9zpVDjtnFDWK0or/jdRVDpUCFHPL35s06avCO+2esleo+5qP75md25Qtnc6QFGaLR0KD02i9m77yJgBGR3QlLmYLuALZyH/7Fr6H+f7Ua+mgGnbS+NT9JDhEPkKhIvRxIbzRk8wSrYq1SzeGHv/Yy7Lw3V+WGo1kzewumAF3YQBgwYbII8zMJL1ReALf2YgpIrTRng==
X-YMail-OSG: IK5Sy_QVM1lsoz686qqnQ5aOLnuon34Ax7CkeDH4ttkQ_2w7F1nFqX4BN1OWbyz
 jnJ1Ek4ZlDGe0OXj9WCXiYeUUGb4h9Kah3DKqTr3GZDjfqga3q.SIMXB87RMpNAx0DQB0pqiBizX
 nZQQIVpl1HFYR_ySgFv0JpjBx7u87JBJ.TNsGJTLhYDtIHXmE_sfrBt8nqM58AftBvPcN68E1lnr
 x2DWvzSeFilm5JxLOCPR4S1PFz0lMXvpXh7iZlro5IKdtw.VPVg1r9zY.g4SeM6UdsO10Lcu_9dE
 G6hpmL.yKptifXABfGNOLsoqaIhWlpJjM2bnH6CuE1xfrHcyaeJ.3ADn8DXtyFaq40jcDKC5lg0W
 Qzn.cI6XbrNIChJ2FOg6uVy6wiTNufR_1LnuExnin2ZZlGKqZsFEhDeEMfjxjFNi2KqSsf3hmdh1
 etirIOJDoGaxF9yvzMHiLhLk5DImk.JhhrYpHLmY7D.kqDBNl6eW_Kx6uo3T8Gdo9_02OcQ9npP4
 gEI6dLUVj4rCWd.vJk71txkifQ1E5.Id89giamJSzIqGHYWFjAAMKEE0N0ChEY4yaReJ2GMU1rRe
 8ts7AjVhMTkMQLQrZqZ6t_yI45dgvrznWE29_nfXA8DGA_LYpEtah66oi_gwr8k1OqsC9Ns413ck
 oyjVtmRP1LTyiNQ1NAOEpLfOaF5lk0SJxVGEqUwsEfFJtVfGOlNnocSj2hSlFxlInttwDKUBiIcE
 x8xZQhvQnxoLNKuvUQ7ZC4qVHwkitv3XyrMlrYLUsT.FFmk79y3WbIQQofklKNHsdJE11nz98Zan
 ejomns5l8femmbSjXLgp8BuFn8k6qlNzjbi0R4A2jcMhskVLw5l3XAGd24IwkTVAyuyF3XD1cy5K
 PVBr_MUNSoAwS8BTwfmHFZYJADov.xJb65DbHT1IKaBgT8Duaqat1a3O2r1iSxAu8BQRAKBYH16F
 DTxQsqQuoMg5ig9uCRlMjdjQhDq7SKvAlY.Ai41NdEXM7k13TdZHMemzWn7fcM2Q9GTndtBdqeF1
 gG9FMjpU9kQI.h5XtrrlfHUthGYajGPCTCQgjanHWW5tjXVYPH30Ll.EZVaz_2LJg4wFFUJDE3Ck
 vB3Dgi_KxHC7QkeueFaGIGjCWWbGPUEGJrbxaalSFHcVsESfvRmP6SH598uAXyMXgICb66u.ImIQ
 I.YOt3dSwgilTMKfauLcOj6IE2IdxGnwB9DIinsQS5KS3U7gSZkS0cSPmdZn49mSzKQGO_jxsA17
 AZg34rGP8S4Bin7CUHHJJdXkSoYdM.hfDK6w-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 07:54:28 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 91e90752a14b0d45ad1c1695aa749d56;
          Sun, 01 Sep 2019 07:54:24 +0000 (UTC)
Date:   Sun, 1 Sep 2019 15:54:11 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190901075240.GA2938@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829095954.GB20598@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

Sorry about my first response, sincerely...
Here is my redo-ed comments to all your suggestions...

On Thu, Aug 29, 2019 at 02:59:54AM -0700, Christoph Hellwig wrote:
> > --- /dev/null
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -0,0 +1,316 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> > +/*
> > + * linux/fs/erofs/erofs_fs.h
> 
> Please remove the pointless file names in the comment headers.

Has already fixed in the latest version, and I will resend
the whole v9 addressing all suggestions from you these days...

However it's somewhat hard to spilt the whole code prefectly
since erofs is ~7KLOC code and linux-fsdevel mailing list
have some limitation, I have spilted it in the form of features...

> 
> > +struct erofs_super_block {
> > +/*  0 */__le32 magic;           /* in the little endian */
> > +/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > +/*  8 */__le32 features;        /* (aka. feature_compat) */
> > +/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> 
> Please remove all the byte offset comments.  That is something that can
> easily be checked with gdb or pahole.

fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-2-hsiangkao@aol.com/

> 
> > +/* 64 */__u8 volume_name[16];   /* volume name */
> > +/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
> > +
> > +/* 84 */__u8 reserved2[44];
> > +} __packed;                     /* 128 bytes */
> 
> Please don't add __packed.  In this case I think you don't need it
> (but double check with pahole), but even if you would need it using
> proper padding fields and making sure all fields are naturally aligned
> will give you much better code generation on architectures that don't
> support native unaligned access.

fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-5-hsiangkao@aol.com/

> 
> > +/*
> > + * erofs inode data mapping:
> > + * 0 - inode plain without inline data A:
> > + * inode, [xattrs], ... | ... | no-holed data
> > + * 1 - inode VLE compression B (legacy):
> > + * inode, [xattrs], extents ... | ...
> > + * 2 - inode plain with inline data C:
> > + * inode, [xattrs], last_inline_data, ... | ... | no-holed data
> > + * 3 - inode compression D:
> > + * inode, [xattrs], map_header, extents ... | ...
> > + * 4~7 - reserved
> > + */
> > +enum {
> > +	EROFS_INODE_FLAT_PLAIN,
> 
> This one doesn't actually seem to be used.

It could be better has a name though, because 1) erofs.mkfs uses this
definition explicitly, and we keep this on-disk definition erofs_fs.h
file up with erofs-utils.

2) For kernel use, first we have,
   datamode < EROFS_INODE_LAYOUT_MAX; and
   !erofs_inode_is_data_compressed, so there are only two mode here,
        1) EROFS_INODE_FLAT_INLINE,
        2) EROFS_INODE_FLAT_PLAIN
   if its datamode isn't EROFS_INODE_FLAT_INLINE (tail-end block packing),
   it should be EROFS_INODE_FLAT_PLAIN.

   The detailed logic in erofs_read_inode and
   erofs_map_blocks_flatmode....

> 
> > +	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
> 
> why are we adding a legacy field to a brand new file system?

The difference is just EROFS_INODE_FLAT_COMPRESSION_LEGACY doesn't
have z_erofs_map_header, so it only supports default (4k clustersize)
fixed-sized output compression rather than per-file setting, nothing
special at all...

> 
> > +	EROFS_INODE_FLAT_INLINE,
> > +	EROFS_INODE_FLAT_COMPRESSION,
> > +	EROFS_INODE_LAYOUT_MAX
> 
> It seems like these come from the on-disk format, in which case they
> should have explicit values assigned to them.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-3-hsiangkao@aol.com/

> 
> Btw, I think it generally helps file system implementation quality
> if you use a separate header for the on-disk structures vs in-memory
> structures, as that keeps it clear in everyones mind what needs to
> stay persistent and what can be chenged easily.

All fields in this file are on-disk representation by design
(no logic for in-memory presentation).

> 
> > +static bool erofs_inode_is_data_compressed(unsigned int datamode)
> > +{
> > +	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> > +		return true;
> > +	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
> > +}
> 
> This looks like a really obsfucated way to write:
> 
> 	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
> 		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-6-hsiangkao@aol.com/

> 
> > +/* 28 */__le32 i_reserved2;
> > +} __packed;
> 
> Sane comment as above.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-5-hsiangkao@aol.com/

> 
> > +
> > +/* 32 bytes on-disk inode */
> > +#define EROFS_INODE_LAYOUT_V1   0
> > +/* 64 bytes on-disk inode */
> > +#define EROFS_INODE_LAYOUT_V2   1
> > +
> > +struct erofs_inode_v2 {
> > +/*  0 */__le16 i_advise;
> 
> Why do we have two inode version in a newly added file system?

There is no new or old, both can be used for the current EROFS in one image.

v2 is an exhanced on-disk inode form, it has 64 bytes,
v1 is more reduced one, which is already suitable for Android use case.

> 
> > +#define ondisk_xattr_ibody_size(count)	({\
> > +	u32 __count = le16_to_cpu(count); \
> > +	((__count) == 0) ? 0 : \
> > +	sizeof(struct erofs_xattr_ibody_header) + \
> > +		sizeof(__u32) * ((__count) - 1); })
> 
> This would be much more readable as a function.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-4-hsiangkao@aol.com/
> 
> > +#define EROFS_XATTR_ENTRY_SIZE(entry) EROFS_XATTR_ALIGN( \
> > +	sizeof(struct erofs_xattr_entry) + \
> > +	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
> 
> Same here.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-4-hsiangkao@aol.com/

> 
> > +/* available compression algorithm types */
> > +enum {
> > +	Z_EROFS_COMPRESSION_LZ4,
> > +	Z_EROFS_COMPRESSION_MAX
> > +};
> 
> Seems like an on-disk value again that should use explicitly assigned
> numbers.

Fixed in
https://lore.kernel.org/linux-fsdevel/20190901055130.30572-3-hsiangkao@aol.com/

Thanks,
Gao Xiang

