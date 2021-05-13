Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D937F927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhEMNwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 09:52:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45165 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234187AbhEMNvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 09:51:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 72E555807A3;
        Thu, 13 May 2021 09:50:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 May 2021 09:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        IYRQbrFEXaKwICPZbu9q1HzmHYUlQBl8R3HUlaLVmHE=; b=ZAdf0RAxr6SapsTJ
        ecGrOuv6h6qjA9igZzqeSszLVV5hAXJ7zn5YMgio0bbOffvbHCYp4pLkNZbNF4dL
        yj+elRiLLCO+um+B6krg4zuoAVVIaKj6RKPTNFFWfue1OVn1jwAnSchS9cLc7gRO
        ie4rdykdIygU5TihRigOS5IgtdB1YYfr+YNvqqMHATQP0SymK6PIMGkongn9UoYW
        G4O/A41nhS9XnqN5zWB2wohBk8fkKy3tFf6oCqxJHsn4lN7aY8kOwQw/GVMxwu9B
        LRY2y6D6pHI5igemrUPGv5JeepKWBG/3wBFPa2zE+8r1d+jwELWk9e0b0ASIyNdr
        3WdNsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=IYRQbrFEXaKwICPZbu9q1HzmHYUlQBl8R3HUlaLVm
        HE=; b=jKlGGNUxPdGKd9OyDQoYa3HcFjtdeYr8B/aOXUs3+xuPnQKBi938Gnpw9
        b0y5cTGeB/+iyL7z5N0Ka1eY5NxL86+vGoG8pFcl1TGr0CH59voGuYTnlIHTGJyX
        7DPjafncHzqXaFnpAV0OfmS3LkTu0G+55ySPnbcjl1OgOqDPuONriAA+SbQJeMVq
        onkbqF5KcjJMJ9KLluRpndWEHbwzrKto0hUEskujKKT2VVG8Mu9nN6C/HvD88Aap
        MCfTqGm3sZ0RwfStHSsyYMlxKxV8k4yZsfN6w7LGKqEXw0gJPHA5TMExHIROzvvx
        G99UTqM+E+1pRbqIKeF5ZnlqKmNdQ==
X-ME-Sender: <xms:pC6dYA-pbe6XDFnPVx_HwTuopJRCGKXwZ04ffZLreJ4zHrlKZvv9cA>
    <xme:pC6dYIuRXi7_ccs70_nOXSLk2axQanb9s2-Rooc59JvHQtWwR6DXOh0KShbHqFH57
    KMBiunqn3ui>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucfk
    phepuddtiedrieelrddvfedurdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:pC6dYGAyi2ILjSR-Bw871dys7PLlrJf_TQPmecz7rjUmw_hDTv0axw>
    <xmx:pC6dYAcf6vnE-vIWeBmbRBYrAwJUG28w3tu5WMWQjq8bXHSP5SpgDw>
    <xmx:pC6dYFNER6l2qJYJaSG2QJHO4cUnznc9mx_L5MsWMuR5lsB9QFOIhA>
    <xmx:pS6dYOhy6yb8o9K2HBa8erLQ3hjt03QnDKFUixREkWezP0XI_WL0KQ>
Received: from mickey.long.domain.name.themaw.net (106-69-231-44.dyn.iinet.net.au [106.69.231.44])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 09:50:24 -0400 (EDT)
Message-ID: <152abd1fea6ae3887febdb16263ebecfcf0d4341.camel@themaw.net>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 13 May 2021 21:50:19 +0800
In-Reply-To: <YJtz6mmgPIwEQNgD@kroah.com>
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
         <YJtz6mmgPIwEQNgD@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-05-12 at 08:21 +0200, Greg Kroah-Hartman wrote:
> On Wed, May 12, 2021 at 08:38:35AM +0800, Ian Kent wrote:
> > There have been a few instances of contention on the kernfs_mutex
> > during
> > path walks, a case on very large IBM systems seen by myself, a
> > report by
> > Brice Goglin and followed up by Fox Chen, and I've since seen a
> > couple
> > of other reports by CoreOS users.
> > 
> > The common thread is a large number of kernfs path walks leading to
> > slowness of path walks due to kernfs_mutex contention.
> > 
> > The problem being that changes to the VFS over some time have
> > increased
> > it's concurrency capabilities to an extent that kernfs's use of a
> > mutex
> > is no longer appropriate. There's also an issue of walks for non-
> > existent
> > paths causing contention if there are quite a few of them which is
> > a less
> > common problem.
> > 
> > This patch series is relatively straight forward.
> > 
> > All it does is add the ability to take advantage of VFS negative
> > dentry
> > caching to avoid needless dentry alloc/free cycles for lookups of
> > paths
> > that don't exit and change the kernfs_mutex to a read/write
> > semaphore.
> > 
> > The patch that tried to stay in VFS rcu-walk mode during path walks
> > has
> > been dropped for two reasons. First, it doesn't actually give very
> > much
> > improvement and, second, if there's a place where mistakes could go
> > unnoticed it would be in that path. This makes the patch series
> > simpler
> > to review and reduces the likelihood of problems going unnoticed
> > and
> > popping up later.
> > 
> > The patch to use a revision to identify if a directory has changed
> > has
> > also been dropped. If the directory has changed the dentry revision
> > needs to be updated to avoid subsequent rb tree searches and after
> > changing to use a read/write semaphore the update also requires a
> > lock.
> > But the d_lock is the only lock available at this point which might
> > itself be contended.
> > 
> > Changes since v3:
> > - remove unneeded indirection when referencing the super block.
> > - check if inode attribute update is actually needed.
> > 
> > Changes since v2:
> > - actually fix the inode attribute update locking.
> > - drop the patch that tried to stay in rcu-walk mode.
> > - drop the use a revision to identify if a directory has changed
> > patch.
> > 
> > Changes since v1:
> > - fix locking in .permission() and .getattr() by re-factoring the
> > attribute
> >   handling code.
> > ---
> > 
> > Ian Kent (5):
> >       kernfs: move revalidate to be near lookup
> >       kernfs: use VFS negative dentry caching
> >       kernfs: switch kernfs to use an rwsem
> >       kernfs: use i_lock to protect concurrent inode updates
> >       kernfs: add kernfs_need_inode_refresh()
> > 
> > 
> >  fs/kernfs/dir.c             | 170 ++++++++++++++++++++------------
> > ----
> >  fs/kernfs/file.c            |   4 +-
> >  fs/kernfs/inode.c           |  45 ++++++++--
> >  fs/kernfs/kernfs-internal.h |   5 +-
> >  fs/kernfs/mount.c           |  12 +--
> >  fs/kernfs/symlink.c         |   4 +-
> >  include/linux/kernfs.h      |   2 +-
> >  7 files changed, 147 insertions(+), 95 deletions(-)
> > 
> > --
> > Ian
> > 
> 
> Any benchmark numbers that you ran that are better/worse with this
> patch
> series?  That woul dbe good to know, otherwise you aren't changing
> functionality here, so why would we take these changes?  :)

Hi Greg,

I'm sorry, I don't have a benchmark.

My continued work on this has been driven by the report from
Brice Goglin and Fox Chen, and also because I've seen a couple
of other reports of kernfs_mutex contention that is resolved
by the series.

Unfortunately the two reports I've seen fairly recently are on
kernels that are about as far away from the upstream kernel
as you can get so probably aren't useful in making my case.

The report I've worked on most recently is on CoreOS/Kunbernetes
(based on RHEL-8.3) where the machine load goes to around 870
after loading what they call an OpenShift performance profile.

I looked at some sysreq dumps and they have a seemingly endless
number of processes waiting on the kernfs_mutex.

I tried to look at the Kubernetes source but it's written in
go so there would need to be a lot of time spent to work out
what's going on, I'm trying to find someone to help with that.

All I can say from looking at the Kubernetes source is it has
quite a few sysfs paths in it so I assume it uses sysfs fairly
heavily.

The other problem I saw was also on CoreOS/Kunernetes.
A vmcore analysis showed kernfs_mutex contention but with a
different set of processes and not as significant as the former
problem.

So, even though this isn't against the current upstream, there
isn't much difference in the kernfs/sysfs source between those
two kernels and given the results of Brice and Fox I fear I'll
be seeing more of this as time goes by.

I'm fairly confident that the user space applications aren't
optimal (although you may have stronger words for it than that)
I was hoping you would agree that it's sensible for the kernel
to protect itself to the extent that it can provided the change
is straight forward enough.

I have tried to make the patches as simple as possible without
loosing much of the improvement to minimize any potential ongoing
maintenance burden.

So, I'm sorry I can't offer you more incentive to consider the
series, but I remain hopeful you will.

If there is anything you would like me to follow up on please
ask and, if I can, I will do what's requested.

Ian


