Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161861AF35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 05:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfEMDmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 23:42:23 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43872 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMDmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 23:42:23 -0400
Received: by mail-vk1-f193.google.com with SMTP id h72so2932368vkh.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2019 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJgFbiUPQUZfJI0lrB3JMmKKoEDj4m9RMcbOR4qyzu0=;
        b=sTCGOJY4atPerCR5x1VdEW0AMNU1ktirMjK10pWDV2HVkV45IPLAAdJpNzYkhzpIvg
         dmtGlgN+qY0AYYWenL8XZMjmu8d4n1ucvPm6tn+Y48QCa5lRvrhMfPOvowKr0Kb/o1DE
         Gv6lgNIKb/2yl+Tf4q9XeVYzgNgxuWW4HiI4kba64ymvZvUL/eDsEswvDGVWvEQlOlXr
         rcCUe54UsvQ5OOIL5WInDftNm18kxZ1qKMrGOSY340N4OR+ymZX9/QaLGxnHhw0xBr7r
         +zqdY1PRqHHh9UTRiH2vMujM4V/8O8prA9OVYRg7dZMUw0GtvpEdhd6ltG7TXDS/xZt2
         AWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJgFbiUPQUZfJI0lrB3JMmKKoEDj4m9RMcbOR4qyzu0=;
        b=HEOJYlROPjA339lKRwiR+pRJItNb+YrtE38IpZPFmCO8SLRIIwUcPFK9XTwFYu+9nE
         V9dNWlvSlsxw2mYqIpgiARNnLrnIR9z1EZBSm2zqFDYd6Jd7CcElRHo2OVxCxapzmKQi
         QbsaNqDBakM/mmRPrGXAPoclWyGewJMIVt4xakEm9mHEr9ftIY66A2EXnnfJGmGFgqhJ
         BcsNjHgrAC+XSyk+RIaTRyEHfv74h4Dh6InIPWnUzqI0WFbG5jfuwpCoY3jp3cYVP3uH
         x8qbAjfFdyRBDsXbPyuIOhUmNIYfSz1pqTXD3tV40Sc9MdUiO3+og8Vt16rcn+1lsSNi
         +kzA==
X-Gm-Message-State: APjAAAUCQxej3NnRt5C/6Du9nj2O8g/kdOmaUlAm2P4+1n2owW02xIly
        69IZ0dlOFRO9TJNQu1JXbixBLnMX1F+c+EWfTS/IoTejAM0=
X-Google-Smtp-Source: APXvYqxWtIjgeCkyFg56+dksd0AGa6J/j3iM7MdZhj8MILrmROaYb4QjwAH808oVYeRFpsqjNRCqpllV9e3XjF2EZ9I=
X-Received: by 2002:a1f:9501:: with SMTP id x1mr11282606vkd.12.1557718942486;
 Sun, 12 May 2019 20:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+49okpy=FUsZpc-WcBG9tMUwzgP7MYNuPPKN22BR=dq3HQ9tA@mail.gmail.com>
 <CA+49okq7+G7wRgr4N8QLMf-6pvqvYumMQzX6qrvp-qQQsRsGHQ@mail.gmail.com> <20190513022222.GA3721@bombadil.infradead.org>
In-Reply-To: <20190513022222.GA3721@bombadil.infradead.org>
From:   Shawn Landden <slandden@gmail.com>
Date:   Sun, 12 May 2019 22:42:11 -0500
Message-ID: <CA+49okrrsRvmuz_v5sdbsSkkZrP7RdT1ko3POYgKmj_35_is1Q@mail.gmail.com>
Subject: Re: COW in XArray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 12, 2019 at 9:22 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, May 12, 2019 at 09:56:47AM -0500, Shawn Landden wrote:
> > I am trying to implement epochs for pids. For this I need to allow
> > radix tree operations to be specified COW (deletion does not need to
> > change). Radix
> > trees look like they are under alot of work by you, so how can I best
> > get this feature, and have some code I can work with to write my
> > feature?
>
> Hi Shawn,
>
> I'd love to help, but I don't quite understand what you want.
>
> Here's the conversion of the PID allocator from the IDR to the XArray:
>
> http://git.infradead.org/users/willy/linux-dax.git/commitdiff/223ad3ae5dfffdfc5642b1ce54df2c7836b57ef1
>
> What semantics do you want to change?
When allocating a pid, you pass an epoch number. If the pids being
allocated wrap, then the epoch is incremented, and a new radix tree
created that is COW of the last epoch. If the page that is found for
allocation is of an older epoch, it is copied and the allocation only
happens in the copy.

On freeing a pid, there a single radix-tree bit for every still-active
epoch that is set to indicate that this slot has expired. This will be
used for the (new) waitpidv syscall, which can provide all the
functionality of wait4() and more, and allows process to synchronize
their references to the current epoch.

The current versions of the pid syscalls will continue to operate with
the same existing racy semantics. New pid syscalls will be added that
take an epoch argument. A current pid epoch u32 is added to
task_sched, that reset on fork() when a new process is allocated, then
a new pid is allocated, and the epoch has a prctl setter and getter.

If a syscall comes in with and the epoch passed is not current AND has
passed the pid of the process (this is not a lock, because we current
and previous epochs are always available), then it might fail with
EEPOCH, the caller then has to call a new syscall, waitpidv(pidv
*pid_t, epoch, O_NONBLOCK) providing a list of pids it has references
to in a specific epoch, and it gets back a list of which processes
have excited.

The epoch of a process is always relative to it's pid (not thread-id),
so the same epoch number can mean differn't things in differn't
places.

The process can then invalidate its own internal pids and use ptctl to
indicate it doesn't need the old epoch. Processes also get a signal if
they haven't updated and are 2 full epochs behind. Being behind should
also could against a process in kernel memory accounting. I am sure
there is much more to consider....
