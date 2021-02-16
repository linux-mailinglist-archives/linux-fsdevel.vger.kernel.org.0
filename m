Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8E31CFD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 19:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBPSDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 13:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBPSDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:03:41 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323DC06174A;
        Tue, 16 Feb 2021 10:03:01 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e133so11068549iof.8;
        Tue, 16 Feb 2021 10:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHDtOQbSLkoFB1/F7DI50eRdZ8TQk/yPFJU8UQ8coog=;
        b=NDR9nL+4DB1MBMaeE8VvChT+P6FKqnwhW3kfMLV/4QLh3wQ0GWYDev+Zl0hOZeo610
         OdS7aSL/dSe044RcIhIBdO3E9InPQ+9NDSZcmJI7wTM/PG5VVFVA0NMBWjRJVDVhc8sw
         wzMvSKmElnSsGNID5PtnEHCpefBGRzyjFUxyLvBFRpZc+fYC+HLVPertBE9CX00fYbZV
         6o5RgkFN115+4QBIGrN7c5YaHBAaFA9i5N2aJ0TJgw7M8655V2902man5FhiHnuV10df
         Oht8jdY0x7JRYAHImFXXxT9XMyLWpUvz2CCWRG9SdtsU6eJJ7XjppbZZNpSCkanpYPtP
         ilog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHDtOQbSLkoFB1/F7DI50eRdZ8TQk/yPFJU8UQ8coog=;
        b=NRJQPlCpFHWMfvmIcn1oTU7q8XEjj5aQN7Yab3HRbJ7tZR+Z36thIIFnxvMPRP5D/Z
         hEcU4ZpeBpKTrNfeqo+uekB3uoW9KwQWJusWSkEhP0LOSt0P2lvRL2YdlSS1f9krkwg1
         oXyDAD6xU9lxRkkYxBa2zRBRKqafRPVwbrNE6qsayKSPmeLgOhKYJ3od7AcMQiwDkTqP
         REmmcOSFM15AZSyf/PDT042/y1Ho71sYpJe+i2iMY6TlTDl5+WLFWcSjJtChxqpOwN29
         B1gihy0F+/80l2erCMc82W0vqoUKKhAmpE57yI4TyxkaRY2YrFxfLJlR3Fd7SSU8Ms2y
         6vSw==
X-Gm-Message-State: AOAM532alwITLGPVzlpRVqp38u7SKRBLQteTM8nif7KYEwygoHc+Pprx
        oN1DfgL6AeYqxI8kJDOJpGrff+Xjg0ucsWZ9fpnx58nanxI=
X-Google-Smtp-Source: ABdhPJwjrm0vSMhYM+3MDeI5Nl1GbI0twIa7kULLE3v4ofegunybegRlF2PT0x/3rjIg1tYpsgcDHMgPkIUOESqrOzI=
X-Received: by 2002:a05:6638:3491:: with SMTP id t17mr21239119jal.81.1613498580576;
 Tue, 16 Feb 2021 10:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20210124184204.899729-1-amir73il@gmail.com> <20210124184204.899729-2-amir73il@gmail.com>
 <20210216162754.GF21108@quack2.suse.cz>
In-Reply-To: <20210216162754.GF21108@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Feb 2021 20:02:49 +0200
Message-ID: <CAOQ4uxh8S-sdqtYjJ1naLwokA8M-dVcZJ1Xf4eUCv21Ug2e-BA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] fanotify: configurable limits via sysfs
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 6:27 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
>
> I'm sorry that I've got to this only now.
>
> On Sun 24-01-21 20:42:03, Amir Goldstein wrote:
> > fanotify has some hardcoded limits. The only APIs to escape those limits
> > are FAN_UNLIMITED_QUEUE and FAN_UNLIMITED_MARKS.
> >
> > Allow finer grained tuning of the system limits via sysfs tunables under
> > /proc/sys/fs/fanotify/, similar to tunables under /proc/sys/fs/inotify,
> > with some minor differences.
> >
> > - max_queued_events - global system tunable for group queue size limit.
> >   Like the inotify tunable with the same name, it defaults to 16384 and
> >   applies on initialization of a new group.
> >
> > - max_listener_marks - global system tunable of marks limit per group.
> >   Defaults to 8192. inotify has no per group marks limit.
> >
> > - max_user_marks - user ns tunable for marks limit per user.
> >   Like the inotify tunable named max_user_watches, it defaults to 1048576
> >   and is accounted for every containing user ns.
> >
> > - max_user_listeners - user ns tunable for number of listeners per user.
> >   Like the inotify tunable named max_user_instances, it defaults to 128
> >   and is accounted for every containing user ns.
>
> I think term 'group' is used in the manpages even more and in the code as
> well. 'listener' more generally tends to refer to the application listening
> to the events. So I'd rather call the limits 'max_group_marks' and
> 'max_user_groups'.

ok.

>
> > The slightly different tunable names are derived from the "listener" and
> > "mark" terminology used in the fanotify man pages.
> >
> > max_listener_marks was kept for compatibility with legacy fanotify
> > behavior. Given that inotify max_user_instances was increased from 8192
> > to 1048576 in kernel v5.10, we may want to consider changing also the
> > default for max_listener_marks or remove it completely, leaving only the
> > per user marks limit.
>
> Yes, probably I'd just drop 'max_group_marks' completely and leave just
> per-user marks limit. You can always tune it in init_user_ns if you wish.
> Can't you?

Yes, I suppose.

>
> Also as a small style nit, please try to stay within 80 columns. Otherwise
> the patch looks OK to me.
>

Ever since discussions that led to:
bdc48fa11e46 checkpatch/coding-style: deprecate 80-column warning

I've tuned my editor to warn on 100 columns.
I still try to refrain from long lines, but breaking a ~82 columns line
in an ugly way is something that I try to avoid.

I'll try harder to stay below 80 when it does not create ugly code,
unless you absolutely want the patches to fit in 80 columns.

Thanks,
Amir.
