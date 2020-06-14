Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E61F864E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jun 2020 05:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgFNDHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 23:07:55 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35735 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbgFNDHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:07:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id E7AD84A2;
        Sat, 13 Jun 2020 23:07:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 13 Jun 2020 23:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        rVTXaitnSkKOsrvPXgD4GPCoz8JiwHZXAjq9rig9rYg=; b=KEcU2L6sJVaklxlW
        ly4adwsoU0jBK+EOoSSsTq6+CKOaXowvcPKf0aXISmGNUW0LksFhkosvOnifDfu+
        PZG+FX4uyNu3We1xEeBNQJ3z0VLn8BGAJ7StNtvqcS4PWyNuXegbNssG2VAnlC9j
        pZS9QuikjDTYWQpd3XTbs0fQCdnHOneIVECurAiUGEKCCAZRS9t1sarvpv6926Lv
        T5VFvlazph9GqI+/wl6/iTYxho6l10nlbPmL3BvtHgFlgKMCj1o/ACHIk5tDJoHm
        XF5V3NxPwmlonyej1NJx2LPdv1K328yw94HcCzIm6K+KQ7cy+MJRDhbqe5y149+/
        g9QVKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=rVTXaitnSkKOsrvPXgD4GPCoz8JiwHZXAjq9rig9r
        Yg=; b=TGEpV4Og9jfsA7r+RjCnv23FfkIn/3sxhnmH3j9xDi5cnqyVEHyFI3Dbm
        xojGEebEfw8hY70/4F+KrLYlmp7Uz4GJ7HrFvf8uSP1RJh68jj/QCBU9oR1CumQF
        mwDZ9CmqiQkqyMx5aLCQ02efEmXJRunJ8xPXK1bJ6cO1s0lYhLBVAhsIZsJ9oZaJ
        AHC1AosA2cXN5n69gXVuXPJjwZGQ1vgt7VDeYwYXpN8fLJpdN5EWnxKc0UJEVFUY
        D/yilCxpJfxJXm+9gtqskVryIJEVAO80FI0/kE9E8bs653ODG9PAaahZO7UkL/wl
        P/lJEeIBXqPCVM6NDGJW3PZ8LO3Lw==
X-ME-Sender: <xms:h5TlXrN47VIjnvpYDt1eyXdrq3DnyPV_pnqyf1659gacM6f3Ja-sJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeigedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepheekrdejrddvvddtrdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:h5TlXl9Sh3AqgFvvMfVQwtzxUTnCkpEtv5FmnFHXWxXBB7KmbaLSNg>
    <xmx:h5TlXqTEk8b_RUqARBhsHqPWg8jBHnwjSq2c8djf3SMJZz8igtqnww>
    <xmx:h5TlXvt9qROB3b_gmh5oFmhjrlBCq9U9_iM6pVdOjpeZ2luNHDaCDQ>
    <xmx:iJTlXh3BZUuJwkYXV_cj-Mzzf-CEdSLXHNlvhHM3A3kzixURy582zCRvISE>
Received: from mickey.themaw.net (58-7-220-47.dyn.iinet.net.au [58.7.220.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 062B53280059;
        Sat, 13 Jun 2020 23:07:45 -0400 (EDT)
Message-ID: <0991792b6e2af0a5cc1a2c2257b535b5e6b032e4.camel@themaw.net>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and
 attribute change notifications [ver #5]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Sun, 14 Jun 2020 11:07:42 +0800
In-Reply-To: <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-04-02 at 17:19 +0200, Miklos Szeredi wrote:
> 
> > Firstly, a watch queue needs to be created:
> > 
> >         pipe2(fds, O_NOTIFICATION_PIPE);
> >         ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
> > 
> > then a notification can be set up to report notifications via that
> > queue:
> > 
> >         struct watch_notification_filter filter = {
> >                 .nr_filters = 1,
> >                 .filters = {
> >                         [0] = {
> >                                 .type = WATCH_TYPE_MOUNT_NOTIFY,
> >                                 .subtype_filter[0] = UINT_MAX,
> >                         },
> >                 },
> >         };
> >         ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
> >         watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);
> > 
> > In this case, it would let me monitor the mount topology subtree
> > rooted at
> > "/" for events.  Mount notifications propagate up the tree towards
> > the
> > root, so a watch will catch all of the events happening in the
> > subtree
> > rooted at the watch.
> 
> Does it make sense to watch a single mount?  A set of mounts?   A
> subtree with an exclusion list (subtrees, types, ???)?

Yes, filtering, perhaps, I'm not sure a single mount is useful
as changes generally need to be monitored for a set of mounts.

Monitoring a subtree is obviously possible because the monitor
path doesn't need to be "/".

Or am I misunderstanding what your trying to get at.

The notion of filtering types and other things is interesting
but what I've seen that doesn't fit in the current implementation
so far probably isn't appropriate for kernel implementation.

There's a special case of acquiring a list of mounts where the
path is not a mount point itself but you need all mount below
that path prefix.

In this case you get all mounts, including the mounts of the mount
containing the path, so you still need to traverse the list to match
the prefix and that can easily mean the whole list of mounts in the
system.

Point is it leads to multiple traversals of a larger than needed list
of mounts, one to get the list of mounts to check, and one to filter
on the prefix.

I've seen this use case with fsinfo() and that's where it's needed
although it may be useful to carry it through to notifications as
well.

While this sounds like it isn't such a big deal it can sometimes
make a considerable difference to the number of mounts you need
to traverse when there are a large number of mounts in the system.

I didn't consider it appropriate for kernel implementation but
since you asked here it is. OTOH were checking for connectedness
in fsinfo() anyway so maybe this is something that could be done
without undue overhead.

But that's all I've seen so far.

Ian

