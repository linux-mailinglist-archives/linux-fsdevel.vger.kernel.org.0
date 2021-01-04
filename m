Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7522E938A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 11:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbhADKn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhADKn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:43:57 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C4C061574;
        Mon,  4 Jan 2021 02:43:17 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id k8so24849034ilr.4;
        Mon, 04 Jan 2021 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3l9UhkzSQuGNhhSoOB/EKfTtvl8Ybm/n2gWJAEInW68=;
        b=SFdzl8oXoGeZUwjzXxM0DEuVx6x2mh9u7VonItYpLnN5C6DJEAkyrfCnp/S996evCm
         YXmySSBSOgxradjHUyZ/ZuNuJXzBpsuvUo/fnIs1Ie7PREI3m7lHJ8uJ2dV9prp9rE8s
         mG0Z//pdiio5XlUsX1FHXMihbb2tTfafUbuKXhRZIbkl3/0CJhlV/g0G3d7bhekbvpAZ
         f0zHe2sQeNtIjIed+pj5c4WImUgTh0YFOj9C22HsUuYbnW5y3oSV22R9PC6R0Cnife3m
         PNnN8vJMUZMIFWEwalGD70GzkXowPB+4fRS5fuC5jtbZyre/6aUJnbeH/wj/dxl7aIaj
         YJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3l9UhkzSQuGNhhSoOB/EKfTtvl8Ybm/n2gWJAEInW68=;
        b=fwruUzoib4e+2lxeN4kVVjVHRLtQr7hJvy3EDloR/Jq90i29Wo+tPohm9v/yYotHiC
         5t0SH/qPPwxhuUgDYeieoCQuK8LIOqJ5ZPC0YeVQPY6EtIgF6KDbKgJAcfqkIjD20uha
         C5bXKOoAR9a+DH0zMvWOy9nRmcbLqshPA7lfal7iCzXn3DhzYPMXU4nc7fK76dljgr8d
         N08HfFJlzA7E8tc97DgtYflqGiqf41+RXRPJP/oFOXfKWs/kX0DWlvwRMjik7nTtXOE6
         goREy9cAbKRFsq61rA8GoPBDq8FDKWlv6WAQ8/2UKZgZgauEvNMpDcp4DfEWr+aeyBQS
         C7WQ==
X-Gm-Message-State: AOAM533MHzHeqnhQ2CeCKo3Tiov9BF+5nvAJZs0Mex1RaBO9OF8+Fvb6
        vJ3zjS2KZAWWsSLEK7hS+bglgHpMaHXnbxCKUqs=
X-Google-Smtp-Source: ABdhPJyRLGSMPviRnCBw25zlf1PIUYFkgyAVvONCYe415ftLgiibcjOVK2zvUCm3SC+BrBMWag5Jjy51CpT3lgimRiE=
X-Received: by 2002:a05:6e02:102f:: with SMTP id o15mr70104237ilj.142.1609756996831;
 Mon, 04 Jan 2021 02:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20201222012131.47020-5-laoar.shao@gmail.com> <20201231030158.GB379@xsang-OptiPlex-9020>
 <CALOAHbD+mLMJSizToKPsx0iUd5Z71sJBOyMaV2enVvUHfHwLzg@mail.gmail.com> <20210101215353.GB331610@dread.disaster.area>
In-Reply-To: <20210101215353.GB331610@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 4 Jan 2021 18:42:41 +0800
Message-ID: <CALOAHbDTCm4XdCJdeN7bP6ChA=8EZi50x2hSA4eSWG-nSSKDsA@mail.gmail.com>
Subject: Re: [xfs] db962cd266: Assertion_failed
To:     Dave Chinner <david@fromorbit.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 2, 2021 at 5:53 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Jan 01, 2021 at 05:10:49PM +0800, Yafang Shao wrote:
> > On Thu, Dec 31, 2020 at 10:46 AM kernel test robot
> > <oliver.sang@intel.com> wrote:
> .....
> > > [  552.905799] XFS: Assertion failed: !current->journal_info, file: fs/xfs/xfs_trans.h, line: 280
> > > [  553.104459]  xfs_trans_reserve+0x225/0x320 [xfs]
> > > [  553.110556]  xfs_trans_roll+0x6e/0xe0 [xfs]
> > > [  553.116134]  xfs_defer_trans_roll+0x104/0x2a0 [xfs]
> > > [  553.122489]  ? xfs_extent_free_create_intent+0x62/0xc0 [xfs]
> > > [  553.129780]  xfs_defer_finish_noroll+0xb8/0x620 [xfs]
> > > [  553.136299]  xfs_defer_finish+0x11/0xa0 [xfs]
> > > [  553.142017]  xfs_itruncate_extents_flags+0x141/0x440 [xfs]
> > > [  553.149053]  xfs_setattr_size+0x3da/0x480 [xfs]
> > > [  553.154939]  ? setattr_prepare+0x6a/0x1e0
> > > [  553.160250]  xfs_vn_setattr+0x70/0x120 [xfs]
> > > [  553.165833]  notify_change+0x364/0x500
> > > [  553.170820]  ? do_truncate+0x76/0xe0
> > > [  553.175673]  do_truncate+0x76/0xe0
> > > [  553.180184]  path_openat+0xe6c/0x10a0
> > > [  553.184981]  do_filp_open+0x91/0x100
> > > [  553.189707]  ? __check_object_size+0x136/0x160
> > > [  553.195493]  do_sys_openat2+0x20d/0x2e0
> > > [  553.200481]  do_sys_open+0x44/0x80
> > > [  553.204926]  do_syscall_64+0x33/0x40
> > > [  553.209588]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Thanks for the report.
> >
> > At a first glance, it seems we should make a similar change as we did
> > in xfs_trans_context_clear().
> >
> > static inline void
> > xfs_trans_context_set(struct xfs_trans *tp)
> > {
> >     /*
> >      * We have already handed over the context via xfs_trans_context_swap().
> >      */
> >     if (current->journal_info)
> >         return;
> >     current->journal_info = tp;
> >     tp->t_pflags = memalloc_nofs_save();
> > }
>
> Ah, no.
>
> Remember how I said "split out the wrapping of transaction
> context setup in xfs_trans_reserve() from
> the lifting of the context setting into xfs_trans_alloc()"?
>
> Well, you did the former and dropped the latter out of the patch
> set.
>

I misunderstood what you mean.

> Now when a transaction rolls after xfs_trans_context_swap(), it
> calls xfs_trans_reserve() and tries to do transaction context setup
> work inside a transaction context that already exists.  IOWs, you
> need to put the patch that lifts of the context setting up into
> xfs_trans_alloc() back into the patchset before adding the
> current->journal functionality patch.
>

Sure.

> Also, you need to test XFS code with CONFIG_XFS_DEBUG=y so that
> asserts are actually built into the code and exercised, because this
> ASSERT should have fired on the first rolling transaction that the
> kernel executes...
>

I really forgot to enable CONFIG_XFS_DEBUG...   -_-b


-- 
Thanks
Yafang
