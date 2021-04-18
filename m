Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1D363734
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Apr 2021 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhDRSvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Apr 2021 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRSvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Apr 2021 14:51:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79C8C06174A
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Apr 2021 11:51:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so31730031wrr.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Apr 2021 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DiuY4BPfqayruvDgjQyjSOKqlblrpUw1lFfd+6FKw58=;
        b=qtVKPNVx2Laoj39PUA0YE3xJTwgN46o+Dt/1H5e955VmUdzdoQfhyiPTCQtioUhj7O
         NFoiszLhXOdKeAWmh8nsu5XKylb1QOs0XTWDtH4UoMPwN6GEr/vMPThH8Z/P0Y3EBwfs
         F+SAaZo6+WoL8JZVbkVE8zo61MFKwGCTJ9uKJWJ48eekgdy4zyTHgugWbP8CO9B0Jkv/
         3ulsqlqwgq0yM8bxBJcK8OWUiGnUo/f2px8Sx41vupCEhNoyGOTzme1jTjzzsG/7KUft
         r2R3NVWAl5JND32dUf+nsTFL/f4/gZMgSV/GTlM4l6q3Jb1ff4Ekh6BLbu45m/rwmPiX
         /1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiuY4BPfqayruvDgjQyjSOKqlblrpUw1lFfd+6FKw58=;
        b=s6QdRVefOjxkXLLKcB+HjQxG2fuWKP7gpRE4mztHSr/KY/xB+Oi4aN2F0foIoyECvn
         nVnB/JF0zlTZs3mRIY46oyqioqR1BPTOOdbrqxn0VA4Xoez39mVXaOFNHMz/+PVurDl8
         JoZMrLnFzDIvfbgGn16J9V19s8tPf1yNQQXLPLZEiH4GCkizcIv+pYe+nDt8DQ99K+Dy
         bujkMo4pahO5Nzam6i6OK6JLUTi7XLTF6NWfNtKDgpkcYpCCYUhaqxAlDRZDkNZL9yWt
         jN4K0qjbszI8i/ecBaR9qBZnmrbx26zD5XB0SfWDGN9lVwpAlFCn3wQBncvSQwb81pOk
         xJjQ==
X-Gm-Message-State: AOAM530Ib37mmMaXNWuTfp/sFfsIOxORRWYHeWzLLUHo83acLt3ofiT7
        SQPeO5qnIW1CimSJOkjhqcj4oJ3b1Q8abXVBkvqjJhpE5L0=
X-Google-Smtp-Source: ABdhPJz5gJUpKc8cOKbb7BjjsfCEDALHA5ZvAaJer1e4TFkKXwyD4hipG0mLnnRRfX+JS7fi17RIZQYl4zL19LkaWZQ=
X-Received: by 2002:adf:ebcc:: with SMTP id v12mr10501655wrn.389.1618771879275;
 Sun, 18 Apr 2021 11:51:19 -0700 (PDT)
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
Date:   Sun, 18 Apr 2021 21:51:08 +0300
Message-ID: <CAOQ4uxhhGsMzZOYnmw5xuz0jXPUtq0Li9hm9+bUiVTmeRxmUug@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
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
> > > outside view, it is unclear that e.g. vfs_create() will generate some types
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

Jan,

I started to go down the vfs_create_notify() path and I guess it's looking
not too bad (?). Pushed WIP to branch fsnotify_path_hooks-wip.

I hit another bump though.  By getting fsnotify_{unlink,rmdir}() outside of the
vfs helpers, we break the rule:

        /* Expected to be called before d_delete() */
        WARN_ON_ONCE(d_is_negative(dentry));

I'm not sure how to solve this without passing mnt into the vfs helpers.

One solution is not adding support for delete events to mount mark.
I was trying to aim for maximum flexibility, but for the use case that
Christian mentioned (injecting bind mounts into container) it is only
really necessary to support FAN_CREATE and FAN_MOVED_TO
(or FAN_MOVE_SELF) on a mount mark for observing when a path
becomes positive.

For observing when a path becomes negative, it is sufficient to watch
all the ancestor directories.

Thoughts?

Thanks,
Amir.
