Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4192C173B80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgB1Pf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:35:27 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52207 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgB1Pf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:35:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so1446355pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 07:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=iX5F5lJMUCIZ1azF1Y5deZ3wOf2c/KQPCaXwYWddcD0=;
        b=r2MD4oS/IojqKiPSBeATC3Jl2RXYlEY+r3x9vQjRWsS3OWW1I9JamhLyBmAG1/n8ys
         p3boJF8xLG29SNUlIzqh1iA9oHAmB2QJvJvYUtOBYYzx2tfPo6+9b363FRpne3pKtQ2I
         yb3na7P4clZiq3eXJRmlNOxshYPuMTKyuitmLhx/dkbeiMpse+1McC/AyEqN1ojMID0R
         76/I/fToPlt6U0G+p5OzqQydWbxH6MqSredMJSf/YRtJS5Q8kb39nJIgMnB7+IT3qBwz
         jBC5qot68cco7cKLmCqjD5iqLYVmAoYnbPIlLzGb9zLqAKYW2/q0A2KJSLiPtgcjAMfi
         Cwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=iX5F5lJMUCIZ1azF1Y5deZ3wOf2c/KQPCaXwYWddcD0=;
        b=WgqlKD7II1kJHWmkOWDDuMbOvcwp49dIg+ZgHNhi1CvqYPkh1+UIV+ZyvpfvOEDDYt
         ZfWJ/3+S8unfD2TXogcSk//RODJfbE7T1lAtyI5RTLv7fejIwhEMoYQ8k6BLROFCpkCd
         8lo4F21p7J50eGBvV9+67ekGeLAiHZQzeIYl43J3iqJSjUF5qY5WY08/EpoOr5vi4T/I
         cBG1B8i9DsZ3UFVoFGPfJkb5Fk8zYe48sB++ZdizLVjW7u77EpJnPGKXDnEKo9HONfwt
         qnQclcMJfQiC3XDdqnVF74O3HOCvt5UfiDM+9FapyGzKZhlRCVgrOvZkCetuvkfsg6u9
         SpZw==
X-Gm-Message-State: APjAAAUQa+/W730PMVwMGVZOjABwR6Idj5ePDuZzfgP+NJ13pyoOsS4I
        stCKl1qkQBxHzuvY1kOCg4kBwQ==
X-Google-Smtp-Source: APXvYqzMkJZWj6r/RxIH5j9deD1iCAqIaL4TE/l9Mbqj71zodIZ2sMe/SvXQxqIGRD0GF/xOZ33+MQ==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr4675937plo.83.1582904125657;
        Fri, 28 Feb 2020 07:35:25 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u126sm11355355pfu.182.2020.02.28.07.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 07:35:24 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4933D88C-2A2D-4ACA-823E-BDFEE0CE143F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1EFD12AF-482B-48B2-A315-3723BD27736A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
Date:   Fri, 28 Feb 2020 08:35:19 -0700
In-Reply-To: <eda406cc-8ce3-e67a-37be-3e525b58d5a1@virtuozzo.com>
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
 <A57E33D1-3D54-405A-8300-13F117DC4633@dilger.ca>
 <eda406cc-8ce3-e67a-37be-3e525b58d5a1@virtuozzo.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_1EFD12AF-482B-48B2-A315-3723BD27736A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 27, 2020, at 5:24 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>=20
> On 27.02.2020 00:51, Andreas Dilger wrote:
>> On Feb 26, 2020, at 1:05 PM, Kirill Tkhai <ktkhai@virtuozzo.com> =
wrote:
>>> Why? There are two contradictory actions that filesystem can't do at =
the same time:
>>>=20
>>> 1)place files on a distance from each other to minimize number of =
extents
>>> on possible future growth;
>>> 2)place small files in the same big block of block device.
>>>=20
>>> At initial allocation time you never know, which file will stop grow =
in some
>>> future, i.e. which file is suitable for compaction. This knowledge =
becomes
>>> available some time later.  Say, if a file has not been changed for =
a month,
>>> it is suitable for compaction with another files like it.
>>>=20
>>> If at allocation time you can determine a file, which won't grow in =
the future,
>>> don't be afraid, and just share your algorithm here.
>>=20
>> Very few files grow after they are initially written/closed.  Those =
that
>> do are almost always opened with O_APPEND (e.g. log files).  It would =
be
>> reasonable to have O_APPEND cause the filesystem to reserve blocks =
(in
>> memory at least, maybe some small amount on disk like 1/4 of the =
current
>> file size) for the file to grow after it is closed.  We might use the
>> same heuristic for directories that grow long after initial creation.
>=20
> 1)Lets see on a real example. I created a new ext4 and started the =
test below:
> https://gist.github.com/tkhai/afd8458c0a3cc082a1230370c7d89c99
>=20
> Here are two files written. One file is 4Kb. One file is 1Mb-4Kb.
>=20
> $filefrag -e test1.tmp test2.tmp
> Filesystem type is: ef53
> File size of test1.tmp is 4096 (1 block of 4096 bytes)
> ext:     logical_offset:        physical_offset: length:   expected: =
flags:
>   0:        0..       0:      33793..     33793:      1:             =
last,eof
> test1.tmp: 1 extent found
> File size of test2.tmp is 1044480 (255 blocks of 4096 bytes)
> ext:     logical_offset:        physical_offset: length:   expected: =
flags:
>   0:        0..     254:      33536..     33790:    255:             =
last,eof
> test2.tmp: 1 extent found

The alignment of blocks in the filesystem is much easier to see if you =
use
"filefrag -e -x ..." to print the values in hex.  In this case, 33536 =3D =
0x8300
so it is properly aligned on disk IMHO.

> $debugfs:  testb 33791
> Block 33791 not in use
>=20
> test2.tmp started from 131Mb. In case of discard granuality is 1Mb, =
test1.tmp
> placement prevents us from discarding next 1Mb block.

For most filesystem uses, aligning the almost 1MB file on a 1MB boundary
is good.  That allows a full-stripe read/write for RAID, and is more
likely to align with the erase block for flash.  If it were to be =
allocated
after the 4KB block, then it may be that each 1MB-aligned read/write of =
a
large file would need to read/write two unaligned chunks per syscall.

> 2)Another example. Let write two files: 1Mb-4Kb and 1Mb+4Kb:
>=20
> # filefrag -e test3.tmp test4.tmp
> Filesystem type is: ef53
> File size of test3.tmp is 1052672 (257 blocks of 4096 bytes)
> ext:     logical_offset:        physical_offset: length:   expected: =
flags:
>   0:        0..     256:      35840..     36096:    257:             =
last,eof
> test3.tmp: 1 extent found
> File size of test4.tmp is 1044480 (255 blocks of 4096 bytes)
> ext:     logical_offset:        physical_offset: length:   expected: =
flags:
>   0:        0..     254:      35072..     35326:    255:             =
last,eof
> test4.tmp: 1 extent found

Here again, "filefrag -e -x" would be helpful.  35840 =3D 0x8c00, and
35072 =3D 0x8900, so IMHO they are allocated properly for most uses.
Packing all files together sequentially on disk is what FAT did and
it always got very fragmented in the end.

> They don't go sequentially, and here is fragmentation starts.
>=20
> After both the tests:
> $df -h
> /dev/loop0      2.0G   11M  1.8G   1% /root/mnt
>=20
> Filesystem is free, all last block groups are free. E.g.,
>=20
> Group 15: (Blocks 491520-524287) csum 0x3ef5 [INODE_UNINIT, =
ITABLE_ZEROED]
>  Block bitmap at 272 (bg #0 + 272), csum 0xd52c1f66
>  Inode bitmap at 288 (bg #0 + 288), csum 0x00000000
>  Inode table at 7969-8480 (bg #0 + 7969)
>  32768 free blocks, 8192 free inodes, 0 directories, 8192 unused =
inodes
>  Free blocks: 491520-524287
>  Free inodes: 122881-131072
>=20
> but two files are not packed together.
>=20
> So, ext4 block allocator does not work good for my workload. It even =
does not
> know anything about discard granuality of underlining block device. =
Does it?
> I assume no fs knows. Should I tell it?

You can tune the alignment of allocations via s_raid_stripe and =
s_raid_stride
in the ext4 superblock.  I believe these are also set by mke2fs by =
libdisk,
but I don't know if it takes flash erase block geometry into account.

>> The main exception there is VM images, because they are not really =
"files"
>> in the normal sense, but containers aggregating a lot of different =
files,
>> each created with patterns that are not visible to the VM host.  In =
that
>> case, it would be better to have the VM host tell the filesystem that =
the
>> IO pattern is "random" and not try to optimize until the VM is cold.
>>=20
>>> In Virtuozzo we tried to compact ext4 with existing kernel =
interface:
>>>=20
>>> =
https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
>>>=20
>>> But it does not work well in many situations, and the main problem =
is blocks allocation in desired place is not possible. Block allocator =
can't behave
>>> excellent for everything.
>>>=20
>>> If this interface bad, can you suggest another interface to make =
block
>>> allocator to know the behavior expected from him in this specific =
case?
>>=20
>> In ext4 there is already the "group" allocator, which combines =
multiple
>> small files together into a single preallocation group, so that the =
IO
>> to disk is large/contiguous.  The theory is that files written at the
>> same time will have similar lifespans, but that isn't always true.
>>=20
>> If the files are large and still being written, the allocator will =
reserve
>> additional blocks (default 8MB I think) on the expectation that it =
will
>> continue to write until it is closed.
>>=20
>> I think (correct me if I'm wrong) that your issue is with =
defragmenting
>> small files to free up contiguous space in the filesystem?  I think =
once
>> the free space is freed of small files that defragmenting large files =
is
>> easily done.  Anything with more than 8-16MB extents will max out =
most
>> storage anyway (seek rate * IO size).
>=20
> My issue is mostly with files < 1Mb, because underlining device =
discard
> granuality is 1Mb. The result of fragmentation is that size of =
occupied
> 1Mb blocks of device is 1.5 times bigger, than size of really written
> data (say, df -h). And this is the problem.


Sure, and the group allocator will aggregate writes << prealloc size of
8MB by default.  If it is 1MB that doesn't qualify for group prealloc.
I think under 64KB does qualify for aggregation and unaligned writes.

>> In that case, an interesting userspace interface would be an array of
>> inode numbers (64-bit please) that should be packed together densely =
in
>> the order they are provided (maybe a flag for that).  That allows the
>> filesystem the freedom to find the physical blocks for the =
allocation,
>> while userspace can tell which files are related to each other.
>=20
> So, this interface is 3-in-1:
>=20
> 1)finds a placement for inodes extents;

The target allocation size would be sum(size of inodes), which should
be relatively small in your case).

> 2)assigns this space to some temporary donor inode;

Maybe yes, or just reserves that space from being allocated by anyone.

> 3)calls ext4_move_extents() for each of them.

... using the target space that was reserved earlier

> Do I understand you right?

Correct.  That is my "5 minutes thinking about an interface for grouping
small files together without exposing kernel internals" proposal for =
this.

> If so, then IMO it's good to start from two inodes, because here may =
code
> a very difficult algorithm of placement of many inodes, which may =
require
> much memory. Is this OK?

Well, if the files are small then it won't be a lot of memory.  Even so,
the kernel would only need to copy a few MB at a time in order to get
any decent performance, so I don't think that is a huge problem to have
several MB of dirty data in flight.

> Can we introduce a flag, that some of inode is unmovable?

There are very few flags left in the ext4_inode->i_flags for use.
You could use "IMMUTABLE" or "APPEND_ONLY" to mean that, but they
also have other semantics.  The EXT4_NOTAIL_FL is for not merging the
tail of a file, but ext4 doesn't have tails (that was in Reiserfs),
so we might consider it a generic "do not merge" flag if set?

> Can this interface use a knowledge about underlining device discard =
granuality?

As I wrote above, ext4+mballoc has a very good appreciation for =
alignment.
That was written for RAID storage devices, but it doesn't matter what
the reason is.  It isn't clear if flash discard alignment is easily
used (it may not be a power-of-two value or similar), but wouldn't be
harmful to try.

> In the answer to Dave, I wrote a proposition to make fallocate() care =
about
> i_write_hint. Could you please comment what you think about that too?

I'm not against that.  How the two interact would need to be documented
first and discussed to see if that makes sene, and then implemented.

Cheers, Andreas






--Apple-Mail=_1EFD12AF-482B-48B2-A315-3723BD27736A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5ZMzgACgkQcqXauRfM
H+CMexAAn8DrnJpgsYug/ExfF6OCWLFgudsTjBjxycNTV9xpWmxBQTfQY9gydzqo
WTTy4v2ei+ziqyOcNv6I4zF8B8+BVnagMTOHrhTDRHnJvNeIfS4ImI37TlrJcrz2
DNq7eXg9Ht21lvKNaJ11Mz2Ktf8eR/gpNPMJlFLwaaVCjY/Rr0nfXygtgw1E0mqa
k/uEwclX339rsiLDR4HwEJpVa4FVEG6aYGm1izzVGsdYhgXQrC43pIGGGFTgpuPk
TmoLyguSwaO8DDM8yDpZfPcacrBJ1WZxEKBqhJxb/T3RaR7YlFozMoxzDxwFP+3Q
5vZJdse3FbqjTR+wlPIFEt67j/BiToiCIDBhiv32DuegXgsY/fh4cLvZUuHE9liR
gdVyHPblk13hnk4c+gy4D3sXUEMLN7wXI+osluOFyZiao/eGoK5pc7hDfPy23/z0
E8wDoEhzGjU/Ua/2VA6l4tipIybvfJugD9TUrd7mPCVYyUNgZiMjN2n98hGwkQG4
MQqvml/ozZlz687EAoDhcpmtTA502EyvzBIgNMKpdTBNSuT2E2lVHCyxLoiDTZsr
PvpbN6ycQsYuZjl8xhF2rrxRnaBfDZYnMVP+iff0qxf+lhBBF8c9YBsXuuTHquVP
Ed2SsFTzVrKwOEXTEerfWQ8qsSeEOsIoKB6aQH8JhxeoUEkC2qI=
=nAMv
-----END PGP SIGNATURE-----

--Apple-Mail=_1EFD12AF-482B-48B2-A315-3723BD27736A--
