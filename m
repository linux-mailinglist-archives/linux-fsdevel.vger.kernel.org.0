Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3691F782B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFLM4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 08:56:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:35659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLM4v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591966599;
        bh=VTJplPqtvpt9ww8ZNgx1qet60fizYRhcm+r1jt2PMl0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CeUdSdD4A0/eCqKCTDahhZXZXtOeFAFpSrr1XpgKvtaRzJmQ9k3S1YkG3gGOxULq7
         vevm3pV2wZDxpksUMMc9nUDzGCJ5eTgatW1QtTClWrmCd1TBuAT2zZULqd0nYrhpay
         zKa3ufF9saR5ZZLHRvxV5+98+iNjEKdXvJhFcBWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1j4Ikj1rKB-00mHtG; Fri, 12
 Jun 2020 14:56:39 +0200
Subject: Re: [PATCH 0/3] Transient errors in Direct I/O
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     darrick.wong@oracle.com, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, linux-fsdevel@vger.kernel.org, hch@lst.de
References: <20200605204838.10765-1-rgoldwyn@suse.de>
 <3e11c9ae-15c5-c52a-2e8a-14756a5ef967@gmx.com>
 <20200611141127.ir7b3ohd3c3qtunu@fiona>
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
Message-ID: <00904015-86c8-f6a9-4173-ff51fe58e506@gmx.com>
Date:   Fri, 12 Jun 2020 20:56:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611141127.ir7b3ohd3c3qtunu@fiona>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R9A6TcfViGjRVeCs196xigoHfekKsiW7R"
X-Provags-ID: V03:K1:MQY6kx9Nb+otai+C7lqtb4eo7HTvPcm0lCtKiPcIJuEb+UN5b/d
 pIg0FGkEBS+d2foAAFKrO40bFL+bdZ2C+3YH5kD9Hr8cUQZmhi7MoQSROth3ff7xWKlhPKi
 KWsmWmzTXFcMJHxj8XRVy8apAD05rjmHkzTwYtLCclIVNlxGVOIAcWBNtKTRmqq1s/b7si0
 fS/WFK1/B+HAyCi9G+yTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1j4EG4humrA=:17lrgb9eEXIl8RzMaDv2AZ
 LxrcJwSOAFQojVfxjfsmuVxJX0FnvM4OjrTEHktufsX4v8P6R4+IKghKiUi2WB0Sn6L+EkGbA
 shMIBQRj5g6bYXtXvqE4pnPfBLvZRbCxw2P4bHqkZljsfufkknHYU5CfhipfCy6srjA3Zz5kv
 Xkv+PE5t5sxbGp7YyiGuftpVxJSW4duKdCE9TXtLXBEXknll29ZFWifLzhd1KYHzCoElnQwk+
 i8cefJjgrEOgsVZURKPBLdkvInakKljybWb9XuAjatyrt5LppiiSVaHfpBvkG7MdwS4fQHD7t
 q8E7hGikLO7r00GAMpB+HmdIF2bzT7KA9KRhX73RmSr9l2IzXojA4bE5oFSn7D7T3fwoyGrzz
 Zhlp61htlkHtD4frfNwdX7Z2cru8wJOgoOCbZebSUb+GZsy3A4TL1Cxs0E2vMUPUWmqa9AMGI
 f7Ber/91x/m8ic0hxPBPERWomWMlsklzxgGPyvafa3omYEmA7zNEwvSFf/8oZhRH5JWa0jnQq
 IV7gSKMps05ZKlLfwQbTD20SHU3kBanC14Cdct6v851ttnDZUwd15UDzlY5oBkI+4x8CtNA+A
 XMHdwtjzVdWctYESt6oKTKjOG2xqpnULMUUknkV+08fVuY3c/l+epN3d1ZYfZCf4MigvpNufN
 mMTKVl7asynEP6OwvKOfb3a3XIi43SQ9q//kk2ENZmCUhJz96yezX7hsuItGmG89kBUGh8aS2
 jKV+xm0NKKQGIBIVtUPUoxIQBfz3LEtw7b/6KGHoUrb0E1U5YBo5mOPWz2UjSHwZ1I2lM+WDN
 E0LfkMGcMXPHLP1Ix7qnZTObvCDwXN3xSNnCGci5gIPmPbV8sCLvWxKoyuEps4JftRi2MMvp9
 yIul0FQWF5l9RqmATh3k7cf42bX/DhvXUJJa9m4GWBivTHoTH89RvVHdsLQ4NniZds+z6H9kH
 pGm6NCf/hf7n4cGXxX4Y4mbCa2hfaFJ30pR4SFfzjXlo63VcCHJCAq1mzV6IAB7UV+dvzJ0ZF
 HU/n1us3FL6b5vzI1nAwxDDX2QitLMPBHQqfifKsYk5LMQXMybjY+6IUf22P83/K2VXkMta62
 A3ATmD2y+RY6gSWB8BmoBqbUdjPSZCMbtHmMIKFGvosW1pl+aLAsLsjyold8i9WvkbxRTRYaV
 j2y9SVHdeOpRHCkZujRTNuqK5HNigpVvEIJ98BOs6XURB3lgc15RzsOeNy7sBiPWmZ4MFu8v0
 uoRurLVrZpkJLre4p
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R9A6TcfViGjRVeCs196xigoHfekKsiW7R
Content-Type: multipart/mixed; boundary="8WTKqTGFdzO5Wp1G7LJNwXHjPhSRvhI21"

--8WTKqTGFdzO5Wp1G7LJNwXHjPhSRvhI21
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/11 =E4=B8=8B=E5=8D=8810:11, Goldwyn Rodrigues wrote:
> On 13:31 10/06, Qu Wenruo wrote:
>>
>>
>> On 2020/6/6 =E4=B8=8A=E5=8D=884:48, Goldwyn Rodrigues wrote:
>>> In current scenarios, for XFS, it would mean that a page invalidation=

>>> would end up being a writeback error. So, if iomap returns zero, fall=

>>> back to biffered I/O. XFS has never supported fallback to buffered I/=
O.
>>> I hope it is not "never will" ;)
>>>
>>> With mixed buffered and direct writes in btrfs, the pages may not be
>>> released the extent may be locked in the ordered extents cleanup thre=
ad,
>>
>> I'm wondering can we handle this case in a different way.
>>
>> In fact btrfs has its own special handling for invalidating pages.
>> Btrfs will first look for any ordered extents covering the page, finis=
h
>> the ordered extent manually, then invalidate the page.
>>
>> I'm not sure why invalidate_inode_pages2_range() used in dio iomap cod=
e
>> does not use the fs specific invalidatepage(), but only do_lander_page=
()
>> then releasepage().
>>
>> Shouldn'y we btrfs implement the lander_page() to handle ordered exten=
ts
>> properly?
>> Or is there any special requirement?
>>
>=20
> The problem is aops->launder_page() is called only if PG_Dirty is
> set. In this case it is not because we just performed a writeback.

For the dio iomap code, before btrfs_finish_ordered_io(), the pages in
ordered ranges are still dirty.
So launder_page() here can still get triggered to finish the ordered exte=
nt.

>=20
> Also, it is not just ordered ordered extent writeback which may lock
> the extent, a buffered read can lock as well.
>=20
That's right.
But at least that would greatly reduce the possibility for btrfs to fall
back to buffered IO, right?

Thanks,
Qu


--8WTKqTGFdzO5Wp1G7LJNwXHjPhSRvhI21--

--R9A6TcfViGjRVeCs196xigoHfekKsiW7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7je34ACgkQwj2R86El
/qgXpAgAjcBsKzvPY1s5vfGNdnfui6rPNrDqMAq2q6brYVp4YMuIc1MasNS+KDSK
jr+myjC880TvMa2qAUCbLSZ+ar+j7TAZ7cTjkgBs1pki5c6KCVqJjZKMGK55pETP
U3jZ5JeVctEGvVWt5DzrwvQcO2iQid/of2Hzuuu4Zp7ukQqCCRIVKFA5vZRyWQF2
rI/F1gIqTfSmNCmBTvqTcaN4ONRwsTO/B6tTiCtxxnb8kezw6judGxrVIV80ik0D
mRt/MWrfBXrZTqVwm+M6OnDAy2wY93G0L8VKedYI9UM0e1P4D0JpJlNJx6SAqA3a
b8TEafvPgklcbGuISMedE7l48kg1qg==
=iN1+
-----END PGP SIGNATURE-----

--R9A6TcfViGjRVeCs196xigoHfekKsiW7R--
