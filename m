Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB984596082
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 18:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiHPQmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiHPQmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:42:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038E80E80
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 09:42:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so9799003pfb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc;
        bh=3UsEcGaqqxu6uaf6V7Db2UUvbrW1qQxZh0X1je5plvs=;
        b=Zmvs6vXQj1YuzC5CpcL9ZdRSfRMxWuvJuG36+xzxXxSn/FnBKBWixBWCoOKIwrcf55
         n46G64dAdkeAyCTOhtlwvPzc4Tk73T8CZOzBxW/yv7iUTcD5j+K09Xl78RS6JHAryYsH
         dpl6GIflzqLKivwt8XMQjnVpsHzQ8A5k8FSijs3OEEXN9w0pRa/0S5IaJNPik48pckp6
         C5aMtORn54V5bsaXmHvhAa1AZHkQKY6sgAgHPDjgbX8T2hQke1pSCge/sRvDRbpzK3+Q
         NVCcQskda4YA0R3znKKkgXYcwZ4EYf0ewpN+JcDe6G59HZSOCmXZDesAM6+QGyO3VRhc
         YGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=3UsEcGaqqxu6uaf6V7Db2UUvbrW1qQxZh0X1je5plvs=;
        b=Z46fb9EdSCXAMxoFBgO7jT8X217iodaOY+6WnBR6heYrcopyWDQQkRU4x2vvfpng/h
         E+c/AtpPpxLGkW4LmIVaScwnlOBiFUPswf1uh5+UmC39tgbncT+MYDwOsUDD7rzmWPEh
         GhstDxaqrhNpZfgSR+UaQ35Gp2Q8mV0X2hCAeAklSTD/nFkH5Ll1QGnbL5pCYCGQ7gUl
         /M6rvpwRxCfcsUE1kPHqT2cG3VqCu7+kvz4H/RzE7mNMMKDRlkXoX3dQnm3dXcSJld4C
         MD5J+iOJ7Xsl+mGQeCeMbiKP1OI1VsCM8zKhkQwUkPwyceJckoBK+9S3kU6ADRMeNLB2
         t6kA==
X-Gm-Message-State: ACgBeo06kaYH2Mdx2MmooMEsTxlidiGZ034LDQ36zZNIe3BOrxPpV8si
        3mcmz1S+AjDqHsGrXWCD3UiPjA==
X-Google-Smtp-Source: AA6agR5MxmTfKKDmbSJw3suGI5oZ/F470+FJjV7/Uj0jVLBbToS4xOkVs5Jg06J4aqmXnDRNRAtD/Q==
X-Received: by 2002:a65:6d85:0:b0:429:9ce8:6a60 with SMTP id bc5-20020a656d85000000b004299ce86a60mr4399151pgb.352.1660668154762;
        Tue, 16 Aug 2022 09:42:34 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z25-20020a656659000000b00419b66846fcsm7761270pgv.91.2022.08.16.09.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2022 09:42:33 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D1CDACE3-EC7E-43E4-8F49-EEA2B6E71A41@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_55512B7B-3B73-458E-BB38-6700602A50E9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Date:   Tue, 16 Aug 2022 10:42:29 -0600
In-Reply-To: <20220816090312.GU3600936@dread.disaster.area>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        xfs <linux-xfs@vger.kernel.org>, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org> <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain> <YuXyKh8Zvr56rR4R@google.com>
 <YvrrEcw4E+rpDLwM@sol.localdomain>
 <20220816090312.GU3600936@dread.disaster.area>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_55512B7B-3B73-458E-BB38-6700602A50E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 16, 2022, at 3:03 AM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Mon, Aug 15, 2022 at 05:55:45PM -0700, Eric Biggers wrote:
>> On Sat, Jul 30, 2022 at 08:08:26PM -0700, Jaegeuk Kim wrote:
>>> On 07/25, Eric Biggers wrote:
>>>> On Sat, Jul 23, 2022 at 07:01:59PM -0700, Jaegeuk Kim wrote:
>>>>> On 07/22, Eric Biggers wrote:
>>>>>> From: Eric Biggers <ebiggers@google.com>
>>>>>>=20
>>>>>> Currently, if an f2fs filesystem is mounted with the mode=3Dlfs =
and
>>>>>> io_bits mount options, DIO reads are allowed but DIO writes are =
not.
>>>>>> Allowing DIO reads but not DIO writes is an unusual restriction, =
which
>>>>>> is likely to be surprising to applications, namely any =
application that
>>>>>> both reads and writes from a file (using O_DIRECT).  This =
behavior is
>>>>>> also incompatible with the proposed STATX_DIOALIGN extension to =
statx.
>>>>>> Given this, let's drop the support for DIO reads in this =
configuration.
>>>>>=20
>>>>> IIRC, we allowed DIO reads since applications complained a lower =
performance.
>>>>> So, I'm afraid this change will make another confusion to users. =
Could
>>>>> you please apply the new bahavior only for STATX_DIOALIGN?
>>>>>=20
>>>>=20
>>>> Well, the issue is that the proposed STATX_DIOALIGN fields cannot =
represent this
>>>> weird case where DIO reads are allowed but not DIO writes.  So the =
question is
>>>> whether this case actually matters, in which case we should make =
STATX_DIOALIGN
>>>> distinguish between DIO reads and DIO writes, or whether it's some =
odd edge case
>>>> that doesn't really matter, in which case we could just fix it or =
make
>>>> STATX_DIOALIGN report that DIO is unsupported.  I was hoping that =
you had some
>>>> insight here.  What sort of applications want DIO reads but not DIO =
writes?
>>>> Is this common at all?
>>>=20
>>> I think there's no specific application to use the LFS mode at this
>>> moment, but I'd like to allow DIO read for zoned device which will =
be
>>> used for Android devices.
>>>=20
>>=20
>> So if the zoned device feature becomes widely adopted, then =
STATX_DIOALIGN will
>> be useless on all Android devices?  That sounds undesirable.  Are you =
sure that
>> supporting DIO reads but not DIO writes actually works?  Does it not =
cause
>> problems for existing applications?
>=20
> What purpose does DIO in only one direction actually serve? All it
> means is that we're forcibly mixing buffered and direct IO to the
> same file and that simply never ends well from a data coherency POV.
>=20
> Hence I'd suggest that mixing DIO reads and buffered writes like
> this ends up exposing uses to the worst of both worlds - all of the
> problems with none of the benefits...
>=20
>> What we need to do is make a decision about whether this means we =
should
>> build in a stx_dio_direction field (indicating no support / readonly
>> support / writeonly support / readwrite support) into the API from =
the
>> beginning.  If we don't do that, then I don't think we could simply =
add
>> such a field later, as the statx_dio_*_align fields will have already
>> been assigned their meaning.  I think we'd instead have to =
"duplicate"
>> the API, with STATX_DIOROALIGN and statx_dio_ro_*_align fields.  That
>> seems uglier than building a directional indicator into the API from =
the
>> beginning.  On the other hand, requiring all programs to check
>> stx_dio_direction would add complexity to using the API.
>>=20
>> Any thoughts on this?
>=20
> Decide whether partial, single direction DIO serves a useful purpose
> before trying to work out what is needed in the API to indicate that
> this sort of crazy will be supported....

Using read-only O_DIRECT makes sense for backup and other filesystem
scanning tools that don't want to pollute the page cache of a system
(which may be in use by other programs) while reading many files once.

Using interfaces like posix_fadvise(FADV_DONTNEED) to drop file cache
afterward is both a hassle and problematic when reading very large files
that would push out more important pages from cache before the large
file's pages can be dropped.


IMHO, this whole discussion is putting the cart before the horse.
Changing existing (and useful) IO behavior to accommodate an API that
nobody has ever used, and is unlikely to even be widely used, doesn't
make sense to me.  Most applications won't check or care about the new
DIO size fields, since they've lived this long without statx() returning
this info, and will just pick a "large enough" size (4KB, 1MB, whatever)
that gives them the performance they need.  They *WILL* care if the app
is suddenly unable to read data from a file in ways that have worked for
a long time.

Even if apps are modified to check these new DIO size fields, and then
try to DIO write to a file in f2fs that doesn't allow it, then f2fs will
return an error, which is what it would have done without the statx()
changes, so no harm done AFAICS.

Even with a more-complex DIO status return that handles a "direction"
field (which IMHO is needlessly complex), there is always the potential
for a TOCTOU race where a file changes between checking and access, so
the userspace code would need to handle this.

Cheers, Andreas






--Apple-Mail=_55512B7B-3B73-458E-BB38-6700602A50E9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmL7yPUACgkQcqXauRfM
H+C5yA/9G0OeBL/KETzAPM0Gdql84d9VCjortatITeNdwHUMtP26voBr8Q5A85dE
vey+YGYSY1rcLrN9ORjCqJ9WRD3e77oXPapHyNlqgh+x2fxGgI8Ypb34fT0oB/vu
YTRE3UgK0IEt2ZB76AnlSOtXzHGQrME4dUNTg9NcwDIEdJL3L4FUrykhozGqkFFu
/zxI8KCATl2lEyuse7h7DYX187W1H1tSORo4Z7BpW7JcA0F4Bw0NoNET9nhV7PlS
GW7QqOSt46Wf+w2V6HsUhVAbLJz+3XfQ1hVO+tp3cWfqRQ54DpcqJIL0HD73GQmY
eR6m67atxsHO2tsgOaMxcaQwTNZrmZoPveHrS5oR2Eo+qWsVn4hp5pikFGp9fyuD
V9cUm2yFCa/bKxhwTcfSTrEO8/R7rYVX3ppqP1HGO5t9xw0vSe8Mg+wBLFG45/L9
Bk+vfgnffDluYw546hklgu+KqD0wVkfRKUEZcimT/4Vfyg5d1GPSXTLlnjm6lWq3
i5Y2yf2PPo+Yx25qt65QC0VkRV1dsdPLuTI9MoyKTHgYc3MlPYJoK+Ohyq8CuHq/
W6Qpib+UBC07fdA61Qw1yJR1TfIIJ+nNFzuXvAZvINFKRDQ87npdHpuoUul1lJ6p
eXugihjhNr7Ny2hXArGDjA/lPjTfg6gf0EPZOezgajagFOyerH4=
=1DeF
-----END PGP SIGNATURE-----

--Apple-Mail=_55512B7B-3B73-458E-BB38-6700602A50E9--
