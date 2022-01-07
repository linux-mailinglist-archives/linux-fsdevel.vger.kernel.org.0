Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B35487993
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 16:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348009AbiAGPPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 10:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232338AbiAGPPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641568550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAmuiqchl7La3h3ruqABsbeVr6wCzTut3XxMAsn9rqo=;
        b=EujggsQIhoBeQax9kXUr0x1byCfktGOZ4wymELuZHEZy9FPRQobh2Da0bCvucbxJJunE89
        qvnGchOcg3Z/z6QeRXOSf+v5+VAysjDWs8d3jKtABnmcfliyGc0XhDz42vmo/4Wfl6DmfQ
        rrWBC1Z/NowEZEO1l+CaX+E/35iRsVo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-APkgWH5zNZODgbjDtjbdyA-1; Fri, 07 Jan 2022 10:15:49 -0500
X-MC-Unique: APkgWH5zNZODgbjDtjbdyA-1
Received: by mail-qv1-f72.google.com with SMTP id 13-20020a0562140d0d00b00411590233e8so5038064qvh.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jan 2022 07:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAmuiqchl7La3h3ruqABsbeVr6wCzTut3XxMAsn9rqo=;
        b=KEo8xp5eLvLs6vUftTTtwoAd1pGPuXoi98G58cvK2fF2lsOGMyhU7kqskv8PIiW0CL
         lflpleRRJDJQEwLBLNaQC6pSZ9vnPaUlbMpoBfzxrlOwxE3O03tmwWDIvNl/cUqPsqYm
         OZMAqPG0TxCN6gxBAaaKbc7bNa7FKzIedj4zQGKL2cR0YX8R1gk03YhGr2m2H+bNrGQq
         6UIEMw3lfs/gR1aG6NbnRHSt2rHr8mxcFeOJxgynhagD8JeNLHhcGfm2PVr1OnSSbNd2
         wX6mHDHp83yS3WPvHoWZM3owAxKRRshQbU4RYTGE5Ax+mfYAUzXSb7x2Y2G0njTl94jv
         udrA==
X-Gm-Message-State: AOAM530+Mg/xGEu5RvvsGUppwWnTlujbt1yeQ2aRF+29g7uwKyWTTfFV
        Ybb7+5Mq9h017sFB28UJxzYJLesYMAmhswRU5ugWxOpFeJnyC/9MurKuLLxvSsN3UQc+d9AnoeH
        kEqzIk3YIqPuCGgsGroPfbZqI3g==
X-Received: by 2002:a05:6214:2424:: with SMTP id gy4mr58978792qvb.128.1641568548872;
        Fri, 07 Jan 2022 07:15:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuxQUohLjbxxjqdqvgSE5BDFWOzfZe406dehwyhm+tDIk5obm61S9Lz/ZNWg9d4HSFE5p5pw==
X-Received: by 2002:a05:6214:2424:: with SMTP id gy4mr58978765qvb.128.1641568548567;
        Fri, 07 Jan 2022 07:15:48 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f12sm3686954qtj.93.2022.01.07.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:15:48 -0800 (PST)
Date:   Fri, 7 Jan 2022 10:15:46 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdhZIsbxdJTu0iEN@bfoster>
References: <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <0996c40657b5873dda5119344bf74556491e27b9.camel@hammerspace.com>
 <c9d9b7850c6086b123b4add4de7b1992cb62f6ad.camel@hammerspace.com>
 <20220105224829.GO945095@dread.disaster.area>
 <28e975e8235a41c529bccb2bc0e73b4bb2d1e45e.camel@hammerspace.com>
 <YddMGRQrYOWr6V9A@bfoster>
 <b7eb3f2cf7a2c819f38c647f4247ff1de80e19b9.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7eb3f2cf7a2c819f38c647f4247ff1de80e19b9.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:08:48AM +0000, Trond Myklebust wrote:
> On Thu, 2022-01-06 at 15:07 -0500, Brian Foster wrote:
> > On Thu, Jan 06, 2022 at 06:36:52PM +0000, Trond Myklebust wrote:
> > > On Thu, 2022-01-06 at 09:48 +1100, Dave Chinner wrote:
> > > > On Wed, Jan 05, 2022 at 08:45:05PM +0000, Trond Myklebust wrote:
> > > > > On Tue, 2022-01-04 at 21:09 -0500, Trond Myklebust wrote:
> > > > > > On Tue, 2022-01-04 at 12:22 +1100, Dave Chinner wrote:
> > > > > > > On Tue, Jan 04, 2022 at 12:04:23AM +0000, Trond Myklebust
> > > > > > > wrote:
> > > > > > > > We have different reproducers. The common feature appears
> > > > > > > > to
> > > > > > > > be
> > > > > > > > the
> > > > > > > > need for a decently fast box with fairly large memory
> > > > > > > > (128GB
> > > > > > > > in
> > > > > > > > one
> > > > > > > > case, 400GB in the other). It has been reproduced with
> > > > > > > > HDs,
> > > > > > > > SSDs
> > > > > > > > and
> > > > > > > > NVME systems.
> > > > > > > > 
> > > > > > > > On the 128GB box, we had it set up with 10+ disks in a
> > > > > > > > JBOD
> > > > > > > > configuration and were running the AJA system tests.
> > > > > > > > 
> > > > > > > > On the 400GB box, we were just serially creating large (>
> > > > > > > > 6GB)
> > > > > > > > files
> > > > > > > > using fio and that was occasionally triggering the issue.
> > > > > > > > However
> > > > > > > > doing
> > > > > > > > an strace of that workload to disk reproduced the problem
> > > > > > > > faster
> > > > > > > > :-
> > > > > > > > ).
> > > > > > > 
> > > > > > > Ok, that matches up with the "lots of logically sequential
> > > > > > > dirty
> > > > > > > data on a single inode in cache" vector that is required to
> > > > > > > create
> > > > > > > really long bio chains on individual ioends.
> > > > > > > 
> > > > > > > Can you try the patch below and see if addresses the issue?
> > > > > > > 
> > > > > > 
> > > > > > That patch does seem to fix the soft lockups.
> > > > > > 
> > > > > 
> > > > > Oops... Strike that, apparently our tests just hit the
> > > > > following
> > > > > when
> > > > > running on AWS with that patch.
> > > > 
> > > > OK, so there are also large contiguous physical extents being
> > > > allocated in some cases here.
> > > > 
> > > > > So it was harder to hit, but we still did eventually.
> > > > 
> > > > Yup, that's what I wanted to know - it indicates that both the
> > > > filesystem completion processing and the iomap page processing
> > > > play
> > > > a role in the CPU usage. More complex patch for you to try
> > > > below...
> > > > 
> > > > Cheers,
> > > > 
> > > > Dave.
> > > 
> > > Hi Dave,
> > > 
> > > This patch got further than the previous one. However it too failed
> > > on
> > > the same AWS setup after we started creating larger (in this case
> > > 52GB)
> > > files. The previous patch failed at 15GB.
> > > 
> > 
> > Care to try my old series [1] that attempted to address this,
> > assuming
> > it still applies to your kernel? You should only need patches 1 and
> > 2.
> > You can toss in patch 3 if you'd like, but as Dave's earlier patch
> > has
> > shown, this can just make it harder to reproduce.
> > 
> > I don't know if this will go anywhere as is, but I was never able to
> > get
> > any sort of confirmation from the previous reporter to understand at
> > least whether it is effective. I agree with Jens' earlier concern
> > that
> > the per-page yields are probably overkill, but if it were otherwise
> > effective it shouldn't be that hard to add filtering. Patch 3 could
> > also
> > technically be used in place of patch 1 if we really wanted to go
> > that
> > route, but I wouldn't take that step until there was some
> > verification
> > that the yielding heuristic is effective.
> > 
> > Brian
> > 
> > [1]
> > https://lore.kernel.org/linux-xfs/20210517171722.1266878-1-bfoster@redhat.com/
> > 
> > 
> > 
> 
> Hi Brian,
> 
> I would expect those to work, since the first patch is essentially
> identical to the one I wrote and tested before trying Dave's first
> patch version (at least for the special case of XFS). However we never
> did test that patch on the AWS setup, so let me try your patches 1 & 2
> and see if they get us further than 52GB.
> 

Hm yeah, fair point. It's a little different in that it shuffles large
ioends to wq completion rather than splitting them up (to avoid atomic
completion context issues), but presumably that is not a factor with
your storage configuration and so otherwise the cond_resched() usage is
essentially the same as your initial patch. Regardless, it would be nice
to get some tangible results from a real reproducer, so the thorough
testing is appreciated. If you hadn't tested to this extreme yet, then
it would be certainly good to know whether the problem still occurs
because that indicates we're still missing something fundamental.

If this does actually survive your test, what might be an interesting
next step (if you're inclined to experiment!) is to plumb in a counter
to track the actual number of pages processed, use that to filter the
cond_resched() and then perhaps experiment with how aggressive that
filter needs to be to avoid the problem in your environment (and/or
similarly dump the counter value in a tracepoint when need_resched()
returns true or some such). The simplest way to do that experiment is
probably to just pass a counter pointer from iomap_finish_ioends() to
iomap_finish_ioend() and let the latter increment/filter/reset the
counter (similar to the logic in Dave's latest patch that allows the
counter to track across a set of ioends) based on the number of pages
processed and whatever magic heuristic is specified.

Brian

> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

