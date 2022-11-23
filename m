Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D916634DD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 03:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiKWC0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 21:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiKWC0T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:26:19 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DFDDB879;
        Tue, 22 Nov 2022 18:26:18 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 7so19405978ybp.13;
        Tue, 22 Nov 2022 18:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=00RzDuciGC3lT3xwhCdi5LokzQVvWdDHLPqjXqGdFJg=;
        b=XxOYWYfkLXZKqUD3n+fJDAFgrClq2Sb81DA9yBIghAtY0oN4Nicw54fBJN26uBoMAW
         CGE2l0OYqyl+K9YgzLCMSLDmPTBonACWL1AQ5Up02om+CQMp1m9X6OHp2UQGg1ZoJNDm
         Gzk4QLk6AWIvfTz+i+IWzkn7gG94jmKX0BAJI/VKczV+onDlpPyEZSVe/XX5/qoS8r5i
         zF9LRUyS0/9vEXBOXQuIV3vLk6ajTk73xwa83CRhfT7AyZQkEQulpme3Z+a++WxExI0e
         TCDYAL/8MldvAoBL6L6IFvTle63L4kzodOdmgc8aEoxGPbGRslThdQ2XdvF6Rwm561RZ
         zJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00RzDuciGC3lT3xwhCdi5LokzQVvWdDHLPqjXqGdFJg=;
        b=pbL1jYAuFbyu410YlNfDVoDxctVrMwjJJAuagngBoM4RK6B7sIxp4U/9eFlUCYqGwV
         cGauLETFMlaOXsxRYI28S0DqPVBJu0ttQ+hrH40kyJ3hQeXgIMruP7CblWaA9/mTMmhT
         ceLFNAS0rQKbEaZ/4IowSoUKwSPtx+foJa7Kj6K8KtnnLgXqpmxQaKTJ3PeDXvHrCTGU
         n63d3hlsELZvrvqo8+ptp06ZWVpLJOF790Px502x9z9ihIwtUj69aLsjmZNdP2GYFqWi
         D0DW2EKfJdaohaKgb6xvJH32mI5kI8NWo2D1LHwHPBKIQaSVT3C44V9kgkolb0ztnMpt
         Jw4A==
X-Gm-Message-State: ANoB5plrwFPQas1KFGPLARigGBiBY2RAQFoL3ZcZ9t2GzZv2sFXa4zzF
        kYMLw6oqTqSEkGoEbYtjRsDyn44JL0k7W1Na2YY=
X-Google-Smtp-Source: AA0mqf477e8qpxV1bYLLR0R8Ks97SHy8PTkHSXaEkM6HfXKb5dxC5qoWucYbvDF6OuQ91KCwyLIaUcmFQhpCw1GYqmA=
X-Received: by 2002:a25:e70f:0:b0:6ef:aa80:9083 with SMTP id
 e15-20020a25e70f000000b006efaa809083mr2100761ybh.407.1669170377646; Tue, 22
 Nov 2022 18:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-15-vishal.moola@gmail.com>
 <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org> <CAOzc2pweRFtsUj65=U-N-+ASf3cQybwMuABoVB+ciHzD1gKWhQ@mail.gmail.com>
In-Reply-To: <CAOzc2pweRFtsUj65=U-N-+ASf3cQybwMuABoVB+ciHzD1gKWhQ@mail.gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 22 Nov 2022 18:26:05 -0800
Message-ID: <CAOzc2pzoG1CN3Bpx5oe37GwRv71TpTQmFH6m58kTqOmeW7KLOw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 14/23] f2fs: Convert f2fs_write_cache_pages()
 to use filemap_get_folios_tag()
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnan chang <fengnanchang@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 1:38 PM Vishal Moola <vishal.moola@gmail.com> wrote:
>
> On Sun, Nov 13, 2022 at 11:02 PM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
> > > Converted the function to use a folio_batch instead of pagevec. This is in
> > > preparation for the removal of find_get_pages_range_tag().
> > >
> > > Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
> > > of pagevec. This does NOT support large folios. The function currently
> >
> > Vishal,
> >
> > It looks this patch tries to revert Fengnan's change:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486
> >
> > How about doing some tests to evaluate its performance effect?
>
> Yeah I'll play around with it to see how much of a difference it makes.

I did some testing. Looks like reverting Fengnan's change allows for
occasional, but significant, spikes in write latency. I'll work on a variation
of the patch that maintains the use of F2FS_ONSTACK_PAGES and send
that in the next version of the patch series. Thanks for pointing that out!

How do the remaining f2fs patches in the series look to you?
Patch 16/23 f2fs_sync_meta_pages() in particular seems like it may
be prone to problems. If there are any changes that need to be made to
it I can include those in the next version as well.
