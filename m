Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8E132D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgAGRir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:38:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56285 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgAGRiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:38:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so391683wmj.5;
        Tue, 07 Jan 2020 09:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UDJ8iFEh0aT3XRBjDUtj+5yED1IZ3Xq7M2iH1ATPT9k=;
        b=Meu8tDGf+9Oi621KmTxxNn/4M8q5vRm1K5UNhLCERDDplY19yg2I6Lcwf4dvqYUvrS
         n9yIMB0++fEra3BC7w4hMJnmhgjv/0LZM9jGRnISJnjttfZGzP9xXMst1DgfYN24gIVk
         +Ki5j71eXXhAJVV7Jpnvv/URIIy40S4UaqMcOs0ETquYskWTWpD1lttPwQ9d2xn3Tqtg
         HAKuYddqhUnBF605CrcQ3dnGLIQUmRuGOob3w8mmrPALZaFZCZHGgBSRUN5a0dZiNlHe
         J3pvwSPRPIw3ngd/v07NOKFKtMM0Ph4a56oVRN3+XtVwXG10FibOlBw+1T7slZSjEpFk
         icdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UDJ8iFEh0aT3XRBjDUtj+5yED1IZ3Xq7M2iH1ATPT9k=;
        b=otGNsKY+EB/XIPYx6TlqISBH/JFHTO6nqeOq0F+PFanUqu1L9fzVyljEYBIZtcd1d6
         xY2ZXTL0vXQ4lPHpEVcfcTatdRFMo/dCwUh1tB99Pu7+6ZAkq7+5qiu40hQq/5SbSAUl
         avUnR5m1KcP9Mt28o51OVIPl37AOHs9oK89JLcPZpFyuSJ7bOYM1oL6FI5KdMah9pQHH
         4rRSqGOKLarSvSL7TAjJ4zwxbp11GR0j1QVSenFgLu+MdjsvfU80egENGmsGumZGH+O3
         LMlv/5qC+Ud9eMSIdjvirPeHe43KaEQV6J1RgfRxtbL4htkJeUyMG3Ghs1Om+xDUhcik
         tdIA==
X-Gm-Message-State: APjAAAVIJIBIC4X2moLb8HbY7VIHi0Vlh/RFEGt+wi4O0BJIDC1WaXXH
        CujmyyGwinzQVD7/0lkXB9U=
X-Google-Smtp-Source: APXvYqzwLRulzQbtxC/ILXD1jYjGPIVShe805pZOTDvpMu4Plb8/5UsUdltQgFOzbeaaErb+AbS2kg==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr146049wma.117.1578418724124;
        Tue, 07 Jan 2020 09:38:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id m21sm374927wmi.27.2020.01.07.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:38:43 -0800 (PST)
Date:   Tue, 7 Jan 2020 18:38:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
        Jan Kara <jack@suse.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Unification of filesystem encoding options
Message-ID: <20200107173842.ciskn4ahuhiklycm@pali>
References: <20200102211855.gg62r7jshp742d6i@pali>
 <20200107133233.GC25547@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uelhbz7cmchbh2fr"
Content-Disposition: inline
In-Reply-To: <20200107133233.GC25547@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uelhbz7cmchbh2fr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 January 2020 14:32:33 Jan Kara wrote:
> On Thu 02-01-20 22:18:55, Pali Roh=C3=A1r wrote:
> > 1) Unify mount options for specifying charset.
> >=20
> > Currently all filesystems except msdos and hfsplus have mount option
> > iocharset=3D<charset>. hfsplus has nls=3D<charset> and msdos does not
> > implement re-encoding support. Plus vfat, udf and isofs have broken
> > iocharset=3Dutf8 option (but working utf8 option) And ntfs has deprecat=
ed
> > iocharset=3D<charset> option.
> >=20
> > I would suggest following changes for unification:
> >=20
> > * Add a new alias iocharset=3D for hfsplus which would do same as nls=3D
> > * Make iocharset=3Dutf8 option for vfat, udf and isofs to do same as ut=
f8
> > * Un-deprecate iocharset=3D<charset> option for ntfs
> >=20
> > This would cause that all filesystems would have iocharset=3D<charset>
> > option which would work for any charset, including iocharset=3Dutf8.
> > And it would fix also broken iocharset=3Dutf8 for vfat, udf and isofs.
>=20
> Makes sense to me.

Ok!

> > 2) Add support for Unicode code points above U+FFFF for filesystems
> > befs, hfs, hfsplus, jfs and ntfs, so iocharset=3Dutf8 option would work
> > also with filenames in userspace which would be 4 bytes long UTF-8.
>=20
> Also looks good but when doing this, I'd suggest we extend NLS to support
> full UTF-8 rather than implementing it by hand like e.g. we did for UDF.

Current kernel NLS framework API supports upper-case / lower-case
conversion only for single byte encodings. So no case-insensitive
support for UTF-8 encoding. And for Unicode conversion it supports only
UCS-2, therefore code points up to the U+FFFF, so for UTF-8 maximally
3byte long sequences.

This really is not possible to fix without rewriting existing
filesystems which uses NLS API.

One hacky option would be to extend NLS API from UCS-2 to UTF-16 and fix
all users of NLS API to expects UTF-16 surrogate pairs.

But I dislike UTF-16 and rather would use usage of unicode_t (UTF-32)
which is already present in kernel. But because existing filesystems
drivers pass their UCS-2/UTF-16 buffers from FS to NLS API it is not
easy to change whole NLS API from UCS-2 to UTF-32.

And still this change does not add support for case-insensitivity, so
is useless for all MS filesystems (msdos, vfat, ntfs), which is
majority.

Kernel already provides functions for converting between UTF-8 and
UTF-16, so this seems to be the easiest way how to provide full UTF-8
support for filesystems which internally uses UTF-16. Similarly like it
is implemented in UDF.

Moreover all NLS encodings except UTF-8 are single byte encodings and
maps into Plane-0, so can be represented by currently used UCS-2
encoding. Therefore conversion to Unicode works correctly and also their
case-insensitivity functions (or rather tables).

Adding support for case-insensitivity into UTF-8 NLS encoding would mean
to create completely new kernel NLS API (which would support variable
length encodings) and rewrite all NLS filesystems to use this new API.
Also all existing NLS encodings would be needed to port into this new
API.

It is really something which have a value? Just because of UTF-8?

For me it looks like better option would be to remove UTF-8 NLS encoding
as it is broken. Some filesystems already do not use NLS API for their
UTF-8 support (e.g. vfat, udf or newly prepared exfat). And others could
be modified/extended/fixed in similar way.

> > 3) Add support for iocharset=3D and codepage=3D options for msdos
> > filesystem. It shares lot of pars of code with vfat driver.
>=20
> I guess this is for msdos filesystem maintainers to decide.

Yes!

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--uelhbz7cmchbh2fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhTCIAAKCRCL8Mk9A+RD
UsF7AJ9F2SRZ9iGtWdPUOIf/F7cGh/vSfQCgnZEHYTrE7RxwVOhGPebC7+Gdz1g=
=zjaq
-----END PGP SIGNATURE-----

--uelhbz7cmchbh2fr--
