Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A129E14FB3A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 03:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBBCYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 21:24:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:53077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBBCYD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 21:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580610241;
        bh=QW2VGG2iGFRRfKMKbGEU2GlyLyp7Tomqr0pu7RshwOY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ac9SeQr1ovcNmQGTU+bR4EnFcN9Fq6eFYtNC4Md+FN6Jt0ScGRXluO3YSEa5GbMvP
         F8ph/sm24yfq4XhtwcEp0BR5Y5lOAiiZbmBQcyTE7CzA2zOY8DWA9xevZmKND2+q6y
         Pp4HD/J5B4UOV1JWxEWpYuRBDxYMaB91gwG8CpdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1j9xPr1gVr-00NvRv; Sun, 02
 Feb 2020 03:24:01 +0100
Subject: Re: About read-only feature EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <4697ab8d-f9cf-07cc-0ce9-db92e9381492@gmx.com>
 <F933761F-D748-4FD9-9FC3-2C52D7CA205D@dilger.ca>
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
Message-ID: <546928bf-842e-0f2d-721b-216f04c696ec@gmx.com>
Date:   Sun, 2 Feb 2020 10:23:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <F933761F-D748-4FD9-9FC3-2C52D7CA205D@dilger.ca>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZHrVyvt24POpnHmnyHib4fRD5MEU2lXej"
X-Provags-ID: V03:K1:9s076PsAFFOlCZzcAAjLL+5U57FBj3mM1OuYpkAznfQHhoiqDRz
 fCfd5htNXh7NekqL3IzacHfbbpimlgwAOb1Kaib1LkJOxngUq9tBbVMcwJzgzLRpIkenCLB
 /tpzbfcZNE0+G/K/QLSJ2R+VbFEfHjly2JyIHNT5Dj4THDDCSsD713L+pugI3fCSuEus3/5
 GBxUmc4t1hwllN/Iv46IA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9uyQLELhvKw=:AMDtsJqVyrGs0Zm9yrUBFH
 xdwlNDzZt4/IBf+8yn0bW5qxStJ7oUVjCH8WeY1BFhk5JOH2iAavFgnGVN2tFvKtXQgqPXp1+
 LsGBWBTszUk5hONqrAyGsouW9oCjKsoAtbemsTbvjeKPIhQt238SEV6dPfYL83bQoNOeVnbm5
 N8wElq3OlpFwTgETqfWpPj68TmHiiUIXuuNSY3D6GzuwHcBxmzV+kOgNAzzfI9j7Y0tlQCz0+
 /9uE26b+h9klijQ2IAggiUMgxMrTMT9RnjWCT3siCiwq2/EOPmGsRCFLXyOfDtfb3mkFkcCZ5
 WkuGgkPmDvbFtgmDtQ3t659GFHhAA9hrHynQMjIvemLkON53XWDnefS6zgVlWsQzKuqNupnyp
 jqXGTajskakximVYJg7I+jbVd/QDujnq2hfKL5MziOu/CFFJ8U/rLU4f6r7jX6DLmWX9fUeyj
 Xsx+NheqSK9BlDmvSjMNLmRL4TaS8ejTESs95+Cwn/ps057l6P2sbgOuYPkgBOGaapZw8jIGL
 qLpuEwCPwqG9BtaNMjx0ZNxvZMed58jeZSHVGgz17h46L+YsuaPsJZtRboHlHsAB8mxJvHdZn
 sfR6f9MXH4/EtMhTpefzqpZ2H/ZmVqm+5MrP+h5B/5/sDrA2omAt9Rl5Fzf83UtGwRkT3u521
 YxK5H5bNMvPuM0Hpc0j1LAX6IXyQXYiPLM8rNa8QznAqrKd2JMvEK8x7ruTf8ueM5IqGi/SMe
 PqOEkyXKQf4HMl7qw5zKuvTNov2XQzR+KkkjoJZQ3tUvYnX5kVB7skISSrTEu0xziyvJ9GPxQ
 NDugPJOaxYYj5Pmu3m6Q2Al3LN48Oa1rbr9j5Eecoz630GCmCNdXd22co4kA7aqvbVDLrRLoC
 DnN/m/EcbtXLRcxF4ZAQV9jjEIKfXjJH9u6OnzZSJzDnMGdeKlAj2zppyLDmeEdhT27pN8cg5
 6EC/8x9UhyfcddQXjw3WMwIOaLlBpGI25JAMfB0Wceypl51D0L2AjfxiHV/Kc5oaZcaJEg3sf
 /mFsWHzso5Fzb5DgBbwvgN5z1R2KPh7BMMUSIuDowDPgaNo8DRJF9sb9KwcHSpotF+Bw6XYa6
 +wBfEi2Hgpq2ZltoO0hyMFw2UzCTBCxPMDnRMGqEQZeNkn+Tw2CynZ2moEKs2uzUfk9N9C942
 lmAub/Gr0nwXjmlQHlod/EqiThInFKzc9nhCmr1mmU5GvKyg5fV63CO1hDlmtZxlnbtqeVYbG
 OKF2XL8AbujtLQwwP
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZHrVyvt24POpnHmnyHib4fRD5MEU2lXej
Content-Type: multipart/mixed; boundary="DMr3SUn23b6V36ITlC9qduZUz2N9ThIpp"

--DMr3SUn23b6V36ITlC9qduZUz2N9ThIpp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/2 =E4=B8=8A=E5=8D=8810:16, Andreas Dilger wrote:
> On Feb 1, 2020, at 7:02 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> Hi ext4 guys,
>>
>> Recently I found an image from android (vendor.img) has this RO featur=
e
>> set, but kernel doesn't support it, thus no easy way to modify it.
>> (Although I can just modify the underlying block for my purpose, it's
>> just one line change, I still want a more elegant way).
>>
>> Thus it can only be mounted RO. So far so good, as from its name, it's=

>> kinda of deduped (BTW, both XFS and Btrfs supports RW mount for
>> reflinked/deduped fs).
>>
>> But the problem is, how to create such image?
>>
>> Man page of mke2fs has no mention of such thing at all, and obviously
>> for whoever comes up with such "brilliant" way to block users from
>> modifying things, the "-E unshare_blocks" will just make the image too=

>> large for the device.
>>
>> Or we must go the Android rabbit hole to find an exotic tool to modify=

>> even one line of a config file?
>=20
> I believe that this feature was only implemented inside Google.

Well, "Don't be evil" is a joke now, right?

>=20
> However, if you want to make changes to some files in this filesystem
> there should be a number of ways to do it:
> - use "dd" to dump file block(s) from image, edit them, then write back=
=2E
>   use "debugfs -c -R 'stat /path/to/file' vendor.img" for block address=
es

Exactly what I'm going to try.

(Thankfully EXT4 hasn't implemented data checksum)

Thanks for the info,
Qu

> - use debugfs to clear the flag, mount the filesystem normally, then
>   overwrite the file *in place* (using "dd" or similar) so that the
>   blocks for the shared file are not reallocated due to unlink, write
> - make a simple patch for the kernel to "support" this feature, then
>   mount it and modify the file in a similar manner
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20


--DMr3SUn23b6V36ITlC9qduZUz2N9ThIpp--

--ZHrVyvt24POpnHmnyHib4fRD5MEU2lXej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl42Mr0ACgkQwj2R86El
/qjDdAf9HfGa0mvGldHWJ6I5+x1y/PqyJ6e9AbEUZDZAO0nqy0nkwccAEyTfoy3H
hnEnfJjpEgQS7ESRKbdObOQAhZZ0kpF8SgFPssfdNaN+wDwx3I3qlBiqjTnEcZo9
4XLL+n276nhUAvOMYVxu/BFh3viD7s1xjLqyx/hfkRyqUJYQ7AfeHt2BM3wJ3dYV
P5YMIVFGHw+DHAFPkzkDYRaJ4cyYMA0CgEmfdsW0pYiX8LxAY/96vitN6rPlIeyG
DpczH2hg2hZl+LR98A794OPrvknpRYK7JKwLo7qTeHU63Y7v0jfiUG2ULAjWP2Wg
XZNr/gMpKsIRVytod6Tp7XtaoaH6Lw==
=izGa
-----END PGP SIGNATURE-----

--ZHrVyvt24POpnHmnyHib4fRD5MEU2lXej--
