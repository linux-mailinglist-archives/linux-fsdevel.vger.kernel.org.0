Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47E13B864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 04:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAODyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 22:54:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:49063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbgAODyw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579060470;
        bh=oey+bGSDZcVc39amlD39i3yaZnQJybVfefztiUwy6VA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VFRDFhJcuQoc8OrCcX1QvqTq65LqESpPeMaJFYnq2UwiyY7hnPN06Xhyzmj4qnqUQ
         qLdlobMtryqxfd2aHWLNaCZ+FBvOkJu4OUzNWJDkXNhg0simH2efPxQkaeMe8WaeRS
         xlBqIKCBu5IGqq6otjeDoxsoWM3X6Cea3pzGxAeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfJX-1jeiba0coR-00v6Fp; Wed, 15
 Jan 2020 04:54:29 +0100
Subject: Re: Problems with determining data presence by examining extents?
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, hch@lst.de, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4467.1579020509@warthog.procyon.org.uk>
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
Message-ID: <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
Date:   Wed, 15 Jan 2020 11:54:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4467.1579020509@warthog.procyon.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kyNX94pNiUDmTOWGi0FWq7UFShlh1konR"
X-Provags-ID: V03:K1:YanSqm2m59hj7+6ra6X2fxbXpjUZaC3KWEnNHzka+qrSJSma/IU
 TQs3ptC0Vc9ePSm56fm7+8pn7S/hdc8UOOiOxNAXwk4DGJQUJpk0pRuuix7HnxNnup72wRU
 EgblHFYF7BDyZGtPoabwgmQDWxT3r6O/QS++2f/vLB2QGr83nIMEEYKF5ZCd37Dv7vSud/P
 rmC7giU3Qbr6haav5i3qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lApdwue0YmM=:EFi2hCpnRZJ2rpKSD/k3sO
 Lhydjj+Wroj/6Manswk++sZuQPEh4+erKeoV/t+UZpfma5EdP6opOuU8AOnzrQ99YR4jBgpfF
 iaVW87V7UakMs6DaFRykGC2A7Eat+fm/Lb9KhMN9s8ibQ8VQssx0615rYVI6GsqwpXLAZhZke
 mb8t+OFGtXDAgN1oX7WJtTvPgb15RibJCwGsSBfxr0jIEDm5rEaxp2fbEdwaNtWVBRpNBwyGH
 EZuz7/ExYkTmp2PJbuGG9UJoCpVSy6X3oZ+R9hfTZZSc658mKwDZWbOfMIbuMeWTJ9mu7uAmF
 dN2CgPrJhiGw9QC0+vHE+l2n4n12lHk57jV8t7zqHdi1t8TonF4JWCevZ34IBs/32YIc9y3uh
 SlF2LPNT6qBMxVP8+z9uV9Mgs7wf1ZbH+ViRN0MogNRgY/B79AegRwfDUodjOpyEiTRmKuO3E
 r18YUso/A2B0mi5g7WXYEojmeGjKn3CVTJBPYZfhO/7hxMBumRspzuRJ5g7zMk5lZRIRjxx03
 nk+tvY2ucFmXx9vfR+ntG/Z/FAzBFlJJaW6eGzMC2C6Lo07b0mVdxjrCqLJVvSwATK9mNnu84
 XeF/Vj5LToQVsHc1CBDvpdon41+b+7QgoLVXwiL8LaDErx+Wd/p/nSSAo9aYOJdxq5vkwYKK1
 JrqyfDyyX4spvZcLUB79wtIO662jotaE2Xgw0VFwbVT+ZvrmRFMCPa98PA75LCWzQdlifQ94A
 RNPmJGHrftCyBL+a5jZ3raSc9iCDR275WNyNb1+mAHOhOES5A4IvKPUz5dFaL6CgTenkKR5zu
 2UcGgVIDYmxBzSPiKu9oHpp8atGBuOIftI6Mt9b1SN9TPZEGJdStpB3QyxS+iqPxTcrd1hi5a
 +bBvQG9h/H352okWhAkjR7f806+o7KkM2rae1SF/ELWQrw2aprJWFfUH5fRff00W0EKBZ8BYL
 n63NtvbDh7kw+MYCqaWs2HNCk5caqbTRqJ9PQrQzns6FagsoUtGiFdFsMYKKDN7x522A9mLmV
 pSoAOdyD2kDic/OS4CSccUkdUYQV7elBFd3/l1uwvPoRMv/XZwGHBrh7XNzqF/hJnKTHemivo
 BD/MggCw/KgZ/CpHs5f4RldoH40j6hLXe4sGEbicsFIT8WBS+agQ0/DfkTaRAppt2zX+o3R2r
 cfng8k5JlM+Xm9olkUrGfDWqoZg+5h4nbJDTmWZkPE0LgKdeU1n7qEJo1qblLn8IoWQCsolrA
 6dceJcoMv1OMzEquRz9wmrgr1lstGIv/RpF4pNvVXdFXqKxIRNaqcwen9mvc=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kyNX94pNiUDmTOWGi0FWq7UFShlh1konR
Content-Type: multipart/mixed; boundary="gB6on3XvgIO0Qk510JqOC9SbshhQFMe5S"

--gB6on3XvgIO0Qk510JqOC9SbshhQFMe5S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/15 =E4=B8=8A=E5=8D=8812:48, David Howells wrote:
> Again with regard to my rewrite of fscache and cachefiles:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/=
log/?h=3Dfscache-iter
>=20
> I've got rid of my use of bmap()!  Hooray!
>=20
> However, I'm informed that I can't trust the extent map of a backing fi=
le to
> tell me accurately whether content exists in a file because:
>=20
>  (a) Not-quite-contiguous extents may be joined by insertion of blocks =
of
>      zeros by the filesystem optimising itself.  This would give me a f=
alse
>      positive when trying to detect the presence of data.

At least for btrfs, only unaligned extents get padding zeros.

But I guess other fs could do whatever they want to optimize themselves.

>=20
>  (b) Blocks of zeros that I write into the file may get punched out by
>      filesystem optimisation since a read back would be expected to rea=
d zeros
>      there anyway, provided it's below the EOF.  This would give me a f=
alse
>      negative.

I know some qemu disk backend has such zero detection.
But not btrfs. So this is another per-fs based behavior.

And problem (c):

(c): A multi-device fs (btrfs) can have their own logical address mapping=
=2E
Meaning the bytenr returned makes no sense to end user, unless used for
that fs specific address space.

This is even more trickier when considering single device btrfs.
It still utilize the same logical address space, just like all multiple
disks btrfs.

And it completely possible for a single 1T btrfs has logical address
mapped beyond 10T or even more. (Any aligned bytenr in the range [0,
U64_MAX) is valid for btrfs logical address).


You won't like this case either.
(d): Compressed extents
One compressed extent can represents more data than its on-disk size.

Furthermore, current fiemap interface hasn't considered this case, thus
there it only reports in-memory size (aka, file size), no way to
represent on-disk size.


And even more bad news:
(e): write time dedupe
Although no fs known has implemented it yet (btrfs used to try to
support that, and I guess XFS could do it in theory too), you won't
known when a fs could get such "awesome" feature.

Where your write may be checked and never reach disk if it matches with
existing extents.

This is a little like the zero-detection-auto-punch.

>=20
> Is there some setting I can use to prevent these scenarios on a file - =
or can
> one be added?

I guess no.

>=20
> Without being able to trust the filesystem to tell me accurately what I=
've
> written into it, I have to use some other mechanism.  Currently, I've s=
witched
> to storing a map in an xattr with 1 bit per 256k block, but that gets h=
ard to
> use if the file grows particularly large and also has integrity consequ=
ences -
> though those are hopefully limited as I'm now using DIO to store data i=
nto the
> cache.

Would you like to explain why you want to know such fs internal info?

Thanks,
Qu
>=20
> If it helps, I'm downloading data in aligned 256k blocks and storing da=
ta in
> those same aligned 256k blocks, so if that makes it easier...
>=20
> David
>=20


--gB6on3XvgIO0Qk510JqOC9SbshhQFMe5S--

--kyNX94pNiUDmTOWGi0FWq7UFShlh1konR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4ejOwACgkQwj2R86El
/qgA9QgAoVjIxeQRumpojy6W5vF6GGlMm/M+IKi83tAOPWnYDP4OIVhiqL/7f1fG
hxue8/hEQW737NImsOQlQvsqD1n8YNg0XEi/zQB6YN5tgtS2s14RzMTPFBlkFosC
ky6DJbseDFAKDvHebodfUxZsL9ibE/YwiOUcrITp155mpVbnYTT+LF2C7a8Emmo2
Sh+7IEWwRDy00TYQ+7lQKzTdD4zj74AvHutpuuMJ/8rstb0y2SS6pkB5EQAno1yS
81owvjgp2EiaZdWJpunBHIhvROfF6nIzZP1czxOAr0T648PBYtE0EcZpOkKH+PHe
Ni8Ucj5vI0r7m6Y3yqZJ5Y8dBTPTYg==
=SBbx
-----END PGP SIGNATURE-----

--kyNX94pNiUDmTOWGi0FWq7UFShlh1konR--
