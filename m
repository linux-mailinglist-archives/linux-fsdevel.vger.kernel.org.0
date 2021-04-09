Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B340F359FB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhDINXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDINXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:23:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C81C061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 06:23:10 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id t14so4705986ilu.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDf/2qm9m/31W87MfzXqoLoZJ7hRfFXLjuoc9mRhEzo=;
        b=jsEVfpqp9HFUwzoRIYuf+f92KSY5Yt60pK2qwFPDetA2dV96cr0dte9xXCb2/bRQqn
         sV0hCtpnHBNoQkqdehllsbUXBwj6PfG73nLU68aBOFMyafZ90hCilIQ/HvyjKX3ruvi8
         3FI3548uoUttwj8seCJD7cUrO87xCfCn+MyEXSlIPa/+ny5Wmd8xhfPPqzaVOJs0aJEU
         SswRphZuwFUhsuRdqqjwd6C0LSkkB6CUCK3eBbl7ieurA8/XaCBchdy/TwZmlfyt//rm
         slwZKyfcNEUpG5OhFg5laYGhh5efcCPviDOCG+jf+TaQfwFZn5J2qTxpDcR85Kb97BTu
         RFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDf/2qm9m/31W87MfzXqoLoZJ7hRfFXLjuoc9mRhEzo=;
        b=sJyepPKgs7uJnhwDiik6LZ4BW7l2jk2c+pLR/hMDNf+5B8VXtwTAuQJBhZL0nnzu7V
         hwx6eZw0ZfhATEZYd+TDIsTq/pdGK+k4M6qv40mIX9kPu7WGGua+LLU0JEZ7v9XHR1GR
         2eXDD0NPuYEwu6EfSSOzhBsXnDprX1V1vcdUzsOxkYiR8BbpgAopBDX7aGBZzfuTpGhT
         /9MWipafDvP8dVLlccW2ZmNLk3DYyVRpFvxjLs7WcGjgECMvLmg4uAGfWNhN9giO8LAt
         oQ5NA3i9bRCiyZiajs2BxmW/TZfD0e3zKziHXontdS9HO3qFohT4CjJJRf/WPTum7RQw
         WY8A==
X-Gm-Message-State: AOAM532gYl4n0x/1MuRe/Ilhv8/s6kFMpl2RyqBXnYqXGMxc6a6z2GPa
        Qwr3ZAwPP3NiifnIlOQjkaXToop0MZwEjIrGJrs=
X-Google-Smtp-Source: ABdhPJw2UmlyHXtQKl8rdN443XbIoWxLwmmht1e6LBrDKwkmf2+1v41BRlrLvsU2YNIR7S1p+KUNiPx4brJchrxeuFc=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr11088338ile.72.1617974589891;
 Fri, 09 Apr 2021 06:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz>
In-Reply-To: <20210409100811.GA20833@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Apr 2021 16:22:58 +0300
Message-ID: <CAOQ4uxi5Njbp-yd_ohNbuxdbeLsYDYaqooYeTp+LpaSnxs2r4A@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 9, 2021 at 1:08 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 08-04-21 18:11:31, Amir Goldstein wrote:
> > > > FYI, I tried your suggested approach above for fsnotify_xattr(),
> > > > but I think I prefer to use an explicit flavor fsnotify_xattr_mnt()
> > > > and a wrapper fsnotify_xattr().
> > > > Pushed WIP to fsnotify_path_hooks branch. It also contains
> > > > some unstashed "fix" patches to tidy up the previous hooks.
> > >
> > > What's in fsnotify_path_hooks branch looks good to me wrt xattr hooks.
> > > I somewhat dislike about e.g. the fsnotify_create() approach you took is
> > > that there are separate hooks fsnotify_create() and fsnotify_create_path()
> > > which expose what is IMO an internal fsnotify detail of what are different
> > > event types. I'd say it is more natural (from VFS POV) to have just a
> > > single hook and fill in as much information as available... Also from
> >
> > So to be clear, you do NOT want additional wrappers like this and
> > you prefer to have the NULL mnt argument explicit in all callers?
> >
> > static inline void fsnotify_xattr(struct dentry *dentry)
> > {
> >         fsnotify_xattr_mnt(NULL, dentry);
> > }
> >
> > For fsnotify_xattr() it does not matter so much, but fsnotify_create/mkdir()
> > have quite a few callers in special filesystems.
>
> Yes, I prefer explicit NULL mnt argument to make it obvious we are going to
> miss something in this case. I agree it's going to be somewhat bigger churn
> but it isn't that bad (10 + 6 callers).
>

I don't mind the churn so much, but for clarity of what we are missing, I'd
prefer to use fsnotify_inode_create() vs. fsnotify_path_create(), which is
exactly the difference between the two flavors - the type or args passed.
BTW, there is a precedence to that convention with security_{inode,path}
hooks, but in that case, both hooks are called.

> > > outside view, it is ctunclear that e.g. vfs_create() will generate some types
> > > of fsnotify events but not all while e.g. do_mknodat() will generate all
> > > fsnotify events. That's why I'm not sure whether a helper like vfs_create()
> > > in your tree is the right abstraction since generating one type of fsnotify
> > > event while not generating another type should be a very conscious decision
> > > of the implementor - basically if you have no other option.
> >
> > I lost you here.
>
> Sorry, I was probably too philosophical here ;)
>
> > Are you ok with vfs_create() vs. vfs_create_nonotify()?
>
> I'm OK with vfs_create_nonotify(). I have a problem with vfs_create()
> because it generates inode + fs events but does not generate mount events
> which is just strange (although I appreciate the technical reason behind
> it :).
>
> > How do you propose to change fsnotify hooks in vfs_create()?
>
> So either pass 'mnt' to vfs_create() - as we discussed, this may be
> actually acceptable these days due to idmapped mounts work - and generate
> all events there, or make vfs_create() not generate any fsnotify events and
> create new vfs_create_notify() which will take the 'mnt' and generate
> events. Either is fine with me and more consistent than what you currently
> propose. Thoughts?
>

I'm good with vfs_create_notify(). This definitely forces me to submit the
s/notify_change/vfs_setattr_notify conversion ;-)
I will take a swing at it.

But we are actually going in cycles around the solution that we all want,
but fear of rejection. It's time to try and solicit direct feedback from Al.

Al,

would you be ok with passing mnt arg to vfs_create() and friends,
so that we can pass that to fsnotify_create() (and friends) in order to
be able to report FAN_CREATE events to FAN_MARK_MOUNT listeners?

The watched mount context is relevant to syscalls/io_uring and nfsd
and less relevant to callers using private mount clones like overlayfs,
but it doesn't hurt to pass the private mount.

Thanks,
Amir.
