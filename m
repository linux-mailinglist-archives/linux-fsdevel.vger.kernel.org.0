Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5AA16B6A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 01:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBYA0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 19:26:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43015 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgBYA03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:26:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so10469802oth.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 16:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rZ6Shn1iEFflpkftjdeTvb007+jMCYxKoLbQJtlZWQ=;
        b=Xdxa0eBbfn0aKqraLTJQp3oGkia1mjCDPmnrEfzQRB5bmAQJYV7nLJkWxEdX25hSIE
         PpCq0r/J/kaVC7pQXWP1UINukEZ2zRJXRUP53gwuFM8QenxuW8sR4eDb3XA11YdbZgHq
         9n4xi9kz8Z7zqi0qf2cZSudUAEdGAptnGsfgQhXW9Ha/meJ28b+uSVz7rh/OYB0UC/vH
         +3yrolw4oqz2PAVKD5zo5HWeA3HKXEsVXvqvpTFb8JO35L6ffEcC3dsS3G1Ha9Y+FngM
         NU/TmnR88heSOC1qcC3pgdV7Ggr8KlHPHs6syxHpuDuuw8yc3T7bBZ7lPB8AcGT+tRPp
         UA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rZ6Shn1iEFflpkftjdeTvb007+jMCYxKoLbQJtlZWQ=;
        b=fc+MBEiboqWg966O86ymJnzjpvwez3myW0jUDi9hL53jd4c2jkU5fozmsrc+hDU0RW
         Oz+0uR1a4qRBBEy8WmHSwjykeVfGBxsVkeTreipIFde+9nP5xt01s7qS2fRoOfEXoaek
         XfhB6m+tBl2i09tDJz8WSzdD+G2a97lQoncGD0fJZPDbVQab51V8hWCj/VgYHixp7fWv
         4jRGjCL5IiQELczp4glCQ+XX19A1aF2txMeMeWZspiwJfX4SXMQ/IDjCNjT0XCLwODRG
         0UvU2KrzU+yXhOUpTGQqv0ib7WnW3AIWgbBznccHN3lBofTX/UTEut37dzmutmAsltr6
         NG6A==
X-Gm-Message-State: APjAAAUzBKdAr0felC5yD7+y3XU5CdRVQG4T4TZ4uYpTNoitC5tYGyZk
        4JaWpwExfzmiw5cwxDUtNDYygCX535vXhl4gGNuxjA==
X-Google-Smtp-Source: APXvYqxoQtHTd57hLQp9etLHy7uFPZjDlgE79OhxjWcTaJ17f4leO7kHK5MW1rp7sufBCeRKgCdAZWUGb/c8NCZ5utQ=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr19922104otq.126.1582590388685;
 Mon, 24 Feb 2020 16:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area> <CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
 <x49blpop00m.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gCA_oR8_8+zhAhMnqOga9GcpMX97S+x8_UD6zLEQ0Cew@mail.gmail.com>
 <x49sgizodni.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49sgizodni.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 Feb 2020 16:26:17 -0800
Message-ID: <CAPcyv4gUM47QgGKvK4ZVUek6f=ABT7hRFX47-DQiD6AcrxtRHA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:53 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> >> Let's just focus on reporting errors when we know we have them.
> >
> > That's the problem in my eyes. If software needs to contend with
> > latent error reporting then it should always contend otherwise
> > software has multiple error models to wrangle.
>
> The only way for an application to know that the data has been written
> successfully would be to issue a read after every write.  That's not a
> performance hit most applications are willing to take.  And, of course,
> the media can still go bad at a later time, so it only guarantees the
> data is accessible immediately after having been written.
>
> What I'm suggesting is that we should not complete a write successfully
> if we know that the data will not be retrievable.  I wouldn't call this
> adding an extra error model to contend with.  Applications should
> already be checking for errors on write.
>
> Does that make sense? Are we talking past each other?

The badblock list is late to update in both directions, late to add
entries that the scrub needs to find and late to delete entries that
were inadvertently cleared by cache-line writes that did not first
ingest the poison for a read-modify-write. So I see the above as being
wishful in using the error list as the hard source of truth and
unfortunate to up-level all sub-sector error entries into full
PAGE_SIZE data offline events.

I'm hoping we can find a way to make the error handling more fine
grained over time, but for the current patch, managing the blast
radius as PAGE_SIZE granularity at least matches the zero path with
the write path.

> > Setting that aside we can start with just treating zeroing the same as
> > the copy_from_iter() case and fail the I/O at the dax_direct_access()
> > step.
>
> OK.
>
> > I'd rather have a separate op that filesystems can use to clear errors
> > at block allocation time that can be enforced to have the correct
> > alignment.
>
> So would file systems always call that routine instead of zeroing, or
> would they first check to see if there are badblocks?

The proposal is that filesystems distinguish zeroing from free-block
allocation/initialization such that the fsdax implementation directs
initialization to a driver callback. This "initialization op" would
take care to check for poison and clear it. All other dax paths would
not consult the badblocks list.
