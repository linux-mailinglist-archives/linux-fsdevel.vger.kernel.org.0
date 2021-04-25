Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6E36A8CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhDYSQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhDYSQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:16:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8500EC061574;
        Sun, 25 Apr 2021 11:15:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ja3so5154953ejc.9;
        Sun, 25 Apr 2021 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/ZtSBDvqTlG56qptq7qwAgMe8JoTOcZRN0BpM31Y6Q=;
        b=EHdMCZHHaGasg4SfOoxLwM9k24VLi/DajXoJH3DJacWrmFpGK1n20uze8m5xXuz4qJ
         wCtvgwwLEwZg3aaKzDue6me8AiCojRKfUNbKT6rALXKBPGgEni4LBVz0L8698DoxWiD2
         daYWMSU7pDuDypncA71Zltq7ZRZHSaa/IQq5v4PN7YRUaNnN7NFRHzNKE5xPEcxT0sXs
         Kr3EBsLeBG6lGmqjtWuM6wfz1IuJCFLKgCsdiFlxTLfizWIQK0Tn9P8pOmMwFD/whjtE
         VURZpMT/EpLcOdQQgWeH1iNeLbKHOC7/NMJCx+9q9hlcu7/J6Md1xKiUYzOGeca8KxT9
         4Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/ZtSBDvqTlG56qptq7qwAgMe8JoTOcZRN0BpM31Y6Q=;
        b=XfTewP3PrQG5bBK/USpeBZKYeLw5qOn1QBGxV6twf5Nzm0GDPmkk17PcYmLsxFHj23
         DDvXVzTX88vWPnU0Py7914lKtCX2R9V0REbSMXcNKAdQcHPlq6r6eO2CbC8h8Pt3GX35
         WVWePuzJXP67aeLGriIiJJbhILNTQu5PgGA9Tu2ucpQHSyeU6FwLf4Kcka8xo0+fdTAG
         NAwuaA+yr/6kOEFn/HfyonBUAqwfBX9BamPZgb4Vz78hd6ynUJnbkpGnsECq1jVxSXuF
         8p8hTlhOaF2XBlFxl/zVPuwkP5xZU2thzSzOopskvAYJPTFgo0F+T5Wrb2XuyW8L6oPp
         AXqA==
X-Gm-Message-State: AOAM532Uu1NUBDS3Z+hIbp99WzphMo4dVY8trIIw5hHxkE41A2EkKXd/
        1JRfK2R0nw9CllPVZOT05oMDovc0//WufhimJPBPWjtcjb7fRQ==
X-Google-Smtp-Source: ABdhPJw10TCE534B8I5UX7zjBr5VS6kO6hjL4hJHk2mAAq0UjE7nEP6Kr+BYyFbO7ztXJ/hHR3FeQIjLJab45n2kxUM=
X-Received: by 2002:a17:906:1c8f:: with SMTP id g15mr14445082ejh.20.1619374549025;
 Sun, 25 Apr 2021 11:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk> <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
 <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk> <CAFt=ROMhLo6AO98BHS4dW2rhXjhCzWqkiLFgYMPc3Q8+KHh1JQ@mail.gmail.com>
In-Reply-To: <CAFt=ROMhLo6AO98BHS4dW2rhXjhCzWqkiLFgYMPc3Q8+KHh1JQ@mail.gmail.com>
From:   haosdent <haosdent@gmail.com>
Date:   Mon, 26 Apr 2021 02:15:37 +0800
Message-ID: <CAFt=RON1gRRmsZmaeGLEvGoDyJeDksTappF2v8MGQ3rcpi809A@mail.gmail.com>
Subject: Re: NULL pointer dereference when access /proc/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> in RCU mode we really, really should not assume ->d_inode stable.

Got it, but looks like the ->d_inode is NULL after out of RCU.

In `lookup_fast` and `walk_component`

```
  dentry = __d_lookup_rcu(parent, &nd->last, &seq);
  ...
  *inode = d_backing_inode(dentry);
```

```
static int walk_component(struct nameidata *nd, int flags)
  ...
  err = lookup_fast(nd, &path, &inode, &seq);
  if (unlikely(err <= 0)) {
    ...
    path.dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
    ...
    seq = 0; /* we are already out of RCU mode */
    inode = d_backing_inode(path.dentry);
  }
```

On Mon, Apr 26, 2021 at 2:00 AM haosdent <haosdent@gmail.com> wrote:
>
> > In the kernels of 4.8..4.18 period there it used to do
> > so, but only in non-RCU mode (which is the reason for explicit rcu argument passed
> > through that callchain).
>
> Yep, we saw the `inode` parameter pass to `__atime_needs_update` is already NULL
>
> ```
> bool __atime_needs_update(const struct path *path, struct inode *inode,
>   bool rcu)
> {
> struct vfsmount *mnt = path->mnt;
> struct timespec now;
>
> if (inode->i_flags & S_NOATIME)   <=== Oops at here because the params
> inode is NULL
> return false;
> ```
>
> ```
>     [exception RIP: __atime_needs_update+5]
>     ...  **RSI: 0000000000000000**  <=== the second params of
> __atime_needs_update "struct inode *inode" is NULL
> ```
>
> On Mon, Apr 26, 2021 at 1:22 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, Apr 26, 2021 at 01:04:46AM +0800, haosdent wrote:
> > > Hi, Alexander, thanks a lot for your quick reply.
> > >
> > > > Not really - the crucial part is ->d_count == -128, i.e. it's already past
> > > > __dentry_kill().
> > >
> > > Thanks a lot for your information, we would check this.
> > >
> > > > Which tree is that?
> > > > If you have some patches applied on top of that...
> > >
> > > We use Ubuntu Linux Kernel "4.15.0-42.45~16.04.1" from launchpad directly
> > > without any modification,  the mapping Linux Kernel should be
> > > "4.15.18" according
> > > to https://people.canonical.com/~kernel/info/kernel-version-map.html
> >
> > Umm...  OK, I don't have it Ubuntu source at hand, but the thing to look into
> > would be
> >         * nd->flags contains LOOKUP_RCU
> >         * in the mainline from that period (i.e. back when __atime_needs_update()
> > used to exist) we had atime_needs_update_rcu() called in get_link() under those
> > conditions, with
> > static inline bool atime_needs_update_rcu(const struct path *path,
> >                                           struct inode *inode)
> > {
> >         return __atime_needs_update(path, inode, true);
> > }
> > and __atime_needs_update() passing its last argument (rcu:true in this case) to
> > relatime_need_update() in
> >         if (!relatime_need_update(path, inode, now, rcu))
> > relatime_need_update() hitting
> >         update_ovl_inode_times(path->dentry, inode, rcu);
> > and update_ovl_inode_times() starting with
> >         if (rcu || likely(!(dentry->d_flags & DCACHE_OP_REAL)))
> >                 return;
> > with subsequent accesses to ->d_inode.  Those obviously are *NOT* supposed
> > to be reached in rcu mode, due to that check.
> >
> > Your oops looks like something similar to that call chain had been involved and
> > somehow had managed to get through to those ->d_inode uses.
> >
> > Again, in RCU mode we really, really should not assume ->d_inode stable.  That's
> > why atime_needs_update() gets inode as a separate argument and does *NOT* look
> > at path->dentry at all.  In the kernels of 4.8..4.18 period there it used to do
> > so, but only in non-RCU mode (which is the reason for explicit rcu argument passed
> > through that callchain).
>
>
>
> --
> Best Regards,
> Haosdent Huang



-- 
Best Regards,
Haosdent Huang
