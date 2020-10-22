Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AA82962D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901906AbgJVQiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502959AbgJVQiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:38:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CC6C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:38:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so3246157wrq.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v7FaFaTdMJ8tRDnhGBi1+id41DhCNPtJjvfWqcIsB1c=;
        b=bWxDfT2Dsx5Kvnhe7Mx+CApRxX2EtdjqCMjmsTK/eYMeEXZsTt0RJpSB3CZxHvRluA
         /C5QuVeAsZ/DeEPdKdhM0E0WGJx2T2v9m3MYhRW4THHYtS+ZE0DpFGmpGRt0IrHa82d0
         Xv3iNh3SjhnIzs4SwmEIXMAdEaKHncc6EizoIKb2cmRXjknWU5304kZN9OG6XDiQpZxH
         SerU5F0hZYBs905dOGoLpPMGvDJuO1BG3E++xZPursi7dE3b9wXy8NHFxPCu5h5w1pZ3
         25XeVxXqCgjjGfO2eAUqnw28i9pF+/kRA21vMvb41oR7Wrr0+/g0yrh0R/IHAXK8n9/9
         E2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7FaFaTdMJ8tRDnhGBi1+id41DhCNPtJjvfWqcIsB1c=;
        b=Rz6vz69YW0RqpzG+2H35sgBN0VweU/4+cLQhytW+DtOaF6AICnjkJqjoyCk4wt3MgW
         yCdpCy9ndpjg+BLCNl0JMLrAmYy3ZYWZeXdONdLtdYvKQGOtjuX7HxmYdeNAFSLZPgMl
         ttby/rUBfaX9C8YowSW96qaPu7YQ4k2SeiTZsgen1UFRmPxZn1qNdwIEjCCXRtoSnuZ5
         0zz7/5h/rNbWS/MqNo2JDSV10l4Gb8xdLze/UR0eNJM4raxY4sKR4yALt9pfYAnJVjTd
         b6XpOJfdQc6CmXi3tsPPhi9tyUJXQlAPSgdsvQIU4OsundOPaW8teRCL+51s6W+i10b/
         ij/Q==
X-Gm-Message-State: AOAM530a0k7lwnth2B696DGZJ1LQLRtm80poUZxoP4IL7AdeBpbktf+U
        3r+DegE1voWHwHy9hTOO8th6Ww==
X-Google-Smtp-Source: ABdhPJxsl1sqM39ATgrwBhkHtsUwIiON9rXgZ+SJgbMLgIv/DRX+c8/hwwiKfb1r2O2AFjrt8HKlnQ==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr3801569wrr.144.1603384703024;
        Thu, 22 Oct 2020 09:38:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id u20sm4013890wmm.29.2020.10.22.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:38:22 -0700 (PDT)
Date:   Thu, 22 Oct 2020 17:38:20 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 4/4] fuse: Handle asynchronous read and write in
 passthrough
Message-ID: <20201022163820.GD36774@google.com>
References: <20200924131318.2654747-1-balsini@android.com>
 <20200924131318.2654747-5-balsini@android.com>
 <CAJfpegueAXqrfdu5WD+WKKmH9cg0BCQd6Q2bHJNS5XUKuxsmtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegueAXqrfdu5WD+WKKmH9cg0BCQd6Q2bHJNS5XUKuxsmtg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:54:03PM +0200, Miklos Szeredi wrote:
> On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Extend the passthrough feature by handling asynchronous IO both for read
> > and write operations.
> >
> > When an AIO request is received, if the request targets a FUSE file with
> > the passthrough functionality enabled, a new identical AIO request is
> > created. The new request targets the lower file system file, and gets
> > assigned a special FUSE passthrough AIO completion callback.
> > When the lower file system AIO request is completed, the FUSE passthrough
> > AIO completion callback is executed and propagates the completion signal to
> > the FUSE AIO request by triggering its completion callback as well.
> 
> This ends up with almost identical code in fuse and overlayfs, right?
> Maybe it's worth looking into moving these into common helpers.
> 
> Thanks,
> Miklos
> 

There are still a few differences between overlayfs and passthrough
read/write_iter(), so that merge wouldn't be straightforward. And I
would love to see this series merged before increasing its complexity,
hopefully in the next version if everything is all right.
I will anyway work on the cleanup patch you suggested right after FUSE
passthrough gets in, so that I have a solid code base to work on.

Would this work for you?

That cleanup patch would be handy also for the upcoming plan of having
something similar to FUSE passthrough extended to directories, as it was
mentioned in a previous discussion on this series with Amir.

Thanks!
Alessio
