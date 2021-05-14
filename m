Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF35D38020B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 04:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhENCgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 22:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhENCgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 22:36:06 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16441C061574;
        Thu, 13 May 2021 19:34:55 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f12so23569386ljp.2;
        Thu, 13 May 2021 19:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tw+iRSHNM+JaMrznkMYgjp1kOR7QgkA0e8fJ2WkmgJU=;
        b=qZYXW3AWpxniI+WuYT5suei/E9/wOtIy8qc89jnjFXQvHAUWnhh2hLB1SgaKgICdd5
         VPYLjUgFNSC5Mur/o7XrTOPQ6D0Or8YeImrrn8IVsA4DOn/fSBKTO1qhZ5TR427bsMg7
         n5RhU3OJSj5poLKNOczcBImric1rskFc0NGFQbXRCUWc4ibuxXWvclJIE+OYTc8kALDb
         r+f++F/yt2ai2+ZAd89KhN3Dx2jM2i6BccpR9F+gKgwRrHSHm2wu5KPwSO54ZuFxfQ/n
         2yrrFjg3JQcrAlGlCGSfAdHZ3VdyjTRMdtyQq+I37TwFVzGYIMBo9QG51llQfkXhfXo3
         Eq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tw+iRSHNM+JaMrznkMYgjp1kOR7QgkA0e8fJ2WkmgJU=;
        b=I2RIB49i7QszXSHwWYXGTf4SA4DJKZ8aEhGGHYp7UsEa/WJEBZpJ5CTdkzEYZMBQkN
         2KVNBst2V9rsaVkRdzQ6xBkxoauqhqY1D2NH2jHeR03TNua3z5fCyY2nygoOdmiMBfyf
         DhdaiBpM6po59OgGf7C7pwQFMGSd61nUP5PURcBpnuDqKphuTnLWp/n0zZ17Q3yRxcH5
         A9XyNx0b4IbgZJbXMA/NQpGN2EHjvImUAoJQO2WPGqCJ03806pKe+j+TXR2Q/SCOCVOQ
         4KK7ochJlSIc55EddGcbyS+MuFm/Oze8HAvwUuwahCHx+LsR3H7h/uGlDtVt6XuNBzm8
         BUtw==
X-Gm-Message-State: AOAM531c8kM8AetkXwgmzrYZAc+Dy9I/3R/9SF4WVDj09QByFzP23ufD
        yWjTEeGYK6ENj2+wFxM6dXaNvdCz3imenrjE04o=
X-Google-Smtp-Source: ABdhPJxRqPKT4iqPsvtyry4hX8e24eATZcsriysBT21Iay19Bn1GMSeyQOf+RIWWzoq00Q9qnyoJxNEhvnvBOLpl7/U=
X-Received: by 2002:a2e:9759:: with SMTP id f25mr30613626ljj.304.1620959693522;
 Thu, 13 May 2021 19:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
 <YJtz6mmgPIwEQNgD@kroah.com> <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
 <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
 <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com>
 <4eae44395ad321d05f47571b58fe3fe2413b6b36.camel@themaw.net>
 <CAC2o3DKvq12CrsgWTNmQmu3iDJ+9tytMdCJepdBjUKN1iUJ0RQ@mail.gmail.com> <bc9650145291b6e568a8f75d02663b9e4f2bcfd7.camel@themaw.net>
In-Reply-To: <bc9650145291b6e568a8f75d02663b9e4f2bcfd7.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Fri, 14 May 2021 10:34:41 +0800
Message-ID: <CAC2o3DL1VwbLgajSYSR_UPL-53cjHDp+X63CerQsZ8tgNgO=-A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 9:34 AM Ian Kent <raven@themaw.net> wrote:
>
> On Thu, 2021-05-13 at 23:37 +0800, Fox Chen wrote:
> > Hi Ian
> >
> > On Thu, May 13, 2021 at 10:10 PM Ian Kent <raven@themaw.net> wrote:
> > >
> > > On Wed, 2021-05-12 at 16:54 +0800, Fox Chen wrote:
> > > > On Wed, May 12, 2021 at 4:47 PM Fox Chen <foxhlchen@gmail.com>
> > > > wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I ran it on my benchmark (
> > > > > https://github.com/foxhlchen/sysfs_benchmark).
> > > > >
> > > > > machine: aws c5 (Intel Xeon with 96 logical cores)
> > > > > kernel: v5.12
> > > > > benchmark: create 96 threads and bind them to each core then
> > > > > run
> > > > > open+read+close on a sysfs file simultaneously for 1000 times.
> > > > > result:
> > > > > Without the patchset, an open+read+close operation takes 550-
> > > > > 570
> > > > > us,
> > > > > perf shows significant time(>40%) spending on mutex_lock.
> > > > > After applying it, it takes 410-440 us for that operation and
> > > > > perf
> > > > > shows only ~4% time on mutex_lock.
> > > > >
> > > > > It's weird, I don't see a huge performance boost compared to
> > > > > v2,
> > > > > even
> > > >
> > > > I meant I don't see a huge performance boost here and it's way
> > > > worse
> > > > than v2.
> > > > IIRC, for v2 fastest one only takes 40us
> > >
> > > Thanks Fox,
> > >
> > > I'll have a look at those reports but this is puzzling.
> > >
> > > Perhaps the added overhead of the check if an update is
> > > needed is taking more than expected and more than just
> > > taking the lock and being done with it. Then there's
> > > the v2 series ... I'll see if I can dig out your reports
> > > on those too.
> >
> > Apologies, I was mistaken, it's compared to V3, not V2.  The previous
> > benchmark report is here.
> > https://lore.kernel.org/linux-fsdevel/CAC2o3DKNc=sL2n8291Dpiyb0bRHaX=nd33ogvO_LkJqpBj-YmA@mail.gmail.com/
>
> Are all these tests using a single file name in the open/read/close
> loop?

Yes,  because It's easy to implement yet enough to trigger the mutex_lock.

And you are right It's not a real-life pattern, but on the bright
side, it proves there is no original mutex_lock problem anymore. :)

> That being the case the per-object inode lock will behave like a
> mutex and once contention occurs any speed benefits of a spinlock
> over a mutex (or rwsem) will disappear.
>
> In this case changing from a write lock to a read lock in those
> functions and adding the inode mutex will do nothing but add the
> overhead of taking the read lock. And similarly adding the update
> check function also just adds overhead and, as we see, once
> contention starts it has a cumulative effect that's often not
> linear.
>
> The whole idea of a read lock/per-object spin lock was to reduce
> the possibility of contention for paths other than the same path
> while not impacting same path accesses too much for an overall
> gain. Based on this I'm thinking the update check function is
> probably not worth keeping, it just adds unnecessary churn and
> has a negative impact for same file contention access patterns.
>
> I think that using multiple paths, at least one per test process
> (so if you are running 16 processes use at least 16 different
> files, the same in each process), and selecting one at random
> for each loop of the open would better simulate real world
> access patterns.
>
>
> Ian
>


thanks,
fox
