Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272C6580896
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiGYX6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 19:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiGYX6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:58:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C334927FC3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jul 2022 16:58:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 6so11702444pgb.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jul 2022 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Ojaa/UU8B50WRImEMgYvPwV6uUe5mTD3KQg4CpEBv6U=;
        b=PkQ/Af+T+bA+/HBQemEG7rZ7dPDvjPWBs3HhdBpZabOE+c1rBlVlPIz1r+rHpdv09X
         hB/EyFoWNzuccoVADcy4Vdl0PLaNW6AiPxDyeJbUvnDe/d0KvCIQjhAOcQQ6b24XQJYg
         8/PAIEY6L4XYgwJFXkpYL6jJ6xqV0QHoFCBKZuCOOlwPSQ9LL/4PuyVrqBEmhxUVKhgq
         +5HJCiX+CYP8vccNJNvOCHb5WsnAQn5aouKG55wjmwwCi36yEZd/bT00fkiGHByJF0de
         LcwGyirkTcqrv4ntzC3qtmLHmekGwpixqOSlqyQo5wyaYQWrvN7MIDDe1tW66CN4d0X1
         CgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Ojaa/UU8B50WRImEMgYvPwV6uUe5mTD3KQg4CpEBv6U=;
        b=SKQuKxJbOF+MdAb28FntQFK6ypZq0Wcb0Xwms1tyWU8SFf2b/3mbgbcJkJyNl4anBz
         NMAURPGJyTlDqa4yU4Wjd35kJ1BXvTQ0+11lgZ5Ri02imqWI6z3egBYPoQYup7ZkknbG
         M3Q0rgftNHl9IFFSz+3CSu8GAgMmlCh9S6PltE6G/OjrqhGUNwngkF8BRhYkXmTsoLJW
         VcSI1JRcDf7a/dxggAw26tm5fmtCIJSSZR34Vjapb3cPtVvZ+OuFC6Vl9cnURe7K3lOV
         jDp/rATH4XulJ+aYtTZnOf7Pn3nfGFe/GLXOWHXzaB6qH6aOonB2F6uLe/e9JMlJptnH
         OPUg==
X-Gm-Message-State: AJIora+y1z8lB4YlEOLVqKNE8MS/+u48g4CSHEAf9px3AXawh3oLjzog
        lC5IFTPKSOJdYDUuHTi2pgr4ig==
X-Google-Smtp-Source: AGRyM1syH3Cbkf+bRQQU5ivPuhB3TZd0qaZdIG1SBv9zyCS0k235ZiPGksi9iuxNjB1O939AUiI02Q==
X-Received: by 2002:a65:57c2:0:b0:41a:ff04:694c with SMTP id q2-20020a6557c2000000b0041aff04694cmr5997273pgr.573.1658793516160;
        Mon, 25 Jul 2022 16:58:36 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b00168dadc7354sm9859676pll.78.2022.07.25.16.58.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 16:58:35 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EC8AF6A7-9A90-4C21-8A1F-4AE936776876@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DB83B9B8-69A7-4FD9-B14D-F8B77FC7C0F2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Date:   Mon, 25 Jul 2022 17:58:31 -0600
In-Reply-To: <Yt7dCcG0ns85QqJe@sol.localdomain>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org> <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_DB83B9B8-69A7-4FD9-B14D-F8B77FC7C0F2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 25, 2022, at 12:12 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> On Sat, Jul 23, 2022 at 07:01:59PM -0700, Jaegeuk Kim wrote:
>> On 07/22, Eric Biggers wrote:
>>> From: Eric Biggers <ebiggers@google.com>
>>>=20
>>> Currently, if an f2fs filesystem is mounted with the mode=3Dlfs and
>>> io_bits mount options, DIO reads are allowed but DIO writes are not.
>>> Allowing DIO reads but not DIO writes is an unusual restriction, =
which
>>> is likely to be surprising to applications, namely any application =
that
>>> both reads and writes from a file (using O_DIRECT).  This behavior =
is
>>> also incompatible with the proposed STATX_DIOALIGN extension to =
statx.
>>> Given this, let's drop the support for DIO reads in this =
configuration.
>>=20
>> IIRC, we allowed DIO reads since applications complained a lower =
performance.
>> So, I'm afraid this change will make another confusion to users. =
Could
>> you please apply the new bahavior only for STATX_DIOALIGN?
>>=20
>=20
> Well, the issue is that the proposed STATX_DIOALIGN fields cannot =
represent this
> weird case where DIO reads are allowed but not DIO writes.  So the =
question is
> whether this case actually matters, in which case we should make =
STATX_DIOALIGN
> distinguish between DIO reads and DIO writes, or whether it's some odd =
edge case
> that doesn't really matter, in which case we could just fix it or make
> STATX_DIOALIGN report that DIO is unsupported.  I was hoping that you =
had some
> insight here.  What sort of applications want DIO reads but not DIO =
writes?
> Is this common at all?

I don't think this is f2fs related, but some backup applications I'm =
aware
of are using DIO reads to avoid polluting the page cache when reading =
large
numbers of files. They don't care about DIO writes, since that is =
usually
slower than async writes due to the sync before returning from the =
syscall.

Also, IMHO it doesn't make sense to remove useful functionality because =
the
new STATX_DIOALIGN fields don't handle this.  At worst the application =
will
still get an error when trying a DIO write, but in most cases they will
not use the brand new STATX call in the first place, and if this is =
documented
then any application that starts to use it should be able to handle it.

Cheers, Andreas






--Apple-Mail=_DB83B9B8-69A7-4FD9-B14D-F8B77FC7C0F2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmLfLigACgkQcqXauRfM
H+DIjBAAuhcCUrRZxLbIIbGQiYg9WA8Kq1A3wSBPDzMet5t78gjiKUo6y+RE2w0X
O2Be8DY9X8x4OIpbD4jiFAe7TiVDAHAYjjrzKFMykU63wB4nJELcIZrqELT/O1qg
9Zi1+hqoXK+WcCcC8IEh52+ypABRczFIb9OF6RPR450wAxc+0x7lXfyZ/TzBcRyl
+NeWbyLAQfW+VRViN/re9tlticLobDklbfgNC0rNuhp1CawlnMVsqWSxx/F9WT3s
RjdsJ8hzDqLEpPv6Sgd30T9U4UaoLEpRe36CMuT4/SYx6h6SR2Kv61+Z3IihAp41
utLypsHnpswfLjF3KmxusOMLZGmCG1EFazn/gMi6WuccfBaI+m7OXeUvvlLGnzn4
9RJWpVHy3TVTWdikFE/LVP9L7D8rj2jos9UVpFE8QUO2Gu1NNf6C5lIg3iXlvcvn
uxuqCpYcPCCwYosLSNcpi9tNW/p3aS0WNNfGlqWfB8Au4S/91sMJsGKkON+jwsMs
cMiUECc+eFc7HuCrP80IW+N8asiaGrTWGrrg+EpxFtl12OzKyn4OnoY5NxWuLXLF
3lSS1IZWudfgO1TD/5sUmvsHtUS4Rd3akslKsAQyavGxszDWvxIGvU0kABSb8k1P
q3CXMHx8oG9FooyoP3FnfUzDrZXf40Sk28cCsqOa09926JUbhqY=
=zitC
-----END PGP SIGNATURE-----

--Apple-Mail=_DB83B9B8-69A7-4FD9-B14D-F8B77FC7C0F2--
