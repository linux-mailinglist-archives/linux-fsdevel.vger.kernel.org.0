Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853CA1E9398
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 22:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgE3Uhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgE3Uha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 16:37:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3903C03E969;
        Sat, 30 May 2020 13:37:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v11so5861788ilh.1;
        Sat, 30 May 2020 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MnwxkbGb0+nWao3yc/JPkhrYxvGO6ffZxMdHcMsUDIo=;
        b=aprvK01vVuPE5aPkxlctJEOBj+unAfDYH7oPTTz5mwj9VhKmI70E+4Fs5gR61dOgr2
         5fyB5n0oO8BNmhXblcl2p8SpO1yXwQt1VsRcG+OG8Zj3X0z/3RQzanpSDh3h9CC8nieK
         HXGjB+pALfHEaUv2c0HucZYgH6k1fbygmuKTx0skfOEqjwWO+mF+G9xmSjEJx/lcnvYp
         lU1jC5aOKFmdbn5wVUIl2YwGChCHvUfBV9w4pZFHFSX1sSbWS725M0oEs1Al8QARiTy2
         6QMcgeJ/k6B6K7d3yP93UHZ2BVihyIRTFWYtm5xDnI9nht+iI/prIsIOFnLZ6jnJ1xi2
         Nbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnwxkbGb0+nWao3yc/JPkhrYxvGO6ffZxMdHcMsUDIo=;
        b=czv0BVk+gKa4lv/Gs3osQCv/v3IiiX1DOeaH4dXFQKMIFgwwou42PZdvW8uUOktMRZ
         DDjQ8fnwjIOBF6XDVVpdhoF5O0Md1OFF9V2N/MoyiSCuSdY8oTmSGh4HtufqAn6gqBdX
         T1t+7rAe/tKXXNGja9+knLCccqXddU8Fa1T1YUjqtFq5Ih1L/Q918jpcpAB+AXGrhzMl
         6tZJiIhTSmTtWPFrVIRLPOSMXCLxIf1ZBYwUGNpS6+wG2Z+YhMeneXRIBuFuYY993yFh
         70qCrtUNWTTFmqfXOAczOWYQy+kI62JdhmfMmuhy1l6SI2TRm8JKn66LiHMYnB4AcRXG
         3Oog==
X-Gm-Message-State: AOAM533rHuL5XZegjKG5+BUt3glr1W2IRfvs3GcZYjR+AiAHrnuroELD
        IyuYHyPokMd/fsQEPkZkcZjrh3FTC+jj8KOk/dARckJx
X-Google-Smtp-Source: ABdhPJzftj1U0zjnc8YKnc+np6w4+GgZb27XoKfnK3mI0V8T4JsunxevC0nae/U5hcX3DMLtV7rHelJKhvkm+jhetyY=
X-Received: by 2002:a92:4015:: with SMTP id n21mr14184396ila.137.1590871047815;
 Sat, 30 May 2020 13:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200527172143.GB14550@quack2.suse.cz> <20200527173937.GA17769@nautica>
 <CAOQ4uxjQXwTo1Ug4jY1X+eBdLj80rEfJ0X3zKRi+L8L_uYSrgQ@mail.gmail.com>
 <20200528125651.GA12279@nautica> <1590777699518.49838@cea.fr>
 <CAOQ4uxgpugScXRLT6jJAAZf_ET+DpmEWoqkSdqCAMEwp+Kezhw@mail.gmail.com> <20200530133908.GA5969@nautica>
In-Reply-To: <20200530133908.GA5969@nautica>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 30 May 2020 23:37:16 +0300
Message-ID: <CAOQ4uxiE9R4gRGwQQETvWK7SLm4J60SvfrSAOZxYJdRHquAwtA@mail.gmail.com>
Subject: Re: robinhood, fanotify name info events and lustre changelog
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     "Quentin.BOUGET@cea.fr" <Quentin.BOUGET@cea.fr>,
        Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "robinhood-devel@lists.sf.net" <robinhood-devel@lists.sf.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I would be happy to work with you on a POC for adapting fanotify
> > test code with robinhood v4, but before I invest time on that, I would
> > need to know there is a good chance that people are going to test and
> > use robinhood with Linux vfs.
> >
> > Do you have actual users requesting to use robinhood with non-Lustre
> > fs?
>
> I would run it at home, but that isn't much :D
> As I wrote previously we have users for large nfs shares out of lustre,
> but I honestly don't think there will be much use for local filesystems
> at least in the short term.
>
> Filesystem indexers like tracker[1] or similar would definitely get much
> more use for that; from an objective point of view I wouldn't suggest
> you spend time on robinhood for this: local filesytems are rarely large
> enough to warrant using something like robinhood, and without something
> like fanotify we wouldn't be efficient for a local disk with hundreds of
> millions of files anyway because of the prohibitive rescan cost - so
> it's a bit like chicken and egg maybe,

I very much agree with that statement.
I have written the kernel side to facilitate a file server system with many
millions of files. We use in-house software for the user side, not very
different in concept from robinhood.
So I am looking for a similar use case out there using open source
software, and they are not easy to find.

> I don't know, but if you want
> many users to test different configurations I wouldn't recommend
> robinhood (OTOH, we run CI tests so would be happy to add that to the
> tests once it's available on vanilla kernels; but that's still not real
> users)
>
> [1] https://wiki.gnome.org/Projects/Tracker
>

The problem with Track/Watchman is that they are running as
as unprivileged services per user and fanotify requires
CAP_SYS_ADMIN (for good reasons).
Also, if they are not used for watching very large scale of directories,
there is no strong incentive to switch from inotify to fanotify.

My plan was to create a privileged system watchman service that
feeds off of fanotify and serves unprivileged watchman services.
This is not unlike MacOS fseventsd.
I never got around to asses the size of that task.

Looking at robinhood (especially v4), I seems like it could fit
very well into the vacuum in Linux and act as "fsnotifyd".
unprivileged applications and services could register to event streams
and get fed from db, so applications not running will not loose events.
Events delivered to unprivileged applications need to be filtered by
subtree those applications, something that fanotify does not do and
will not likely do and filtered by access permissions of application
to the path of the reported object.

This is not going to be an easy task, but without it, fanotify can serve
some niche use cases and not be as helpful to the wider community.

>
> > May I ask, what is the reason for embarking on the project to decouple
> > robinhood v4 API from Lustre changelog API?
> > Is it because you had other fsevent producers in mind?
>
> I've been planning to at least add some recursive-inotifywatch a
> subfolder at least (like watchman does) before these new fanotify events
> came up, so I might be partly to blame for that.
>
> There also are advantages for lustre though; the point is to be able to
> ingest changelogs directly with some daemon (it's only at proof of
> concept level for v4 at this point), but also to split the load by
> involving multiple lustre clients.
> So you would get a pool of lustre clients to read changelogs, a pool of
> lustre clients to stat files as required to enrich the fsevents (file
> size etc), and a pool of servers to read fsevents and commit changes to
> the database (this part is still at the design level afaik)
>

Sounds interesting. I hope I was able to plant enough seeds
in your mind to steer robinhood in the direction of a future "fsnotifyd" ;-)

Anyway, I will CC you with new posting of my work, so if you want
you can take it for a test drive.

Thanks,
Amir.
