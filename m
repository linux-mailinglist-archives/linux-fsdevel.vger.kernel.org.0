Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1DC3D5A15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhGZMai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 08:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232572AbhGZMah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627305065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPL6SyJfCAcGFknIr89e6g6Y7tOrsxyCmKRCnF/Y8R0=;
        b=NIBwVE6EPsHiD8SwHPA/Mu5OtfZ0lbgi4oq6m+r2+TV9vhZZhINtVJ6cOMOXxFMF/ivvdU
        +ifIjIHASGwJ92EZHezojhDlAZ0OuLYSVXgmQpLMkQsYfDif3mAkOF4bxC+U9NWjhu/LxC
        R12HdjaeesYCqlYJcvgSFDLyBixrjqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-HOrxHyIGPv2nY66dsqMeWQ-1; Mon, 26 Jul 2021 09:11:04 -0400
X-MC-Unique: HOrxHyIGPv2nY66dsqMeWQ-1
Received: by mail-wm1-f69.google.com with SMTP id n10-20020a05600c4f8ab029024eabacb065so584506wmq.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 06:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=tPL6SyJfCAcGFknIr89e6g6Y7tOrsxyCmKRCnF/Y8R0=;
        b=KaqJcDsIxrCI5IYqToBtl4Tjws5EOXLDB3X8/ovtXOZ+DcBGxn1/8Z87PoNgw50N4n
         5OHZvIjXvCpQITEegrF1jMZBPPYzondsT5eBaQ9XROtzdnIPBN9l4XRc3PeONkY3vUPZ
         oY0gfzqBWBJcxURQgFl6rgf5UOZOG/txgf41Cqaw2yiD0CmKesp3CeAbyS+ENhtagDPk
         YPaBK52Pl4J7zCwzirIuVFkcUdjl8Z1cECrPJRUWg2bB38uc9WDTSZgD597282CuTJic
         S0tqMFi8NvhApyqTzJZ0rtFaCQyJSIPs3dZnHNwPJAnb9w+u77WuEnt8frlrJ3Zd7AkG
         Sozg==
X-Gm-Message-State: AOAM533jaYsmbAjIxUtaEeEinaagSmV+eseYy5B3axDEGMPAWCHZ4NfK
        sGnGwRUq5E/eLy/htlzDHCjObDUcftsHbvi/8/g9skeOc3mcsaJ+sKNnHTCup3Bv+ztRw0Kwo5X
        o0iRSxCN0WNOdJATeylaj17wFj8FgCO0/W/53aneftw==
X-Received: by 2002:a1c:2282:: with SMTP id i124mr17092312wmi.166.1627305063183;
        Mon, 26 Jul 2021 06:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyazdqGI0qehD4Mm0gUxh5ITfYFs2JsUFWs3CSE0J7pUjoTGjDY2Mt93MVWMQBRvSg882EFFsTvTDaZEHsMF0g=
X-Received: by 2002:a1c:2282:: with SMTP id i124mr17092287wmi.166.1627305062909;
 Mon, 26 Jul 2021 06:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local> <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de> <CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com>
 <YP6vs180ThT1A2dO@B-P7TQMD6M-0146.local>
In-Reply-To: <YP6vs180ThT1A2dO@B-P7TQMD6M-0146.local>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 26 Jul 2021 15:10:51 +0200
Message-ID: <CAHc6FU6t84w-RoV7jyQmVAdvjEk6AcVVL6YkhBr10rNKs8DOrQ@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 2:51 PM Gao Xiang <hsiangkao@linux.alibaba.com> wro=
te:
> Hi Andreas, Christoph,
>
> On Mon, Jul 26, 2021 at 02:27:12PM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Mo., 26. Juli 2021 um 14:17 Uhr schrieb Christoph Hellwig <hch@lst.d=
e>:
> > >
> > > > Subject: iomap: Support tail packing
> > >
> > > I can't say I like this "tail packing" language here when we have the
> > > perfectly fine inline wording.  Same for various comments in the actu=
al
> > > code.
> > >
> > > > +     /* inline and tail-packed data must start page aligned in the=
 file */
> > > > +     if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > > > +             return -EIO;
> > > > +     if (WARN_ON_ONCE(size > PAGE_SIZE - offset_in_page(iomap->inl=
ine_data)))
> > > > +             return -EIO;
> > >
> > > Why can't we use iomap_inline_data_size_valid here?
> >
> > We can now. Gao, can you change that?
>
> Thank you all taking so much time on this! much appreciated.
>
> I'm fine to update that.
>
> >
> > > That is how can size be different from iomap->length?
> >
> > Quoting from my previous reply,
> >
> > "In the iomap_readpage case (iomap_begin with flags =3D=3D 0),
> > iomap->length will be the amount of data up to the end of the inode.
>
> For tail-packing cases, iomap->length is just the length of tail-packing
> inline extent.
>
> > In the iomap_file_buffered_write case (iomap_begin with flags =3D=3D
> > IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
> > (For extending writes, we need to write beyond the current end of
> > inode.) So iomap->length isn't all that useful for
> > iomap_read_inline_data."
>
> Ok, now it seems I get your point. For the current gfs2 inline cases:
>   iomap_write_begin
>     iomap_write_begin_inline
>       iomap_read_inline_data
>
> here, gfs2 passes a buffer instead with "iomap->length", maybe it
> could be larger than i_size_read(inode) for gfs2. Is that correct?
>
>         loff_t max_size =3D gfs2_max_stuffed_size(ip);
>
>         iomap->length =3D max_size;
>
> If that is what gfs2 currently does, I think it makes sense to
> temporarily use as this, but IMO, iomap->inline_bufsize is not
> iomap->length. These are 2 different concepts.
>
> >
> > > Shouldn't the offset_in_page also go into iomap_inline_data_size_vali=
d,
> > > which should probably be called iomap_inline_data_valid then?
> >
> > Hmm, not sure what you mean: iomap_inline_data_size_valid does take
> > offset_in_page(iomap->inline_data) into account.
> >
> > > >       if (iomap->type =3D=3D IOMAP_INLINE) {
> > > > +             int ret =3D iomap_read_inline_data(inode, page, iomap=
);
> > > > +             return ret ?: PAGE_SIZE;
> >
> > > The ?: expression without the first leg is really confuing.  Especial=
ly
> > > if a good old if is much more readable here.
> >
> > I'm sure Gao can change this.
> >
> > >                 int ret =3D iomap_read_inline_data(inode, page, iomap=
);
> > >
> > >                 if (ret)
> > >                         return ret;
> > >                 return PAGE_SIZE;
>
> I'm fine to update it if no strong opinion.
>
> > >
> > > > +             copied =3D copy_from_iter(iomap_inline_data(iomap, po=
s), length, iter);
> > >
> > >
> > > > +             copied =3D copy_to_iter(iomap_inline_data(iomap, pos)=
, length, iter);
> > >
> > > Pleae avoid the overly long lines.
> >
> > I thought people were okay with 80 character long lines?
>
> Christoph mentioned before as below:
> https://lore.kernel.org/linux-fsdevel/YPVe41YqpfGLNsBS@infradead.org/
>
> We also need to take the offset into account for the write side.
> I guess it would be nice to have a local variable for the inline
> address to not duplicate that calculation multiple times.

Fair enough, we could add a local variable:

  void *inline_data =3D iomap_inline_data(iomap, pos);

and use that in the copy_from_iter and copy_to_iter. Why not.

Thanks,
Andreas

