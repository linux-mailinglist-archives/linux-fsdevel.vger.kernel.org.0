Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0383F5111
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhHWTN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 15:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhHWTNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629745987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jhaMcYrw2lrnaBdCd+giUeZH7Ccr515F+el79Rmo7nk=;
        b=Z4dHd9WMY+VGMICN6TPp1s4dMwkDpLbetOu/bDcxjjj7aGPwXcxCbz+LMei4I+5JfsiwFg
        r5aAsMa/SjuoE9wLwWQ0Lj29DFMz8q+DN0KXCoWJB0NN1ChKM+2sQUZonvJqBqATy365jK
        MM8BXGhwr856iRmrNrX29XXMxD0hqDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-CvEqEEMxPCqe-Mxpr6zCpg-1; Mon, 23 Aug 2021 15:13:04 -0400
X-MC-Unique: CvEqEEMxPCqe-Mxpr6zCpg-1
Received: by mail-wm1-f70.google.com with SMTP id g3-20020a1c2003000000b002e751c4f439so86646wmg.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 12:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhaMcYrw2lrnaBdCd+giUeZH7Ccr515F+el79Rmo7nk=;
        b=iCPo+GoRReIk7yE75SCfB4Sn6xJyIk0/CnDmVyomA6vponDclSS8KZnVWTMGQ03C2O
         aOHaeUcn284qR5VudEgneGpN04jkQWce80mmiX2nPHVBPCn8bI+Sep8Bj3+52bEDF0LR
         9elX8dJNg0QnvIR3K9176IfS1+W35P+YDRMlgzmFCaUuTVAVveBi9Z4jrVsdcHJicSMN
         3AKd7JMVkWvGFaMuMFpeZDnfDoUfLrdM2UIh3MjYDd/iDqPVSWCVWrnM2i7Hi4PrbmmK
         Wvg25sF0IVB7f4ybe4th6MjuP+KdhahiBLupD2agelGxMe9hQBdMsiDz1OexDizyC0vV
         UvOQ==
X-Gm-Message-State: AOAM5300niLqORZvCj0t23KT/PAC19DCUnyQo7Uv7rY2/tWJclcI4hB2
        WEi4CS7+cDsTNOdi/hvjwMj/Zy/gt4Rf8Ut6Y4cN9kaA1VgiKb7AKxJOWJQtApmNZZKaJ+JijRt
        LU9JeHhnbjSm/iIqDzhihifdv4F3QzNvvgM8Swu/u6Q==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr7629122wrb.329.1629745983121;
        Mon, 23 Aug 2021 12:13:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOwVKSkOsp25StuMxS8Ul0aw4mKnHx9V9RP7lUqsGktvPh3lqSJ/b7aud/VYi5l7IjlqGElaqaSmdZHcnMVNk=
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr7629112wrb.329.1629745982984;
 Mon, 23 Aug 2021 12:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210819194102.1491495-1-agruenba@redhat.com> <20210819194102.1491495-11-agruenba@redhat.com>
 <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
 <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com> <CAHc6FU7EMOEU7C5ryu5pMMx1v+8CTAOMyGdf=wfaw8=TTA_btQ@mail.gmail.com>
 <8e2ab23b93c96248b7c253dc3ea2007f5244adee.camel@redhat.com>
 <CAHc6FU5uHJSXD+CQk3W9BfZmnBCd+fqHt4Bd+=uVH18rnYCPLg@mail.gmail.com> <YSPHR7EL/ujG0Of7@casper.infradead.org>
In-Reply-To: <YSPHR7EL/ujG0Of7@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 23 Aug 2021 21:12:51 +0200
Message-ID: <CAHc6FU4Qay6v8gRQN_ZWz0AwtuOD-BH6+Ahkgimk0L4GkWLbrQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 6:06 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Aug 23, 2021 at 05:18:12PM +0200, Andreas Gruenbacher wrote:
> > On Mon, Aug 23, 2021 at 10:14 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
> > > If the goal here is just to allow the glock to be held for a longer
> > > period of time, but with occasional interruptions to prevent
> > > starvation, then we have a potential model for this. There is
> > > cond_resched_lock() which does this for spin locks.
> >
> > This isn't an appropriate model for what I'm trying to achieve here.
> > In the cond_resched case, we know at the time of the cond_resched call
> > whether or not we want to schedule. If we do, we want to drop the spin
> > lock, schedule, and then re-acquire the spin lock. In the case we're
> > looking at here, we want to fault in user pages. There is no way of
> > knowing beforehand if the glock we're currently holding will have to
> > be dropped to achieve that. In fact, it will almost never have to be
> > dropped. But if it does, we need to drop it straight away to allow the
> > conflicting locking request to succeed.
>
> It occurs to me that this is similar to the wound/wait mutexes
> (include/linux/ww_mutex.h & Documentation/locking/ww-mutex-design.rst).
> You want to mark the glock as woundable before faulting, and then discover
> if it was wounded after faulting.  Maybe sharing this terminology will
> aid in understanding?

I've looked at the ww_mutex documentation. A "transaction" wounds
another "transaction" and that other transaction then "dies", or it
"heals" and restarts. In the glock case, a process sets and clears the
HIF_MAY_DEMOTE flag on one of its own glock holder contexts. After
clearing the flag, it either still holds the glock or it doesn't;
nothing needs to be done to "die" or to "heal". So I'm not sure we
want to conflate two concepts.

One of the earlier terms we've used was "stealing", with a
HIF_MAY_STEAL flag. That works, but it's slightly less obvious what
happens to a glock holder when the glock is stolen from it. (The
holder gets dequeued, __gfs2_glock_dq.) The glock code already uses
the terms promote/demote, acquire/release, enqueue/dequeue, and
_nq/_dq for various forms of acquiring and releasing a glock, so we're
not in a shortage or names right now apparently.

Thanks,
Andreas

