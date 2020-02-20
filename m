Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CCB165CCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBTLbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 06:31:05 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34625 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgBTLbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:31:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 95C1A327;
        Thu, 20 Feb 2020 06:31:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 20 Feb 2020 06:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        eLiud/Rsy5p8XN8U+ILzeII/ojMGZfdK4TZW/by/ETA=; b=uM5cDtY+Tk/pn+Nz
        phelYPraeZgfOzC/O1Gir8zTC4oVFFCl9lqApSg6y/6oZbpNDNcGIctYMXDKzyaz
        U7xjpMlKdeHKUxXhXwuHgiTKN/2PRHdXFI7mOzzzc3X22Np6QhmWBoAgTGo9YZEj
        E5gLduzKccjRYQsm/QAm3GHzIlQ+m50hPHY8HJG7rs+uKkfw9XyMJae0MmfDwm90
        ngYYH3gY9pUGeicxKPpe5GM22LouA/cfcv6v3pxoJ7EtKfkNU3pMWpbS/4LENtGk
        F4L8pYAR2+T+qVrYnWhgdaVUFiiVqO4da1OE0OWuvt3jMMGmo6Nfq2Ryi6S8P7mD
        wbzXEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=eLiud/Rsy5p8XN8U+ILzeII/ojMGZfdK4TZW/by/E
        TA=; b=HZMTb91bgBRCQ9c0vzNcFiyYPfhFofjwN3wQiIjeJ4GbsXQ1MGE7Qnxha
        Ja5C18UY0kFMv/WtOTKmU+6nRtXbYSzJc7gfCAMljdwIr8HT5i3rCO3pLuP3EBJo
        wKmj58K7wlMvS9bB7DerkmnZW0maFDKYOePV/XOeWNylVFGK6L7LmYo+zEP82I6v
        9grcrvHUYpzHGUWzNcMf6BfY7cUBKipV9qJkgTNE3CKP5eZZbY3elppP3xm1t5mk
        EiMlwndlvLiJZsU7OG/bd64Lrgh22Dhg3ExJQyQEn2icdg52zM62Nx/cfHszZIqt
        mPzG8/VobF8+xiIS1HLc8ORKs/FIQ==
X-ME-Sender: <xms:9m1OXoz2FNs3ecB2yx2tuWzwpEjst1yim2H8UVvIOvR04kCABBUuDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    duieefrdefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:9m1OXrLo7tHFFS3GpyJEMjGLMHH71J5Fev23zZ0-IFlKxPAVwvAs8w>
    <xmx:9m1OXquLV81nO7mM6AurtarK5fhBMllap-VqlVPrd4bXK4kinMUXVQ>
    <xmx:9m1OXrgiq0zZrU_LQHY2DGnlyRJPK-J4xR-mQmDeo-1yUppHcei6jw>
    <xmx:921OXqnwnjTkgrPApnIVqxjG5gU2VeEXS4tVmbo23cEphWauDJq4tA>
Received: from mickey.themaw.net (unknown [118.208.163.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id AAF1F3280060;
        Thu, 20 Feb 2020 06:30:58 -0500 (EST)
Message-ID: <80b70aa96c2e386719a7683d7627fc4d5a6caade.camel@themaw.net>
Subject: Re: [PATCH 00/19] VFS: Filesystem information and notifications
 [ver #16]
From:   Ian Kent <raven@themaw.net>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Feb 2020 19:30:54 +0800
In-Reply-To: <20200220090939.4e2mpmdixcyruzda@wittgenstein>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
         <20200219144613.lc5y2jgzipynas5l@wittgenstein>
         <c9a6f929b57e0c21c8845c211d1e3eab09d09633.camel@themaw.net>
         <20200220090939.4e2mpmdixcyruzda@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-20 at 10:09 +0100, Christian Brauner wrote:
> On Thu, Feb 20, 2020 at 12:42:15PM +0800, Ian Kent wrote:
> > On Wed, 2020-02-19 at 15:46 +0100, Christian Brauner wrote:
> > > On Tue, Feb 18, 2020 at 05:04:55PM +0000, David Howells wrote:
> > > > Here are a set of patches that adds system calls, that (a)
> > > > allow
> > > > information about the VFS, mount topology, superblock and files
> > > > to
> > > > be
> > > > retrieved and (b) allow for notifications of mount topology
> > > > rearrangement
> > > > events, mount and superblock attribute changes and other
> > > > superblock
> > > > events,
> > > > such as errors.
> > > > 
> > > > ============================
> > > > FILESYSTEM INFORMATION QUERY
> > > > ============================
> > > > 
> > > > The first system call, fsinfo(), allows information about the
> > > > filesystem at
> > > > a particular path point to be queried as a set of attributes,
> > > > some
> > > > of which
> > > > may have more than one value.
> > > > 
> > > > Attribute values are of four basic types:
> > > > 
> > > >  (1) Version dependent-length structure (size defined by type).
> > > > 
> > > >  (2) Variable-length string (up to 4096, including NUL).
> > > > 
> > > >  (3) List of structures (up to INT_MAX size).
> > > > 
> > > >  (4) Opaque blob (up to INT_MAX size).
> > > 
> > > I mainly have an organizational question. :) This is a huge
> > > patchset
> > > with lots and lots of (good) features. Wouldn't it make sense to
> > > make
> > > the fsinfo() syscall a completely separate patchset from the
> > > watch_mount() and watch_sb() syscalls? It seems that they don't
> > > need
> > > to
> > > depend on each other at all. This would make reviewing this so
> > > much
> > > nicer and likely would mean that fsinfo() could proceed a little
> > > faster.
> > 
> > The remainder of the fsinfo() series would need to remain useful
> > if this was done.
> > 
> > For context I want work on improving handling of large mount
> > tables.
> 
> Yeah, I've talked to David about this; polling on a large mountinfo
> file
> is not great, I agree.
> 
> > Ultimately I expect to solve a very long standing autofs problem
> > of using large direct mount maps without prohibitive performance
> > overhead (and there a lot of rather challenging autofs changes to
> > do for this too) and I believe the fsinfo() system call, and
> > related bits, is the way to do this.
> > 
> > But improving the handling of large mount tables for autofs
> > will have the side effect of improvements for other mount table
> > users, even in the early stages of this work.
> > 
> > For example I want to use this for mount table handling
> > improvements
> > in libmount. Clearly that ultimately needs mount change
> > notification
> > in the end but ...
> > 
> > There's a bunch of things that need to be done alone the way
> > to even get started.
> > 
> > One thing that's needed is the ability to call fsinfo() to get
> > information on a mount to avoid constant reading of the proc based
> > mount table, which happens a lot (since the mount info. needs
> > to be up to date) so systemd (and others) would see an improvement
> > with the fsinfo() system call alone able to be used in libmount.
> > 
> > But for the fsinfo() system call to be used for this the file
> > system specific mount options need to also be obtained when
> > using fsinfo(). That means the super block operation fsinfo uses
> > to provide this must be implemented for at least most file systems.
> > 
> > So separating out the notifications part, leaving whatever is
> > needed
> > to still be able to do this, should be fine and the system call
> > would be immediately useful once the super operation is implemented
> > for the needed file systems.
> > 
> > Whether the implementation of the super operation should be done
> > as part of this series is another question but would certainly
> > be a challenge and make the series more complicated. But is needed
> > for the change to be useful in my case.
> 
> I think what would might work - and what David had already brought up
> briefly - is to either base the fsinfo branch on top of the mount
> notificaiton branch or break the notification counters pieces into a
> separate patch and base both mount notifications and fsinfo on top of
> it.

Possibly, but I'm pretty sure David has more fsinfo patches.

So I suspect there will be a right time to post patches for the
fsinfo super block operation that David doesn't already have. I'm
going to have to find time for that ...

The post was more to let David know what my first goal is and what
I need for it, and to let others know there is someone wanting to
use this for user space improvements and give some initial insight
into my longer term goals.

Ian

