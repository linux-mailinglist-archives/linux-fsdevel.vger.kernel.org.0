Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA0365394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhDTHyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhDTHyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:54:39 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E01C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 00:54:08 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b10so37563396iot.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 00:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtTy8qt+vxQI8g880AUpBUyHK9BDK2ONR8pJop/yPp0=;
        b=Wu/YJ/c/pNucLYwHZFL8EI86QQ1/hU+EF6NUSszI8gKgMf41vWuwSVl7cKV0V9AakS
         NEAUobwGbPvbxloK0INdHw1j/YqW5P/kZPPdUIGuUCfshoBNoJHsYsQaul1CT9c5v2vg
         XUxS1gVg3WNSNLnWZRHPZHOwPublDLbuEHdDaMV98Io75DZeO714POMULccOi894Sd/m
         uUuj6aK4AM+On0/zSfu8TJ50+tr79tsEGC3NWJt53EwJ5CTB6WWqzsMHfVKGbFY5jeqS
         WjW8X/vRjUIcBBQCdn1lC2h6/2VWK/ehyll4BGsQfLFjthjRcIkZaijtU3+beTybdKAJ
         duxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtTy8qt+vxQI8g880AUpBUyHK9BDK2ONR8pJop/yPp0=;
        b=FmliphCIF72fCjhJTz28bu2QKMRaRxgIMHaqKrPZpQdN0nUbYjWijmlKlljJ+7qfRr
         ZP/xC9SMvt/ogNw1RHNzKU63ItQ8t0KkokwSoXbDm1WlDj+D4+soAit7wOAfhxb1BSas
         YkdR/POHjUTgeBUzKZAM7EI93bHS50g9QUt3xGryfVdhxsgiID2krYxV2gK/MiEY0AhX
         3pQHaRZhaNbo0rT4A5UJm1KZcCwcZoRoLCcfOlTnEqIwj24TLCklMKHu0gJdGnwVgZiP
         QCM1hC/P4mHDUeSgCkvYpXrqW3uFLSJYjhVWO5Jo+9lhpVWcqifSswzFV/UKlAnT2gbt
         ifoQ==
X-Gm-Message-State: AOAM530EB3ygQH1fu4ooDcTVN3ljhL3V9ZtrcC7t5amhrr5v1q4eXMJq
        IVBJf6FeEVyemuIcSk5BRr9cZ1sgKF3n2cLWJFU=
X-Google-Smtp-Source: ABdhPJy9vK00V3cb4Q0I9QzuwhH9Hyf4gCQfPbXu3Hov2D471fAW4Zcx8l+4TYS35vb7qs+cg7uIqpCk0q63R0cuoZI=
X-Received: by 2002:a02:331b:: with SMTP id c27mr7856453jae.30.1618905248253;
 Tue, 20 Apr 2021 00:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <CAOQ4uxi3c2xg9eiL41xv51JoGKn0E2KZuK07na0uSNCxU54OMQ@mail.gmail.com>
 <YH23mMawq2nZeBhk@zeniv-ca.linux.org.uk> <CAOQ4uxhXXLwUBr01zuU=Uo9rzEg4JQ2w_zEejdRRU8FSJsJg0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhXXLwUBr01zuU=Uo9rzEg4JQ2w_zEejdRRU8FSJsJg0w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Apr 2021 10:53:57 +0300
Message-ID: <CAOQ4uxiWb5Auyrbrj44hvdMcvMhx1YPRrR90RkicntmyfF+Ugw@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I really want to see details on all callers - which mount are
> > you going to use in each case.
>
> The callers are:
> cachefiles, ecryptfs, nfsd, devtmpfs,
> do_truncate(), vfs_utimes() and file_remove_privs()
>
> * cachefiles, ecryptfs, nfsd compose paths from stashed
> mount like this all the time (e.g. for vfs_truncate(), vf_getattr()).
>
> * devtmpfs has the parent path from and also uses it to
> compose child path for vfs_getattr().
>
> * vfs_utimes() and all callers of do_truncate() already have the
> path, just need to pass it through to notify_change()
>

Not sure how I forgot to mention chmod and chown, but obviously
there is no problem with path from those callers.

> >
> >         The thing that is not going to be acceptable is
> > a combination of mount from one filesystem and dentry from
> > another.  In particular, file_remove_privs() is going to be
> > interesting.
> >
> >         Note, BTW, that ftruncate() and file_remove_privs()
> > are different in that respect - the latter hits d_real()
> > (by way of file_dentry()), the former does not.  Which one
> > is correct and if both are, why are their needs different?
>
> Nowadays (>= v4.19) I think the only files whose file_inode() and
> f_path do not agree are the overlayfs "real.file" that can find their
> way to f_mapping and to some vfs helpers and from there to
> filesystem ops and to file_modified() or generic_file_write_iter()
> and to file_remove_privs().
>
> Contrary to that, overlayfs does not call any vfs truncate()
> helper, it calls notify_change() directly (with a composed path).
>
> So what should we do about file_remove_privs()?
> Since I don't think we really need to care about generating an
> event on file_remove_privs(), perhaps it could call __notify_change()
> that does not generate an event

I found more instances of notify_change() in overlayfs copy_up code
that IMO should also use __notify_change() and not report fsnotify
events for restoring attributes on files post copy up.

Like with the case of file_remove_privs(), it is enough IMO that the
listener is able to get an event on the modification event that caused
copy up or remove_privs, no need for an event on the subsystem
internal implementation details.

> and the rest of the callers call this wrapper:
>
> int notify_change(struct path *path, struct iattr *attr,
>                             struct inode **delegated_inode)
> {
>         unsigned int ia_valid;
>         int error = __notify_change(mnt_user_ns(path->mnt), path->dentry,
>                                                     attr, &ia_valid,

Braino here. There is no need to pass ia_valid to helper.
I failed to notice that notify_change updates attr->ia_valid.

Which brings me to the fun question - naming.

Would you like me to follow up on Jan's suggestion to rename:
s/__notify_change/vfs_setattr
s/notify_change/vfs_setattr_notify

I pushed this version (a.k.a. "tollerabe") to:
https://github.com/amir73il/linux/commits/fsnotify_path_hooks

It's only sanity tested.

Thanks,
Amir.
