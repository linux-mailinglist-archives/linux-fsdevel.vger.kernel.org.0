Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953748C8FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 18:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355412AbiALRBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 12:01:46 -0500
Received: from mout.web.de ([212.227.15.3]:46721 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349807AbiALRBp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:01:45 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 12:01:44 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642006904;
        bh=VpwX7tXhTbrLuzi1YF8Uzmb4A2oBhdUT14fAMPWrFis=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PeskKWovL/ACSiPTBh401vUzji0my+TACRDRioT7OKxnbJRg38vK9L8VFKIJbqPcI
         KXjyohg8wbSuXw6mRJ/2iQZJDVi6V7V1HeWGMM4MpinLd1V/Nl02zr+lUveXqI73dF
         dKp91ZyAl1wVDk5yZVzUixu1s0L2gub2JgC+352M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.151.70]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1n1fJI3tgc-006XPY; Wed, 12
 Jan 2022 17:56:15 +0100
Date:   Wed, 12 Jan 2022 16:56:12 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org
Subject: Re: [dm-devel] Proper way to test RAID456?
Message-ID: <20220112155351.5b670d81@gecko>
In-Reply-To: <24998019-960c-0808-78df-72e0d08c904e@gmx.com>
References: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
        <20220108195259.33e9bdf0@gecko>
        <20220108202922.6b00de19@gecko>
        <5ffc44f1-7e82-bc85-fbb1-a4f89711ae8f@gmx.com>
        <e209bfe191442846f66d790321f2db672edfb8ca.camel@infradead.org>
        <24998019-960c-0808-78df-72e0d08c904e@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/trK2B+bQZg4U+J+J8zLUK/8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:heywFokXSb224cpwvQrsi2v/LXbEHOE0r74vVZ0tAW61GPjbn6c
 eDdc9ppwND/oggCfxDn5DN/mNAEMOVaVO4sSRcD5N3Lu0QPeZ0mcwnxvixwiuMB9gADj3xX
 dVwYWnfBfnpweGh1YlYWJL76eTBrK6kgl6tA9RTyCdIlzfqKoVwEtzccIk2kpvTVW8uMHiR
 nbXSeKAdNKk+mM7NioWjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HoFGdC2jWiw=:IO49La0OrTdQ2Ah/QSu86R
 PInkEFYz0f7sLMKmILByyxEbjUOcCQgktOoaHafjY777p5GLH7bbCdB8Jz7611+wkdnpBRu7r
 uOsURFWjr4Uv/Va3/HJqSR2CzbbVn/T4mQUwGUfZe+gJF9uOHT1FEj2hL8swfEpA2hKBagFFG
 ahOztmFrt5u5vJ+7cSOi66FDfXwg9xr7L+ocsKIuXF/gA0XBzD4/9jsCrEtjlIhgfw4L/JcVT
 E6XNq63820FwJ/iQvuDpBIH7/1f5WVZBonMyexMx7FEDeE98Q1hfz+DbMiFXMUDMajCB3yAgX
 aRhDNXsrCu0seOZLJYeQNzhjJ7q3MmVx/71Ur8SzphSEKAm/Yp1bCE4Nqcyx19SZxUSSgJfso
 MeWdPL9FHR+oRO8iNFcc6YA9p52dilbL6s7ycJbAr7RwVpXs/EZaD/3CZMIuKKFcwtkb8w+gA
 DfKTiGgkSf7PndQWkSk260pTzE9gj6L9HpgoS74v5hXd27wuXTQxjM6UiAjcl0ujB3+TUni3e
 cTO0EOcBYgpy85HayzEQMcnWDbP7A+Wia9gkjREnmEwhjLeBkWENf83z1uOo2AiX7V+pwgwv1
 qMOLIOomVl+0Tr+FpBW+X4pFXqkvS+TEpeRgKny27cY00YaWBhLoiNXnIKAEidd/qA5WQbIJ5
 alM8JfrfHK4cmMBtX+E/zwqH/HYaOtP58bwh8pjyNfJOjgqe0ym3ej6CcfCMHP3ci1YhzhmbL
 sIMjcCUlLCD5ILBna9NQElbEAfcSACWI/bkz+g4kAehupxO6RM+2C6Msg7t0l/uclPPw6+wS+
 d7OHze5YbfgRLNDHLyxYbl3cwM6zLgWj0i4pdXXSiinBcnh+JNndgXR4TR/Mcg6BqEcQJDJ+U
 O3x24kK3e9PlhPSxSuHspAc1qoSqghi86xAX8NCS2y95PAceQbjOv01dZDBQCijS/L3xo8aTt
 sdhGSC2NrB4ibyEf6PEKhxNZINhJX4JlFi9/VgOcnhsbyNjXw99oAo5wq99zxF50iolzY2bzw
 U4/2Xn2bc4Sb9HdUEj8iOqHOx0g8+IWNXuvX7S3ZnfQbINbYU8F07rFS+GO+YZOtVaEBSZg1W
 4GFIFl2Xg7/rdQ=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/trK2B+bQZg4U+J+J8zLUK/8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Jan 2022 20:13:36 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> On 2022/1/9 18:04, David Woodhouse wrote:
> > On Sun, 2022-01-09 at 07:55 +0800, Qu Wenruo wrote: =20
> >> On 2022/1/9 04:29, Lukas Straub wrote: =20
> >>> But there is a even simpler solution for btrfs: It could just not tou=
ch
> >>> stripes that already contain data. =20
> >>
> >> That would waste a lot of space, if the fs is fragemented.
> >>
> >> Or we have to write into data stripes when free space is low.
> >>
> >> That's why I'm trying to implement a PPL-like journal for btrfs RAID56=
. =20
> >
> > PPL writes the P/Q of the unmodified chunks from the stripe, doesn't
> > it? =20
>=20
> Did I miss something or the PPL isn't what I thought?
>=20
> I thought PPL either:
>=20
> a) Just write a metadata entry into the journal to indicate a full
>     stripe (along with its location) is going to be written.
>=20
> b) Write a metadata entry into the journal about a non-full stripe
>     write, then write the new data and new P/Q into the journal
>=20
> And this is before we start any data/P/Q write.
>=20
> And after related data/P/Q write is finished, remove corresponding
> metadata and data entry from the journal.
>=20
> Or PPL have even better solution?

Yes, PPL is a bit better than a journal as you described it (md
supports both). Because a journal would need to be replicated to
multiple devices (raid1) in the array while the PPL is only written to
the drive containing the parity for the particular stripe. And since the
parity is distributed across all drives, the PPL overhead is also
distributed across all drives. However, PPL only works for raid5 as
you'll see.

PPL works like this:

Before any data/parity write either:

 a) Just write a metadata entry into the PPL on the parity drive to
    indicate a full stripe (along with its location) is going to be
    written.

 b) Write a metadata entry into the PPL on the parity drive about a
    non-full stripe write, including which data chunks are going to be
    modified, then write the XOR of chunks not modified by this write in
    to the PPL.

To recover a inconsistent array with a lost drive:

In case a), the stripe consists only of newly written data, so it will
be affected by the write-hole (this is the trade-off that PPL makes) so
just standard parity recovery.

In case b), XOR what we wrote to the PPL (the XOR of chunks not
modified) with the modified data chunks to get our new (consistent)
parity. Then do standard parity recovery. This just works if we lost a
unmodified data chunk.
If we lost a modified data chunk this is not possible and just do
standard parity recovery from the beginning. Again, the newly written
data is affected by the write-hole but existing data is not.
If we lost the parity drive (containing the PPL) there is no need to
recover since all the data chunks are present.

Of course, this was a simplified explanation, see drivers/md/raid5-ppl.c
for details (it has good comments with examples). This also covers the
case where a data chunk is only partially modified and the unmodified
part of the chunk also needs to be protected (by working on a per-block
basis instead of per-chunk).

The PPL is not possible for raid6 AFAIK, because there it could happen
that you loose both a modified data chunk and a unmodified data chunk.

Regards,
Lukas Straub

> >
> > An alternative in a true file system which can do its own block
> > allocation is to just calculate the P/Q of the final stripe after it's
> > been modified, and write those (and) the updated data out to newly-
> > allocated blocks instead of overwriting the original. =20
>=20
> This is what Johannes is considering, but for a different purpose.
> Johannes' idea is to support zoned device. As the physical location a
> zoned append write will only be known after it's written.
>=20
> So his idea is to maintain another mapping tree for zoned write, so that
> full stripe update will also happen in that tree.
>=20
> But that idea is still in the future, on the other hand I still prefer
> some tried-and-true method, as I'm 100% sure there will be new
> difficulties waiting us for the new mapping tree method.
>=20
> Thanks,
> Qu
>=20
> >
> > Then the final step is to free the original data blocks and P/Q.
> >
> > This means that your RAID stripes no longer have a fixed topology; you
> > need metadata to be able to *find* the component data and P/Q chunks...
> > it ends up being non-trivial, but it has attractive properties if we
> > can work it out. =20



--=20


--Sig_/trK2B+bQZg4U+J+J8zLUK/8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmHfCCwACgkQNasLKJxd
slj5YRAAriTi+zPKCzdoJ0d2cj8ZkHXtVoQMa5qr3R5f20aEyu/oTPkMFvmtsOKj
ViMcFhTaV5Ceardq7Td7G3N2QzBJjEQsrg0FIl6aD9Jp8XWW49VwXRTyHihXi7xy
HRCziWCxp8HWc6qy3IpOCm/XD3i0i37IDrm8dmA7r62swOALFX5g5zIpDo/CkfNU
Tln3wA97KMEd93dWLzvWZsXFhETQ2lX9l5EMYzTjUqR0PAtbVJlHfeVYTnF1eAnw
S5+TyiwfXa0lqOKUABYR8Ygnelu98VROpNWXUJi25CaY8l2T5jigskFdNvm+Ihy+
era4R8dAsXCBhTEmO4JXNLmE42IU+m+6DnZlGHxn+v3wuh7Tz46sAAC9JX73R6Fk
e925eXQ2e2df7Ej964r3f4u/yiVO+/MaoiLUacz+U3VbZu9LOGYJ+xmnmycjhV3X
NmfBV1nnWIeYU6fHvRigLCMJXnVd9dPlYlqW0alRq/OtLW2rKlUkXf+RWLOpT8By
+ZMyloNz0/84MFLN+XhgdbwpEJ/NStbaJXJtD7T2nUf2l3+kWV6rFrmPIgxdPYyb
7yJMWxj9rGaU+2XmAkqoyC5ahj30apruZbQLyCXqc1EeHlGY8/Wrq5h2ZBAJcDbr
CH22cVV2JzDT77MvzC+9nPWT/rkm8MNna4TRLZgtTauio9bPGHg=
=Jly6
-----END PGP SIGNATURE-----

--Sig_/trK2B+bQZg4U+J+J8zLUK/8--
