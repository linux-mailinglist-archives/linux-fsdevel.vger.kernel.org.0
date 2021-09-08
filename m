Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3C34040FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhIHW0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 18:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhIHW0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:26:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144EC061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 15:25:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s29so3329081pfw.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GsOrTd4Eiaa4fJ6fmodeytgLKdYBzvLFJl+g+LZoAiY=;
        b=fxQVbYoe22hfocGiQe66c8zVCIXD64eLRHmCa2gI3B4NSqFfhbv4O8yx6uuchip+ay
         aAStSON4Ai26y9EITHjc7w7fQiy5tSySy7hH5vHYVl9WqFtRcU8QZkdswwFfikVHYmTV
         sPvBCgoTYHR6WrXSDRZjd7Lj7GL00kr0BnhblNmcQwvYDzn8i7T4soXPIAGao3SUk00Z
         pOBBFtwRgv7pLrGizQyMPw2e9CeFxfpYhhWJri/sPHJv+KculmKB/9kYqAM/6spuzYoo
         6P6MwXZBbBAC8XHwiMipzcrktoKTmR5UVchHGoNg45uc4xvCAOftDK6+3ZL7SvVo6Pas
         I0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GsOrTd4Eiaa4fJ6fmodeytgLKdYBzvLFJl+g+LZoAiY=;
        b=FM3mjSN2mSiJxuKUSkPtTWATsunabYqAKI9dabGhpLhtwLL6RTdMCKknrl0pqtPwnr
         hpS4fBtlGRRcRWfsnt0Rk9DV0Kwl926mCq+ihfA6RpLjbnjxX4LH9e5HV8d0Q6BVqjsM
         nssrowr7QlZbUeM3Vegdf6TbfRI8bcIpLFQRmlki3Zs3GJlN4h83P9i9A/1YMsiwsXLB
         fJmAPhxYDpxUkMHxafTshldKXu72zVXqXALJqYr39F2wX4l2cGr8vDwHT7kcgb80ALBk
         +oYdC2GJ15ktt8NR76kO4Fk5EVdOjLOfcHJuStTu2yffMVEE2CcWtdwTarJV7bhIEDRr
         V6xQ==
X-Gm-Message-State: AOAM533A5XZsEf5lJhag3BFhztrEgDAk/fOCkvv57j0j9Z2ZPwiggFZ8
        5cAUstPby7nz3c02s2vATBSRRmvdHbY1nw==
X-Google-Smtp-Source: ABdhPJyc4D2lce8lCQUWM1Y/rJ/fdc/rYPui/2uTNnITMRsWcqA8G0XvDXhhl+oODG9Mwh4JlGwIjA==
X-Received: by 2002:a63:9546:: with SMTP id t6mr388649pgn.260.1631139930769;
        Wed, 08 Sep 2021 15:25:30 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n185sm195417pfn.171.2021.09.08.15.25.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 15:25:29 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7F4D357F-152A-48F2-A43E-DE835BA6EAFC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FD21034E-1A42-4C21-AB70-CC4BFC69612F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [TOPIC LPC] Filesystem Shrink
Date:   Wed, 8 Sep 2021 16:25:27 -0600
In-Reply-To: <3bffa6b2-981f-9a64-9fed-f211bfe501cd@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
References: <3bffa6b2-981f-9a64-9fed-f211bfe501cd@oracle.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_FD21034E-1A42-4C21-AB70-CC4BFC69612F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 8, 2021, at 1:27 AM, Allison Henderson =
<allison.henderson@oracle.com> wrote:
>=20
> Hi All,
>=20
> Earlier this month I had sent out a lpc micro conference proposal for
> file system shrink.  It sounds like the talk is of interest, but folks
> recommended I forward the discussion to fsdevel for more feed back.
> Below is the abstract for the talk:
>=20
>=20
> File system shrink allows a file system to be reduced in size by some =
specified size blocks as long as the file system has enough unallocated =
space to do so.  This operation is currently unsupported in xfs.  Though =
a file system can be backed up and recreated in smaller sizes, this is =
not functionally the same as an in place resize.  Implementing this =
feature is costly in terms of developer time and resources, so it is =
important to consider the motivations to implement this feature.  This =
talk would aim to discuss any user stories for this feature.  What are =
the possible cases for a user needing to shrink the file system after =
creation, and by how much?  Can these requirements be satisfied with a =
simpler mkfs option to backup an existing file system into a new but =
smaller filesystem?  In the cases of creating a rootfs, will a protofile =
suffice?  If the shrink feature is needed, we should further discuss the =
APIs that users would need.
>=20
> Beyond the user stories, it is also worth discussing implementation =
challenges.  Reflink and parent pointers can assist in facilitating =
shrink operations, but is it reasonable to make them requirements for =
shrink?  Gathering feedback and addressing these challenges will help =
guide future development efforts for this feature.
>=20
>=20
> Comments and feedback are appreciated!

This is an issue that has come up occasionally in the past, and more
frequently these days because of virtualization. "Accidental resize"
kind of mistakes, or an installer formatting a huge root filesystem
but wanting to carve off separate filesystems for more robustness
(e.g. so /var/log and /var/tmp don't fill the single root filesystem
and cause the system to fail).

There was some prototype work for a "lazy" online shrink mechanism
for ext4, that essentially just prevented block allocations at the
end of the filesystem.  This required userspace to move any files
and inodes that were beyond the high watermark, and then some time
later either do the shrink offline once the end of the filesystem
was empty, or later enhance the online resize code to remove unused
block groups at the end of the filesystem.  This turns out to be not
as complex as one expects, if the filesystem is already mostly empty,
which is true in the majority of real use cases ("accidental resize",
or "huge root partition" cases).

There is an old a patch available in Patchworks and some discussion
about what would be needed to make it suitable for production use:

=
https://patchwork.ozlabs.org/project/linux-ext4/patch/9ba7e5de79b8b25e3350=
26d57ec0640fc25e5ce0.1534905460.git.jaco@uls.co.za/

I don't think it would need a huge effort to update that patch and add
the minor changes that are needed to make it really usable (stop inode
allocations beyond the high watermark, add a group remove ioctl, etc.)

Cheers, Andreas






--Apple-Mail=_FD21034E-1A42-4C21-AB70-CC4BFC69612F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmE5OFcACgkQcqXauRfM
H+Diew/+LrnOswu5NVaw98QMXObZb8G0aRvY0E6efsjMb6pCVebojOAnGvuwT4yS
IDT4LD9VAgeaZUl1keSRDKYOk5WAHXnmnzJVDKr5mRJrRMU3WY+3U/UsSFAfwvV1
frBBKZjcMBeKov7ys6/94Q46kjrPmFcr91WQfq8MSGjWuxqkpMKfixTo/h+w+DfV
ZA9fqPvXSEoQRi/0vy8FwR/hqgq5f5eWouvnahNQPLOHuOrzEmDQ4U/NSN9mkvUA
NV1AYLy6n51ciQh/fF5EQmrIlmPi+vewO8AyPB2YV/1MO+a22rSXyEF0ZlHvtqj0
dNGTq1z4RZrkWrLVfpeg9pwX0vvnpjfc7zWb9xSlp96E+9jqM2HnGFgnULgilbnV
oCHSF3ToCB5HEpG6aR2x6mESUaFBx4KNK/Mq4hgZxeYlstyGvhwNaCsd6zI5nl3c
qrlDMdCdGEOCXCX7DdlE7RNbn5PgkWgY/q3T5/EJ/zguHWYHPI6QTMiEHMCPwZfJ
5zUjdGgJf5/laNx0veOuE6u8444qiKTrKwy44ssbsFmO35UC/kGqzru7XOnjfgcq
FwmW1AIfyOB5hR0NAAsOtzZ43FaSX33mgyXbENABTcxqR7lzGpnBolZk8vkthM8Z
QwT1pCc+MLf3Sw2fUVoYpCH1bnoYOAnU1Lq8ceZdfaOCesm7z6M=
=qc9V
-----END PGP SIGNATURE-----

--Apple-Mail=_FD21034E-1A42-4C21-AB70-CC4BFC69612F--
