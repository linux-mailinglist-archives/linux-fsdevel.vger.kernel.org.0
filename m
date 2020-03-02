Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB69E175871
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCBKeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 05:34:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46346 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727115AbgCBKeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583145254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TnovkU9TRaPZCsU6BNaYIoozjytGGGEjCSLnwzS1uVA=;
        b=NsjoU95o9fnVJW/Vdm9ZpAZWjpmX8yKiDmKP5MG8qHxOeL4Jx0/MYE0dMyVm2T3fa8LIeS
        iaUhghid6qV7YH/iwKiUvp3qmjkGJMf1KOiyJGG0/rFgnE/Lx6TcZIRfdhhJf6vhsWYf7c
        xRxIj3eczxSD+x/fwz9oDkkTiWmLCq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-tECFLaW-PiulY-HJ6apnyg-1; Mon, 02 Mar 2020 05:34:10 -0500
X-MC-Unique: tECFLaW-PiulY-HJ6apnyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C8410824EE;
        Mon,  2 Mar 2020 10:34:07 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97F465DA2C;
        Mon,  2 Mar 2020 10:34:03 +0000 (UTC)
Date:   Mon, 2 Mar 2020 11:34:00 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
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
Message-ID: <20200302103400.vk3cki7agfq2zhpv@ws.net.home>
References: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
 <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
 <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
 <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
 <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
 <20200227151421.3u74ijhqt6ekbiss@ws.net.home>
 <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
 <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com>
 <20200228122712.GA3013026@kroah.com>
 <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 05:24:23PM +0100, Miklos Szeredi wrote:
> ned-By: MIMEDefang 2.78 on 10.11.54.4
> 
> On Fri, Feb 28, 2020 at 1:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> > > Superblocks and mounts could get enumerated by a unique identifier.
> > > mnt_id seems to be good for mounts, s_dev may or may not be good for
> > > superblock, but  s_id (as introduced in this patchset) could be used
> > > instead.
> >
> > So what would the sysfs tree look like with this?
> 
> For a start something like this:
> 
> mounts/$MOUNT_ID/
>   parent -> ../$PARENT_ID
>   super -> ../../supers/$SUPER_ID
>   root: path from mount root to fs root (could be optional as usually
> they are the same)
>   mountpoint -> $MOUNTPOINT
>   flags: mount flags
>   propagation: mount propagation
>   children/$CHILD_ID -> ../../$CHILD_ID
> 
>  supers/$SUPER_ID/
>    type: fstype
>    source: mount source (devname)
>    options:

What about use-cases where I have no ID, but I have mountpoint path
(e.g. "umount /foo")?  In this case I have to go to open() + fsinfo()
and then sysfs does not make sense for me, right?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

