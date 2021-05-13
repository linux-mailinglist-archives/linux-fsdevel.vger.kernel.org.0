Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE137FAE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhEMPjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 11:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhEMPjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 11:39:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4DC06175F;
        Thu, 13 May 2021 08:37:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h4so39173433lfv.0;
        Thu, 13 May 2021 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uyn2IBTIkLjB9k01rZMUR5OEPKGWdveEkK33rxkPS8w=;
        b=L0u0rrC8GxqT4Wl04VrQ8cB556v34iFWHE5swPXM6KJcWV1ORAUtToAnAiQkQ9hscY
         azEiTUh8GV9o/3f31em50RcOMqB0K5oG0Q9h0JF5RCdg7Pi/ZnUkn7ABaIUbGJ/rIUrf
         WYtYnnpC8zbGKt2Z7sCne8T0Zi9WpDRNLfiHG/wg8CtKVXrf86aJbEyd8ns9ivVb8FD/
         OUx4PJs3SUTTens6JOIGwH7dkZGgy6b0FkOo4+Zfh2gNIbd3MZ+HNt1cIuuuT5rSeg0x
         bMBuu2iDmHqob1NKlcD886X6iBRIP7MOwCGztS2qfPXupewUCsQowhljy6I1wpSz26rW
         rJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uyn2IBTIkLjB9k01rZMUR5OEPKGWdveEkK33rxkPS8w=;
        b=udbKWh8a9Rx3Jii299Y6P2Cw73KJEcdEp1tUz5U4i03fKoBlxPP3lV3TA3dnoCFLj4
         lviBGl+xBJGtjZavYdT5R9eemEe1ABQP+/CYbce8Sz4jhNCfxO0UPSpfHTI0D5aBkZGK
         dFplB9jZTqvQCfK5QWYIZYuum6jeHqdG6IFozjstlAyMrvfTnXVofR55rQ8Wh6pVQP+d
         wxHjifPBaHeet/6+wWb0uZuhcueJKybmDcJQQrij/RRWMLzFVJBxW/MrZbahodZsSlDW
         r8RivGtPyhfsc8Myw8AfsBVuAvJOlK9IFP61ph6TuJYVWba1upN8EsO13bwftVuMQ4xr
         sJFg==
X-Gm-Message-State: AOAM5333IbzYWz25pnIzx/nMJeNsyE+c7dTNXiTbvYVwwD7ajhJ1H8+n
        PmL6Za7Pk5EXidBtfrMvFv1geTyxvOZ8bM8BEZY=
X-Google-Smtp-Source: ABdhPJza4h+CNXjRDsbfrR3TqIkIwYuZr/8435FEFmT1yAcyVLwt2LuSaMc/O9Cpk2yXGvbqifq94ovMGbmH+EuxOHA=
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr28596792lfl.349.1620920269323;
 Thu, 13 May 2021 08:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
 <YJtz6mmgPIwEQNgD@kroah.com> <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
 <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
 <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com> <4eae44395ad321d05f47571b58fe3fe2413b6b36.camel@themaw.net>
In-Reply-To: <4eae44395ad321d05f47571b58fe3fe2413b6b36.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 13 May 2021 23:37:38 +0800
Message-ID: <CAC2o3DKvq12CrsgWTNmQmu3iDJ+9tytMdCJepdBjUKN1iUJ0RQ@mail.gmail.com>
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

Hi Ian

On Thu, May 13, 2021 at 10:10 PM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2021-05-12 at 16:54 +0800, Fox Chen wrote:
> > On Wed, May 12, 2021 at 4:47 PM Fox Chen <foxhlchen@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I ran it on my benchmark (
> > > https://github.com/foxhlchen/sysfs_benchmark).
> > >
> > > machine: aws c5 (Intel Xeon with 96 logical cores)
> > > kernel: v5.12
> > > benchmark: create 96 threads and bind them to each core then run
> > > open+read+close on a sysfs file simultaneously for 1000 times.
> > > result:
> > > Without the patchset, an open+read+close operation takes 550-570
> > > us,
> > > perf shows significant time(>40%) spending on mutex_lock.
> > > After applying it, it takes 410-440 us for that operation and perf
> > > shows only ~4% time on mutex_lock.
> > >
> > > It's weird, I don't see a huge performance boost compared to v2,
> > > even
> >
> > I meant I don't see a huge performance boost here and it's way worse
> > than v2.
> > IIRC, for v2 fastest one only takes 40us
>
> Thanks Fox,
>
> I'll have a look at those reports but this is puzzling.
>
> Perhaps the added overhead of the check if an update is
> needed is taking more than expected and more than just
> taking the lock and being done with it. Then there's
> the v2 series ... I'll see if I can dig out your reports
> on those too.

Apologies, I was mistaken, it's compared to V3, not V2.  The previous
benchmark report is here.
https://lore.kernel.org/linux-fsdevel/CAC2o3DKNc=sL2n8291Dpiyb0bRHaX=nd33ogvO_LkJqpBj-YmA@mail.gmail.com/

> >
> >
> > > though there is no mutex problem from the perf report.
> > > I've put console outputs and perf reports on the attachment for
> > > your reference.
>
> Yep, thanks.
> Ian
>

thanks,
fox
