Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF633F020
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 13:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCQMUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 08:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCQMUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:20:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D971C06174A;
        Wed, 17 Mar 2021 05:20:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id w11so14918816iol.13;
        Wed, 17 Mar 2021 05:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGoVRpR02OWWu1pRvJAAjd+T74J80lkkzsYt752lPyU=;
        b=GXqup1WSn05SmFLRYw2uvyY4CzdlG6TMt1HlrD/Uig5PRVOeAGrmIo3ck0pcORcSap
         QUHP83sXPL4z7Fh+eGUOh4ujUJzWq6CwTQLzsJoN0IEoPweAs1jlcHK75bc2Pn/mdbgY
         HUhZAAScr5Xjv06BaOfc327bZuJKrio+6jA25+/qZBkJxWXy62ILcakAGooSn34Pljt5
         WntGaut1OQ/E2vls1hfvTihqtHQ1o3nluCf/y+TUFurF5JaMy1k2xF7FLiAoz3xrXAHF
         xVrYrjN6lKoNfErsYOvCxXbAReW84iO2O2lyBoxwom7UPT0+5jZ08D7To47w00ZSpThE
         6R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGoVRpR02OWWu1pRvJAAjd+T74J80lkkzsYt752lPyU=;
        b=VOqj+86PLHWYIlVFH5BXHVoC1aSdjOtGoqr44GQJct3jod50r9jp84WbADxuL6aEKl
         RLK4bDf0kc062nsxQGGzEE/0K2rglWMDKdwGW8woJxfevkV0Zf5UxmvS0H05OZILHdnr
         EC2Rz5lbhJhjPieJiO5ZZRECoISHTKCnPXmgjDNceSvztZ8L+dBknb5TsFNlOF9xtXoS
         myZZ11gJr91cPNmwr8pLXAcW0cJI/2adJfOhkNhCXgAsNHHfHnKIABVsqu3MM+9yIqV2
         s45pdml/vruaBi/SvKQoFrfgA8VDvDUSK9e0KjW2vjA+vWdifxDjSA4rtWV0E5cv20Jk
         0oew==
X-Gm-Message-State: AOAM532S82+79NYy9wn6bT6vnmyMpexyPsx5Kek9GiWQp+xb0rjtqS6t
        K2Gcm6vJv7p/rON5+DxrMSNiXlHpiF7ri7zlN1ETN/OxYII=
X-Google-Smtp-Source: ABdhPJwjkO9eCfcXfIWsCSlZ/FzbQ4XThfJDAvfyzIgj/uYzEIFfvAPmdnjkYoyIvNDFaUfhKlq6ZuWJlAp7Nl6tLEc=
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr6550339iot.186.1615983609010;
 Wed, 17 Mar 2021 05:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com> <20210317114207.GB2541@quack2.suse.cz>
In-Reply-To: <20210317114207.GB2541@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Mar 2021 14:19:57 +0200
Message-ID: <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 1:42 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 17-03-21 13:01:35, Amir Goldstein wrote:
> > On Tue, Mar 16, 2021 at 5:55 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 04-03-21 13:29:19, Amir Goldstein wrote:
> > > > Jan,
> > > >
> > > > These patches try to implement a minimal set and least controversial
> > > > functionality that we can allow for unprivileged users as a starting
> > > > point.
> > > >
> > > > The patches were tested on top of v5.12-rc1 and the fanotify_merge
> > > > patches using the unprivileged listener LTP tests written by Matthew
> > > > and another LTP tests I wrote to test the sysfs tunable limits [1].
> > >
> > > Thanks. I've added both patches to my tree.
> >
> > Great!
> > I'll go post the LTP tests and work on the man page updates.
> >
> > BTW, I noticed that you pushed the aggregating for_next branch,
> > but not the fsnotify topic branch.
> >
> > Is this intentional?
>
> Not really, pushed now. Thanks for reminder.
>
> > I am asking because I am usually basing my development branches
> > off of your fsnotify branch, but I can base them on the unpushed branch.
> >
> > Heads up. I am playing with extra privileges we may be able to
> > allow an ns_capable user.
> > For example, watching a FS_USERNS_MOUNT filesystem that the user
> > itself has mounted inside userns.
> >
> > Another feature I am investigating is how to utilize the new idmapped
> > mounts to get a subtree watch functionality. This requires attaching a
> > userns to the group on fanotify_init().
> >
> > <hand waving>
> > If the group's userns are the same or below the idmapped mount userns,
> > then all the objects accessed via that idmapped mount are accessible
> > to the group's userns admin. We can use that fact to filter events very
> > early based on their mnt_userns and the group's userns, which should be
> > cheaper than any subtree permission checks.
> > <\hand waving>
>
> Yeah, I agree this should work. Just it seems to me the userbase for this
> functionality will be (at least currently) rather limited. While full

That may change when systemd home dirs feature starts to use
idmapped mounts.
Being able to watch the user's entire home directory is a big win
already.

> subtree watches would be IMO interesting to much more users.

Agreed.

I was looking into that as well, using the example of nfsd_acceptable()
to implement the subtree permission check.

The problem here is that even if unprivileged users cannot compromise
security, they can still cause significant CPU overhead either queueing
events or filtering events and that is something I haven't been able to
figure out a way to escape from.

BUT, if you allow userns admin to setup subtree watches (a.k.a filtered
filesystem marks) on a userns filesystem/idmapped mount, now users
can watch subtrees in their home directories and other processes will
pay CPU penalty only for file access in the users home directories.

That might be acceptable.

Thanks,
Amir.
