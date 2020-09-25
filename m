Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D8278A3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIYOBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgIYOBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:01:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD61FC0613CE;
        Fri, 25 Sep 2020 07:01:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x14so2862101oic.9;
        Fri, 25 Sep 2020 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gwKAD82cAi9ifIdOh2K2TtI0GczDqHfjnVkzQYsupRk=;
        b=CxjJg7ITauNmQYCwDH1y1UzbWZVEHuUOimRzldyd43wJA39wGbTFPu0xabz/BI1vmb
         mXuAiis82gUs0Oz75tySKZc+4aqW6qTvSY2BBDRwZKLbokdpAqSo0jBQSM4bob6apUB9
         WbkD0HZd8Wa9DSbc1yR3eaQQMtHYyzXNqrDForeWrIieZZf+d0dIIF9EBCJkZWUmDXiq
         IR0zvSbQIqpDuXn+f+36X77tqX3i2lRtvJeTgYXSOa1kXDUg8YLZ0JMhbUEYCUKLO7iB
         jNNxhswaQgHVQokM6USHeW3AofT0/t2N9uozwIZHBRQruYQyWghYxJA2TTXtf4rNkeyQ
         5shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gwKAD82cAi9ifIdOh2K2TtI0GczDqHfjnVkzQYsupRk=;
        b=aKDbUP3NBQoCsMcfyCEYq1xyNtYvrXMQ6nrqbl+Wh+EJfdaM0McwfCo6kdtF/R6m/Z
         WE/CafOI9JRB3qIDBSgFfovuJ7e6pqiFevApDE2KWXQmMdgiiTy/M0VNqtm9N/2QUldR
         2SeInBCpqJyBQnJ2JEB68vk0YbCH/ChW3Py+N+dg5aLn2wU4djAoXsCEQXQUeXwkP+uB
         znzYA9sBgE45VUh9TIZIPAB5PW4omimmZQlJbml3je1T6d5A7Kj5kViZf/8lX7iPm4nD
         B0+axZTtNNCGKI+DJbyxv5FLbi9QJGfJh/fa/ecBGGvui2mTbkXbjGvSGN9fD40AjDnC
         X56g==
X-Gm-Message-State: AOAM532x3f8ms9wLC6zCr3A1fO8agAh2M1hi4R2+LYtMiYHihKPcUZ8z
        FnUlO+G/ITQjv6nsP0gXU4uJ1rA3ePbGQKjqQrQ=
X-Google-Smtp-Source: ABdhPJwJsu0EERw15KoAH6q+6XWiMNDnJQeK8TeUbf0cS9a/pGgyZOuyRazKbu818sAhEmrKNw+pRuisCsHy+Gm59cY=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr319704oih.35.1601042474087;
 Fri, 25 Sep 2020 07:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org> <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com> <20200925134608.GE32101@casper.infradead.org>
In-Reply-To: <20200925134608.GE32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 25 Sep 2020 16:01:02 +0200
Message-ID: <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 3:46 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 25, 2020 at 03:36:01PM +0200, Sedat Dilek wrote:
> > > I have applied your diff on top of Linux v5.9-rc6+ together with
> > > "iomap: Set all uptodate bits for an Uptodate page".
> > >
> > > Run LTP tests:
> > >
> > > #1: syscalls (all)
> > > #2: syscalls/preadv203
> > > #3: syscalls/dirtyc0w
> > >
> > > With #1 I see some failures with madvise0x tests.
>
> Why do you think these failures are related to my patches?
>

Oh sorry, I was not saying it is related to your patches and I am not
familiar with all syscalls LTP tests.

You said:
> Qian reported preadv203.c could reproduce it easily on POWER and ARM.
> They have 64kB pages, so it's easier to hit.  You need to have a
> filesystem with block size < page size to hit the problem.

Here on my x86-64 Debian host I use Ext4-FS.
I can setup a new partition with a different filesystem if this helps.
Any recommendations?

How does the assertion look like in the logs?
You have an example.

Here on Debian I switched over to a newer kernel-libc and
kernel-headers - I guess it's good to recompile a recent LTP from Git
against this new stuff.
In my install-logs I have seen some packages where re-built against
new kernel-libc (capabilities etc.).

- Sedat -


- Sedat -
