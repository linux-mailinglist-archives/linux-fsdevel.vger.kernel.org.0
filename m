Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339302D4AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgLITsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 14:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgLITsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:48:40 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06FC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 11:48:00 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id g20so3916907ejb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 11:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsll6aprTPCbO5sTOq3PqZayd/y4SfYjxDP+csUrtX4=;
        b=06AsXUG6DFkUZdeym5IUJf5akhsWQWaGOarJsg3OZdNkLNQSeAcU8oTGFenI+cm8au
         tEirEk7bmHNQCIqJOK5J0Z20mWnml6/IsYhAoVEJJN4+yekg90X398kci4VxdZi83Tst
         RTD6NL9bNQFQUsxvTFRbjMzTDltf1rL1FmCuQf9cURXgbdKD825/Rkcd9Dc8OTyrJh21
         ijoF//0UdWodetZLQCVANlUGfGa2Izs4VDPKYZ8sEeEelkk+ZjaM9pKDn/XzYBRfWRkQ
         2/W79SnraP4NANLAixBmzv9g7e6INw8FcRHbhILTDKrxI3aGXSVWxQwsufRZgQknhv+k
         wvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsll6aprTPCbO5sTOq3PqZayd/y4SfYjxDP+csUrtX4=;
        b=Id5+MMXkE8LdgQLiduTadspBvcZHM4OT4A0oqauEBwbMvbr+qW8d2pdolFr8ldJw/I
         gWU5zBoi7LpbP++xS/rojVBnGgai/j9xCx0lWer/yKdwdB2VI684NVO2lWW8NgqHaHyY
         +/rf+gxQUBf7xYeBOsRGLbVyIRdoMt87ntpbB2/qFVUERYxGUL3daZE+XeYjAov2JMVK
         e1R1GZDW7I6Cm9UC0yZfGMyXdIT3U3ZjE66jvFEVsAbAE/TOYKabwsO+TMRvX3xHa3os
         HWyyhUKNiWqOgP4ORCpgQjX9F5W3CQbTsANby/H1EwBpBwAmZ5pzcJo9TWwNfMnUU3ke
         TPlw==
X-Gm-Message-State: AOAM533pYnrXu8JfvQh6DeS3S6XyLzm8nOyIULhNimpa+MMm1TkFKEcZ
        /U02il2PUNCMTMsiKEoHGRci/eP21kx87ay6J/uKYA==
X-Google-Smtp-Source: ABdhPJyfJT6jQ/kpMwEgKSHnj04XzX0kf/syoi9lWAFNYIq5dzVNx4rn3/59EYVkJHFFyY2aooKjUhQ0DmDhXJhR6Aw=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr3497106ejk.323.1607543278769;
 Wed, 09 Dec 2020 11:47:58 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org> <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com> <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org> <20201208224555.GA605321@magnolia>
 <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
 <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com> <20201209040312.GN7338@casper.infradead.org>
In-Reply-To: <20201209040312.GN7338@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 11:47:56 -0800
Message-ID: <CAPcyv4iD0eprWC_kMOdYdX-GvT-72OjZB-CKA9b5qV8BwNQ+6A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
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

On Tue, Dec 8, 2020 at 8:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 08, 2020 at 06:22:50PM -0800, Ira Weiny wrote:
> > Right now we have a mixed bag.  zero_user() [and it's variants, circa 2008]
> > does a BUG_ON.[0]  While the other ones do nothing; clear_highpage(),
> > clear_user_highpage(), copy_user_highpage(), and copy_highpage().
>
> Erm, those functions operate on the entire PAGE_SIZE.  There's nothing
> for them to check.
>
> > While continuing to audit the code I don't see any users who would violating
> > the API with a simple conversion of the code.  The calls which I have worked on
> > [which is many at this point] all have checks in place which are well aware of
> > page boundaries.
>
> Oh good, then this BUG_ON won't trigger.
>
> > Therefore, I tend to agree with Dan that if anything is to be done it should be
> > a WARN_ON() which is only going to throw an error that something has probably
> > been wrong all along and should be fixed but continue running as before.
>
> Silent data corruption is for ever.  Are you absolutely sure nobody has
> done:
>
>         page = alloc_pages(GFP_HIGHUSER_MOVABLE, 3);
>         memcpy_to_page(page, PAGE_SIZE * 2, p, PAGE_SIZE * 2);
>
> because that will work fine if the pages come from ZONE_NORMAL and fail
> miserably if they came from ZONE_HIGHMEM.

...and violently regress with the BUG_ON.

The question to me is: which is more likely that any bad usages have
been covered up by being limited to ZONE_NORMAL / 64-bit only, or that
silent data corruption has been occurring with no ill effects?

> > FWIW I think this is a 'bad BUG_ON' use because we are "checking something that
> > we know we might be getting wrong".[1]  And because, "BUG() is only good for
> > something that never happens and that we really have no other option for".[2]
>
> BUG() is our only option here.  Both limiting how much we copy or
> copying the requested amount result in data corruption or leaking
> information to a process that isn't supposed to see it.

At a minimum I think this should be debated in a follow on patch to
add assertion checking where there was none before. There is no
evidence of a page being overrun in the audit Ira performed.
