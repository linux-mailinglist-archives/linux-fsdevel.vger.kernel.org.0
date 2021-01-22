Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252343004B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbhAVOA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 09:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbhAVOAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:00:25 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA15C0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 05:59:44 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h11so11116888ioh.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 05:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPc1R1eXPPahvy5WKkZ2Hgkr4nBt96NPVfPIRnNxiFo=;
        b=VpA4aV3iDli21mqMPxepOQ+Y6+HA3q6lKZJsJk2+WPFl8Y38cvlGfp8L8DKZQMyHKS
         V3FvfUVvapykEWhm07pBeFX90G/hto/W0WuYIEEhLWJjJDFkfZPb+3RvZkYvlGLQT384
         VdGDU4LjPSH7sB4svJFditXly7msScuUDE37/26bGKVKkqQ4GhoMUAVDG3ZtIItOgUbt
         N8H0sbpM5IO3t9pBxkX2XtTYYIe2kNGNfnxVwALMmIc+hEs+6F+5EU3Gxx+dOqUvLoK4
         RYCEQeTYZzPbvFg1FdlACtuKXzX7+gvdoaxhom32XCQMH96DLU+gPxf7Ja4r08hIxZut
         /ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPc1R1eXPPahvy5WKkZ2Hgkr4nBt96NPVfPIRnNxiFo=;
        b=Vfh7nSiyZuBVx7ARtbpLzbBpthMdU1sb/IJM1PGKp7OpvXnLuoxDBRyMPlM4bMmRnv
         mbdiojmQ54PYlyuR4eNBCQq2fu01q5UGL4OTWg319BTawSzVwEAyRv3tK1apXsXRCMOX
         /vkoYnOG3p1giIU5gFGEM/53J4FCIrPVtOpBAoxZAtzKJihCu/iaHQNrhdEH/QD1IuSY
         mqmwtL6s3ntUyHqN75Xf6++zNr9Oe27Rg4p/OYJtvZQjb6Dd7isLwROTeIrbvdb4UrHR
         oNEru0dyFc/NYvVWhN/ietw4LQUdSOLrzkbbjUQPDF5KeujH+mExaiG0kNnKF3/ruLac
         5ZJQ==
X-Gm-Message-State: AOAM531kkFQ2p1ASXRd3XxRSSqJj+kTp+xPT0yU7dnm9C8r2BZY5OhAY
        41txZTBZRXLXMXLZuhtM6yAhrl3p+FfPVC6ucS8=
X-Google-Smtp-Source: ABdhPJwR3ZUwTUct5uh/rmpg25FfpXoKng1PxuxCwXQzstalLYIV680f3huBWf3l+6rX9Aoj8ZjZhcItsLdUN1+wxwU=
X-Received: by 2002:a92:5b8e:: with SMTP id c14mr4148457ilg.275.1611323984071;
 Fri, 22 Jan 2021 05:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-9-amir73il@gmail.com>
 <20200226091804.GD10728@quack2.suse.cz> <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
 <20200226143843.GT10728@quack2.suse.cz>
In-Reply-To: <20200226143843.GT10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Jan 2021 15:59:32 +0200
Message-ID: <CAOQ4uxh+Mpr-f3LY5PHNDtCoqTrey69-339DabzSkhRR4cbUYA@mail.gmail.com>
Subject: Re: fanotify_merge improvements
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > Hum, now thinking about this, maybe we could clean this up even a bit more.
> > > event->inode is currently used only by inotify and fanotify for merging
> > > purposes. Now inotify could use its 'wd' instead of inode with exactly the
> > > same results, fanotify path or fid check is at least as strong as the inode
> > > check. So only for the case of pure "inode" events, we need to store inode
> > > identifier in struct fanotify_event - and we can do that in the union with
> > > struct path and completely remove the 'inode' member from fsnotify_event.
> > > Am I missing something?
> >
> > That generally sounds good and I did notice it is strange that wd is not
> > being compared.  However, I think I was worried that comparing fid+name
> > (in following patches) would be more expensive than comparing dentry (or
> > object inode) as a "rule out first" in merge, so I preferred to keep the
> > tag/dentry/id comparison for fanotify_fid case.
>
> Yes, that could be a concern.
>
> > Given this analysis (and assuming it is correct), would you like me to
> > just go a head with the change suggested above? or anything beyond that?
>
> Let's go just with the change suggested above for now. We can work on this
> later (probably with optimizing of the fanotify merging code).
>

Hi Jan,

Recap:
- fanotify_merge is very inefficient and uses extensive CPU if queue contains
  many events, so it is rather easy for a poorly written listener to
cripple the system
- You had an idea to store in event->objectid a hash of all the compared
  fields (e.g. fid+name)
- I think you had an idea to keep a hash table of events in the queue
to find the
  merge candidates faster
- For internal uses, I carry a patch that limits the linear search for
last 128 events
  which is enough to relieve the CPU overuse in case of unattended long queues

I tried looking into implementing the hash table idea, assuming I understood you
correctly and I struggled to choose appropriate table sizes. It seemed to make
sense to use a global hash table, such as inode/dentry cache for all the groups
but that would add complexity to locking rules of queue/dequeue and
group cleanup.

A simpler solution I considered, similar to my 128 events limit patch,
is to limit
the linear search to events queued in the last X seconds.
The rationale is that event merging is not supposed to be long term at all.
If a listener fails to perform read from the queue, it is not fsnotify's job to
try and keep the queue compact. I think merging events mechanism was
mainly meant to merge short bursts of events on objects, which are quite
common and surely can happen concurrently on several objects.

My intuition is that making event->objectid into event->hash in addition
to limiting the age of events to merge would address the real life workloads.
One question if we do choose this approach is what should the age limit be?
Should it be configurable? Default to infinity and let distro cap the age or
provide a sane default by kernel while slightly changing behavior (yes please).

What are your thoughts about this?
Do you have a better idea maybe?

Thanks,
Amir.
