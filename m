Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658FE1E3532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 04:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgE0CIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 22:08:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:51813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgE0CI2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 22:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590545292;
        bh=b+kRttRtOARF7ACeO7JWvwZi9LCTFlR8wKM7BlLx0SM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Fldu7Bbh+TaoxSXaTvoRtkRY77/lRZhV3me2AvwhjfuDsltJu78hZ7jpkEN7310p0
         bIeVSYSi9BZsnp52nSLotjQ0iN3YZWfEdsT+wgB5kUr5xO3ZDE6OPvll0RZmfr+ZjQ
         ohL40LnWZ50yEuKmDS+ubk48YnTM50OhMj+OA7fc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgesG-1j5XfT2nj2-00h6Uv; Wed, 27
 May 2020 04:08:12 +0200
Subject: Re: [PATCH v3 0/3] Add file-system authentication to BTRFS
To:     Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200514092415.5389-1-jth@kernel.org>
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
Message-ID: <5663c6ca-87d4-8a98-3338-e9a077f4c82f@gmx.com>
Date:   Wed, 27 May 2020 10:08:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514092415.5389-1-jth@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bY1H2oeSHY7yGepsOJwpUNwlMsO2Zk1Qh"
X-Provags-ID: V03:K1:2nY+9gVDcWRV9KqR5rNWN8sZ5QOSsMxpiCf1DV1NR0w06e1h0f0
 2msTJgvhWTDcRxiRjLvTkCcNu1wE5/nsnUtJGO88iWIxfiv7B6ny1JbCjtM1nyHe5I1T1t1
 Fp+8pH1DXgcna9GHdgBaHH0saOlDBTYrbi5i3bg9+P0hrWFj6Pm1qcNdlzyQrPbftjtAyML
 WSkWOxs+69q/kzS/EY01g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sJ2qK++zETI=:dT7PzUWYSjBk73SDoXX3qN
 2dUwQJhShrxft6D4oY4CIQ9mMp93TbCYOE6ixo7Rs7Fo6Sl7LHqeoXLFSFODDJtY7TPy5wYdA
 J4O1Ip5pIoNzHW15voEkxYe2pi4G2EeMbLQJDtmmZaj7Y5lYBBvqPMx1EffX7fko4vxe28a7x
 mVD+VL1T2gelT1U4d5TQTSA65B/soY4TGOA73ABe0IDqT+BbcvWv3nqShiRMZz8+dUdsY4eql
 OuJbjg8joOYKhZ6TIlFkRlcbtMmachupZcUHrbs4MULBIf3AzuRDCicG3iOtZvLSTMToT1wMl
 Qj556BjIr1RBfJCHjOOAplFXdHrX1SiA5XBEl7WPJP5vfrL4buWOKsHIKBkH3s/c6cYeXXYsC
 +9p+UpOWJukvkfePn7tdVvRFMaQ8lwhhJmDaKjkW2Rpo1hMjerNP00vez/5YW2/jCxlgUOLDs
 JQvOKNTOewZx5bHMQmDYX2zAIvVb89DjT/zQ/Hfi+iTbvfVqqajKjLe4plqbvyophkyRnXHvK
 bBqs6/0sQRMVJY2lQdbXDaIzNsMCIrf3DSpKwFM4XsIXTKNJYYRNGm2a3UUfrP2uFhgHDDogX
 dlajWD3x/mKvbbx2IfkTA7a6lFE9RTG7llDWVaHgSJgNKIbcuhPvP85v4fz4g2/5eRlGBTTSq
 dwe6u3lzUxN33sErtHLjRbrfofWnc03aOU7AJpfJojT3ZlUYP8Q0Lfmsb5I4rSXnQ7zq8wwUX
 9tHfHI10KmPI2eCgaSoW03HRLQKhRK2HtALnt/W8uPy9x+dh6x4yDffigCAe8oLbTZ0HttIbm
 EbgOrGC7ZDMGPmFlzBCb87RWhQR6cm8N3aKKYgbL5Zo3yAJHUDTuUcvrSnoeDbqG4+B9Cy+vO
 tr/NTIeYLmAlQX8rWAWywdPbTOI+Xohxd+58AbKDQj3LtC/TrQM2qBZZphLGXjT8triov3sHS
 75OP5sfp2W4bk/JdvygXzp4Xub25BZNtXZPLf09dyUZh46jFWKvrPxPQjtZmNuqp9JmsrMeZj
 /LlhGz/QIhl9j8Yg3TazKzEAQWhAK900iMQMB5AODcXmhBGRWgeg/lg/CJ+bB6cGnviKQGkc+
 wSBB4rHAh4UF1QgM7HXeX1Za3zrjHdTV8zzlQWRAHVqKdjJrmcUSUNw40H8XVBEPEubAxgeY7
 1nKOZA6zCYRsNo3Ublt4tAI2kxa5/yXrb1Rn8dHicor9aVtNDsWmP9VH4fSzAM2EVWzeHBgK7
 sED0F23JQltea2K4b
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bY1H2oeSHY7yGepsOJwpUNwlMsO2Zk1Qh
Content-Type: multipart/mixed; boundary="51V4n0F9VKySgjHGHme3F1gITbJRw1eLr"

--51V4n0F9VKySgjHGHme3F1gITbJRw1eLr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/14 =E4=B8=8B=E5=8D=885:24, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> This series adds file-system authentication to BTRFS.=20
>=20
> Unlike other verified file-system techniques like fs-verity the
> authenticated version of BTRFS does not need extra meta-data on disk.
>=20
> This works because in BTRFS every on-disk block has a checksum, for met=
a-data
> the checksum is in the header of each meta-data item. For data blocks, =
a
> separate checksum tree exists, which holds the checksums for each block=
=2E
>=20
> Currently BRTFS supports CRC32C, XXHASH64, SHA256 and Blake2b for check=
summing
> these blocks. This series adds a new checksum algorithm, HMAC(SHA-256),=
 which
> does need an authentication key. When no, or an incoreect authenticatio=
n key
> is supplied no valid checksum can be generated and a read, fsck or scru=
b
> operation would detect invalid or tampered blocks once the file-system =
is
> mounted again with the correct key.=20
>=20
> Getting the key inside the kernel is out of scope of this implementatio=
n, the
> file-system driver assumes the key is already in the kernel's keyring a=
t mount
> time.
>=20
> There was interest in also using keyed Blake2b from the community, but =
this
> support is not yet included.
>=20
> I have CCed Eric Biggers and Richard Weinberger in the submission, as t=
hey
> previously have worked on filesystem authentication and I hope we can g=
et
> input from them as well.
>=20
> Example usage:
> Create a file-system with authentication key 0123456
> mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk
>=20
> Add the key to the kernel's keyring as keyid 'btrfs:foo'
> keyctl add logon btrfs:foo 0123456 @u
>=20
> Mount the fs using the 'btrfs:foo' key
> mount -t btrfs -o auth_key=3Dbtrfs:foo,auth_hash_name=3D"hmac(sha256)" =
/dev/disk /mnt/point
>=20
> Note, this is a re-base of the work I did when I was still at SUSE, hen=
ce the
> S-o-b being my SUSE address, while the Author being with my WDC address=
 (to
> not generate bouncing mails).
>=20
> Changes since v2:
> - Select CONFIG_CRYPTO_HMAC and CONFIG_KEYS (kbuild robot)
> - Fix double free in error path
> - Fix memory leak in error path
> - Disallow nodatasum and nodatacow when authetication is use (Eric)

Since we're disabling NODATACOW usages, can we also disable the
following features?
- v1 space cache
  V1 space cache uses NODATACOW file to store space cache, althouhg it
  has inline csum, but it's fixed to crc32c. So attacker can easily
  utilize this hole to mess space cache, and do some DoS attack.

- fallocate
  I'm not 100% sure about this, but since nodatacow is already a second
  class citizen in btrfs, maybe not supporting fallocate is not a
  strange move.

Thanks,
Qu

> - Pass in authentication algorithm as mount option (Eric)
> - Don't use the work "replay" in the documentation, as it is wrong and
>   harmful in this context (Eric)
> - Force key name to begin with 'btrfs:' (Eric)
> - Use '4' as on-disk checksum type for HMAC(SHA256) to not have holes i=
n the
>   checksum types array.
>=20
> Changes since v1:
> - None, only rebased the series
>=20
> Johannes Thumshirn (3):
>   btrfs: rename btrfs_parse_device_options back to
>     btrfs_parse_early_options
>   btrfs: add authentication support
>   btrfs: document btrfs authentication
>=20
>  .../filesystems/btrfs-authentication.rst      | 168 ++++++++++++++++++=

>  fs/btrfs/Kconfig                              |   2 +
>  fs/btrfs/ctree.c                              |  22 ++-
>  fs/btrfs/ctree.h                              |   5 +-
>  fs/btrfs/disk-io.c                            |  71 +++++++-
>  fs/btrfs/ioctl.c                              |   7 +-
>  fs/btrfs/super.c                              |  65 ++++++-
>  include/uapi/linux/btrfs_tree.h               |   1 +
>  8 files changed, 326 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/filesystems/btrfs-authentication.rst
>=20


--51V4n0F9VKySgjHGHme3F1gITbJRw1eLr--

--bY1H2oeSHY7yGepsOJwpUNwlMsO2Zk1Qh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7Ny4cACgkQwj2R86El
/qhKAQf9GkOgXua0TZq3qxlK/i9Wc7uuO/1SDHZqdijK7mSGOa4+knRNO9gKOzn2
hkuy+nqzr6YC29+ZVdNaS0fB394EqAlUPj2FYaWpase+YNm924STDG6seQ9Vk3nE
XMu43b56i5R/wvFrCzrW0f0Ko7QffhlwL2W3k9ZFaEqyL8FuCNOH7p+/dB3OZd20
pdKfdfi9xsTL/l0Vn18vtxYbJ9zRlTAriFHCxpXfwrqxH3Wk1ezU5US+4Jfx3Cit
Ok3F+s1xQh0BNpbrQih3KBpJ6S1PQdmImNPgYT+HsG7WuBhGFSk9/e2gjcCnsttR
2gpWkT1FBEGekJaf01s5NgtPVb/4hg==
=eiWJ
-----END PGP SIGNATURE-----

--bY1H2oeSHY7yGepsOJwpUNwlMsO2Zk1Qh--
