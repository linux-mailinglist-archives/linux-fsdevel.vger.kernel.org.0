Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A313093F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 17:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEQvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 11:51:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgAEQvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 11:51:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so46997644wro.9;
        Sun, 05 Jan 2020 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NEc2ONIGqs4JDceykYjjlLRjytS3/UAT9WyX5gz4mJs=;
        b=tjb48Gq5Eki3T2ytZKMg7AKkC/7++9EXYp2y7ugEXaapzinQ03174dOAreazI2pqyn
         brOf1hasHLOWtg7T+fztXIh0ldiUhc+iWs/eBo5AlFjJt5dnyYa6tfYvEWebGFSevjus
         jgORj/yZmVP6ui/i8j55SPV0SLlSLKv7EIfB6/tVUFayLhMX85woO2xFccnub2CCB9do
         Z+VFaIs7Wx8eO3cY6IJz2h210opEi+DBoLTG5/TiDykaZU9MryyZ2bAjzrsFdFCV9oVH
         68SjF4m5VpOdTDIIb5+61z5KObjiRsNKJao+FaQkvlBfQBjIkjyhSgMcqP6tPJS0SWxD
         lsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NEc2ONIGqs4JDceykYjjlLRjytS3/UAT9WyX5gz4mJs=;
        b=LHh82GCX+hgefYpPppsoTTqy/T+KniPMS1h/UK51FwKQi06F7pIjkvtkoHCxZ1Ks8w
         xA801I2uMRhDxtWl6HR55VcmFxjZ1C7FM23ABCX88Zxw+hfzHNayG2q/l+I/sr+wKDqf
         hQL1D2uzCqUe28cbCmL9QYTN9uzEtyeVYEM1XbZwuLn8JEWXTP+fET/4VDcT8Yx+nskN
         yjQ1vlp/DuQkMyeWb0FxMyIWHVdcgXwPJ+RN874GhdHbPxD4pZ1uF6E1jMaog/Fd8Mq4
         +DsaBX42j4jxXMowuDd7gcbAI94mtgl5rq3lrTV5Knn1mPjT1w7rUgSeAOzBiK1IMcQr
         fCBA==
X-Gm-Message-State: APjAAAVa8eYPJ7k6ZPAt6Au56z6mBkS5sopZ5ozvzHjo5uHfyGOeWYMY
        0adUMotGI/g9XjZqIEnOpOQ=
X-Google-Smtp-Source: APXvYqzuHuM6YOph/540pvgdV/vmpzihUqFdaNRgnA39GiwzXbHTNa7ZlQchPuODUDxriKqsR7XWUA==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr52668317wrq.314.1578243077695;
        Sun, 05 Jan 2020 08:51:17 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h2sm74392376wrt.45.2020.01.05.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 08:51:16 -0800 (PST)
Date:   Sun, 5 Jan 2020 17:51:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, tytso@mit.edu,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200105165115.37dyrcwtgf6zgc6r@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
 <20200102082036.29643-11-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b4fesfv3w7a3u7ah"
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-11-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--b4fesfv3w7a3u7ah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> This adds the implementation of nls operations for exfat.

Hello! In whole patch series are different naming convention for
nls/Unicode related terms. E.g. uni16s, utf16s, nls, vfsname, ...

Could this be fixed, so it would be unambiguously named? "uni16s" name
is misleading as Unicode does not fit into 16byte type.

Based on what is in nls.h I would propose following names:

* unicode_t *utf32s always for strings in UTF-32/UCS-4 encoding (host
  endianity) (or "unicode_t *unis" as this is the fixed-width encoding
  for all Unicode codepoints)

* wchar_t *utf16s always for strings in UTF-16 encoding (host endianity)

* u8 *utf8s always for strings in UTF-8 encoding

* wchar_t *ucs2s always for strings in UCS-2 encoding (host endianity)

Plus in the case you need to work with UTF-16 or UCS-2 in little endian,
add appropriate naming suffixes.

And use e.g. "vfsname" (char * OR unsigned char * OR u8 *) like you
already have on some places for strings in iocharset=3D encoding.


Looking at the whole code + exfat specification and usage is:

Kernel NLS functions do conversion between UCS-2 and iocharset=3D.
exfat upcase table has definitions only for UCS-2 characters.
All exfat string structures are stored in UTF-16LE, except upcase table
which is in UCS-2LE.

It is great mess in specification, specially when it talks about Unicode
upcase table for case insensitivity, which is limited only to code
points up to the U+FFFF and does not say anything about Unicode
Normalization and Normal Forms.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

And this opens a new question, what should kernel do if userspace asks
to create these 4 files? (Assume that iocharset=3Duff8 for full Unicode
support)

1. U+00e9
2. U+0065, U+0301
3. U+00c9
4. U+0045, U+0301

According to Unicode uppercase algorithm, all 4 filenames results in
same grapheme "LATIN CAPITAL LETTER E WITH ACUTE".

But with current exfat implementation first and third are treated as
same and then second and fourth are treated as same. Therefore first and
fourth are treated as different filenames, even the fact that they
represent same grapheme just only one is upper case and one lower case.

To prevent such thing we need to use some kind of Unicode normalization
form here.

What do you think what should kernel's exfat driver do in this case?

CCing Gabriel as he was implementing some Unicode normalization for ext4
driver and maybe should bring some light to new exfat driver too.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--b4fesfv3w7a3u7ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhIT/QAKCRCL8Mk9A+RD
UmiXAJ4wRXGodYjANGPhNEOOoeAKpG5kpACgwCk0fQfxkYOKmrxsPYI5PHtS2Kc=
=DcG1
-----END PGP SIGNATURE-----

--b4fesfv3w7a3u7ah--
