Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA119A4AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgDAFWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 01:22:54 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56977 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgDAFWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:22:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id F2F76580629;
        Wed,  1 Apr 2020 01:22:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Apr 2020 01:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        CL/q7l0x3aGF1c50Pvo/bYiApj1J1O+uucbuoLSx1xE=; b=YSE6eE459CJfuGw/
        KbrwFfyRa0gg8orYFNDT1tkZZHqdyzQh+Y/lEOsWSpZ7WS+BlK8DfgVf43yIWwqv
        hgKwC228P6WSTxXi7HACpyuDW6fMmIcW/tOfsi+bJCw8oL9OAaNTHWOHvg/lMgbg
        EVbSFfd+0M1pPohK/2Cere/8HanSJh1PGBuh+ngTkptkbWx200FciPtjJXlNp3Lf
        5LXeQ43F2bPrnmSBw1q4FiM/bFi1AYjDdHdh2EBJp7gZCzKvanxquJ/7HbIfijfL
        ppPASbAOKgSES8AueIq1N/R13Cxu9wGgXel2VfLAziRyLXQo1PiyLjRquBUlxB2j
        lrbv4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=CL/q7l0x3aGF1c50Pvo/bYiApj1J1O+uucbuoLSx1
        xE=; b=DA9BdxY1gioAg0NXnQ6GEQUwVfG930YnigMDzI32lurqK2x+HnaIRgPY2
        b/52LdDuEc6hM13+h8g90aUPwpd+vgg89lSYHhYz76Giic6urXITmUedZUZX/yfe
        8abynnwl9VsSBavIlWpJGKpXs8YxtRF2BhXiKGah+8p9tUk9c0bCCevVKRAw/JxF
        GSZnVSDzzoEj1kpB64GZRUaEwq6RZTx0vN21zou4mZsV+AmOB8KwxwAq3/UhPul+
        joY8ZJY5jGw1T3sbqDRYuDkmUNBtE6fnb41CBmXPE68f1i01fHMyUR7ijRrkCdvs
        CznAQdpIQgw1D/Ffa5eIYeRYHkszg==
X-ME-Sender: <xms:KSWEXs8mYEqZr-PT8YRJZeV3CgoRT2MpBIy-OwEg8sMKb7mPpeyk4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtddugdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    duieeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:KSWEXiN4FCOB8HlaGmv7_HS4bbSYTTUIxVk8aTB9DU36zVcjaB8i9w>
    <xmx:KSWEXoVZ17upHiMJctNk3NlNtlj2GRKJj8pzmgkDmFr-rUEX1-Rjiw>
    <xmx:KSWEXjnDqnh8Peyc6NFaUnxAOCGSYTMx4QEdR7niPqEx_aeNdOKg8w>
    <xmx:KyWEXobvzDEnnkTqTPFREfiAa5Uu8gRTac1op0NMRSK6eWSZHRpvRA>
Received: from mickey.themaw.net (unknown [118.209.166.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F4DD306CC67;
        Wed,  1 Apr 2020 01:22:42 -0400 (EDT)
Message-ID: <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
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
Date:   Wed, 01 Apr 2020 13:22:38 +0800
In-Reply-To: <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
         <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-03-18 at 17:05 +0100, Miklos Szeredi wrote:
> On Wed, Mar 18, 2020 at 4:08 PM David Howells <dhowells@redhat.com>
> wrote:
> 
> > ============================
> > WHY NOT USE PROCFS OR SYSFS?
> > ============================
> > 
> > Why is it better to go with a new system call rather than adding
> > more magic
> > stuff to /proc or /sysfs for each superblock object and each mount
> > object?
> > 
> >  (1) It can be targetted.  It makes it easy to query directly by
> > path.
> >      procfs and sysfs cannot do this easily.
> > 
> >  (2) It's more efficient as we can return specific binary data
> > rather than
> >      making huge text dumps.  Granted, sysfs and procfs could
> > present the
> >      same data, though as lots of little files which have to be
> >      individually opened, read, closed and parsed.
> 
> Asked this a number of times, but you haven't answered yet:  what
> application would require such a high efficiency?

Umm ... systemd and udisks2 and about 4 others.

A problem I've had with autofs for years is using autofs direct mount
maps of any appreciable size cause several key user space applications
to consume all available CPU while autofs is starting or stopping which
takes a fair while with a very large mount table. I saw a couple of
applications affected purely because of the large mount table but not
as badly as starting or stopping autofs.

Maps of 5,000 to 10,000 map entries can almost be handled, not uncommon
for heavy autofs users in spite of the problem, but much larger than
that and you've got a serious problem.

There are problems with expiration as well but that's more an autofs
problem that I need to fix.

To be clear it's not autofs that needs the improvement (I need to
deal with this in autofs itself) it's the affect that these large
mount tables have on the rest of the user space and that's quite
significant.

I can't even think about resolving my autofs problem until this
problem is resolved and handling very large numbers of mounts
as efficiently as possible must be part of that solution for me
and I think for the OS overall too.

Ian
> 
> Nobody's suggesting we move stat(2) to proc interfaces, and AFAIK
> nobody suggested we move /proc/PID/* to a binary syscall interface.
> Each one has its place, and I strongly feel that mount info belongs
> in
> the latter category.    Feel free to prove the opposite.
> 
> >  (3) We wouldn't have the overhead of open and close (even adding a
> >      self-contained readfile() syscall has to do that internally
> 
> Busted: add f_op->readfile() and be done with all that.   For example
> DEFINE_SHOW_ATTRIBUTE() could be trivially moved to that interface.
> 
> We could optimize existing proc, sys, etc. interfaces, but it's not
> been an issue, apparently.
> 
> >  (4) Opening a file in procfs or sysfs has a pathwalk overhead for
> > each
> >      file accessed.  We can use an integer attribute ID instead
> > (yes, this
> >      is similar to ioctl) - but could also use a string ID if that
> > is
> >      preferred.
> > 
> >  (5) Can easily query cross-namespace if, say, a container manager
> > process
> >      is given an fs_context that hasn't yet been mounted into a
> > namespace -
> >      or hasn't even been fully created yet.
> 
> Works with my patch.
> 
> >  (6) Don't have to create/delete a bunch of sysfs/procfs nodes each
> > time a
> >      mount happens or is removed - and since systemd makes much use
> > of
> >      mount namespaces and mount propagation, this will create a lot
> > of
> >      nodes.
> 
> Not true.
> 
> > The argument for doing this through procfs/sysfs/somemagicfs is
> > that
> > someone using a shell can just query the magic files using ordinary
> > text
> > tools, such as cat - and that has merit - but it doesn't solve the
> > query-by-pathname problem.
> > 
> > The suggested way around the query-by-pathname problem is to open
> > the
> > target file O_PATH and then look in a magic directory under procfs
> > corresponding to the fd number to see a set of attribute files[*]
> > laid out.
> > Bash, however, can't open by O_PATH or O_NOFOLLOW as things
> > stand...
> 
> Bash doesn't have fsinfo(2) either, so that's not really a good
> argument.
> 
> Implementing a utility to show mount attribute(s) by path is trivial
> for the file based interface, while it would need to be updated for
> each extension of fsinfo(2).   Same goes for libc, language bindings,
> etc.
> 
> Thanks,
> Miklos

