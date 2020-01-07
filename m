Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309861330A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 21:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgAGUhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 15:37:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37958 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgAGUhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:37:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so1019978wrh.5;
        Tue, 07 Jan 2020 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XaL6t4v2vQUuUGBKgzCS+DPAs1rbOJ+x6CyTwGXWZL0=;
        b=C/67CYdw9EiQTFkhFOwzG+gP69UccHKLh6hfprav8IpJr0WD44mZdr9L0I3GqHUVCR
         69B49Dtk6DdGFFD96VjQpGzVRINXuzjfBYTdbu3BBIrM3Y6GOf2C8U1DOEhjyz/JV0Kw
         aDGH2skhGmNK5EHAIhCzbiSh47rqgBtqxTxf3117roTrL09CcWRlEG5PYlWMfRJlz4yh
         bLIHla0MAFoFcee11+QehjnhjA3kkAjIBzP+ykypocJCRQGmx492N0eda6mclwoZuW6u
         kMKoBXA9s8fDoVpePlCUv94RD/myDhPz/3B3aCQYFmny7I6I79rLoxU2ZSTcHHXv+M+a
         aTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XaL6t4v2vQUuUGBKgzCS+DPAs1rbOJ+x6CyTwGXWZL0=;
        b=By8vFvBIgS12NLPKclqzToubROVAFBEMNTqqmOaHRh/DCMohLkY6zmPNYmgFM4Z8Cn
         Zl7t/nHtMJGqkH7pY7RUqGCsFy8sFDJXAHOaQQwL+bRtC33vsdJFfZePFerJZtBRvk9G
         cJ1KnyZg9aZgjZ2INFy7ilI/X9yAKfHIM6RxZ3GkCj51aqjH4O0/C91SPeKYnKmzIJ10
         3G8hbMjGMopsPl6ObsHp26+4AVFn+t0ed/3nb9J9RcB7MVW2p12cTDfK6D+A+mEmlhRu
         M6alME6CSUxevy84i9C55uX7L8EGXEd5+9ZQsjfRCSpDphm8wKbBMPaxp+9tOiFvkRF4
         MKAQ==
X-Gm-Message-State: APjAAAXhp2FPhPR7hiQmklsN+tm9WsvD7MST/26M2x1VtMnTRVzXWZwr
        vH0WMwM9/X9nak9hYOjToYSNTsJA/1k=
X-Google-Smtp-Source: APXvYqyD0plNPIcXsFUAfF5pcRe9N7C+GGkj6Hfr9SCzoDTfpq5AQglUrgRw/V+S9kk8LgpZ51NLkw==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr969096wrx.304.1578429454861;
        Tue, 07 Jan 2020 12:37:34 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o129sm957337wmb.1.2020.01.07.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 12:37:33 -0800 (PST)
Date:   Tue, 7 Jan 2020 21:37:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Unification of filesystem encoding options
Message-ID: <20200107203732.ab4jnfgsjobtt5xa@pali>
References: <20200102211855.gg62r7jshp742d6i@pali>
 <20200107133233.GC25547@quack2.suse.cz>
 <20200107173842.ciskn4ahuhiklycm@pali>
 <20200107200301.GE3619@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="77fn7474fypyqytm"
Content-Disposition: inline
In-Reply-To: <20200107200301.GE3619@mit.edu>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--77fn7474fypyqytm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 January 2020 15:03:01 Theodore Y. Ts'o wrote:
> On Tue, Jan 07, 2020 at 06:38:42PM +0100, Pali Roh=C3=A1r wrote:
> > Adding support for case-insensitivity into UTF-8 NLS encoding would mean
> > to create completely new kernel NLS API (which would support variable
> > length encodings) and rewrite all NLS filesystems to use this new API.
> > Also all existing NLS encodings would be needed to port into this new
> > API.
> >=20
> > It is really something which have a value? Just because of UTF-8?
> >=20
> > For me it looks like better option would be to remove UTF-8 NLS encoding
> > as it is broken. Some filesystems already do not use NLS API for their
> > UTF-8 support (e.g. vfat, udf or newly prepared exfat). And others could
> > be modified/extended/fixed in similar way.
>=20
> You didn't mention ext4 and f2fs, which is using the Unicode code in
> fs/unicode for its case-folding and normalization support.

Hi! I have not mentioned because I took only filesystems which use NLS.
And also I forgot that ext4 now has unicode flag which basically put
this filesystem into group where FS "enforce" encoding of on disk
structure.

> Ext4 and
> f2fs only supports utf-8, so using the NLS API would have added no
> value --- and it as you pointed out, the NLS API doesn't support
> variable length encoding anyway.

Theoretically using NLS API could have a value if userspace is
configured to work in e.g. Latin1 encoding and you want to use ext4/f2fs
with unicode flag in this userspace (NLS API in this case could convert
3byte UTF-8 to Latin1). But it is very theoretical and limited use case.

> In contrast the fs/unicode functions
> have support for full Unicode case folding and normalization, and
> currently has the latest Unicode 12.1 tables (released May 2019).

That is great!

But for example even this is not enough for exfat. exfat has stored
upcase table directly in on-disk FS, so ensure that every implementation
of exfat driver would have same rules how to convert character (code
point) to upper case or lower case (case folding). Upcase table is
stored to FS itself when formatting. And in MS decided that for exfat
would not be used any Unicode normalization. So this whole fs/unicode
code is not usable for exfat.

> What I'd suggest is to create a new API, enhancing the functions in
> fs/unicode, to support those file systems that need to deal with
> UTF-16 and UTF-32 for their on-disk directory format, and that we
> assume that for the most part, userspace *will* be using a UTF-8
> encoding for the user<->kernel interface.

I do not see a use-case for such a new API. Kernel has already API
functions:

    int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
    int utf32_to_utf8(unicode_t u, u8 *s, int maxlen);
    int utf8s_to_utf16s(const u8 *s, int len, enum utf16_endian endian, wch=
ar_t *pwcs, int maxlen);
    int utf16s_to_utf8s(const wchar_t *pwcs, int len, enum utf16_endian end=
ian, u8 *s, int maxlen);

which are basically enough for all mentioned filesystems. Maybe in for
some cases would be useful function utf16 to utf32 (and vice-versa), but
that is all. fs/unicode does not bring a new value or simplification.

Mentioned filesystems are in most cases either case-sensitive (UDF),
having own case-folding (exfat), using own special normalization
incompatible with anything (hfsplus) or do not enforce any normalization
(cifs, vfat, ntfs, isofs+joliet). So result is that simple UTF-8 to
UTF-16LE/BE conversion function is enough and then filesystem module
implements own specific rules (special upcase table, incompatible
normalization).

And I do not thing that it make sense to extending fs/unicode for every
one stupid functionality which those filesystems have and needs to
handle. I see this as a unique filesystem specific code.

> We can keep the existing
> NLS interface and mount options for legacy support, but in my opinion
> it's not worth the effort to try to do anything else.

NLS interface is crucial part of VFAT. Reason is that in VFAT can be
filenames stored either as UTF-16LE or as 8bit in some CP encoding.
Linux kernel stores new non-7-bit-ASCII filenames as UTF-16LE, but it
has to able to read 8-bit filenames which were not stored as UTF-16LE,
but rather as 8bit in CP encoding. And therefore mount option codepage=3D
which specify it is required needs to be implemented. It says how
vfat.ko should handle on-disk structure, not which encoding is exported
to userspace (those are two different things).

And current vfat implementation uses NLS API for it. Via CONFIG_* is
specified default codepage=3D mount option (CP473 or what it is -- if you
do not specify one explicitly at mount time). And because FAT is
required part of UEFI, Linux kernel would have to support this stuff
forever (or at least until it support UEFI). I think this cannot be
marked as "legacy". It is pity, but truth.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--77fn7474fypyqytm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhTsCgAKCRCL8Mk9A+RD
UtPtAKCm4SOQXuN/Oeg6lDHCG/Gp5bqLKgCfTCeg9MXar+6v7z2MH87xYH2CpYo=
=utpq
-----END PGP SIGNATURE-----

--77fn7474fypyqytm--
