Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7112422F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 02:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgHLAFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 20:05:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53509 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726255AbgHLAFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597190743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jvOO01wJQ7L+h65rqFuV46JFZcKV/98XxuqqDs02rY=;
        b=TguyTb2ETCyWCsly3HBrZTk10f+zg6SelJCXxPsHwLlhJ4nOKn5ISk0qIQA+BOapPUpAv6
        0aGwOYKrzW+2vmOngUIjcQ1dH4XYdlp4u291fz1fkIdjctxZ3Bweg5vgOO6T8THLlsWAb5
        dx8Dmb8FTyPvtlAMAMWoW2wlox7ExQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-lrrbiAU6MvS7mSu0Py8dfg-1; Tue, 11 Aug 2020 20:05:39 -0400
X-MC-Unique: lrrbiAU6MvS7mSu0Py8dfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B5F680048A;
        Wed, 12 Aug 2020 00:05:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2D5972ADE;
        Wed, 12 Aug 2020 00:05:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com> <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk> <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com> <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com> <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com> <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 12 Aug 2020 01:05:33 +0100
Message-ID: <52483.1597190733@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [ I missed the beginning of this discussion, so maybe this was already
> suggested ]

Well, the start of it was my proposal of an fsinfo() system call.  That at =
its
simplest takes an object reference (eg. a path) and an integer attribute ID=
 (it
could use a string instead, I suppose, but it would mean a bunch of strcmps
instead of integer comparisons) and returns the value of the attribute.  Bu=
t I
allow you to do slightly more interesting things than that too.

Mikl=C3=B3s seems dead-set against adding a system call specifically for th=
is -
though he's proposed extending open in various ways and also proposed an
additional syscall, readfile(), that does the open+read+close all in one st=
ep.

I think also at some point, he (or maybe James?) proposed adding a new magic
filesystem mounted somewhere on proc (reflecting an open fd) that then had a
bunch of symlinks to somewhere in sysfs (reflecting a mount).  The idea bei=
ng
that you did something like:

	fd =3D open("/path/to/object", O_PATH);
	sprintf(name, "/proc/self/fds/%u/attr1", fd);
	attrfd =3D open(name, O_RDONLY);
	read(attrfd, buf1, sizeof(buf1));
	close(attrfd);
	sprintf(name, "/proc/self/fds/%u/attr2", fd);
	attrfd =3D open(name, O_RDONLY);
	read(attrfd, buf2, sizeof(buf2));
	close(attrfd);

or:

	sprintf(name, "/proc/self/fds/%u/attr1", fd);
	readfile(name, buf1, sizeof(buf1));
	sprintf(name, "/proc/self/fds/%u/attr2", fd);
	readfile(name, buf2, sizeof(buf2));

and then "/proc/self/fds/12/attr2" might then be a symlink to, say,
"/sys/mounts/615/mount_attr".

Mikl=C3=B3s's justification for this was that it could then be operated fro=
m a shell
script without the need for a utility - except that bash, at least, can't do
O_PATH opens.

James has proposed making fsconfig() able to retrieve attributes (though I'd
prefer to give it a sibling syscall that does the retrieval rather than mak=
ing
fsconfig() do that too).

>   {
>      int fd, attrfd;
>
>      fd =3D open(path, O_PATH);
>      attrfd =3D openat(fd, name, O_ALT);
>      close(fd);
>      read(attrfd, value, size);
>      close(attrfd);
>   }

Please don't go down this path.  You're proposing five syscalls - including
creating two file descriptors - to do what fsinfo() does in one.

Do you have a particular objection to adding a syscall specifically for
retrieving filesystem/VFS information?

-~-

Anyway, in case you're interested in what I want to get out of this - which=
 is
the reason for it being posted in the first place:

 (*) The ability to retrieve various attributes of a filesystem/superblock,
     including information on:

	- Filesystem features: Does it support things like hard links, user
          quotas, direct I/O.

	- Filesystem limits: What's the maximum size of a file, an xattr, a
          directory; how many files can it support.

	- Supported API features: What FS_IOC_GETFLAGS does it support?  Which
          can be set?  Does it have Windows file attributes available?  What
          statx attributes are supported?  What do the timestamps support?
          What sort of case handling is done on filenames?

     Note that for a lot of cases, this stuff is fixed and can just be memc=
py'd
     from rodata.  Some of this is variable, however, in things like ext4 a=
nd
     xfs, depending on, say, mkfs configuration.  The situation is even more
     complex with network filesystems as this may depend on the server they=
're
     talking to.

     But note also that some of this stuff might change file-to-file, even
     within a superblock.

 (*) The ability to retrieve attributes of a mount point, including informa=
tion
     on the flags, propagation settings and child lists.

 (*) The ability to quickly retrieve a list of accessible mount point IDs,
     with change event counters to permit userspace (eg. systemd) to quickly
     determine if anything changed in the even of an overrun.

 (*) The ability to find mounts/superblocks by mount ID.  Paths are not uni=
que
     identifiers for mountpoints.  You can stack multiple mounts on the same
     directory, but a path only sees the top one.

 (*) The ability to look inside a different mount namespace - one to which =
you
     have a reference fd.  This would allow a container manager to look ins=
ide
     the container it is managing.

 (*) The ability to expose filesystem-specific attributes.  Network filesys=
tems
     can expose lists of servers and server addresses, for instance.

 (*) The ability to use the object referenced to determine the namespace
     (particularly the network namespace) to look in.  The problem with loo=
king
     in, say, /proc/net/... is that it looks at current's net namespace -
     whether or not the object of interest is in the same one.

 (*) The ability to query the context attached to the fd obtained from
     fsopen().  Such a context may not have a superblock attached to it yet=
 or
     may not be mounted yet.

     The aim is to allow a container manager to supervise a mount being mad=
e in
     a container.  It kind of pairs with fsconfig() in that respect.

 (*) The ability to query mount and superblock event counters to help a
     watching process handle overrun in the notifications queue.


What I've done with fsinfo() is:

 (*) Provided a number of ways to refer to the object to be queried (path,
     dirfd+path, fd, mount ID - with others planned).

 (*) Made it so that attibutes are referenced by a numeric ID to keep search
     time minimal.  Numeric IDs must be declared in uapi/linux/fsinfo.h.

 (*) Made it so that the core does most of the work.  Filesystems are given=
 an
     in-kernel buffer to copy into and don't get to see any userspace point=
ers.

 (*) Made it so that values are not, by and large, encoded as text if it ca=
n be
     avoided.  Backward and forward compatibility on binary structs is hand=
led
     by the core.  The filesystem just fills in the values in the UAPI stru=
ct
     in the buffer.  The core will zero-pad or truncate the data to match w=
hat
     userspace asked for.

     The UAPI struct must be declared in uapi/linux/fsinfo.h.

 (*) Made it so that, for some attributes, the core will fill in the data as
     best it can from what's available in the superblock, mount struct or m=
ount
     namespace.  The filesystem can then amend this if it wants to.

 (*) Made it so that attributes are typed.  The types are few: string, stru=
ct,
     list of struct, opaque.  Structs are extensible: the length is the
     version, a new version is required to be a superset of the old version=
 and
     excess requestage is simply cleared by the kernel.

     Information about the type of an attribute can be queried by fsinfo().


What I want to avoid:

 (*) Adding another magic filesystem.

 (*) Adding symlinks from proc to sysfs.

 (*) Having to use open to get an attribute.

 (*) Having to use multiple opens to get an attribute.

 (*) Having to pathwalk to get to the attribute from the object being queri=
ed.

 (*) Allocating another O_ open flag for this.

 (*) Avoidable text encoding and decoding.

 (*) Letting the filesystem access the userspace buffer.

Note that I'm not against splitting fsinfo() into a set of sibling syscalls=
 if
that makes it more palatable, or even against using strings for the attribu=
te
IDs, though I'd prefer to avoid the strcmps.

David

