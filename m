Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC243F9722
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbhH0JhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 05:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhH0JhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:37:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD1C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 02:36:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b7so7689531iob.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyjTZIXcTKNZrNpynfNpSNcPP3/p0TIc5oH3wFyAZHI=;
        b=mRcdy/6zEmYUfL4Py+VejVjXgWfWkonuO06KK1puC9jEbl9hcW35EFgixAn3vLUtHk
         kuylyf7lsPR6tuIQj4NZ22hu9RmAKFlm0TyXdQGehIhvqctHECy35mKgMnSthSnI0iKP
         ufQzS4IhMPTpBzRqHikkq129neGyUYJ9Bn7Gu/imwLRgzzFF8vZWW6IxgwF5JEW6nYvT
         PMIC5EEKsM04Fmq18ag4mrUpMfkqnrX/vXO+E2Yf67kTuVSbT/tjfzd6EYVjXnR5X0aV
         rUZbU6Ytuo7ZN3fBFzZPDqtC/5Ei3thYNYLaSSiaCFfcfEepShkd3Yglw8ydGDJbuIEw
         kh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyjTZIXcTKNZrNpynfNpSNcPP3/p0TIc5oH3wFyAZHI=;
        b=DO1yIwl+zFwVEECJQG/UJBC/20oyqEFN7pWRlB9XQba47HAC3AO7h7LGJ0VuuiL0on
         sO9+w2q6enh1NmJ+qcHy+pTRYgyBmtXAH4zuNyaxkPrSJTBFeooF1Z5uiFHU/b5l1s5T
         KkYoJhX7ExZC3aCQtUnw61ZdNHQkRUUiSBLR8Bl2IlT9VA/pKkRqsZMKfbvoPIXGWfGi
         LYnRRtCLr5PQ59xi0H21lCfdamAXvCGrpy27y5hsQzKUM0yTJu4PT9/fTNuE+z1bqoeJ
         s9IpY44d8iYrZNRjHhCgN/YLfd9xHodZJEl/Sg7JF1fUYE47LQA9HruCrPaWno2yrTAJ
         akPw==
X-Gm-Message-State: AOAM5303qNspv/VUMYxIeM7FSp87MX8Ty+823L3o8c7nLlkCG9J+Xg83
        0lXj+gblltGV5NOZPj5/wXMO5+Nd8UAiJhvqU7KTlaxBZNs=
X-Google-Smtp-Source: ABdhPJy2A7xkn17XChdugSCmtykKVIFAnETIBLBBAKeCeZQK1CSu0jKr/UJxwdWrpnMnOSxtbLiAPEM2Vb/hcQxQAmQ=
X-Received: by 2002:a6b:8b54:: with SMTP id n81mr6686283iod.5.1630056994285;
 Fri, 27 Aug 2021 02:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-10-krisman@collabora.com> <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
 <87tujdz7u7.fsf@collabora.com> <CAOQ4uxhj=UuvT5ZonFD2sgufqWrF9m4XJ19koQ5390GUZ32g7g@mail.gmail.com>
 <87mtp5yz0q.fsf@collabora.com> <CAOQ4uxjnb0JmKVpMuEfa_NgHmLRchLz_3=9t2nepdS4QXJ=QVg@mail.gmail.com>
 <CAHC9VhT9SE6+kLYBh2d7CW5N6RCr=_ryK+ncGvqYJ51B7_egPA@mail.gmail.com>
In-Reply-To: <CAHC9VhT9SE6+kLYBh2d7CW5N6RCr=_ryK+ncGvqYJ51B7_egPA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Aug 2021 12:36:23 +0300
Message-ID: <CAOQ4uxgDdNsSHj4T8Ugr1_WTZgDpGcVMnNMqVVNFnVWvYcX4eQ@mail.gmail.com>
Subject: audit watch and kernfs
To:     Paul Moore <paul@paul-moore.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Fork new thread from:
https://lore.kernel.org/linux-fsdevel/CAHC9VhT9SE6+kLYBh2d7CW5N6RCr=_ryK+ncGvqYJ51B7_egPA@mail.gmail.com/
and shrink CC list]

> > > >> Hi Amir,
> > > >>
> > > >> I think this is actually necessary.  I could identify at least one event
> > > >> (FS_CREATE | FS_ISDIR) where fsnotify is invoked with a NULL data field.
> > > >> In that case, fsnotify_dirent is called with a negative dentry from
> > > >> vfs_mkdir().  I'm not sure why exactly the dentry is negative after the
> > > >
> > > > That doesn't sound right at all.
> > > > Are you sure about this?
> > > > Which filesystem was this mkdir called on?
> > >
> > > You should be able to reproduce it on top of mainline if you pick only this
> > > patch and do the change you suggested:
> > >
> > >  -       sb = inode->i_sb;
> > >  +       sb = fsnotify_data_sb(data, data_type);
> > >
> > > And then boot a Debian stable with systemd.  The notification happens on
> > > the cgroup pseudo-filesystem (/sys/fs/cgroup), which is being monitored
> > > by systemd itself.  The event that arrives with a NULL data is telling the
> > > directory /sys/fs/cgroup/*/ about the creation of directory
> > > `init.scope`.
> > >
> > > The change above triggers the following null dereference of struct
> > > super_block, since data is NULL.
> > >
> > > I will keep looking but you might be able to answer it immediately...
> >
> > Yes, I see what is going on.
> >
> > cgroupfs is a sort of kernfs and kernfs_iop_mkdir() does not instantiate
> > the negative dentry. Instead, kernfs_dop_revalidate() always invalidates
> > negative dentries to force re-lookup to find the inode.
> >
> > Documentation/filesystems/vfs.rst says on create() and friends:
> > "...you will probably call d_instantiate() with the dentry and the
> >   newly created inode..."
> >
> > So this behavior seems legit.
> > Meaning that we have made a wrong assumption in fsnotify_create()
> > and fsnotify_mkdir().
> > Please note the comment above fsnotify_link() which anticipates
> > negative dentries.
> >
> > I've audited the fsnotify backends and it seems that the
> > WARN_ON(!inode) in kernel/audit_* is the only immediate implication
> > of negative dentry with FS_CREATE.
> > I am the one who added these WARN_ON(), so I will remove them.
> > I think that missing inode in an FS_CREATE event really breaks
> > audit on kernfs, but not sure if that is a valid use case (Paul?).
>
> While it is tempting to ignore kernfs from an audit filesystem watch
> perspective, I can see admins potentially wanting to watch
> kernfs/cgroupfs/other-config-pseudofs to detect who is potentially
> playing with the system config.  Arguably the most important config
> changes would already be audited if they were security relevant, but I
> could also see an admin wanting to watch for *any* changes so it's
> probably best not to rule out a kernfs based watch right now.
>
> I'm sure I'm missing some details, but from what I gather from the
> portion of the thread that I'm seeing, it looks like the audit issue
> lies in audit_mark_handle_event() and audit_watch_handle_event().  In
> both cases it looks like the functions are at least safe with a NULL
> inode pointer, even with the WARN_ON() removed; the problem being that

Correct. They are safe.

> the mark and watch will not be updated with the device and inode
> number which means the audit filters based on those marks/watches will
> not trigger.  Is that about right or did I read the thread and code a
> bit too quickly?
>

That is also my understanding of the code although I must admit
I did not try to test this setup.

> Working under the assumption that the above is close enough to
> correct, that is a bit of a problem as it means audit can't
> effectively watch kernfs based filesystems, although it sounds like it
> wasn't really working properly to begin with, yes?  Before I start

Correct. It seems it was always like that (I did not check history of kernfs)
but do note that users can set audit rules on specific kernfs directories or
files, it's only recursive rules on subtree may not work as expected

> thinking too hard about this, does anyone already have a great idea to
> fix this that they want to share?
>

One idea I had, it may not be a great idea, but I'll share it anyway :)

Introduce an event FS_INSTANTIATE that will only be exposed to
internal kernel fsnotify backends. It triggers when an inode is linked
into the dentry cache as a result of lookup() or mkdir() or whatever.

So for example, in case of audit watch on kernfs,
audit_watch_handle_event() will miss the FS_CREATE event, but
on the first user access to the new created directory, audit will get
the FS_INSTANTIATE event with child inode and be able to setup
the recursive watch rule.

I did not check if it is possible or easy to d_instantiate() in kernfs
mkdir() etc like other filesystems do and I do not know if it would be
possible to enforce that as a strict vfs API rather than a recommendation.

Thanks,
Amir.
