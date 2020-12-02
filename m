Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79E2CC998
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLBW0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgLBW0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:26:17 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41AC0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:25:31 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id p21so1101551pjv.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5utOZVf3veGfMRoQbf2Yx/BFy8qrmXGBXUjzJ8dKZ44=;
        b=0GCKxWP2V5HaarOWgPvAdnTXx2FRqhPN6H35kJgFG3cmfCi3Mddc/k9uZy+S4h4RDb
         GWBTdRXy44u1W/nWYPm+u+lkq4wJf2L4nVB5o2OjsEbewfP8nzxKvEhWSMVrSC0kOvgb
         0HxT5OC7CC6zKJfKgWvYI06cW2z5Phvfgnj5CcLaKtsgSIa1sQGX6oJp4DGArUZMhAdu
         vLg3EdS/BuQWOoz3IKjtHpV7T2vxkNo9dDNFEmcIc0gvSZDIqsDmYo+F6yJL1uo54bch
         xJ5Q+grshGBi7lOzhF4S2LMjssIrN+Y9pZ7B1MvPnIRMtvy489e4qHIuK8pAywGAbEvV
         YIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5utOZVf3veGfMRoQbf2Yx/BFy8qrmXGBXUjzJ8dKZ44=;
        b=Uzcv4ZucraFIspRZTg8Bqc08QNqQ1aq22Zr7iFjEws6Gzv6YVMjJlCblfYnIX7rVFh
         V37gsZ7LcVGFGKNGxXyziWY8GewhU7U7pKyXpSzoeFGFXypOQl6448GfmW8WuzyHPzl3
         GBOwXvBgQCxuN8gNN9RjCMBCQOi8xlQlAblAgpsymUthdyZW0CoLiq88/GaOCnyhDKDO
         Z50y00Xo8yrLENfFeU1sZnhJPpboIil681sqYIv4tMIrkyzu0eYijKNgJq2XJ+GfUy4F
         leo2bEbfuyrhJA7xOLotawGG4ywVxwSU5vw3j4Xi4ninJslAB82vOxXOdgXPN8PbXznz
         DEjA==
X-Gm-Message-State: AOAM531ff1D4UMMBF5eZ+qxnBVjLjqa7kaemUWVaZj/KQy4oFKGMKHKy
        lu84Q65qNt2gBIdR9JVXHXpvKA==
X-Google-Smtp-Source: ABdhPJw2pnDywanmCG7P6trWRpLjwJHWFEhzfNkYWRCskdYELm+ojAXsHpq14/R1YtqT0yrv9Dcmgw==
X-Received: by 2002:a17:902:8691:b029:d7:e0f9:b1b with SMTP id g17-20020a1709028691b02900d7e0f90b1bmr271552plo.37.1606947929537;
        Wed, 02 Dec 2020 14:25:29 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h4sm70851pgp.8.2020.12.02.14.25.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:25:28 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <047AD2C4-4E34-4325-B2B6-02E240ED50DD@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_68D5BA99-AE77-4AE7-932A-159B4173426B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/9] Allow deleting files with unsupported encryption
 policy
Date:   Wed, 2 Dec 2020 15:25:25 -0700
In-Reply-To: <X8gCKTx96rXUMh0i@gmail.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <X8gCKTx96rXUMh0i@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_68D5BA99-AE77-4AE7-932A-159B4173426B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 2, 2020, at 2:07 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> On Tue, Nov 24, 2020 at 04:23:27PM -0800, Eric Biggers wrote:
>> Currently it's impossible to delete files that use an unsupported
>> encryption policy, as the kernel will just return an error when
>> performing any operation on the top-level encrypted directory, even =
just
>> a path lookup into the directory or opening the directory for =
readdir.
>>=20
>> It's desirable to return errors for most operations on files that use =
an
>> unsupported encryption policy, but the current behavior is too =
strict.
>> We need to allow enough to delete files, so that people can't be =
stuck
>> with undeletable files when downgrading kernel versions.  That =
includes
>> allowing directories to be listed and allowing dentries to be looked =
up.
>>=20
>> This series fixes this (on ext4, f2fs, and ubifs) by treating an
>> unsupported encryption policy in the same way as "key unavailable" in
>> the cases that are required for a recursive delete to work.
>>=20
>> The actual fix is in patch 9, so see that for more details.
>>=20
>> Patches 1-8 are cleanups that prepare for the actual fix by removing
>> direct use of fscrypt_get_encryption_info() by filesystems.
>>=20
>> This patchset applies to branch "master" (commit 4a4b8721f1a5) of
>> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git.
>>=20
>> Eric Biggers (9):
>>  ext4: remove ext4_dir_open()
>>  f2fs: remove f2fs_dir_open()
>>  ubifs: remove ubifs_dir_open()
>>  ext4: don't call fscrypt_get_encryption_info() from dx_show_leaf()
>>  fscrypt: introduce fscrypt_prepare_readdir()
>>  fscrypt: move body of fscrypt_prepare_setattr() out-of-line
>>  fscrypt: move fscrypt_require_key() to fscrypt_private.h
>>  fscrypt: unexport fscrypt_get_encryption_info()
>>  fscrypt: allow deleting files with unsupported encryption policy
>>=20
>> fs/crypto/fname.c           |  8 +++-
>> fs/crypto/fscrypt_private.h | 28 ++++++++++++++
>> fs/crypto/hooks.c           | 16 +++++++-
>> fs/crypto/keysetup.c        | 20 ++++++++--
>> fs/crypto/policy.c          | 22 +++++++----
>> fs/ext4/dir.c               | 16 ++------
>> fs/ext4/namei.c             | 10 +----
>> fs/f2fs/dir.c               | 10 +----
>> fs/ubifs/dir.c              | 11 +-----
>> include/linux/fscrypt.h     | 75 =
+++++++++++++++++++------------------
>> 10 files changed, 126 insertions(+), 90 deletions(-)
>>=20
>>=20
>> base-commit: 4a4b8721f1a5e4b01e45b3153c68d5a1014b25de
>=20
> Any more comments on this patch series?

I think the general idea makes sense.  I'll review the ext4 patches in =
the series.


Cheers, Andreas






--Apple-Mail=_68D5BA99-AE77-4AE7-932A-159B4173426B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IFFUACgkQcqXauRfM
H+CrkBAAmi+u5EOfLwZ4a5VQwxEzgad3GDbuBgmWS1SBHEetbx+9IRVZ6usAo4Ce
8AN1KeZFZcVbPD2Qjo3mAULr8MzuJEOP6qKsMUKT/0zN1LAmd4J8oMnfk0aJBKl0
SXKoKNuHi7CXHIiimj1zqZa8ToaEm30zlmSwRYRy/AbBnT2PIluKaDehsiSJoq1a
r5KXAI3WlsnOVzmp32PVeHnvAVLsb9hCSwZYZDNmawT0GR+0dupyMinz5fx0XP/N
QPY32OjFavTd2ON1Q0+f07nbKnbXn1gIWOVI8/z80EoXYuyIgJvAqUjou3O7LFBS
6FpDmoMNx+cJBBfGlJkC/PeuqapF9SICwuP+d0Sc0bkn+R2rxsFSSjJUbVrxf/k7
qW0Urs/amJS6fjuZIZntzfaHAD+x782+dqAyBH4d5Z4pGiFaSBo8cdHbLcX627Uf
8THXBZzkpCOUGypQUPT2+zjA6VMxLJV5HwddG86p0GwLEi3o/YCm3R8xrbLelq4G
SMJLpcicYnD7UbcukGJHVZvchSClprDbIlBjgP9ArcLzQ4FYJ7OS6TU5EL8NkoE3
7FVtrDvS9ypXmqWx6n+X7sVfGCV0NRjBacINaYmwlv9ZCs5DUXS8w4HSXse/kc4m
JINcTZoFZHSG2H0vfRnxnC6oUXE54gAalfjOOZobMLEOHR8Fw3I=
=ZB7J
-----END PGP SIGNATURE-----

--Apple-Mail=_68D5BA99-AE77-4AE7-932A-159B4173426B--
