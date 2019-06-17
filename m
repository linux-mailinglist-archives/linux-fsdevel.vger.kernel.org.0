Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE647DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfFQJGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 05:06:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:57835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbfFQJG3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560762386;
        bh=HIP74PHNlopo8K8cwOjLm6cXcNhcCxZGW5mAXSpWCoM=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=QN4qQMbZBZ5nL3LvJHRyIgaDzD5DaX+GQrgcvXpZh89CEJDa0XXYQheiZ78JwV+I8
         ORxERcOCkiqBefm0sia97act0+2h58vFz1dr2QuF27OCrC30suAkvpeMCAMEnYA6VR
         AkOuAxzlOP3eoL01NZ4T/VxEXuhNRPU+m7x9frb0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lubnw-1icV052iPo-00zn1v; Mon, 17
 Jun 2019 11:06:26 +0200
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Proper packed attribute usage?
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
Message-ID: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
Date:   Mon, 17 Jun 2019 17:06:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AvCz0ytMeoVwnc0PuhRcRTwCYkW1Cbkii"
X-Provags-ID: V03:K1:tA8PQXqFBVFw6s1Q4uVcRLWV8Yz5D/Twikb8Ht8sbwM10xuotW2
 T9x07n/IxOzJusvjsvA/zGGneJ5G5REnI79qFx07/D16mCz55RV/mB5EOW5Ig+ncHXXXC2/
 35zTfQquI9PWdz0ilieZWFz1+cm6jWRgiFOgRUPEOzaXV6dkTUEHJfdpaRjRVqk3zNzKLdd
 ZLmLYsJGZxPE936928l+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h4Nq5W5DqCA=:ex3LTVftj8BbtVvI6/H4ZJ
 sjh1JK6yc5e9IQh+uka2FnAyNctmNdcUlqY8IStqydLptUJ9rX8H2e14Zay3m/SG29IHyRM61
 8e7BtoR9Zkhrr7dKe0zuIdRPnsRiXaEq1/PkqZ+XT5l/rg27quDsfpKtcU60KSA+Orq8zUMh+
 GnWh199NQe2zWWKvAn8kFjjrYZjPXZmo2cMIev7uzfL0FPhfZXLM3Uv8O5OCY4dXfT713UWe+
 niH7Qc+M1CRLatDmM/8gCK5qPSArDirs+373tqfrNRhKTDA0r+PjbpoiCuEV1W2BjA4cT7b6N
 YaoSkm6cki2tsLOwHCBql1NL3pIe6IJSBVdD29JhMKxxolj63fZros52Z6hOkndP2P81JquJo
 3YxfyfqOaI1aO/YTCscWhETBojEiCkemY1hEKn/dAXhm5TncSv5uHN3acaYCcMk9bjpYfw+3I
 AEqKVNkvifyilTMdxROKBxtaJuwjRsHtiyCeiGTfOu7LhCi+I6G+q8C0cmMG/aFisXozHR2Mw
 mWKgpL2/nVTLMVtl2rkGNFlxh+GqA/0Ar+6VdVK39sZVHBDzVtcnPVQ3+FiwntC+K+yhXCm5d
 LcgAybcLJzXC/HTS18VDv1htXuEKW9BpGoFM9zGndngFmjnZI0LZKGd39NF00HYi1tR940h+f
 wLuxMFXYh0uKXzp7P0tBs4YswtprbEfmyI6P31K5xjQ77igaUQ7JloEA/0jZ8y21umJWfeLBz
 A/VQUdoRkL2MwzLUouPjGZKdbO2yqrR+c08OgF33URoplZqJFlAUTq7IM8kptn35nIfgzUlLu
 gW+/TUKnESkz6jKn36MNLVO7YkeWcGHdnEk0ncwdGMb2/Q3kzoQFmcbAaxjRC8ytjt+WQJqbb
 riOSeBqMgZe2WvRILGBjaoF7k8i3zuZYcIg/5f2Lt55Avzt/+zK/pCm0yu1LvnmrPcMVM+3kn
 s7qckczBzhibROVKEsaUtX3PmOJrY/xY=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AvCz0ytMeoVwnc0PuhRcRTwCYkW1Cbkii
Content-Type: multipart/mixed; boundary="gzrO4tgqKB0nV2uf9edJZMkOBg80DVcRG";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
Subject: Proper packed attribute usage?

--gzrO4tgqKB0nV2uf9edJZMkOBg80DVcRG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

With GCC 9 coming soon, its new default warning,
-Waddress-of-packed-member, is already causing a lot of btrfs-progs
warnings.

It's pretty sure kernel will just suppress this warning, but this makes
me to think about the proper way to use packed attribute.

To my poor understanding, we should only use packed attribute handling:
- On-disk format
  Obviously. And also needs extra handlers to do the endian convert.

- Ioctl parameters
  To make sure the format doesn't change.

- Fixed format packages
  For network packages.

But then this means, we should have two copies of data for every such
structures.
One for the fixed format one, and one for the compiler aligned one, with
enough helper to convert them (along with needed endian convert).

Is that the correct practice?

And for a btrfs specific question, why we have packed attribute for
btrfs_key?
I see no specific reason to make a CPU native structure packed, not to
mention we already have btrfs_disk_key.
And no ioctl structure is using btrfs_key in its parameter.

Thanks,
Qu


--gzrO4tgqKB0nV2uf9edJZMkOBg80DVcRG--

--AvCz0ytMeoVwnc0PuhRcRTwCYkW1Cbkii
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0HWA4ACgkQwj2R86El
/qgrrAf+Ip7u+1OxfactcS4HZOVdriZr4M5BzABtIQDU2WnmlkKFy5ClRsU3R/YK
JfuZWRrYs12WFQ3NwUNWtb87nSaqkhp61nMwiSJj4N0zRXaIZHL3XYB+wS32Hp9S
4Q9M0ugQRzGWfUBdBe8L/yqblhuj0ixSp0+irap8Bw8jqE3JSD5U7WVjYibz+UEy
X75EHY5BncCs/z4K0jZWMXHk8tza+Mqnl7SAhYhRkTnnSNyIO2GaA7d0s7r8UMwq
GnLuWAak5MhF7QOh1X0anNb3l2355skqqg6Mj7a2wZNStDuNmSd9asCEcgUPKU6x
+OXfT7hoLzcp2OTkz+m7W9sXx+Bx3A==
=Q/d8
-----END PGP SIGNATURE-----

--AvCz0ytMeoVwnc0PuhRcRTwCYkW1Cbkii--
