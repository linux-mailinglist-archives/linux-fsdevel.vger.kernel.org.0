Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9A13C5E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgAOOZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:25:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:53571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgAOOZF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579098275;
        bh=HZHhuEVpJOCxLE5t1ilI1CzwJiGiguc8gRsz8ua8z3I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fNhnFHbm7LMTsiq6athb1eZt3VnUPFgrf2yJh5mKGvLaloLuePGEaY9vzLo+qpPqS
         v2H2BZ9HPxoclHqaPn4tb8P8YsKpam26X0yiA9njnTX9iz1/klAipNhco8hX/8lGga
         ea1YjOK79VqOBaXQDoVeI1n3YuofQ2UbjWf+Bn74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GMk-1jn7T90Kq8-014GWE; Wed, 15
 Jan 2020 15:24:35 +0100
Subject: Re: Problems with determining data presence by examining extents?
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
 <4467.1579020509@warthog.procyon.org.uk>
 <23358.1579097103@warthog.procyon.org.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <6330a53c-781b-83d7-8293-405787979736@gmx.com>
Date:   Wed, 15 Jan 2020 22:24:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <23358.1579097103@warthog.procyon.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mfqk37L4T50od0D32ynqRvPp0V1YvG8Lj"
X-Provags-ID: V03:K1:fSkEIBLf+bToxS5fux5e1MX2dRfJEGgPEjNhYCSIH3aU17h6GnV
 VHEvcIDHnqpb1vWky/nOjEcN0X3qNBltwu/psHLxYBNcUNFdF0JICeAZTHuIdXPsI34fMhc
 j4VW/1MMkr4MojhaHO376/y7aTEGqqo3uFV1QAV1+WtgLlQZwBKtQhSSyNXQFKHzkpetOuA
 8w/X8Do2egsA8Cb/u6dvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3GkpFB7oFbo=:xB0eONLYsaDQw+FS43g1iU
 7mxQX9/VYnS6n/y7cvERiihGb/b+TYzlmlINkdQV94RAwhdJ7bm4zYPdwdEKkl4r4pBvnPbZ9
 jmeUD4eqRG1LF+xDbW0S2kKumyrYbwDNtWYWm3TdexITyJL4eq0AcY4r85F3mkpDsX1VwQ/ot
 ZkxmFuVhHFHYyXezBsrhab9vjkJvSy9vrv3ModERwO2ncV7RwWD2Ew0zn0Etna/A9y0i9ZUOL
 RP4c7jUJSJ3msw0UMuRl7OnK8Gudxd5Y4d9JuOxN6YDUcDGrN6PCMRO9AlOgE9gfi6ni/alkC
 VWmCeD+S6WCG0yoUQjsqrt4S84tRRjRh1y1WSImyqbFkpW2C5YkvZ9i5CqDVWkgevE8oOgAge
 jpm4omixIhofx/Ev/LBg3n9zw4TGAGjPtW4W9vLuuYCxao9uDxIm7bbZuiDkPDWGK19KYHfRT
 QWXo/Suv41I4/cdjcougbIf2ALAaaW+RGc1zHb3D6NHGEfVdFQ3I3NkRrX+W/VDHbX0y4urDT
 6Z6C+ixY903VXBWmnS3EtTVhU6i4yS7IDxnPfzfa8Aj3HYzweJcwMMkDAAsG/zlKkKRnQNuBv
 CERJwbYcclusQxdzqI7IQlKpYPpYLGCJGhndJ+pW4gTDRgfMKzP727HNYYZ4zietZbEvAJegE
 3MP/uND5857g5o2LIZCmuY61zoc4OqIO3GHrRDqWOdJ5ia3uh7gaLRjSOVx38pT8P03pNoec8
 UHDw1EDIyBlYs81VHLCrwkNeTyatqq1hOm0cRHIoHk9/swNIfPkZ8n4YEsDi6TVRdg6+p6dlK
 kgiHJtQ0QFH8tWM6lmNGjBEy5KVl7mD3x7eGcQksXxHF9izJ/fsF1mPN2VTCYNllOsK5Kaj7Q
 nWH4bnmidZsdjU+9wxcqgjCN3qjAEDy5G2YOCX43AtjlQLLnkYCdPZG9hq48njmI0CoroWyLj
 fRH4ZyJyPZlnKa+O5D4FwFYM9lJsnBfRSDSn2RditLRMuESkiMtFP7Gomq2CdROuEdSwUP+KG
 RsY7LF9RHDg2anEzBGHDobMZ7A7/blRClkQDQSHD25IPs/PC/YZbSOStH2RLg667PLHXQA6bP
 GOsW6UXH5NVjo2bafFREakWcFSpUmQHFhJUeBsESUQvGFtI9VAHelPZ+cwGewFpQDzDZPPyGU
 Mdct2HENPb+rYlZ83Dxk06qIQvMHaj86FUS1mhYYp/WtLlym8/8GF4PXzl6rvySj1N9vZF4dQ
 X+U9uyHr1Oe6EHpGIL9bLR+qU25WIm+GTXzY3uQvlkdIiwrLb+/LEe7k5GDI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mfqk37L4T50od0D32ynqRvPp0V1YvG8Lj
Content-Type: multipart/mixed; boundary="atLNP1g1R4GjRLsVU1f3mOpJvhewFzX7K"

--atLNP1g1R4GjRLsVU1f3mOpJvhewFzX7K
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/15 =E4=B8=8B=E5=8D=8810:05, David Howells wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>> At least for btrfs, only unaligned extents get padding zeros.
>=20
> What is "unaligned" defined as?  The revised cachefiles reads and write=
s 256k
> blocks, except for the last - which gets rounded up to the nearest page=
 (which
> I'm assuming will be some multiple of the direct-I/O granularity).  The=
 actual
> size of the data is noted in an xattr so I don't need to rely on the si=
ze of
> the cachefile.

"Unaligned" means "unaligned to fs sector size". In btrfs it's page
size, thus it shouldn't be a problem for your 256K block size.

>=20
>> (c): A multi-device fs (btrfs) can have their own logical address mapp=
ing.
>> Meaning the bytenr returned makes no sense to end user, unless used fo=
r
>> that fs specific address space.
>=20
> For the purpose of cachefiles, I don't care where it is, only whether o=
r not
> it exists.  Further, if a DIO read will return a short read when it hit=
s a
> hole, then I only really care about detecting whether the first byte ex=
ists in
> the block.
>=20
> It might be cheaper, I suppose, to initiate the read and have it fail
> immediately if no data at all is present in the block than to do a sepa=
rate
> ask of the filesystem.
>=20
>> You won't like this case either.
>> (d): Compressed extents
>> One compressed extent can represents more data than its on-disk size.
>=20
> Same answer as above.  Btw, since I'm using DIO reads and writes, would=
 these
> get compressed?

Yes. DIO will also be compressed unless you set the inode to nocompressio=
n.

And you may not like this btrfs internal design:
Compressed extent can only be as large as 128K (uncompressed size).

So 256K block write will be split into 2 extents anyway.
And since compressed extent will cause non-continuous physical offset,
it will always be two extents to fiemap, even you're always writing in
256K block size.

Not sure if this matters though.

>=20
>> And even more bad news:
>> (e): write time dedupe
>> Although no fs known has implemented it yet (btrfs used to try to
>> support that, and I guess XFS could do it in theory too), you won't
>> known when a fs could get such "awesome" feature.
>=20
> I'm not sure this isn't the same answer as above either, except if this=

> results in parts of the file being "filled in" with blocks of zeros tha=
t I
> haven't supplied.

The example would be, you have written 256K data, all filled with 0xaa.
And it committed to disk.
Then the next time you write another 256K data, all filled with 0xaa.
Then instead of writing this data onto disk, the fs chooses to reuse
your previous written data, doing a reflink to it.

So fiemap would report your latter 256K has the same bytenr of your
previous 256K write (since it's reflinked), and with SHARED flag.

>  Couldn't this be disabled on an inode-by-inode basis, say
> with an ioctl?

No fs has implemented yet, but for btrfs, it has a switch to disable it
in a per-inode base.

Thanks,
Qu

>=20
>>> Without being able to trust the filesystem to tell me accurately what=
 I've
>>> written into it, I have to use some other mechanism.  Currently, I've=

>>> switched to storing a map in an xattr with 1 bit per 256k block, but =
that
>>> gets hard to use if the file grows particularly large and also has
>>> integrity consequences - though those are hopefully limited as I'm no=
w
>>> using DIO to store data into the cache.
>>
>> Would you like to explain why you want to know such fs internal info?
>=20
> As Andreas pointed out, fscache+cachefiles is used to cache data locall=
y for
> network filesystems (9p, afs, ceph, cifs, nfs).  Cached files may be sp=
arse,
> with unreferenced blocks not currently stored in the cache.
>=20
> I'm attempting to move to a model where I don't use bmap and don't moni=
tor
> bit-waitqueues to find out when page flags flip on backing files so tha=
t I can
> copy data out, but rather use DIO directly to/from the network filesyst=
em
> inode pages.
>=20
> Since the backing filesystem has to keep track of whether data is store=
d in a
> file, it would seem a shame to have to maintain a parallel copy on the =
same
> medium, with the coherency issues that entail.
>=20
> David
>=20
>=20


--atLNP1g1R4GjRLsVU1f3mOpJvhewFzX7K--

--mfqk37L4T50od0D32ynqRvPp0V1YvG8Lj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4fIJIACgkQwj2R86El
/qgc3wgAnraRH13IXzsWtwU79JxRf5nhvuNUPR+1MNrx4PYmTymL1jLDZ3z5DXaI
YFE14k6Lf9nRitOJaUCkuqYK53aVubgCxolUCuphCE7aqnranaUlPuYQo4RWBkcO
rgqrKF6frT0KgL/eIGr+d92nUDSo0mCO6lsm2qEwCrtnBGef0dcWdy2X9A8CBkFR
8Xe6phmRL/5FD1VK2poGbZCvPDeah+CKqq+4Z9ZZCMz7Sncz7ibUXn42vewmDekk
Pbzm+8fh9Bg2/YhCBhHjhHgKfwoufDAx4Yy6nTDUy9UGZueFIFnvri0Co9XjETBF
6kvu5UYIi3zMtdVjxPctcOHQDWY84w==
=so8F
-----END PGP SIGNATURE-----

--mfqk37L4T50od0D32ynqRvPp0V1YvG8Lj--
