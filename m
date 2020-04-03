Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE28719CE47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 03:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390269AbgDCBoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 21:44:14 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51669 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389108AbgDCBoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:44:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id DFB5958024C;
        Thu,  2 Apr 2020 21:44:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 02 Apr 2020 21:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        KyvhXjB5DdFettsz9BCOqHLXK5wPN6w15uaxcR0jueY=; b=WiorhD9nz+ySgT04
        SlNTC1Oo8MVXYRcS83g1m8PfBwjQq0WtZOY+ve90s7jrQhNHK/rGJcMtj3Fj/4oM
        mB+lQ7RNXJnKaR7B5EIK/QThJCwpB/wNxenqGKo9EU7b2IhziOM2RwONboe8FpaM
        6HcnaBkeXuqMJVEoTjuXRG3JS/a7nDrufJPK+eyf/g5SkCFn391tmJU7OkikIWhE
        rIjfzU/o6DkRzw2Db0lqyZe0vOUCuS+WieH7WE0ttAlkc27Wok7tFbGWQ/ItG4ZS
        vzdhK6Ea6r+RIlQOrxYxDZl8du4CLT/Mqy5ZHll7p+xydP6kThbZbDMEU/jDHbRM
        wSVI7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=KyvhXjB5DdFettsz9BCOqHLXK5wPN6w15uaxcR0ju
        eY=; b=O854i+9yi0NoUPthyXezXO261AjR/d6v7HnPjiHRJdw/Jx3AA84b6upw0
        RFM86AqDYX+XAivrs4F1Jftl4CBoF152UfNZC2y95Sl6p8/RBO0ZTimFPolkgFcg
        J0mdkKWrgVpT5b6SADDMyxG4cb27h/0EwU24UmQYH4q2kOe+/RJyaHwUR6xmeCej
        JrzdkdTKV5hbyjX0F5/wyYbgI2cFyoaj/xTS7nQMPjN9UE1P5perydJTl131XXKf
        qo5j4bRdfK/EAQVaLBVjwMobHqG9+mQaSPXPSv5rnHOss48o/WjuBC4tCQasVPwH
        FXd87Df2/F++wZnShVZ3eVsHr2zbQ==
X-ME-Sender: <xms:6pSGXkdHxUvI6wlmnAbrK1IhF4RG_jpiEwxWWlIYz4vFQvMKLdnMrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    duieeirddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:6pSGXnwfhJE9N0v1qesQ14JQMfUdxALscI2X0tTbRm_x9mGm6FudxQ>
    <xmx:6pSGXr22pq9nSguKU9WXSf6z6T8RAxP-KcQWIzw_azBWppVaSkjMUg>
    <xmx:6pSGXlzVC2JgYjpSWiUJF1qr6HHJ2FUWJxxDMVCEktQZmsruDI_grw>
    <xmx:65SGXhje8TwcSnI3ENAKN-q0A7TP3GpKJnBHff2RR7XgGd8RC_5abQ>
Received: from centos8 (unknown [118.209.166.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA752306CEE4;
        Thu,  2 Apr 2020 21:44:05 -0400 (EDT)
Message-ID: <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Date:   Fri, 03 Apr 2020 09:44:01 +0800
In-Reply-To: <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
         <1445647.1585576702@warthog.procyon.org.uk>
         <2418286.1585691572@warthog.procyon.org.uk>
         <20200401144109.GA29945@gardel-login>
         <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
         <2590640.1585757211@warthog.procyon.org.uk>
         <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
         <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
         <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-9.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-04-02 at 15:52 +0200, Miklos Szeredi wrote:
> On Thu, Apr 2, 2020 at 4:52 AM Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2020-04-01 at 18:40 +0200, Miklos Szeredi wrote:
> > > On Wed, Apr 1, 2020 at 6:07 PM David Howells <dhowells@redhat.com
> > > >
> > > wrote:
> > > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > 
> > > > > I've still not heard a convincing argument in favor of a
> > > > > syscall.
> > > > 
> > > > From your own results, scanning 10000 mounts through mountfs
> > > > and
> > > > reading just
> > > > two values from each is an order of magnitude slower without
> > > > the
> > > > effect of the
> > > > dentry/inode caches.  It gets faster on the second run because
> > > > the
> > > > mountfs
> > > > dentries and inodes are cached - but at a cost of >205MiB of
> > > > RAM.  And it's
> > > > *still* slower than fsinfo().
> > > 
> > > Already told you that we can just delete the dentry on
> > > dput_final, so
> > > the memory argument is immaterial.
> > > 
> > > And the speed argument also, because there's no use case where
> > > that
> > > would make a difference.  You keep bringing up the notification
> > > queue
> > > overrun when watching a subtree, but that's going to be painful
> > > with
> > > fsinfo(2) as well.   If that's a relevant use case (not saying
> > > it's
> > > true), might as well add a /mnt/MNT_ID/subtree_info (trivial
> > > again)
> > > that contains all information for the subtree.  Have fun
> > > implementing
> > > that with fsinfo(2).
> > 
> > Forgive me for not trawling through your patch to work this out
> > but how does a poll on a path get what's needed to get mount info.
> > 
> > Or, more specifically, how does one get what's needed to go
> > directly
> > to the place to get mount info. when something in the tree under
> > the
> > polled path changes (mount/umount). IIUC poll alone won't do
> > subtree
> > change monitoring?
> 
> The mechanisms are basically the same as with fsinfo(2).   You can
> get
> to the mountfs entry through the mount ID or through a proc/fd/ type
> symlink.  So if you have a path, there are two options:
> 
>  - find out the mount ID belonging to that path and go to
> /mountfs/$mntid/
>  - open the path with fd = open(path, O_PATH) and the go to
> /proc/self/fdmount/$fd/
> 
> Currently the only way to find the mount id from a path is by parsing
> /proc/self/fdinfo/$fd.  It is trivial, however, to extend statx(2) to
> return it directly from a path.   Also the mount notification queue
> that David implemented contains the mount ID of the changed mount.

I'm aware the mount id comes through David's notifications, I was
wondering how to get that via your recommendation, thanks.

In your scheme it sounds like the mount id doesn't hold the
importance it deserves, it's central to the whole idea of getting
information about these mounts. But it sounds like you need to
open fds to paths you might not know to find it ...

Your explanation wasn't clear on how one gets notifications of
events within a tree under a mount you've opened an fd on to
get events?

> 
> > Don't get me wrong, neither the proc nor the fsinfo implementations
> > deal with the notification storms that cause much of the problem we
> > see now.
> > 
> > IMHO that's a separate and very difficult problem in itself that
> > can't even be considered until getting the information efficiently
> > is resolved.
> 
> This mount notification storm issue got me thinking.   If I
> understand
> correctly, systemd wants mount notifications so that it can do the
> desktop pop-up thing.   Is that correct?
> 
> But that doesn't apply to automounts at all.  A new mount performed
> by
> automount is uninteresting to to desktops, since it's triggered by
> crossing the automount point (i.e. a normal path lookup), not an
> external event like inserting a usb stick, etc...
> 
> Am I missing something?

Yeah, you're not missing anything.

Unfortunately, in a recent discussion on the autofs mailing list,
an investigation showed that systemd does want/get events for
autofs mounts and proceeds to issue around a 100 or so events on
the d-bus for every one.

> 
> Maybe the solution is to just allow filtering out such notifications
> at the source, so automount triggers don't generate events for
> systemd.

Except that autofs automounts might be expected to be seen on a
desktop, that's not out of the question I guess.

Ian

