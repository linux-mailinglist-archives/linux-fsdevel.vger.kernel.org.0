Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300EA601927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiJQUPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiJQUPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:15:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2412D17;
        Mon, 17 Oct 2022 13:14:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j7so14578544ybb.8;
        Mon, 17 Oct 2022 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LaEEWFnklwaZAjd5Tk8/ac4k/IUjI6Kq8GFYJsjy+3o=;
        b=cQql2FbReTJUOdpvKV9ihGFnEpOtSC1OaajXoy2CU5jiealiv3+VmpDo1tqX9jUD1z
         IYg4VAAEf3lM/rN0D24izsaat2VIi7sRFIbDYo+QxBv5OEUgynY6XgXnTe3v8jL1StHh
         PSJpzq33GrbxKAnBBlvPHiAfBPtuWzcP0s5hJHlW4Myga3dtXY9UTXb4ZCfAIXNHSauw
         +qDoHN0hKjv2mht0lW6spmiuyKv2Ve0TPteX4LsD/MEermqUUsRwrEsqdy1NBuGizFib
         z++ZG9/61uYHsGdjbwS5BXaQaUnYpzwnIT5vd5y22y1D4llCU7w1TdOs2bMmB6Mp6P/G
         UccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaEEWFnklwaZAjd5Tk8/ac4k/IUjI6Kq8GFYJsjy+3o=;
        b=LOiNRKyFmhmvbDc90lsRhQk0g0BFyo2NS/O1Z1zKEklUYgYbypX3wTxQeQtQOdktG+
         9QFp9Set1xLvb+9jX3ARHLpsRkiVyZr+E0YArHy/X6xAFKNdtnXNk/B3xw1T7y9PUbUo
         vpGfE6ctTCpHFcljPR3JGxFzVf2wmnvf+Rv9AqaX15YwN66PjmrZQM2N1uT1+kQZ9aDC
         4LEE6GrhkpdWG8KgC8fD3AeUZUsPSHcNYH/AVPDHI+KV1uBUv4fb9QkVuWwNUvqFX9UL
         JEcT6jp5PNaoVGpWJnWPSJeT8N6h+NphyvHopkwld4cXIGdEQ981mxg+QYePNZbKUSsX
         /mBw==
X-Gm-Message-State: ACrzQf0y6YcYR5QIhBog+RkNkR3cgkzjPrKGN09RhzIOz/4sFAojH0Mv
        CXyv+JqgRLFsX6zKrlv+DEHT0PiNP3DGAOMGTkw=
X-Google-Smtp-Source: AMsMyM4AHqC2gUZLCsyYa10ZgMYS/rjlu/1xXDPPG9Sfdbx8BHkdeg5leOvnug17ihKOiBbCGtiNTA5vYh/F5synjSY=
X-Received: by 2002:a25:4fc1:0:b0:6bc:c570:f99e with SMTP id
 d184-20020a254fc1000000b006bcc570f99emr10733540ybb.58.1666037584709; Mon, 17
 Oct 2022 13:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221017161800.2003-1-vishal.moola@gmail.com> <20221017161800.2003-2-vishal.moola@gmail.com>
 <Y02JTOtYEbAyo+zu@casper.infradead.org> <CAOzc2py24=NBFX6mWZ9s0eRH-rU87n-mYsVK=TW_jtx646z_qQ@mail.gmail.com>
 <Y02wcnTOMH+KnnML@casper.infradead.org>
In-Reply-To: <Y02wcnTOMH+KnnML@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 17 Oct 2022 13:12:53 -0700
Message-ID: <CAOzc2pze8XFUE_h-bLzO-P7i6sKc7RF0vnFF+Tjuw7KU=X4hOg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] filemap: find_lock_entries() now updates start offset
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 17, 2022 at 12:43 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Oct 17, 2022 at 12:37:48PM -0700, Vishal Moola wrote:
> > On Mon, Oct 17, 2022 at 9:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 09:17:59AM -0700, Vishal Moola (Oracle) wrote:
> > > > +++ b/mm/shmem.c
> > > > @@ -932,21 +932,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> > > >
> > > >       folio_batch_init(&fbatch);
> > > >       index = start;
> > > > -     while (index < end && find_lock_entries(mapping, index, end - 1,
> > > > +     while (index < end && find_lock_entries(mapping, &index, end - 1,
> > >
> > > Sorry for not spotting this in earlier revisions, but this is wrong.
> > > Before, find_lock_entries() would go up to (end - 1) and then the
> > > index++ at the end of the loop would increment index to "end", causing
> > > the loop to terminate.  Now we don't increment index any more, so the
> > > condition is wrong.
> >
> > The condition is correct. Index maintains the exact same behavior.
> > If a find_lock_entries() finds a folio, index is set to be directly after
> > the last page in that folio, or simply incrementing for a value entry.
> > The only time index is not changed at all is when find_lock_entries()
> > finds no folios, which is the same as the original behavior as well.
>
> Uh, right.  I had the wrong idea in my head that index wouldn't increase
> past end-1, but of course it can.
>
> > > I suggest just removing the 'index < end" half of the condition.
> >
> > I hadn't thought about it earlier but this index < end check seems
> > unnecessary anyways. If index > end then find_lock_entries()
> > shouldn't find any folios which would cause the loop to terminate.
> >
> > I could send an updated version getting rid of the "index < end"
> > condition as well if you would like?
>
> Something to consider is that if end is 0 then end-1 is -1, which is
> effectively infinity, and we'll do the wrong thing?  So maybe just
> leave it alone, and go with v3 as-is?

Yeah in that case find_lock_entries() would definitely do the
wrong thing. I was thinking the "end-1" could be replaced with
"end" as well as removing the "index < end". But that would
change the behavior of the function(s) to now deal with
end inclusive rather than exclusive which may or may not
be problematic. Considering that I don't see any compelling
reason to eliminate the "index < end" condition.

I say we go with v3 as-is if there are no problems.
