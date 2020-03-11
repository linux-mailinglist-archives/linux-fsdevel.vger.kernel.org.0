Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945891813B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 09:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgCKIrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 04:47:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35619 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgCKIrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id g6so770744plt.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=meJyGAJSXgAr31+3ukEDFuw73ZMObvwwFCeW5WBwRac=;
        b=XJIjFVrvZtIylJUzkT+T5e5BJAU82ChJ7L8BK6PQXlfPo/o4aRJHBG8jWwdzUvzhFM
         zIg8PIu3GQUEch50mWVSNWvX2F9J/5Ld0r7BaiwDu34vEz3GswEaLBVm0ef1CMZJMB6+
         4np84VqVGx+5X2BK0iZWtsBiwr7R307Su6gQ3OU724PvDy/CDcluJrX+a2t4udnq0RZZ
         guQLVxkDDuHPzsht2Lr02BPj2zcZN9pqDR5XmhRoQWoCfitA4jsMasbxKYQ5TUYXRRJy
         ITe+4PCdwWQijSRKUaniBHnxBpTS6v3boEGBU+R74HB/kNhWQvvhLF6NAJmJ/xAvw1c5
         AZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=meJyGAJSXgAr31+3ukEDFuw73ZMObvwwFCeW5WBwRac=;
        b=Dl1tsc5WLL4MSTXEsQQLwmfJPDh4uLblXru3thfXZ8bkO1GOAsA5UDZ+eNBrx04Bt0
         J9WHm0PjZSRMddLeOCBqbwiKjiS2Yled12GXcBlXhTRiLT8txjrfX6P4DVI4gJTE78Qe
         M3m7qRCNLIFvVpDfTEOi6SHEhVuVOYAHL8wKS4yU0BP70ZK6szUboWsS6cHdnktL2K5U
         ubEyStm/k1KlwzkORD3iXw4CPhRfoGnEhTE3BuP54ILwq9zCUbjbyBxsz0OmVJbQ/VTt
         4wskTzZcrTdgECaIbdA8UFlN8yRf9XD1sJj+cftdijVEEKKuEMdRWQxVNjnURVkO4FYh
         2fhw==
X-Gm-Message-State: ANhLgQ3W4+THDh7jCAogI3+9dJfSFw+4gaFNBUToePovtp71P9okjY/T
        ua8uimc6Cjh0sy4ISDds0NIRzg==
X-Google-Smtp-Source: ADFU+vuNqQ+iHcYWOxMz1qzEmeqojAhrgBwGH3aDI9mnKKGqzldPb/Wsub/jfCuoZ5gclIlokegR+Q==
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr2257664pjy.170.1583916461621;
        Wed, 11 Mar 2020 01:47:41 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id v29sm50393874pgc.72.2020.03.11.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:47:41 -0700 (PDT)
Date:   Wed, 11 Mar 2020 01:47:39 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH man-pages v4] Document encoded I/O
Message-ID: <20200311084739.GB252106@vader>
References: <cover.1582930832.git.osandov@fb.com>
 <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
 <CAOQ4uxgym1C3JZHrLhBmEh_T7UbQOukxTBKVzHqp4NSdjredSg@mail.gmail.com>
 <20200229180335.GA157744@vader>
 <CAOQ4uxiKmErX0YLkHs2tE4=OUobxmiYBsDz5982YYmierm2Yig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiKmErX0YLkHs2tE4=OUobxmiYBsDz5982YYmierm2Yig@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 01, 2020 at 09:26:10AM +0200, Amir Goldstein wrote:
> On Sat, Feb 29, 2020 at 8:03 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > On Sat, Feb 29, 2020 at 12:28:41PM +0200, Amir Goldstein wrote:
> > > > +encoded_io \- overview of encoded I/O
> > > > +.SH DESCRIPTION
> > > > +Several filesystems (e.g., Btrfs) support transparent encoding
> > > > +(e.g., compression, encryption) of data on disk:
> > > > +written data is encoded by the kernel before it is written to disk,
> > > > +and read data is decoded before being returned to the user.
> > > > +In some cases, it is useful to skip this encoding step.
> > > > +For example, the user may want to read the compressed contents of a file
> > > > +or write pre-compressed data directly to a file.
> > > > +This is referred to as "encoded I/O".
> > > > +.SS Encoded I/O API
> > > > +Encoded I/O is specified with the
> > > > +.B RWF_ENCODED
> > > > +flag to
> > > > +.BR preadv2 (2)
> > > > +and
> > > > +.BR pwritev2 (2).
> > > > +If
> > > > +.B RWF_ENCODED
> > > > +is specified, then
> > > > +.I iov[0].iov_base
> > > > +points to an
> > > > +.I
> > > > +encoded_iov
> > > > +structure, defined in
> > > > +.I <linux/fs.h>
> > > > +as:
> > > > +.PP
> > > > +.in +4n
> > > > +.EX
> > > > +struct encoded_iov {
> > > > +    __aligned_u64 len;
> > > > +    __aligned_u64 unencoded_len;
> > > > +    __aligned_u64 unencoded_offset;
> > > > +    __u32 compression;
> > > > +    __u32 encryption;
> > > > +};
> > >
> > > This new API can generate many diverse error conditions that the standard errno
> > > codes are not rich enough to describe.
> > > Maybe add room for encoded io specific error codes in the metadata structure
> > > would be good practice, for example:
> > > - compression method not supported
> > > - encryption method not supported
> > > - the combination of enc/comp is not supported
> > > - and so on
> >
> > I like this idea, but it feels like even more iovec abuse. Namely, for
> 
> That's true.
> 
> > pwritev2(), it feels a little off that we'd be copying _to_ user memory
> > rather than only copying from. It's probably worth it for better errors,
> > though.
> >
> 
> Apropos iovec abuse, if encoded io is going to interpret iovec[0] differently
> why not interpret iovec arg differently. The result might be less awkward if
> the structure passed to preadv2/pwritev2 is struct encoded_iov * instead
> of struct iov *.

IMO, that's clunkier both from an API perspective and an implementation
perspective. On the implementation side, we now have to special case a
bunch of places in the VFS that are expecting a struct iovec *. On the
API side, it's so far from p{read,write}v2 that it might as well be an
ioctl or a new system call. (In fact, v1 of this series was a
Btrfs-specific ioctl, but it's much so nicer to reuse the VFS read/write
infrastructure.)

[snip]

> > > I find the unencoded_len/unencoded_offset API extremely confusing and all
> > > the clarifications above did not help to ease this feeling.
> > > Please remind me why does the API need to expose unencoded details at all.
> > > I understand the backup/restore use case for read/write encoded data.
> > > I do not understand how unencoded offset info is relevant to this use case
> > > or what are the other use cases it is relevant for.
> >
> > I agree, it's confusing. However, without this concept on the read side,
> > there's no way to represent some file extent layouts, and without the
> > write side, those layouts can't be written back out. That would make
> > this interface much less useful for backups.
> >
> > These cases arise in a few ways on Btrfs:
> >
> > 1. Files with a size unaligned to the block size.
> >
> >    Ignoring inline data, Btrfs always pads data to the filesystem block
> >    size when compressing. So, a file with a size unaligned to the block
> >    size will end with an extent that decompresses to a multiple of the
> >    block size, but logically the file only contains the data up to
> >    i_size. In this case, len (length up to i_size) < unencoded_len (full
> >    decompressed length). This can arise simply from writing out an
> >    unaligned file or from truncating a file unaligned.
> >
> > 2. FICLONERANGE from the middle of an extent.
> >
> >    Suppose file A has a large compressed extent with
> >    len = unencoded_len = 128k and unencoded_offset = 0. If the user does
> >    an FICLONERANGE out of the middle of that extent (say, 64k long and
> >    4k from the start of the extent), Btrfs creates a "partial" extent
> >    which references the original extent (in my example, the result would
> >    have len = 64k, unencoded_offset = 4k, and unencoded_len still 128k).
> >
> > 3. Overwriting the middle of an extent.
> >
> >    In some cases, when the middle of an extent is overwritten (e.g., an
> >    O_DIRECT write, FICLONERANGE, or FIDEDUPERANGE), Btrfs splits up the
> >    overwritten extents into partial extents referencing the original
> >    extent instead of rewriting the whole extent.
> >
> > These aren't specific to compression or Btrfs' on-disk format. fscrypt
> > uses block ciphers for file data, so case 1 is just as relevant for
> > that. The way Btrfs handles case 2 is the only sane way I can see for
> > supporting FICLONERANGE for encoded data.
> >
> 
> I see... so now I understand the complication, but that doesn't mean
> that the developers reading the encoded_io documentation will or that
> they will get the implementation details right.
> 
> IMO, if the only use case for encoded io is backup/restore, then we
> should make the API simpler and more oriented to this use case, namely,
> serialization -
> For all I care, btrfs can still return struct encoded_iov in iov[0],
> but the user needs not to know about this and this internal detail should
> not be documented nor exposed in UAPI.
> btrfs send reads a stream of encoded data and metadata that describes it.
> btrfs receive writes the encoded data stream and metadata descriptors that
> tell the file system about overlapping extents and whatnot.
> 
> Is that something that can work out, or does userspace have to be aware
> of encoded extents layout?

There are use cases outside of backups that would benefit from being
able to make arbitrary encoded writes. Specifically, one of my
colleagues at Facebook expressed interest in using encoded writes for
package distribution. The idea is that a package could be distributed as
a compressed archive and installed via encoded writes and reflinks to
the proper files, avoiding any need to decompress the package contents
before they're actually accessed. This sort of low-level fiddling needs
a proper UAPI. I'd much rather improve the documentation than make it
opaque.

Thanks,
Omar
