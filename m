Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F121D2EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgENLqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgENLqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 07:46:21 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9AAC061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 04:46:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so2105861edq.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UevIGmxVqy7MbzvCxNsgljlZgKGihjq+cu00TRG2HKY=;
        b=mLSeB1NB/XbOKA7AjR+UwRKZTO/wgZ+NP5DhH0IDdWN0W+1LheMra7cRnIhlxOnP4E
         nPfenc743lM1hLk30+rEeJUPZTUhqhwGltWULAsBfnswko5RItRcQT+UbQH8RMcW1Npu
         xReVKG3COmH7N/wNNEbLA4bTOiesOosLVJbzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UevIGmxVqy7MbzvCxNsgljlZgKGihjq+cu00TRG2HKY=;
        b=S6tYu92+eR9qWgdEq5xeFwa3TVYna60SOPxZaJvfZl+X2lfbaD1QdzJosKjM22YUXM
         taxXHfc2Nc31o8wopMGonJhQWWfesxgtM78NQvqPrwFjG50EtUTChohuC872DXbFyXKX
         D39g+XNyGHB/ilu6bX85l6FaGrSdWCRIk7xcAh16Twb7vKTswSqNhB+keHGzkexyKSM3
         Yy0yt0oj9AiXhaCLhyM0qjQ5u8s97UjsSiwZ+wIy77jB8DvCkDhg9yURKRAiwDBOb7Wt
         HSEEjLr+xm9JMU563mDTXV6JGQK8aPSb6kW31e+8Lj+xbqSz5LBbtEn+x1AKZe/+Tj4w
         g1zA==
X-Gm-Message-State: AOAM531nUcW9Foz5fG5ZovfYeul2H49gHiR5e5ZkwQ67H8LECPJ18QmH
        eb3hfmhJ4FTzLMXD4x6TyKOMum0os0JOr5wVeqdWkQ==
X-Google-Smtp-Source: ABdhPJyJ11cBmICgs9+6mw2TmbskU4wKTp64tdU4P6Y7+GSlmiGDUi119OTXvvbRjGdFfIbZmnFqjQdESqDg9G/9CVc=
X-Received: by 2002:a05:6402:1296:: with SMTP id w22mr3316046edv.364.1589456778758;
 Thu, 14 May 2020 04:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200505095915.11275-1-mszeredi@redhat.com> <CAJfpegtNQ8mYRBdRVLgmY8eVwFFdtvOEzWERegtXbLi9T2Ytqw@mail.gmail.com>
 <20200513194850.GY23230@ZenIV.linux.org.uk>
In-Reply-To: <20200513194850.GY23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 May 2020 13:46:06 +0200
Message-ID: <CAJfpegvg0bXK=1N+GBPs=MYZMU1f2RxJ_0kGKb6z4RKrPrmuqg@mail.gmail.com>
Subject: Re: [PATCH 00/12] vfs patch queue
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 9:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, May 13, 2020 at 09:47:07AM +0200, Miklos Szeredi wrote:
> > On Tue, May 5, 2020 at 11:59 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > Hi Al,
> > >
> > > Can you please apply the following patches?
> >
> > Ping?  Could you please have a look at these patches?
> >
> > - /proc/mounts cursor is almost half the total lines changed, and that
> > one was already pretty damn well reviewed by you
> >
> > - unprivileged whiteout one was approved by the security guys
> >
> > - aio fsync one is a real bug, please comment on whether the patch is
> > acceptable or should I work around it in fuse
> >
> > - STATX_MNT_ID extension is a no brainer, the other one may or may not
> > be useful, that's arguable...
> >
> > - the others are not important, but I think useful
> >
> > - and I missed one (faccess2); amending to patch series
>
> I can live with that, modulo couple of trivial nits.  Have you tested the
> /proc/mounts part for what happens if it's opened shitloads of times,
> with each instance lseek'ed a bit forward (all to the same position, that
> is)?  That, in principle, allows an unpriveleged user to pile a lot of list
> entries and cause serious looping under a spinlock...

Hmm, indeed.

Did some testing: a single loop takes on the order of 40ns.  To
trigger the soft lockup detector it would take 20s/40ns=500M cursors.
Each new cursor is added after the existing ones, so inserting 500M
cursors would take 40ns*500M^2/2 = ~158 years.  That's obviously not a
great way to DoS the system.

I understand that 100ms could be a serious problem in some cases, but
even that would take 34 hours to set up.

Is less than that still a worry?   I don't really know how much effort
is needed (if at all) in order to make this a non-issue.

Thanks,
Miklos
