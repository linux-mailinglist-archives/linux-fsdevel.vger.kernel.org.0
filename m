Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D322A22484
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfERSkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 14:40:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43970 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbfERSkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 14:40:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so10273495wro.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2019 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ouEAfY4fVdVHhS9xR65IP6Zu3YZKMcX1yK26/K9YRUY=;
        b=nlp7cHJt2SjtBL+lyV4uwEHDsEea6nRrWx5BU9r3PG8LieJX1ROiQDyxQpLG1WdGm/
         2TrUP8Z6n6D2ouN6A/3sw7WZysGcv73ll6ZTXI8RyL+ntXWvd5wHWzQ0o6aS92tqPJju
         C1rGQW9JCxQuhs7CQOqrLPbJWm4aEiqDd41KQhAWZirqNKSNz9MAlQOMB68cUxn0UUTe
         KIP/emPF1QPcyA/CLxVNJXMr1X2h46CgI12jfOyhBlI++DQErsG3wj3NPXfXWYj9glIE
         wEEPycLptPZkBPIoyZqcaurC/U5Ltp6ZOOnPhW8BvqdYLnVBza6XzYvD+pPkgWf02k+g
         eK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ouEAfY4fVdVHhS9xR65IP6Zu3YZKMcX1yK26/K9YRUY=;
        b=SOfKMxBTbvMRJBfWV2EeJy5D+BnfZwqGRVsWNtXC9AXvvoApLJBN4mmC9oo1x13kBh
         SI3ufSCM6V42NmapMJ3AjcGFeIvQIkJd/yrXQHaKQro5c6j1rdI5n38IgSmjG0IbIV/Q
         JisGVRBCRJZ8bQxXQmplvVgwiG2K8wCL5IjMGr/WMqOzNoNY1U8jzv9SP7xCzTSvh20o
         x5GHXKegFjkARbBcO9Kw3/9mYGV3svNpKXGk1bwtzgCC4RWRdLdIq+zapvnCG1TmpHhR
         GKU8i5W7Bs+dSCdw99epa6of98HR/Vg2vwtPIVRKFQzy9G0pcmqayNKg2bCKLQ1MoEwy
         /9ag==
X-Gm-Message-State: APjAAAVqs6KbxeeonBSYPjlgLDo6zHisu5Z4x7YBfAbHKpi1wroHWAhD
        PHuZoxHvbHb2BaLyUCew6qwjLw==
X-Google-Smtp-Source: APXvYqzVK8BV5Of9EvEM1INCvl8U4K12CuUulfyj9lY9OcHKvXPf2OwHmZNC0FvObtMXpR/7vHW8IA==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr40449129wrv.52.1558204797886;
        Sat, 18 May 2019 11:39:57 -0700 (PDT)
Received: from [192.168.0.104] (146-241-112-39.dyn.eolo.it. [146.241.112.39])
        by smtp.gmail.com with ESMTPSA id m206sm16520509wmf.21.2019.05.18.11.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 11:39:56 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2AB4EAF8-8BC4-47A0-9500-56DE63C63E62";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Sat, 18 May 2019 20:39:54 +0200
In-Reply-To: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jack@suse.cz,
        jmoyer@redhat.com, tytso@mit.edu, amakhalov@vmware.com,
        anishs@vmware.com, srivatsab@vmware.com
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_2AB4EAF8-8BC4-47A0-9500-56DE63C63E62
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I've addressed these issues in my last batch of improvements for BFQ, =
which landed in the upcoming 5.2. If you give it a try, and still see =
the problem, then I'll be glad to reproduce it, and hopefully fix it for =
you.

Thanks,
Paolo

> Il giorno 18 mag 2019, alle ore 00:16, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
>=20
> Hi,
>=20
> One of my colleagues noticed upto 10x - 30x drop in I/O throughput
> running the following command, with the CFQ I/O scheduler:
>=20
> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflags=3Ddsync
>=20
> Throughput with CFQ: 60 KB/s
> Throughput with noop or deadline: 1.5 MB/s - 2 MB/s
>=20
> I spent some time looking into it and found that this is caused by the
> undesirable interaction between 4 different components:
>=20
> - blkio cgroup controller enabled
> - ext4 with the jbd2 kthread running in the root blkio cgroup
> - dd running on ext4, in any other blkio cgroup than that of jbd2
> - CFQ I/O scheduler with defaults for slice_idle and group_idle
>=20
>=20
> When docker is enabled, systemd creates a blkio cgroup called
> system.slice to run system services (and docker) under it, and a
> separate blkio cgroup called user.slice for user processes. So, when
> dd is invoked, it runs under user.slice.
>=20
> The dd command above includes the dsync flag, which performs an
> fdatasync after every write to the output file. Since dd is writing to
> a file on ext4, jbd2 will be active, committing transactions
> corresponding to those fdatasync requests from dd. (In other words, dd
> depends on jdb2, in order to make forward progress). But jdb2 being a
> kernel thread, runs in the root blkio cgroup, as opposed to dd, which
> runs under user.slice.
>=20
> Now, if the I/O scheduler in use for the underlying block device is
> CFQ, then its inter-queue/inter-group idling takes effect (via the
> slice_idle and group_idle parameters, both of which default to 8ms).
> Therefore, everytime CFQ switches between processing requests from dd
> vs jbd2, this 8ms idle time is injected, which slows down the overall
> throughput tremendously!
>=20
> To verify this theory, I tried various experiments, and in all cases,
> the 4 pre-conditions mentioned above were necessary to reproduce this
> performance drop. For example, if I used an XFS filesystem (which
> doesn't use a separate kthread like jbd2 for journaling), or if I =
dd'ed
> directly to a block device, I couldn't reproduce the performance
> issue. Similarly, running dd in the root blkio cgroup (where jbd2
> runs) also gets full performance; as does using the noop or deadline
> I/O schedulers; or even CFQ itself, with slice_idle and group_idle set
> to zero.
>=20
> These results were reproduced on a Linux VM (kernel v4.19) on ESXi,
> both with virtualized storage as well as with disk pass-through,
> backed by a rotational hard disk in both cases. The same problem was
> also seen with the BFQ I/O scheduler in kernel v5.1.
>=20
> Searching for any earlier discussions of this problem, I found an old
> thread on LKML that encountered this behavior [1], as well as a docker
> github issue [2] with similar symptoms (mentioned later in the
> thread).
>=20
> So, I'm curious to know if this is a well-understood problem and if
> anybody has any thoughts on how to fix it.
>=20
> Thank you very much!
>=20
>=20
> [1]. https://lkml.org/lkml/2015/11/19/359
>=20
> [2]. https://github.com/moby/moby/issues/21485
>     https://github.com/moby/moby/issues/21485#issuecomment-222941103
>=20
> Regards,
> Srivatsa


--Apple-Mail=_2AB4EAF8-8BC4-47A0-9500-56DE63C63E62
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzgUXoACgkQOAkCLQGo
9oPNXw//edQtNFa1ZbM3WUODyCQi7cKAIh4ducAKO16wY4cr3eaXmlDO++GEBBos
cPdrh1eqQUs6ARuLbmwyLSCZpm3dyJFuK6RBqWYAPdM8vExd4cl6xAHzCK271grv
2+HvBk5p9/fR+TZoKKz/fv6gJG1qBW6/sdVwLGY7pb6J9iTYjRO6t2faRhc6LXFE
LrsLOwF4OzYYhYbbU1tvTu34VxDycloASVdaYUQsqA9B3C5NO1VeMVhoPRFXL6fK
8ZOiXkpOZLaqldXk6sctyg7yWFmzjUFS/PfnG3ZBSOGWYhA0T7aIEzOddQy39Ckx
iEFl6DCCsUrzCw7kWZRjitVeDZp1itdANtNmqBBwcv/ccW1ag4Hryt08F9LSNKp/
P4JDKOLezZ39VQyLoOnYVT/HeCQjx1uQpmilE3lU6+KFEjq61lD5y072Wz8Nw8AE
qVjwv7Z2FPAROe8JGVpHn6YMvFzrl79nKa+ji9BlQWm1JVvgDcHoZGdVyuaznNyV
NXOpSbi2BnsQvyfhNYwSc9/Jkopfbx/3fMkTK7LnLLSiPo1snzC2bMdICJPWtsYx
Vqd4II1J1ZcvSmllZ7lOHpAi3JsPbuemcx0fvA8CXdBST0ZgEuaJLzb2MM5+X8uP
SJwBn7Vy3TlM6kio9mtr4W3x2341l/FmpxnHWDZiCFsS6A/EQ6c=
=FzRW
-----END PGP SIGNATURE-----

--Apple-Mail=_2AB4EAF8-8BC4-47A0-9500-56DE63C63E62--
