Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0424C3DE27F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 00:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhHBWcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 18:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhHBWcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627943513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4EVhT6i3eXXJjz3ahLl3R5UmsaRKu+vDRCucrxfPbqs=;
        b=g+h9mZQYkhEdz2dCkF2WuvNswyV5l8GeIPgllm6d/pZKzjGSP7p6QLW9xQQ//uqzM3FQwx
        IK2hxRVvi5raz9jEZLkaWSyD2m3xWNel9SKDmSFEsnlc2Btz8yLBpFp9zjK5NQFfBs0D+X
        3QSObk3kK2N9y5Vpaq0sDtvdDT27m2k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-hRQ0nI-rMSOkJpLGCs3HKw-1; Mon, 02 Aug 2021 18:31:52 -0400
X-MC-Unique: hRQ0nI-rMSOkJpLGCs3HKw-1
Received: by mail-wm1-f70.google.com with SMTP id o26-20020a05600c511ab0290252d0248251so295403wms.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Aug 2021 15:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EVhT6i3eXXJjz3ahLl3R5UmsaRKu+vDRCucrxfPbqs=;
        b=sbp2spoLa6ZXelQE3bLBtDW4ReDOYQHV1tM7GFEKaa+I3syZzj1GAJljaiI3lfZ8Ks
         ukRvBOKqq6Bhdt0VHDuhNHhJxDJSUuidwCqO4QXZz/YTZVC5nVatheO5Jo358e/XAiiY
         JmBjMqcoKQVTKPbW0nGFdnDZtORG9JmRYWxJdIHLRfcbo0dnja380SJFca8CIcpz+gCq
         H1vXrGxi3L4i52PabDaADchBopaMlDi2QoG6/qd+ZzISstSWd7+u+COwxd3TCdWC2od6
         8ZpCanX6YBPfJ9qNugfkv8v2reRjj1vqHxwuKvd5aXoOrBRmzuNl3iIN/xRrPrfgjkwz
         ScoA==
X-Gm-Message-State: AOAM532aGUQIgSaZuiLa2IGoUV+wxjkpdaGF/ICTxJ4L41sZAe7k80T2
        g0pVPU/GbOd8PbGfRup238EpeBXS3SRxf9OtKL8mbgoCMXzR7LitQz6Nf9HV8xQIpe0M/lBdWNu
        6QQM75enP2p/urC0Ll6v9en/3dRdq567fZRoSJ0M7mw==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr19254658wrm.377.1627943510796;
        Mon, 02 Aug 2021 15:31:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUHr36B5P/mt6E/dLhCWXX9iYzqcwuvGX7I402J27W+nWBdib/Y2RF3iSckApfuxD0i+HWk/ODRlxb6VjoIok=
X-Received: by 2002:adf:dd07:: with SMTP id a7mr19254644wrm.377.1627943510642;
 Mon, 02 Aug 2021 15:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210802221114.GG3601466@magnolia>
In-Reply-To: <20210802221114.GG3601466@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 Aug 2021 00:31:39 +0200
Message-ID: <CAHc6FU5YAs-8HZAVeP-ZWRmvZ3mXDs37SgWXXOJC+uS=6hTVgw@mail.gmail.com>
Subject: Re: iomap 5.15 branch construction ...
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 3, 2021 at 12:11 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Hi everyone!
>
> iomap has become very popular for this cycle, with seemingly a lot of
> overlapping patches and whatnot.  Does this accurately reflect all the
> stuff that people are trying to send for 5.15?
>
> 1. So far, I think these v2 patches from Christoph are ready to go:
>
>         iomap: simplify iomap_readpage_actor
>         iomap: simplify iomap_add_to_ioend
>
> 2. This is the v9 "iomap: Support file tail packing" patch from Gao,
> with a rather heavily edited commit:
>
>         iomap: support reading inline data from non-zero pos
>
> Should I wait for a v10 patch with spelling fixes as requested by
> Andreas?  And if there is a v10 submission, please update the commit
> message.
>
> 3. Matthew also threw in a patch:
>
>         iomap: Support inline data with block size < page size
>
> for which Andreas also sent some suggestions, so I guess I'm waiting for
> a v2 of that patch?  It looks to me like the last time he sent that
> series (on 24 July) he incorporated Gao's patch as patch 1 of the
> series?
>
> 4. Andreas has a patch:
>
>         iomap: Fix some typos and bad grammar
>
> which looks more or less ready to go.
>
> 5. Christoph also had a series:
>
>         RFC: switch iomap to an iterator model
>
> Which I reviewed and sent some comments for, but (AFAICT) haven't seen a
> non-RFC resubmission yet.  Is that still coming for 5.15?
>
> 6. Earlier, Eric Biggers had a patchset that made some iomap changes
> ahead of porting f2fs to use directio.  I /think/ those changes were
> dropped in the latest submission because the intended use of those
> changes (counters of the number of pages undergoing reads or writes,
> iirc?) has been replaced with something simpler.  IOWs, f2fs doesn't
> need any iomap changes for 5.15, right?
>
> 7. Andreas also had a patchset:
>
>         gfs2: Fix mmap + page fault deadlocks
>
> That I've left unread because Linus started complaining about patch 1.
> Is that not going forward, then?

Still working on it; it's way nastier than expected.

> So, I /think/ that's all I've received for this next cycle.  Did I miss
> anything?  Matthew said he might roll some of these up and send me a
> pull request, which would be nice... :)
>
> --D
>

Andreas

