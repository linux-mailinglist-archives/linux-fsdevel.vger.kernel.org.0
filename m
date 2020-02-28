Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1608173B08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgB1PJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:09:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41202 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbgB1PJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:09:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DDE9D8EE245;
        Fri, 28 Feb 2020 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582902555;
        bh=dAvkoZd9hqHCyw/YsJjl7WIBqmozG3odFfynnMjmuGo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZFAs/MCuTgaCGldqlIrOq57Bsip9wGh6SXp+JJLpvYrEvccuBCznL1lg/iu29nRGD
         7FWBHoXc1h4yOPFDEDdFMDRp48Ge+fs0IW6LyIllHfYLxBqe7a9MOkbZPGLVdZ1FgU
         2Mw6lhut4XgNUCO1SldHR5CYQYXCB7A5k37bZHJY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nXtQSWVL_eMo; Fri, 28 Feb 2020 07:08:49 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D30C58EE15F;
        Fri, 28 Feb 2020 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582902524;
        bh=dAvkoZd9hqHCyw/YsJjl7WIBqmozG3odFfynnMjmuGo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EtXhmLsaE6xEyFIGAb30rY5I0JjGxzQOtezpZ9Hx2cZo38cwxkp1lVKwqX0jXF3ku
         GP7sZa1L3dHN1+lBfJCdVIpaw0+PWWyHtIpBSeE6KTWm1ah3agkDprjXfuiWoPK/De
         BF1mxQnyLMq+2yxIdHkYNzfGGyrITMii8g7encd0=
Message-ID: <1582902521.3338.20.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>
Cc:     Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>,
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
        Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        util-linux@vger.kernel.org
Date:   Fri, 28 Feb 2020 07:08:41 -0800
In-Reply-To: <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com>
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
         <20200227151421.3u74ijhqt6ekbiss@ws.net.home>
         <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
         <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-28 at 09:35 +0100, Miklos Szeredi wrote:
> On Fri, Feb 28, 2020 at 1:43 AM Ian Kent <raven@themaw.net> wrote:
> 
> > > I'm not sure about sysfs/, you need somehow resolve namespaces,
> > > order of the mount entries (which one is the last one), etc. IMHO
> > > translate mountpoint path to sysfs/ path will be complicated.
> > 
> > I wonder about that too, after all sysfs contains a tree of nodes
> > from which the view is created unlike proc which translates kernel
> > information directly based on what the process should see.
> > 
> > We'll need to wait a bit and see what Miklos has in mind for mount
> > table enumeration and nothing has been said about name spaces yet.
> 
> Adding Greg for sysfs knowledge.
> 
> As far as I understand the sysfs model is, basically:
> 
>   - list of devices sorted by class and address
>   - with each class having a given set of attributes
> 
> Superblocks and mounts could get enumerated by a unique identifier.
> mnt_id seems to be good for mounts, s_dev may or may not be good for
> superblock, but  s_id (as introduced in this patchset) could be used
> instead.
> 
> As for namespaces, that's "just" an access control issue, AFAICS.

That's an easy thing to say but not an easy thing to check:  it can be
made so for label based namespaces like the network, but the mount
namespace is shared/cloned tree based.  Assessing whether a given
superblock is within your current namespace root can become a large
search exercise.  You can see how much of one in fs/proc_namespaces.c
which controls how /proc/self/mounts appears in your current namespace.

> For example a task with a non-initial mount namespace should not have
> access to attributes of mounts outside of its namespace.  Checking
> access to superblock attributes would be similar: scan the list of
> mounts and only allow access if at least one mount would get access.

That scan can be expensive as I explained above.  That's really why I
think this is a bad idea.  Sysfs itself is nicely currently restricted
to system information that most containers don't need to know, so a lot
of the sysfs issues with containers can be solved by not mounting it. 
If you suddenly make it required for filesystem information and
notifications, that security measure gets blown out of the water.

> > While fsinfo() is not similar to proc it does handle name spaces
> > in a sensible way via. file handles, a bit similar to the proc fs,
> > and ordering is catered for in the fsinfo() enumeration in a
> > natural way. Not sure how that would be handled using sysfs ...
> 
> I agree that the access control is much more straightforward with
> fsinfo(2) and this may be the single biggest reason to introduce a
> new syscall.
> 
> Let's see what others thing.

Containers are file based entities, so file descriptors are their most
natural thing and they have full ACL protection within the container
(can't open the file, can't then get the fd).  The other reason
container people like file descriptors (all the Xat system calls that
have been introduced) is that if we do actually need to break the
boundaries or privileges of the container, we can do so by getting the
orchestration system to pass in a fd the interior of the container
wouldn't have access to.

James

