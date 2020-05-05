Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A141C51E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgEEJ1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:27:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:34969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgEEJ1E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588670809;
        bh=cPCHWML2APDGJaIqr+B8WZ7OTWu9fHRQfl42v8zgecc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L1xQ9fyEYJLvy8mzJVEj5DJc5d3pDY4aoz0h5lxos3Tsn2BuB+Omc/UKKzxF/+YJ7
         wE3tqWG3/Fy8IMwUXOROSeUSPsP5X09dq8cdCVtTBIkAvAPzG9IRSPyWb8Dm0L/kdV
         B/pGbq6UlhCBKp0j1KIclOYlGWzt/hK+onL6LM84=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3HU-1jKrEO1WNk-00FVBh; Tue, 05
 May 2020 11:26:49 +0200
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
 <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <d395520c-0763-8551-ec80-9cde9b39c3cd@gmx.com>
Date:   Tue, 5 May 2020 17:26:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB359843476634082E8329168A9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zYKK3JYJvbRUo4RLgvjOL0AJtB39E83Vg"
X-Provags-ID: V03:K1:OwSaLDi+eTYa6MtDsML6bcUNizsqaks+95nLKGtbPA8leaT5kdn
 53LO33DPQPDEgVSuWk6CFRL3iYEs4rLxIxvGar262uf+SwvBckkAqhKv1QwbPNuqrz78w/2
 oxDf4Vt0BprLsy1QsIp7daDLEo2dTy12J+GU+EOjHPKvE6uTQANMib++rhZHfhAdrUsNE6V
 4gqYwpId2Op95SPa2SAnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J9wiOGs+DEY=:jCdlp64Rer1YpUXUcNORXB
 O1xoMSfUU4xs1O9kN+P8xx+gr5Z8ZWnD+khT3IkrbBLHQt/49Q6e710zJ+JJZjBXGvC/JddWY
 aHYR7v9oDX3ACixn26bYJGRkH778qY87MBsKZP3tsd2dGpOIFN4VdW6ooC7fBie7lmoCimD4w
 0V7dfD+/toCvSD/04lBHCqGnRnpENaUY6Wjg/eg/a4CnW1HxNnFQLPd4rYiNCDE6EJpJBPeFD
 lbi6Rga8cGY67qWVjJC0X8OSOO1AbI6eZr49/1q2EIM8ftb/cXKkytTMJvUCn4QwlxjvGdlZR
 6H4HQGLYZecxK3yXt/YZLZscEahB8HtFBM3m+G9lm0ZYZL6Pyxg1YoG9szRKZrtx+gEqzKAEj
 VD4P4n9FFvosszFg7EljF5O2hilENhLntckG3hjuOjl+JSVUIUMDNx6ff9KfYssAIfu4s5fwC
 44feUaccOzhfkQ/ehKD6ohOxFs3Z4r7eToojUyZac2Mdo7AT5ZDk4W4T5LuxCPA626I8c+zwU
 vvzRlic9kt+vsnN9w9QFhdYrTuyyCQibmngDdwiaohw2u9Asp2UwNDRy9kuw5xcf1tO3QpyFt
 x2gnRezbLcQVCJlP/qlkrZWANLsyEVg0AYTPXgWmfQLORoL3ooAkYPVqIiRenUtDhH096Md4L
 qYbbF8F1yhgXhvvZFw7RrFWnL7z76gm6xDCxEUe/lp1Iz3dUER/WimMTQE31LuEmdzp3njrQV
 idsVikBFVcy8imPqYY6WKAX6sZ7WIBs8/IIoV1iaZF8ABTBozP3sYcXI++9vAcugIHsmcv74S
 nZdjtyHQoT2+snwE98GSphcBV9857fV+c99z739MBDloBOQs3iYJxCtQjTh02JKB0Pq7QQ+m5
 btHkcK8wVmXpG7ZQf9WvuixfWI6CZNr9AQJF0oLkfrvt75au8yVWATh2yLUvVYCxPyYMMwi6r
 tXUK8/uU54/zB2ukj4nM4KwCgzwhedS3ZxHVuuImY+8hn7RPwoHV4AutCnkcR3fEpyh7KXGvN
 nJ3WyXgcUrMfjFWQTsBICgcgMy0GMx7xhkh6VCYMuUF2ZB36INDqeXm7TvAgD+jebABya4gQz
 VcEsn9JZ2Dv1P5LWrdiAj7HCWAzIsuYtz47mIRRpuYaersqabYspDAt34h4aTAdmpf+WXRoYJ
 HsBzOoPAzLWyd2H4Nos7VACuim8on8Itzuc/ohkDYC5JvddmBZmpuEOlkCOCPr76pYVXLvBZx
 pZFf1Xtjy19KxvbYp
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zYKK3JYJvbRUo4RLgvjOL0AJtB39E83Vg
Content-Type: multipart/mixed; boundary="FAlTnjRcEWkh2KrU0nYR3Oc9yIBUNRPwJ"

--FAlTnjRcEWkh2KrU0nYR3Oc9yIBUNRPwJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/5 =E4=B8=8B=E5=8D=884:11, Johannes Thumshirn wrote:
> On 04/05/2020 22:59, Eric Biggers wrote:
> [...]
>=20
>> But your proposed design doesn't do this completely, since some times =
of offline
>> modifications are still possible.
>>
>> So that's why I'm asking *exactly* what security properties it will pr=
ovide.
>=20
> [...]
>=20
>> Does this mean that a parent node's checksum doesn't cover the checksu=
m of its
>> child nodes, but rather only their locations?  Doesn't that allow subt=
rees to be
>> swapped around without being detected?
>=20
> I was about to say "no you can't swap the subtrees as the header also=20
> stores the address of the block", but please give me some more time to =

> think about it. I don't want to give a wrong answer.

My personal idea on this swap-tree attack is, the first key, generation,
bytenr protection can prevent such case.

The protection chain begins from superblock, and ends at the leaf tree
blocks, as long as superblock is also protected by hmac hash, it should
be safe.


Btrfs protects parent-child relationship by:
- Parent has the pointer (bytenr) of its child
  The main protection. If attacker wants to swap one tree block, it must
  change the parent tree block.
  The parent is either a tree block (parent node), or root item in root
  tree, or a super block.
  All protected by hmac csum. Thus attack can only do such attach by
  knowing the key.

- Parent has the first key of its child
  Unlike previous one, this is just an extra check, no extra protection.
  And root item doesn't contain the first key.

- Parent has the generation of its child tree block
  This means, if the attacker wants to use old tree blocks (since btrfs
  also do COW, at keeps tree blocks of previous transaction), it much
  also revert its parent tree block/root item/superblock.
  The chain ends at superblock, but superblock is never COWed, means
  attacker can't easily re-create an old superblock to do such rollback
  attack.

  Also btrfs has backup super blocks, backup still differs from the
  primary by its bytenr. Thus attacker still needs the key to regenerate
  a valid primary super block to rollback.

  But this still exposed a hole for attacker to utilize, the
  usebackuproot mount option, to do such rollback attack.

  So we need to do something about it.
>=20
> [...]
>=20
>> Actually, nothing in the current design prevents the whole filesystem =
from being
>> rolled back to an earlier state.  So, an attacker can actually both "c=
hange the
>> structure of the filesystem" and "roll back to an earlier state".
>=20
> Can you give an example how an attacker could do a rollback of the whol=
e=20
> filesystem without the key? What am I missing?

As explained, attacker needs the key to regenerate the primary
superblock, or use the usebackuproot mount option to abuse the recovery
oriented mount option.

The only attack I can thing of is re-generating the csum using
non-authentic algorithm, mostly in user space.
But it can be easily detected.

Thanks,
Qu

>=20
>> It very well might not be practical to provide rollback protection, an=
d this
>> feature would still be useful without it.  But I'm concerned that you'=
re
>> claiming that this feature provides rollback protection when it doesn'=
t.
>=20
> OK.
>=20
> [...]
>=20
>> The data on disk isn't trusted.  Isn't that the whole point?  The file=
system
>> doesn't trust it until it is MAC'ed, and to do that it needs the MAC a=
lgorithm.
>=20
> OK, will add this in the next round.
>=20
> Thanks,
> 	Johannes
>=20


--FAlTnjRcEWkh2KrU0nYR3Oc9yIBUNRPwJ--

--zYKK3JYJvbRUo4RLgvjOL0AJtB39E83Vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6xMVEACgkQwj2R86El
/qivTAf9E9rIR6vymjF3/2fHjkGINx4W66q1wSLzFZEYzSq4L1st/1nXq7tKemO5
R/nrMnKUH92kYpb2vAIB8P69GBgpDYXeOwKgFNeQbf/sifR1WL9OfJi6oXLdtsju
rQxq9LMU3lgo2UKrGprvm/bfe5INVz13EscM/7uMx8wkTgb39cZ4NWf9436LIXMJ
pEfhNhxvpavmhVEqTcbrjxJ1GN5vy+lRnGDmEQ5KxeD70qGV2VzkKMHWz3tJaklu
lYSp8kqQQBhxpGRyXIYRTze0ITijZd2PQucCDarQLpyw5RdEAfH4hOsBDmp6v9bd
21gPmWhrcS59qCfhn0pp6/W3rP4BgA==
=UDEK
-----END PGP SIGNATURE-----

--zYKK3JYJvbRUo4RLgvjOL0AJtB39E83Vg--
