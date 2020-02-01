Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB714FAED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 00:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBAXQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 18:16:17 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:52434 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgBAXQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 18:16:17 -0500
Received: by mail-pj1-f49.google.com with SMTP id ep11so4594535pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=iGWodyo7BE3SjtJqSzBK4M9PQhoTpRtuGVVx63VdcvE=;
        b=VG8VHgFW5Y8I1qQ+mKKmHk3CK1FeLilftSPodp/gAQLO7H0iMnXo/hbXzzW+1sBgCy
         FVFZJbW2QCXRlgfWq52EZyv8hyFKxVc7n0VUJSzxoGj6M0Ma3oBg8m+qb8v9DwzpC1t6
         dmK7lN+1vbf5qhYIMTy8ObDbZgfXaAI1SCI/gBHNGC6XQG6/ZWuKSSBrPUefrSvYszQZ
         zyCWCNDZn5eh9psagZ4lktWyeufza8klNNhqusERsju64VtmXzSxDL/TjlaX9lL62+1N
         lad3q8zuHBPNqmJ3WN0Ev/jLSE9OK/3/+q+Kr6aTOKtX3lqH7aN9HchPQuvDC+FRxgC4
         U6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=iGWodyo7BE3SjtJqSzBK4M9PQhoTpRtuGVVx63VdcvE=;
        b=ZJNqTqKM5BW2AEPT5nVhhJNUMYLv7erwLd3M11zmw2ePjFjhREJJaYyqmtsYi8WDlQ
         BgfEO57TIbcXxTREC0+THazLvk4pa+u+ZLjVVC7pg/pUuflYY496hIZNT+NZutVuUOPY
         nuh9fNIQfu4/g7MvyL+LTFJSylhzci11+PKb3+kfAWIHmqkZlk8tavL0OYnkHZhaFTXB
         Xs7GZIAOBMua70IDCizQkcWjkQj6ElNDlorQ6w2CTbNyoysMHlnaw7XN7mdQxk8A/dl6
         /bvWEdOc6qoaRoBf52SmjfroZ+jkJUKoiMe0OlT5zCksG+Ou2Y39otM8cweyqNsU/JEW
         BMcA==
X-Gm-Message-State: APjAAAXw/6weqYda48sCwoc3S1i4uR2e9dmw4u+nUz2dNaNyCGU1+Ojx
        pBIYweBtb4C1sIujMxjXkWQixQ==
X-Google-Smtp-Source: APXvYqzwWU/jmICW8I0Bs+kQESOAJUhqZqQrxBQZImpPgkzh/M14GEdRdgArFATUrqRq68VbajhSyA==
X-Received: by 2002:a17:902:8688:: with SMTP id g8mr16718690plo.277.1580598976077;
        Sat, 01 Feb 2020 15:16:16 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 136sm14221343pgg.74.2020.02.01.15.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Feb 2020 15:16:15 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <497E0258-F69E-4739-B9B5-B3DA92571A27@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_18888712-B94F-4C77-8A59-99C68A3C505C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [LSF/MM/BPF TOPIC] Enhancing Linux Copy Performance and Function
 and improving backup scenarios
Date:   Sat, 1 Feb 2020 16:16:11 -0700
In-Reply-To: <CAH2r5mv55Ua3B8WX1Qht1xfWL-k5pGJrN+Uz0L4jHtYOo9RMKw@mail.gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        lsf-pc@lists.linux-foundation.org
To:     Steve French <smfrench@gmail.com>
References: <CAH2r5mvYTimXUfJB+p0mvYV3jAR1u5G4F3m+OqA_5jKiLhVE8A@mail.gmail.com>
 <20200130015210.GB3673284@magnolia>
 <CAH2r5mv55Ua3B8WX1Qht1xfWL-k5pGJrN+Uz0L4jHtYOo9RMKw@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_18888712-B94F-4C77-8A59-99C68A3C505C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 1, 2020, at 12:54 PM, Steve French <smfrench@gmail.com> wrote:
>=20
> On Wed, Jan 29, 2020 at 7:54 PM Darrick J. Wong =
<darrick.wong@oracle.com> wrote:
>>=20
>> On Wed, Jan 22, 2020 at 05:13:53PM -0600, Steve French wrote:
>>> As discussed last year:
>>>=20
>>> Current Linux copy tools have various problems compared to other
>>> platforms - small I/O sizes (and most don't allow it to be
>>> configured), lack of parallel I/O for multi-file copies, inability =
to
>>> reduce metadata updates by setting file size first, lack of cross
>>=20
>> ...and yet weirdly we tell everyone on xfs not to do that or to use
>> fallocate, so that delayed speculative allocation can do its thing.
>> We also tell them not to create deep directory trees because xfs =
isn't
>> ext4.
>=20
> Delayed speculative allocation may help xfs but changing file size
> thousands of times for network and cluster fs for a single file copy
> can be a disaster for other file systems (due to the excessive cost
> it adds to metadata sync time) - so there are file systems where
> setting the file size first can help

Sometimes I think it is worthwhile to bite the bullet and just submit
patches to the important upstream tools to make them work well.  I've
sone that in the past for cp, tar, rsync, ls, etc. so that they work
better.  If you've ever straced those tools, you will see they do a
lot of needless filesystem operations (repeated stat() in particular)
that could be optimized - no syscall is better than a fast syscall.

For cp it was changed to not allocate the st_blksize buffer on the
stack, which choked when Lustre reported st_blksize=3D8MB.  I'm starting
to think that it makes sense for all filesystems to use multi-MB buffers
when reading/copying file data, rather than 4KB or 32KB as it does =
today.
It might also be good for cp to use O_DIRECT for large file copies =
rather
than buffered IO to avoid polluting the cache?  Having it use AIO/DIO
would likely be a huge improvement as well.

That probably holds true for many other tools that still use st_blksize.
Maybe filesystems like ext4/xfs/btrfs should start reporting a larger
st_blksize as well?

As for parallel file copying, we've been working on MPIFileUtils, which
has parallel tree/file operations (also multi-node), but has the =
drawback
that it depends on MPI for remote thread startup, and isn't for =
everyone.
It should be possible to change it to run in parallel on a single node =
if
MPI wasn't installed, which would make the tools more generally usable.

>>> And copy tools rely less on
>>> the kernel file system (vs. code in the user space tool) in Linux =
than
>>> would be expected, in order to determine which optimizations to use.
>>=20
>> What kernel interfaces would we expect userspace to use to figure out
>> the confusing mess of optimizations? :)
>=20
> copy_file_range and clone_file_range are a good start ... few tools
> use them ...

One area that is really lacking a parallel interface is for directory
and namespace operations.  We still need to do serialized readdir()
and stat for operations in a directory.  There are now parallel VFS
lookups, but it would be useful to allow parallel create and unlink
for regular files, and possibly renames of files within a directory.

For ext4 at least, it would be possible to have parallel readdir()
by generating synthetic telldir() cookies to divide up the directory
into several chunks that can be read in parallel.  Something like:

     seek(dir_fd[0], 0, SEEK_END)
     pos_max =3D telldir(dir_fd[0])
     pos_inc =3D pos_max / num_threads
     for (i =3D 0; i < num_threads; i++)
         seekdir(dir_fd[i], i * pos_inc)

but I don't know if that would be portable to other filesystems.

XFS has a "bulkstat" interface which would likely be useful for
directory traversal tools.

>> There's a whole bunch of xfs ioctls like dioinfo and the like that we
>> ought to push to statx too.  Is that an example of what you mean?
>=20
> That is a good example.   And then getting tools to use these,
> even if there are some file system dependent cases.

I've seen that copy to/from userspace is a bottleneck if the storage is
fast.  Since the cross-filesystem copy_file_range() patches have landed,
getting those into userspace tools would be a big performance win.

Dave talked a few times about adding better info than st_blksize for
different IO-related parameters (alignment, etc).  It was not included
in the initial statx() landing because of excessive bikeshedding, but
makes sense to re-examine what could be used there.  Since statx() is
flexible, applications could be patched immediately to check for the
new fields, without having to wait for a new syscall to propagate out.

That said, if data copies are done in the kernel, this may be moot for
some tools, but would still be useful for others.

>>> But some progress has been made since last year's summit, with new
>>> copy tools being released and improvements to some of the kernel =
file
>>> systems, and also some additional feedback on lwn and on the mailing
>>> lists.

I think if the tools are named anything other than cp, dd, tar, find
it is much less likely that anyone will use them, so focussing developer
efforts on the common GNU tools is more likely to be a win than making
another new copy tool that nobody will use, IMHO.

>>> In addition these discussions have prompted additional
>>> feedback on how to improve file backup/restore scenarios (e.g. to
>>> mounts to the cloud from local Linux systems) which require =
preserving
>>> more timestamps, ACLs and metadata, and preserving them efficiently.
>>=20
>> I suppose it would be useful to think a little more about =
cross-device
>> fs copies considering that the "devices" can be VM block devs backed =
by
>> files on a filesystem that supports reflink.  I have no idea how you
>> manage that sanely though.
>=20
> I trust XFS and BTRFS and SMB3 and cluster fs etc. to solve this =
better
> than the block level (better locking, leases/delegation, state =
management,
> etc.) though.

Getting RichACLs into the kernel would definitely help here.  Non-Linux
filesystems have some variant of NFSv4 ACLs, and having only POSIX ACLs
on Linux is a real hassle here.  Either the outside ACLs are stored as =
an
xattr blob, which leads to different semantics depending on the access
method (CIFS, NFS, etc) or they are shoe-horned into the POSIX ACL and
lose information.

Cheers, Andreas






--Apple-Mail=_18888712-B94F-4C77-8A59-99C68A3C505C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl42BrsACgkQcqXauRfM
H+AxlQ/9FywysisQOOCc/ouusT5nKTjv6mvLQmY+1TxXBie24tz+ndWXs6gz68MF
j8Lqz7BYaTTfeLc98s488jHPA9O/MIounuAtUfx/mqiwFIwPlysrXhAXam9lo+HZ
DnhMYBzlGtoHy/82Wb3pkl5iNauqFNMVeInnHOaRtmEmutqSsZ1EPXId6MMIGr1N
LbjkXXLpL2LXmn3pVM+0xVRdaWRYUEe8DBQ3YskaIf4lqjw6HlAHOHsrRm9DZqTi
B4C9zVVfIdDFss8N9lOemMRX7yMVDNKMxBdHRQExLpKN4B9p4rK405K5YDuxY0yp
3wYcZPEBXlIDsR2y7EkJR4DQ80DF3W4rlsACzLDp6wsjdIRLq0IxlZEZuzptoyiN
RJvgy4e6nyVWcX3j864vqHcAAd5NQ3XVCAMRNPy4OXOPWmWovcN845uDL6mcX5SN
fykRtlAKJs/+L8LRy+tbAt4FJD0e+fIuBls7t8M90tGEs49bg8GZIzk3HMvOdKvD
ld9VkWf6lFIwg/zkidEvYxRpYFwwdh9j9LPg6cgc1VKneMzNbAuEK9OmODXmT8gy
s/YNiqj8JMWVU50V5MDYRda4LoTcH6eUR4ANXcnNiF0UlIdoj9Id2BpUbr92KvoD
/Fw+XQIy96XHZGrM7wly17Jqz3NGu5e/O8hJKVUWXlaAqRx09nQ=
=zjhF
-----END PGP SIGNATURE-----

--Apple-Mail=_18888712-B94F-4C77-8A59-99C68A3C505C--
