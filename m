Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6A347FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhCXSA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 14:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhCXSA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:00:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3926C0613DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 11:00:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jy13so34349224ejc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KFNkl1or0mmtXA1jvsRAF0OANfT9njIYX+exK4jOos=;
        b=vFzEiq5fNjCN/7R0WwqtTXBrQesBMnmm7Yt0aIk36IUzb9nz2Iwwjuku88ov5xGoo7
         I2nZHiAzvvorrWHog5G+fz0o6Iwgp6fPe5BX5ALrKM8J8rriLQBF2bQ6iQmCTySTWQeW
         U//yvsIy1PSHAhs/SX8wnQHVLy4lhbL9aV+PelAq1xjXUrvVSvyfV6E/eLWQI3REFqaQ
         He1p0+EQfwXwRd5c1XOplbo7llR+YgnDVh0Qw+Ot0l9QZsjaixzo1kAkhZJUMzGxY+ki
         n7X09BFlfP5Sp9r65op8Vg3Ww+4V6SnFtzm8Ym0iKZ0MacVqsqNvp80/mc20puyxivuG
         ceGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KFNkl1or0mmtXA1jvsRAF0OANfT9njIYX+exK4jOos=;
        b=DpOblRe5DfOzSosa0QSRRTino1P1i0X6S6X4eKpPM5ucRo1l6HxASdETIwP2wtMRWS
         uZqjaUT00/3/K0BfDP89MBnWIu97UELnHlVGFKqxzmcgTfB38+w/fdMsnEfMguK+zNrg
         F12SCSt4H+VLH6wYkSLHy7tIgX6tiHMaxBRZM0ve3A1Mi6P4a0c/ZruJl6/kAWWpFD5G
         /Tux0KaP1uAA67Bt8fMkEQg9d8QcQisBAAjpG5mXvzOtvfCU4O4VZOiHfBZBC6KxLMwR
         RNyL4LNnz3XFdrzmsw411c5jqR8rZ6bcR1yoEiOHlbXEgawJmEwtzjE2kvNxI4h7tJBV
         LWdw==
X-Gm-Message-State: AOAM531Tgi3w2tLS3OETUd7sPKK2x6aTIwJ/uler3vzLrFjgFstRekn0
        qs5dpsv+SMWqKW+sd3PlPnoX3InctkcyV0c7FpaJpw==
X-Google-Smtp-Source: ABdhPJy9J40IqLa/d+cck6PXVVGYBFPLo6iqEOA+v2R4s6asbN5wOCf5ZJ6fNNbFdsT8bCsuZH/tAzIMp5hm7zOGEdw=
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr5154772ejy.523.1616608827202;
 Wed, 24 Mar 2021 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4jhUU3NVD8HLZnJzir+SugB6LnnrgJZ-jP45BZrbJ1dJQ@mail.gmail.com>
 <20210324074751.GA1630@lst.de> <CAPcyv4hOrYCW=wjkxkCP+JbyD+A_Po0rW-61qQWAOm3zp_eyUQ@mail.gmail.com>
 <20210324173935.GB12770@lst.de>
In-Reply-To: <20210324173935.GB12770@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 11:00:16 -0700
Message-ID: <CAPcyv4iyS0EB0zLNxLwML1C0E2Eqk3TweHvmgpNWpZKVPVpz5Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To:     Christoph Hellwig <hch@lst.de>
Cc:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 24, 2021 at 09:37:01AM -0700, Dan Williams wrote:
> > > Eww.  As I said I think the right way is that the file system (or
> > > other consumer) can register a set of callbacks for opening the device.
> >
> > How does that solve the problem of the driver being notified of all
> > pfn failure events?
>
> Ok, I probably just showed I need to spend more time looking at
> your proposal vs the actual code..
>
> Don't we have a proper way how one of the nvdimm layers own a
> spefific memory range and call directly into that instead of through
> a notifier?

So that could be a new dev_pagemap operation as Ruan has here. I was
thinking that other agents would be interested in non-dev_pagemap
managed ranges, but we could leave that for later and just make the
current pgmap->memory_failure() callback proposal range based.

>
> > Today pmem only finds out about the ones that are
> > notified via native x86 machine check error handling via a notifier
> > (yes "firmware-first" error handling fails to do the right thing for
> > the pmem driver),
>
> Did any kind of firmware-first error handling ever get anything
> right?  I wish people would have learned that by now.

Part of me wants to say if you use firmware-first you get to keep the
pieces, but it's not always the end user choice as far as I
understand.

> > or the ones that are eventually reported via address
> > range scrub, but only for the nvdimms that implement range scrubbing.
> > memory_failure() seems a reasonable catch all point to route pfn
> > failure events, in an arch independent way, to interested drivers.
>
> Yeah.
>
> > I'm fine swapping out dax_device blocking_notiier chains for your
> > proposal, but that does not address all the proposed reworks in my
> > list which are:
> >
> > - delete "drivers/acpi/nfit/mce.c"
> >
> > - teach memory_failure() to be able to communicate range failure
> >
> > - enable memory_failure() to defer to a filesystem that can say
> > "critical metadata is impacted, no point in trying to do file-by-file
> > isolation, bring the whole fs down".
>
> This all sounds sensible.

Ok, Ruan, I think this means rework your dev_pagemap_ops callback to
be range based. Add a holder concept for dax_devices and then layer
that on Christoph's eventual dax_device callback mechanism that a
dax_device holder can register.
