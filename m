Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D0D1138E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 01:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfLEAgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 19:36:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39012 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLEAgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:36:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so454149plk.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 16:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=v9E5rlSkQJQrSqIO0YcWMYwFioVqcs/hD8v34GkQHRU=;
        b=H6FPhFB96uqLT7ljNNjqB3p4lAgPxhM/m/mQpQqMFvV4f0EZW+BVyDPGQ0o1AavKBD
         szUdzCxFGY9pyStlH1eTP7iS12JnCDGS2xkQN1t0kgKfCYez2XOYiJohT3jV+9wAwN/s
         /RzpsEoBU3RidFffc9s6pH3CKGiLwqooAapEVz+/GjB1WNa81i5sifAEzlnaa1nCpkwS
         uvHV1CdHbGjDMRBmbgapEtAZ8wgcU0Cg/4qTVF0OW/xCbKhOa2E7/KYwKoGUCNs7cWej
         /P10YyBVu9VSVepgGe/AOANUOYW49r7KEi40gMnOexA308huChpOOCbDcT0tpk9C5diE
         8WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=v9E5rlSkQJQrSqIO0YcWMYwFioVqcs/hD8v34GkQHRU=;
        b=rrhwDTtUUEawg1xCZ3IPW+rwihpQbzz7rGkp9OLo6/YESTW/Jm1dVF584eu7Y9ThQk
         0ooDT0pYGvyd45gquwc2SokKtMheXCpY8yf6jfdmThYLr130baKGq21G/zhMCs3K4JWz
         JegpGaCpbzBohKP5O+wLzpC4Qsx1pdGZXjZNk+4Ia/fY6VlWIoUttTGAwk+sRwqdEf2m
         gHE8ZyqPYHJQxwoJi8NME/LgGqIzCpzOA4/B0YW3WyorHDjFCZFfMwxU91iYZlHMqxbK
         6J9E4yzTjqFmZ11z8udNKBR9c8l2f881tkDLeaq8z0bYFNfuqJoa/vNx3sijwzAId89k
         NtZA==
X-Gm-Message-State: APjAAAU2TToJx91b9sUonvfM1qvpcP+IbZePa9ATuBdK2Vf2uKv8ptCS
        JBQ4UWw1aDtWLiNrgGD28habNg==
X-Google-Smtp-Source: APXvYqxe8uQ05ZDEjkaV79c/Q46eo2bQVYhf9xsRWl8ToZUfVmwP0I3hIfhaNxnbz8BOa0oE5wZMCA==
X-Received: by 2002:a17:902:8507:: with SMTP id bj7mr6005857plb.69.1575506198773;
        Wed, 04 Dec 2019 16:36:38 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id j16sm8905983pfi.165.2019.12.04.16.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 16:36:37 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <13F44A87-CAAE-4090-B26C-73EC2AF56765@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D0697059-1FC1-40CA-9626-39043366B48C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Date:   Wed, 4 Dec 2019 17:36:32 -0700
In-Reply-To: <f385445b-4941-cc48-e05d-51480a01f4aa@phunq.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Daniel Phillips <daniel@phunq.net>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
 <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
 <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
 <f385445b-4941-cc48-e05d-51480a01f4aa@phunq.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D0697059-1FC1-40CA-9626-39043366B48C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 4, 2019, at 2:44 PM, Daniel Phillips <daniel@phunq.net> wrote:
>=20
> On 2019-12-04 10:31 a.m., Andreas Dilger wrote:
>> One important use case that we have for Lustre that is not yet in the
>> upstream ext4[*] is the ability to do parallel directory operations.
>> This means we can create, lookup, and/or unlink entries in the same
>> directory concurrently, to increase parallelism for large =
directories.
>=20
> This is a requirement for an upcoming transactional version of user =
space
> Shardmap. In the database world they call it "row locking". I am =
working
> on a hash based scheme with single record granularity that maps onto =
the
> existing shard buckets, which should be nice and efficient, maybe a =
bit
> tricky with respect to rehash but looks not too bad.
>=20
> Per-shard rw locks are a simpler alternative, but might get a bit =
fiddly
> if you need to lock multiple entries in the same directory at the same
> time, which is required for mv is it not?

We currently have a "big filesystem lock" (BFL) for rename(), as rename
is not an operation many people care about the performance.  We've
discussed a number of times to optimize this for the common cases of
rename a regular file within a single directory and rename a regular
file between directories, but no plans at all to optimize rename of
directories between parents.

>> This is implemented by progressively locking the htree root and index
>> blocks (typically read-only), then leaf blocks (read-only for lookup,
>> read-write for insert/delete).  This provides improved parallelism
>> as the directory grows in size.
>=20
> This will be much easier and more efficient with Shardmap because =
there
> are only three levels: top level shard array; shard hash bucket; =
record
> block. Locking applies only to cache, so no need to worry about =
possible
> upper tier during incremental "reshard".
>=20
> I think Shardmap will also split more cleanly across metadata nodes =
than
> HTree.

We don't really split "htree" across metadata nodes, that is handled by
Lustre at a higher level than the underlying filesystem.  Hash filename
with per-directory hash type, modulo number of directory shards to find
index within that directory, then map index to a directory shard on a
particular server.  The backing filesystem directories are normal from
the POV of the local filesystem.

>> Will there be some similar ability in Shardmap to have parallel ops?
>=20
> This work is already in progress for user space Shardmap. If there is
> also a kernel use case then we can just go forward assuming that this
> work or some variation of it applies to both.
>=20
> We need VFS changes to exploit parallel dirops in general, I think,
> confirmed by your comment below. Seems like a good bit of work for
> somebody. I bet the benchmarks will show well, suitable grist for a
> master's thesis I would think.
>=20
> Fine-grained directory locking may have a small enough footprint in
> the Shardmap kernel port that there is no strong argument for getting
> rid of it, just because VFS doesn't support it yet. Really, this has
> the smell of a VFS flaw (interested in Al's comments...)

I think that the VFS could get 95% of the benefit for 10% of the effort
would be by allowing only rename of regular files within a directory
with only a per-directory mutex.  The only workload that I know which
does a lot of rename is rsync, or parallel versions of it, that create
temporary files during data transfer, then rename the file over the
target atomically after the data is sync'd to disk.

>> Also, does Shardmap have the ability to shrink as entries are =
removed?
>=20
> No shrink so far. What would you suggest? Keeping in mind that =
POSIX+NFS
> semantics mean that we cannot in general defrag on the fly. I planned =
to
> just hole_punch blocks that happen to become completely empty.
>=20
> This aspect has so far not gotten attention because, historically, we
> just never shrink a directory except via fsck/tools. What would you
> like to see here? Maybe an ioctl to invoke directory defrag? A mode
> bit to indicate we don't care about persistent telldir cookies?

There are a few patches floating around to shrink ext4 directories which
I'd like to see landed at some point.  The current code is sub-optimal,
in that it only tries to shrink "easy" blocks from the end of directory,
but hopefully there can be more aggressive shrinking in later patches.

> How about automatic defrag that only runs when directory open count is
> zero, plus a flag to disable?

As long as the shrinking doesn't break POSIX readdir ordering semantics.
I'm obviously not savvy on the Shardmap details, but I'd think that the
shards need to be garbage collected/packed periodically since they are
log structured (write at end, tombstones for unlinks), so that would be
an opportunity to shrink the shards?

>> [*] we've tried to submit the pdirops patch a couple of times, but =
the
>> main blocker is that the VFS has a single directory mutex and =
couldn't
>> use the added functionality without significant VFS changes.
>=20
> How significant would it be, really nasty or just somewhat nasty? I =
bet
> the resulting efficiencies would show up in some general use cases.

As stated above, I think the common case could be implemented relatively
easily (rename within a directory), then maybe rename files across
directories, and maybe never rename subdirectories across directories.

>> Patch at =
https://git.whamcloud.com/?p=3Dfs/lustre-release.git;f=3Dldiskfs/kernel_pa=
tches/patches/rhel8/ext4-pdirop.patch;hb=3DHEAD
>=20
> This URL gives me =
git://git.whamcloud.com/fs/lustre-release.git/summary,
> am I missing something?

Just walk down the tree for the "f=3Dldiskfs/..." pathname...


Cheers, Andreas






--Apple-Mail=_D0697059-1FC1-40CA-9626-39043366B48C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3oURAACgkQcqXauRfM
H+BGjA//aKtPVyYUXuoYzd2v6YYF5Qa9HLnQMbdiCMTzHWE1sKsfZ1cydSR6v4Bt
MXMmnLHmHHoQsKkQ4TztCik13YmekmSHFnj+THNWKqYhcyq2AuPyftpbWXWZjuWB
HgxzMC0Mmz0gXlK7UPwd1DDCLBn8sasp5eeBl3esWmHq88qcmXss8YuR40nLeKkC
X4wycj7A/uGH8L5++jSmqBCcR6mHbM8f+vp0llpP9mr1U5tjvki/0Rk/1ngTRRLM
DiAfcwBLtmi7Tqzi8Q9Nw97CwZCrGl/Q9zqPlTxdPQ4il/aT45UD2KlA6x5q1kY/
gyIUUojXIc4eIDOE5oNmVDsEBZMncI/psS9l0Z7NCMbGSA91ylCMgH5bvzvJjBHH
tULJbRAAKOSVJZ8EHnx5KBnLhInz026ELoZn8zjaWUg+0c6fEIi9Y3Z5SvkZnvOJ
43j/SOIRSdaFKywHuTxvVI4llt4j8VszXRGmDM1tlswdYJB23aSRboJ8MFcA7blP
c8bLKsgzsdCtBkLYKTl6sxnBxeksq5/7AEWqqLgvliYwr+Zi5CLDOLKTPcD7X7sQ
++7yW/ahZJtgDeuUShlffU5PpZGqiLharxdpFlzGD8RjOvb9piWq8QW/PLzlhZ31
8/MyNWQ8Zv7+l0RzS9VcvoVk/R8vtJtZKL+T9tF7kD6aU/PSKJY=
=Kq/v
-----END PGP SIGNATURE-----

--Apple-Mail=_D0697059-1FC1-40CA-9626-39043366B48C--
