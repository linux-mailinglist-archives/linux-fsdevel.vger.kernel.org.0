Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F481EB022
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 22:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgFAUUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgFAUUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:20:17 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BDCC061A0E;
        Mon,  1 Jun 2020 13:20:17 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id r2so10668161ila.4;
        Mon, 01 Jun 2020 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsCFZJ3NUkSLSlf4w4peWdicWUek2V5RP0t7UTESXRI=;
        b=MxFJjgOu+A2HZ41czv5LB6aXf1QdBJmLasWqPmQwb+ycJb9l1yVaRteqLovYfQT83t
         XFIPJbwvUU5327QeyjHwHjjlO56naU9dvbodPPaXj0l9TooVk7UqhiRKXnH3+hU0tvIi
         KkSBBXsSUN3HDA7rH4z56mCSnhR4rKAGFNd9h3o1Rb2nkMv6v9p8ZORFZr4g/8Sc84hN
         KiPt6vVtXBwF9Tg81dccLLpTWl9vkHQbParT3C8bvgo1PQzGPgpvK/uHQza6FjRosEvw
         rAsl7z7o7n+FA7kvBlnPSNr7AQeLlbrzFAUCwI/7dYTWlNbu+LApDQrtnoEw2TNLHBg+
         jChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsCFZJ3NUkSLSlf4w4peWdicWUek2V5RP0t7UTESXRI=;
        b=LKzjbi3TUBBZ+W4FSaSShd+b9OUlHoUfrs2kBmpgrFrb44+w6Nf0YMJTxJEnSFMVC0
         ET5EWsNvhlnWx9XiqWUz51DYDWnDHC1kIewPBdJ2TcB52Wqqlo1JhEjP+uMLt1LCguTX
         BltJn0EWdgUzZ5ejK9otYHC5cNowj9ELBLhCSfpk9ktWyFMZL7zc1jDX4B7NYaKh5lLa
         lLzqJBhdRW1/eL3YxLMW84Rap0PVHU4j1mKpt1gbkn0WOtfhRhWkCgOloB/ZKCERK/2B
         17nbXToD3cFuRa4HvXiFOhN+5CTBlME3u0PS2rWCam10IgCsDw1amkkdlic6ruOR6XYY
         kJRg==
X-Gm-Message-State: AOAM533pVjrUELmKb72Zt4qjiaPn0G3edSdjcwb/7VQLesMwagN0V79u
        RsjW2sC1dq+PKQuACPmf8q0veZapy1nAyYQf/pc=
X-Google-Smtp-Source: ABdhPJwIvV9jsEZmzpcCqlzSrIf5y8KhVN7oPkC7aWIz6XJ8i8gQKcVYTwntrTeAaG+VVF9eBKzwPU/GldRj1IGRR6c=
X-Received: by 2002:a92:4015:: with SMTP id n21mr23490983ila.137.1591042817034;
 Mon, 01 Jun 2020 13:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200527172143.GB14550@quack2.suse.cz> <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
 <20200528125651.GA12279@nautica> <1590777699518.49838@cea.fr>
 <CAOQ4uxgpugScXRLT6jJAAZf_ET+DpmEWoqkSdqCAMEwp+Kezhw@mail.gmail.com>
 <20200530133908.GA5969@nautica> <CAOQ4uxiE9R4gRGwQQETvWK7SLm4J60SvfrSAOZxYJdRHquAwtA@mail.gmail.com>
 <1591040775412.28640@cea.fr>
In-Reply-To: <1591040775412.28640@cea.fr>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 1 Jun 2020 23:20:05 +0300
Message-ID: <CAOQ4uxjdPVWnK8807XzPv_DLa6zqyeMzX6Ezm1r_680DziXxYw@mail.gmail.com>
Subject: Re: robinhood, fanotify name info events and lustre changelog
To:     "Quentin.BOUGET@cea.fr" <Quentin.BOUGET@cea.fr>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "robinhood-devel@lists.sf.net" <robinhood-devel@lists.sf.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > With fanotify FAN_CREATE event, for example, the parent fid + name
> > > > information should be used by the rbh adapter code to call
> > > > name_to_handle_at(2) and get the created object's file handle.
> > > >
> > > > The reason we made this API choice is because fanotify events should
> > > > not be perceived as a sequence of changes that can be followed to
> > > > describe the current state of the filesystem.
> > > > fanotify events should be perceived as a "poll" on the namespace.
> > > > Whenever notified of a change, application should read the current state
> > > > for the filesystem. fanotify events provide "just enough" information, so
> > > > reading the current state of the filesystem is not too expensive.
>
> I am a little worried about objects that would move around constantly and thus
> "evade" name_to_handle_at(). A bad actor could try to hide a setuid binary this
> way... Of course they could also just copy/delete the file repeatedly and in
> this case having the fid becomes useless, but it seems harder to do, and it is
> likely it would take more time than a simple rename.
>

I am not following. This threat model sounds bogus, but I am not a security
expert, and fanotify async events shouldn't have anything to do with security.

If you can write a concrete use case and explain how your application
wants to handle it and why it cannot without the missing object fid information
I get give a serious answer.

> > > > When fanotify event FAN_MODIFY reports a change of file size,
> > > > along with parent fid + name, that do not match the parent/name robinhood
> > > > knows about (i.e. because the event is received out of order with rename),
> > > > you may use that information to create rbh_fsevent_ns_xattr event to
> > > > update the path or you may wait for the FAN_MOVE_SELF event that
> > > > should arrive later.
> > > > Up to you.
>
> This is making me think: if I receive such a FAN_MODIFY event, and an object
> is moved at parent_fid + name before I query the FS, how can I know which file
> the event was originally meant for?
>

FAN_MODIFY/FAN_ACCESS/FAN_ATTRIB events do have the object_fid in
addition to parent_fid + name.
FAN_CREATE/FAN_DELETE/FAN_MOVE do NOT have the object_fid,
FAN_DELETE_SELF/FAN_MOVE_SELF do have the object_fid
FAN_DELETE_SELF does NOT have parent_fid + name
FAN_MOVE_SELF does have parent_fid + name (new parent/name)

Is there anything missing in your opnion for robinhood to be able to
perform any of its missions?

Thanks,
Amir.
