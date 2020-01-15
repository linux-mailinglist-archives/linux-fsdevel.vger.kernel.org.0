Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 076B113CD6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 20:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgAOTsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 14:48:50 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:50899 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgAOTst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:48:49 -0500
Received: by mail-pj1-f54.google.com with SMTP id r67so392859pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mfOcggh9Ij5VrzzcP3dcYGzGv0U+3av4+wN4xCGn2hk=;
        b=M2G/cnOwd/oFmzBASlg+3RqBtFzOPZybUgUGoE9A1sLNkSCuwWLyFz2lW64IfdFsna
         9AQlZom4Ba5CyPqMjBQA9C8+RfYOs4T01nBk8B65/Bw+x9sEBjnQ6K0vJV9mxZ9obt45
         Ne9RJHAP1nLs32+Jb691Ph6cfKzWcmSk+Aa6QPjwHLTNctgothN38yQaunuF4KymMEEf
         DtYQauwDrpMgfCwd8NNFuICuDQ+/l5cBD996TlyR071ifvOazmG94Wv9lYxbWzb2YNI+
         VUka4MMOF1pRwsSud1zk7CK7oRnQ801uD42ZPcimYEJn/+pvVwX2TMKJ0gSq72E7NiKn
         8rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mfOcggh9Ij5VrzzcP3dcYGzGv0U+3av4+wN4xCGn2hk=;
        b=lXBvUOS/zWaS0rPRwzoee9Q515ZRy9AoW11IlNyN5ZinUJrdW/8Kb64/VpCydE4kIU
         EaqRJLN4QEnfS9dK1Dvo4bsczft64TLhpCTAgwtPMOkYQ3ePoIo9ikXwy4mhPfQmbXQh
         UQFyfJEGjJtNzn2PywaW5dZWUAOWNR/qHBvapQaS2YbwEEKjAZcwnfZqe4KKTgL8Xqqz
         krglixviYxr/JvU/aodOQJLre3mG2sBMnfXyU+Up+KNPPJDpvzs62oQQ6zw3b3TmN8qr
         6B6jyv8M79xYoG7FRadtx3nwt5QZENKjJQvsX1DnblhShBurXW3aqDVnqbQZNcuYitXB
         NvGg==
X-Gm-Message-State: APjAAAUTDoA/Vje/06Pm2rEe5JS/SJskck5C1ZSgTdvVKqW7671tAKLn
        B1TRGD4PM4bOjt7TfL7Gt0mUdg==
X-Google-Smtp-Source: APXvYqxP6WhNjxkfuE0g6khT7UyihhalBizsQoBp9O693hV+s+j7MHh19YyDAax8jCcjC9KTJ2bxsQ==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr1882398pjr.100.1579117728439;
        Wed, 15 Jan 2020 11:48:48 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id g67sm23485209pfb.66.2020.01.15.11.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:48:47 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CC498D30-739D-4ED3-A222-2F501C8D578D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Problems with determining data presence by examining extents?
Date:   Wed, 15 Jan 2020 12:48:44 -0700
In-Reply-To: <20200115133101.GA28583@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <4467.1579020509@warthog.procyon.org.uk>
 <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
 <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca>
 <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com>
 <20200115133101.GA28583@lst.de>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_CC498D30-739D-4ED3-A222-2F501C8D578D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 15, 2020, at 6:31 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Wed, Jan 15, 2020 at 09:10:44PM +0800, Qu Wenruo wrote:
>>> That allows userspace to distinguish fe_physical addresses that may be
>>> on different devices.  This isn't in the kernel yet, since it is mostly
>>> useful only for Btrfs and nobody has implemented it there.  I can give
>>> you details if working on this for Btrfs is of interest to you.
>> 
>> IMHO it's not good enough.
>> 
>> The concern is, one extent can exist on multiple devices (mirrors for
>> RAID1/RAID10/RAID1C2/RAID1C3, or stripes for RAID5/6).
>> I didn't see how it can be easily implemented even with extra fields.
>> 
>> And even we implement it, it can be too complex or bug prune to fill
>> per-device info.
> 
> It's also completely bogus for the use cases to start with.  fiemap
> is a debug tool reporting the file system layout.  Using it for anything
> related to actual data storage and data integrity is a receipe for
> disaster.  As said the right thing for the use case would be something
> like the NFS READ_PLUS operation.  If we can't get that easily it can
> be emulated using lseek SEEK_DATA / SEEK_HOLE assuming no other thread
> could be writing to the file, or the raciness doesn't matter.

I don't think either of those will be any better than FIEMAP, if the reason
is that the underlying filesystem is filling in holes with actual data
blocks to optimize the IO pattern.  SEEK_HOLE would not find a hole in
the block allocation, and would happily return the block of zeroes to
the caller.  Also, it isn't clear if SEEK_HOLE considers an allocated but
unwritten extent to be a hole or a block?

I think what is needed here is an fadvise/ioctl that tells the filesystem
"don't allocate blocks unless actually written" for that file.  Storing
anything in a separate data structure is a recipe for disaster, since it
will become inconsistent after a crash, or filesystem corruption+e2fsck,
and will unnecessarily bloat the on-disk metadata for every file to hold
redundant information.

I don't see COW/reflink/compression as being a problem in this case, since
what cachefiles cares about is whether there is _any_ data for a given
logical offset, not where/how the data is stored.  IF FIEMAP was used for
a btrfs backing filesystem, it would need the "EXTENT_DATA_COMPRESSED"
feature to be implemented as well, so that it can distinguish the logical
vs. physical allocations.  I don't think that would be needed for SEEK_HOLE
and SEEK_DATA, so long as they handle unwritten extents properly (and are
correctly implemented in the first place, some filesystems fall back to
always returning the next block for SEEK_DATA).

Cheers, Andreas






--Apple-Mail=_CC498D30-739D-4ED3-A222-2F501C8D578D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4fbJ0ACgkQcqXauRfM
H+CGqw//clrcdoV9kWx8edXSbVsdv8WiQjBERU0J4tkQgIcsIPB4/w1kWk/qsk56
Cew1K8m6uWzKmrOb9pOdDUQeSVMiqoCEFJKabnEu17miBjRBeQofftQazJ66VCDt
jTpqDmTIJlX6GPHmJQf52V+YMzRqdZhWPBwU2DOiLzXktvPt8zLJdUQLhvHv5xom
rKXBFqi3ZKW8MAtVN4xdwMCpgqzqgwE/ZEciZkIQmkt71eo2+mqg5DxYGDjBbV8r
u/KQm0mkh1otrCgskTUcb7mhnf52uWkpZQZTtBD246ShTvnuU0MaCSqv3HhLHVo+
p5/q5S3oFE67Odc/Tj3vFW0N2R5uX0o20tGr4TFoRl5enngiCM2OTg3Pqh2fq8vc
hrOw8SARGuhCq5QNOyydtpQ1YO1QTT6TTxVJTxXEkkxWyexPBtufupKUCRVhTkC2
nfh704xUn137Gcr5Rk8p2io54s8kKnLUE5sVGU44TrD0voG6f8OD/eI1vr7XWLIw
5pNtxLfFLe0LNFX5+5M0FfmJxuXyVqzUT5co79d3AHVwjN0/LYmuN+ICgWomBy34
fm2S4mdW1SyLCK8T3LVXX5/JFpK+e0jzQ8DFUhumUzES+q0uMRSdDQjxRX5asdX2
z3CT+qbgnMElZuf+JaARqPC/tV8z+FlawJv/xgVq7eXpmILQjA0=
=1vdd
-----END PGP SIGNATURE-----

--Apple-Mail=_CC498D30-739D-4ED3-A222-2F501C8D578D--
