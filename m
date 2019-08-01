Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94207D819
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfHAI6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 04:58:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36467 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHAI6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:58:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so72764327wrs.3;
        Thu, 01 Aug 2019 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/HEhyFZO0PQcA15hc+xv1gSr3R650WNl/Bsog3ig1Vs=;
        b=sl5IXHiHCL5z+uilPCGfWVyupm8W5EY68r0TP12ZTaGzoKU5+ultngbNZ5OSxjdENi
         //faMtKZAL52HnWpHh3fy0Yoh2ELqMvQpIF2nCI/MvWkFCovAxRrARYKeCy7KR/9sivS
         K/XZzXeA3hOdS49iMCHq6MuDCwkbcwb4GPreSz0S0fxDBOhf893Vs7ww/5QoTtsAchxI
         ViykhyMJSTtX/+6QGW1KcY0TyCo+SB48lwP44xGKRnpnYIrl1gPPnddWGCQ84vxDtDhV
         Uh2HOjRnxiuh6DkdYuHk9Aasne9Tp3ZYdipdFsA8YW6fLpSTooGgAS+Yqt1shKiS5dai
         eNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/HEhyFZO0PQcA15hc+xv1gSr3R650WNl/Bsog3ig1Vs=;
        b=BAFOB7nwOHUGVF1X935hbfzgr14RkoDr7a99EcsAsQD+3F2QE507FhRlrOvNz/81fC
         Euv+ITrJ77M8yUc2znnKA+4jR0Nva4POuHoHzA5JwoW1j6Xb4O35Xwar2bIhozi4w4rk
         RpkFFT4oGZXL7yJ2ZOaLD72nQChNR1eipjz1kz5gGnCfzRYxt5XQvxmskE6owvNcyx6K
         YrcGHs7HCHAwHwtQSRRnV3ideHk4RBwU4lV9x99olJZGEwgyOnuMea/wMSdeTjBvaX1v
         +8AiTRnDshDKkzi/xZFIRjpZjxvCpAt8LdjH+E/QDhVZE30Wbv4YAxO+uCVMbK1nG451
         7vXw==
X-Gm-Message-State: APjAAAVPJtzvqF6beL3FTv+RxkINbOvKjtCJA/Gin1DooXhp6NPlvMpM
        GA/sgrfZNhUh5KthFy452wa0PM70
X-Google-Smtp-Source: APXvYqyY+3vcNwphJXMCGTksVgAY06ND6JvRvKgU7VlRBs1UnVnNBiDqL4YHpDS6Nj3/XwlTKW5hkQ==
X-Received: by 2002:adf:f6d2:: with SMTP id y18mr63065880wrp.102.1564649877368;
        Thu, 01 Aug 2019 01:57:57 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id d16sm64969933wrv.55.2019.08.01.01.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 01:57:56 -0700 (PDT)
Date:   Thu, 1 Aug 2019 10:57:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Roald Strauss <mr_lou@dewfall.dk>,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: UDF filesystem image with Write-Once UDF Access Type
Message-ID: <20190801085755.amohgsxdcmzf2nzc@pali>
References: <20190712100224.s2chparxszlbnill@pali>
 <20190801073530.GA25064@quack2.suse.cz>
 <20190801083800.GC25064@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mwzeuwgqdutbd6v3"
Content-Disposition: inline
In-Reply-To: <20190801083800.GC25064@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mwzeuwgqdutbd6v3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 01 August 2019 10:38:00 Jan Kara wrote:
> On Thu 01-08-19 09:35:30, Jan Kara wrote:
> > > If you want to play with Write-Once Access Type, use recent version of
> > > mkudffs and choose --media-type=3Dcdr option, which generates UDF
> > > filesystem suitable for CD-R (Write-Once Access Type with VAT and oth=
er
> > > UDF options according to UDF specification).
> >=20
> > Reasonably recent kernels should have this bug fixed and mount such fs =
read
> > only. That being said I've tested current upstream kernel with a media
> > created with --media-type=3Dcdr and mounting failed with:
> >=20
> > UDF-fs: error (device ubdb): udf_read_inode: (ino 524287) failed !bh
> > UDF-fs: error (device ubdb): udf_read_inode: (ino 524286) failed !bh
> > UDF-fs: error (device ubdb): udf_read_inode: (ino 524285) failed !bh
> > UDF-fs: error (device ubdb): udf_read_inode: (ino 524284) failed !bh
> > UDF-fs: Scanning with blocksize 2048 failed
> >=20
> > So there's something fishy either in the created image or the kernel...
> > Didn't debug this further yet.

Hi!

Now I verified version from git master branch and it seems to work.

$ ./mkudffs/mkudffs --media-type=3Dcdr --new-file /tmp/cdr 307200
filename=3D/tmp/cdr
label=3DLinuxUDF
uuid=3D1564648861319606
blocksize=3D2048
blocks=3D307200
udfrev=3D2.01
vatblock=3D319
start=3D0, blocks=3D16, type=3DRESERVED=20
start=3D16, blocks=3D4, type=3DVRS=20
start=3D20, blocks=3D76, type=3DUSPACE=20
start=3D96, blocks=3D16, type=3DMVDS=20
start=3D112, blocks=3D16, type=3DUSPACE=20
start=3D128, blocks=3D1, type=3DLVID=20
start=3D129, blocks=3D95, type=3DUSPACE=20
start=3D224, blocks=3D16, type=3DRVDS=20
start=3D240, blocks=3D16, type=3DUSPACE=20
start=3D256, blocks=3D1, type=3DANCHOR=20
start=3D257, blocks=3D31, type=3DUSPACE=20
start=3D288, blocks=3D306912, type=3DPSPACE

$ ls -l -a /tmp/cdr
-rw-r----- 1 pali pali 655360 aug  1 10:41 /tmp/cdr

$ mkdir /mnt/cdr

$ sudo mount /tmp/cdr /mnt/cdr -o loop
mount: /dev/loop0 is write-protected, mounting read-only

$ dmesg | tail
[320934.128836] loop: module loaded
[320934.169960] UDF-fs: warning (device loop0): udf_load_vrs: No anchor fou=
nd
[320934.169965] UDF-fs: Rescanning with blocksize 2048
[320934.177772] UDF-fs: warning (device loop0): udf_load_vrs: No anchor fou=
nd
[320934.177777] UDF-fs: Rescanning with blocksize 2048
[320934.181206] UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2019/08/=
01 10:41 (1078)

$ uname -rvm
4.9.0-9-amd64 #1 SMP Debian 4.9.168-1+deb9u4 (2019-07-19) x86_64


And CDR code was not modified since release 2.1. At time of releasing
version 2.1 I tested that cdr image created by mkudffs and burned to
CD-R disc can be correctly recognized and mounted by linux kernel.

> Hum, looks like a problem with mkudffs. Relevant debug messages look like:
>=20
> UDF-fs: fs/udf/super.c:671:udf_check_vsd: Starting at sector 16 (2048 byt=
e sectors)
> UDF-fs: fs/udf/super.c:824:udf_load_pvoldesc: recording time 2019/08/01 0=
9:47 (1078)
> UDF-fs: fs/udf/super.c:836:udf_load_pvoldesc: volIdent[] =3D 'LinuxUDF'
> UDF-fs: fs/udf/super.c:844:udf_load_pvoldesc: volSetIdent[] =3D '15646456=
45200563LinuxUDF'
> UDF-fs: fs/udf/super.c:1462:udf_load_logicalvol: Partition (0:0) type 1 o=
n volume 1
> UDF-fs: fs/udf/super.c:1462:udf_load_logicalvol: Partition (1:0) type 2 o=
n volume 1
> UDF-fs: fs/udf/super.c:1471:udf_load_logicalvol: FileSet found in Logical=
VolDesc at block=3D0, partition=3D1
> UDF-fs: fs/udf/super.c:1218:udf_load_partdesc: Searching map: (0 =3D=3D 0)
> UDF-fs: fs/udf/super.c:1060:udf_fill_partdesc_info: Partition (0 type 151=
1) starts at physical 288, block length 524000
> UDF-fs: fs/udf/super.c:1060:udf_fill_partdesc_info: Partition (1 type 201=
2) starts at physical 288, block length 524000
> UDF-fs: fs/udf/misc.c:223:udf_read_tagged: location mismatch block 524287=
, tag 0 !=3D 523999
> UDF-fs: error (device ubdb): udf_read_inode: (ino 524287) failed !bh
>=20
> So the fact that location tag was 0 in block 524287 (which should contain
> VAT inode) suggests there's something fishy with how / where mkudffs
> creates the VAT inode. Can you have a look?
>=20
> BTW, mkudffs messages look like:
> filename=3D/tmp/image
> label=3DLinuxUDF
> uuid=3D1564645645200563
> blocksize=3D2048
> blocks=3D524288
> udfrev=3D2.01
> vatblock=3D319
> start=3D0, blocks=3D16, type=3DRESERVED=20
> start=3D16, blocks=3D4, type=3DVRS=20
> start=3D20, blocks=3D76, type=3DUSPACE=20
> start=3D96, blocks=3D16, type=3DMVDS=20
> start=3D112, blocks=3D16, type=3DUSPACE=20
> start=3D128, blocks=3D1, type=3DLVID=20
> start=3D129, blocks=3D95, type=3DUSPACE=20
> start=3D224, blocks=3D16, type=3DRVDS=20
> start=3D240, blocks=3D16, type=3DUSPACE=20
> start=3D256, blocks=3D1, type=3DANCHOR=20
> start=3D257, blocks=3D31, type=3DUSPACE=20
> start=3D288, blocks=3D524000, type=3DPSPACE=20
>=20
> which suggests that VAT was indeed allocated somewhere in the beginning of
> the partition.

For write-once media you are not able to modify size of UDF partition.
So if you are creating image for CD-R disc, you need to specify size of
UDF filesystem to match size of CD-R disc. VAT is always burned to the
last block of current track on CD-R.

Therefore if you had pre-allocated big image file for CD-R and then you
run mkudffs for cdr on it, you lost information what is the last used
block on that cdr image. Normally for optical drivers kernel use mmc
commands to retrieve last block of current session and based on it find
VAT. But image files loaded via /dev/loop are not optical drivers and
therefore do not have ability "hardware" ability to ask where is the
last used block. IIRC in this case kernel just fallback to the last
block of block device for VAT, which in this case is not correct.

What should help is to truncate image file to "correct" size after
running mkudffs with --media-type=3Dcdr. Maybe mkudffs itself should do it
when was asked to create UDF filesystem for CD-R on existing image file.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--mwzeuwgqdutbd6v3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXUKpkQAKCRCL8Mk9A+RD
UoBGAJsFXEkWo4MN9Hbbot3YpaSU0RNkvACfRpFrTTCDAY08DdAAYKZiUGQl2gQ=
=9GYB
-----END PGP SIGNATURE-----

--mwzeuwgqdutbd6v3--
