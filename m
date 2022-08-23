Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701E59CF57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 05:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiHWDWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 23:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiHWDWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:22:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BC954658
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 20:22:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso13313443pjo.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 20:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc;
        bh=t5TO7xdQGMXaC5TRTQFcqhFSnLRjgf1D8C0Y6A6YDxE=;
        b=WmzvvmXH5e7wP/UE3SOCEoTxUnalykJ3N3TkckdsZzxqPN6OxAvOMEhsFJIg72/pec
         dV+HIGE92uLWsaavfgjKM+C+A5n4EiV88XdKFsoxydVAFe5nmQZ3wXK7pbUiZnpPSViH
         9wcRuFbEeMk6CuUC5TU2Fsvnjo++S7A79RBLzB6Aur+2C1mdRPNWR6V9hkWGd33kuaZ6
         xcCba0irYI0fzWODf7B+oUYh3cw5uD53qZpQUEbxAvY5/4dbEDBWYTz1DS09LYro3uwm
         G9+kpUhWzIhcfbKMcEQU1XlfvHYa+Duf15Pq6vyDet2odUshI95kkV9niiVxvoEj4EEl
         OWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=t5TO7xdQGMXaC5TRTQFcqhFSnLRjgf1D8C0Y6A6YDxE=;
        b=eKPROd7iPKtBuxBkgSZBJXCb6HzrO/VCoUSPK3tnz3CKp5lQJ1lyqDwYPTEBwaHK6t
         wo1ix47FyrcuRXyP5CYWdGFdnpeJ7yMedfHqU+XRnYtY7MFWm/HTIFBWNzV8p0DlxXhW
         S3ZKPZoiBBXuNhnl1cR4wTTiNVAS91IiWe6ExJFk+iwaE9OLoHeJWva7jgjT0nHcBXNf
         fbKg0OtjHBGUjv/wcBPIU5xZfZzraqq6S0wsU+6UK5Z7EGg3Z1Rq1C9/uvws44gLfl0f
         5EP8a5MJ6+9aDrBnkRfNGes1BQvPjtZ4anWQr+bVb+4rQyBqSxP5raNva9pA+Ogt2k24
         kvpA==
X-Gm-Message-State: ACgBeo3wcLX6UekrVjI2/px0EvtuRVQUExq43GXyWtUN7yqwJpfL7/4M
        wppOKF30lktJKLLhMXgCfpdTEQ==
X-Google-Smtp-Source: AA6agR6bYAoLnjuq/NI/816MPUccS4/TdIQzRNkgRVQfsY/JSoRbcW6B7pyoAJACabZ0K9rJNxD0pA==
X-Received: by 2002:a17:903:18b:b0:16e:f09c:919b with SMTP id z11-20020a170903018b00b0016ef09c919bmr23613380plg.135.1661224935485;
        Mon, 22 Aug 2022 20:22:15 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709027e0900b00172d52b7c03sm5372011plm.125.2022.08.22.20.22.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2022 20:22:14 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <21923F1E-1C54-44FB-AF7C-4CD8B4B35433@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8E3621BA-8A02-4654-8DC0-856F43CB7C0C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Date:   Mon, 22 Aug 2022 21:22:11 -0600
In-Reply-To: <YwAYPFxW7VV4M9D1@sol.localdomain>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        xfs <linux-xfs@vger.kernel.org>, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org> <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain> <YuXyKh8Zvr56rR4R@google.com>
 <YvrrEcw4E+rpDLwM@sol.localdomain>
 <20220816090312.GU3600936@dread.disaster.area>
 <D1CDACE3-EC7E-43E4-8F49-EEA2B6E71A41@dilger.ca>
 <YwAYPFxW7VV4M9D1@sol.localdomain>
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


--Apple-Mail=_8E3621BA-8A02-4654-8DC0-856F43CB7C0C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 19, 2022, at 5:09 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> On Tue, Aug 16, 2022 at 10:42:29AM -0600, Andreas Dilger wrote:
>>=20
>> IMHO, this whole discussion is putting the cart before the horse.
>> Changing existing (and useful) IO behavior to accommodate an API that
>> nobody has ever used, and is unlikely to even be widely used, doesn't
>> make sense to me.  Most applications won't check or care about the =
new
>> DIO size fields, since they've lived this long without statx() =
returning
>> this info, and will just pick a "large enough" size (4KB, 1MB, =
whatever)
>> that gives them the performance they need.  They *WILL* care if the =
app
>> is suddenly unable to read data from a file in ways that have worked =
for
>> a long time.
>>=20
>> Even if apps are modified to check these new DIO size fields, and =
then
>> try to DIO write to a file in f2fs that doesn't allow it, then f2fs =
will
>> return an error, which is what it would have done without the statx()
>> changes, so no harm done AFAICS.
>>=20
>> Even with a more-complex DIO status return that handles a "direction"
>> field (which IMHO is needlessly complex), there is always the =
potential
>> for a TOCTOU race where a file changes between checking and access, =
so
>> the userspace code would need to handle this.
>=20
> I'm having trouble making sense of your argument here; you seem to be =
saying
> that STATX_DIOALIGN isn't useful, so it doesn't matter if we design it
> correctly?  That line of reasoning is concerning, as it's certainly =
intended
> to be useful, and if it's not useful there's no point in adding it.
>=20
> Are there any specific concerns that you have, besides TOCTOU races =
and the
> lack of support for read-only DIO?

My main concern is disabling useful functionality that exists today to =
appease
the new DIO size API.  Whether STATX_DIOALIGN will become widely used by
applications or not is hard to say at this point.

If there were separate STATX_DIOREAD and STATX_DIOWRITE flags in the =
returned
data, and the alignment is provided as it is today, that would be enough =
IMHO
to address the original use case without significant complexity.

> I don't think that TOCTOU races are a real concern here.  Generally =
DIO
> constraints would only change if the application doing DIO =
intentionally does
> something to the file, or if there are changes that involve the =
filesystem
> being taken offline, e.g. the filesystem being mounted with =
significantly
> different options or being moved to a different block device.  And, =
well,
> everything else in stat()/statx() is subject to TOCTOU as well, but is =
still
> used...

I was thinking of background filesystem operations like compression, LVM
migration to new storage with a different sector size, etc. that may =
change
the DIO characteristics of the file even while it is open.  Not that I =
think
this will happen frequently, but it is possible, and applications =
shouldn't
explode if the DIO parameters change and they get an error.

Cheers, Andreas






--Apple-Mail=_8E3621BA-8A02-4654-8DC0-856F43CB7C0C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmMER+MACgkQcqXauRfM
H+D5gBAAjf5qhCdnFlyRgIkdcPs1zELiCu4+Jw0PH5rkavcu3tVPwEBTCbHxXVMN
6ZsFra7ARjxxj58mUSEtN9NDHwpiQreGlgqDoP+uYYb3EwiFZstja2fl0mTAytE5
lMb8zBxkfCh8xexTnnVk7ULsOrTO+/xYTUbmRIqQvK6PTicVuO6H8FtzYFHjilnn
/RZ8yRCndDsFmRpZCApwy26cPcP3UyrtUqz8rKk1iy5oBIC1ALvx8baYjY/Wi7Fs
vMq1ExdKsjPPVQT5dmj1ISPRXpxTGezKhqvxNvbR/IMwKW2PzEMZzClRQnYKuWe5
GBu6zW0mWe5l+Bg1amzve/WteBX/5i6rrkknoD58zBL8SL4LDh+uQGaM2q7EzegR
lEc1/IpOtR1WrfmP+tOqEIfdwa4jMikNm4NKHYoQA2OQcxEzmYgtBHeeVbGOFCEq
PRKVZbxxF2bVFWuBVbsSbAar9o6G6Ucm11LBDHkKEpn8RTqN/UeXBrcslIk9NczK
2qtnn0jbek1OgtMEpGaajobjeqBqQUIC6/cUkU0S7Ga1LsV7D8eH5TV9EF3rWwLe
0MJ2IWgAmbMDp7gYNVZYrsJJMrqcjphRO33u2JvwFisboKU1DD4qtfnG1vvF8u1n
RHpWdRBE/l0VC15dWox4zVKfVgH52rkeKE8ZVkTj83NDSIidz94=
=WmyJ
-----END PGP SIGNATURE-----

--Apple-Mail=_8E3621BA-8A02-4654-8DC0-856F43CB7C0C--
