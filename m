Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB272DBA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbjFMHym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjFMHyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:54:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC27E7D
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 00:54:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so4366573b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 00:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686642879; x=1689234879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCkgcZgojFrJD6ikZBBlWSOOkLn20nhRfhYeTzhO/KY=;
        b=LnnHBbwURgWlIq2Kl2ZHAuPlRbR6UBkyXHR7hZf7WGab2MH69yCnA4xx1UzT/8Py/Z
         6NeF+yxA0XPwaSjAVO/sXKIbB//IWNnRxWxYpiiW/Z230+h4hAhWj9NeHy7/keKIMVi8
         X+ntbSLHwwd0FMn7O/qAakF8lCRLSo62AHeGJntNPPJnogM17VZ5Aovgxw7dVYjEMtZW
         sNQXWoLFZ/ctNPn0iA4O6U8m2cetDo21MGJW+Rlc19D2A5q+XwX5xcYRRnfDU5B17Kw+
         +pazru7N4I+LKqjfCUEkFSdjFtZFnpZzfQbfx4U3+0cywDIeD/IICFkFPZHeEgPv5WvE
         7pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642879; x=1689234879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCkgcZgojFrJD6ikZBBlWSOOkLn20nhRfhYeTzhO/KY=;
        b=WuosIuX0CeJnWC9b+TMQOqbS5Uh6Lg5jyVVXP4vrc57D0SRdJJAAczwWusMnqemuBz
         qO5ow/yS2sYsibHj/+95SDqzooaLoK82VFYFSHjEUJa5j4imCofFCtsifgF3IjOHTOqv
         XXxVEXob5gkr2gR5Rlmbi3z0K1EnlwEwiCbwydKGCGf0PoI6TNnl2Zznj5AG90/MWWZN
         uSGB8FPpEKD604pberMHP597jpqF/F0SRYhI2wEILl0Vf5nBw+KiemSJ9LyfV2809eSw
         Rhlno95mJ208VVNScIV9dmC8gYW9qSncwjsfR7nGlG4g30ydsrPRSj/rPPi0ikrJDsKf
         XCLA==
X-Gm-Message-State: AC+VfDwZL6aWsQYxC0pG8WQ5qGkYSlykAAxWykmACBIzdh2l9TrXR1fH
        Y2WEkCdOjMj6wyh9FNGshxakxWP/ZRXs2TOUOZE=
X-Google-Smtp-Source: ACHHUZ6squwwYVgIArur+aSPNOVVl/9piWl50z7W2qAHgfJzQEG/YTMxGMtLs4NY3Vyb9oaY4UE/iw==
X-Received: by 2002:a05:6a20:43a2:b0:104:7a4c:6ca6 with SMTP id i34-20020a056a2043a200b001047a4c6ca6mr12070509pzl.13.1686642879383;
        Tue, 13 Jun 2023 00:54:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id jl1-20020a170903134100b001a245b49731sm8118560plb.128.2023.06.13.00.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:54:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q8yrL-00BCQ9-1S;
        Tue, 13 Jun 2023 17:54:35 +1000
Date:   Tue, 13 Jun 2023 17:54:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 6/8] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZIggux3yxAudUSB1@dread.disaster.area>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-7-willy@infradead.org>
 <ZIeg4Uak9meY1tZ7@dread.disaster.area>
 <ZIe7i4kklXphsfu0@casper.infradead.org>
 <ZIfGpWYNA1yd5K/l@dread.disaster.area>
 <ZIfNrnUsJbcWGSD8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIfNrnUsJbcWGSD8@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 03:00:14AM +0100, Matthew Wilcox wrote:
> On Tue, Jun 13, 2023 at 11:30:13AM +1000, Dave Chinner wrote:
> > Indeed, if we do a 1MB write at offset 4KB, we'll get 4kB at 4KB, 8KB
> > and 12kB (because we can't do order-1 folios), then order-2 at 16KB,
> > order-3 at 32kB, and so on until we hit offset 1MB where we will do
> > an order-0 folio allocation again (because the remaining length is
> > 4KB). The next 1MB write will then follow the same pattern, right?
> 
> Yes.  Assuming we get another write ...
> 
> > I think this ends up being sub-optimal and fairly non-obvious
> > non-obvious behaviour from the iomap side of the fence which is
> > clearly asking for high-order folios to be allocated. i.e. a small
> > amount of allocate-around to naturally align large folios when the
> > page cache is otherwise empty would make a big difference to the
> > efficiency of non-large-folio-aligned sequential writes...
> 
> At this point we're arguing about what I/O pattern to optimise for.
> I'm going for a "do no harm" approach where we only allocate exactly as
> much memory as we did before.  You're advocating for a
> higher-risk/higher-reward approach.

Not really - I'm just trying to understand the behaviour the change
will result in, compared to what would be considered optimal as it's
not clearly spelled out in either the code or the commit messages.

If I hadn't looked at the code closely and saw a trace with this
sort of behaviour (i.e. I understood large folios were in use,
but not exactly how they worked), I'd be very surprised to see a
weird repeated pattern of varying folio sizes. I'd probably think
it was a bug in the implementation....

> I'd prefer the low-risk approach for now; we can change it later!

That's fine by me - just document the limitations and expected
behaviour in the code rather than expect people to have to discover
this behaviour for themselves.

> I'd like to see some amount of per-fd write history (as we have per-fd
> readahead history) to decide whether to allocate large folios ahead of
> the current write position.  As with readahead, I'd like to see that even
> doing single-byte writes can result in the allocation of large folios,
> as long as the app has done enough of them.

*nod*

We already have some hints in the iomaps that can tell you this sort
of thing. e.g. if ->iomap_begin() returns a delalloc iomap that
extends beyond the current write, we're performing a sequence of
multiple sequential writes.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
