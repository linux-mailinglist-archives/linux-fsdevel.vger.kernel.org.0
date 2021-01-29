Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21248308571
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 07:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhA2GB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 01:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhA2GBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:01:52 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11977C061756;
        Thu, 28 Jan 2021 22:01:12 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u17so8181818iow.1;
        Thu, 28 Jan 2021 22:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I7Jf4w2xQmonkgOSIoCWrc0+He7UNn5JipXpaAB81cg=;
        b=r70zrkvIb3T0rBH5Z2812Vuxjmhp2HQrxUhsJAvYWEv8Nc6dww2sKXdShoNWfpDe0l
         FosQjsrtPB7nsNNeaa9uk+SdRiNKSj/2QcCgESa3wE8qY6rkjUpwa+KG5oXFAAwxHQVF
         E1MwCx6X52VGXNtbzXHGvZETNhjX4l3FJKC/rbPNmlOWMUu2UzNR4lzC2z9zL8pujS5y
         2Kof7uqiBRc+RvqvfLhbGnYH7QihgpkD+SSCAxm1uKOxsQCv/p9+CX/O6TWPZLArNQHK
         ssLCzcTh1j6TxbFLjZtOOF7/OHfdXoUJszw7y+WEzTkm6MGrDRl1NRqMIqUtH1kQ0FBK
         IMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I7Jf4w2xQmonkgOSIoCWrc0+He7UNn5JipXpaAB81cg=;
        b=AyDYsLSlFLx0n2SGsNF/z89a2tZUlmqTXz7Spk1ivuPFBJ7Yvuij2zu2bMM9sfecW+
         Fyr5g3DCgXMuAj6Zyfwza3XCM1xtdAC3/j3VMQvcJ+wADrbUQDqF+9NXJX+84DmXIV6t
         7nbivzNR26gqccIXN9ihU4/GMhlTxgsePDTHOn4Rw2WnylZwopEVXCVzKGrri+V5vqgX
         EJ2wMLGeuJe38EyVUImL5iQYaC6x5kGT+LjIVVn4brdwmlpyKUhZu8105gq3oQS4jYhs
         bvWAJXB/nIHUyyB/Vsf5aMMt3/iZx/KrUKN36f3M2SSOGriHx4yyv1Cj6E2PMkWsPA0c
         RBKA==
X-Gm-Message-State: AOAM532XZ1niOjSnJoFH4kEzPsXjZy4aq8pKmGiIkbbf0Xtq+8l+KVNp
        LNNWrlmtH+oV6lEEUZdG1ZvZLQyhDl3OWKdRZjHlRy/M3uQiZg==
X-Google-Smtp-Source: ABdhPJxFpR3aT0BQY0meTLiJwXYnAk7p0kzsniXup3IColeXcgDuwcom/2i2lyMLAgcPN5I0dB7OCiSur35i35eXS20=
X-Received: by 2002:a05:6602:144:: with SMTP id v4mr2671045iot.168.1611900070495;
 Thu, 28 Jan 2021 22:01:10 -0800 (PST)
MIME-Version: 1.0
References: <1611800401-9790-1-git-send-email-bingjingc@synology.com>
 <CAJfpegtDbDzSCgv-D66-5dAA=pDxMGN_aMTVcNPzWNibt2smLw@mail.gmail.com> <939d2196-8468-4d93-b976-70f3d8ac83de@Mail>
In-Reply-To: <939d2196-8468-4d93-b976-70f3d8ac83de@Mail>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Fri, 29 Jan 2021 14:00:59 +0800
Message-ID: <CAMmgxWFMBxg47J_Zjdfm5i36m3TMf2VEzoeREGKD6VFJXcbN3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] parser: add unsigned int parser
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cccheng@synology.com, robbieko@synology.com,
        bingjingc <bingjingc@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Thank you for your mail. Please see my message below.

bingjingc <bingjingc@synology.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [loop bxxxjxxg@gmail.com] in order to reply in plain-text
> Miklos Szeredi <miklos@szeredi.hu> =E6=96=BC 2021-01-28 16:37 =E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Thu, Jan 28, 2021 at 3:21 AM bingjingc <bingjingc@synology.com> wrote:
> >
> > From: BingJing Chang <bingjingc@synology.com>
> >
> > Will be used by fs parsing options
> >
> > Reviewed-by: Robbie Ko<robbieko@synology.com>
> > Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
> > Signed-off-by: BingJing Chang <bingjingc@synology.com>
> > ---
> >  fs/isofs/inode.c       | 16 ++--------------
> >  fs/udf/super.c         | 16 ++--------------
> >  include/linux/parser.h |  1 +
> >  lib/parser.c           | 22 ++++++++++++++++++++++
> >  4 files changed, 27 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> > index 342ac19..21edc42 100644
> > --- a/fs/isofs/inode.c
> > +++ b/fs/isofs/inode.c
> > @@ -335,18 +335,6 @@ static const match_table_t tokens =3D {
> >         {Opt_err, NULL}
> >  };
> >
> > -static int isofs_match_uint(substring_t *s, unsigned int *res)
> > -{
> > -       int err =3D -ENOMEM;
> > -       char *buf =3D match_strdup(s);
> > -
> > -       if (buf) {
> > -               err =3D kstrtouint(buf, 10, res);
> > -               kfree(buf);
> > -       }
> > -       return err;
> > -}
>
> I don't see how adding this function and removing it in the same
> series makes any sense.

That's true. Simple and clear is better.
I used to think that the acceptance of patch can be 3/3 or 2/3.
And I was not sure are there needs for making match_uint
as shared lib. So I made the first patch.

I simplify them. Please see the third patch, thanks!

>
> Why not make this the first patch in the series, simplifying everything?
>
> And while at it the referenced fuse implementation can also be
> converted (as a separate patch).
>
> Thanks,
> Miklos

Thanks,
BingJing
