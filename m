Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD86910CFCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 23:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfK1Wra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 17:47:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40284 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1Wra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:47:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id m15so23361590otq.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 14:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUk7v7UPe6VTRCevALfgnUC9KL2cGJpFHn8mL3idLe0=;
        b=Y8Ea/smQHjouC6SBRXFZkjwTn2tarmmechSnFeym66dooOOnkxhT2nHCmkSARtdQUe
         ZXdW78yhSFGWQa9ZEKD+TSdGevk4bhR+ccadD5qPzyAVHBSeBpKWvJNNtVxHxWYdKSlw
         tsLHHiQ1/WZPQ7fJQVfpJxtzU5skIztwBNzX5XZeRT1BCWYgL3D14cJyuo171iKI4apV
         7E/2u7t3FvJMNVr/zLBD1kmeCWN/E3GUMZmzjsEZ0yKeEv5iUJpSKP1JivJYGprcKcsb
         cVpqaAEL62COc9FyK1lg2vZAtfyTW3MfKZ4yqB7r/BorGWp6TDqqVlQRslci132N+iyF
         Zafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUk7v7UPe6VTRCevALfgnUC9KL2cGJpFHn8mL3idLe0=;
        b=ShTVI4/tTDj8J+fqnIH+NNp5+hjEf2Hjci9RtetoYYWhIzX//EiwL7gOZajlUboTMC
         wRRU/R1YlD1Si7vkslo1t9Tl6G8TyjYz7NKyx8ICmW+HIdknga/6I2niADwu2lWUpWob
         rQHF4KeR+Nrr5//TXxBsszZn/MwHIYIUVOJgO8d2V3N8vpRzw17EK+AVOzVZJ005jN9I
         OgnW+v1GCABaUT7yubY3ZH0MK8KiE0d1KMAS6dfHXeFmU6H9CfEllMDLCe5d4VNkbBB9
         Q/voDM8AbRYWvMyNwDFzUuAKAj4tjxm62MGmmTXiH+kOe5n1wbcHdQo3Nrx04tFXn7dO
         7+xA==
X-Gm-Message-State: APjAAAXhTrLc1wn6z38VvC5c5MsLd8u44UaC+rvEG+cqVgjpUYxPFX8o
        JymItbJMBF6bLZd0HUdHft9W5dOyOKKDQE5qnuW2xA==
X-Google-Smtp-Source: APXvYqwtrGRoVpfoYUQbpfscgR1YvjNIoEJwTjGpNh374JxCwGJYz8mI0UDKMJGK2aEAi5yUqMGk7HFD34Er13qtUfQ=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr8740496otf.32.1574981248999;
 Thu, 28 Nov 2019 14:47:28 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk> <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
 <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk> <CAG48ez1v5EmuSvn+LY8od_ZMt1QVdUWqi9DWLSp0CgMxkL=sNg@mail.gmail.com>
 <CAG48ez1FK6h4tEv=cGGtm84NXDkeiMV+woFmqQYPbcsOZjKxZw@mail.gmail.com>
In-Reply-To: <CAG48ez1FK6h4tEv=cGGtm84NXDkeiMV+woFmqQYPbcsOZjKxZw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 23:46:59 +0100
Message-ID: <CAG48ez11PjWtaFrPqtU6yPKsm0_0Sb3Te-8bvVQLEozDzx7cFw@mail.gmail.com>
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

On Thu, Nov 28, 2019 at 8:18 PM Jann Horn <jannh@google.com> wrote:
> On Thu, Nov 28, 2019 at 11:07 AM Jann Horn <jannh@google.com> wrote:
> > On Thu, Nov 28, 2019 at 10:02 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > > On 28/11/2019 00.27, Jann Horn wrote:
> > >
> > > > One more thing, though: We'll have to figure out some way to
> > > > invalidate the fd when the target goes through execve(), in particular
> > > > if it's a setuid execution. Otherwise we'll be able to just steal
> > > > signals that were intended for the other task, that's probably not
> > > > good.
> > > >
> > > > So we should:
> > > >  a) prevent using ->wait() on an old signalfd once the task has gone
> > > > through execve()
> > > >  b) kick off all existing waiters
> > > >  c) most importantly, prevent ->read() on an old signalfd once the
> > > > task has gone through execve()
> > > >
> > > > We probably want to avoid using the cred_guard_mutex here, since it is
> > > > quite broad and has some deadlocking issues; it might make sense to
> > > > put the update of ->self_exec_id in fs/exec.c under something like the
> > > > siglock,
> > >
> > > What prevents one from exec'ing a trivial helper 2^32-1 times before
> > > exec'ing into the victim binary?
> >
> > Uh, yeah... that thing should probably become 64 bits wide, too.
>
> Actually, that'd still be wrong even with the existing kernel code for
> two reasons:
>
>  - if you reparent to a subreaper, the existing exec_id comparison breaks

... actually, I was wrong about this, this case is fine because the
->exit_signal is reset in reparent_leader().
