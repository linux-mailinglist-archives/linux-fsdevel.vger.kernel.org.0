Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0952917491A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 21:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgB2UM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 15:12:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35556 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgB2UM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:12:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2606364plt.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Feb 2020 12:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0G4OUp8C4Ql/B1PTKhqRXXsr2EA2E7yf/lAnvlcFoiI=;
        b=r7EXfM5jDZUHCTHSEoKMH49CUhBE27hnSQQfOZpsuoxVpMy0qD05f7M49I4XOYLAaz
         PLxlMPX5L1MKabAF/t2ovlm82r4Nuq5scgbGO6vQfAR1ujFzH8ZxGtyukSYQgRvHrZUD
         vlEMRDw0OfkUT2xA26YVCN7clwyWnXycDTR5Z7RfTCX4BxbOcd5dqWvi9UqzpkT+lcYU
         uRL1tOH2bDUGLh6N422Q2/y9Or3Ce9zlWv+SReSlRP9Axc0tAQ7XhyoIQkT1Nz0Pc5Ds
         TuTksO7gKtY/pIxHj1QU3EuLIYmz0Qnq9pRYgCKSniVhB5WPk8Hs6infNE59lT82vz2Z
         esqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0G4OUp8C4Ql/B1PTKhqRXXsr2EA2E7yf/lAnvlcFoiI=;
        b=ChMp8+Qulg8CI+up3NoK5FwaNCwhnkw6Ouc2BX4zt2MvOeNW9+c23bxxoud/DqEBp6
         DOkHz/oram52Erb6ZbIFwQ8xsddXNdAMDCBFGGOyhDql2dBTnjbKuMs5u4Au1yW/iNKq
         wAaZ9Fh/OlRGCw0vYhw+IyjTfwzEqaVXMCxJXlY78zu3MwLFRGBVFBzjN+CO6pTE5F+A
         lL+rxV9vpdx9+XPmJWmbinoYTL8k7TrSpwt1a4Dw+jsKv1ugRwW2O0qA0LeCFbjefDOs
         ettjw4+k8+IU7cJZ43f8NEOMqT9LvthKuXyuQxRYbC5CBP0drvc+hQvVtcIVwLNJgdrE
         jouQ==
X-Gm-Message-State: APjAAAUtQOATiN80g91pUXF12VcOXf2uET2kaZSfsiTLXjzCDdJMc6Ic
        B3YQIXk/oi3ANvNrG4+pwTecWQ==
X-Google-Smtp-Source: APXvYqxff7tvINHICD/n4zqu2Ch1Mjo4Yf2ZnTbxn4PSHwFGNKZnYz4QOnC70GwR0rQwOuhXQFuLWA==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20mr10526775plp.6.1583007177660;
        Sat, 29 Feb 2020 12:12:57 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id l8sm6763724pjy.24.2020.02.29.12.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Feb 2020 12:12:56 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F2CA6010-F7E5-4891-A337-FA1FEB32B935@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_62B17B5E-9866-4EB5-96FE-CA8E93030FD2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
Date:   Sat, 29 Feb 2020 13:12:52 -0700
In-Reply-To: <20200228211610.GQ10737@dread.disaster.area>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christoph Hellwig <hch@infradead.org>,
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
To:     Dave Chinner <david@fromorbit.com>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
 <A57E33D1-3D54-405A-8300-13F117DC4633@dilger.ca>
 <eda406cc-8ce3-e67a-37be-3e525b58d5a1@virtuozzo.com>
 <4933D88C-2A2D-4ACA-823E-BDFEE0CE143F@dilger.ca>
 <20200228211610.GQ10737@dread.disaster.area>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_62B17B5E-9866-4EB5-96FE-CA8E93030FD2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 28, 2020, at 2:16 PM, Dave Chinner <david@fromorbit.com> wrote:
> 
> On Fri, Feb 28, 2020 at 08:35:19AM -0700, Andreas Dilger wrote:
>> On Feb 27, 2020, at 5:24 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>> 
>>> So, this interface is 3-in-1:
>>> 
>>> 1)finds a placement for inodes extents;
>> 
>> The target allocation size would be sum(size of inodes), which should
>> be relatively small in your case).
>> 
>>> 2)assigns this space to some temporary donor inode;
>> 
>> Maybe yes, or just reserves that space from being allocated by anyone.
>> 
>>> 3)calls ext4_move_extents() for each of them.
>> 
>> ... using the target space that was reserved earlier
>> 
>>> Do I understand you right?
>> 
>> Correct.  That is my "5 minutes thinking about an interface for grouping
>> small files together without exposing kernel internals" proposal for this.
> 
> You don't need any special kernel interface with XFS for this. It is
> simply:
> 
> 	mkdir tmpdir
> 	create O_TMPFILEs in tmpdir
> 
> Now all the tmpfiles you create and their data will be co-located
> around the location of the tmpdir inode. This is the natural
> placement policy of the filesystem. i..e the filesystem assumes that
> files in the same directory are all related, so will be accessed
> together and so should be located in relatively close proximity to
> each other.

Sure, this will likely get inodes allocate _close_ to each other on
ext4 as well (the new directory will preferentially be located in a
group that has free space), but it doesn't necessarily result in
all of the files being packed densely.  For 1MB+4KB and 1MB-4KB files
they will still prefer to be aligned on 1MB boundaries rather than
packed together.

>>> Can we introduce a flag, that some of inode is unmovable?
>> 
>> There are very few flags left in the ext4_inode->i_flags for use.
>> You could use "IMMUTABLE" or "APPEND_ONLY" to mean that, but they
>> also have other semantics.  The EXT4_NOTAIL_FL is for not merging the
>> tail of a file, but ext4 doesn't have tails (that was in Reiserfs),
>> so we might consider it a generic "do not merge" flag if set?
> 
> Indeed, thanks to XFS, ext4 already has an interface that can be
> used to set/clear a "no defrag" flag such as you are asking for.
> It's the FS_XFLAG_NODEFRAG bit in the FS_IOC_FS[GS]ETXATTR ioctl.
> In XFS, that manages the XFS_DIFLAG_NODEFRAG on-disk inode flag,
> and it has special meaning for directories. From the 'man 3 xfsctl'
> man page where this interface came from:
> 
>      Bit 13 (0x2000) - XFS_XFLAG_NODEFRAG
> 	No defragment file bit - the file should be skipped during a
> 	defragmentation operation. When applied to  a directory,
> 	new files and directories created will inherit the no-defrag
> 	bit.

The interface is not the limiting factor here, but rather the number
of flags available in the inode.  Since chattr/lsattr from e2fsprogs
was used as "common ground" for a few years, there are a number of
flags in the namespace that don't actually have any meaning for ext4.

One of those flags is:

#define EXT4_NOTAIL_FL    0x00008000 /* file tail should not be merged */

This was added for Reiserfs, but it is not used by any other filesystem,
so generalizing it slightly to mean "no migrate" is reasonable.  That
doesn't affect Reiserfs in any way, and it would still be possible to
also wire up the XFS_XFLAG_NODEFRAG bit to be stored as that flag.

It wouldn't be any issue at all to chose an arbitrary unused flag to
store this in ext4 inode internally, except that chattr/lsattr are used
by a variety of different filesystems, so whatever flag is chosen will
immediately also apply to any other filesystem that users use those
tools on.

Cheers, Andreas






--Apple-Mail=_62B17B5E-9866-4EB5-96FE-CA8E93030FD2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIyBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5axcQACgkQcqXauRfM
H+BrEw/4/xX6/kAej+OjkMhA17Rp8GyQjqkGTwu4jrUcDGCjtl8uPxDAt3zZuXPF
KducnBKDK4eFnBHBMVelWFYL0EjD5qON3aPjth+Zn+SjgPVtpuPHBAFhwNuLt4KT
EGsvqABmyxZE0pTtfAcx5z54JaU99+9B/XB8iPN3is8gLvnEjo8v6RPOC4t8SyHz
e0hnJoRdv/mikO53be3L4kt+k1mSthu+1jqEwT9t3uHVqtpDZYVdFaMirYmCRsId
wabocrWrqoxCbOXeMTQtuUmZL/pTD7hWxKpUdpmBSqSaFA7mbxt/9VpxZbLGD03f
/SDcGlKSUj5j6NzVD3IwiIluJ4LROf4F+jIq8dtWHLk7QenMAnZK7H6Y+pGOr5K8
SN+YkjaSgqC3aAs3wTuOe49duET5zc3k7nF+uaJO/zAI5rwtXsAg7u1mBjYnaUgQ
criV7ldi5m4nkN4iAPgAOhndn+dyW210nZRALd0bhH22JPgt+LLQZ1fueED2RbZa
I1+Tplu9kQBU0mYsrosQROsiGNdoKzhDwrwngOKHGTwAefMMO8yPW7N9kkFV5VLc
MjOEpq/u6II2oVbzy2xtPibhCo4G1hQgU3sEzeoh9J/UsWZ6lwlEYXEt+77ajZWW
RsZ+BnYWK1Ajx3OWqYGubarK3WjSDwQxxGqeig9SdHjs4JiJWA==
=woXX
-----END PGP SIGNATURE-----

--Apple-Mail=_62B17B5E-9866-4EB5-96FE-CA8E93030FD2--
