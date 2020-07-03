Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1126D2137F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGCJpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 05:45:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgGCJpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593769542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AA5KODddQ3HbG0ydkjTXDrfB0iva22PrfbR0RkgNHDk=;
        b=Ae7VpSksvYLK1fC0q3zkmXPQ6G099gxRyRqPpz0rc7w9j0WMDABcFpytUYgtOY/VlGRoQI
        RbbWYYtIAlWN1sHufFU8TbdbT6j+6k0tpFbWIjBsAnHBjGInRg7juZBALq+oWvMuYFxRCV
        4bRS/UsfpHq3O1QMQNNrHrI4bQ6ELOk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-GJmGwAyYP1aMk0b788Sw4g-1; Fri, 03 Jul 2020 05:45:41 -0400
X-MC-Unique: GJmGwAyYP1aMk0b788Sw4g-1
Received: by mail-ot1-f70.google.com with SMTP id l13so2129985otf.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2020 02:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AA5KODddQ3HbG0ydkjTXDrfB0iva22PrfbR0RkgNHDk=;
        b=uJLGlpq0rdUsSWwz3hiNJYm53deZv1ZjDppSQb54kyQ3DLNPpWvAw2BTpW/lHMKWYH
         C+wIYEUJbz6KfTwdKuwIWBPqqhyqlLyRqWpJEbpZB6os3+CgvqTaOZpSpwW4JgjlKcbw
         3ywOPufSxAQJvDhElz+kcCKPV0OejkQWoZO9d045qMRP+UY08Hd6rbA+RTO+20lk3JqW
         COv9aJR97uitPEgybd01ySzvdBdwntZUnZXDVns92pvYxrF7z5vrQ/az38k1yvATbVsB
         8awPFbNz0pHCuv5bhVzTiLFD194hwRcKr4ZOynwWcd2vB2KmbSisurUg2stapyO679vP
         VQcQ==
X-Gm-Message-State: AOAM5339CuhrJ3Cx1u5MmYBovJL7Xyn4dBdurNQRFWD8OFFUETk5Vcjq
        SNOiXzVRtnZYDiqVbWYdG+yzM0th54Qh3auhLNiZWedDSphaEfQiakYITrBs91pWnrH32yWhixG
        SxNY/yZRfu9t3apsmxxMvG+RVB2V/PwSwsvDxsO8gyA==
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr25164708otg.58.1593769540965;
        Fri, 03 Jul 2020 02:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Ce/YV4Ri2FhaSPK6PoutDZUmwdOzBUZOLe5RemGei+boqUpH8/2S5wzAt2YXKDn+6fKVwICp10PF4itwpMQ=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr25164681otg.58.1593769540566;
 Fri, 03 Jul 2020 02:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
 <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com> <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
In-Reply-To: <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Jul 2020 11:45:29 +0200
Message-ID: <CAHc6FU5rz+2NZwvXqAxSAme9uvY8cGEHjnBmwi0S6NFnHRbUCA@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 10:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 12:58 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > Of course, if you want to avoid both new reads to be submitted _and_
> > > avoid waiting for existing pending reads, you should just set both
> > > flags, and you get the semantics you want. So for your case, this may
> > > not make any difference.
> >
> > Indeed, in the gfs2 case, waiting for existing pending reads should be
> > fine. I'll send an update after some testing.
>
> Do note that "wait for pending reads" very much does imply "wait for
> those reads to _complete_".
>
> And maybe the IO completion handler itself ends up having to finalize
> something and take the lock to do that?
>
> So in that case, even just "waiting" will cause a deadlock. Not
> because the waiter itself needs the lock, but because the thing it
> waits for might possibly need it.
>
> But in many simple cases, IO completion shouldn't need any filesystem
> locks. I just don't know the gfs2 code at all, so I'm not even going
> to guess. I just wanted to mention it.

Yes, that makes sense. Luckily gfs2 doesn't do any such locking on IO
completion.

Thanks,
Andreas

