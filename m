Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AC4968D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 03:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFRBHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 21:07:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:55705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRBHf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560820050;
        bh=udQO5efJBM9PXQnI6xMdbHSv5W44M5zHvd0ZXbeSIds=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gtInDD4YmN/OXv3YG1JkUm11yDcvz63BbI430fwsf+PQZo5tJnXZD5JyBRy1ZI45a
         al5EXe+pmGt84CUNwwrwzYm+G1Y4sOnBweHydvFuBQCwlo62KZzpuQqdUJw1886V7K
         +jdxwKnpfc11VCOtv7gw79tTAkRzEfWv9n/wr0u4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lj4xG-1iBpBX1kek-00dJ4v; Tue, 18
 Jun 2019 03:07:30 +0200
Subject: Re: Proper packed attribute usage?
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
 <1560785821.3538.22.camel@HansenPartnership.com>
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
Message-ID: <94dc6bb0-5df8-6b86-77e8-b3fdc8507660@gmx.com>
Date:   Tue, 18 Jun 2019 09:07:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1560785821.3538.22.camel@HansenPartnership.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KcA5qcjNIMGYqJcA63BA1lU0geZnEqLJc"
X-Provags-ID: V03:K1:6mOPfQw95f38p1xCH06ItjfH4fP31bjdIE45PCu9+xUIpWSVILc
 d9QNufq3rNUPJ+JiW4TAuwkgQEBsGFKJLhi5FlJ6mUYeNw+dB280+ozz/3m+zJvKJgLXyew
 jy0y1FILctacUS6R9LcLtdfIn3qQ/qVDliFbysvt7MdIS8gpXwzYlj5IcO7YK3Y0QNuWBkT
 YJtkBYfuw1Ft2UWh+86XQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BcQpfZbbgdA=:X/ke1fj2J0BxZOAwOQFdao
 QTyvNOJ2HpGHilzC/4Msyg53D56SuWIbD8VDKPlBsZ4Y1vpgG+HdGEIb67q7KYlBRTLZtom/H
 r/wWwsu9gEWsHjVUpBAf63fru/9Y7ZsC6XK+mxnmqLd3lCX9r6die4RfTAMAtjw3QdhNgEp5o
 29n1bOl0fHO9zfPD0TofBJ42J6NlIEP/odOBNWw5BT9L7EFR6OJQHtABXCWWS3A11+xEmlwls
 Eg5bch3nPHkAJfr7omb9L3ik/DWof1ZAuTVB5NDlNBZnr5ODsxKJySDoKrW9dpnvVp1LQW/Hr
 fX06q/iff3YDN1pQq/2e4wr8WXUNsb0/orUb4DlGJvnpfiYps937XkvqlkIWM4LU9VNL8ch0w
 1Nf3xKoPHwODOGTo01GDN4jhjWsSew4XFajUU6VxJaVYcevPnvaYLmkJvlm/0kMqDjh1Z2am7
 tnFCnnR3RuEm1cDh1fqfK8dvGkcwVKO4+fCIjDTk74u1J2PXB5KRMhjDchK1yDbkqYPWPi8fk
 JO4W9ZG0s8kbRwsU6C1JNWbi4q6Fr+Rw3v7sVJl+dSNlkvSPmzGnFRm+xGuXz/SCj/2Tu8gs5
 dt09k83Vf4L37ADotXKstcjcHj/3wlO5mfYn8gXCCYD8Tmh8Wglx2MEISm9bYD/C2OMW1+tQW
 yI6g5AibqvWKDeMvq/Wdbj+WP4Ey6vAQH6tcUo71jq5Z/juf8/586dmWBHoVq8MzGmQ3uK8Lc
 O4zLIZ3kjPCHnSIUVNWs+y8MYhip5VAhGyuR1jUUD9HRporKp5H4UTv6YgqGVyJYDdEWWC5k8
 afH9SifWv5vsAxZ3JocMa7gJT+XnwNaWlbwUYOdjIZ/OrG2asPa7gX90id2lJg09LPq8SfT+/
 MvmsMDdbLT40EcbJIX4EWmGBaZhrBrVWQ83PSg5GVj7/fKnNuqMJ/tMLzkDTNGNK06//DDRXo
 NYAY6C6CMJOJjOh0HQHgvEF6aGS/O2aE=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KcA5qcjNIMGYqJcA63BA1lU0geZnEqLJc
Content-Type: multipart/mixed; boundary="6NnAtpdSzpvbdd3QSmZBMblxgrc2GHySA";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <94dc6bb0-5df8-6b86-77e8-b3fdc8507660@gmx.com>
Subject: Re: Proper packed attribute usage?
References: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
 <1560785821.3538.22.camel@HansenPartnership.com>
In-Reply-To: <1560785821.3538.22.camel@HansenPartnership.com>

--6NnAtpdSzpvbdd3QSmZBMblxgrc2GHySA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/17 =E4=B8=8B=E5=8D=8811:37, James Bottomley wrote:
> On Mon, 2019-06-17 at 17:06 +0800, Qu Wenruo wrote:
> [...]
>> But then this means, we should have two copies of data for every such
>> structures. One for the fixed format one, and one for the compiler
>> aligned one, with enough helper to convert them (along with needed
>> endian convert).
>=20
> I don't think it does mean this.  The compiler can easily access the
> packed data by pointer, the problem on systems requiring strict
> alignment is that it has to be done with byte accesses, so instead of a=

> load word for a pointer to an int, you have to do four load bytes.=20
> This is mostly a minor slowdown so trying to evolve a whole
> infrastructure around copying data for these use cases really wouldn't
> be a good use of resources.

Then I can argue it shouldn't be a default warning for GCC 9.

But anyway, kernel will disable the warning, so I think it shouldn't
cause much problem.

Thanks,
Qu

>=20
> James
>=20


--6NnAtpdSzpvbdd3QSmZBMblxgrc2GHySA--

--KcA5qcjNIMGYqJcA63BA1lU0geZnEqLJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0IOUsACgkQwj2R86El
/qhrKgf/QA7GMi26LEi/snqrQF0NqHQaD/RXLxt4ehKOgCYW/syJtkeFCOtcmXcJ
5T3kK4eqL7ZeHsAUuqHeo6+ZP3KhcJ5hbeJHnT7kIMf7C3gjBeuoWKHXkKRoBQAH
au0FpEbwiUupS1Juodip64BSsvIWBi7o6HZvmDW7Ch9xGK42/9HeBMzuRnMfJzJ2
MIQnvJnfYSYvojeywyN+M0Wmgh6QtZWztaDlWBF3TEprhoFPgy5jeGGeft42lDqB
sD4NWe6AfcyoiqulaVlldzY/REwyHhjYPlERJLmLUqzyB4e1JYrT79loNdCOuA94
FTSHIYfSs1D1TYUYJXkuFdcYAMafUQ==
=iTrp
-----END PGP SIGNATURE-----

--KcA5qcjNIMGYqJcA63BA1lU0geZnEqLJc--
