Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC67315DAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 04:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBJDEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 22:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhBJDED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 22:04:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A08DC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 19:03:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t29so331636pfg.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 19:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Wxig3GtqxXedKbj9Q8kimXAwZFTS7x210dcgDCTLRfY=;
        b=DDcRoN4TcDmavE86AWNMBt2uA1D+sWvA2oy6qvrIIlGMHJqBXNjyJOxNZu2jqrLTMv
         ovbL7oZaBfrHUcbLFUaGtoYPMKuLDmL8Vp/a7RfWcEuahUIEg9BkNtn+jEL8x7r+VSQy
         be+bk+4Hp0Or2Bb8nKu7yDYVEpAVnG49mI4j+AxBY7RxT0DxRvvPjMS74Wmd4ZTg3sKu
         3OdkhfJTYJRIl7TAjuFvjxx5vwfyzYK0/TfaXaQGKK7MvbvrcQ0x7zU1xYKCg1qe9+N/
         g4A+UnbaPb195lia2MMaEbQ0ERI9oJAdIAit3tJg8aE2XLXjMghSwCoEyWDt6spe8afZ
         WcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Wxig3GtqxXedKbj9Q8kimXAwZFTS7x210dcgDCTLRfY=;
        b=LMk/DXeM1efIlZDBQAoZiQor1AeojQPs8wFvUcwvWvHePaaL0aF0AGz+uHDWto0+3T
         iflZyBEHfcP67yssexssMKYztfBGfX0qttw5ftEZU7UpePWRGMHmaNsJRDRPxDxI2vC+
         eIElIsgng+XpSE2U0w9cpmzbB0895U9KWhGe19R17t6MZVi2YlX+feUpZ01R0Yil4xv/
         Jk858/reOnJb1NpEUkifoTg0RnO8CTHVBLLme2EmOud4CqaavCkB/uGZ4v/3QhjZU6G3
         eDpAx+SIz9wkklJeq5E8f6iL+nNnqPXrRDC02ezV59trEFZYXCHhc9IvHEU0LOJqWOYp
         Dxlw==
X-Gm-Message-State: AOAM532tOepK5vIt6Gai5kBJ632YGfrRcNluHORCIOQoYAmqylpDjGb5
        4SOKsUa1GhXqKZQvhp2QV02aXw==
X-Google-Smtp-Source: ABdhPJyMAErOvZnDMTtvq5oKl3tV/0/Y/Ob/H2mzAkeSogBoC23ivxgzqWS7JviWmOOhMSaIjyTc7w==
X-Received: by 2002:a65:4bc3:: with SMTP id p3mr1042950pgr.318.1612926194562;
        Tue, 09 Feb 2021 19:03:14 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c18sm284977pfo.171.2021.02.09.19.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:03:13 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <42511E9D-3786-4E70-B6BE-D7CB8F524912@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B97C2B2A-E3FE-4E74-A627-67973AE4DA7B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
Date:   Tue, 9 Feb 2021 20:03:10 -0700
In-Reply-To: <YCMZSjgUDtxaVem3@mit.edu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20210203090745.4103054-2-drosen@google.com>
 <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca> <YBrP4NXAsvveIpwA@mit.edu>
 <YCMZSjgUDtxaVem3@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_B97C2B2A-E3FE-4E74-A627-67973AE4DA7B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 9, 2021, at 4:22 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Wed, Feb 03, 2021 at 11:31:28AM -0500, Theodore Ts'o wrote:
>> On Wed, Feb 03, 2021 at 03:55:06AM -0700, Andreas Dilger wrote:
>>>=20
>>> It looks like this change will break the dirdata feature, which is =
similarly
>>> storing a data field beyond the end of the dirent. However, that =
feature also
>>> provides for flags stored in the high bits of the type field to =
indicate
>>> which of the fields are in use there.
>>> The first byte of each field stores
>>> the length, so it can be skipped even if the content is not =
understood.
>>=20
>> Daniel, for context, the dirdata field is an out-of-tree feature =
which
>> is used by Lustre, and so has fairly large deployed base.  So if =
there
>> is a way that we can accomodate not breaking dirdata, that would be
>> good.
>>=20
>> Did the ext4 casefold+encryption implementation escape out to any
>> Android handsets?
>=20
> So from an OOB chat with Daniel, it appears that the ext4
> casefold+encryption implementation did in fact escape out to Android
> handsets.  So I think what we will need to do, ultiumately, is support
> one way of supporting the casefold IV in the case where "encryption &&
> casefold", and another way when "encryption && casefold && dirdata".
>=20
> That's going to be a bit sucky, but I don't think it should be that
> complex.  Daniel, Andreas, does that make sense to you?

I was just going to ping you about this, whether it made sense to remove
this feature addition from the "maint" branch (i.e. make a 1.45.8 =
without
it), and keep it only in 1.46 or "next" to reduce its spread?

Depending on the size of the "escape", it probably makes sense to move
toward having e2fsck migrate from the current mechanism to using dirdata
for all deployments.  In the current implementation, tools don't really
know for sure if there is data beyond the filename in the dirent or not.

I guess it is implicit with the casefold+encryption case for dirents in
directories that have the encryption flag set in a filesystem that also
has casefold enabled, but it's definitely not friendly to these features
being enabled on an existing filesystem.

For example, what if casefold is enabled on an existing filesystem that
already has an encrypted directory?  Does the code _assume_ that there =
is
a hash beyond the name if the rec_len is long enough for this?  There =
will
definitely be some pre-existing dirents that will have a large rec_len
(e.g. those at the end of the block, or with deleted entries immediately
following), that do *not* have the proper hash stored in them.  There =
may
be random garbage at the end of the dirent, and since every value in the
hash is valid, there is no way to know whether it is good or bad.

With the dirdata mechanism, there would be a bit set in the "file_type"
field that will indicate if the hash was present, as well as a length
field (0x08) that is a second confirmation that this field is valid.

Cheers, Andreas






--Apple-Mail=_B97C2B2A-E3FE-4E74-A627-67973AE4DA7B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAjTO4ACgkQcqXauRfM
H+CUXQ//UF7Nr25/LRaBips06YAxdNieUkUiO17hkfLNFs+ul1Ru7Bpbb9uyyzQ/
i9GtW4QtBy0wQiG6NiYRUHcd96cORUx+DKIERr5Faw5hMd3PeigL90YYLLcjxFnf
QJw9qc/8CjeAb0P8nAZOWFcnyi0FbEsZgQLG174j1kO8n30kYeliW3Y12oMpOTEG
boYJHIehffrkLO4ctD304dX3933j4Na4MUsM9f2Mtiunr8XR9gimjcx77TkPQ272
XLl1OXPNB0w2ZANzlzdsEX5cBZETglzwFNQ7cPRZ4f8Tw1PGD/wdoGBClgE8OBdg
5Ptfe1oW7QlN1YOnk0jDWjvJ2YaiRpf638yeGUuMz2tU1DIqBSNOjwGj20n8FXz9
wkATmC+o+l7jpE+mk87G38O6u2cdZJvGIDwcUKE31PRvZJ58OVgLs1dVMNbSjRAh
jSoMNUUxEAvWj/ATJl5+vx9453F4dta9E29BlIs8ArQDEKrMRbtuZKWYA4X6lSzY
kLLFH1uGyWRRrt2Vxc3PuIxU/JVWYTWGKAomXSNy574yMPTYWMq3SGqTiy7QwSc2
OlghMC62ms4m/Gv9f7OitxPJjRRa7S2uToVbGWAcRubIkCYLFbM2+/7r9sHOE8iQ
jZw+5CCqYnEejicxWyNIDO20kP+x/z7BQbQED/0DoqrEPq1Zl5s=
=IOgG
-----END PGP SIGNATURE-----

--Apple-Mail=_B97C2B2A-E3FE-4E74-A627-67973AE4DA7B--
