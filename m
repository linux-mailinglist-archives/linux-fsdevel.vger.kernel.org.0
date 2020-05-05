Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208AC1C64A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgEEXzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 19:55:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:56475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbgEEXzn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 19:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588722934;
        bh=txko/MvoZ2M6adnjfmi7UT9rYBD6VJ+XoYrkDAjUx40=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VJYs08pss3GGncKJVEQbXYsTEn/J8dRB1YObKt9dRk6kujxlllHplmYodvZ6vE9uq
         fn1LV5f76iuraqvwojIrBtuB8ip9sKbAxI+Y9MqNEksI1EcKB7PHokyQmrOmjbE08n
         RTjeaiDL8xmRe+/3wkvFwd/tVWCoXYOAHVkmhQ4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1j5Cku0cDZ-0104Y0; Wed, 06
 May 2020 01:55:33 +0200
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
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
 <bb748efb-850b-3fa9-0ecd-c754af83e452@gmx.com>
 <20200505223221.GY18421@twin.jikos.cz>
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
Message-ID: <d37ea86e-0eb7-30af-331a-447419a2f052@gmx.com>
Date:   Wed, 6 May 2020 07:55:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505223221.GY18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B7BqKdYLicNGwYWsyuYKN9a5H91r3S469"
X-Provags-ID: V03:K1:zoV7IL2uOXNZ/MSezH+vSYK5251iAiOJ1O6XsYdHIZL8qv3xsBo
 g5WuEniGWa5lx+I8PQshV/6Djmc30cJXAID6T8QRdwAOMVF2VUBmjziXQkTNbEG+2H6Wd20
 LZywl4ga9HdMqM5w4GwVPTa11y51+OqmvBKPu+Pll7yk24AsxA9+vse9b3TjmEllXu4KahQ
 Dan9D4R3/+WKYbBkALOoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kpNJFhfKBMU=:qD+3Xw9SQXJ/8wCr28Fmbc
 Fdv4t/goa/BYd7gOBfMW//p8wX43DmaFfOEokyvXnQiJJopwLFpeU49UxF0mduhip1HOFHifH
 ywHilWM4cNQVUiWECTO7S6V1TRvef/1fs3nKusf+MPm+8CfNDJY+rFiA7r2fOBbU9TEhnkhbA
 PeVwLoi4XD4FKCMnVPpVFGRr239DS0LOEnMm72uCfYddUj6SlXt1m5D97xE7tw9I8a5FbkPGb
 QzJblDnzc2Zr4ifd6l8JZETi6KsMpi9mA5MrVXJDSB8RaKNJBoGFdFrDxc77ZgOPz22y5Mswo
 32U+dYvUttuFHua5lvypNn9DNIOKUd6OIWvAB4LlEhXwstvwdkEd0pP6yRPZDERpMPa1ecJuw
 DDNQrieVVN3tTkS3QF9HCuW8NeKUOko/we5Pqcsl1NLN50qxfDbhHUmeiLaiI7pXXBhsP6ugB
 c4QPPr/SVuscFBUmxNSV6ERrXV9bWmNVHQ5gqRZ5mySqzLoFgXUcMdCa+d2jhFAVWoq4WOgbF
 AxFvmQg/lAmlY04KzObN4MbO9SLaSFTydWa0lYyk4/aFMQJF1ZcetKvX9Tr2dOF+CvQDPmo5O
 Mnk6GK8LbQTSRG5sK9SXf4Vk07H2dbFOFBoyrqroGvGo54tkdwpCXgfptjdx+9zfU5zIoF9FI
 nBhsXlpvyeHDHwFAjPyaKb1TGiFb9WpjRZv07+uw7DDH6qBYzTa5R+za9TWC631W0YMg9+nrb
 pEEsJArAY5SA7GDUaNaiXbIXjjtiBxhhloP7t5oqGI8TDWoZnYPC3V7e+nRWN6+4Szo6i64yM
 /EoVql8ICsF0iM8CtM2iED2eFUrAGyFOQQ1zB8VI0Stq3rwT32D1s4gVOAmg4wYNx7Ul7FR2R
 AI6zu+OMidIZQL3XFaOsXo9f/m1FgGzRc56oDvf2KPkRlFLGqJwXlb+NEpzEqfNACAqdVagBb
 qZuS0cwB12guimVpzKJOq376YXgNkGNxe91xEe9dhKjVmeSfTETPuGCbeoVyUd6Rh6P7zi35Q
 U1yi42GfUCwUPB35GEqPWZZ53OIu9zcLjXMxmAezpOODXc2u6xKVK6f7iW8MFB8X38NEmKT07
 XnT7/81JQ8EBbtQwHj8zVSN/bNOLyM1qRKFFgoiQh2WEdW0IOeYqEEb6FoT8aM+AlJgvMR2WY
 +CJt0+wtcKtpYrPoNYI4+hI1HtLDL2ntzYeiqrr5Z4ufurNSMgJdTVUyIyPWJFYNpENPg5NkQ
 eKA2tCFp/gYgvtYZu
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B7BqKdYLicNGwYWsyuYKN9a5H91r3S469
Content-Type: multipart/mixed; boundary="QPEJqMJKQVIl3cwcijWx0jcEocPuPkoxs"

--QPEJqMJKQVIl3cwcijWx0jcEocPuPkoxs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/6 =E4=B8=8A=E5=8D=886:32, David Sterba wrote:
> On Tue, May 05, 2020 at 05:59:14PM +0800, Qu Wenruo wrote:
>> After some more thought, there is a narrow window where the attacker c=
an
>> reliably revert the fs to its previous transaction (but only one
>> transaction earilier).
>>
>> If the attacker can access the underlying block disk, then it can back=
up
>> the current superblock, and replay it to the disk after exactly one
>> transaction being committed.
>>
>> The fs will be reverted to one transaction earlier, without triggering=

>> any hmac csum mismatch.
>>
>> If the attacker tries to revert to 2 or more transactions, it's pretty=

>> possible that the attacker will just screw up the fs, as btrfs only
>> keeps all the tree blocks of previous transaction for its COW.
>>
>> I'm not sure how valuable such attack is, as even the attacker can
>> revert the status of the fs to one trans earlier, the metadata and COW=
ed
>> data (default) are still all validated.
>>
>> Only nodatacow data is affected.
>=20
> I agree with the above, this looks like the only relialbe attack that
> can safely switch to previous transaction. This is effectively the
> consistency model of btrfs, to have the current and new transaction
> epoch, where the transition is done atomic overwrite of the superblock.=

>=20
> And exactly at this moment the old copy of superblock can be overwritte=
n
> back, as if the system crashed just before writing the new one.
>=20
> From now on With each data/metadata update, new metadata blocks are
> cowed and allocated and may start to overwrite the metadata from the
> previous transaction. So the reliability of an undetected and unnoticed=

> revert to previous transaction is decreasing.
>=20
> And this is on a live filesystem, the attacker would have to somehow
> prevent new writes, then rewrite superblock and force new mount.
>=20
>> To defend against such attack, we may need extra mount option to verif=
y
>> the super generation?
>=20
> I probably don't understand what you mean here, like keeping the last
> committed generation somewhere else and then have the user pass it to
> mount?
>=20
Yes, that's my original idea.

Thanks,
Qu


--QPEJqMJKQVIl3cwcijWx0jcEocPuPkoxs--

--B7BqKdYLicNGwYWsyuYKN9a5H91r3S469
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6x/PAACgkQwj2R86El
/qgLOgf/ej5MWh5Ir8+tMSjC1h7NX8HyLuJi/GnVrCsPLhL4Zmrdnhwb1It1+Lpu
PHG4N/3bZe0jM/hbmUHyv4eSGjkiKPyIezn0kVOsZld8rIyzKKV6rK2yOnJEoXV+
L5fIGtAevFPQrz6OYPjcV+ImCjezDrjV04wcWpgQdSnyPVeMRarOiZZ4XjEISsyU
/3/CWXYCXU3G4vgYGreORq65Xv8u+cQ+VwbNecg6j6aVG5CDGdYONxILMfiuOaaH
aJ1d9/k2x3wMj6Qsy7FOy0zvnVyD08CNMAbh/tSjwR05ZdPVCczo6Ir5RA03UVUM
45OiLXHeRNH7Qam4j6Bmu2ALJGcKeg==
=r4W3
-----END PGP SIGNATURE-----

--B7BqKdYLicNGwYWsyuYKN9a5H91r3S469--
