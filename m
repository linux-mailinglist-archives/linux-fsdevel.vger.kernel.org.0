Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DF5439F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiFHRGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiFHRBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:01:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA3A3DB6F9
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 09:52:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d129so19426942pgc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=fnPN3qV01P3JmXHU8gW5ko0hf6xSVYre2n0YUp+eUSM=;
        b=iMN/bMnLY5zPHxO3z021Ssj9b09dXulhc9izzTBvxBYD/4i+JJizkdR+Cn3b+Thmkl
         JEo/Si6S074JQ57IsXq+Zgx53XhA81/+D7bDP98wny13GU0ThZ2YCiSvjdSRMKo70pbi
         9jfcv76OV2UMkJ4ttFAnYSAS8ujK4mqqBoL6465yPREa2H36m9ekaf0YuAdfjgVdPnAd
         k07og7lBaEIOUOQMLU0vZ89P8wyLRvg2OVz3PbWzqgYnRfLW47VdfoPL4nk8rrk2PV+I
         8Tk85greJtZabPE5TABw/ZOauNycrmuh68RIEDgmrN6MLDywh+l1Erz6Dkxeff1Q63MZ
         gBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=fnPN3qV01P3JmXHU8gW5ko0hf6xSVYre2n0YUp+eUSM=;
        b=MGCjNwhYfSKyBg3aEbmKmZsbmfdR34UW+nzsVKAtn0q3goxvnLUx6Wa9NMMBm5zfzu
         /+TOGriVTcyoqL2MOk8uvvI+YB2RMGSWXucEUB0tHwGwRxMFKVfROo6ok02AGJxnqqFN
         EONKAJdxcAgcJKyaYr4Z1j9Dnt7mG5RU1Ud4HKJzrs/QRPku7P1NDhxTbqqfZP4v/f/D
         2cc4sJv4UuXFoOJWfhmNyxjQBt9G6d3X9walGR3JTvzAV+ZyBDOMGV0j9Pcgpxn236Dq
         hXzkHaX3RIP8O6+nVffdi4k2UV5I8YdNPC77NwcKZO2ExcBNUmOR+n9nFCMRseEggM8T
         HGyw==
X-Gm-Message-State: AOAM532JHOUwXC5Lluy4u1bn+4fr9DLphDgMHQMmv3cwAwwM/mBaLRRv
        cMml+UgvIyg7sJEngFgZH/MWIg==
X-Google-Smtp-Source: ABdhPJyYOxJT4qNu/PrIgO1lgsUudJcnOLVnOnGhyamodZr6ktOlCvuznkFn470anfKLLkzQiqt1dQ==
X-Received: by 2002:a05:6a00:1811:b0:51b:fec8:be7b with SMTP id y17-20020a056a00181100b0051bfec8be7bmr21576391pfa.22.1654707179152;
        Wed, 08 Jun 2022 09:52:59 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b0050dc7628146sm15230078pfl.32.2022.06.08.09.52.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 09:52:58 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <08A11E25-0208-4B4F-8759-75C1841E7017@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5498CD26-7CAB-44EA-B8BC-C75BC8DD9F40";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
Date:   Wed, 8 Jun 2022 10:53:11 -0600
In-Reply-To: <20220607153139.35588-1-cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
To:     =?utf-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
References: <20220607153139.35588-1-cgzones@googlemail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_5498CD26-7CAB-44EA-B8BC-C75BC8DD9F40
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Jun 7, 2022, at 9:31 AM, Christian G=C3=B6ttsche =
<cgzones@googlemail.com> wrote:
>=20
> From: Miklos Szeredi <mszeredi@redhat.com>
>=20
> Support file descriptors obtained via O_PATH for extended attribute
> operations.
>=20
> Extended attributes are for example used by SELinux for the security
> context of file objects. To avoid time-of-check-time-of-use issues =
while
> setting those contexts it is advisable to pin the file in question and
> operate on a file descriptor instead of the path name. This can be
> emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
> which might not be mounted e.g. inside of chroots, see[2].

Will this allow get/set xattrs directly on symlinks?  That is one =
problem
that we have with some of the xattrs that are inherited on symlinks, but
there is no way to change them.  Allowing setxattr directly on a symlink
would be very useful.

Cheers, Andreas

> [1]: =
https://github.com/SELinuxProject/selinux/commit/7e979b56fd2cee28f647376a7=
233d2ac2d12ca50
> [2]: =
https://github.com/SELinuxProject/selinux/commit/de285252a1801397306032e07=
0793889c9466845
>=20
> Original patch by Miklos Szeredi <mszeredi@redhat.com>
> =
https://patchwork.kernel.org/project/linux-fsdevel/patch/20200505095915.11=
275-6-mszeredi@redhat.com/
>=20
>> While this carries a minute risk of someone relying on the property =
of
>> xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
>> introducing another set of syscalls.
>>=20
>> Only file->f_path and file->f_inode are accessed in these functions.
>>=20
>> Current versions return EBADF, hence easy to detect the presense of
>> this feature and fall back in case it's missing.
>=20
> CC: linux-api@vger.kernel.org
> CC: linux-man@vger.kernel.org
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> fs/xattr.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e8dd03e4561e..16360ac4eb1b 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -656,7 +656,7 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, =
pathname,
> SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
> 		const void __user *,value, size_t, size, int, flags)
> {
> -	struct fd f =3D fdget(fd);
> +	struct fd f =3D fdget_raw(fd);
> 	int error =3D -EBADF;
>=20
> 	if (!f.file)
> @@ -768,7 +768,7 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, =
pathname,
> SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
> 		void __user *, value, size_t, size)
> {
> -	struct fd f =3D fdget(fd);
> +	struct fd f =3D fdget_raw(fd);
> 	ssize_t error =3D -EBADF;
>=20
> 	if (!f.file)
> @@ -844,7 +844,7 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, =
pathname, char __user *, list,
>=20
> SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, =
size)
> {
> -	struct fd f =3D fdget(fd);
> +	struct fd f =3D fdget_raw(fd);
> 	ssize_t error =3D -EBADF;
>=20
> 	if (!f.file)
> @@ -910,7 +910,7 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, =
pathname,
>=20
> SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
> {
> -	struct fd f =3D fdget(fd);
> +	struct fd f =3D fdget_raw(fd);
> 	int error =3D -EBADF;
>=20
> 	if (!f.file)
> --
> 2.36.1
>=20


Cheers, Andreas






--Apple-Mail=_5498CD26-7CAB-44EA-B8BC-C75BC8DD9F40
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmKg0/cACgkQcqXauRfM
H+Cr1A/9GWZGOg+kt6I+09zL5KisPWOXiA1uxzaae5CcnznwYr60ZJQz2Hn7NEnR
PfvHoyl1GS01x19rtV7TFszbjtwmiPvhh+zfjhLYzEUFnou3QTJhgVFcIzKqDnMJ
t366qvA7dIcnGxqVPCWNepIELFOv2na8+AO6S/q6MeeTTS2P3KmqhWOsvioe1N+H
93NN+vCPCIjs0pDM22V4GJ9BP4adrJZRUG0UGIForSpgjyNpGn2KVXtmM9gntYS5
gCv6vm6VQpcTIkJrwXI8nebI2MrsG752HZT3H5E5byGzoY6XUPnFuIdRurifeR/m
mjA+ZrqTycEbGbULpZ6/W+mYCpi/64d/voYqF9akMgqoaj5CGT/IpKpdgZKDsfR6
qsbZeuvkBnzGqlgZcKlN8ArFnx56SonH+H/LgDGKoQEi+LlGkXTBw+YT262tQAZU
8OVwDUIGCi98pq+ZCr2mlCUu/p3aOeKZbjJXxbPlSkjZy7RFdqPFdmO5wmlcCsUu
chzNHpo3cUpGwbesF++ArwboJV3/ffKwo7+9UxzIb+qJGPKcfSaB3Xbrjj3igOKy
tjG2jLlpfvN8lxHMY036peNmFXH6Ok95a8Zd8vZDaZxhrbT6J0gb3wyZ/NgDkeTJ
0DlIrUibeXEH4VHzGlkuYiwmN1HlOhynJ2SB9afRYw6WgoAvcX8=
=76kK
-----END PGP SIGNATURE-----

--Apple-Mail=_5498CD26-7CAB-44EA-B8BC-C75BC8DD9F40--
