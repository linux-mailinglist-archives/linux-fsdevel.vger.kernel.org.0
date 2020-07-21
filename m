Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6508D227850
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGUFqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 01:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUFqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:46:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE6DC061794;
        Mon, 20 Jul 2020 22:46:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so1094980pjc.4;
        Mon, 20 Jul 2020 22:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3veC3pi53wl7dFDGpjkOo+uS1itnPbzCOm4x4ko6JVY=;
        b=D/IxIwyEq3hF3iTuaIk+KFCFZyGC8VqcCGJnFT12TDv/8eGagJrHkXCGkF3Muc266t
         OGT7OoG2HtHbaXMhlknQISHa5De5A/xFpxWKJLCbc/SAIqTngBdVmIG3+rFG2+Y1Wb46
         YATZPWszcpNmKSDpEHErZUkhido9bvZlai2206IHzthib3Y0UiQ6fX8Re2N3orWnF12s
         XZ6RPqQNT9T2QKcABfS3hJr1GCzgJFm/rDpCofJQA16hsZZMLUHK0fkaVJHJKDnTcvEP
         YayBMF/DStbLmLjOPFjbig16IweaRvLj4UCWCSitHEj/N0DuM+39Lm+dho9165oRwpKe
         XDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3veC3pi53wl7dFDGpjkOo+uS1itnPbzCOm4x4ko6JVY=;
        b=kKDf9hYPNfFx+vlamvo53EVnijLvDnh2gDSOEgTN7NK8ieDWPEkAvH09bq9L8KZT8A
         NqhxhuAxU5Eoo1HglQpQCoUzAwwRsNPbN3Cqc8dogQzsQmPHywFP0N8CyKGvQP4E8jUD
         HtDs2nnIVl4vn98n9Q+nNfsx0VS5u52SXHhf1X1tVz8+c8nwscKuYShEIKvp4oSGgk8B
         jb0alZHqijPGTuO5lWGKDeoL9Er0qxLP05vJOq0/34lQdXnxY8mevxGj/ZLJHhKRd+zP
         7CyzC6V0wYZ/jw19o0Jm9E+Omx6Jr6IHKngv6bRBE8VSXJDewgpPEVf3Czz743yCr9/t
         mS1w==
X-Gm-Message-State: AOAM532LNpJqlyiIILMOP8g32Cr4HkRAeFZ/WApONLKFeA79jZOkw/o5
        8imwm3wvnM6fjJ2Lf/1IGM4=
X-Google-Smtp-Source: ABdhPJylrFyWY9zOcJ3tuosterYe/etVkRG4BboKrT7kWFS6Sy9YPaV4NbuHkPEn95UZ4BSYHonUbw==
X-Received: by 2002:a17:90a:dd44:: with SMTP id u4mr2794038pjv.203.1595310380927;
        Mon, 20 Jul 2020 22:46:20 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id nh14sm1541134pjb.4.2020.07.20.22.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 22:46:19 -0700 (PDT)
Date:   Mon, 20 Jul 2020 22:46:17 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more intelligently
Message-ID: <20200721054617.GA1879427@google.com>
References: <20200720075148.172156-1-hch@lst.de>
 <20200720075148.172156-12-hch@lst.de>
 <CALvZod7ACBnNX5W-gtTzheh8R-rxv1nB-5q7UcDUZ7BvtpakpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7ACBnNX5W-gtTzheh8R-rxv1nB-5q7UcDUZ7BvtpakpA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for Ccing me, Shakeel.

On Mon, Jul 20, 2020 at 10:52:55AM -0700, Shakeel Butt wrote:
> +Minchan Kim
> 
> On Mon, Jul 20, 2020 at 12:52 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > There is no point in trying to call bdev_read_page if SWP_SYNCHRONOUS_IO
> > is not set, as the device won't support it.  Also there is no point in
> > trying a bio submission if bdev_read_page failed.
> 
> This will at least break the failure path of zram_rw_page().

Yes, it needs post processing for error propagaion like *page* handling
part in end_swap_bio_read(mostly, PG_error and PG_uptodate with pr_alert).
bdev_read_page's sematic doesn't need to be synchronous so it could just
submit the IO request and complete the IO afterward. In that case, we
need right error handling, too if the IO encoutered error. BIO fallback
makes it simple.

 * bdev_read_page() - Start reading a page from a block device
 * @bdev: The device to read the page from
 * @sector: The offset on the device to read the page to (need not be aligned)
 * @page: The page to read
 *
 * On entry, the page should be locked.  It will be unlocked when the page
 * has been read.  If the block driver implements rw_page synchronously,
 * that will be true on exit from this function, but it need not be.
 *
 * Errors returned by this function are usually "soft", eg out of memory, or
 * queue full; callers should try a different route to read this page rather
 * than propagate an error back up the stack.

The other concern about this patch is zram have used rw_page for a long
time even though sometime it doesn't declare BDI_CAP_SYNCHRONOUS_IO by itself
because rw_page shows 4~5% bandwidth improvement compared to bio-based.
The performance gain becomes more important these day because compressor
becomes more fast day by day.

> 
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  mm/page_io.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index ccda7679008851..63b44b8221af0f 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -403,8 +403,11 @@ int swap_readpage(struct page *page, bool synchronous)
> >                 goto out;
> >         }
> >
> > -       ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> > -       if (!ret) {
> > +       if (sis->flags & SWP_SYNCHRONOUS_IO) {
> > +               ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> > +               if (ret)
> > +                       goto out;
> > +
> >                 if (trylock_page(page)) {
> >                         swap_slot_free_notify(page);
> >                         unlock_page(page);
> > --
> > 2.27.0
> >
