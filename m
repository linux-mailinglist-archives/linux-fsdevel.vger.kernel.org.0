Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472C21C55E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgEEMtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 08:49:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:34959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEMtX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 08:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588682941;
        bh=ObGMfoaDKSAtdq2QVH681cEM+d/Lnv01KFqPi8R8gQo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h21b/xoYTCc3D3+ZTPkxR3/58BhENe8w1Jt9ide5mxzx2rp7tfZ74BBm8QnZoSC1F
         qPTkjg42rDDZxV6NREolfPLSF03JSUhsqTxtBXeJMOxiK+tQOz9qS2sHhrjNM1p3Q6
         Gi4jRddlSQa17ujtS0teI8GOmpA7OJkvzeLm9CM8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQv8x-1jkTsY0Rj5-00NvJb; Tue, 05
 May 2020 14:49:01 +0200
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     Jeff Mahoney <jeffm@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
 <SN4PR0401MB3598DDEF9BF9BACA71A1041D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <bc2811dd-8d1e-f2ff-7a9b-326fe4270b96@suse.com>
 <6d15c666-c7c8-8667-c25c-32bb89309b6d@gmx.com>
 <f48ae201-cb4a-9bd3-5dd0-2d79db5019af@suse.com>
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
Message-ID: <36484e72-9faa-8298-32c2-0aef26acc8a4@gmx.com>
Date:   Tue, 5 May 2020 20:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f48ae201-cb4a-9bd3-5dd0-2d79db5019af@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hz14lPoQVbkn6ChGiVcL2Zz0PEDQHXjKh"
X-Provags-ID: V03:K1:u+fuJJljQ3ELpfH0Vlt0YJwTML5KNkkvrJagrUkV/l6pgn0yWLP
 ro2QFOciRmsvTk86RlwXpZ/aOlMSSzim+/4Nja/zEcTgtB/0l3hFdYHEhTHGRgjiEfTkCOe
 eNUhpQiaSAP63eQadAv2CpOuSQtDiQ6N2vP3ni55H6bOdRF+7WNrmf7bQUtmWoQFXbR/syR
 kdcSrHfEgO5a9HWi/yE+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lvqFOAwa1gI=:M5sqWIAgXQg78WOceyX1sK
 rLEg0YGy/zp88viBDjq7OFB2c4ZapRBl7/9+CoMMmDNCOd8RMUdHomqvBa4F8DuRQSwKHGpmY
 yjrytv/q935TPBIwYsTBPpyxRZ6UAYuESX5Lw7VW+kM3TPDXEl7jZ4D8/NMkucF3UHlCcLg94
 c1OgieS3a+qJylALG5UgdnCDd0bj2VvgpMZVrj/h3wXb3YSXkJQ2qbd8gmCqdnDm/AZ0uZyzx
 eYm4VPtaHc/7m+xlbWUuVJuH8bCooMJRJsYQwm0ek71p/LYo7/5kjGijqiQbmTBGwnY7wXHnN
 JZWHRiIsmAHT0v5Jl7OJWQ0khnkCuxA5H/hFdDBjgBR4la7niF9VIO0JSYgZ5FAFTmZSV3AEo
 BO1Nxww7LfDxc7IzhAajzFDDa9OgGPxvxOU9zdHfVDN6ha9THlU73PDaDFi6NuqrtftMtU94h
 oBnJ2IabPVBTE4VsRta6JYeXs4CYsUW2gRQr3PukiHz4YIALzcSqdd0PjuaYyCt8l6b7NabYT
 rLmWtUImmdcy4lillR/aYiT+65Knpj/ZKm4xplHh4hjE0tFVKwygLaRFBhACr1jNP5bkmkaAM
 wYXMp0l5f3/KbEFMqubNkVlTK0NQPHXg46H8AgG6TSHdkRuMZ406rPlDTiiA4yabPEeeaQflB
 pdz8936kkj8g1AUZ8/5krwM4NZ9Rbzd9TBx12VBofVfLgOcVOtx+T09JE/O+sedVHgk/Bi+E5
 rIK30ufmy0m9HkjNRZJg992/G16hEGVHJ46TW/7uzqyqsOQ5ICcBU/Oyy7vQtAowJkZNbUrQA
 F36C4JF5jgAHuWtvqh+BZLAMD2G4TcWPQjrSeghvt8lRzZvFG8K6ws+g85+GJbj6V9mrLNxPL
 6Fy0GxqSxf65QQOWBui6mdqUIewROJXABiVYrQasWiegVIQZtoS8SpqjEXfK7h2Ww1cXJKPSU
 CHbXAKXbPQErIHf0n1nCMYY5cFpdgGqKjRTrPrDvU3ufs1G9eb0imxujOYd6YIPRy5bKSLpVw
 G16GojDTj1nmqMudk0uqDDus1JRX88Ua0RKqGrf7zlf2b/Qv4yDm+JATsjXJAxkGSgjlt1doo
 bdCdlusJhWjeXkYaus03NEkvKcAx7ZG32W+AMHf6mu0SqxnH1jmF4l+hvnS/V9zaqgSrmoD1c
 O/5BPuZ89LCPoVU1Z/jUvm5JuOAq9C0/Zc5dGVkOYNTxsOTJ4hp42s5YhrtqLV8TmATfSs7YP
 6TVLq/yQIL4pro3By
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hz14lPoQVbkn6ChGiVcL2Zz0PEDQHXjKh
Content-Type: multipart/mixed; boundary="yV3jb9LM7GzA11v3G7mKnCawR0XVMbLW6"

--yV3jb9LM7GzA11v3G7mKnCawR0XVMbLW6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/5 =E4=B8=8B=E5=8D=888:41, Jeff Mahoney wrote:
> On 5/5/20 8:39 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/5/5 =E4=B8=8B=E5=8D=888:36, Jeff Mahoney wrote:
>>> On 5/5/20 3:55 AM, Johannes Thumshirn wrote:
>>>> On 04/05/2020 23:59, Richard Weinberger wrote:
>>>>> Eric already raised doubts, let me ask more directly.
>>>>> Does the checksum tree really cover all moving parts of BTRFS?
>>>>>
>>>>> I'm a little surprised how small your patch is.
>>>>> Getting all this done for UBIFS was not easy and given that UBIFS i=
s truly
>>>>> copy-on-write it was still less work than it would be for other fil=
esystems.
>>>>>
>>>>> If I understand the checksum tree correctly, the main purpose is pr=
otecting
>>>>> you from flipping bits.
>>>>> An attacker will perform much more sophisticated attacks.
>>>>
>>>> [ Adding Jeff with whom I did the design work ]
>>>>
>>>> The checksum tree only covers the file-system payload. But combined =
with=20
>>>> the checksum field, which is the start of every on-disk structure, w=
e=20
>>>> have all parts of the filesystem checksummed.
>>>
>>> That the checksums were originally intended for bitflip protection is=
n't
>>> really relevant.  Using a different algorithm doesn't change the
>>> fundamentals and the disk format was designed to use larger checksums=

>>> than crc32c.  The checksum tree covers file data.  The contextual
>>> information is in the metadata describing the disk blocks and all the=

>>> metadata blocks have internal checksums that would also be
>>> authenticated.  The only weak spot is that there has been a historica=
l
>>> race where a user submits a write using direct i/o and modifies the d=
ata
>>> while in flight.  This will cause CRC failures already and that would=

>>> still happen with this.
>>>
>>> All that said, the biggest weak spot I see in the design was mentione=
d
>>> on LWN: We require the key to mount the file system at all and there'=
s
>>> no way to have a read-only but still verifiable file system.  That's
>>> worth examining further.
>>
>> That can be done easily, with something like ignore_auth mount option =
to
>> completely skip hmac csum check (of course, need full RO mount, no log=

>> replay, no way to remount rw), completely rely on bytenr/gen/first_key=

>> and tree-checker to verify the fs.
>=20
> But then you lose even bitflip protection.

That's why we have tree-checker for metadata.

Most detected bitflips look like from readtime tree-checker, as most of
them are bit flip in memory.
It looks like bitflip in block device is less common, as most physical
block devices have internal checksum. Bitflip there tends to cause EIO
other than bad data.

For data part, I have to admit that we lose the check completely, but
read-only mount is still better than unable to mount at all.

However such ignore_auth may need extra attention on the device assembly
part, as it can be another attacking vector (e.g. create extra device
with higher generation to override the genuine device), so it will not
be that easy as I thought.

Thanks,
Qu

>=20
> -Jeff
>=20


--yV3jb9LM7GzA11v3G7mKnCawR0XVMbLW6--

--Hz14lPoQVbkn6ChGiVcL2Zz0PEDQHXjKh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6xYLUACgkQwj2R86El
/qibYgf9He32TuiEl1c5kDpJOugH8elCEQlgo0bAL6T88DwD79gpJqASdqgz2DlR
Lh5e5ewBfpwwzPrk2EyZvvln1IhlPE9tByUrkpp6kBpxDXLorZPeOBUgpaiSj0Qd
7Yf8R5UbuoaBucbOztSlKN0BTvwEuc6liAmDtw1bBJnjIcDWu8hRXWfeWxIiajMK
OP3LVsFA31aynYm94ktwvd0tdMOZbOwm7AV/RDrQf2oAFUCj2v6PgnhZ27AEqomP
3XZhloi/fJAwkc5jsaqLbmnY2hLPZjz+KFpsec9L9BdRuaUv6jszqbI5zg/6pfUY
Epxk9v3lfVR3qOJLaiOpRMy+VYYNrw==
=EDZD
-----END PGP SIGNATURE-----

--Hz14lPoQVbkn6ChGiVcL2Zz0PEDQHXjKh--
