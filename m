Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD8427FFC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbgJANJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 09:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgJANJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:09:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F2FC0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 06:09:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y74so6509200iof.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+V12OpifAjwflHllCdg7vx4objKgtEAuTSWnb1JoBMA=;
        b=Vz2J6h0m6bBsKhWLqX9RpFJpUJQNumabxhWr8xXFw83dfkB8X8UjQL4OpkUysgrGvY
         pfiOzSVSOady2dJsaaf0NQcRS1C671sWHjLXbti4FkzIb6OjPI+a3wY7FGofHxtes5fz
         Ibtpjl4UoZ0XYuVgyxkp5aQEiWAFFIRlz2xbz//O3s1aOIRXVnwuYXOSiM1OZPw7BxsQ
         lAKQqe48zVKOEQZ7W34Xx4khim7CMOuhmoy/khdrjfJMol4qdFshyRUt52bbQe4AehQn
         5p/4xteh+C++LZLZWq3Yktg6xRIXyKd/lwG2RfwHmaQYKTSb0ptt5WW6+2kWsNGDmhzl
         GWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+V12OpifAjwflHllCdg7vx4objKgtEAuTSWnb1JoBMA=;
        b=V6QAa2WT7FXc1NacSqOno9mUE4S7wbSMvgeKHIFKOw/VPzfkAxbm2Y3jOs3NTTeA7B
         G7gE0eeJP/jwEK93Gr9e3JiMOpTbBp7mwVmb+/pSaBJzE/EY2dRtCr8HwIWxEzNnBZfo
         XcMxnVTL2UJn2OWYnChg9IoXUeRGfhEdbD3ve+DdixdLCA0Ov14qPsbzJTRLmky8zpch
         HUdyPexpDDQroLIQp9Sk3+QJhijsqF3hEL/BKZks6SxPu7jAxAxLMRtg82cWtdAcmP2v
         imY3dk1xffs6J8g7K0zSqdhK7q/YjP4hnwSRfNJKqEUZPgVQZQ2ARfLnliYqucsm3d7O
         KPQw==
X-Gm-Message-State: AOAM531jbnx4JGrgla6jfvK4Qru3haJmtPjXYFPw4oPXR9dZ33hPQJEY
        pg9RgiypG63CRY1BDRml7Gw2ubM07lX2OVveqeE=
X-Google-Smtp-Source: ABdhPJzDpCBNokFm8h3jt504it8hfJJ+joc2GGT9heAnkY0Kg3NuZ+mOzKNV8wtFeFGS3yUoMr4quorCO1xeto5riSI=
X-Received: by 2002:a6b:5a0d:: with SMTP id o13mr5308813iob.186.1601557741783;
 Thu, 01 Oct 2020 06:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200914172737.GA5011@192.168.3.9> <20200915070841.GF4863@quack2.suse.cz>
 <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com> <20201001110058.GG17860@quack2.suse.cz>
In-Reply-To: <20201001110058.GG17860@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Oct 2020 16:08:50 +0300
Message-ID: <CAOQ4uxh3cgzEZJhYVMqtVB5kig1O57WaUkxPnxnpQHm5TGjmfg@mail.gmail.com>
Subject: Re: FAN_UNPRIVILEGED
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 1, 2020 at 2:00 PM Jan Kara <jack@suse.cz> wrote:
>
> I'm sorry for late reply on this one...
>
> On Tue 15-09-20 11:33:41, Amir Goldstein wrote:
> > On Tue, Sep 15, 2020 at 10:08 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> > > > Now the IN_OPEN event can report all open events for a file, but it can
> > > > not distinguish if the file was opened for execute or read/write.
> > > > This patch add a new event IN_OPEN_EXEC to support that. If user only
> > > > want to monitor a file was opened for execute, they can pass a more
> > > > precise event IN_OPEN_EXEC to inotify_add_watch.
> > > >
> > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > >
> > > Thanks for the patch but what I'm missing is a justification for it. Is
> > > there any application that cannot use fanotify that needs to distinguish
> > > IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
> > > specialized purposes (e.g. audit) which are generally priviledged and need
> > > to use fanotify anyway so I don't see this as an interesting feature for
> > > inotify...
> >
> > That would be my queue to re- bring up FAN_UNPRIVILEGED [1].
> > Last time this was discussed [2], FAN_UNPRIVILEGED did not have
> > feature parity with inotify, but now it mostly does, short of (AFAIK):
> > 1. Rename cookie (*)
> > 2. System tunables for limits
> >
> > The question is - should I pursue it?
>
> So I think that at this point some form less priviledged fanotify use
> starts to make sense. So let's discuss how it would look like... What comes
> to my mind:
>
> 1) We'd need to make max_user_instances, max_user_watches, and
> max_queued_events configurable similarly as for inotify. The first two
> using ucounts so that the configuration is actually per-namespace as for
> inotify.
>
> 2) I don't quite like the FAN_UNPRIVILEDGED flag. I'd rather see the checks
> being done based on functionality requested in fanotify_init() /
> fanotify_mark(). E.g. FAN_UNLIMITED_QUEUE or permission events will require
> CAP_SYS_ADMIN, mount/sb marks will require CAP_DAC_READ_SEARCH, etc.
> We should also consider which capability checks should be system-global and
> which can be just user-namespace ones...

OK. That is not a problem to do.
But FAN_UNPRIVILEDGED flag also impacts:

    An unprivileged event listener does not get an open file descriptor in
    the event nor the process pid of another process.

Obviously, I can check CAP_SYS_ADMIN on fanotify_init() and set the
FAN_UNPRIVILEDGED flag as an internal flag.

The advantage of explicit FAN_UNPRIVILEDGED flag is that a privileged process
can create an unprivileged listener and pass the fd to another process.
Not a critical functionality at this point.

Thoughts?

Thanks,
Amir.
