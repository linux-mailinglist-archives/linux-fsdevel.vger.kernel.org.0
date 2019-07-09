Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96A63B7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 20:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfGIS4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 14:56:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41269 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGIS4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:56:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so22137909wrm.8;
        Tue, 09 Jul 2019 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R2a5Ykr8Gh3HS3Iw/maFNxbOLyKlmoZP6KXVN9Qj8GI=;
        b=MjjfT3k6/J4egSnsGLaJht4OzRmt/hG6IglXvRc7MxF6l2bGuHM0tzWAq+nCxqG9Z5
         dmu5C7BuA8iN7NibzvYPB/4TsLiuPKlmOACSB4LRkg1Xe1O75S46BkkJEZNNo/OW0vJQ
         wRixxlyjCmoID6Ib2+db65eCseZfuInANMOxlvqH/Q3qQ+mvA4O91xiCD1H7t3q473jx
         G1g1ylXLxPWU6JiahG9xf5NKU4wo1KXN35Kwo97wat6FEL2TND/VipVW+yFHJI/HUxJz
         U+PH18zM3+35UKAM12ycyrapRVn9r8a5hpQ7Se66jZKA+V2NYiM8r+FAnXOA4+Qfpgae
         +kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R2a5Ykr8Gh3HS3Iw/maFNxbOLyKlmoZP6KXVN9Qj8GI=;
        b=Rngnx7jgaDaJJIzJIiYoBTtTpuy/KU88PeKznNA+YYrSbMP4SxFcxuqS4cC/t6CmMH
         pjRAbEyAzAHRWMQFvyT9Zo3ztxboRfIREDm6jyOGO8/FfP8y+lPfnC9xNzjnAedDolKz
         BHvKZrvj4IuzenJ47ka7bubT00WGvmS3A9aJFb0otn3YnNMQmRizjPEAcnaXMQ1CGOuX
         pEyIJWvwxm+/eIRuHE+NaEqvnDXCF/RPwqghSDm+dueb+lbJnQ8lacGZbIJTbDMwWmme
         CSxBa1mpQ/sCDZaNLkGnVQkY+53RCVXCW5VWeHRqVo3Wv5On8bYFwaO8CbBkkWnUZPjn
         fvPw==
X-Gm-Message-State: APjAAAU/g+PHimF4Kz/+/hoRi2GLLE1p4ho5GK59cpVk4V0FcM6DsdTW
        +jTPyRgKW1v+SdJZKtBRQULV93DA
X-Google-Smtp-Source: APXvYqxVt2pqqgMEecALIDhzP/6aJO7dhV/kJH6FnDqImA/oUTahBFF+chHpxnhOuwN14JrD9rVlTQ==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr7832039wrv.30.1562698600673;
        Tue, 09 Jul 2019 11:56:40 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 72sm22824991wrk.22.2019.07.09.11.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 11:56:39 -0700 (PDT)
Date:   Tue, 9 Jul 2019 20:56:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <vojtech.vladyka@foxyco.cz>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] udf: 2.01 interoperability issues with Windows 10
Message-ID: <20190709185638.pcgdbdqoqgur6id3@pali>
References: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eccj5ajh3vtt7ix3"
Content-Disposition: inline
In-Reply-To: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eccj5ajh3vtt7ix3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi! I'm adding Vojt=C4=9Bch Vladyka to conversation.

Steve, can you describe what you mean by Advanced Format 4K sector size?

It is hard disk with 512 bytes logical sector size and 4096 bytes
physical sector size? Or do you mean hard disk which has both logical
and physical sector size equal to 4096 bytes?

On Tuesday 09 July 2019 13:27:58 Steve Magnani wrote:
> Hi,
>=20
> Recently I have been exploring Advanced Format (4K sector size)
> and high capacity aspects of UDF 2.01 support in Linux and
> Windows 10. I thought it might be helpful to summarize my findings.
>=20
> The good news is that I did not see any bugs in the Linux
> ecosystem (kernel driver + mkudffs).
>=20
> The not-so-good news is that Windows has some issues that affect
> interoperability. One of my goals in posting this is to open a
> discussion on whether changes should be made in the Linux UDF
> ecosystem to accommodate these quirks.
>=20
> My test setup includes the following software components:
>=20
> * mkudffs 1.3 and 2.0

Can you do tests also with last version of mkudffs 2.1?

> * kernel 4.15.0-43 and 4.15.0-52
> * Windows 10 1803 17134.829
> * chkdsk 10.0.17134.1
> * udfs.sys 10.0.17134.648
>=20
>=20
> ISSUE 1: Inability of the Linux UDF driver to mount 4K-sector
>          media formatted by Windows.

Can you check if udfinfo (from udftools) can recognize such disk?

And can blkid (from util-linux) recognize such disk as UDF with reading
all properties?

Can grub2 recognize such disks?

Also can you check if libparted from git master branch can recognize
such disk? In following commit I added support for recognizing UDF
filesystem in libparted, it is only in git master branch, not released:

http://git.savannah.gnu.org/cgit/parted.git/commit/?id=3D8740cfcff3ea839dd6=
dc8650dec0a466e9870625

> This is because the Windows ecosystem mishandles the ECMA-167
> corner case that requires Volume Recognition Sequence components
> to be placed at 4K intervals on 4K-sector media, instead of the
> 2K intervals required with smaller sectors. The Linux UDF driver
> emits the following when presented with Windows-formatted media:
>=20
>   UDF-fs: warning (device sdc1): udf_load_vrs: No VRS found
>   UDF-fs: Scanning with blocksize 4096 failed
>=20
> A hex dump of the VRS written by the Windows 10 'format' utility
> yields this:
>=20
>   0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
>   0800: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
>   1000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........
>=20
> We may want to consider tweaking the kernel UDF driver to
> tolerate this quirk; if so a question is whether that should be
> done automatically, only in response to a mount option or
> module parameter, or only with some subsequent confirmation
> that the medium was formatted by Windows.
>=20
>=20
> ISSUE 2: Inability of Windows chkdsk to analyze 4K-sector media
>          formatted by mkudffs.

This is really bad :-(

> This is another aspect of Windows' VRS corner case bug.
> Formatting by mkudffs places the VRS components at the proper 4K
> intervals. But the chkdsk utility looks for components at 2K
> intervals. Not finding a component at byte offset 2048, chkdsk
> decides that the media is RAW and cannot be checked. Note that
> this bug affects chkdsk only; udfs.sys *does* recognize mkudffs-
> formatted 4K-sector media and is able to mount it.
>=20
> It would be possible to work around this by tweaking mkudffs to
> insert dummy BOOT2 components in between the BEA/NSR/TEA:
>=20
>   0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
>   0800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
>   1000: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
>   1800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
>   2000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........
>=20
> That would introduce a slight ECMA-167 nonconformity, but Linux
> does not object and Windows actually performs better. I would
> have to tweak udffsck though since I believe this could confuse
> its automatic detection of medium block size.

I would like to avoid this hack. If chkdsk is unable to detect such
filesystem, it is really a good idea to let it do try doing filesystem
checks and recovery? You are saying that udfs.sys can recognize such
disk and mount it. I think this should be enough.

Currently mkudffs contains workarounds for older util-linux versions or
MBR partition layout. But everything should be fully complaint with
ECMA-67 and OSTA-UDF.

>=20
> ISSUE 3: Inability of the Windows UDF driver to mount media
>          read-write when a maximally-sized space bitmap
>          descriptor is present
>=20
> I suspect this is an off-by-one error in udfs.sys relating to
> the maximum number of blocks a space bitmap descriptor can
> occupy. The bug causes UDF partitions that are close to 2 TiB
> (512-sector media) or 16 TiB (4K-sector media) to be mounted
> read-only, with no user-visible indication as to why.
>=20
> It would be possible for mkudffs to print a warning when
> formatting results in a space bitmap that occupies the maximum
> number of blocks.
>=20
>=20
> ISSUE 4: chkdsk reports spurious errors when space bitmap
>          descriptor exceeds 32 MiB
>=20
> Some permutations of this:
>=20
>   * "Correcting errors in Space Bitmap Descriptor at block 0"
>     (with no prior mention of any errors)
>   * "Space Bitmap Descriptor at block 32 is corrupt or unreadable"
>=20
> This is actually one of the more crippling issues if one values
> Windows' ability to check and repair UDF errors. A limit of
> 32 MiB on the space bitmap implies a UDF partition size of at
> most 137 GB (not GiB) with 512-sector media or at most 1099 GB
> with 4K-sector media.
>=20
> Again, the most I think we could do is code mkudffs to warn of
> this possibility. But a message that clearly conveys the issue
> and what should be done to avoid it could be a little tricky to
> construct.

I have no problems with solution that udftools prints warning message
that current selected configuration does not work on Windows systems.
There are already some such warning messages in mkudffs.

>=20
> Obviously the best solution would be for the Windows bugs to
> get fixed. If anyone reading this can convey these details into
> the Microsoft silo, that would be great.

For Windows 10 users, the only option is to report bug via
Use Feedback app on the Start Menu.

> Regards,
> ------------------------------------------------------------------------
>  Steven J. Magnani               "I claim this network for MARS!
>  www.digidescorp.com              Earthling, return my space modulator!"
>=20
>  #include <standard.disclaimer>
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--eccj5ajh3vtt7ix3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXSTjZAAKCRCL8Mk9A+RD
UljMAJ9XBtkRV9CJ2h3Abr/M7Lalenk/TQCfXvPkPPTsB8aiIgZ3BTpG+UCFedo=
=8B+j
-----END PGP SIGNATURE-----

--eccj5ajh3vtt7ix3--
