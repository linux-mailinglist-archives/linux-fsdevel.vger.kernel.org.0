Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1C4843F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFQNkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 09:40:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:59301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfFQNkc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560778829;
        bh=MAvJXTyJ8LYm7Xi27VyWjODfpCEau14e7rdyN6xgMW8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bGQ2KKYZXlX/1UMk4BZOZZeZWDvDwzbhsci10qw9rBHk0vetKrbUMklh+gMjkWLa9
         EeyUD9onqY56iCFE8qMyyJs72csoVJ6wgUkkZ7VvdOK5eoXKv1r1BYu+swGAFmwf0o
         RjwQWjrXfBbGUi3JIvBP1N6bIIoErGhy+CcmGrNw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1iiBLk1egt-017DmW; Mon, 17
 Jun 2019 15:40:28 +0200
Subject: Re: Proper packed attribute usage?
To:     dsterba@suse.cz,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
 <20190617131837.GE19057@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <83271524-4c34-f44a-3d32-3ebaeea13fbe@gmx.com>
Date:   Mon, 17 Jun 2019 21:40:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617131837.GE19057@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tOl0xQ9b4f0YtVqbVH3vJTjwKD2Xggwmy"
X-Provags-ID: V03:K1:NBBLCzDboFJallkSiwgUvLZ5Qu2rnFSYcmvF5Ah5PpShx6727M5
 i9z4XEonCd41c9600ogPbcq7ClAOPxZJ51wQPeZhSsWoWYvUMDZCJNHVPgTQak7roGmVg+l
 7rX81ocdhDpCCmLQpjhlKvnDJx6lCBp0m8mKkZLpvUh5Mi6EongyFcGsleLlIb5IFGJWWvF
 ZNXtal39Wxhu8cRc1P4fQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xZsWr6W1mo=:qOjRpZsRcf+hfKF8XALxBD
 d1pFs4agwIySF6ZKoABemmIBGX2iLaqU0PaWkAjitf5/7PPBZ5a+VHt7YNHwbGpdLLYt23wq/
 vk6Zx0+eOU4JLlsRMTvVZm904IgdDWW8PNNe+PrM+k+6GrdV9diiznrlLfphteIdewqNNNG6+
 0DwP/b7Cnq/e5JTvZ7dA/OrC583hkbD8ulTTe0aMLuytGRcst2NqrMDBcGxghaH58Ydfo0BRN
 xkLqGpLbNK4aYlES7bK6iM6oAKrKTiV5bkErUfLJ1OQtEGkeVa1hFc2pKtSGeKVyOrXl+6nRv
 KX39bY8o7OMKR/YBsDLL8wXYOGCOIUqP/ZgRgpzChn7bob8aKNIjbUjcEXN9KTdvYtN+QU9ll
 2i+5McgpH8djN6DPeibVGQEy6SgCQQZibEZxXMMbSkEWSlEcGINMCIsFAGhaLjiVaX7NFOkjz
 GsKBglg/gkM4vWtufdw6aBx9rn4S5yRjtGhFuGwEKVG18nR0RM+wBox30wQH22PE6cekI3WjW
 EMV3p5Y/SeKSWqZUYqj978ZJjKdCS2I1nSxqOvPrqnxA2WLf9sRjNCbKGEa2r4x0DYKMmu7B+
 T0/RV8KOBNYtc0TlHjjKmy1kh3W0vKGYM2CA0IJb/6CMiCbfwQ3r95aoJK0prFJwJWJHqcTHh
 O8roA/ykW4WUPbn2X1jYUh7UzFtJpn6quVtb6JntITB2bHQazpxOy8AP71qkmQvnqZeRWobIa
 yMErIaszXOll+y2BAbbR1C5FK2Vyp2Wij3K3nwNlPvov76M6N9HOcWcSyRh664p0Vml9PpjBS
 8HpQH59om7mEY0hbpecsvrBG4U4sSiqZK5gyL1wtr2L2YWX7kYzZihwjyVU3h2JQ7On+eDj0F
 gjtvjpZuYEo81fRJFIKESWjw4QrwOqOaZ1F9Q8h/1qhVAUFWAXD+RBO1HRDfWOWcnkOTXnwnK
 inys10i4YPsCr1qqELETmOJnUwu5d1B2FImmnRTLsS3jNSlyNijXv5k3cgzwyvGqxPgYp2MEJ
 gA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tOl0xQ9b4f0YtVqbVH3vJTjwKD2Xggwmy
Content-Type: multipart/mixed; boundary="1oojHcbhp0vNwMMTPQ1PmsQ4fFyZaBnft";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <83271524-4c34-f44a-3d32-3ebaeea13fbe@gmx.com>
Subject: Re: Proper packed attribute usage?
References: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
 <20190617131837.GE19057@twin.jikos.cz>
In-Reply-To: <20190617131837.GE19057@twin.jikos.cz>

--1oojHcbhp0vNwMMTPQ1PmsQ4fFyZaBnft
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/17 =E4=B8=8B=E5=8D=889:18, David Sterba wrote:
> On Mon, Jun 17, 2019 at 05:06:22PM +0800, Qu Wenruo wrote:
>> And for a btrfs specific question, why we have packed attribute for
>> btrfs_key?
>> I see no specific reason to make a CPU native structure packed, not to=

>> mention we already have btrfs_disk_key.
>=20
> For that one there's no reason to use packed and we can go further and
> reorder the members so that the offset is right after objectid, ie. bot=
h
> at aligned addresses.

Yep, exactly what I want to do.

>  I have a patch for that but I still need to
> validate that.

A quick grep shows no direct btrfs_key usage in ioctl structures.
Thus I think existing test cases should be enough to validate it.

Thanks,
Qu


--1oojHcbhp0vNwMMTPQ1PmsQ4fFyZaBnft--

--tOl0xQ9b4f0YtVqbVH3vJTjwKD2Xggwmy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0HmEMACgkQwj2R86El
/qjwkQf7B952FrSEOpFozBJjtkQiJWNSTI9aP67zAP8uCdANqi9XAEwamwMM3T6X
Pq3r6gOEBZ16AFvRdhVbsZHxqnvocbD9uTI4TzfFbv1gchNkfVzmt+sVbwLCgOt3
H8DrPueccAOkISAroc2iQ7Fs7wl6da5Cae401fY8MAIC8nc+1CwvizyCEam4FGGu
Tz0miwZlapmfnAvzhUoWHDZLQUbyTVWC4BEbbAOhwoIFazzPHLNgj/8uMEkqNZ6O
KdL1rWsCxdVz1gSA1Q3QsFn00tXw39bPwoAD42IDfMUoQi8dyOT+ZZGR4v5/9Oyd
sCn1DT6q4FNYy/Ul/ixsW6t6y2ASaQ==
=bS77
-----END PGP SIGNATURE-----

--tOl0xQ9b4f0YtVqbVH3vJTjwKD2Xggwmy--
