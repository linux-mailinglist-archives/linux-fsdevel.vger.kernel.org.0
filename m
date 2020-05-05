Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C3C1C55C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgEEMjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 08:39:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:54643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgEEMju (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 08:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588682368;
        bh=RYyuZqktq3At4RdFJz11gO6sLQHgSEd7W2ICM/30bAo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bB2+nxpUimfGz0Xy15TW7j6CnefOfUEaOTt81U+amYpeUDOOIAD24KyDqN+cXHEkz
         QIx0o/O/JPBKFuPe/llOzpNnL8PeW+W+GTYDxTX9HHccXZ7IMxAPodds6lIqRYw+aJ
         h6asH1TQa3H6561IbxaenfHYL9ZuGgBuHQtZXun0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mirna-1itZEJ2hCG-00er2J; Tue, 05
 May 2020 14:39:28 +0200
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
Message-ID: <6d15c666-c7c8-8667-c25c-32bb89309b6d@gmx.com>
Date:   Tue, 5 May 2020 20:39:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bc2811dd-8d1e-f2ff-7a9b-326fe4270b96@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="onWiBbwSJuk8zwdmOw68hXzpEvcKIC7iW"
X-Provags-ID: V03:K1:Ze8NRwEj1cUjwXiIN1nayMK+kTjyNu9VPKB4fSe1V7I5IyAmClE
 mvyi1kthiRDxhdGwjKyNpzwZNRMDhQjib28iQdTbyZQVLhk5EpiX5IGvxesdzwvAvBpHGgG
 VE28s7PHv18a8f6n75ybU1bwrMfrLOEqu2ffi8n7gfFhIkFlQsD72OQFVHba8v+3QBbd+C0
 wU973iH3TAlm2SloL167Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O7kfMKhdNIU=:Amwa9aW1zydT0cLxlJEjdr
 xZl2dXVLKMaFqQndilEfmdaF4/3S/AANI6Jth/f1wuVlKBqBIBeuUygskuHsF51CV+AvnPd5S
 uQKn9CnKgC6BJee3eNli/c3+YgKZ/wr9Q7NBuqPcnX461/U46uwtf9/CBsHVnmt1uMuUU3xcG
 AmDTfeN2/X0pO7tX51SW//q8CMfoC4eoAYbY3/Ev4vDyjNxpE3paIXX2FRnGEQsxmL68DSxSi
 Pj+mNSGfZeh1YmORJtWT0CJAT0UbiFLNRGGeUTMIeVSpK63d+/A3mJvoUonknb/LBp0jM2jnZ
 juk2Bb1iqUHimgjQ4bUqP8RsRVz7m/QSSWmK+u4bCml9/gp6EEMvxamlNOu+vupNkBMFi7YU3
 5C/EER++gkqSwt/vbfj20uDxy1iMORbY90sa28JHyCzennB55lK1xD7a5ZbJDiJ2fNMYtOrbC
 q9DmXSAmKvj+xsneVjueFcM/qYq0MbcumChw65m+2WZ8Gh+pMVoA2Z4dXdCIqUgvmeJSzM+Gr
 JDd3a7vrPHVB0Gt53OPEYH+TWcfAEM2yQE6wazBOfSrdOmOIF79cNPqgKJS+/tw+7g0u3OH+Z
 fbO07PglEV60wydwMRxIXWGIRrfj+xI4guZ20OPXt3h0xbt7vajDbNx6SlBP7wqNen+nFdSji
 eOrPsu6YITmhjAUIZQmyH9V8y1GrIUHA5mZR/3jEa9GaL47hnmsTFggH8pwCEROYVkTZ1LeEP
 lH9AyQnHEp17EEcv7K5oTXJOMUCWlGZa3X1pSEwOHGswVl9E+9WzXkOBefFTL5sHSydawiXJp
 BuUnY0KS62D18XSWSLFzun0JXiTsjTorYS3wokddZ08tyfgX9AZPIc9bZMqX6Yq1jCdZ5GuW0
 zSrPbDE6XPvXReNxV8lPNjtHEQpQkfQcAKNPNHLD1punYyMfaQwnpQYwOvOMJweBWlwgpLq6m
 ItK3sOG3ZSyp24rzKsW403fytpxnr3cOU68WaPzjfrLiaCMAI0aHMO5kdj3eDjq67laLutmHv
 rVpUD7tvh7TJlV3ayS00bmFmtpkgZIK1oCTHxq9Exn8MAyDELBfgTqIF5xHYPpLetMp9dt03S
 tlhxK+Rd6yNfHWge147xuKnXC7Lu8FC5llbgemqQk9Tb4qrXyt4lAQWEpJAjA66QN2h0aOElS
 h1zRZBTj0YJ6k8ZD8ebjvZPcxvfkguzJHTTxetP/yT74HVQJXazkjyrWfugiWyXnGlAAYNALi
 sNN2Tx3H+JHzZ4XTN
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--onWiBbwSJuk8zwdmOw68hXzpEvcKIC7iW
Content-Type: multipart/mixed; boundary="7gqdWU31On6gFfvPn2PyevQzk3Aaofy77"

--7gqdWU31On6gFfvPn2PyevQzk3Aaofy77
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/5 =E4=B8=8B=E5=8D=888:36, Jeff Mahoney wrote:
> On 5/5/20 3:55 AM, Johannes Thumshirn wrote:
>> On 04/05/2020 23:59, Richard Weinberger wrote:
>>> Eric already raised doubts, let me ask more directly.
>>> Does the checksum tree really cover all moving parts of BTRFS?
>>>
>>> I'm a little surprised how small your patch is.
>>> Getting all this done for UBIFS was not easy and given that UBIFS is =
truly
>>> copy-on-write it was still less work than it would be for other files=
ystems.
>>>
>>> If I understand the checksum tree correctly, the main purpose is prot=
ecting
>>> you from flipping bits.
>>> An attacker will perform much more sophisticated attacks.
>>
>> [ Adding Jeff with whom I did the design work ]
>>
>> The checksum tree only covers the file-system payload. But combined wi=
th=20
>> the checksum field, which is the start of every on-disk structure, we =

>> have all parts of the filesystem checksummed.
>=20
> That the checksums were originally intended for bitflip protection isn'=
t
> really relevant.  Using a different algorithm doesn't change the
> fundamentals and the disk format was designed to use larger checksums
> than crc32c.  The checksum tree covers file data.  The contextual
> information is in the metadata describing the disk blocks and all the
> metadata blocks have internal checksums that would also be
> authenticated.  The only weak spot is that there has been a historical
> race where a user submits a write using direct i/o and modifies the dat=
a
> while in flight.  This will cause CRC failures already and that would
> still happen with this.
>=20
> All that said, the biggest weak spot I see in the design was mentioned
> on LWN: We require the key to mount the file system at all and there's
> no way to have a read-only but still verifiable file system.  That's
> worth examining further.

That can be done easily, with something like ignore_auth mount option to
completely skip hmac csum check (of course, need full RO mount, no log
replay, no way to remount rw), completely rely on bytenr/gen/first_key
and tree-checker to verify the fs.

Thanks,
Qu

>=20
> -Jeff
>=20


--7gqdWU31On6gFfvPn2PyevQzk3Aaofy77--

--onWiBbwSJuk8zwdmOw68hXzpEvcKIC7iW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6xXnkACgkQwj2R86El
/qgoIggAlGT08EtjRS8Z+a3bJnt6cZZNDjy8kRU8AT0w9ezMUTb8Xt7ZlhXHaCN/
AVkxZ1p3U7dqpZN8mKbViLKvU8KocELvOGdM7pOyvZlNuzBiGWU80paoyuprhkkd
fZxDoN4VVQxbBZd9xe4LdGOhGQaX3Oe4b2fybcs5hpzPK0/QYQXoxt++PdG+nON0
oxuOg1pAxiI9jLIrv1fYPnAtBIdiNjVrBpdRSyBdF9HmIS8ryBI4O0RgKLr32mQE
cCpMHq/CMYVNYCaOBqNFGdUfBXhDbAID+2gCrtsSsoU8InqOwI0EuPVGA7If216q
jj+Y9VKqFSOBEuuHXICakbKAUxjoJw==
=+VXA
-----END PGP SIGNATURE-----

--onWiBbwSJuk8zwdmOw68hXzpEvcKIC7iW--
