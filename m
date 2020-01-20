Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9566B143378
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 22:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgATVkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 16:40:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36289 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATVkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 16:40:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so889018wma.1;
        Mon, 20 Jan 2020 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EclQbYOQEkzamFYNx/Y4PzCYvv/zjV5YtY7vdNyyehw=;
        b=NJmlIDgOuzcNpXmypgRGRuNTI+EY5rWcJry9WzvjCRt2DfZVKx/ZqkpT9w6c4f1P4k
         cvYGp8/dUbgQkSPrCAf+VeyJHCOkiv/vYhdbNfrTz2NDzpNN/PEtWvMnhJL/DpVCkapY
         KFFsIW6XRxqhQ8gONMayZuN9dg0WYc4oPXP6qfVLVcB1z4IbbZI5SPRrYht8OMPZbZ/5
         dQjYjemra+dXJX5b37O7Jipj0y2zh6pQm8T+9mmuos/FMfuggQc9LEkGiGMZpnTGQK+h
         JXIbfdzIalxR6zdpk9r/SRYN94y2/rKJujJEwiaNJsjmcSAsWfRZxXgEwxqoog6QE+N/
         /fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EclQbYOQEkzamFYNx/Y4PzCYvv/zjV5YtY7vdNyyehw=;
        b=TQNG5xI7UJfkqT8jPVh5sAelVfpm98w4DYvm7yO0Q0ZiPFhF74S13HzkpydmuDygvM
         L5xDisq5hpTAECg0qwYb20/4E+luhDkiQ+g+4iiMqyEVQkPLuZf2Vo46Xn/h/DDPfyRE
         J0q9jepaCaKpJSDXHENw0SoqFEaRzarlmJF7JaCp04XMB0PhBgcTeiKVkCSi2wh4+ogu
         VYIgkKtot7gqADbxYvh1FA/v8LoQ3ZraN/GbKgOv9FuZpqt4srGpzB4G+/nI8Y2J8tS3
         lRrYno/zvCvBKdvLUhjaePgXCAYFIhUEOp48Zo29St3IH9hh60NS59N8bNYN+ENbzvV3
         4f1w==
X-Gm-Message-State: APjAAAXq+SkEHnwvGBTVZs8KgjI4mzH5JICvmKMlr4LI+HzmZR1fdwtd
        5mI8eCz3faTNdrAiNMF2bdA=
X-Google-Smtp-Source: APXvYqzo05DDEd29zOE88PvXVdBesd8iqi8SnC8gPVfVOjKhTWKkVQwvaJXBBqduSHSI+3XqDe7+FA==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr767255wmo.123.1579556448870;
        Mon, 20 Jan 2020 13:40:48 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h2sm50235953wrv.66.2020.01.20.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 13:40:47 -0800 (PST)
Date:   Mon, 20 Jan 2020 22:40:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120214046.f6uq7rlih7diqahz@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uh7dvwiyhyuai6mk"
Content-Disposition: inline
In-Reply-To: <875zh6pc0f.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uh7dvwiyhyuai6mk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 20 January 2020 21:07:12 OGAWA Hirofumi wrote:
> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
>=20
> >> To be perfect, the table would have to emulate what Windows use. It can
> >> be unicode standard, or something other.
> >
> > Windows FAT32 implementation (fastfat.sys) is opensource. So it should
> > be possible to inspect code and figure out how it is working.
> >
> > I will try to look at it.
>=20
> I don't think the conversion library is not in fs driver though,
> checking implement itself would be good.

Ok, I did some research. It took me it longer as I thought as lot of
stuff is undocumented and hard to find all relevant information.

So... fastfat.sys is using ntos function RtlUpcaseUnicodeString() which
takes UTF-16 string and returns upper case UTF-16 string. There is no
mapping table in fastfat.sys driver itself.

RtlUpcaseUnicodeString() is a ntos kernel function and after my research
it seems that this function is using only conversion table stored in
file l_intl.nls (from c:\windows\system32).

Project wine describe this file as "unicode casing tables" and seems
that it can parse this file format. Even more it distributes its own
version of this file which looks like to be generated from official
Unicode UnicodeData.txt via Perl script make_unicode (part of wine).

So question is... how much is MS changing l_intl.nls file in their
released Windows versions?

I would try to decode what is format of that file l_intl.nls and try to
compare data in it from some Windows versions.

Can we reuse upper case mapping table from that file?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--uh7dvwiyhyuai6mk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiYeWQAKCRCL8Mk9A+RD
Uh0bAJ9oXybx7i8wTkLtZEpeDpnDUmCgNwCgys3n6EWFgeEQxy3My+sXPUnxXXQ=
=nzVm
-----END PGP SIGNATURE-----

--uh7dvwiyhyuai6mk--
