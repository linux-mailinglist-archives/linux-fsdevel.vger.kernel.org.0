Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23ECA1AF3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 05:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfEMDwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 23:52:04 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42986 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfEMDwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 23:52:04 -0400
Received: by mail-ua1-f68.google.com with SMTP id e9so3777172uar.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2019 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gL6JQrKD/INdIX7UdqqiTk1mR3eypn5Q/g1KxOWTus=;
        b=N1wgvnMQMb1ehlRFk7aEVtAOG5POjwii6YU4IVRzZOrMA6YlGE7nOsNvdKzGwBZLvG
         jSJr4z2P1/HbYBHvJj4CFqwx9FNd3OrBFK2M0wgTb6y1FpNbVaS8nrrKx1U+90lV9kCv
         3LeZYV9pGjw0DE2R/fKUjid0tfNkaSMmEtgGjiO68m5dcMmJayTeu3mQo5Rh2l88Rr//
         b9c6Pt65OE1bP/Y9HyPVRsoHVkr6mKV6+69vL9HlJFq1vX+kKvXUKQDf98RufYEbZyK4
         0nbnDICnTN/Vv7amalil6cvduvLcFguxMoELzi9RdwYIMSe9tpORwqiblH5Pmc7nTZJP
         FFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gL6JQrKD/INdIX7UdqqiTk1mR3eypn5Q/g1KxOWTus=;
        b=DrAR672j4ho833Aj/ZJKdbQ7hMojZ1itJMT0vLnLBOSAvdbbqdgSBkZ5e6VNce3HmH
         nmv1RuqsSUjuQyFT/wN4L+AvtY8qxXxgdNcy5JtsCQYQuiQp5h7BmigaShLoxMH5uwVI
         6PHswGzsWtBbpJTZ8swPz0T4unnW0DA+urPrPeuKQyncrZE/v5SD3DJHKsGDc4j+/h9H
         p5tRsoI3PPkdVd9+4S8bTiGM5JrP/pSn1M9FuQMy5nTFVc3JKVPmGfUdGBMNcbw+6q9Y
         rcyxEBMF2iAlvYhXvUyGHBaIuAEXcMXnKAuKKQTNAldikwXX7HCSsuWpCO15LltEMSnd
         fdzg==
X-Gm-Message-State: APjAAAXXfdYhQ2S0nt0zMr+35sqEAW2V0e89y/HiJKkB1UYs7FBUcSdk
        aAFjmc633i4yZxFJ6FU3b2NbdfnUcsBNBd6wMMLK507iXp4=
X-Google-Smtp-Source: APXvYqxxzHRSCxL2lzj7GpsamPH7M/suIY8pXiUNBmGQu2EVBD/yl3G4IDycgfmu71cfX3XVitMc7AFdGU+3Rzb8x0s=
X-Received: by 2002:ab0:14c6:: with SMTP id f6mr12343234uae.30.1557719522942;
 Sun, 12 May 2019 20:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+49okpy=FUsZpc-WcBG9tMUwzgP7MYNuPPKN22BR=dq3HQ9tA@mail.gmail.com>
 <CA+49okq7+G7wRgr4N8QLMf-6pvqvYumMQzX6qrvp-qQQsRsGHQ@mail.gmail.com>
 <20190513022222.GA3721@bombadil.infradead.org> <CA+49okrrsRvmuz_v5sdbsSkkZrP7RdT1ko3POYgKmj_35_is1Q@mail.gmail.com>
In-Reply-To: <CA+49okrrsRvmuz_v5sdbsSkkZrP7RdT1ko3POYgKmj_35_is1Q@mail.gmail.com>
From:   Shawn Landden <slandden@gmail.com>
Date:   Sun, 12 May 2019 22:51:51 -0500
Message-ID: <CA+49okqUvMidjhZaou63Bzrq_BLR5KnwPcqvUq0aJ24mYUFNSg@mail.gmail.com>
Subject: Re: COW in XArray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Actually, I am sorry. I will have to put some more thought into how to
do this, as it might be possible without only some bitmaps to keep
track of invalidated processes.

On Sun, May 12, 2019 at 10:42 PM Shawn Landden <slandden@gmail.com> wrote:
>
> On Sun, May 12, 2019 at 9:22 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, May 12, 2019 at 09:56:47AM -0500, Shawn Landden wrote:
> > > I am trying to implement epochs for pids. For this I need to allow
> > > radix tree operations to be specified COW (deletion does not need to
> > > change). Radix
> > > trees look like they are under alot of work by you, so how can I best
> > > get this feature, and have some code I can work with to write my
> > > feature?
> >
> > Hi Shawn,
> >
> > I'd love to help, but I don't quite understand what you want.
> >
> > Here's the conversion of the PID allocator from the IDR to the XArray:
> >
> > http://git.infradead.org/users/willy/linux-dax.git/commitdiff/223ad3ae5dfffdfc5642b1ce54df2c7836b57ef1
> >
> > What semantics do you want to change?
> When allocating a pid, you pass an epoch number. If the pids being
> allocated wrap, then the epoch is incremented, and a new radix tree
> created that is COW of the last epoch. If the page that is found for
> allocation is of an older epoch, it is copied and the allocation only
> happens in the copy.
>
> On freeing a pid, there a single radix-tree bit for every still-active
> epoch that is set to indicate that this slot has expired. This will be
> used for the (new) waitpidv syscall, which can provide all the
> functionality of wait4() and more, and allows process to synchronize
> their references to the current epoch.
>
> The current versions of the pid syscalls will continue to operate with
> the same existing racy semantics. New pid syscalls will be added that
> take an epoch argument. A current pid epoch u32 is added to
> task_sched, that reset on fork() when a new process is allocated, then
> a new pid is allocated, and the epoch has a prctl setter and getter.
>
> If a syscall comes in with and the epoch passed is not current AND has
> passed the pid of the process (this is not a lock, because we current
> and previous epochs are always available), then it might fail with
> EEPOCH, the caller then has to call a new syscall, waitpidv(pidv
> *pid_t, epoch, O_NONBLOCK) providing a list of pids it has references
> to in a specific epoch, and it gets back a list of which processes
> have excited.
>
> The epoch of a process is always relative to it's pid (not thread-id),
> so the same epoch number can mean differn't things in differn't
> places.
>
> The process can then invalidate its own internal pids and use ptctl to
> indicate it doesn't need the old epoch. Processes also get a signal if
> they haven't updated and are 2 full epochs behind. Being behind should
> also could against a process in kernel memory accounting. I am sure
> there is much more to consider....
