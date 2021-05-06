Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD0375232
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhEFKWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhEFKWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 06:22:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30592C06174A;
        Thu,  6 May 2021 03:21:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w3so7476090ejc.4;
        Thu, 06 May 2021 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Okvuy7UMQ+muyrVt6dbv2vx5m7gZXNUjABVA8axp1J8=;
        b=G+CpirJVV/wOQQZ+DzmK77gsRy5ewNYMoHjs65eaMxTuejOjRdifM+6QQUqddxcCT3
         G+NftrHR9lz9WmUYa+snrG3q9i7I1QJ0spE/gogwAi2kIrCOTDTYDmxceMbpFRebT1VD
         uPwbhbjdB22EUA4PphSSmY6oQvPIWxvLMyNxAc9h0/tlpLVtrlsTjNOc0VvNmX2anMCz
         FMj4H4d+aBMp14c3qoPBkqT8jUb3JqISvlNSeCE0WyLqDIxS5D9njjp6RR+FR7HafbQZ
         9Jhb0XfK0q88By0HhWWWb/c4rOVpOpKkFFm+yJjLy1ujsHsaqNGLmgU68/TLqVeHKUp8
         vjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Okvuy7UMQ+muyrVt6dbv2vx5m7gZXNUjABVA8axp1J8=;
        b=bLf+VrCYdZVsqwM5byHJAltZ8FQYd/mdmDiegUsgwq8qnR884qrjUSH/9kRLmgEjn0
         YXpNErOfB8PWDQSml2YdTsUgUHuinSEJJQXZouXNY13L491owAKBkDgopJnUKIGca0sz
         mi2FTAbz1UPFKJjRCEihcbZTRpCeiQq2BoMmQ2/vnXRc5emx8zqVJgtt22bDgBpN969N
         E6JZ4gVoIezjLcD/WtiEm/mVIHJog++lOg+dTCCfhgS5RHiafQmVbIJhUFeb7fUqM60K
         w9k9JbJP8c/B9oNSmqV0PaxRvd7zaFeeCopCjhVDR8WccUh5rlbBFBFTo5XN4EQWQUZx
         ZHOQ==
X-Gm-Message-State: AOAM5303/bBn6vFlFWrVpcIFY3qee31AzkYXQFBrXG7/O8oL71M3TJAE
        4Hkkk0KQcALdvJril182xbwQMmRsIymcprMKFaU=
X-Google-Smtp-Source: ABdhPJx/PWX8+mn+kYtfhCmdRhQ3bJC+30Rhk8EyyPiXA8mP/xTU2pOfrpEX7T0RWvVLADrRFOYmmcmyJNw1iCIjrl0=
X-Received: by 2002:a17:906:1617:: with SMTP id m23mr3763516ejd.352.1620296509848;
 Thu, 06 May 2021 03:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk> <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
 <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk> <CAFt=ROOi+bi_N4NEkDQxagNwnoqM0zYR+sxiag7r2poNVW9u+w@mail.gmail.com>
 <YIb4xIU6x5BLe0wd@zeniv-ca.linux.org.uk> <CAFt=ROOnU-rVoLoP=bgR3Y3WpJmhTerAQZqFd-v=eZ306Vrobg@mail.gmail.com>
In-Reply-To: <CAFt=ROOnU-rVoLoP=bgR3Y3WpJmhTerAQZqFd-v=eZ306Vrobg@mail.gmail.com>
From:   haosdent <haosdent@gmail.com>
Date:   Thu, 6 May 2021 18:21:37 +0800
Message-ID: <CAFt=ROMzGwFssZA4Z35UeP2JPwEZtf62spm1Q+mN+mN+08bk8Q@mail.gmail.com>
Subject: Re: NULL pointer dereference when access /proc/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oh, Al, I saw you mentioned the reoder issue at
https://groups.google.com/g/syzkaller/c/0SW33jMcrXQ/m/lHJUsWHVBwAJ
and with a follow-up patch
https://gist.githubusercontent.com/dvyukov/67fe363d5ce2e2b06c71/raw/4d1b6c23f8dff7e0f8e2e3cab7e50208fddb0570/gistfile1.txt
However, it looks it would not work in some previous version
https://github.com/torvalds/linux/blob/v4.16/fs/dcache.c#L496

Because we set `d_hahs.prev` to `NULL` at

```
void __d_drop(struct dentry *dentry)
{
  ___d_drop(dentry);
  dentry->d_hash.pprev = NULL;
}
```

then in `dentry_unlink_inode`, `raw_write_seqcount_begin` would be
skipped due to `if (hashed)` condition is false.

```
static void dentry_unlink_inode(struct dentry * dentry)
    __releases(dentry->d_lock)
    __releases(dentry->d_inode->i_lock)
{
    struct inode *inode = dentry->d_inode;
    bool hashed = !d_unhashed(dentry);

    if (hashed)
        raw_write_seqcount_begin(&dentry->d_seq);  <--- Looks would
skip because hashed is false.
    __d_clear_type_and_inode(dentry);
    hlist_del_init(&dentry->d_u.d_alias);
    if (hashed)
        raw_write_seqcount_end(&dentry->d_seq);     <--- Looks would
skip because hashed is false.
...
```

Should we backport
https://github.com/torvalds/linux/commit/4c0d7cd5c8416b1ef41534d19163cb07ffaa03ab
and https://github.com/torvalds/linux/commit/0632a9ac7bc0a32f8251a53b3925775f0a7c4da6
to previous versions?

On Mon, May 3, 2021 at 11:31 PM haosdent <haosdent@gmail.com> wrote:
>
> Hi, Alexander, thanks a lot for your detailed explanations. I take a
> look at the code again and the thread and I realize there are some
> incorrect representations in my previous word.
>
> >>   struct inode *d_inode = 0x0         <======= d_inode is NULL and cause Oops!
>
> Actually it is Oops at `inode->i_flags` directly instead of `d_inode`,
> so the code would not further to change the access time.
>
> ```
> bool __atime_needs_update(const struct path *path, struct inode *inode,
>   bool rcu)
> {
> struct vfsmount *mnt = path->mnt;
> struct timespec now;
>
> if (inode->i_flags & S_NOATIME)    <======= Oops at here according to
> `[19521409.372016] IP: __atime_needs_update+0x5/0x190`.
> return false;
> ```
>
> But it looks impossible if we take a look at "walk_component > lookup_fast".
>
> Let me introduce why it goes through "walk_component > lookup_fast"
> instead of "walk_component > lookup_slow" first,
>
> in "walk_component > step_into > pick_link", the code would set
> `nameidata->stack->seq` to `seq` which is comes from the passed in
> parameters.
> If the code goes through "walk_component > lookup_slow", `seq` would
> be 0 and then `nameidata->stack->seq` would be 0.
> If the code goes through "walk_component > lookup_slow", `seq` would
> be `dentry->d_seq->sequence`.
> According to the contents in attachment files "nameidata.txt" and
> "dentry.txt", `dentry->d_seq->sequence` is 4, and
> `nameidata->stack->seq` is 4 as well.
> So looks like the code goes through "walk_component > lookup_fast" and
> "walk_component > step_into > pick_link".
>
> The `inode` parameter in `__atime_needs_update` comes from
> `nameidata->link_inode`. But in attachment file "nameidata.txt", we
> could found `nameidata->link_inode` is NULL already.
> Because the code goes through "walk_component > lookup_fast" and
> "walk_component > step_into > pick_link", the `inode` assign to
> `nameidata->link_inode` must comes from `lookup_fast`.
>
> So it looks like something wrong in `lookup_fast`. Let me continue to
> explain why this looks impossible.
>
> In `walk_component`, `lookup_fast` have to return 1 (> 0), otherwise
> it would fallback to `lookup_slow`.
>
> ```
> err = lookup_fast(nd, &path, &inode, &seq);
> if (unlikely(err <= 0)) {
>   if (err < 0)
>     return err;
>   path.dentry = lookup_slow(&nd->last, nd->path.dentry,
>         nd->flags);
> }
>
> return step_into
> ```
>
> Because for our case, it looks like the code goes through
> "walk_component > lookup_fast" and "walk_component > step_into >
> pick_link",
> This infers `lookup_fast` return 1 in this Oops.
>
> Because `lookup_fast` return 1, it looks like the code goes through
> the following path.
>
> ```
>   if (nd->flags & LOOKUP_RCU) {
>     ...
>
>     *inode = d_backing_inode(dentry);
>     negative = d_is_negative(dentry);
>
>     ...
>       ...
>       if (negative)
>         return -ENOENT;
>       path->mnt = mnt;
>       path->dentry = dentry;
>       if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
>         return 1;
> ```
>
> As we see, if `*inode` is NULL, it should return `-ENOENT` because `if
> (negative)` would be true, which is conflict with "`lookup_fast`
> return 1".
>
> And in `__d_clear_type_and_inode`, it always sets the dentry to
> negative first and then sets d_inode to NULL.
>
> ```
> static inline void __d_clear_type_and_inode(struct dentry *dentry)
> {`
>   unsigned flags = READ_ONCE(dentry->d_flags);
>
>   flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);   // Set dentry to
> negative first.
>   WRITE_ONCE(dentry->d_flags, flags);
>       // memory barrier
>   dentry->d_inode = NULL;
>                // Then set d_inode to NULL.
> }
> ```
>
> So looks like `inode` in `lookup_fast` should not be NULL if it could
> skip `if (negative)` check even in the RCU case. Unless
>
> ```
> # in lookup_fast method
>   *inode = d_backing_inode(dentry);
>   negative = d_is_negative(dentry);
> ```
>
> is reorder to
>
> ```
> # in lookup_fast method
>   negative = d_is_negative(dentry);
>   *inode = d_backing_inode(dentry);
> ```
>
> when CPU executing the code. But is this possible in RCU?
>
> I diff my local ubuntu's code with upstream tag v4.15.18, it looks
> like no different in `fs/namei.c`, `fs/dcache.c`, `fs/proc`.
> So possible the problem may happen to upstream tag v4.15.18 as well,
> sadly my script still could not reproduce the issue on the server so
> far,
> would like to see if any insights from you then I could continue to
> check what's wrong in this Oops, thank you in advance!
>
> On Tue, Apr 27, 2021 at 1:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Apr 27, 2021 at 01:16:44AM +0800, haosdent wrote:
> > > > really should not assume ->d_inode stable
> > >
> > > Hi, Alexander, sorry to disturb you again. Today I try to check what
> > > `dentry->d_inode` and `nd->link_inode` looks like when `dentry` is
> > > already been killed in `__dentry_kill`.
> > >
> > > ```
> > > nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> > > dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> > > nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> > > dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> > > nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
> > > dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
> > > ```
> > >
> > > It looks like `dentry->d_inode` could be NULL while `nd->link_inode`
> > > is always has value.
> > > But this make me confuse, by right `nd->link_inode` is get from
> > > `dentry->d_inode`, right?
> >
> > It's sampled from there, yes.  And in RCU mode there's nothing to
> > prevent a previously positive dentry from getting negative and/or
> > killed.  ->link_inode (used to - it's gone these days) go with
> > ->seq, which had been sampled from dentry->d_seq before fetching
> > ->d_inode and then verified to have ->d_seq remain unchanged.
> > That gives you "dentry used to have this inode at the time it
> > had this d_seq", and that's what gets used to validate the sucker
> > when we switch to non-RCU mode (look at legitimize_links()).
> >
> > IOW, we know that
> >         * at some point during the pathwalk that sucker had this inode
> >         * the inode won't get freed until we drop out of RCU mode
> >         * if we need to go to non-RCU (and thus grab dentry references)
> > while we still need that inode, we will verify that nothing has happened
> > to that link (same ->d_seq, so it still refers to the same inode) and
> > grab dentry reference, making sure it won't go away or become negative
> > under us.  Or we'll fail (in case something _has_ happened to dentry)
> > and repeat the entire thing in non-RCU mode.
>
>
>
> --
> Best Regards,
> Haosdent Huang



-- 
Best Regards,
Haosdent Huang
