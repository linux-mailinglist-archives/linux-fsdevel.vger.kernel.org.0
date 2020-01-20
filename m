Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC72142F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgATQ1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 11:27:05 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35565 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgATQ1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:27:05 -0500
Received: by mail-wr1-f53.google.com with SMTP id g17so111165wro.2;
        Mon, 20 Jan 2020 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C43kfEsLFxRZy2sK+w1qIwr4+TCPdvXSm3RH+wVd5qU=;
        b=mOBZLXtlqfsLVlIR51FbTNLAtsf8o72Td2ObDsLY0Xvk4B35HFcU0PGjNo42BCMnb7
         DQ2ygZ+HOQFTyzmPJ2xwCZ5W+lVyYAOGDFeIfxjZG+jyJGsi9TljdlUHpm1Mz1Ed0BWP
         4k3ukTI1O3iEuHCDFLb0oVX3m0Q5+m9ZxSrYltgb6+9KIjp60+WoRN0m/Txw5M0jF8E0
         aSOVuApB0s+J72PL325fy97uhYnT3v18qkM2zrHFuTtWvIjagRhWvTqqGGB1ARaIRK8r
         V3SVCXGCeWF1q6on5zWLJa0Dgxgma4DbLbtSZE8SYjk2NXaZRDAh1K4VA3mgEhxnrOEd
         AXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C43kfEsLFxRZy2sK+w1qIwr4+TCPdvXSm3RH+wVd5qU=;
        b=jws0d4Peko9XZXBIOqpdPC5UEugHIgMb3G/OGdSLr1MtfJ2nqx5ifBkKuyEi+GRO8r
         4CzBzDZUoky8cCZsXHTsIybUR++dv9fzIuopy23gqbiLhicIlvY6usUMLTbi1rwWITJ6
         ezWrfxQEo2oFBcUSZqKQnDbW5LDSkgxiNaOeygn8BnXZhXDd8FAnu0hB1BG/J55H7041
         w2VsvunntVg1+Hcakrt0afPYx28wzarO3SwSogOcg/ddxevw04fAZwTugvLpPgaB2bEp
         OBbDhbalu+cv5jKoiEehJY091M2Ydvi+9lkaysyFKkqYnq/PmaAoLogfPXt3z3JIScbv
         CvxA==
X-Gm-Message-State: APjAAAUqLw9rv3O5roLIRpN1pJP7dxH6T14Gdnq+8H/M4QZI3lHOT2Mq
        3WTq0epIMdysS8zNpPoa1iI=
X-Google-Smtp-Source: APXvYqwcrRPnd5O+FjCmMVilD1cPlUDyEkN+L8g3frQ/hOzgsjRVTtow3OsdeXH80y8Ed+5KPrAWAQ==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr356257wrx.14.1579537623030;
        Mon, 20 Jan 2020 08:27:03 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r6sm49550041wrq.92.2020.01.20.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:27:02 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:27:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120162701.guxcrmqysejaqw6y@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
 <20200120152009.5vbemgmvhke4qupq@pali>
 <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rb3yd7yh2odisgq3"
Content-Disposition: inline
In-Reply-To: <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--rb3yd7yh2odisgq3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 20 January 2020 15:47:22 David Laight wrote:
> From: Pali Roh=C3=A1r
> > Sent: 20 January 2020 15:20
> ...
> > This is not possible. There is 1:1 mapping between UTF-8 sequence and
> > Unicode code point. wchar_t in kernel represent either one Unicode code
> > point (limited up to U+FFFF in NLS framework functions) or 2bytes in
> > UTF-16 sequence (only in utf8s_to_utf16s() and utf16s_to_utf8s()
> > functions).
>=20
> Unfortunately there is neither a 1:1 mapping of all possible byte sequenc=
es
> to wchar_t (or unicode code points),

I was talking about valid UTF-8 sequence (invalid, illformed is out of
game and for sure would always cause problems).

> nor a 1:1 mapping of all possible wchar_t values to UTF-8.

This is not truth. There is exactly only one way how to convert sequence
of Unicode code points to UTF-8. UTF is Unicode Transformation Format
and has exact definition how is Unicode Transformed.

If you have valid UTF-8 sequence then it describe one exact sequence of
Unicode code points. And if you have sequence (ordinals) of Unicode code
points there is exactly one and only one its representation in UTF-8.

I would suggest you to read Unicode standard, section 2.5 Encoding Forms.

> Really both need to be defined - even for otherwise 'invalid' sequences.
>=20
> Even the 16-bit values above 0xd000 can appear on their own in
> windows filesystems (according to wikipedia).

If you are talking about UTF-16 (which is _not_ 16-bit as you wrote),
look at my previous email:

"MS FAT32 implementations allows half of UTF-16 surrogate pair stored in FS=
=2E"

> It is all to easy to get sequences of values that cannot be converted
> to/from UTF-8.
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rb3yd7yh2odisgq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiXU0wAKCRCL8Mk9A+RD
UlffAJ0elMMTIUY0wtAoDO7B5Dqo/pfzcwCdFon3xWqzyaeLu9BTsknYE0wNmjE=
=ZCx6
-----END PGP SIGNATURE-----

--rb3yd7yh2odisgq3--
