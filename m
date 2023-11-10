Return-Path: <linux-fsdevel+bounces-2720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54A7E7BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C4028146A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24285171DA;
	Fri, 10 Nov 2023 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9CQ7dVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093041640A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 11:29:59 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D861D2FECE
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 03:29:58 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7ba0d338367so853418241.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699615798; x=1700220598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWDeG6Y0Djj4LeLH+d2JUKsr4iVGhvLlfwLTizivECQ=;
        b=Y9CQ7dVgMQYJ1e0lfjNl7sjrIiMSP2/0sG/1+1fccSCiJzCfuv7wzXBhi57W4EPVIM
         XmtwxsJShPNw+3I1q/UPtduh5Yt+sIWgP9MWEoncmO2bX2W5Ro5TYSWxtZ/jB2+/HY0x
         VJ4hip4yJl2HDQ5o5dIFvprGkcPQGmymZIISjWpol4JnqnDLKqpN6fnkWcKMwVq3WS11
         7pTJm7ukElfxwcDD4MJK3ZbUfQs31jojbQ7Q+3S5M4vLC0EZe3YsoRc3EjlEG/IGnrYb
         34GnI53Z0lK895NPQWgQ3i5Pv1FPUMJCd/dk2RI1W6UmgzBzy9yP3q7v6LVVZQ3NHzLd
         +RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699615798; x=1700220598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWDeG6Y0Djj4LeLH+d2JUKsr4iVGhvLlfwLTizivECQ=;
        b=SoBl+4UscNg9r6rafAhvkzSr1/EkyR34F69Cy9YcKBRfgjqzskJd9Hyo0z0SWFoI68
         Vm4jLX93stS8icrj+hC7kviMP8M9Q+NZwM7jxnNuzOSXcfGoTY9EMjYafiqhfbKJgCrW
         TwakmXfkvB4ErROdpQdApocX0RAxBWBBJKtgi54zmludVZjWa6tkDaZL+dLVayQz98SC
         x5O2EaGjMXWiq/AuOzDhrSuJKljml/mix6+3T/ullmgksOJefXhniD+Qeou9b6cJwARK
         /vQ94IPufomJaTVxm1hJfwsqmwQwCqbe7JG+22KXua/b/bij9ZK06pnMpUBEo7lxxzZ/
         JN6g==
X-Gm-Message-State: AOJu0YwjU4trHTXoKG5VoBbr6ep6QnT6iBFyMjUTkzyyHdzlW+BEkQvO
	QXKt5ipMuUwEN7vtm7Oz83dug9RYjMZ8usuiwGc=
X-Google-Smtp-Source: AGHT+IGKN8zQJHXAQN8mSH7zK9dpeg3xTcec0j/BjjYRHuH13USZdRTfTbNemalQFMah358v3ieCJNyyLR14D3dqdb8=
X-Received: by 2002:a05:6102:5707:b0:45f:4e67:4423 with SMTP id
 dg7-20020a056102570700b0045f4e674423mr7804355vsb.0.1699615797795; Fri, 10 Nov
 2023 03:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109210608.2252323-1-willy@infradead.org> <20231109210608.2252323-4-willy@infradead.org>
 <CAKFNMokB=jtjLTnu_qTKUvCbrxACq3X2+gQzJOqJkB68pO_Ogg@mail.gmail.com>
In-Reply-To: <CAKFNMokB=jtjLTnu_qTKUvCbrxACq3X2+gQzJOqJkB68pO_Ogg@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 10 Nov 2023 20:29:41 +0900
Message-ID: <CAKFNMok+xpU7FiWdnUOJS_5EKboKEn7+WXvquHJMiE69-t78yg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size > PAGE_SIZE
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:37=E2=80=AFPM Ryusuke Konishi wrote:
>
> On Fri, Nov 10, 2023 at 6:06=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
> >
> > We must not shift by a negative number so work in terms of a byte
> > offset to avoid the awkward shift left-or-right-depending-on-sign
> > option.  This means we need to use check_mul_overflow() to ensure
> > that a large block number does not result in a wrap.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/buffer.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 44e0c0b7f71f..9c3f49cf8d28 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1085,26 +1085,21 @@ static bool grow_dev_folio(struct block_device =
*bdev, sector_t block,
> >  static bool grow_buffers(struct block_device *bdev, sector_t block,
> >                 unsigned size, gfp_t gfp)
> >  {
> > -       pgoff_t index;
> > -       int sizebits;
> > -
> > -       sizebits =3D PAGE_SHIFT - __ffs(size);
> > -       index =3D block >> sizebits;
> > +       loff_t pos;
> >
> >         /*
> > -        * Check for a block which wants to lie outside our maximum pos=
sible
> > -        * pagecache index.  (this comparison is done using sector_t ty=
pes).
> > +        * Check for a block which lies outside our maximum possible
> > +        * pagecache index.
> >          */
> > -       if (unlikely(index !=3D block >> sizebits)) {
> > -               printk(KERN_ERR "%s: requested out-of-range block %llu =
for "
> > -                       "device %pg\n",
> > +       if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILE=
SIZE) {
> > +               printk(KERN_ERR "%s: requested out-of-range block %llu =
for device %pg\n",
> >                         __func__, (unsigned long long)block,
> >                         bdev);
> >                 return false;
> >         }
> >

> >         /* Create a folio with the proper size buffers */
> > -       return grow_dev_folio(bdev, block, index, size, gfp);
>
> > +       return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);
>
> "pos" has a loff_t type (=3D long long type).
> Was it okay to do C division directly on 32-bit architectures?
>
> Regards,
> Ryusuke Konishi

Similar to the comment for patch 5/7, can we safely use the generally
less expensive shift operation "pos >> PAGE_SHIFT" here ?

Regards,
Ryusuke Konishi

