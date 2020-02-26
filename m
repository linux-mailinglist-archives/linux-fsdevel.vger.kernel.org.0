Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02132170ADD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 22:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBZVvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 16:51:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44056 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBZVvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:51:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id a14so300298pgb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7ldHABlBD18zLPYrSu+cdH4KI93P+mg6f36otJlbi3M=;
        b=BbODRCYf3qUCVc0FwRNhp0e9kHNKBcNi5nDzE6bM+LY9S5XKEQEW3DREWeM4ysZZ/t
         8XbLYXnyYeVYbkp84Whzykfb6mD4JzwsjfxIRiEO5Dm8fKoY6z96HrGrWVDqIVuYDyHp
         CJnuggS/T1OZrWHZpq7mPoFf8OYEaVX7TIhqcqt8fmJneCpBkLwWTgosUk3NP/ePs87T
         6M6z3w/i6QqhqLLLV4BlVs6Z18GQKWhVRz+2yRnzkAb28fJYBZi+CvlxsSfBEJxYRz/y
         i8RcaNC+QvbYo+KO0kPfNa1Uzmm7AAcsVsXM9x9VJZOp8aG/2KzENFU5DQWincHbnLnG
         YHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7ldHABlBD18zLPYrSu+cdH4KI93P+mg6f36otJlbi3M=;
        b=ge46fGCBH+3X6gvJ2e73vy7zhB5qQtUCyTMoQDqP6WjO+ZV9bdSuQhz0IgBHsMiw6z
         O9uLFjOzaPE9o9zzfDm9dtZESR6gdFiOu5ZvleS6QCFIzvPoW153gkVWRZsZn2V66tK4
         UEtD4UDj3i7cpadiLJVFa2+RU/Hqh8uCdn9b8NlljfaK8p9W841q9U69w3b7JQ20T3ud
         XdLKgA58+KCjQvK5kXCIC9iusmBvoC8Ltfh/4D6aQG2hH95Z4AuNgUZquDMBWd/Ir3gY
         CrK5Fq/YRo+wK9uliDR1mtppbTZqFIwz0+3Az9/qGnxzkRBwOFcGPnuqeUbSTBGzo0+b
         0ySg==
X-Gm-Message-State: APjAAAXNU08P9CHhO0nJT7EEL0wTJoqDxXZdLcKlDAjbZcLIHLcWT9Im
        Ll7Crpzxj5oV7pTtw0pEE//Cgg==
X-Google-Smtp-Source: APXvYqxT1yiTPqoDhXgDTKgD5sJZm7rxtcjb/lfNHBR6wzTwindN+HTCBjfYXZwQ/t5YHcxlhoabRQ==
X-Received: by 2002:a62:e112:: with SMTP id q18mr762213pfh.88.1582753883078;
        Wed, 26 Feb 2020 13:51:23 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h7sm4371553pfq.36.2020.02.26.13.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 13:51:22 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A57E33D1-3D54-405A-8300-13F117DC4633@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D480D5B9-1B56-445A-98C9-E11CD8F90398";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
Date:   Wed, 26 Feb 2020 14:51:18 -0700
In-Reply-To: <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Snitzer <snitzer@redhat.com>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, riteshh@linux.ibm.com,
        krisman@collabora.com, surajjs@amazon.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, Eric Whitney <enwlinux@gmail.com>,
        sblbir@amazon.com, Khazhismel Kumykov <khazhy@google.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D480D5B9-1B56-445A-98C9-E11CD8F90398
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 26, 2020, at 1:05 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>=20
> On 26.02.2020 18:55, Christoph Hellwig wrote:
>> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
>>> This adds a support of physical hint for fallocate2() syscall.
>>> In case of @physical argument is set for ext4_fallocate(),
>>> we try to allocate blocks only from [@phisical, @physical + len]
>>> range, while other blocks are not used.
>>=20
>> Sorry, but this is a complete bullshit interface.  Userspace has
>> absolutely no business even thinking of physical placement.  If you
>> want to align allocations to physical block granularity boundaries
>> that is the file systems job, not the applications job.
>=20
> Why? There are two contradictory actions that filesystem can't do at =
the same time:
>=20
> 1)place files on a distance from each other to minimize number of =
extents
>  on possible future growth;
> 2)place small files in the same big block of block device.
>=20
> At initial allocation time you never know, which file will stop grow =
in some
> future, i.e. which file is suitable for compaction. This knowledge =
becomes
> available some time later.  Say, if a file has not been changed for a =
month,
> it is suitable for compaction with another files like it.
>=20
> If at allocation time you can determine a file, which won't grow in =
the future,
> don't be afraid, and just share your algorithm here.

Very few files grow after they are initially written/closed.  Those that
do are almost always opened with O_APPEND (e.g. log files).  It would be
reasonable to have O_APPEND cause the filesystem to reserve blocks (in
memory at least, maybe some small amount on disk like 1/4 of the current
file size) for the file to grow after it is closed.  We might use the
same heuristic for directories that grow long after initial creation.

The main exception there is VM images, because they are not really =
"files"
in the normal sense, but containers aggregating a lot of different =
files,
each created with patterns that are not visible to the VM host.  In that
case, it would be better to have the VM host tell the filesystem that =
the
IO pattern is "random" and not try to optimize until the VM is cold.

> In Virtuozzo we tried to compact ext4 with existing kernel interface:
>=20
> https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
>=20
> But it does not work well in many situations, and the main problem is =
blocks allocation in desired place is not possible. Block allocator =
can't behave
> excellent for everything.
>=20
> If this interface bad, can you suggest another interface to make block
> allocator to know the behavior expected from him in this specific =
case?

In ext4 there is already the "group" allocator, which combines multiple
small files together into a single preallocation group, so that the IO
to disk is large/contiguous.  The theory is that files written at the
same time will have similar lifespans, but that isn't always true.

If the files are large and still being written, the allocator will =
reserve
additional blocks (default 8MB I think) on the expectation that it will
continue to write until it is closed.

I think (correct me if I'm wrong) that your issue is with defragmenting
small files to free up contiguous space in the filesystem?  I think once
the free space is freed of small files that defragmenting large files is
easily done.  Anything with more than 8-16MB extents will max out most
storage anyway (seek rate * IO size).

In that case, an interesting userspace interface would be an array of
inode numbers (64-bit please) that should be packed together densely in
the order they are provided (maybe a flag for that).  That allows the
filesystem the freedom to find the physical blocks for the allocation,
while userspace can tell which files are related to each other.

Tools like "readahead" could also leverage this to "perfectly" allocate
the files used during boot into a single stream of reads from the disk.

Cheers, Andreas






--Apple-Mail=_D480D5B9-1B56-445A-98C9-E11CD8F90398
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5W6FYACgkQcqXauRfM
H+ARrg/+M8YUY/LsY7U43iojx1GZazLqDMONgBDBXLFLlo9tfab/kekT78JLeRHt
0gesFe8j9TIJ1aOv/Cqss+yyvzXvryXbAuk8rIcGNbixf83YQ4J0hN7Z07unb5PH
6Og5VRhI/BuqXWVezvqY//FrKq+vZ1cZ6wIQPSJKFqa2W28DtqsRm2pY/Z9uhd1x
CHTDPAFX7PHasI+76obGjbF2eNNMo9OTTODOseDWQer7lUkF2YO0IKi4diDCBoli
FKVfzYt7lxi6Kz1qjsewPnFLAAp+paY1qIRTU9NCm1T2rUIjSg8j/XKc967NBNZY
/ZFlWu6RCp3WcohZmMX6tZTPyhk5Ua/Y2cu5fuOhxxag+vvcokR8OzOe6ikVzyyq
Jbs8mw8fdtUUJ9QLkUTtSnFpwKHN/uriGM1gzbtm8iN5sJI0mo5aDqHkwItMu7kp
8+sHFqcSRlAQHzyAfz44bt6tyFyYSqMUwWOukOrnyDKNHIrNerZVKiM+4VPRdXkP
zmboMuMpqFrsB4GdlRUWK8l4zSFXKSAlHYrpLdj3muCyzXqhtsG9fKbsFgEox7Yx
AazQeV4PSTUuxQenRgNQidLRKNY+gGj09+jJsxk3u2T80gjX3Hd6FR9Scevu2nbe
yvkZNBL2udbidu8lZYczpkcJ5RGoPMErC2ccwtx8dWKTMD84XAg=
=L/2m
-----END PGP SIGNATURE-----

--Apple-Mail=_D480D5B9-1B56-445A-98C9-E11CD8F90398--
