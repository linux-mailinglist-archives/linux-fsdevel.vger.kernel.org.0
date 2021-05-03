Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50637180D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhECPc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhECPcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 11:32:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C9C06174A;
        Mon,  3 May 2021 08:32:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id di13so6778619edb.2;
        Mon, 03 May 2021 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPcEDUZw/0IvzQ4PQFMuC9nBNxrolPJ1cEZaVKiLsgE=;
        b=QD/N0Ems2ZYkE7+IbtXCF133Wq6v0BVEvRNXIWSQKyOimtxrEjAYEcWPUjU49Bio84
         7PW22Ak9Ht6KsewK2bF4tKGEexZXvzZiiIHasKgkRc3dskbtvAIm/4AAym2ZtqnhYjHd
         Jmnt5vrDPnb7saQrVq2PJe/sfh+xzizldTzWacmfdZsePjWYdZUoI36NQ/RWdkywb4Gg
         MDZo5teDRIwqpGguR2U4XwCQ26fd7l2FMhtWzXoqoHBs+0o3JQbIoEGwtQ6YvFdQf7qd
         QIYG5CXrpVHaqI0eC4v27ZKDVCGjyb1G0YmOEQ/y4oR0lh65oVHnYxxfV4n9HXLp3xDb
         281g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPcEDUZw/0IvzQ4PQFMuC9nBNxrolPJ1cEZaVKiLsgE=;
        b=W90v2j53db5Ds28N/ih4H3Ikf7eNCUsxPMw1HWV9Na+80YWNTkeiy3ip7f6NP+MoXR
         Cqt9DeSfPXzuhf5j//1XDHf3BngaVpd/ffWr8B2FRJQqqDwhiA2Ip8bn95QbqokNx2Oz
         6aYcxCTfj+bl8Dc0PBM4e/TFjpicsxSpCLsiSMQ1RhN+dfA7VVT58c/eCIy9mqZ4IGla
         vtR9GOkr7xR4qiwix40i7KUevadyxt2CbHDz9ICfS+fEwEGteg2ddG4apzSdkxxdz8P9
         W5CXSG9+A3kKtR5ijiB+LsURhNjxh+4vr3QPBC+mlNJ9PJbtipCeuZis8GKoC6loCFb2
         8mMQ==
X-Gm-Message-State: AOAM5301tyEEcNEdyD8Pn+kNNXEOuxhKUcYQ3Mpk6YPQPuc0S1L8rhuA
        5m2fggTlvQztDlRk/u++2jGaHjmqYwMZbVwSsXU=
X-Google-Smtp-Source: ABdhPJwORV0gSzoAPl77pyjWHRSUJhVsvJCZcOtggUgU6tzWxCutEFow5L38IewIgX7qSErD/1UC9isvjWqjzzTMWA0=
X-Received: by 2002:aa7:dd4d:: with SMTP id o13mr20933813edw.53.1620055920665;
 Mon, 03 May 2021 08:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk> <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
 <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk> <CAFt=ROOi+bi_N4NEkDQxagNwnoqM0zYR+sxiag7r2poNVW9u+w@mail.gmail.com>
 <YIb4xIU6x5BLe0wd@zeniv-ca.linux.org.uk>
In-Reply-To: <YIb4xIU6x5BLe0wd@zeniv-ca.linux.org.uk>
From:   haosdent <haosdent@gmail.com>
Date:   Mon, 3 May 2021 23:31:48 +0800
Message-ID: <CAFt=ROOnU-rVoLoP=bgR3Y3WpJmhTerAQZqFd-v=eZ306Vrobg@mail.gmail.com>
Subject: Re: NULL pointer dereference when access /proc/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Alexander, thanks a lot for your detailed explanations. I take a
look at the code again and the thread and I realize there are some
incorrect representations in my previous word.

>>   struct inode *d_inode = 0x0         <======= d_inode is NULL and cause Oops!

Actually it is Oops at `inode->i_flags` directly instead of `d_inode`,
so the code would not further to change the access time.

```
bool __atime_needs_update(const struct path *path, struct inode *inode,
  bool rcu)
{
struct vfsmount *mnt = path->mnt;
struct timespec now;

if (inode->i_flags & S_NOATIME)    <======= Oops at here according to
`[19521409.372016] IP: __atime_needs_update+0x5/0x190`.
return false;
```

But it looks impossible if we take a look at "walk_component > lookup_fast".

Let me introduce why it goes through "walk_component > lookup_fast"
instead of "walk_component > lookup_slow" first,

in "walk_component > step_into > pick_link", the code would set
`nameidata->stack->seq` to `seq` which is comes from the passed in
parameters.
If the code goes through "walk_component > lookup_slow", `seq` would
be 0 and then `nameidata->stack->seq` would be 0.
If the code goes through "walk_component > lookup_slow", `seq` would
be `dentry->d_seq->sequence`.
According to the contents in attachment files "nameidata.txt" and
"dentry.txt", `dentry->d_seq->sequence` is 4, and
`nameidata->stack->seq` is 4 as well.
So looks like the code goes through "walk_component > lookup_fast" and
"walk_component > step_into > pick_link".

The `inode` parameter in `__atime_needs_update` comes from
`nameidata->link_inode`. But in attachment file "nameidata.txt", we
could found `nameidata->link_inode` is NULL already.
Because the code goes through "walk_component > lookup_fast" and
"walk_component > step_into > pick_link", the `inode` assign to
`nameidata->link_inode` must comes from `lookup_fast`.

So it looks like something wrong in `lookup_fast`. Let me continue to
explain why this looks impossible.

In `walk_component`, `lookup_fast` have to return 1 (> 0), otherwise
it would fallback to `lookup_slow`.

```
err = lookup_fast(nd, &path, &inode, &seq);
if (unlikely(err <= 0)) {
  if (err < 0)
    return err;
  path.dentry = lookup_slow(&nd->last, nd->path.dentry,
        nd->flags);
}

return step_into
```

Because for our case, it looks like the code goes through
"walk_component > lookup_fast" and "walk_component > step_into >
pick_link",
This infers `lookup_fast` return 1 in this Oops.

Because `lookup_fast` return 1, it looks like the code goes through
the following path.

```
  if (nd->flags & LOOKUP_RCU) {
    ...

    *inode = d_backing_inode(dentry);
    negative = d_is_negative(dentry);

    ...
      ...
      if (negative)
        return -ENOENT;
      path->mnt = mnt;
      path->dentry = dentry;
      if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
        return 1;
```

As we see, if `*inode` is NULL, it should return `-ENOENT` because `if
(negative)` would be true, which is conflict with "`lookup_fast`
return 1".

And in `__d_clear_type_and_inode`, it always sets the dentry to
negative first and then sets d_inode to NULL.

```
static inline void __d_clear_type_and_inode(struct dentry *dentry)
{`
  unsigned flags = READ_ONCE(dentry->d_flags);

  flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);   // Set dentry to
negative first.
  WRITE_ONCE(dentry->d_flags, flags);
      // memory barrier
  dentry->d_inode = NULL;
               // Then set d_inode to NULL.
}
```

So looks like `inode` in `lookup_fast` should not be NULL if it could
skip `if (negative)` check even in the RCU case. Unless

```
# in lookup_fast method
  *inode = d_backing_inode(dentry);
  negative = d_is_negative(dentry);
```

is reorder to

```
# in lookup_fast method
  negative = d_is_negative(dentry);
  *inode = d_backing_inode(dentry);
```

when CPU executing the code. But is this possible in RCU?

I diff my local ubuntu's code with upstream tag v4.15.18, it looks
like no different in `fs/namei.c`, `fs/dcache.c`, `fs/proc`.
So possible the problem may happen to upstream tag v4.15.18 as well,
sadly my script still could not reproduce the issue on the server so
far,
would like to see if any insights from you then I could continue to
check what's wrong in this Oops, thank you in advance!

On Tue, Apr 27, 2021 at 1:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Apr 27, 2021 at 01:16:44AM +0800, haosdent wrote:
> > > really should not assume ->d_inode stable
> >
> > Hi, Alexander, sorry to disturb you again. Today I try to check what
> > `dentry->d_inode` and `nd->link_inode` looks like when `dentry` is
> > already been killed in `__dentry_kill`.
> >
> > ```
> > nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> > dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> > nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> > dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> > nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> > dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> > ```
> >
> > It looks like `dentry->d_inode` could be NULL while `nd->link_inode`
> > is always has value.
> > But this make me confuse, by right `nd->link_inode` is get from
> > `dentry->d_inode`, right?
>
> It's sampled from there, yes.  And in RCU mode there's nothing to
> prevent a previously positive dentry from getting negative and/or
> killed.  ->link_inode (used to - it's gone these days) go with
> ->seq, which had been sampled from dentry->d_seq before fetching
> ->d_inode and then verified to have ->d_seq remain unchanged.
> That gives you "dentry used to have this inode at the time it
> had this d_seq", and that's what gets used to validate the sucker
> when we switch to non-RCU mode (look at legitimize_links()).
>
> IOW, we know that
>         * at some point during the pathwalk that sucker had this inode
>         * the inode won't get freed until we drop out of RCU mode
>         * if we need to go to non-RCU (and thus grab dentry references)
> while we still need that inode, we will verify that nothing has happened
> to that link (same ->d_seq, so it still refers to the same inode) and
> grab dentry reference, making sure it won't go away or become negative
> under us.  Or we'll fail (in case something _has_ happened to dentry)
> and repeat the entire thing in non-RCU mode.



-- 
Best Regards,
Haosdent Huang
