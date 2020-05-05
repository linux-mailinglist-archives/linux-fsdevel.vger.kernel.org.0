Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FEE1C525A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgEEJ7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:56331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbgEEJ7k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588672766;
        bh=l1jfpdYM6s1ezWW3TlOm8gRkZRmLfg8dhAY3Z7onJRE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=PJT/7DZlS5r+h+ZhIXEzLS1X+ELm1RPBW2bIY5PHwSgNral7kMMZIlUBXezFh8lOP
         /X2SxlE2cYB0aiHb2O3VZdsl+vEdsjkdVTw31eO1Q3TwBXZpIxgl1Rnw5eRWoM20st
         Sq1GKycALmRCxHlv001HS/84VeAs7xoT8b1sS6CM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf078-1ivApD1nSM-00gbjp; Tue, 05
 May 2020 11:59:26 +0200
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 <d395520c-0763-8551-ec80-9cde9b39c3cd@gmx.com>
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
Message-ID: <bb748efb-850b-3fa9-0ecd-c754af83e452@gmx.com>
Date:   Tue, 5 May 2020 17:59:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d395520c-0763-8551-ec80-9cde9b39c3cd@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wVr8or6ZtomrNYU86i9PVKXMyWPzpt4bS"
X-Provags-ID: V03:K1:E4VJ5hzDngWeXYO4KSdo/5wg3tM5z/oC7bv/6pgK99FBBKsN6TY
 1xNDHe4Ajjc8aJw/8VazA9LPePbPHTYY/hOZpgOJRTNDIlVQeJTgNmBglbkPCl/LRFG9NBl
 RaGGGcfR0p7yndmPCW4o6zZRAxjPjBtSe4zstfxvHV07FLNQVxNLaLu9f09MCO2L5D7SAcj
 7GqxS7BkuAVj0ri2L3Ckg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PEcE9w2uKTo=:I5P2D1qj8jjVBeWLcDjPh2
 ec3Fz6F4C2ESSECDZD1PGvM+RJeb9MAjutzvuNwHczbudvSfnOovfYmp14Ur5O/0KdI710csm
 EJGvp2OC/eZBYzHN8GU5zGbirn7mnGHq5O06Ee7/RPPsCmF5knWBS3h3AmJ1D6RBawV3i3vGP
 Fn5th6y0LilBMlMgmbu80XGKQEJj3/4JQ4xaMEQx7O43jS5l992l5uIRYc4nyv3LHKjiPVhO6
 TU1eVw0KzP3EqhcE3UVTjlMVTpJDXn0HX6ggvpyPMai35fiAFB2m3hHy5Knh929fdUwpGcIy9
 MZOPz4TkrmTFtIWuCa70q5VFrB2qfihdmTo4ADgzeYGvSiTjf2AYn9I3Jdpxi0bXeQY7+Y11+
 Negq9eDkxaoyyRIw8ytJvOqo0w0WnwBblBM+4KmUJNzFJ0VJox/amhjDPxjdTvU4RmeBSLAzU
 estmkOkDyXfyrh24JHjItSW6eZMN88IQyR1qMlZBwHRUa24RCKnKimWeY8WHQIy24Tzo816Sz
 0NcMxHn9eg6B/lwuDD+uBFOmqHDOoRvHTcAOJnggACM5kxAnXhaqjs6Go92I+MoPAgX8b5kRX
 iUOMnZh9rUVNvFnHgievGCh8x6oEf8qcnf/jFO4gKEWp9M2tIxbGbmasAtMd0odXE4I1RSdrj
 cgNmYMJUL3/PLlAODzUucZw/n/5Ut1EHUMdIBu6JcyeWVbFN2eZkMj8um3jPJxPSV0juM2eTM
 uKh86dNP5uLceaUI2AZfKCx9YyVf3Kqg/CJQV461LGOapfI8xqZ7TwPAhxU5MB052+6fdyvYw
 D4uKMO8fZswGu0ACN6OC5mzYAWkixuSeSWbO6Xhg+IQ8mRtcX2D4M9DsPaCdBcACB4vh0enji
 nzPhE9fZEkROrv8lOkKXiUC7UbZKEhuc/U3DOdELGqMeJnFBiKvesxEUsz8by9CsOzvhy4ocy
 c/otSbPmZu7UHh5JZjfIXIwtImkfOG0/wiWoRkLKd5wkTUbJvYqyPDT4zZKD1JSXLfObd6WIA
 gPKCBLeTYcYGFKH+3Gg3AT9y+zlv4d6eFfoo0DwifZmjsl067kYW5OHSmxBsi3EY2WnHHN633
 /RokQLI0A87qK/m0LZZKEqmPbaIW/UFTrxni1YcZNv6dgqiW1OMeX3RgQCsQ+TmE5DnuDD8UL
 Ao7EZNjeV4KefsIwu+InMDdqlcqhaVczrWDcXHEiRaZgzK/MOA6l8euYvu3KCdrRzc3opz9o7
 5qZv4SH+0/2IRSz9F
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wVr8or6ZtomrNYU86i9PVKXMyWPzpt4bS
Content-Type: multipart/mixed; boundary="sabj9w9kfWdKJBMAcNIOlLusGWLKXNju3"

--sabj9w9kfWdKJBMAcNIOlLusGWLKXNju3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/5 =E4=B8=8B=E5=8D=885:26, Qu Wenruo wrote:
>=20
>=20
> On 2020/5/5 =E4=B8=8B=E5=8D=884:11, Johannes Thumshirn wrote:
>> On 04/05/2020 22:59, Eric Biggers wrote:
>> [...]
>>
>>> But your proposed design doesn't do this completely, since some times=
 of offline
>>> modifications are still possible.
>>>
>>> So that's why I'm asking *exactly* what security properties it will p=
rovide.
>>
>> [...]
>>
>>> Does this mean that a parent node's checksum doesn't cover the checks=
um of its
>>> child nodes, but rather only their locations?  Doesn't that allow sub=
trees to be
>>> swapped around without being detected?
>>
>> I was about to say "no you can't swap the subtrees as the header also =

>> stores the address of the block", but please give me some more time to=
=20
>> think about it. I don't want to give a wrong answer.
>=20
> My personal idea on this swap-tree attack is, the first key, generation=
,
> bytenr protection can prevent such case.
>=20
> The protection chain begins from superblock, and ends at the leaf tree
> blocks, as long as superblock is also protected by hmac hash, it should=

> be safe.
>=20
>=20
> Btrfs protects parent-child relationship by:
> - Parent has the pointer (bytenr) of its child
>   The main protection. If attacker wants to swap one tree block, it mus=
t
>   change the parent tree block.
>   The parent is either a tree block (parent node), or root item in root=

>   tree, or a super block.
>   All protected by hmac csum. Thus attack can only do such attach by
>   knowing the key.
>=20
> - Parent has the first key of its child
>   Unlike previous one, this is just an extra check, no extra protection=
=2E
>   And root item doesn't contain the first key.
>=20
> - Parent has the generation of its child tree block
>   This means, if the attacker wants to use old tree blocks (since btrfs=

>   also do COW, at keeps tree blocks of previous transaction), it much
>   also revert its parent tree block/root item/superblock.
>   The chain ends at superblock, but superblock is never COWed, means
>   attacker can't easily re-create an old superblock to do such rollback=

>   attack.
>=20
>   Also btrfs has backup super blocks, backup still differs from the
>   primary by its bytenr. Thus attacker still needs the key to regenerat=
e
>   a valid primary super block to rollback.
>=20
>   But this still exposed a hole for attacker to utilize, the
>   usebackuproot mount option, to do such rollback attack.
>=20
>   So we need to do something about it.
>>
>> [...]
>>
>>> Actually, nothing in the current design prevents the whole filesystem=
 from being
>>> rolled back to an earlier state.  So, an attacker can actually both "=
change the
>>> structure of the filesystem" and "roll back to an earlier state".
>>
>> Can you give an example how an attacker could do a rollback of the who=
le=20
>> filesystem without the key? What am I missing?
>=20
> As explained, attacker needs the key to regenerate the primary
> superblock, or use the usebackuproot mount option to abuse the recovery=

> oriented mount option.

After some more thought, there is a narrow window where the attacker can
reliably revert the fs to its previous transaction (but only one
transaction earilier).

If the attacker can access the underlying block disk, then it can backup
the current superblock, and replay it to the disk after exactly one
transaction being committed.

The fs will be reverted to one transaction earlier, without triggering
any hmac csum mismatch.

If the attacker tries to revert to 2 or more transactions, it's pretty
possible that the attacker will just screw up the fs, as btrfs only
keeps all the tree blocks of previous transaction for its COW.

I'm not sure how valuable such attack is, as even the attacker can
revert the status of the fs to one trans earlier, the metadata and COWed
data (default) are still all validated.

Only nodatacow data is affected.

To defend against such attack, we may need extra mount option to verify
the super generation?

Thanks,
Qu

>=20
> The only attack I can thing of is re-generating the csum using
> non-authentic algorithm, mostly in user space.
> But it can be easily detected.
>=20
> Thanks,
> Qu
>=20
>>
>>> It very well might not be practical to provide rollback protection, a=
nd this
>>> feature would still be useful without it.  But I'm concerned that you=
're
>>> claiming that this feature provides rollback protection when it doesn=
't.
>>
>> OK.
>>
>> [...]
>>
>>> The data on disk isn't trusted.  Isn't that the whole point?  The fil=
esystem
>>> doesn't trust it until it is MAC'ed, and to do that it needs the MAC =
algorithm.
>>
>> OK, will add this in the next round.
>>
>> Thanks,
>> 	Johannes
>>
>=20


--sabj9w9kfWdKJBMAcNIOlLusGWLKXNju3--

--wVr8or6ZtomrNYU86i9PVKXMyWPzpt4bS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6xOPIACgkQwj2R86El
/qjAQwf8C2Wp5phmeO029yuQ992OZPUZfwK0Lwc5j4M/t5pzN5niIQ21j7rjYFBl
4dOR5ocrJIyoo+G5WE2Lyp1noBqHOsJA5a6huiTNurdGiX3c1nU/b/Vua1l7scFB
I22ESiX/4qrBI1JZRT9wYyhgd8vlRDaf1Ad8ufn1+cCz5jkcyFPzdqBMuuymHvL1
GAaAiQFXaS95R8b7CtpIxEoWUEPp6XcNwBlh2LEFrK0/niazWT7+UoKwBw5wBPIk
P4GEE0eXkjcY76IaQ3TScTQf8syfrWiOmerIow646xBVTPUwZmVdEL4PvHn/zM1W
A8oH1fG2q9BmW3Ic1vse1Qzl9W9b1g==
=pJ3J
-----END PGP SIGNATURE-----

--wVr8or6ZtomrNYU86i9PVKXMyWPzpt4bS--
