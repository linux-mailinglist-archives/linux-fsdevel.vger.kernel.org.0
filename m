Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C072DB531
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 21:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgLOUcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 15:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgLOUVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:21:24 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110FC06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 12:20:44 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id q205so12029472oig.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 12:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cctYVRDBvS7gnFdNMIYJVdkb8x7AF/SwJBlmVDDyCYk=;
        b=cG0sQKUePn5k7aBXprnMtjUhgWTI62Pe7UHw/zIlAPxIQF8CdBeDUc+kWVw1uEmxrp
         nt/Mf6lmzqPPneA5f9T/IvFq50L32zvCJtGIu0+lySsoIbydIJUIm5JqDUwPtlh8wvwJ
         qFLBILp4QS5owF/wYwSpWgEK1a3dB7Kw7lbnFV5LLSu/0tP2/DRUh+wOWoJzxKGTw+0c
         JF6fTJxilb868jW5eKByzmX4MhYZnt06ya79TX/1gCHWi3HlsniqM+LZtGadDp6+Fo5Y
         gg6j3iGI20bmEC/fcSFLip5F1NZSJtRFSu/1DN2TxE06zRrR8d0Rn64n3Mi7peUwaJM/
         X9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cctYVRDBvS7gnFdNMIYJVdkb8x7AF/SwJBlmVDDyCYk=;
        b=NG2U5UQ67qGgSZVzncHOITDISZ3Z9YzzTXr7289pXRbvsATaQzzEBx9vynLsfISzVK
         sppRwIi4/h8r8YnSk8BmW6mBNLGplqZsXXDNMOQ8yCWjbq0aFN65LWDvsTosbXa/l52B
         46exGdr0eepMeyGec94gpn+P+TUa19H8ukr/bZNc+nPheHNQ91uPw7tpqiCl2A8AEfV5
         SsuNqXSRx1q2FY0GIrhavK5qz+gXwJNqb8dAyvD1GCmXt3A7HHNxVu5bPcTCCvPyIY3Q
         x008qUokdNVu+0wLWtQ1jhPVNjClqbNol8ugm+JR6LGRNTsOy3Wqt8UBJ2uFstntVN14
         npIA==
X-Gm-Message-State: AOAM533hX87cfc7ndLN+Nl4WuonajXKRb/AJMjBHpbFp749U0jkhIdxL
        UCZHip/etYl9WAY0N7ikbqbuoQl4qTv+u5bC++8HRwFHWOzUMLuc
X-Google-Smtp-Source: ABdhPJxhr1wP1fBdicsk1DqIMds7hvlQbEZkufoyYLdqHll79Mr3HnsYwm3O4OouD6BQp08lkedR8r7d50Auyk+oO34=
X-Received: by 2002:aca:4f47:: with SMTP id d68mr385593oib.135.1608063643849;
 Tue, 15 Dec 2020 12:20:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOg9mSSCsPPYpHGAWVHoY5bO8DozzFNWXTi39XBc+GhDmWcRTA@mail.gmail.com>
 <20201214030552.GI3913616@dread.disaster.area> <20201214040703.GJ2443@casper.infradead.org>
In-Reply-To: <20201214040703.GJ2443@casper.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 15 Dec 2020 15:20:32 -0500
Message-ID: <CAOg9mST-DqAp5ijqc8aX-5TH_cZrd7Wt5fLDZR0chUUpuyxMaw@mail.gmail.com>
Subject: Re: "do_copy_range:: Invalid argument"
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey! Y'all are awesome! I added this simple patch
and all the tests that failed work now.  I added
.splice_read too, don't know if I should have...

I'll run all the xfstests (so far I just ran the
handful of regressions so I could see that they
were passing) and if that goes well, I'll refresh
the orangefs linux-next tree. If that goes well, hopefully
Linus will accept this during the 5.11 merge window.

Thanks again!

-Mike

[root@vm1 linux]# git diff
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index af375e049aae..7417af40d33e 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -663,6 +663,8 @@ const struct file_operations orangefs_file_operations = {
        .unlocked_ioctl = orangefs_ioctl,
        .mmap           = orangefs_file_mmap,
        .open           = generic_file_open,
+        .splice_read    = generic_file_splice_read,
+        .splice_write   = iter_file_splice_write,
        .flush          = orangefs_flush,
        .release        = orangefs_file_release,
        .fsync          = orangefs_fsync,
[root@vm1 linux]#

On Sun, Dec 13, 2020 at 11:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Dec 14, 2020 at 02:05:52PM +1100, Dave Chinner wrote:
> > On Fri, Dec 11, 2020 at 11:26:28AM -0500, Mike Marshall wrote:
> > > Greetings everyone...
> > >
> > > Omnibond has sent me off doing some testing chores lately.
> > > I made no Orangefs patches for 5.9 or 5.10 and none were sent,
> > > but I thought I should at least run through xfstests.
> > >
> > > There are tests that fail on 5.10-rc6 that didn't fail
> > > on 5.8-rc7, and I've done enough looking to see that the
> > > failure reasons all seem related.
> > >
> > > I will, of course, keep looking to try and understand these
> > > failures. Bisection might lead me somewhere. In case the
> > > notes I've taken so far trigger any of y'all to give me
> > > any (constructive :-) ) suggestions, I've included them below.
> > >
> > > -Mike
> > >
> > > ---------------------------------------------------------------------
> > >
> > > generic/075
> > >   58rc7: ? (check.log says it ran, results file missing)
> > >   510rc6: failed, "do_copy_range:: Invalid argument"
> > >           read the tests/generic/075 commit message for "detect
> > >           preallocation support for fsx tests"
> > >
> > > generic/091
> > >   58rc7: passed, but skipped fallocate parts "filesystem does not support"
> > >   510rc6: failed, "do_copy_range:: Invalid argument"
> > >
> > > generic/112
> > >   58rc7: ? (check.log says it ran, results file missing)
> > >   510rc6: failed, "do_copy_range:: Invalid argument"
> > >
> > > generic/127
> > >   58rc7: ? (check.log says it ran, results file missing)
> > >   510rc6: failed, "do_copy_range:: Invalid argument"
> > >
> > > generic/249
> > >   58rc7: passed
> > >   510rc6: failed, "sendfile: Invalid argument"
> > >           man 2 sendfile -> "SEE ALSO copy_file_range(2)"
> >
> > If sendfile() failed, then it's likely a splice related regression,
> > not a copy_file_range() problem. The VFS CFR implementation falls
> > back to splice if the fs doesn't provide a clone or copy offload
> > method.
> >
> > THere's only been a handful of changes to fs/splice.c since 5.8rc7,
> > so it might be worth doing a quick check reverting them first...
>
> I'd suggest applying the equivalent of
> https://lore.kernel.org/linux-fsdevel/1606837496-21717-1-git-send-email-asmadeus@codewreck.org/
> would be the first step.
