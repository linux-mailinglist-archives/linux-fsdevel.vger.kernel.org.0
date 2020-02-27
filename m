Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB71721FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 16:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgB0POh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 10:14:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730383AbgB0POg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582816476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsXD7OC/j5gaz+S/O9WvlSstDKGTM7c7shTcNdfT6SA=;
        b=EgnDTWxjqIm9eGAsnZG8XDys/asq/mPCgVOTXj/ZAnB0jl+bKpJevx3UJLfboA8/cs1oMv
        SKEze3R9pTQfxlwveey0B6+geNPpi+X+156IpVslGa6poOYKnWDnateBPvllZElEVdJwqC
        MZsmcK9vDH7VGp+u9s+0aD0q+qlWH5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-WDNOwscoO72aO4dxQsI4uw-1; Thu, 27 Feb 2020 10:14:30 -0500
X-MC-Unique: WDNOwscoO72aO4dxQsI4uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 693DD1005514;
        Thu, 27 Feb 2020 15:14:28 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 807061036B25;
        Thu, 27 Feb 2020 15:14:23 +0000 (UTC)
Date:   Thu, 27 Feb 2020 16:14:21 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200227151421.3u74ijhqt6ekbiss@ws.net.home>
References: <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
 <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
 <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:45:27PM +0100, Miklos Szeredi wrote:
> > So the problem I want to see fixed is the effect of very large
> > mount tables on other user space applications, particularly the
> > effect when a large number of mounts or umounts are performed.

Yes, now you have to generate (in kernel) and parse (in
userspace) all mount table to get information about just 
one mount table entry. This is typical for umount or systemd.

> > >  - add a notification mechanism   - lookup a mount based on path
> > >  - and a way to selectively query mount/superblock information
> > based on path ...

For umount-like use-cases we need mountpoint/ to mount entry
conversion; I guess something like open(mountpoint/) + fsinfo() 
should be good enough.

For systemd we need the same, but triggered by notification. The ideal
solution is to get mount entry ID or FD from notification and later use this
ID or FD to ask for details about the mount entry (probably again fsinfo()).
The notification has to be usable with in epoll() set.

This solves 99% of our performance issues I guess.

> > So that means mount table info. needs to be maintained, whether that
> > can be achieved using sysfs I don't know. Creating and maintaining
> > the sysfs tree would be a big challenge I think.

It will be still necessary to get complete mount table sometimes, but 
not in performance sensitive scenarios.

I'm not sure about sysfs/, you need somehow resolve namespaces, order
of the mount entries (which one is the last one), etc. IMHO translate
mountpoint path to sysfs/ path will be complicated.

> > But before trying to work out how to use a notification mechanism
> > just having a way to get the info provided by the proc tables using
> > a path alone should give initial immediate improvement in libmount.
> 
> Adding Karel, Lennart, Zbigniew and util-linux@vger...
> 
> At a quick glance at libmount and systemd code, it appears that just
> switching out the implementation in libmount will not be enough:
> systemd is calling functions like mnt_table_parse_*() when it receives
> a notification that the mount table changed.

We're ready to change this stuff in systemd if there will be something
better (something per-mount-entry).

My plan is add new API to libmount to query information about one
mount entry (but I had no time to play with fsinfo yet).

> What is the end purpose of parsing the mount tables?  Can systemd guys
> comment on that?

If mount/umount is triggered by systemd than it need verification
about success and final version of the mount options. It also reads
information from libmount to get userspace mount options (.e.g.
_netdev -- libmount uses mount source, target and fsroot to join
kernel and userpace stuff).

And don't forget that mount units are part of systemd dependencies, so
umount/mount is important event for systemd and it need details about
the changes (what, where, ... etc.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

