Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6EF10CED1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 20:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfK1TT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 14:19:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40814 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfK1TT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:19:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id d22so24113294oic.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sa7Qo9GWk7jIcVb/UqPiStHbvEoHinr+Eez2kcCOf1c=;
        b=F8QNZvQZFDC4R29kvG1rBgKm1kpx6PZbsIqFU0WaDGkxK0KPMas53EVmUrCxZEWKu+
         TyLjB1Ji+sFJdqf10OEg/Jozf5L3+00M4S1V7iG1JEs3oz9wCN28WolNCGBvlMTdIfFE
         bCJSycpiYuwAopQg9Lp7fG1kSZUha7EtNo2xhBUGQxHctbro13ju+XhNyk2oV0lydZPA
         7tAjfzfqTCfQ8IlhZZ5l5iKkHtTTOt3RdXbCxk14A3d3bohxQt8+j1GpA3cJOQ0/5B1z
         fRu4mh07clHKxnURShciN+a3Sjz8/CkJmxPsT2gWtE03/BSgjSI3V1fToG8TUdB/kN8q
         mkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sa7Qo9GWk7jIcVb/UqPiStHbvEoHinr+Eez2kcCOf1c=;
        b=KH7sLZx8SNnzKRXKc+qpGeb6lEpbRG2Zejx9ijXMXjOezVeQcCeRrdChfMOWqV/E5r
         Rt9NrZgCLixST7fCyGIuSv4uCJ0iO75tTYyeQKy6VstMNu0sTiyYpZ2ZDe10c4Y8aFiZ
         ICCqM3nooYfK0+5Qrz/RQ1WUI7EKoRfRxnoIpyqnDYOV5bhePIUDJvPoHTGTgzgxxush
         JxIEpvEulcZdxKuBBXA9cN4PZuL9XCGoQd5o8rlGet0zWbChRqZ5Cjxido+Nzy25L081
         gQ1RwTgXIoHiEQ33mPmawAlZ3PHpJflhzQe+HyYqt+/yglouFsc7UzeeVNS6jtN9EoOw
         pmUQ==
X-Gm-Message-State: APjAAAVZtxSxFNnXzQ/ZU7UNysFZ2mJK/XxqEMVOWTflkug/lz4kyPHb
        GrZxFSJJdyH1u51rpFp7IZdooBfgoHZCpY+DLzuyCw==
X-Google-Smtp-Source: APXvYqzumrng90jkIfbBLU7fDZd/qU3JI2V43WqgFg86Aeyg+t0BewnS9HPGkbBeXtjVOMeJs9BXjig5wfJCdgaE2LI=
X-Received: by 2002:aca:ccd1:: with SMTP id c200mr9810023oig.157.1574968766126;
 Thu, 28 Nov 2019 11:19:26 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk> <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
 <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk> <CAG48ez1v5EmuSvn+LY8od_ZMt1QVdUWqi9DWLSp0CgMxkL=sNg@mail.gmail.com>
In-Reply-To: <CAG48ez1v5EmuSvn+LY8od_ZMt1QVdUWqi9DWLSp0CgMxkL=sNg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 20:18:55 +0100
Message-ID: <CAG48ez1FK6h4tEv=cGGtm84NXDkeiMV+woFmqQYPbcsOZjKxZw@mail.gmail.com>
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 28, 2019 at 11:07 AM Jann Horn <jannh@google.com> wrote:
> On Thu, Nov 28, 2019 at 10:02 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > On 28/11/2019 00.27, Jann Horn wrote:
> >
> > > One more thing, though: We'll have to figure out some way to
> > > invalidate the fd when the target goes through execve(), in particular
> > > if it's a setuid execution. Otherwise we'll be able to just steal
> > > signals that were intended for the other task, that's probably not
> > > good.
> > >
> > > So we should:
> > >  a) prevent using ->wait() on an old signalfd once the task has gone
> > > through execve()
> > >  b) kick off all existing waiters
> > >  c) most importantly, prevent ->read() on an old signalfd once the
> > > task has gone through execve()
> > >
> > > We probably want to avoid using the cred_guard_mutex here, since it is
> > > quite broad and has some deadlocking issues; it might make sense to
> > > put the update of ->self_exec_id in fs/exec.c under something like the
> > > siglock,
> >
> > What prevents one from exec'ing a trivial helper 2^32-1 times before
> > exec'ing into the victim binary?
>
> Uh, yeah... that thing should probably become 64 bits wide, too.

Actually, that'd still be wrong even with the existing kernel code for
two reasons:

 - if you reparent to a subreaper, the existing exec_id comparison breaks
 - the new check here is going to break if a non-leader thread goes
through execve(), because of the weird magic where the thread going
through execve steals the thread id (PID) of the leader

I'm gone for the day, but will try to dust off the years-old patch for
this that I have lying around somewhere tomorrow. I should probably
send it through akpm's tree with cc stable, given that this is already
kinda broken in existing releases...
