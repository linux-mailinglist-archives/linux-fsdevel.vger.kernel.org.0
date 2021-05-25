Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9C390B15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 23:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhEYVPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhEYVPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 17:15:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A02C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 14:13:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso13895164pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 14:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JmM52i5DNThmfft1Cd0isHBrymiQJRyWSlR6uoOrusw=;
        b=SOVprFe0BzMa6/xG5BUaiLbSHmR6DfG13wobQJj5aVigGaL1CrXgB4LM2PB61Wc5MK
         hd1L83F5ploc2veZiGIHQkg7oZs+iYFtGvw/e46v62eESQjsWhYCRsZWqul3culutsus
         bm6FTuGfP0hTjoepFHswHJorzJm2OTx3c4yt7ykAHtkCaPs+b5yBeFFMfjChfLfF+szw
         w/6I0E7Q8axsSV0BBUWvBOAmkTeyG0lZ4TMcnkzmSocXd248/QfKJRwYu6An1y9f5jgy
         zrTCpJedVaZLOzM8cQ1UIS/k58G8nKVgPvFwGs02/krSIH3xXjdTrihwHYvguZ+0QD81
         giyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JmM52i5DNThmfft1Cd0isHBrymiQJRyWSlR6uoOrusw=;
        b=Bggwva224TUuf14J26tMRECKKuPjW8a8AJo6SRtrG0bwlrVEc+/RBTtcIjJhXaoHrW
         ycwviyWpryy4eSGvXyq5SXCOzvABSgcy9A26wWvCp7LDP0ImtmpjWN5hX7+DLdAzz0Re
         fBKY/a2ZOBeA6QOQb91jKYv53J3OqGO8tFPIjgKK2m9dToBex84Hp4NFAdF1lBn6NGZc
         fnh7k3oqdKdrKo/ddGba1SP5NCrX6418Ykeh7I0JAe5P647/lDo2Pt5fVRWRO+rwU3BV
         t/mpdzLWDLpaIJ9Qv56eaGs6OjSVOHrgxTzcw+Qqla4EawqXADxSR8h81VuJoNIOdW3S
         6EAA==
X-Gm-Message-State: AOAM531HF1qkFa9qy45O79OotOcSCjJOG4S/MAh270cMv+9F9O3Df71D
        Ckfo4rVNn91QKLwKIKatpGgMpg==
X-Google-Smtp-Source: ABdhPJxovMaArTxrZUjDz9WBUBNLV77MQCbQ2dnAfC0ijKAmUCSCo+9SdO9Bfs9OvCAbEJYT0dkpow==
X-Received: by 2002:a17:90a:390a:: with SMTP id y10mr32412407pjb.9.1621977224576;
        Tue, 25 May 2021 14:13:44 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id gb10sm13084005pjb.57.2021.05.25.14.13.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 14:13:43 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_794BFB72-2A90-4EC6-873C-64F5CD31A56E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Date:   Tue, 25 May 2021 15:13:52 -0600
In-Reply-To: <YKntRtEUoxTEFBOM@localhost>
Cc:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
To:     Josh Triplett <josh@joshtriplett.org>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca> <YKntRtEUoxTEFBOM@localhost>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_794BFB72-2A90-4EC6-873C-64F5CD31A56E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 22, 2021, at 11:51 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>=20
> On Thu, May 20, 2021 at 11:13:28PM -0600, Andreas Dilger wrote:
>> On May 17, 2021, at 9:06 AM, David Howells <dhowells@redhat.com> =
wrote:
>>> With filesystems like ext4, xfs and btrfs, what are the limits on =
directory
>>> capacity, and how well are they indexed?
>>>=20
>>> The reason I ask is that inside of cachefiles, I insert fanout =
directories
>>> inside index directories to divide up the space for ext2 to cope =
with the
>>> limits on directory sizes and that it did linear searches (IIRC).
>>>=20
>>> For some applications, I need to be able to cache over 1M entries =
(render
>>> farm) and even a kernel tree has over 100k.
>>>=20
>>> What I'd like to do is remove the fanout directories, so that for =
each logical
>>> "volume"[*] I have a single directory with all the files in it.  But =
that
>>> means sticking massive amounts of entries into a single directory =
and hoping
>>> it (a) isn't too slow and (b) doesn't hit the capacity limit.
>>=20
>> Ext4 can comfortably handle ~12M entries in a single directory, if =
the
>> filenames are not too long (e.g. 32 bytes or so).  With the =
"large_dir"
>> feature (since 4.13, but not enabled by default) a single directory =
can
>> hold around 4B entries, basically all the inodes of a filesystem.
>=20
> ext4 definitely seems to be able to handle it. I've seen bottlenecks =
in
> other parts of the storage stack, though.
>=20
> With a normal NVMe drive, a dm-crypt volume containing ext4, and =
discard
> enabled (on both ext4 and dm-crypt), I've seen rm -r of a directory =
with
> a few million entries (each pointing to a ~4-8k file) take the better
> part of an hour, almost all of it system time in iowait. Also makes =
any
> other concurrent disk writes hang, even a simple "touch x". Turning =
off
> discard speeds it up by several orders of magnitude.
>=20
> (I don't know if this is a known issue or not, so here are the details
> just in case it isn't. Also, if this is already fixed in a newer =
kernel,
> my apologies for the outdated report.)

Definitely "-o discard" is known to have a measurable performance =
impact,
simply because it ends up sending a lot more requests to the block =
device,
and those requests can be slow/block the queue, depending on underlying
storage behavior.

There was a patch pushed recently that targets "-o discard" performance:
https://patchwork.ozlabs.org/project/linux-ext4/list/?series=3D244091
that needs a bit more work, but may be worthwhile to test if it improves
your workload, and help put some weight behind landing it?

Another proposal was made to change "-o discard" from "track every freed
block and submit TRIM" to "(persistently) track modified block groups =
and
submit background TRIM like fstrim for the whole group".  One advantage
of tracking the whole block group is that block group state is already
maintained in the kernel and persistently on disk.  This also provides a
middle way between "immediate TRIM" that may not cover a whole erase =
block
when it is run, and "very lazy fstrim" that aggregates all free blocks =
in
a group but only happens when fstrim is run (from occasionally to =
never).

The in-kernel discard+fstrim handling could be smarter than "run every =
day
from cron" because it can know when the filesystem is busy or not, how =
much
data has been written and freed, and when a block group has a =
significant
amount of free space and is useful to actually submit the TRIM for a =
group.

The start of that work was posted for discussion on linux-ext4:
https://marc.info/?l=3Dlinux-ext4&m=3D159283169109297&w=3D4
but ended up focussed on semantics of whether TRIM needs to obey =
requested
boundaries for security reasons, or not.

Cheers, Andreas






--Apple-Mail=_794BFB72-2A90-4EC6-873C-64F5CD31A56E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCtaJIACgkQcqXauRfM
H+B43g//XXljpnvCDqmJdZoi3BWDl8BXab4KwkTguFmad56XaZQHFlCLjW0AhBHE
zsBcuVk/C2ZsO4lwRUL02JtXD2fWB/VQ2lTFQ7dL0RPyL5QIvt0ineeUjm7Ik/nC
bqu1GSoTyNCKV37S25mnsYfM9+pxuHongQu1q5cXzdEzqi6Lk2Wpe0o6ktw0M0us
08YX+B4g2aGgk1zjlnpiTBCjlbSpst91AhoLmjfdL+oDIHqG17HV0gonZsy+84W4
kHqb/IPAiDQJ+FCHGIbpRoMlXVYB6G265m+e2vECMi1+wiXxBLIJsxvjYk3vd1k/
ZHtY67f5UNQAqU/TeYhlTpNdfwUs0nYb85oYGMR/db1kDQj1vCh/OS6SZKjQj/fl
a5cjREGb8ts+JYvVTYLQYbMtsBMtFSimss6HRl9SrI5N18zMGT9ffdSjciZaTdaM
51gtZd06Vs9cR3K91xaJqa6NVo/BrTrFqNmZP0ccxPa9kRzKwzfQbvF9s2wF75va
9rx5ouzLvrbZDqGVM5VjYumJtptvLAigoCFa3F1R/ebdwer3Rbn6GMLFbttZ98zd
vvoGxgQVmBAYMt6SqYpZ2nr8gygFTr0guzN+xRp6ynlHusVOkbfSNrR8x0k7ZA96
kqU0BeziMpUL5r7OL6casG/bSRUxgKgdHi9sP+jmAK2yu6S+aG8=
=P+t3
-----END PGP SIGNATURE-----

--Apple-Mail=_794BFB72-2A90-4EC6-873C-64F5CD31A56E--
