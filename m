Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD079182237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgCKT00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 15:26:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33803 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730914AbgCKT0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:26:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so1899092pfj.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=N8GeVwimrf194q+69nNoqJbKMtnU04MRfyht6Ybi7d8=;
        b=GZj2zCxtZQN7rdwZIHCh7uyVzBz4scfrRmTUFR/VffGGdCMA5bFrHhL2JL5YEyT6mu
         aqxBUwJ0thje1vnf+cT4Tay0UfVbeKhf+lSsKewwSLy9Q0va9cTYxrbI6Ubao8v9vOBE
         AJI9KLn8rFoAN7kOyhqkKYI795+vxgGRLFa6aaR4vlWc6RZlfY3C6ipaA9g/e1d7xahd
         gjW4sa1bK+aCX9/c3GsABv9kgNpQTmSGO3TKaVswW11iaElcHnHE0wzTabUUblTlzo2v
         +AoUipGw4JhQO+irtU9G7gPPbenApQLW1gWXcivgE3hqR2chl+i047KTZ4IG9h2gulwf
         /UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=N8GeVwimrf194q+69nNoqJbKMtnU04MRfyht6Ybi7d8=;
        b=GgAUWThHNV/lT99SDyD2bw8AQnoFkYf6gMowIDXMDm//7CNffR/fFq8P00iVvEnrsv
         3jN7r+JHhs8r6r36VXUbd6PRAb+0YqCV74MLZc7q8bkdlG9YURDxuTW7UJGf3lbyB9sL
         SuT3XIQwXKXV/6Z+VGJZ6rWQ6hxil1mDIBvwqrRN+ER1WZfNeKDO2ObF726LQaCjaI07
         XPrMAja4zRiSAlh8AXLE53ksUt2LRIyK5FvPk/fOqPtx1dNZl2QEUpSbVwn/NJ45y9RG
         iIjO1QDKq5at8DBwhAEAL7TJUNss1DQix8GabV/vze1x+7+2ux6R7Rn/owhbyp7QAkCq
         04Gg==
X-Gm-Message-State: ANhLgQ2UZZ5J0UjlQEI7HxUuUUViTUmOfpnIFZJrGcTeEahbqj4MZQ1P
        DkdpQ4XQe6KRuT2N/6eUOSUR2w==
X-Google-Smtp-Source: ADFU+vu8rW01yUwE3dJ6eiLXrml4XQ97aTB4ttHKpl1VVIpAKWDBPNdmLEzNqgBxmiXxUuG4g+xnfA==
X-Received: by 2002:a63:5547:: with SMTP id f7mr4302933pgm.166.1583954784511;
        Wed, 11 Mar 2020 12:26:24 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id w124sm1859792pfd.71.2020.03.11.12.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 12:26:23 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C4175F35-E9D4-4B79-B1A0-047A51DE3287@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_905F47DD-E2D0-46C5-9E10-53ED895035D2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
Date:   Wed, 11 Mar 2020 13:26:19 -0600
In-Reply-To: <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Snitzer <snitzer@redhat.com>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, riteshh@linux.ibm.com,
        krisman@collabora.com, surajjs@amazon.com,
        Dmitry Monakhov <dmonakhov@gmail.com>,
        mbobrowski@mbobrowski.org, Eric Whitney <enwlinux@gmail.com>,
        sblbir@amazon.com, Khazhismel Kumykov <khazhy@google.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <20200302165637.GA6826@mit.edu>
 <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_905F47DD-E2D0-46C5-9E10-53ED895035D2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 3, 2020, at 2:57 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>=20
> On 02.03.2020 19:56, Theodore Y. Ts'o wrote:
>> Kirill,
>>=20
>> In a couple of your comments on this patch series, you mentioned
>> "defragmentation".  Is that because you're trying to use this as part
>> of e4defrag, or at least, using EXT4_IOC_MOVE_EXT?
>>=20
>> If that's the case, you should note that input parameter for that
>> ioctl is:
>>=20
>> struct move_extent {
>> 	__u32 reserved;		/* should be zero */
>> 	__u32 donor_fd;		/* donor file descriptor */
>> 	__u64 orig_start;	/* logical start offset in block for =
orig */
>> 	__u64 donor_start;	/* logical start offset in block for =
donor */
>> 	__u64 len;		/* block length to be moved */
>> 	__u64 moved_len;	/* moved block length */
>> };
>>=20
>> Note that the donor_start is separate from the start of the file that
>> is being defragged.  So you could have the userspace application
>> fallocate a large chunk of space for that donor file, and then use
>> that donor file to defrag multiple files if you want to close pack
>> them.
>=20
> The practice shows it's not so. Your suggestion was the first thing we =
tried,
> but it works bad and just doubles/triples IO.
>=20
> Let we have two files of 512Kb, and they are placed in separate 1Mb =
clusters:
>=20
> [[512Kb file][512Kb free]][[512Kb file][512Kb free]]
>=20
> We want to pack both of files in the same 1Mb cluster. Packed together =
on block
> device, they will be in the same server of underlining distributed =
storage file
> system. This gives a big performance improvement, and this is the =
price I aimed.
>=20
> In case of I fallocate a large hunk for both of them, I have to move =
them
> both to this new hunk. So, instead of moving 512Kb of data, we will =
have to move
> 1Mb of data, i.e. double size, which is counterproductive.
>=20
> Imaging another situation, when we have
> [[1020Kb file]][4Kb free]][[4Kb file][1020Kb free]]
>=20
> Here we may just move [4Kb file] into [4Kb free]. But your suggestion =
again
> forces us to move 1Mb instead of 4Kb, which makes IO 256 times worse! =
This is
> terrible! And this is the thing I try prevent with finding a new =
interface.

One idea I had, which may work for your use case, is to run fallocate() =
on
the *1MB-4KB file* to allocate the last 4KB in that hunk, then use that =
block
as the donor file for the 1MB+4KB file.  The ext4 allocation algorithms =
should
always give you that 4KB chunk if it is free, and that avoids the need =
to try
and force the allocator to select that block through some other method.

Cheers, Andreas






--Apple-Mail=_905F47DD-E2D0-46C5-9E10-53ED895035D2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5pO1sACgkQcqXauRfM
H+CUYQ/+N4uJb0zbYQEoZSC1KjJdap67W8NEO4Ja/2L++extPWuCUl9YQy7MEfoQ
oF2C/7ryZReGDzXO3RPtZkQ5IuiQSLkcmVYhJJsDmyLGOxtNEDobV/UchLjGeYSH
XcoQAZXi+bzvB27PYLkfFQ/rOJD24XP/vj9+brrN75fqapD1zdsqc7FdJr7JQuuU
gvFfakB94J6+XCXrWH8VDsnliXK3ylwIoHKNbcUcEe/bLyozZ+Pa0Uld8nX/IvF0
UMJwj2H456qeovLVmjm7F6/R62uGTnJU1D6LkgozdhM4hT+bBzf/5ReJgC0+R8pT
UPu4cDUGSlmjZTfKWxbT5ZkrEUsM/gR6/wxIdWCZYHzHWov70Hud7fd0WJX/VGrd
lP3/CxrI7+L1xF9BHFdyrOrFb52YjYDrK0PLbUBoT89VLbrdC7VFQZvLokq0VPMe
Uf/n7aaLllgP2EfxgQNgB7HI5Qpo9XceFEDnFAR9ahj9d+pYns8+tr7qvdnpW/L8
BQ0T96GtcAvtVlrdPL6Q/Bw4xS14h4AwUz8qgSYHb0JCoiML50uIVx62jJkPEGAr
8RuofbHTOZQVxiaIJYsgCn7Eg5WNTVhYVxB/f1HTAz+K215EvA1HkSwaH0CY9LYE
gfa2zfNxQ05c9TvNbe4JWcXcdLG06NxybRviCQ2G3Higtyh1Zf4=
=l6lA
-----END PGP SIGNATURE-----

--Apple-Mail=_905F47DD-E2D0-46C5-9E10-53ED895035D2--
