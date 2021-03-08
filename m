Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6B33156B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 19:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhCHSCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCHSB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:01:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016DBC06175F
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 10:01:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so16094006edx.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zcp9aSnYoFbyB3tMeqX2oxWSrOP4DQTmgBJZuYBvDA=;
        b=yTqFiowg+ZrDQtEMf4WQCSpsgfGWzoDQpdhdJUNvav3WFR5Fl31Twy3LzXQ2HywcM+
         RrbZGR8F02Tfetm3U1Lpxu5XyG1yT1ZlQCSohl2vOC3g4QMqojDgmBTgZc1b7kG68+yV
         VvPcGQfwXkSyNByekhFWqNxqJNGNZ1+f3remo8UT9cc1o16+QjcJXep8wsZYGU18HbSI
         J7TDY5zxBQvWjRoJl6piqGZe+IQgnXAn3scq0hzfsDM4IaSKP59goSfGKo+1LLciZRW9
         xc+lFfDGbSOygStnXQhI8ZPnjq5+SAPHsYR702i3ZVA61b2FRGUPNiC8fjLf0KqLjF9a
         30lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zcp9aSnYoFbyB3tMeqX2oxWSrOP4DQTmgBJZuYBvDA=;
        b=Fj4hFmc4wJgeG7qLgcY1pO4I2m5jonkgBfcYrq7qkHTZMTUOejceapr+9DWAXMe5uL
         k4I6rAATl6KTux13k4H/CxpGDrY+Y2VYXHsv6uzKhnerv8g20uL+HPSzpX6E6RqHxlnL
         x3udtdGd8c4M5/Yg6OFNP2b1z2qwQHtgAM4Il0M88tEJfsUoKjY4QjM/GIz3ymNZiv/8
         1O8K78Zh1aIG1sYNThG5hIJOXM35Yp6Psgbg567Wgsjtnw9Z+pJUNwihR9BLcZvEWTIj
         2/H+tTyDv5DqT00lzpez1v2/3e/qQRCk8iaScTEwMD+LdMsoyRc1l4B4p+Ek0aEsogoY
         j4sg==
X-Gm-Message-State: AOAM530CLCprLxMGiOyrGePp7iPHxJKYVzob5USDmrURug12cpQAQdSr
        BnlK/Hm+/QQeWEXp6UgL4alcSCN0K+5XIWnIvDr7gg==
X-Google-Smtp-Source: ABdhPJyiH5A/Lsq6qgR2AevlyxpZfOCI02f/Sq+KNGBFf5iXaQ47vO/OVkIBwMUvOxYfFtKqEcOogvchILyJzJrHkW4=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr11617699edw.348.1615226515542;
 Mon, 08 Mar 2021 10:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com> <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com> <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Mar 2021 10:01:52 -0800
Message-ID: <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 8, 2021 at 3:34 AM ruansy.fnst@fujitsu.com
<ruansy.fnst@fujitsu.com> wrote:
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > > > index 79c49e7f5c30..0bcf2b1e20bd 100644
> > > > > --- a/include/linux/memremap.h
> > > > > +++ b/include/linux/memremap.h
> > > > > @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
> > > > >          * the page back to a CPU accessible page.
> > > > >          */
> > > > >         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> > > > > +
> > > > > +       /*
> > > > > +        * Handle the memory failure happens on one page.  Notify the processes
> > > > > +        * who are using this page, and try to recover the data on this page
> > > > > +        * if necessary.
> > > > > +        */
> > > > > +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> > > > > +                             int flags);
> > > > >  };
> > > >
> > > > After the conversation with Dave I don't see the point of this. If
> > > > there is a memory_failure() on a page, why not just call
> > > > memory_failure()? That already knows how to find the inode and the
> > > > filesystem can be notified from there.
> > >
> > > We want memory_failure() supports reflinked files.  In this case, we are not
> > > able to track multiple files from a page(this broken page) because
> > > page->mapping,page->index can only track one file.  Thus, I introduce this
> > > ->memory_failure() implemented in pmem driver, to call ->corrupted_range()
> > > upper level to upper level, and finally find out files who are
> > > using(mmapping) this page.
> > >
> >
> > I know the motivation, but this implementation seems backwards. It's
> > already the case that memory_failure() looks up the address_space
> > associated with a mapping. From there I would expect a new 'struct
> > address_space_operations' op to let the fs handle the case when there
> > are multiple address_spaces associated with a given file.
> >
>
> Let me think about it.  In this way, we
>     1. associate file mapping with dax page in dax page fault;

I think this needs to be a new type of association that proxies the
representation of the reflink across all involved address_spaces.

>     2. iterate files reflinked to notify `kill processes signal` by the
>           new address_space_operation;
>     3. re-associate to another reflinked file mapping when unmmaping
>         (rmap qeury in filesystem to get the another file).

Perhaps the proxy object is reference counted per-ref-link. It seems
error prone to keep changing the association of the pfn while the
reflink is in-tact.

> It did not handle those dax pages are not in use, because their ->mapping are
> not associated to any file.  I didn't think it through until reading your
> conversation.  Here is my understanding: this case should be handled by
> badblock mechanism in pmem driver.  This badblock mechanism will call
> ->corrupted_range() to tell filesystem to repaire the data if possible.

There are 2 types of notifications. There are badblocks discovered by
the driver (see notify_pmem()) and there are memory_failures()
signalled by the CPU machine-check handler, or the platform BIOS. In
the case of badblocks that needs to be information considered by the
fs block allocator to avoid / try-to-repair badblocks on allocate, and
to allow listing damaged files that need repair. The memory_failure()
notification needs immediate handling to tear down mappings to that
pfn and signal processes that have consumed it with
SIGBUS-action-required. Processes that have the poison mapped, but
have not consumed it receive SIGBUS-action-optional.

> So, we split it into two parts.  And dax device and block device won't be mixed
> up again.   Is my understanding right?

Right, it's only the filesystem that knows that the block_device and
the dax_device alias data at the same logical offset. The requirements
for sector error handling and page error handling are separate like
block_device_operations and dax_operations.

> But the solution above is to solve the hwpoison on one or couple pages, which
> happens rarely(I think).  Do the 'pmem remove' operation cause hwpoison too?
> Call memory_failure() so many times?  I havn't understood this yet.

I'm working on a patch here to call memory_failure() on a wide range
for the surprise remove of a dax_device while a filesystem might be
mounted. It won't be efficient, but there is no other way to notify
the kernel that it needs to immediately stop referencing a page.
