Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8615B9FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 08:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgBMHXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 02:23:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36634 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbgBMHXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:23:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so4819789oic.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 23:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=muyZ7YMznir5WH5exT0RbBmxdQ/Z+Ljlf7z/NaG6Agg=;
        b=L61FooOwf9pKuM2tfav43uuzApo0o0TxSOJOE8dnOlQ2hvwEnOdmfFgEZ9qB3fIp8r
         2pmCCAJR5/24PQuRFSN8Bva5hmG31QIxHh81GHBe5gqIeMmvV182MBY4wKMq2nsPBYlN
         z/fjVcD813zY1x8Mnu0IlyjefBRM5kPjRfL8r7FOspda6BVKzYeat4nC571OE/yz0Azz
         VDm3z2c+NGuF7fFrXMXkXQGm8Lv6JykpaZONh26d+TPoK+l1dOvEqJeXmHQrbwApcyri
         0zOeQlWzlQTkeMPMlqFbG2uoodOvV8f3yD783BxTbMazdQtkiE7N0osbll+5OSSQ62kp
         CY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=muyZ7YMznir5WH5exT0RbBmxdQ/Z+Ljlf7z/NaG6Agg=;
        b=kJm6MqEbjl7FsF+EAqARZH98FAgahIyJNMGoYMbKvoqChCGG0wy6+JMgoLzYkWbJtQ
         Pi+mWzxCxLN9gxfmP2ABHQ0wZ2JglnEpqxC+q2s0Mgec1+fMYmOB/BH6M+0PVAP99djp
         OIjYMbn5AiAKOV0zUoTslse2DhGV6qz7AOtpjOR30UD1qPA3V6TfoWrAYkVSUiBhOLo9
         4KiT8hYcyEvCvh7IxEhqKvzVfgWU+zbkjqqgmZ2FV9mdwjaeV4PHoZrgcoXD6HI6Hltw
         CvLiHDQ0xJ/A4pnMOao8IWFvBZj9Y6wTLuTJhvhcZukkFaGGjWBz5i/LR6t6wTe44tji
         IA+w==
X-Gm-Message-State: APjAAAWWJHi7S1qAZxHUc76FrhQrXQKg/eNDHeNUNBy/O9HT7jkkCHMX
        tYC2qCVrZfeUVgWvUiJHSZKT2ozY2XoI/ylOlOefxQ==
X-Google-Smtp-Source: APXvYqyYzxgFIan1kewGLG3nqH4OvVo1xRGOuRgd1gmRmamEyn7pbXlvPBmnd0zoDYbsyql132fSHcS/xRA08u5VJ5s=
X-Received: by 2002:a05:6808:8ca:: with SMTP id k10mr2012050oij.164.1581578598795;
 Wed, 12 Feb 2020 23:23:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
 <20200209080918.1562823-1-michael+lkml@stapelberg.ch> <CAJfpegv4iL=bW3TXP3F9w1z6-LUox8KiBmw7UBcWE-0jiK0YsA@mail.gmail.com>
 <CANnVG6kYh6M30mwBHcGeFf=fhqKmWKPeUj2GYbvNgtq0hm=gXQ@mail.gmail.com>
 <CAJfpegtX0Z3_OZFG50epWGHkW5aOMfYmn61WmqYC67aBmJyDMA@mail.gmail.com>
 <CANnVG6=s1C7LSDGD1-Ato-sfaKi1LQvW3GM5wfAiUqWXibEohw@mail.gmail.com> <CAJfpegvBguKcNZk-p7sAtSuNH_7HfdCyYvo8Wh7X6P=hT=kPrA@mail.gmail.com>
In-Reply-To: <CAJfpegvBguKcNZk-p7sAtSuNH_7HfdCyYvo8Wh7X6P=hT=kPrA@mail.gmail.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Thu, 13 Feb 2020 08:23:07 +0100
Message-ID: <CANnVG6=u8drSyKhF9Gjd-Y-saN8gdOSOsmEJenyWXsQE9QYmVQ@mail.gmail.com>
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

I confirm that the patch fixes the issue I was seeing. Thanks a lot!

On Wed, Feb 12, 2020 at 8:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Feb 12, 2020 at 10:38 AM Michael Stapelberg
> <michael+lkml@stapelberg.ch> wrote:
> >
> > Unfortunately not: when I change the code like so:
> >
> >     bool async;
> >     uint32_t opcode_early =3D req->args->opcode;
> >
> >     if (test_and_set_bit(FR_FINISHED, &req->flags))
> >         goto put_request;
> >
> >     async =3D req->args->end;
> >
> > =E2=80=A6gdb only reports:
> >
> > (gdb) bt
> > #0  0x000000a700000001 in ?? ()
> > #1  0xffffffff8137fc99 in fuse_copy_finish (cs=3D0x20000ffffffff) at
> > fs/fuse/dev.c:681
> > Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> >
> > But maybe that=E2=80=99s a hint in and of itself?
>
> Yep, it's a stack use after return bug.   Attached patch should fix
> it, though I haven't tested it.
>
> Thanks,
> Miklos
