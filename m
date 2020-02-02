Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A270414FB33
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 03:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBBCCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 21:02:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:39657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBBCCS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 21:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580608937;
        bh=jS6B2LN4qRD1FiWx/800KFZ9BGh30fsz9JBNS1d/JxI=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=BdW4Un1m19VLx+tNrh6ZJH+D61Zc2ViiSvBglm79x21cVLXZp7aCDXKGiDu0StVtf
         6+vWenuBHAv8Kx6KpXO7uhBhyX8nysEG56H4tz2iDD2TnHtPp4oclT6w+Hgez01I49
         31pvWV1YI9QdpXJcskUxfbnjPcl4oDk4zrDaq2Y4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mulm5-1jonlb11Nr-00rsEH; Sun, 02
 Feb 2020 03:02:16 +0100
To:     linux-ext4@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: About read-only feature EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS
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
Message-ID: <4697ab8d-f9cf-07cc-0ce9-db92e9381492@gmx.com>
Date:   Sun, 2 Feb 2020 10:02:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ttRdle2b4khj48s4ZraTVMryllJUe6JaV"
X-Provags-ID: V03:K1:ldIic9/tqxvnJX8pO0CLhWW+L5Zl4LzvIzzan8YC+Rq1Y9wL3RF
 Ee08je3mC51S+/tJ8AppS5ZesqVzlmT/R/O+HE92oeVjYztn8jqPnllr0qlKROskv9UL27o
 qOGIrHZh6GZqXgEiXphxZzkjBts49J4KkiyZci5rSsRYatY+2OHEPze1R9+MRBucgv7pUPw
 l3lkhILGI7YK2pxlbF3mA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7GMOS1ZlqU=:3S8s7fQRY9TorMIEfY6o3H
 9bmHXSsUCh3rm4d9IYOKq0oZx+F36lwBlBDMQp1+/PhAb+qlHI7GQ6VGAYxNcqpqJ7PmYyS2P
 kn5n1V8yFG1oM1bqKFRJE/y5sE6bWz81x28mVkuc/iVguELZ2gTnEOaomKp8sL6JjmdykHHuZ
 NIfatbPPEKGpnoiKMvLVZcgKH64m4gfn63MQwaYXWIxurmqzBox/pE7C6NDDleBSgCLNZ/dGV
 j13kYIlkAh7bBb1db/TrJ3eNbkcSiFBsH4tCTmkt0fsSrFOXFE/M5ShRtXabxDjgU7iSsthoL
 ylWmiOtC48fhB2GYv74SHbI3uD8IfZ04yt0koUwo1AkotM9GR4dnQqGmimQTodDOWOcMXTPEH
 pTnTkHE6M9+ZnUz0LiC07Zw4BPm0U0tIp1ksn3+SX6MrotVq9hwSnA9FQVfwQp02yoDNpXT5X
 CK0eTwd2XFEcLFSqiuQil+ZlgDj/aTw9G7BzNSPnToQvXmdfh3WXNP4pTpkdOqaT7PDFVJbo+
 D/cYEZz1Ffwp0c1y3Ye4b7JVWZMLY51iRdGBJZvyQvdAERhvnLHRing145AGFViNU3nTx8/c3
 /hpNz6a0oG8GJbIDdaT+h0gyMW6vBDxZNbVFNiv1zcdsIOe4A4aUVgoLox9a2/LznTEDF1TRJ
 B7S7539lYQbirWy8CPUueQoKt4Z6fZx/jDWI3+HbQ4sSc1mxaTxFVs+4ffz/zqHxibFpdQ07t
 18FA71ELw2LAyHYdjBAcrbrYDqkbDUES8QcUvlPOgkoBbLWe2FKZeOE4+wAExNU5L27p/nc5R
 YQZOhglkwAMz6Xp1vgNwwMIL9zJ/HxTcVYgUSoG5/qP9TOGcT50sjFjw77+7tTu3oOd5duHgw
 yHxahDFk4vaHlcZhMqJd/1ghyU7jylfR3w4TLHoJ2f9KnawEmEgVu9goZIRWwrdktxZ6WXrF9
 KoQ3f85AC1AfSKpaRnW4IHBfdGcFX4DwGotDi/nmr8TPtbxlwlp1+LQyUr0RN3Wd4BlC3idp4
 MfRNExvFAouGGbrMXyeMvqj3NwOYHjaNCM/ACURoxk6/jKFJjhIvkh10Pd08Rb01T9Yw8nXJ9
 ny9Y+3+XFKhL7ntaZflvb5lSzpRn/gcCLLxGt72DcXSjlvJ+aTV7RmhYEgD8ocyRRsBagrwmz
 ymOiM5gS0xf2YUknFHLOk1TynG+KXCBrhbbJUW4Bt/pyfr2XVyN7G1vwkuAZpYDu6fszksO+G
 znC2cd4JlwgdOJps9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ttRdle2b4khj48s4ZraTVMryllJUe6JaV
Content-Type: multipart/mixed; boundary="gHzb7Jv3uwwl8ywRz1kd3twosCZQuJEAz"

--gHzb7Jv3uwwl8ywRz1kd3twosCZQuJEAz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi ext4 guys,

Recently I found an image from android (vendor.img) has this RO feature
set, but kernel doesn't support it, thus no easy way to modify it.
(Although I can just modify the underlying block for my purpose, it's
just one line change, I still want a more elegant way).

Thus it can only be mounted RO. So far so good, as from its name, it's
kinda of deduped (BTW, both XFS and Btrfs supports RW mount for
reflinked/deduped fs).

But the problem is, how to create such image?

Man page of mke2fs has no mention of such thing at all, and obviously
for whoever comes up with such "brilliant" way to block users from
modifying things, the "-E unshare_blocks" will just make the image too
large for the device.

Or we must go the Android rabbit hole to find an exotic tool to modify
even one line of a config file?

Thanks,
Qu


--gHzb7Jv3uwwl8ywRz1kd3twosCZQuJEAz--

--ttRdle2b4khj48s4ZraTVMryllJUe6JaV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl42LaUACgkQwj2R86El
/qiNdgf9HKeu+xtdBWRXm8yvy0x/giFCC5dAThCixVc+637hFh3eqgjD+AvdDcqA
Rj2X1BGKgJGvGJvL6tOdQ7Ga9rb+AeNbMm734KsZMi/89gKYqh655hiMoyKyvr5E
n8oW79TUHkgo6sZDAwkxZfLQep4a9/j+LgEOGhdtmSM/r/LyjtegyaEH3GDcG29c
2IwLQ0DwOHOzN1gqu1Yfz97ObPKeXk5Zhs/UUoVHYV2myCsfoP4pL5A5wsm6D4qv
Bf5E8bwAbRLHklM4ezr3ppiNjQ1yTdshS+vfQHvTiMCytUxM68LuxCdp0qx43h2R
5WLjMJ1UHAicKxP0iyHGeAex8aUETg==
=iM+l
-----END PGP SIGNATURE-----

--ttRdle2b4khj48s4ZraTVMryllJUe6JaV--
