Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0219B9FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 03:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgDBBie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 21:38:34 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46223 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbgDBBid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:38:33 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3ABD45801C4;
        Wed,  1 Apr 2020 21:38:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Apr 2020 21:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        65E0cCQjZaasR2Q4SReMT3up4B2vZTD5YrrV+eEQPzU=; b=EhjE5WUllq7utAsj
        QGotnYbb9Kw8jZCsD7odmyKl1n5mYNo16UGKeB+MA/N8pXr1cwCWa1jb2Qz6NnFR
        OmkHYTPm3ClH8nYV38aHOd8+YkGAGNacEUH924J1y6HJ80OvGw1vOk420eaVRmr1
        Wqv16Qg6Prbwz52FOwUoa9pw7JtngLbVwCiM9SbAOY4/IxfKTbu2Bj+zofmYQPAZ
        3DbFdozqMh3qo9qJ646FaGfljfvPwyXGuJkQfmzNQxDFzQLOA6lcR1LS1OAtdFYu
        R1qMp7IVbQ+56/KqtUyLLkVzOUUUIIJ+umm4GYxaZV/Wirk+sjBmfMOp/5UCTFtr
        +kr2LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=65E0cCQjZaasR2Q4SReMT3up4B2vZTD5YrrV+eEQP
        zU=; b=ZVR+2Un1ogFAbTykJdID1KGQHIQCJlxQdHSQLt4iyc695rALIxGzJ/tZx
        8ttNUhd77g0OaBXN5/v5Q61v4ileqM3MNUllXQT/wmZHyyTxCGxukO3drlUximUQ
        Yn0lLHQQ4deECa6MIpgb5BJCB4VMr8RT3NfjFcB+xwsNz55sEXdbwq6kd1MQnzlK
        Mta2qB0IOK7uVSe1r+MH6dKM/Ym1LVOlW+qAmnUOMTA0qqlWFDEPpyRtftHWjREV
        czKId4Nepql7rXMwphjcl51Mlljv3xaYYmB6qAyPcxod1+UpKfKizo5hobnmT3m2
        byqO5tanFiUouyIa6j4md5wueG0Pg==
X-ME-Sender: <xms:F0KFXnxfg-I39THCyxl8TBBO4WHZ_l_tGpGYiNs6KqDi_2mdnroUvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    duieeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:F0KFXjgFLqkZZSXP7k-wS0dX0TesDJcOZg4BLckP6jqvx7AMc3i6yw>
    <xmx:F0KFXsV1k4K3Nk4yTG1Kpiu9GOkeb9fya0zvYG0XJ_h-ikBRchiVTg>
    <xmx:F0KFXl0sM4s2FZ5lq6RtbJIVXDAH4v1HQranqyejd-iKBEZ1hzssSA>
    <xmx:GEKFXpBmaOPBnPhHnGLHAp7bVvRp7u-xAXONrNwu4w2Gmy4Elbu9bg>
Received: from mickey.themaw.net (unknown [118.209.166.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69846306CD83;
        Wed,  1 Apr 2020 21:38:24 -0400 (EDT)
Message-ID: <459876eceda4bc68212faf4ed3d4bcb8570aa105.camel@themaw.net>
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Apr 2020 09:38:20 +0800
In-Reply-To: <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
         <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
         <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
         <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com>
         <2465266.1585729649@warthog.procyon.org.uk>
         <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-04-01 at 10:37 +0200, Miklos Szeredi wrote:
> On Wed, Apr 1, 2020 at 10:27 AM David Howells <dhowells@redhat.com>
> wrote:
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > According to dhowell's measurements processing 100k mounts would
> > > take
> > > about a few seconds of system time (that's the time spent by the
> > > kernel to retrieve the data,
> > 
> > But the inefficiency of mountfs - at least as currently implemented
> > - scales
> > up with the number of individual values you want to retrieve, both
> > in terms of
> > memory usage and time taken.
> 
> I've taken that into account when guesstimating a "few seconds per
> 100k entries".  My guess is that there's probably an order of
> magnitude difference between the performance of a fs based interface
> and a binary syscall based interface.  That could be reduced somewhat
> with a readfile(2) type API.
> 
> But the point is: this does not matter.  Whether it's .5s or 5s is
> completely irrelevant, as neither is going to take down the system,
> and userspace processing is probably going to take as much, if not
> more time.  And remember, we are talking about stopping and starting
> the automount daemon, which is something that happens, but it should
> not happen often by any measure.

Yes, but don't forget, I'm reporting what I saw when testing during
development.

From previous discussion we know systemd (and probably the other apps
like udisks2, et. al.) gets notified on mount and umount activity so
its not going to be just starting and stopping autofs that's a problem
with very large mount tables.

To get a feel for the real difference we'd need to make the libmount
changes for both and then check between the two and check behaviour.
The mount and umount lookup case that Karel (and I) talked about
should be sufficient.

The biggest problem I had with fsinfo() when I was working with
earlier series was getting fs specific options, in particular the
need to use sb op ->fsinfo(). With this latest series David has made
that part of the generic code and your patch also cover it.

So the thing that was holding me up is done so we should be getting
on with libmount improvements, we need to settle this.

I prefer the system call interface and I'm not offering justification
for that other than a general dislike (and on occasion outright
frustration) of pretty much every proc implementation I have had to
look at.

> 
> > With fsinfo(), I've tried to batch values together where it makes
> > sense - and
> > there's no lingering memory overhead - no extra inodes, dentries
> > and files
> > required.
> 
> The dentries, inodes and files in your test are single use (except
> the
> root dentry) and can be made ephemeral if that turns out to be
> better.
> My guess is that dentries belonging to individual attributes should
> be
> deleted on final put, while the dentries belonging to the mount
> directory can be reclaimed normally.
> 
> Thanks,
> Miklos

