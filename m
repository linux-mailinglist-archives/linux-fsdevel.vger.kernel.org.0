Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30269216EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 16:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGGOai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 10:30:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53030 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgGGOag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594132235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdHAIpfWqWHafM+znmNZIJaMTPI5wENHSEaIJXcuW90=;
        b=QtjyHM5Vhk3tsIQUdAhndT/azb5HdOsoaNmBHqOyjEI52JDzIFrM748+hqW5J8OOQAMjkI
        nQC0uF1t73GIRU8tqucFxfVI+iI5wVsOZLi3w7kZDZ4Z4BaIbdTxbG2ET/hnGkQWHV8XY6
        TikitstwpO6C5XElSHKg9hDDEI5CeC8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-6KkJ2UZnP3qJ653a63IN4A-1; Tue, 07 Jul 2020 10:30:32 -0400
X-MC-Unique: 6KkJ2UZnP3qJ653a63IN4A-1
Received: by mail-oo1-f71.google.com with SMTP id p68so9266506oop.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 07:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdHAIpfWqWHafM+znmNZIJaMTPI5wENHSEaIJXcuW90=;
        b=YKUYZFvF3nyTklPofDq+gDUqvCkq++JZJMv9RhDdeFg3nKeQqY4HYXvSlhIYPfeXD5
         Uz4TEJTA3QEndhFo2fKjRPJELNBDbcQMuW0s4+DvfD9Cl/efshtRWrYxU6/ZAv+EGYdu
         N+dSvXYFXkktbHPBnfXD3U/kjOxIz28wEsjqpqS79AXoY67WKDa0YTU9GJ3af7B0kAQK
         n6nTsXPk6txQT07yN+fR5rLMNscNIQIdufBdc1JYA08SVZhLWtpdVOehxM6GIB8y8RKI
         c93lwVQNwJ0Bdm2h3O1/h2qeaUd455eVC/Qth2roFfOCcv6N4wT5ys5Bf8VdFB6/Du0b
         92kQ==
X-Gm-Message-State: AOAM531HyGi73XUnJs+c07Jy6FKcbdnDo1KAB8y1ucm4fPcgj1eJYPZ2
        /cHA1z58wAtQgIGMFv47iI1n7CC2PgoVHFO9x4gpnUrJ2hwT1K9tgLhKwmTbwqemqJYMoLckQS/
        R1GbBD3GfGy+A6YrJHSYGHPeHK0aCIcxm9uJrOv7shQ==
X-Received: by 2002:a4a:868a:: with SMTP id x10mr47045444ooh.31.1594132231279;
        Tue, 07 Jul 2020 07:30:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkyrmC9YyVoZKCHhEbKVmEbE0QU21dPZEuBspnOoCY6PvjRo2XRprybq1+LMm+sMOQeYKXQRvYJk4hHGy4wPw=
X-Received: by 2002:a4a:868a:: with SMTP id x10mr47045402ooh.31.1594132230968;
 Tue, 07 Jul 2020 07:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 7 Jul 2020 16:30:19 +0200
Message-ID: <CAHc6FU6LmR7m_8UHmB_77jUpYNo-kgCZ-1YTLqya-PPqvvBy7Q@mail.gmail.com>
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

On Thu, Jul 2, 2020 at 8:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> > shouldn't trigger any filesystem I/O for the actual request or for
> > readahead.  This allows to do tentative reads out of the page cache as
> > some filesystems allow, and to take the appropriate locks and retry the
> > reads only if the requested pages are not cached.
>
> This looks sane to me, except for this part:
> >                 if (!PageUptodate(page)) {
> > -                       if (iocb->ki_flags & IOCB_NOWAIT) {
> > +                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
> >                                 put_page(page);
> >                                 goto would_block;
> >                         }
>
> This path doesn't actually initiate reads at all - it waits for
> existing reads to finish.
>
> So I think it should only check for IOCB_NOWAIT.

It turns out that label readpage is reachable from here via goto
page_not_up_to_date / goto page_not_up_to_date_locked. So IOCB_NOIO
needs to be checked somewhere. I'll send an update.

Andreas

