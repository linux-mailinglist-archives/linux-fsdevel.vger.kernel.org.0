Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4463792A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhEJP17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhEJP0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 11:26:07 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CDBC04BF02
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 08:08:42 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c3so14355207ils.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoyLcPzwjLsUbYzLl0oH6mo0hjLaQ6U9BFye59BcKJI=;
        b=RdWIKp1pvqbwp1K2WXhqPPmXDbnc56uNWxoBIPPskyh2HeHPGa5QwcdgqDE/EHbCYN
         FI6jm6F/vVuWWOpQvJerD8j0EZYjj6fVYsO6hYNA5J66atJxaEY3+apoglTUQdeGdwU7
         yLhzcOqYATRFxneKFjuxrfiho6ytXyNm1kC3dTpdTbU9uOpUk0KqSIBbusLHM6xphdUk
         K9UizacsETLXjLkivmySV2PqNCV6lBFlM2Bzyjmu5Zrl75N7hNWrtBZ6thlzI7piTmRt
         npphNkn9aImLjSwQDLL3YH8X+Ann6oWhpmnfT1ytmYRTmjSPq+kaxCBFvT6VdRWRY6gV
         NBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoyLcPzwjLsUbYzLl0oH6mo0hjLaQ6U9BFye59BcKJI=;
        b=fb1KdcozTATvEWPd4oo4ykCDCj1Ssyv69s6YlOj/wFKtzxSR9TDaZLOP9dIVA6m/2f
         bZQ/sztomf5AGFvhN0EfyYI5ARfGA4dJWrVz7vdgi9vZYWgEZbz/b+dsvixRuVN7PbOF
         ed01gAHW5YbV8zPZEqWpeu3dFEfUpOfM6N+5OnXcMSTmBbU5Tav9W8N2bEyYWbNMNeM8
         qthq3ptYMqCp53jYAqFJkT6yZWOlhv5+Vln+QBzHPuNrTFcsAHlcxrSbxWwYkXLeqE8b
         LM9B06ea9vTvJ/ZFSK2jP68ZhFn4/g24yob8AzB9fTbWZpWQjNeLC0ED4E1893kngZgT
         gDhA==
X-Gm-Message-State: AOAM530Ejy1OpOnxl9/fTg+FbEDHMbIxw3xmEetNdm03XSzz/oC/PmqZ
        ZRoFAl0/y+asT1GMvfJ4XvI4pKB7hMQDuVwkUmvindTYxVI=
X-Google-Smtp-Source: ABdhPJyMLGYo26TCvgmh8PWBnZpP0HfNP28PcSB4WAv1AICwR0m9wT/5N6anz1n0ug2z1/8FDqwK9Fi2s32emRqhlII=
X-Received: by 2002:a92:b74a:: with SMTP id c10mr21439797ilm.72.1620659322211;
 Mon, 10 May 2021 08:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201125110156.GB16944@quack2.suse.cz> <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz> <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz> <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz> <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz> <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210510142107.GA24154@quack2.suse.cz>
In-Reply-To: <20210510142107.GA24154@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 May 2021 18:08:31 +0300
Message-ID: <CAOQ4uxhKk3oJdWF8YxYRPyomimg9xQaHnMo3ggALOhTuwWxYBw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > OK, so this feature would effectively allow sb-wide watching of events that
> > > are generated from within the container (or its descendants). That sounds
> > > useful. Just one question: If there's some part of a filesystem, that is
> > > accesible by multiple containers (and thus multiple namespaces), or if
> > > there's some change done to the filesystem say by container management SW,
> > > then event for this change won't be visible inside the container (despite
> > > that the fs change itself will be visible).
> >
> > That is correct.
> > FYI, a privileged user can already mount an overlayfs in order to indirectly
> > open and write to a file.
> >
> > Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> > hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> > Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> >
> > I wonder if that is a problem that we need to fix...
>
> I assume you are speaking of the filesystem that is absorbing the changes?
> AFAIU usually you are not supposed to access that filesystem alone but
> always access it only through overlayfs and in that case you won't see the
> problem?
>

Yes I am talking about the "backend" store for overlayfs.
Normally, that would be a subtree where changes are not expected
except through overlayfs and indeed it is documented that:
"If the underlying filesystem is changed, the behavior of the overlay
 is undefined, though it will not result in a crash or deadlock."
Not reporting events falls well under "undefined".

But that is not the problem.
The problem is that if user A is watching a directory D for changes, then
an adversary user B which has read/write access to D can:
- Clone a userns wherein user B id is 0
- Mount a private overlayfs instance using D as upperdir
- Open file in D indirectly via private overlayfs and edit it

So it does not require any special privileges to circumvent generating
events. Unless I am missing something.

Thanks,
Amir.
