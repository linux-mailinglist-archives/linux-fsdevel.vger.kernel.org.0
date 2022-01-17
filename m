Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79749118D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 23:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiAQWCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 17:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiAQWCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:02:50 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C0C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 14:02:50 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e79so821104iof.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 14:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnNveDh8HOCxmsb4VABrhLRcoryXfAT1OfLF/SpybNg=;
        b=WrXSQAXbXH4k9anOlz8sWTi6+D+YmTVX/MwpR1bdZr6CMSjXO2XesZ0aJuavi4x+Dz
         QpTyZApsLGG5bmd6H+O4PkH+FK21q4IrIUCBgY22Pk2qMLQmKAa6otF6dChwXLaXX4l8
         OGpvxgCMyFPVbFKz2CJQFV0NbWSNQeyqy1X1IoZbZIOBsKutFVZnKE8bf/Lm2n77rsyF
         eGaaQ8O/XukKdWcCo/tmOhHVyje7louhK9zMu5XqUj1SaTJhJjog7EGMQClAsGN1dX9S
         aq18vCTQl3ybEvIawu1t3G6UawziPQ6bCxkZd2XsVzGJtc1I2sjljoFIuRdAURpvFoPH
         KPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnNveDh8HOCxmsb4VABrhLRcoryXfAT1OfLF/SpybNg=;
        b=e/eBm1t1nl+DS6Ax4UEk5B8v3bHEM77K+jNbXrfPwwXk/IzpEXtD46vUxzYbIRg8Gf
         gk/1IJJZ55FRMKKsrkQ/EB+CIpAuzImHD9YAQujxL4BTu5xe75g6gu44ykU7k5TaY4oP
         mfaBn1vhzzeo7jLMs6wOVIVWgU8ipkZLvycvBuKW4Xe/HVC5gjQ0/yUIQ7hi/WDIYtEg
         lAuE9wVemZmK0btiCEFMJWkl0CLvOoCQizQtqEAds8HLwgbWRr6LKK4EORSBIbYBUEld
         XRqzOsnaJEF7VE8KFkwbU+sOxbU5XNMzn3X8RoSkuUyJJnqccWeLTygm58n+FLXVcM7U
         vdsw==
X-Gm-Message-State: AOAM530GU79UfBwVlZUa9iugB9cwFakYrYTBwXquDNdmBqIexgo9sl7Z
        tqxRfe0L27OYA6OkisqvEI5MVfeGFwd06fB+SLY=
X-Google-Smtp-Source: ABdhPJxtslB7ZGQSnZqpDRANaqUJqYPjKWFbWoKsNgmv8KR+z6JcU4b/cRIhuBXZbmtosfW1nbFpIPcqaxStmkKvoCs=
X-Received: by 2002:a02:9564:: with SMTP id y91mr10689022jah.1.1642456969904;
 Mon, 17 Jan 2022 14:02:49 -0800 (PST)
MIME-Version: 1.0
References: <YeI7duagtzCtKMbM@visor> <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
 <YeNyzoDM5hP5LtGW@visor> <CAOQ4uxhaSh4cUMENkaDJij4t2M9zMU9nCT4S8j+z+p-7h6aDnQ@mail.gmail.com>
 <YeTVx//KrRKiT67U@visor> <CAOQ4uxibWbjFJ2-0qoARuyd2WD9PEd9HZ82knB0bcy8L92TOag@mail.gmail.com>
 <20220117142107.vpfmesnocsndbpar@quack3.lan> <CAOQ4uxj2mSOLyo612GAD_XnZOdCZ9R_BC-g=Qk_iaU65_yh72Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxj2mSOLyo612GAD_XnZOdCZ9R_BC-g=Qk_iaU65_yh72Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Jan 2022 00:02:38 +0200
Message-ID: <CAOQ4uxh5h5tQXtirxfUuZT1NJXrHuqm=e7uXD5sCDWjf5n+DEQ@mail.gmail.com>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
To:     Jan Kara <jack@suse.cz>
Cc:     Ivan Delalande <colona@arista.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > One possibility I can see is: Add fsnotify primitive to create the event,
> > just not queue it in the notification queue yet (essentially we would
> > cut-short the event handling before calling fsnotify_insert_event() /
> > fsnotify_add_event()), only return it. Then another primitive would be for
> > queueing already prepared event. Then the sequence for unlink would be:
> >
> >         LIST_HEAD(event_list);
> >
> >         fsnotify_events_prepare(&event_list, ...);
> >         d_delete(dentry);
> >         fsnotify_events_report(&event_list);
> >
> > And we can optionally wrap this inside d_delete_notify() to make it easier
> > on the callers. What do you think?
> >
>
> I think it sounds like the "correct" design, but also sounds like a
> big change that
> is not so practical for backporting.
>
> Given that this is a regression that goes way back, backportability
> plays a role.
> Also, a big change like this needs developer time, which I myself don't have
> at the moment.
>
> For a simpler backportable solution, instead of preparing the event
> perhaps it is enough that we ihold() the inode until after fsnotify_unlink()
> and pass it as an argument very similar to fsnotify_link().
>
> The question is how to ihold() the inode only if we are going to queue
> an IN_DELETE event? Maybe send an internal FS_PRE_DELETE
> event?
>

Actually, seeing that do_unlinkat() already iholds the inode outside
vfs_unlink()
anyway, is it so bad that vfs_unlink() will elevate refcount as well, so we can
call fsnotify_unlink() with the inode arg after d_delete()?

Thanks,
Amir.
