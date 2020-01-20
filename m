Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF34143056
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 17:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgATQ4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 11:56:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40002 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgATQ4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:56:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so27117wmi.5;
        Mon, 20 Jan 2020 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l03WTNrKTQC5MGvzPNBY30UTO75BWr5Rgkv2u4ayoro=;
        b=ROjySfoOvPa8OYjeITdb0qF+NXnHnNrwRo5wLjbwgErHa9tN1hls2IF7eIwmncLX09
         fHL6mig8O69Inof4dLV7O0hDeFFbzpzuoCgnlV/yv5feWmxeIHo1JTJbTqtnsc9ZCdHm
         40hwczJ9GX+mrI9J7AaYqpHVf+ue/h+iWK7QjC9pWTzMagowjnlm62maunfJ6GJmRuoc
         ObFMyX64VnPUxuuvyNd4Ym+m7Dmd1bptNC76FDkPFyFwqUnh6sM5JsFhBj7+dfAJIM0m
         iiJwu5dMw8neXQ5w9roxCREwTRhhOfKGL8MNTvr3ckpHfYCRcH//DZlrr/q4iGkYT8u8
         h/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l03WTNrKTQC5MGvzPNBY30UTO75BWr5Rgkv2u4ayoro=;
        b=Q8ldlPdc1L5u/+y41q7FxQzV4waNRAMKg9hYHIJwWSz4UsOIBey5Ye/oGaEraVpdJD
         kYAVEi2bbO+bZgoFA/dyvsIN056GgwHkeuQWwa575dmxXDUXQY2CA26EXniXYIueOb9D
         BAVr9OzNzZf1cVPLVrDAh5tWQa98nDVvFHnOJaUFUkUcTvSWloaFvpKyQBl4Mbkb8nOd
         Y9L5P+SJ9LFDkuH+Ou2rRywl/tBnp6DwVp3Cf7ayZWEeLJ2RS2StfL+Sqe4YbqXN+Hfm
         8d++cKcpsrkDKoHKs+Q5CHqK9iiVfW0PV04nQfJOaTOutyE3FoiIVEgm+Vh4oTn0RB0p
         Wfag==
X-Gm-Message-State: APjAAAWNgPC92u18gz11q4huG8VKIAwHrsPx7AqVYp52dQzMcCbIwCAi
        2GWFkUTDHyTIX+QpNXvpJcM=
X-Google-Smtp-Source: APXvYqxVTGZ/hNNKU9GlL6hTSquhGMZWUbQgRUTLQdxRwE+BwRTJSFRBSKoRb9HfcB6IVux2m+T7Fg==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr238030wmi.37.1579539375549;
        Mon, 20 Jan 2020 08:56:15 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x16sm305227wmk.35.2020.01.20.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:56:14 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:56:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120165614.yp3pukpj3ilq6nxp@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
 <20200120152009.5vbemgmvhke4qupq@pali>
 <1a4c545dc7f14e33b7e59321a0aab868@AcuMS.aculab.com>
 <20200120162701.guxcrmqysejaqw6y@pali>
 <b42888a01c8847e48116873ebbbbb261@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7vl3wb4i55lghd6k"
Content-Disposition: inline
In-Reply-To: <b42888a01c8847e48116873ebbbbb261@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7vl3wb4i55lghd6k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 20 January 2020 16:43:21 David Laight wrote:
> From: Pali Roh=C3=A1r
> > Sent: 20 January 2020 16:27
> ...
> > > Unfortunately there is neither a 1:1 mapping of all possible byte seq=
uences
> > > to wchar_t (or unicode code points),
> >=20
> > I was talking about valid UTF-8 sequence (invalid, illformed is out of
> > game and for sure would always cause problems).
>=20
> Except that they are always likely to happen.

As wrote before, Linux kernel does not allow such sequences. So
userspace get error when is trying to store garbage.

> I've been pissed off by programs crashing because they assume that
> a input string (eg an email) is UTF-8 but happens to contain a single
> 0xa3 byte in the otherwise 7-bit data.
>=20
> The standard ought to have defined a translation for such sequences
> and just a 'warning' from the function(s) that unexpected bytes were
> processed.

There is informative part, how to replace invalid part of sequence to
Unicode code point U+FFFD. So if your need to to "process any byte
sequence as UTF-8" there is standardized way to convert it into one
exact sequence of Unicode code points. This is what email programs
should do and non-broken are already doing it.

> > > nor a 1:1 mapping of all possible wchar_t values to UTF-8.
> >=20
> > This is not truth. There is exactly only one way how to convert sequence
> > of Unicode code points to UTF-8. UTF is Unicode Transformation Format
> > and has exact definition how is Unicode Transformed.
>=20
> But a wchar_t can hold lots of values that aren't Unicode code points.
> Prior to the 2003 changes half of the 2^32 values could be converted.
> Afterwards only a small fraction.

wchar_t in kernel can hold only subset of Unicode code points, up to
the U+FFFF (2^16-1).

Halves of surrogate pairs are not valid Unicode code points but as
stated they are used in MS FAT.

So anything which can be put into kernel's wchar_t is valid for FAT.

>=20
> > If you have valid UTF-8 sequence then it describe one exact sequence of
> > Unicode code points. And if you have sequence (ordinals) of Unicode code
> > points there is exactly one and only one its representation in UTF-8.
> >=20
> > I would suggest you to read Unicode standard, section 2.5 Encoding Form=
s.
>=20
> That all assumes everyone is playing the correct game

And why should we not play correct game? On input we have UTF and
internally we works with Unicode. Unicode codepoints does not leak from
kernel, so we can play correct game and assume that our code in kernel
is correct (and if not, we can fix it). Plus when communicating with
outside word, just check that input data are valid (which we already do
for UTF-8 user input).

So I do not see any problem there.

> > > Really both need to be defined - even for otherwise 'invalid' sequenc=
es.
> > >
> > > Even the 16-bit values above 0xd000 can appear on their own in
> > > windows filesystems (according to wikipedia).
> >=20
> > If you are talking about UTF-16 (which is _not_ 16-bit as you wrote),
> > look at my previous email:
>=20
> UFT-16 is a sequence of 16-bit values....

No, this is not truth. UTF-16 is sequence either of 16-bit values or of
32-bit values with other restrictions. UTF-16 is variable length enc.

> It can contain 0xd000 to 0xffff (usually in pairs) but they aren't UTF-8 =
codepoints.
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

--7vl3wb4i55lghd6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiXbrAAKCRCL8Mk9A+RD
UgSWAJ4ktl8RuEWLboJtM53qzi+wvlI2UwCfWQmIzJHZ//yydpo769G/FVDYQSo=
=9ZkE
-----END PGP SIGNATURE-----

--7vl3wb4i55lghd6k--
