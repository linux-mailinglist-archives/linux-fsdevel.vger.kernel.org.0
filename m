Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3EA38BDD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 07:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhEUFO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEUFO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 01:14:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497AAC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 May 2021 22:13:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso5911850pjq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 May 2021 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bgS4pF9Ne9nJ3937pRt34Uv0EWKH/eisWTbh6rzbM2w=;
        b=H7YCLMRndDIQtTj6d8jQriGetGwG4I300X506G4hPwBq8a4n2I2NZQzF7tomfz4sfo
         XcCfuvIU9xiUuJlVfA2W9pGVXtv+5fnlaRrYyxu4HpQ/IpTa+MlPwfbq9J56mg3OYDkm
         w48ZefoatPt2VudvdYTxqF4DQRC7Z4dNz6vx8T7bdmDis5Th3R7RjwmgU2rQr3Xv2VRT
         M5SMZnhnsjREFoE8AGFO/IQaRoGavNPIqZGY1OWy9Ocdz/GrLeg8bfJWeXtAmlxvEq4O
         2Quwnfw1tA9Mj5UARwdueHmvmJ59a2E/YBbtXnhax+e4iuvjw9C1ttc0DE+1UBIy04yD
         zU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bgS4pF9Ne9nJ3937pRt34Uv0EWKH/eisWTbh6rzbM2w=;
        b=Exw0tP/0bLGOUHoCcwVKkmp0YF8vHFAhulzpr5cMaaxAuGJ8BsCZfdRCwLxyzV4GR2
         B0l7x3Ul5Hn+iiZPsqj0Lcsev3Ose9Gt8NGtE0MzwWISzj33ubVDBRRFRJX8nR8dofop
         Te5FkV+F7QK658lRKepek7JUjjRbxVRe1cu9yt1RVko82cKNhjTliFq8UJMwwY80PGI9
         STQC8XI524DcOF4vRrUiVX8A5XGH3tZ1suSQ4RevlynTPkzOOo04+o4oJLGwvfKTOe41
         uDqf6rH9BuYLVbpQSCKThD2laMn2/LRM1kUGIxE+vu2kiFVAJQP+xPJYaM+20yLhTnZD
         +nYQ==
X-Gm-Message-State: AOAM531N3lYF1N4NecsV9xUdMZDiN4W91CbcKfyc3zLrGs4q0GJAlLRz
        G668oHU/YybLLiZpCgCHj+MH0A==
X-Google-Smtp-Source: ABdhPJw+V5ShgApxNxW34140eavfSn3skDwRCF9/zx690qZo2q8BklpLFc4augcHT2DreEMSI2l/lw==
X-Received: by 2002:a17:90a:a106:: with SMTP id s6mr8815490pjp.170.1621574012699;
        Thu, 20 May 2021 22:13:32 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id cv24sm3519057pjb.7.2021.05.20.22.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 22:13:31 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9ABD2FFE-ADCA-4E79-B98F-629817F7E7A3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Date:   Thu, 20 May 2021 23:13:28 -0600
In-Reply-To: <206078.1621264018@warthog.procyon.org.uk>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
To:     David Howells <dhowells@redhat.com>
References: <206078.1621264018@warthog.procyon.org.uk>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_9ABD2FFE-ADCA-4E79-B98F-629817F7E7A3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 17, 2021, at 9:06 AM, David Howells <dhowells@redhat.com> wrote:
> With filesystems like ext4, xfs and btrfs, what are the limits on =
directory
> capacity, and how well are they indexed?
>=20
> The reason I ask is that inside of cachefiles, I insert fanout =
directories
> inside index directories to divide up the space for ext2 to cope with =
the
> limits on directory sizes and that it did linear searches (IIRC).
>=20
> For some applications, I need to be able to cache over 1M entries =
(render
> farm) and even a kernel tree has over 100k.
>=20
> What I'd like to do is remove the fanout directories, so that for each =
logical
> "volume"[*] I have a single directory with all the files in it.  But =
that
> means sticking massive amounts of entries into a single directory and =
hoping
> it (a) isn't too slow and (b) doesn't hit the capacity limit.

Ext4 can comfortably handle ~12M entries in a single directory, if the
filenames are not too long (e.g. 32 bytes or so).  With the "large_dir"
feature (since 4.13, but not enabled by default) a single directory can
hold around 4B entries, basically all the inodes of a filesystem.

There are performance knees as the index grows to a new level (~50k, =
10M,
depending on filename length)

As described elsewhere in the thread, allowing concurrent create and =
unlink
in a directory (rename probably not needed) would be invaluable for =
scaling
multi-threaded workloads.  Neil Brown posted a prototype patch to add =
this
to the VFS for NFS:

=
https://lore.kernel.org/lustre-devel/8736rsbdx1.fsf@notabene.neil.brown.na=
me/

Maybe it's time to restart that discussion?

Cheers, Andreas






--Apple-Mail=_9ABD2FFE-ADCA-4E79-B98F-629817F7E7A3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCnQXgACgkQcqXauRfM
H+CtAhAArkAICuRAycDLoFhi3+HEtLyGeg8lvr/V0czSXjKcz0kgsjnpRjQKWW3M
k4bKUagfH8Y0i3oN2BQ6Tdra0KDtyTFzOGCNFj4u6mnFNwK5ONw3xdrVG7AEmrqj
Xw9a0yQ46vvcUNXnTYVD9yL4Rzb9NSqbJStenwhO7OdG0kYY8WcS9sWo2ycnsHmc
oxWFFTaM+CRe0SIirT92MbzJtDdbEPBxVHLtdw9tE9+jSfc547+42N0UmEO/kAxL
cbObKq9zPsNICHraAoBKusp66p6r4TxlTVXt8sS72PBIn2zKjvYRBdhRZy8DcnCi
7+uj4VQp9JpeSCB7hqDdUQuUCXkJs2emvxiQv+F1mGjyYSXveDhdQwbcF/6zKqjk
aCFJNDKH4xvVQpUg7diBKnuf0nhdOgn18m+RnGidSFH52xYR1AI3vtzN9BuN76At
w0vhpElqyfj6CpJuKh+uAnyAWgE+tqebaSOXQbFGBx6rpelp9kKxzpmusjn5Xpj6
DWIiSqSLGtJnBQo1PyqWQykqR7het6xNCTIn6TWMDqZNSZ2vCZ4smrVWgl+CZthn
o6gBqI6SsXwRPCUh5qIMVqVPWcFvvdFUoYltKDG6w7sNaON+UhtcMSrLxwiJA9FA
/7Ezr8zglU/AB4wrGwd/4aTHrQWdLwn6Ww0HpYTqNNqpMAsSMgA=
=A2zI
-----END PGP SIGNATURE-----

--Apple-Mail=_9ABD2FFE-ADCA-4E79-B98F-629817F7E7A3--
