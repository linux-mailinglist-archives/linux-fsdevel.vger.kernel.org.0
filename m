Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1602D362C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbgLHWXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 17:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbgLHWXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:23:54 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA259C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Dec 2020 14:23:13 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id jx16so85199ejb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDvIgwM3KYUr0vGzGaIWWHLyAec1spjaULYt1zzdT4s=;
        b=lcCLQiHgKOnWsKLetWZmR5QtSD6blr1zwiw554WVg0AiNLsDu/kt6/L2pZGQeRHIlR
         sk4AVKxRad9oVAN0P4xpOslW8DxPRoB5wUGIl/7BR8VDXluBCoCy3GltHE+FXzPRrQxR
         wQej/D6bXtMRk92njXQqKJZQH8etZbXv83JEtSOT5th+HgexH+PpCMk0aUGWuYCayWqM
         vOXlOUNv+ppF55wtH9HFHRDVUrwvk/2TbLHkv8ldtjRRWc/2AULYvbscWV+jss9n54tu
         WpKpNOLYTePYoJy7ePGx930oJcVthHof02l6Ltv8q8N765mB7nbm99dZ7SnDj/JyCKdm
         eCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDvIgwM3KYUr0vGzGaIWWHLyAec1spjaULYt1zzdT4s=;
        b=SIf744y3KMQxbYCaaadHMQlorGY8OSbRB1xDTwvLPDvPZLNwj1jt+YvOQmkjV9aHIV
         tXZ5EwTTl1L2+7rAXqi7kU52dzuk0x62LqrdRPDAiXvaMljOkQdsE3X9w0mR+YWRZ+lM
         iUYe3wBSRUwJD/sgX0i2+Gr3tN+0UHy0qK5tORYpub/jRaTuIkuWha7TKcY1jnyAOx1I
         +Rsf7kTn66Qbd+wOPEm/VFh/+axsEL13MQvsoQkXxz5mQWoqEco/NxPuKa2gT7/f7CIv
         3kcKkz1S8Bi/Jv3sd2b412v6SfhQTWGmMrKeGWVrNtpH1EAwFKABVG0GU7M/5IvIIh2I
         gK0g==
X-Gm-Message-State: AOAM531d/Kiq9wk3djIKS4GLzEf5+GP2hBsaQ/Uk+EBMe5ub231CHnsU
        zouVku/YAPCk6D8kGtJ+Phlx2kQfVDP+zICnArnNHw==
X-Google-Smtp-Source: ABdhPJz7hpkHYZQB8gPmkyjxkrTY7+BAotTEDsjnew5emDltxEq0pnKaMyyY9J6ssfhQwUmQYIos3XCw3hu+XH++d88=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr23993748ejb.264.1607466192389;
 Tue, 08 Dec 2020 14:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20201207225703.2033611-1-ira.weiny@intel.com> <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org> <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org> <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com> <20201208215028.GK7338@casper.infradead.org>
In-Reply-To: <20201208215028.GK7338@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Dec 2020 14:23:10 -0800
Message-ID: <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 1:51 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 08, 2020 at 01:32:55PM -0800, Ira Weiny wrote:
> > On Mon, Dec 07, 2020 at 03:49:55PM -0800, Dan Williams wrote:
> > > On Mon, Dec 7, 2020 at 3:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Dec 07, 2020 at 03:34:44PM -0800, Dan Williams wrote:
> > > > > On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > > > > > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > > > > > > +                            struct page *src_page, size_t src_off,
> > > > > > > +                            size_t len)
> > > > > > > +{
> > > > > > > +     char *dst = kmap_local_page(dst_page);
> > > > > > > +     char *src = kmap_local_page(src_page);
> > > > > >
> > > > > > I appreciate you've only moved these, but please add:
> > > > > >
> > > > > >         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> > > > >
> > > > > I imagine it's not outside the realm of possibility that some driver
> > > > > on CONFIG_HIGHMEM=n is violating this assumption and getting away with
> > > > > it because kmap_atomic() of contiguous pages "just works (TM)".
> > > > > Shouldn't this WARN rather than BUG so that the user can report the
> > > > > buggy driver and not have a dead system?
> > > >
> > > > As opposed to (on a HIGHMEM=y system) silently corrupting data that
> > > > is on the next page of memory?
> > >
> > > Wouldn't it fault in HIGHMEM=y case? I guess not necessarily...
> > >
> > > > I suppose ideally ...
> > > >
> > > >         if (WARN_ON(dst_off + len > PAGE_SIZE))
> > > >                 len = PAGE_SIZE - dst_off;
> > > >         if (WARN_ON(src_off + len > PAGE_SIZE))
> > > >                 len = PAGE_SIZE - src_off;
> > > >
> > > > and then we just truncate the data of the offending caller instead of
> > > > corrupting innocent data that happens to be adjacent.  Although that's
> > > > not ideal either ... I dunno, what's the least bad poison to drink here?
> > >
> > > Right, if the driver was relying on "corruption" for correct operation.
> > >
> > > If corruption actual were happening in practice wouldn't there have
> > > been screams by now? Again, not necessarily...
> > >
> > > At least with just plain WARN the kernel will start screaming on the
> > > user's behalf, and if it worked before it will keep working.
> >
> > So I decided to just sleep on this because I was recently told to not introduce
> > new WARN_ON's[1]
> >
> > I don't think that truncating len is worth the effort.  The conversions being
> > done should all 'work'  At least corrupting users data in the same way as it
> > used to...  ;-)  I'm ok with adding the WARN_ON's and I have modified the patch
> > to do so while I work through the 0-day issues.  (not sure what is going on
> > there.)
> >
> > However, are we ok with adding the WARN_ON's given what Greg KH told me?  This
> > is a bit more critical than the PKS API in that it could result in corrupt
> > data.
>
> zero_user_segments contains:
>
>         BUG_ON(end1 > page_size(page) || end2 > page_size(page));
>
> These should be consistent.  I think we've demonstrated that there is
> no good option here.

True, but these helpers are being deployed to many new locations where
they were not used before.
