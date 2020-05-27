Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1561E410C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgE0L7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 07:59:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:53917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgE0L7R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 07:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590580741;
        bh=/4ZxwbojsP0H8jvnRJLfQPi+JeuPy72LvcnXI0WW84A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RsCITmXv1ILnW0AuRCdyGmp/COa+Gu1DtzNhgc2O9Vuyp53o7g8obh3B8BTNaMp3h
         uq0lj43A9TorKaL1lc5t+Kjoa70MXzhy1gqvd4tT+GYY5axyTXeiU0XU6myOI/C8XW
         TQ+Q9Zb+rsUvwzXm096XgqgQfTN/KhyyIuEu0H4s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGz1f-1jqr1L3duV-00E7uW; Wed, 27
 May 2020 13:59:01 +0200
Subject: Re: [PATCH v3 0/3] Add file-system authentication to BTRFS
To:     dsterba@suse.cz, Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <5663c6ca-87d4-8a98-3338-e9a077f4c82f@gmx.com>
 <20200527112725.GA18421@suse.cz>
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
Message-ID: <db7c0e64-66fb-15a8-b976-92423b044ecf@gmx.com>
Date:   Wed, 27 May 2020 19:58:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527112725.GA18421@suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I5jE12PKb4pwHIIDDaXWTzr99utTzjnwN"
X-Provags-ID: V03:K1:4Ulk2ZUwpFYBxEMgs7b1MlPvqtBqKv2XsNobGAgzL3ztWevmXUL
 E5Phy9Rv7E4FgGiQRT99Lj6vyazmmffQKhZajsOig+QXtyAwEu6vlUvoXgWaErS9BZ+yQFq
 kSXDnKxe+bUWIw1ZcL+MZAkAknn/xcbJIOhuNuuLNeXErBc5ehgcqOPU9XSx/01HwBXZKQD
 sDc6VIPG/Ds3EbhJII1PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8QbOsWp2X8c=:5SQOKAKaIGrV1hGBm1PMSp
 gVB4qIZaDxfYu1ThcKpnd8PgML4hCjb+V48TuM8aRWMK3tYd66VR7It9oaF8VRSy/910Ce2BJ
 eBGwlllHmZBALC83ZtjWgVzLsqK4T7T62tfyjHPbDV5yiYIQDl44s3c/P123OPpNlaXNKfoTu
 U17TJePZ8OdALgz0OKZKqfk2NpDLOhNZhtjGTxRiIU1eC5VIGojoosQWI/9FALWl131CK7rAx
 UEF8xSNvht4VI7/eiaeaxqFsWdUKQ+hwLZDs4raIrENC6bpNZJxnp0UYXRp5mNoBQO4sM77Rr
 qQAwm229cdnl06fFDVnz1fRKQWmYl6Y3Dz2CnQh8Wr9o+k9e2yEd8S+npQhaLOX3isjs445Tl
 pADndNVSY9YApxjQJXSq/4PObCBlb1cqop3BsFBnyrlrrUc4ZQ1vFRFZQa1KpoJPAr89HN5I+
 a0oMspoEOdH9QG6t9o7DVQ2QduxZbnTGHCcPGfTQ8NX/REnTBAl27OngTXnaYJG8JBagKEuTD
 woQMTU8XDQdDGiD2XihyUbwQty/dzfGmNPWEX8OLwS6B9DnR0+T6g1EWe8RlGZqWHeB9vmNZN
 dfq6ZSboXAn53OssPOA8AZWRuqnQ+BhsJw3Izib7f5seUxAO99PD9wXaAxnmSTeAk+lQGZMkY
 gr1sw1M07dZpYdZzZzqM6J05QCj3WBTxFmq409XfkszpAi5cmVvXK3RR7E77vgzjZLOC33I3x
 FO+8bv2A5qJzbjbMQD+isvLQDqJamgwpBIpKvB79AOlLet7v7OOBF8cxpDdIzlE2Oo9bWkJCl
 pbNTJ1iZfhnP8zzBJOmqJje9+NZo0nXsIVhKPDL8WM/HasUXxiFFtmys0irVqHf5WhzQcjP/f
 9quJH3tvA+owQij5uAHk79a4qvrTQ6Hf+gNMttZLZ/FVCXZPsaUMvZRkSojfhF4L5MpUnbC4Z
 pS1txrXCMRtFUTouoTIK3exU4A8dmHfewOu8tHV8+vtD/VO38ooh3SKPF+tD+wWAK5rcTAO3L
 1svGhP4O8xxWZpub2t6K2arIUwq76BKNb+0PyEeeMNZwW78McJREaP+vw+Byp5+rTZvAbXF9y
 QyE1JoyKF8pC96KoYJhpaGfgvW3fBAD5ZA7xZWMfe6qMGdWgMpdIKqlPsyIdKEdOurftcHh75
 AgVgWYR3MNdSmgQZ7Ad9w8R+7ujwmrVb2FOaCCLtLpDjveKWQFnOqSI5a+YjxmAnQDVfSTOaL
 3iad6JRyx59lewPkk
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I5jE12PKb4pwHIIDDaXWTzr99utTzjnwN
Content-Type: multipart/mixed; boundary="irJgq6ndamF6Nvqx6F1w4NWkw2cdWTifN"

--irJgq6ndamF6Nvqx6F1w4NWkw2cdWTifN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/27 =E4=B8=8B=E5=8D=887:27, David Sterba wrote:
> On Wed, May 27, 2020 at 10:08:06AM +0800, Qu Wenruo wrote:
>>> Changes since v2:
>>> - Select CONFIG_CRYPTO_HMAC and CONFIG_KEYS (kbuild robot)
>>> - Fix double free in error path
>>> - Fix memory leak in error path
>>> - Disallow nodatasum and nodatacow when authetication is use (Eric)
>>
>> Since we're disabling NODATACOW usages, can we also disable the
>> following features?
>> - v1 space cache
>>   V1 space cache uses NODATACOW file to store space cache, althouhg it=

>>   has inline csum, but it's fixed to crc32c. So attacker can easily
>>   utilize this hole to mess space cache, and do some DoS attack.
>=20
> That's a good point.
>=20
> The v1 space cache will be phased out but it won't be in a timeframe
> we'll get in the authentication. At this point we don't even have a way=

> to select v2 at mkfs time (it's work in progress though), so it would b=
e
> required to switch to v2 on the first mount.
>=20
>> - fallocate
>>   I'm not 100% sure about this, but since nodatacow is already a secon=
d
>>   class citizen in btrfs, maybe not supporting fallocate is not a
>>   strange move.
>=20
> Fallocate is a standard file operation, not supporting would be quite
> strange. What's the problem with fallocate and authentication?
>=20
As said, I'm not that sure about preallocate, but that's the remaining
user of nodatacow.
Although it's a pretty common interface, but in btrfs it doesn't really
make much sense.
In case like fallocate then snapshot use case, there is really no
benefit from writing into fallocated range.

Not to mention the extra cross-ref check involved when writing into
possible preallocated range.

Thanks,
Qu


--irJgq6ndamF6Nvqx6F1w4NWkw2cdWTifN--

--I5jE12PKb4pwHIIDDaXWTzr99utTzjnwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7OVgAACgkQwj2R86El
/qi6pQf9GlhhFZR4RYAQi8goFJs2uJRE7ch31FzGoAl+mbEzttKrA0pxBNOBmxcX
TKbmL8CD6YKcNCODOoSZuD9UEDqLq3p83y6oxkxLep1+JB91evcsIGo6Su+099rj
xh13C4UbzJm8GBvjpAq5bMoogSwalPwEhMWKdiQDQh8TSwp5j/mPpKN9U6jemAqF
T3UKah4IZAqfvvHIaN/tPUXzEj5FDKyGeUGcQIZM4MdcznoUJxpdJhiYs4sxraZs
4C+5a/89t3ee3osYhLEK3JhRnBvDtSVFTlW8G8J6AbSjFVh5WGNw6rO+23c1WJFX
7rci5Am+FUkwFSIIYTdz8yGicEwm5g==
=cRGg
-----END PGP SIGNATURE-----

--I5jE12PKb4pwHIIDDaXWTzr99utTzjnwN--
