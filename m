Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F177125154D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgHYJ03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgHYJ00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:26:26 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D876C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 02:26:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r8so335430ota.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtdNILRbFpNDC70ZxIPdrfWI20tr17di9UquKIlAhMg=;
        b=Gpgu/1SgntVTf0NCW1imw7k2WmBjTYfGL2aSC5mp27POfNAxpZXGfrRe26ruqMIhif
         hJ0Vq3Q3s8g7xn7mstVJkMe5AUSWacWbe4Bw2OAhqOzfC7Gvtxg/EYUdahpC4oWv2SBO
         4w8RXC4Iks/7gvwM25jYhiyymW4U0zfCsG3xfNRrdncocLOhGTkCa3Wvv0JsFQ7IZSf2
         Qcuvtw+/6J95dwnbaoEli8YAN7BGzH5oRwWgvE08F+zOr4s0KK+yI5VjFe8Fv6XHMQ6A
         iAp1Y7gw+Ngom7xkzykAtI+JhwqwCGNptoWi7ZdaH93EDJdG8Niv0uXZE6iNeTRsef8f
         vMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtdNILRbFpNDC70ZxIPdrfWI20tr17di9UquKIlAhMg=;
        b=WHFMTWQ6enMmWC1uc4shG2x5wlZ5JPF8C0LN9W8F1O4GMZhbswpI/2FRfKoeV5lkG1
         BDQVfqYsXXjAFL4QX7yGqVHCoTcZwE0HS1GHvUnv+1PCAUimYhkqosH3eeoIppvlZmya
         E1pO+QKnKkl8NUvUDDebysI8WWrffCsbUh3M+GlLCfPzJfQrEOaZAdXvwvJRa9h6QDft
         ZHxz+I7rAi4U1lAlG0qMvS4Trg9J08F3oX21PLyk2UeTuSHFPM8FMygms5F0g9P4S9/2
         63uhvuQjSfU/x+9lR3HXrjsY1/Oow38AgKzgzivlUS1Y5fSIaiyM5Yg59+2YTDeHLRke
         Awug==
X-Gm-Message-State: AOAM5333hfUo1pnBRYMW41F+9JU14oYZ3LGxPSTu+5VrFzylV1ITkMfJ
        GnhjWk5USUdMDma8hPIMUnFDI02Ji+WpOM4Jl9DOopyn
X-Google-Smtp-Source: ABdhPJx1xtJtASqEa/bSze/52N7c1wXez+M3fx4SVrd7+RJT9O+vSAoSFgq6LIiP6aac4FtSzJAlqoXgV1YKknkaH/4=
X-Received: by 2002:a9d:2f03:: with SMTP id h3mr6689685otb.151.1598347585569;
 Tue, 25 Aug 2020 02:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200505183608.10280-1-yshuiv7@gmail.com> <20200505193049.GC5694@magnolia>
In-Reply-To: <20200505193049.GC5694@magnolia>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Tue, 25 Aug 2020 10:26:14 +0100
Message-ID: <CAGqt0zzA5NRx+vrcwyekW=Z18BL5CGTuZEBvpRO3vK5rHCBs=A@mail.gmail.com>
Subject: Re: [PATCH] iomap: iomap_bmap should accept unwritten maps
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Do we actually want to fix this bug or not? There are a number of
people actually seeing this bug.

If you think this is not the right fix, what do you think we should
do? If the correct fix is to make ext4 use iomap_swapfile_activate,
maybe we should CC the ext4 people too?

On Tue, May 5, 2020 at 8:32 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, May 05, 2020 at 07:36:08PM +0100, Yuxuan Shui wrote:
> > commit ac58e4fb03f9d111d733a4ad379d06eef3a24705 moved ext4_bmap from
> > generic_block_bmap to iomap_bmap, this introduced a regression which
> > prevents some user from using previously working swapfiles. The kernel
> > will complain about holes while there is none.
> >
> > What is happening here is that the swapfile has unwritten mappings,
> > which is rejected by iomap_bmap, but was accepted by ext4_get_block.
>
> ...which is why ext4 ought to use iomap_swapfile_activate.
>
> --D
>
> > This commit makes sure iomap_bmap would accept unwritten mappings as
> > well.
> >
> > Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
> > ---
> >  fs/iomap/fiemap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> > index d55e8f491a5e..fb488dcfa8c7 100644
> > --- a/fs/iomap/fiemap.c
> > +++ b/fs/iomap/fiemap.c
> > @@ -115,7 +115,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
> >  {
> >       sector_t *bno = data, addr;
> >
> > -     if (iomap->type == IOMAP_MAPPED) {
> > +     if (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_UNWRITTEN) {
> >               addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
> >               *bno = addr;
> >       }
> > --
> > 2.26.2
> >


-- 

Regards
Yuxuan Shui
