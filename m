Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B82796E36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 02:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbjIGAsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 20:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjIGAsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:48:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342C6172E
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:48:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c09673b006so3175335ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694047687; x=1694652487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xiTqCZfUuOaZiyeOYi2J8iopikWSUHIkvjjbcjN5Ig=;
        b=DJxkSNt3s1oRhYSYo8V6+XjHMcdEb46BKzpp+vvBoR5fpeJfK8ce4SPUBAg0UlQMxV
         aGLiAgs4tBf9JGCWJfwzEFc9p14/uvIbdy6dOo8Ho9M9VdYGU7lfYCtPVSJxWui5Zydd
         2DFHBA70ur3gbwXB/3fB3mQyWIKLDtsSuP2ho1Dw/I92a7UNkUn9YAEzBMBmP8lC1FH1
         FWarZoU6bbb5LA0AmRHc0+TMBGfUqgxb11ph/GSAZKwaLRMQrOjLFE12xnWJGhKnBvi+
         b9Y1405h3LzLkGGOGGzWlttivZhViss1jeQwNyPNbdEwErF6qXGkSfEz5pmyoQwljzWu
         XYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694047687; x=1694652487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xiTqCZfUuOaZiyeOYi2J8iopikWSUHIkvjjbcjN5Ig=;
        b=YHlHr+KfdbuGgulmWQYsgUQr+w+CzszQOzfzY1Rx7YSnyQ0Ky+To8z4YWTgUdnjq84
         PyYhEw6t6PDHuW5pwm9ZcSLxphS4mx9vRxJSd8wE6eTAMU2FpDeBM3IU/i6tYis4kV5/
         Y1QeU3JAbeCgtv099aUQkYh68k7+61WMmJUqqT3Ff+WJq2gJ5Nc5urCvLYp9RUmYyFXS
         vcg+esJ/BdA7KG1AjjSFT8QoFq+bMcy96Fa8OJAp12Ov2R3qx2ve4l0e7B7/d8f4caiX
         O3Qt91iFyMZ/JQqo1dG5D3MsT40HoYiYMT0mrTaT7nuWM9gDyQPJePWEs3Lmy/K1yPAt
         ZYFg==
X-Gm-Message-State: AOJu0Yz6qjPUVZlxM15WmMBfWsoo3FmC2nOpWF0/Y4Why+hqKO/2gqgy
        f8sLjOyf8k81AAuTYcP81wk=
X-Google-Smtp-Source: AGHT+IEY9xYAsQYYGkJv4GkODYYJ6ajlHZ7BGVWUymi1OSJPOe8x8ywPl2pbJ8Fsuxc4C7a6jaFbqQ==
X-Received: by 2002:a17:903:1109:b0:1bb:d280:5e0b with SMTP id n9-20020a170903110900b001bbd2805e0bmr16710589plh.18.1694047687539;
        Wed, 06 Sep 2023 17:48:07 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001b87d3e845bsm11636314plg.149.2023.09.06.17.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 17:48:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 30A57817F2CA; Thu,  7 Sep 2023 07:48:04 +0700 (WIB)
Date:   Thu, 7 Sep 2023 07:48:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPkdxMh7jt5A7x67@debian.me>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="POqXAfAGR5zFhSYW"
Content-Disposition: inline
In-Reply-To: <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--POqXAfAGR5zFhSYW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 03:32:28PM -0700, Guenter Roeck wrote:
> On 8/30/23 07:07, Christoph Hellwig wrote:
> > Hi all,
> >=20
> > we have a lot of on-disk file system drivers in Linux, which I consider
> > a good thing as it allows a lot of interoperability.  At the same time
> > maintaining them is a burden, and there is a lot expectation on how
> > they are maintained.
> >=20
> > Part 1: untrusted file systems
> >=20
> > There has been a lot of syzbot fuzzing using generated file system
> > images, which I again consider a very good thing as syzbot is good
> > a finding bugs.  Unfortunately it also finds a lot of bugs that no
> > one is interested in fixing.   The reason for that is that file system
> > maintainers only consider a tiny subset of the file system drivers,
> > and for some of them a subset of the format options to be trusted vs
> > untrusted input.  It thus is not just a waste of time for syzbot itself,
> > but even more so for the maintainers to report fuzzing bugs in other
> > implementations.
> >=20
> > What can we do to only mark certain file systems (and format options)
> > as trusted on untrusted input and remove a lot of the current tension
> > and make everyone work more efficiently?  Note that this isn't even
> > getting into really trusted on-disk formats, which is a security
> > discussion on it's own, but just into formats where the maintainers
> > are interested in dealing with fuzzed images.
> >=20
> > Part 2: unmaintained file systems
> >=20
> > A lot of our file system drivers are either de facto or formally
> > unmaintained.  If we want to move the kernel forward by finishing
> > API transitions (new mount API, buffer_head removal for the I/O path,
> > ->writepage removal, etc) these file systems need to change as well
> > and need some kind of testing.  The easiest way forward would be
> > to remove everything that is not fully maintained, but that would
> > remove a lot of useful features.
> >=20
> > E.g. the hfsplus driver is unmaintained despite collecting odd fixes.
> > It collects odd fixes because it is really useful for interoperating
> > with MacOS and it would be a pity to remove it.  At the same time
> > it is impossible to test changes to hfsplus sanely as there is no
> > mkfs.hfsplus or fsck.hfsplus available for Linux.  We used to have
> > one that was ported from the open source Darwin code drops, and
> > I managed to get xfstests to run on hfsplus with them, but this
> > old version doesn't compile on any modern Linux distribution and
> > new versions of the code aren't trivially portable to Linux.
> >=20
> > Do we have volunteers with old enough distros that we can list as
> > testers for this code?  Do we have any other way to proceed?
> >=20
> > If we don't, are we just going to untested API changes to these
> > code bases, or keep the old APIs around forever?
> >=20
>=20
> In this context, it might be worthwhile trying to determine if and when
> to call a file system broken.
>=20
> Case in point: After this e-mail, I tried playing with a few file systems.
> The most interesting exercise was with ntfsv3.
> Create it, mount it, copy a few files onto it, remove some of them, repea=
t.
> A script doing that only takes a few seconds to corrupt the file system.
> Trying to unmount it with the current upstream typically results in
> a backtrace and/or crash.

Did you forget to take the checksum after copying and verifying it
when remounting the fs?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--POqXAfAGR5zFhSYW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPkdwwAKCRD2uYlJVVFO
oy8pAP0Z5qmUJsEAD+6yij0ybOFmAUw5+ifdA3NrJK675IcAqwEA4FVjK4Y1copi
hfW5YCSuY2VMkr43cApyoGgv34xjnwg=
=Ct+D
-----END PGP SIGNATURE-----

--POqXAfAGR5zFhSYW--
