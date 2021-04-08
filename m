Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA33587ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhDHPLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 11:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhDHPLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:11:54 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD1C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 08:11:43 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id 7so410503ilz.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZiEEGT3Nd9lXn1GHF4FkUvN50hzMvi/SSkiRWa15sUk=;
        b=BnrZaq4p5l/XL7/9ZGwekgRL2TuNLSUB9lS0U8AzF/esYhgyODkreldCIhat/xsjpk
         2c8iHLv1UVmhn4trx6eWFK5DLJuNt2wW80abk44HEIpFGO3EehbxhUxEsvh1MNaQn9Lk
         Gkt8U1gsTvGHvSPVwlZXsHD3gSbV1e1h/SqCO+3eSTtF+q825mo80PjeNm6IjuQiPRZb
         Fe4AVLeVdX7Tj+X4/FrlD9CTLN94fDUl+8KOnWW30TeAU7TyB3ybMFX0+3O2DvnA1XhI
         h1T9WtDnU2ThQYrNWUFpfU8za+TKlgnSrlsmpOFQozXEtyAvbCayuK4HEzXIX8LhFzWP
         +jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiEEGT3Nd9lXn1GHF4FkUvN50hzMvi/SSkiRWa15sUk=;
        b=iRRL0wBESgkz4QvMz8SEbuWzm3jUWSieGBwrTIavHSUdCI3dd6d8k95g7wOVikWCTN
         fdR8yRuO6s8vOtquzIq7vAUXYepMN7WlhZaa3LkcA4/xRpiei9jPP2CLDS5gnkqPe3RP
         HN4R8jmmZo1cAoTfW5yQr0FlNCEYFccDH6rfXzpMDLBuFMqXE+Si8svHeRpS5NIum5wf
         q0uo2iBlzdfOG+yWp0diXcjrtiFGH4pegecfsmq3yjB2KG7qUxO02FAMt45LFjeZOnir
         8re2rpJ52BfQA8QtaQGdz+q7Wptp9PDBogZkbdAvxZVl5Y+JLAbxZLtIsgMIfZE+yM4F
         8UbA==
X-Gm-Message-State: AOAM531XDy243wIxHbufV4rATQQ8VDKoWWUSpz2jq7bp4xaQIzEemKum
        bJ1I5+LKQo6sQkw1nh1oj/0gXUw3OKUTJYCzrCk=
X-Google-Smtp-Source: ABdhPJwsp/Qov3Nmgs7pIX2LM4mIL4oxT6P2Me2Hc3pBGFctgb8vkuLMsLtj3OwiAL3CXmisCKcldx/4mf8eqLAXSi4=
X-Received: by 2002:a92:d44c:: with SMTP id r12mr7420040ilm.275.1617894702655;
 Thu, 08 Apr 2021 08:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com> <20210408125258.GB3271@quack2.suse.cz>
In-Reply-To: <20210408125258.GB3271@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 8 Apr 2021 18:11:31 +0300
Message-ID: <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > FYI, I tried your suggested approach above for fsnotify_xattr(),
> > but I think I prefer to use an explicit flavor fsnotify_xattr_mnt()
> > and a wrapper fsnotify_xattr().
> > Pushed WIP to fsnotify_path_hooks branch. It also contains
> > some unstashed "fix" patches to tidy up the previous hooks.
>
> What's in fsnotify_path_hooks branch looks good to me wrt xattr hooks.
> I somewhat dislike about e.g. the fsnotify_create() approach you took is
> that there are separate hooks fsnotify_create() and fsnotify_create_path()
> which expose what is IMO an internal fsnotify detail of what are different
> event types. I'd say it is more natural (from VFS POV) to have just a
> single hook and fill in as much information as available... Also from

So to be clear, you do NOT want additional wrappers like this and
you prefer to have the NULL mnt argument explicit in all callers?

static inline void fsnotify_xattr(struct dentry *dentry)
{
        fsnotify_xattr_mnt(NULL, dentry);
}

For fsnotify_xattr() it does not matter so much, but fsnotify_create/mkdir()
have quite a few callers in special filesystems.

> outside view, it is unclear that e.g. vfs_create() will generate some types
> of fsnotify events but not all while e.g. do_mknodat() will generate all
> fsnotify events. That's why I'm not sure whether a helper like vfs_create()
> in your tree is the right abstraction since generating one type of fsnotify
> event while not generating another type should be a very conscious decision
> of the implementor - basically if you have no other option.
>

I lost you here.
Are you ok with vfs_create() vs. vfs_create_nonotify()?
How do you propose to change fsnotify hooks in vfs_create()?
Did you mean to call the same fsnotify_create() hook in both vfs_create()
and do_mknodat() where the former is called with NULL mnt argument?

> That all being said, this is just an internal API so we are free to tweak
> it in the future if we get things wrong. So I'm not pushing hard for my
> proposal but I wanted to raise my concerns. Also I think Al Viro might have
> his opinion on this so you should probably CC him when posting the series...
>

Sure, just wanted to get your initial feedback before kicking the patch set
into shape, because it could have gone in many different ways, which it did ;)

> > I ran into another hurdle with fsnotify_xattr() -
> > vfs_setxattr() is too large to duplicate a _nonotify() variant IMO.
> > OTOH, I cannot lift fsnotify_xattr() up to callers without moving
> > the fsnotify hook outside the inode lock.
> >
> > This was not a problem with the directory entry path hooks.
> > This is also not going to be a problem with fsnotify_change(),
> > because notify_change() is called with inode locked.
> >
> > Do you think that calling fsnotify_xattr() under inode lock is important?
> > Should I refactor a helper vfs_setxattr_notify() that takes a boolean
> > arg for optionally calling fsnotify_xattr()?
> > Do you have another idea how to deal with that hook?
>
> I think having the event generated outside of i_rwsem is fine. The only
> reason why I think it could possibly matter is due to reordering of events
> on the same inode but that order is uncertain anyway.
>

That's what I thought. It is not much different than ACCESS/MODIFY
events.

> > With notify_change() I have a different silly problem with using the
> > refactoring method - the name notify_change_nonotify() is unacceptable.
> > We may consider __ATTR_NONOTIFY ia_valid flag as the method to
> > use instead of refactoring in this case, just because we can and
> > because it creates less clutter.
> >
> > What do you think?
>
> Hmm, notify_change() is an inconsistent name anyway (for historical
> reasons). Consistent name would be vfs_setattr(). And
> vfs_setattr_nonotify() would be a fine name as well. What do you think?
>

I won't propose to convert all notify_change() callers before getting an
explicit ACK from Al, but I could still use notify_change() as a wrapper
around vfs_setattr_nonotify() and maybe also create an alias vfs_setattr()
and use it in some places.

Thanks,
Amir.
