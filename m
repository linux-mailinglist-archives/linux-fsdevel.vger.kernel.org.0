Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42A2663BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIKQXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIKQXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:23:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78711C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 09:23:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so12026132wrl.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6SlwUZsnL/qW5jVfhFO7QbUYBoAMLGlcOKF3wt4NfUM=;
        b=HwlnYVl3wQKzd3A+zX2xtFIOpottAY358rN9GCQQA73v1qRJMPnmTv6QZ9eGylewQ3
         XVx24cJBjtXE0Gv3UgSpqZ5f3Y3ZOqMNGWjK/aJEnSzwKX+WbDsHeRm15P3EZyTsC9Ni
         boSUYoPFQ7BNnek2wyVuPNkh1q0toYU17HrwtLbcu8eVI9A+tNQpUBaq6QJ63zqxuUCG
         AT7STseU6xdcDiaMIeCeoDNYldQYscshX/wKz4N7Fi4eBkPoJcjqFvK0y28FjOMUyCJX
         gSc/d/WlixwdbBh5sRk99nNJIaNeOo5tcDDi4Omoj/lDp0jr7ToBDhLSyIxpzUHA+ApB
         kvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SlwUZsnL/qW5jVfhFO7QbUYBoAMLGlcOKF3wt4NfUM=;
        b=NDHMCTJZo4QPLHBRUOlJe04lrEajfGBgTTuzxTrb5Cpd0essh6uw2aumjZlqqlz/ij
         /XIltQZ+ZycH8+VYD6VIc3uwV0CxhiqeUWHIiQ9MukNaeRbAqHAUgCQr2JcpyXLXV8tG
         cKaT4u/tk3y4MKQHIkCRN2zC4A8TL6GBfZIGckrC21crf0qD0Ct/qAC1sOQHdYleC+yu
         zXJJ2Y/uXkayNlPA8+bHoecXewlLfaSmJxLyDoI3FQCwC13w5jFvugsibweNhrTX/fv6
         9Elb0h9Gd7zC5xVJCMUcwl1wOthpJLpqehP+GrTaY0CQMElT1p32ypUmWapyLgxf9xcA
         l37Q==
X-Gm-Message-State: AOAM532jFTMCvfHHYuP/7CI+H5uRToljmCOwuNIf02HO+rJCpSMii267
        1UdcKfjPVK0r0l1hNnOJDdSvIA==
X-Google-Smtp-Source: ABdhPJwFRemssOYrgqwfSGOoTOfqpzQHvvekBhWw2qod9FQm6HNeQ/SIJDdMcQy4aOgiUgwSj62IIg==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr2761061wrn.93.1599841427191;
        Fri, 11 Sep 2020 09:23:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id s124sm5347757wme.29.2020.09.11.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 09:23:46 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:23:45 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alessio Balsini <balsini@android.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Nikhilesh Reddy <reddyn@codeaurora.org>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
Message-ID: <20200911162345.GA71562@google.com>
References: <20200812161452.3086303-1-balsini@android.com>
 <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
 <20200813132809.GA3414542@google.com>
 <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
 <20200818135313.GA3074431@google.com>
 <877dtvb2db.fsf@vostro.rath.org>
 <CAOQ4uxhRzkpg2_JA2MCXe6Hjc1XaA=s3L_4Q298dW3OxxE2nFg@mail.gmail.com>
 <CAJfpegs2LHv4xfb5KPzSRPSAVg3eZEvZKk46SjgwGcgq==qNzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs2LHv4xfb5KPzSRPSAVg3eZEvZKk46SjgwGcgq==qNzw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks all for the comments.

I have a patchset ready that hopefully wraps together the extendability
suggested by Nikolaus, that I agree is a good idea.
The way I tried to make it more flexible is first of all transitioning to a
ioctl(), as suggested by both Jann and Miklos, and by using a data
structure with flexible array member.

Thanks Amir for the fuse2 pointer. I didn't notice that project before, but
I really enjoyed going through its code.
I'm curious if it's intended to deprecate the current fuse implementation
or is what the current fuse will converge to. I noticed that some good
ideas that were in fuse2 have been also added to fuse, so I tried to take
fuse2 as a reference for my passthrough ioctl().

Miklos, can you please give us a glimpse of what's the future of fuse2?

Thanks a lot again for the feedback, I'll send the new patch in a few
minutes.

Cheers,
Alessio


On Mon, Aug 24, 2020 at 02:48:01PM +0200, Miklos Szeredi wrote:
> On Wed, Aug 19, 2020 at 11:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > > What I have in mind is things like not coupling the setup of the
> > > passthrough fds to open(), but having a separate notification message for
> > > this (like what we use for invalidation of cache), and adding not just
> > > an "fd" field but also "offset" and "length" fields (which would
> > > currently be required to be both zero to get the "full file" semantics).
> > >
> >
> > You mean like this?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=fuse2
> 
> Look specifically at fuse_file_map_iter():
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/tree/fs/fuse2/file.c?h=fuse2#n582
> 
> and fudev_map_ioctl():
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/tree/fs/fuse2/fudev.c?h=fuse2#n601
> 
> This avoids the security issue Jann mentioned as well as allowing
> arbitrary mapping of file ranges.  E.g. it could also  be used by a
> block based filesystem to map I/O directly into the block device.
> 
> What the implementation lacks is any kind of caching.  Since your
> usecase involves just one map extent per file, special casing that
> would be trivial.  We can revisit general caching later.
> 
> Thanks,
> Miklos
