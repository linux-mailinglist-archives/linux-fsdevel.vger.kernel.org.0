Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A206B15A503
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 10:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgBLJir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 04:38:47 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33792 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgBLJir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:38:47 -0500
Received: by mail-oi1-f177.google.com with SMTP id l136so1434938oig.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 01:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mIiapcw2qY11tt9ZC1FJxtTmrsdn4un9X7oox81xbp0=;
        b=xIQqMJZiBbTwqKfqhbIBV8cPsjP0fB9ODjH3UlNW47f/KQGuR5LFmez888vOfWtrgx
         hHzFz3tEzyCn6T6KIuQStJtkVI0qMygIbWwrjF0tagXMv4fEBuIM6bBQs2lOC7hc17XA
         j25098U0iL4LjQokTeZsIEps7PMv+J9ST/pw7B+IH8kdBSetzPsRjd65RtygwqC9kG6J
         zGzRWsaXvM+7mx1QKkmfPTrh9c76C7S1y7ItyjNDjXCiO3nYxw2tcRoyB2OqXfZR4a83
         EOckv3TbvBMl2eipVhcUUBB+dIz1yLD8LKDVdpMnRNojyka69+JamCvqctzEuNboLjQ5
         SvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mIiapcw2qY11tt9ZC1FJxtTmrsdn4un9X7oox81xbp0=;
        b=dHHEdQElaCb2SMxJWnOHoP7BsFcUbTm/V/8K/3E3OaeB5XogOwNoFNdipcrFD56WOu
         HCqhWJL9rKvJQvjXlXJLLss+eH77sys1v3CoSOaNGtQ9oS7r6dcW4XLVnQj7ROJsq0ir
         nIqLrMIGQSkl5O34CaM0voAwKkQWK0RBWljGKYBelVYvclmweO+O1j3p+zKcbzqYDWx+
         IQlUF7k2lCxroGSe/yZI8uJrvWK/piFC7phw4F56PXSAJhZt0yVesiSDwSUtje1oVLMz
         QaVV/ZaiRCKKVpbYsIaScvIIwl1QYuR++RqwtBzmmCeUELkHRj0OvNqvkP/L8WgUXFTW
         skfA==
X-Gm-Message-State: APjAAAWsO+L+aKy0if8uiVkKuPweGsgurrdb6EtTzANX0gXScbMDUnzI
        RPDUgYXI9K8Ut3lDBwJiqoBFxCCxn3dttNPZZN307A==
X-Google-Smtp-Source: APXvYqwE/sMJX5ePegfwW/KgqcLC2oPJAKKTz2Nu51sp1Q0ZQgEywIjx8jgBjgEwGDKmUND0vtCRy1M3lHRYMiYtuRQ=
X-Received: by 2002:a05:6808:8ca:: with SMTP id k10mr5623635oij.164.1581500325196;
 Wed, 12 Feb 2020 01:38:45 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch> <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
 <CANnVG6kYh6M30mwBHcGeFf=fhqKmWKPeUj2GYbvNgtq0hm=gXQ@mail.gmail.com> <CAJfpegtX0Z3_OZFG50epWGHkW5aOMfYmn61WmqYC67aBmJyDMA@mail.gmail.com>
In-Reply-To: <CAJfpegtX0Z3_OZFG50epWGHkW5aOMfYmn61WmqYC67aBmJyDMA@mail.gmail.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Wed, 12 Feb 2020 10:38:33 +0100
Message-ID: <CANnVG6=s1C7LSDGD1-Ato-sfaKi1LQvW3GM5wfAiUqWXibEohw@mail.gmail.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unfortunately not: when I change the code like so:

    bool async;
    uint32_t opcode_early =3D req->args->opcode;

    if (test_and_set_bit(FR_FINISHED, &req->flags))
        goto put_request;

    async =3D req->args->end;

=E2=80=A6gdb only reports:

(gdb) bt
#0  0x000000a700000001 in ?? ()
#1  0xffffffff8137fc99 in fuse_copy_finish (cs=3D0x20000ffffffff) at
fs/fuse/dev.c:681
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

But maybe that=E2=80=99s a hint in and of itself?

On Wed, Feb 12, 2020 at 9:34 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Feb 12, 2020 at 8:58 AM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
>
> > (gdb) p *req->args
> > $5 =3D {
> >   nodeid =3D 18446683600620026424,
> >   opcode =3D 2167928246,
> >   in_numargs =3D 65535,
> >   out_numargs =3D 65535,
> >   force =3D false,
> >   noreply =3D false,
> >   nocreds =3D false,
> >   in_pages =3D false,
> >   out_pages =3D false,
> >   out_argvar =3D true,
> >   page_zeroing =3D true,
> >   page_replace =3D false,
> >   in_args =3D {{
> >       size =3D 978828800,
> >       value =3D 0x2fafce0
> >     }, {
> >       size =3D 978992728,
> >       value =3D 0xffffffff8138efaa <fuse_alloc_forget+26>
> >     }, {
> >       size =3D 50002688,
> >       value =3D 0xffffffff8138635f <fuse_lookup_name+255>
> >     }},
> >   out_args =3D {{
> >       size =3D 570,
> >       value =3D 0xffffc90002fafb10
> >     }, {
> >       size =3D 6876,
> >       value =3D 0x3000000001adc
> >     }},
> >   end =3D 0x1000100000001
> > }
>
> Okay, that looks like rubbish, the request was possibly freed and overwri=
tten.
>
> > Independently, as a separate test, I have also modified the source like=
 this:
> >
> > bool async;
> > bool async_early =3D req->args->end;
> >
> > if (test_and_set_bit(FR_FINISHED, &req->flags))
> > goto put_request;
> >
> > async =3D req->args->end;
> >
> > =E2=80=A6and printed the value of async and async_early. async is true,
> > async_early is false.
>
> Can you save and print out the value of req->opcode before the
> test_and_set_bit()?
>
> Thanks,
> Miklos
