Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1713C24E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAONLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:11:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:36431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgAONLP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579093853;
        bh=GACHe/A4NUnsLt6nmN4a3IUPIpCXBBUk3t4qf+8W5LE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bJ5JQDFuYjGGY/Ss8AQ92FDQn6RuVRBW8x4ChJGGlsUj8I9yykF+XlM9SzTOaGBiU
         8kCupuLIeuTtsX8SQQeF0hSAnml7Dmtw2nC1Fcr+ZXGYYU05gj+erFwIcEALsJBYdY
         Fj0/n0bBpFLLV9N99opzHKH+EG6MBm1Bae4UWUZg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVN6t-1jGHiV2EoZ-00SK2N; Wed, 15
 Jan 2020 14:10:53 +0100
Subject: Re: Problems with determining data presence by examining extents?
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4467.1579020509@warthog.procyon.org.uk>
 <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
 <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca>
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
Message-ID: <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com>
Date:   Wed, 15 Jan 2020 21:10:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wnxGRQSvPQJqBidzcPInLcdXSne6ta9CM"
X-Provags-ID: V03:K1:xeioVm+ZwQ2APp3sx+DTCx+5rWOntoHy2WWP9n2fYnhMN8PXldd
 lvciigPL7iL2XdDgrUQqcmH81FmHiF/3RZlL8LSzp4nPb9lJY01aqDajXUfDtBiQKBws1eb
 RKobljuooeyF6KJPBLZGjLnavdY/+MCpxc15vc+oBbvp9VcsqdXeaT2QeoYqjRq43/vGqwo
 Kz97aNapx8LzWhDXbSB8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g88NoOBjGB0=:NgtpghqqQQj8tD09+qLvao
 L46Yvv6PVIwsboxU+BZ3Wr0isQf1Q254wOzOxQQLzA7PhU7xyeEqNjLtwdT3t32PQJEJ2c5x7
 AVUPBHrun2ija98vAQHzjemiAbSoSOM3lrh2NQWlq/jxemHGRZx+h4TdnbLrxXDMZunfh1td+
 /lCw9Lj5DuufzUpSAwvGbZ9WKJhYsmhLs7Z6kLcepTTtPWOIzXVVYaPFEtP9ND6C4XQZpvLJs
 phDOx32y67kYx/Ys9pl9wqs044qAXtnHzmbwMAETvVQQbIczAsqEw+dKBNPoa0qif6LH2bKcj
 A6yBs84QHcXTeDJuZVKu/4mfhsvURotgmUCWgYTsQ12bjaMLfoNefm56XuoSCLL44tUKOhzZn
 xXPl0nNaFc8H1G/L7ZgVD4TO5DKA+gw0mfSH0Bc+knL9JWnALuMBH71/jVm6eo3fXwVoYc9P9
 tk4ypbAx1r0K2qEoM8pWGA+F4ATeJcQDUNjCI3KEDFvvmYZTLp3vyjTaAeRt5YtcWn3i7KraP
 4d22PCuUY25UJfvRccXPsgbt7ZBlwProGoHUMaOsbZXhOFAsWS7e5eIe3KW/LlUJ8MbBUc2TU
 WGF7nWCDuk0ssJlAXKmlMHkgKnKWA53xnjrS/jJJchUt1jSyWKICS61xRtbxocnSjBUrO20Wn
 EwRMYUxQNQ3s7o26PsN2AYid28TW2wCLQtFNhPisLtmyCNYEPqLsZoLHnvS9Xl7VagRu/VRTJ
 +SZKbymvPBRhd3w1z5c32tRwD4aF1uVZ/qhfBWAKw/LaSEera3szmuKrybe6WXQyL9Va/cg80
 3NP2IaIMV60iY7Ksz4RatNGvUGE8wBCxREy9ckhoh8vdlQEpCpQizm8orw6BdNLC4xkoS0rdD
 QVSIDN4r4GwIYfioesD9tls/8llMjEKXB2m5pIuYg7NJ4YWW2Z4y2zn2UcUV2IqJtZixnh6Ac
 HgrHQ9bDqX6iivPKrSnBH6pZ6Ia/O9s5HzkAZowpWq5UrcvwJiPJ+KeGn51sk8DH5TDErqnCv
 4zl7A+809rBdyBeNpvF6wgTlBulzCJGlBOgdRjFjeMUBGAXfoDoAsqB70DZ2aiywYdpXB/KRg
 BOq1ychUGM0AjKFoxKUyqMJgokpBqG7tWykZGV5EGU9UgWqibmVl3DXMU4BvvVbL32QRlmWnY
 rOrI8eDTk8SxOilNsJ3vn+6csx5K0pQPl2iWH63OQM0BmeH+ooxWUGVeENjcsqTkO+2QwBFUd
 JtrT0DrxSbonGI4vSec+oJOSB2AVPbO/RNJCiNweXSw/E20GCU/BuDcrAuQXBZ0veKX/N+tHl
 cEyMKQ83gcZezUdTaH61YtOxaLAv458Rd22yoBgm1peLLfmEDUpjEuOnBrJrrULC7ByyEr7OQ
 HxRf1nfrp4926wIlp/bUF0adxBzAa2RXvEwo6JP+YpUzsAOgvJI66tJviEVPftfYqBxSA4k/r
 HAfuzQL/X7pCrUqit1llHSGFj+tpyGVg/yLbnXvTZYOPGkK145o5M68JHXorSTUm8Yu0f5tkZ
 aOw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wnxGRQSvPQJqBidzcPInLcdXSne6ta9CM
Content-Type: multipart/mixed; boundary="Rvojnmd15NITd9vuRIw68oGUfjalcLZtS"

--Rvojnmd15NITd9vuRIw68oGUfjalcLZtS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/15 =E4=B8=8B=E5=8D=888:46, Andreas Dilger wrote:
> On Jan 14, 2020, at 8:54 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> On 2020/1/15 =E4=B8=8A=E5=8D=8812:48, David Howells wrote:
>>> Again with regard to my rewrite of fscache and cachefiles:
>>>
>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.gi=
t/log/?h=3Dfscache-iter
>>>
>>> I've got rid of my use of bmap()!  Hooray!
>>>
>>> However, I'm informed that I can't trust the extent map of a backing =
file to
>>> tell me accurately whether content exists in a file because:
>>
>>>
>>> (b) Blocks of zeros that I write into the file may get punched out by=

>>>     filesystem optimisation since a read back would be expected to re=
ad zeros
>>>     there anyway, provided it's below the EOF.  This would give me a =
false
>>>     negative.
>>
>> I know some qemu disk backend has such zero detection.
>> But not btrfs. So this is another per-fs based behavior.
>>
>> And problem (c):
>>
>> (c): A multi-device fs (btrfs) can have their own logical address mapp=
ing.
>> Meaning the bytenr returned makes no sense to end user, unless used fo=
r
>> that fs specific address space.
>=20
> It would be useful to implement the multi-device extension for FIEMAP, =
adding
> the fe_device field to indicate which device the extent is resident on:=

>=20
> + #define FIEMAP_EXTENT_DEVICE		0x00008000 /* fe_device is valid, non-
> +						    * local with EXTENT_NET */
> + #define FIEMAP_EXTENT_NET		0x80000000 /* Data stored remotely. */
>=20
>  struct fiemap_extent {
>  	__u64 fe_logical;  /* logical offset in bytes for the start of
>  			    * the extent from the beginning of the file */
>  	__u64 fe_physical; /* physical offset in bytes for the start
>  			    * of the extent from the beginning of the disk */
>  	__u64 fe_length;   /* length in bytes for this extent */
>  	__u64 fe_reserved64[2];
>  	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
> -	__u32 fe_reserved[3];
> +	__u32 fe_device;   /* device number (fs-specific if FIEMAP_EXTENT_NET=
)*/
> +	__u32 fe_reserved[2];
>  };
>=20
> That allows userspace to distinguish fe_physical addresses that may be
> on different devices.  This isn't in the kernel yet, since it is mostly=

> useful only for Btrfs and nobody has implemented it there.  I can give
> you details if working on this for Btrfs is of interest to you.

IMHO it's not good enough.

The concern is, one extent can exist on multiple devices (mirrors for
RAID1/RAID10/RAID1C2/RAID1C3, or stripes for RAID5/6).
I didn't see how it can be easily implemented even with extra fields.

And even we implement it, it can be too complex or bug prune to fill
per-device info.

>=20
>> This is even more trickier when considering single device btrfs.
>> It still utilize the same logical address space, just like all multipl=
e
>> disks btrfs.
>>
>> And it completely possible for a single 1T btrfs has logical address
>> mapped beyond 10T or even more. (Any aligned bytenr in the range [0,
>> U64_MAX) is valid for btrfs logical address).
>>
>>
>> You won't like this case either.
>> (d): Compressed extents
>> One compressed extent can represents more data than its on-disk size.
>>
>> Furthermore, current fiemap interface hasn't considered this case, thu=
s
>> there it only reports in-memory size (aka, file size), no way to
>> represent on-disk size.
>=20
> There was a prototype patch to add compressed extent support to FIEMAP
> for btrfs, but it was never landed:
>=20
> [PATCH 0/5 v4] fiemap: introduce EXTENT_DATA_COMPRESSED flag David Ster=
ba
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg35837.html
>=20
> This adds a separate "fe_phys_length" field for each extent:

That would work much better.
Although we could has some corner cases.

E.g. a compressed extent which is 128K on-disk, and 1M uncompressed.
But only the last 4K of the uncompressed extent is referred.
Then current fields are still not enough.

But if the user only cares about hole and non-hole, then all these
hassles are not related.

>=20
> +#define FIEMAP_EXTENT_DATA_COMPRESSED  0x00000040 /* Data is compresse=
d by fs.
> +                                                   * Sets EXTENT_ENCOD=
ED and
> +                                                   * the compressed si=
ze is
> +                                                   * stored in fe_phys=
_length */
>=20
>  struct fiemap_extent {
>  	__u64 fe_physical;    /* physical offset in bytes for the start
> 			       * of the extent from the beginning of the disk */
>  	__u64 fe_length;      /* length in bytes for this extent */
> -	__u64 fe_reserved64[2];
> +	__u64 fe_phys_length; /* physical length in bytes, may be different f=
rom
> +			       * fe_length and sets additional extent flags */
> +	__u64 fe_reserved64;
>  	__u32 fe_flags;	      /* FIEMAP_EXTENT_* flags for this extent */
>  	__u32 fe_reserved[3];
>  };
>=20
>=20
>> And even more bad news:
>> (e): write time dedupe
>> Although no fs known has implemented it yet (btrfs used to try to
>> support that, and I guess XFS could do it in theory too), you won't
>> known when a fs could get such "awesome" feature.
>>
>> Where your write may be checked and never reach disk if it matches wit=
h
>> existing extents.
>>
>> This is a little like the zero-detection-auto-punch.
>>
>>> Is there some setting I can use to prevent these scenarios on a file =
- or can
>>> one be added?
>>
>> I guess no.
>>
>>> Without being able to trust the filesystem to tell me accurately what=
 I've
>>> written into it, I have to use some other mechanism.  Currently, I've=
 switched
>>> to storing a map in an xattr with 1 bit per 256k block, but that gets=
 hard to
>>> use if the file grows particularly large and also has integrity conse=
quences -
>>> though those are hopefully limited as I'm now using DIO to store data=
 into the
>>> cache.
>>
>> Would you like to explain why you want to know such fs internal info?
>=20
> I believe David wants it to store sparse files as an cache and use FIEM=
AP to
> determine if the blocks are cached locally, or if they need to be fetch=
ed from
> the server.  If the filesystem doesn't store the written blocks accurat=
ely,
> there is no way for the local cache to know whether it is holding valid=
 data
> or not.

That looks like a hack, by using fiemap result as out-of-band info.

Although looks very clever, not sure if this is the preferred way to do
it, as that's too fs internal mechanism specific.

Thanks,
Qu

>=20
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20


--Rvojnmd15NITd9vuRIw68oGUfjalcLZtS--

--wnxGRQSvPQJqBidzcPInLcdXSne6ta9CM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4fD1QACgkQwj2R86El
/qh38Qf/aAKZSXVTdhZ99I7zYzvyS24APpZMrdqjxnCHx722R7/rn9cTBjCsLPnW
wp0pEWvHbjBA1e9FIjT1NoEa3LZ8in2mW7mXfPbLrlTnRhmmHFk5TjhdiPdMzhoK
33n3HAeBYLq9PtaZi7i6d9kumY6Fpz8MGBQTyfVV5quvlSu8Uun1PZlngq4z76xC
v/Yb5b0DUe/n+yUlVLjXO4rt+AmtGI+I233NuIve9cl4OgFNeVnzo/cgs0NIRf50
nHmWnerwcUlAB6XIfM0Amcg4U8+vJljKuE44zXhUQ45700pp+bPMobcz3TB0ycq0
1Z9cdHJWeO0ORmYOkvw/SWgEc8pTqw==
=46ox
-----END PGP SIGNATURE-----

--wnxGRQSvPQJqBidzcPInLcdXSne6ta9CM--
