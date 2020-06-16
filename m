Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEE31FBBD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgFPQfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbgFPQfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:35:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867BC061573;
        Tue, 16 Jun 2020 09:34:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a13so2372929ilh.3;
        Tue, 16 Jun 2020 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeczCUw4VGlryDikP+LHTZeK1GFAMCPROD0ZhbqnYrs=;
        b=Gm4lLSM9A+ctS8aVhfaAp6qbML4FqeZpMI7uwG1szAIWWByRgnf6lYMM7YxjCs18Xu
         zgP9RlQzdlNf0SjhUH3nm/TCMgPGz37e4EjIeMEdb3ViMXGqzUYSZ6mo4E8TFfn1jLHc
         TiUVh+nIsWJXTgUNmz4Xon/LcWRCknH6eJxpPEVAhdjArmMm1Y5lME0+9LrS/AasNObd
         jF/bku34fQs3sSfexAwy6V4XQdKftex58/sCvmkl2BAwsrpH2apC/EiCOoFibwycCXD6
         cmvJVpYLr6NbbxziA06lF8RxJjxTBm9++5hYVJ/O05yRU15w9gYN+WUHUvLdvDG/d6gh
         27PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeczCUw4VGlryDikP+LHTZeK1GFAMCPROD0ZhbqnYrs=;
        b=k9hZpFy2w3kYEJfRJNGPKTz0IfzIZuETziH5KrKCCEt5cfMWLVjEk/h23ba/njqrjK
         EkOgcAi4F8j56osTGwjGWGwcOJePxkm7jLp/+SKAe0gWX+y030579OL/ijBm2vO4IeY5
         5ygylp34hbeWGUgcFLpTjERLHMTMaT21iSh8JlC/Bx88QNa2ff5HmBw6rFtU8sPWu0DN
         xWtcSvZkjYN+eH8+sNlr4fncAbTqsItVNqBqjLsYQIv5nmyIaLcgHU7+G58130Tp7i5D
         P3bvu1oB1Pz7T7LQV7bvea0znzjr1P9gZD9ruooksew2mYSvMgB7cdDuG7wnWaBPLXOd
         XHBg==
X-Gm-Message-State: AOAM530M52dnQ8sUw+Wyjzvzkirz9bW1huEG4jE/C/nrIcTp/yquJW9z
        rWVOJqtJJpsMTwv8lAsxLXteSoDyCf05sSCTDBM=
X-Google-Smtp-Source: ABdhPJxhXeenFpS1jYvSlQ/I3w3cQQR0OvU6gkywev0NM2wczThH3Sn2nTDqy+hP8sM78NP4aHnJjIzazj0QOT+10iQ=
X-Received: by 2002:a92:1fc7:: with SMTP id f68mr4208040ilf.133.1592325298784;
 Tue, 16 Jun 2020 09:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200615160244.741244-1-agruenba@redhat.com> <20200615233239.GY2040@dread.disaster.area>
 <20200615234437.GX8681@bombadil.infradead.org> <20200616003903.GC2005@dread.disaster.area>
 <315900873.34076732.1592309848873.JavaMail.zimbra@redhat.com>
 <20200616132318.GZ8681@bombadil.infradead.org> <CAHc6FU7uU8rUMdkspqH+Zv_O5zi2eEyOYF4x4Je-eCNeM+7NHA@mail.gmail.com>
 <20200616162539.GN11245@magnolia>
In-Reply-To: <20200616162539.GN11245@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 16 Jun 2020 18:34:47 +0200
Message-ID: <CAHpGcMKn64Fi4gOtDzFRUOrOU9fMkYWToXcPPb_4QrUBA_jjxg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 16. Juni 2020 um 18:26 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Tue, Jun 16, 2020 at 03:57:08PM +0200, Andreas Gruenbacher wrote:
> > On Tue, Jun 16, 2020 at 3:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Tue, Jun 16, 2020 at 08:17:28AM -0400, Bob Peterson wrote:
> > > > ----- Original Message -----
> > > > > > I'd assume Andreas is looking at converting a filesystem to use iomap,
> > > > > > since this problem only occurs for filesystems which have returned an
> > > > > > invalid extent.
> > > > >
> > > > > Well, I can assume it's gfs2, but you know what happens when you
> > > > > assume something....
> > > >
> > > > Yes, it's gfs2, which already has iomap. I found the bug while just browsing
> > > > the code: gfs2 takes a lock in the begin code. If there's an error,
> > > > however unlikely, the end code is never called, so we would never unlock.
> > > > It doesn't matter to me whether the error is -EIO because it's very unlikely
> > > > in the first place. I haven't looked back to see where the problem was
> > > > introduced, but I suspect it should be ported back to stable releases.
> > >
> > > It shouldn't just be "unlikely", it should be impossible.  This is the
> > > iomap code checking whether you've returned an extent which doesn't cover
> > > the range asked for.  I don't think it needs to be backported, and I'm
> > > pretty neutral on whether it needs to be applied.
> >
> > Right, when these warnings trigger, the filesystem has already screwed
> > up; this fix only makes things less bad. Those kinds of issues are
> > very likely to be fixed long before the code hits users, so it
> > shouldn't be backported.
> >
> > This bug was in iomap_apply right from the start, so:
> >
> > Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
>
> So... you found this through code inspection, and not because you
> actually hit this on gfs2, or any of the other iomap users?

Bob did, yes. I've only hit those warnings in the very early stages of
gfs2 iomap development, long before that code was even posted for
review.

> I generally think this looks ok, but I want to know if I should be
> looking deeper. :)

It's really supposed to be a simple, straight forward fix only.

Thanks,
Andreas
