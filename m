Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39CD306B89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 04:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhA1DWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 22:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhA1DWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:22:05 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49ACC061573;
        Wed, 27 Jan 2021 19:21:24 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id h192so4618708oib.1;
        Wed, 27 Jan 2021 19:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7D7Kv+sjYJAWD/JXyGJ1S45dldYp/5GoVGVph94OBPk=;
        b=RzCv6WlKg0nA0ksFmTRvveWqgbbyGPwRr3X6/uxvokMAWTlDMSlVlTzIOxEnM7L6QV
         hBbZJGQSwbY8pWztHzLPOQcQ/0aA1MVU9zgNP0zYypwkfzhNoSkTyNsTpJyAGh6JlYIH
         psZImE0VwacO8QrX9KCBBVlN5ejXnFppYZcSlEjcib/0EDtir2MdMMM9MfSGspSEcEIv
         IEEHYVWAIucsXUeEMuW9h89U3nyMKcBYGQh+Slo81McoxJAgPKgWyDfU4lEOgfPl2ms3
         Ft5s3+qEkDNOxw4j8VrrDiUJWkUQW6xgOa6wOjnwWLRIS6zkmVjGoaPhaP9Ip9M0sb6T
         2aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7D7Kv+sjYJAWD/JXyGJ1S45dldYp/5GoVGVph94OBPk=;
        b=XyfID70wbN3/rIJ6pau/2fGnxKSlfgU18mbV0Kv+3SB1gQJxmjmEJbtp1IvDKPAiJf
         y4G4GI4tTzX7w3t+nxqfjwSfJs92OcLR827DvuG238muCq/KFpy4iypEHaY2TF6/mqka
         EOZ18QqYRNcKm2E7KLpVfCD3j3ILzX4gy606jjBLFwbGYahS1Z1D39+YNJ4JJp5TltvQ
         GQ6upTos0DiRY1qG+94r3rm+MFjpiIozrVnObB4YrPVd0mhQZw54OGN9s3igtiIhNO7H
         4MRPtkWfOUbk7YLB0RXVyK9imTJwZ5yCZaFp1EZKgtFSl+OwNR9+Oz891aXwU9c2ZNzT
         arqw==
X-Gm-Message-State: AOAM531IAQVpWPvWeojG46HcFiTlxYfDJ+I8+6ISMma+tNiz9pjpL4Ao
        hNjewzTw1kOaFtMxcxBaVGuilbmTqp0KEUGvZuFPDEEcxbo=
X-Google-Smtp-Source: ABdhPJx7TuyrvGnfkiFQ0BDnRyFprq7jtt3djhlO3E4V6QJan5FV176uIaPsIW/MTe/lLQDw6MpPKrmbTQZibX8ctX4=
X-Received: by 2002:aca:d5c5:: with SMTP id m188mr5488249oig.114.1611804084325;
 Wed, 27 Jan 2021 19:21:24 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
 <BYAPR04MB4965F2E2624369B34346CC5686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <YBD72wlZC323yhqZ@mit.edu>
In-Reply-To: <YBD72wlZC323yhqZ@mit.edu>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 27 Jan 2021 19:21:13 -0800
Message-ID: <CAE1WUT65q1RZjths-EoKtMLNKUX17A9vzfpUXcYtS5dxTf6AbA@mail.gmail.com>
Subject: Re: Getting a new fs in the kernel
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:36 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Jan 26, 2021 at 07:06:55PM +0000, Chaitanya Kulkarni wrote:
> > From what I've seen you can post the long patch-series as an RFC and get the
> >
> > discussion started.
> >
> > The priority should be ease of review and not the total patch-count.
>
> File systems are also complicated enough that it's useful to make the
> patches available via a git repo, and it's highly recommended that you
> are rebasing it against the latest kernel on a regular basis.

Was already setting up some local git infrastructure for this.

>
> I also strongly recommend that once you get something that mostly
> works, that you start doing regression testing of the file system.

"'Regression testing? What's that? If it compiles, it is good; if it
boots up, it is perfect."

In all seriousness, though, yeah, already been planning for stuff like that.

> Most of the major file systems in Linux use xfstests for their
> testing.

Decently familiar with xfstests, used it for some previous change
testing I had to do.

> One of the things that I've done is to package up xfstests
> as a test appliance, suitable for running under KVM or using Google
> Compute Engine, as a VM, to make it super easy for people to run
> regression tests.  (One of my original goals for packaging it up was
> to make it easy for graduate students who were creating research file
> systems to try running regression tests so they could find potential
> problems --- and understand how hard it is to make a robust,
> production-ready file system, by giving them a realtively well
> documented, turn-key system for running file system regression tests.)
>
> For more information, see:
>
>     https://thunk.org/gce-xfstests
>     https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
>     https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md
>     https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md

Thank you so much for that!

>
> The final thing I'll point out is that file system development is a
> team sport.  Industry estimates are that it takes between 50 and 200
> person-years to create a production-ready, general purpose enterprise
> file system.  For example, ZFS took seven years to develop, starting
> with a core team of 4, and growing to over 14 developers by the time
> it was announced.  And that didn't include all of the QA, release
> engineering, testers, performance engineers, to get it integrated into
> the Solaris product.  Even after it was announced, it was a good four
> years before customers trusted it for production workloads.

Wasn't expecting to do that completely solo, I get that it takes a
significant amount of people time to build something as important as a
production filesystem. Once I get some basic stuff lined out for it,
if I decide to continue, already working on getting people to help
assist with its development.

>
> If you look at the major file systems in Linux: ext4, xfs, btrfs,
> f2fs, etc., you'll find that none of them are solo endeavors, and all
> of them have multiple companies who are employing the developers who
> work on them.  Figuring out how to convince companies that there are
> good business reasons for them to support the developers of your file
> system is important, since in order to keep things going for the long
> haul, it really needs to be more than a single person's hobby.

Yeah, got that.

>
> Good luck!
>
>                                         - Ted

Thank you!

Best regards,
Amy Parker
(she/her/hers)
