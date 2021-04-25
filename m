Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC28B36A8B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhDYSBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhDYSBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:01:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0C1C061574;
        Sun, 25 Apr 2021 11:00:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cq11so19452216edb.0;
        Sun, 25 Apr 2021 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReeEc8S73nyjDOIe7NAJ3YuXZmnnG8VFsB28ujaVD70=;
        b=mjRdE1RGuXiyKuR9adhwb/XPalg3Dr5ZW0bZCoon35B0Wi/G8ERN/LcgfvX+l7ocw9
         TTCVeSsdC3xaaNXao3inDGb739Qox8Y6A0C6jt5Q/goUuhpAtxAfaXI2cItiyhmXNbsc
         NnrErQ2Ax8u6jGdYWSt+w9y1DiiQIt4NkvpgLWmFGF5lgJLGEaZu1plh1f5bVGQ/QH/6
         ikGTW8oZnVlqN6ZWFWCnYBsgMof6lxILFygFDnNjnSYy03U3cTXfo48BBh64Y72JiC1V
         cLv85kfJHrskfSIpX7u1cvLILfm6RNRMdte0IzFDu0LbbeMJNwfCk7hyqZlZ4mjFiDWz
         xnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReeEc8S73nyjDOIe7NAJ3YuXZmnnG8VFsB28ujaVD70=;
        b=QL1dO7m6XwxMrcFI2JWmUtmdglVqduS3Lo0ne4XR63qqUdJm5cEHiMOrbujvJzdTEo
         Sre1232HSS+CIoy7SYdQRHg8K2bFMxZXldWvfMw2GoCRfCUnYmdlO6vqqi2vsEgLpfbc
         /wdQEGqEWxHfh1SJyLFEGgZlR/LysyWLQMbAy5tHXXaqI03O4AodWU3+fpGdXdgzl/Pz
         EJn+QNjdq8Ha9ypTBS7dM1DzjJNT3qqJysYMlJRbiOqfmSsP5R/8dkrOrhNwvhMlFgaO
         32UsP4Hl1ZP3sRPRrft/GB2TXMnuCzIEd8a33Cn2pcBqSEpaak02tDf+hJreOTfjZ18d
         SgJg==
X-Gm-Message-State: AOAM533nLzg6UjlhkmQNHQzcIljpbOa7l3QtmXq0Q659GkY79FriHw1m
        yu5YKHTIeEM7wD6N/pdCIF4ddWloqmLC2W8XVRo=
X-Google-Smtp-Source: ABdhPJySLiFKDAwm8T0KSxt/lOvGo7/i/oQ6nDSQYauWDOO9/CUBjgXPhFMFouNpRptggueg8LP/GGMxLEdJz0dp6EQ=
X-Received: by 2002:a05:6402:1a47:: with SMTP id bf7mr16992729edb.173.1619373638001;
 Sun, 25 Apr 2021 11:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk> <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
 <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk>
In-Reply-To: <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk>
From:   haosdent <haosdent@gmail.com>
Date:   Mon, 26 Apr 2021 02:00:26 +0800
Message-ID: <CAFt=ROMhLo6AO98BHS4dW2rhXjhCzWqkiLFgYMPc3Q8+KHh1JQ@mail.gmail.com>
Subject: Re: NULL pointer dereference when access /proc/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> In the kernels of 4.8..4.18 period there it used to do
> so, but only in non-RCU mode (which is the reason for explicit rcu argument passed
> through that callchain).

Yep, we saw the `inode` parameter pass to `__atime_needs_update` is already NULL

```
bool __atime_needs_update(const struct path *path, struct inode *inode,
  bool rcu)
{
struct vfsmount *mnt = path->mnt;
struct timespec now;

if (inode->i_flags & S_NOATIME)   <=== Oops at here because the params
inode is NULL
return false;
```

```
    [exception RIP: __atime_needs_update+5]
    ...  **RSI: 0000000000000000**  <=== the second params of
__atime_needs_update "struct inode *inode" is NULL
```

On Mon, Apr 26, 2021 at 1:22 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Apr 26, 2021 at 01:04:46AM +0800, haosdent wrote:
> > Hi, Alexander, thanks a lot for your quick reply.
> >
> > > Not really - the crucial part is ->d_count == -128, i.e. it's already past
> > > __dentry_kill().
> >
> > Thanks a lot for your information, we would check this.
> >
> > > Which tree is that?
> > > If you have some patches applied on top of that...
> >
> > We use Ubuntu Linux Kernel "4.15.0-42.45~16.04.1" from launchpad directly
> > without any modification,  the mapping Linux Kernel should be
> > "4.15.18" according
> > to https://people.canonical.com/~kernel/info/kernel-version-map.html
>
> Umm...  OK, I don't have it Ubuntu source at hand, but the thing to look into
> would be
>         * nd->flags contains LOOKUP_RCU
>         * in the mainline from that period (i.e. back when __atime_needs_update()
> used to exist) we had atime_needs_update_rcu() called in get_link() under those
> conditions, with
> static inline bool atime_needs_update_rcu(const struct path *path,
>                                           struct inode *inode)
> {
>         return __atime_needs_update(path, inode, true);
> }
> and __atime_needs_update() passing its last argument (rcu:true in this case) to
> relatime_need_update() in
>         if (!relatime_need_update(path, inode, now, rcu))
> relatime_need_update() hitting
>         update_ovl_inode_times(path->dentry, inode, rcu);
> and update_ovl_inode_times() starting with
>         if (rcu || likely(!(dentry->d_flags & DCACHE_OP_REAL)))
>                 return;
> with subsequent accesses to ->d_inode.  Those obviously are *NOT* supposed
> to be reached in rcu mode, due to that check.
>
> Your oops looks like something similar to that call chain had been involved and
> somehow had managed to get through to those ->d_inode uses.
>
> Again, in RCU mode we really, really should not assume ->d_inode stable.  That's
> why atime_needs_update() gets inode as a separate argument and does *NOT* look
> at path->dentry at all.  In the kernels of 4.8..4.18 period there it used to do
> so, but only in non-RCU mode (which is the reason for explicit rcu argument passed
> through that callchain).



-- 
Best Regards,
Haosdent Huang
