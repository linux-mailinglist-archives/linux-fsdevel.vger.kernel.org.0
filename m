Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBF1D734B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgERIwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERIwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 04:52:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D4C061A0C;
        Mon, 18 May 2020 01:52:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 79so9749550iou.2;
        Mon, 18 May 2020 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4chbHYgJUDXODbTEEGjDgCp5f6yFQOHY+1MvD4mvpCk=;
        b=sBiH3kaWmaslx5GBWQSs+jdoLiOpdCJBuAIFMe4aGOzNthpWQ01d+99RkEtDHWkgjY
         vPq9k7bG4mZN3C24I+hovGf4wK6g+bBAN/sha59ZLGlFikFI6xzq9bepeClRmZZPN8ik
         8H+bGI263GFLyEVALFTIBz+mHSokMmHLT+ZRTi9DYUHSPqL942gPLXBI2jgC00kkJ7uO
         ruMYxL+9iRAe+sKE8G7xitBR4gSqWMNlpcLWt1RH0glhUpLdKWA+DVoiuDTqfrCbL9Wt
         Jeh7Rp1WSPYFd4lWkRTDy4eJjNfaH5cx4YCXKmB2Hn1tdc9lIa4zS/CoTbRa5Majbw14
         gCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4chbHYgJUDXODbTEEGjDgCp5f6yFQOHY+1MvD4mvpCk=;
        b=dxW/bHDcKtWhNR27oA8K8J5s1VDLQqxcJJrkfuXCaA+MW/n/IQDrnuZGaymxudnxK3
         lcYTBHvcOMhAfuG8mZIcV1vcPm6YI0q3zQyQBnOdC/tBVDNBGHOlC8aMiXXtPlHX9pgT
         q/1bi8FcAXKchvMVWUb/V+67PAnLr0ZhEy/16Yg0mPgNqTT1kUoGgwG9KDIpwoABPhkz
         xjS/PRIOM8h0ALpjQtrNYab7bZM/ZTxcGCV89HKdNo9ym1hLaMXuxYZlL36Gi1cx7Hgr
         bIUyGRyZCP6vogTWnIZLTLgg8fxY/ZnfIhYazBzOetcwzy9SiekTqWppy5QQBxvchcJf
         pP+w==
X-Gm-Message-State: AOAM533cFbeHTOlfxsqedhder/wWd3RxF1IgIx5p+ElcOf67UoWjqg9A
        Kh7C4u0Ihbauh7TaApMfs2cokZweJInNoowjB9EIxA==
X-Google-Smtp-Source: ABdhPJwOEDgjcoHUnVGjWMzMdmI9fKPqMwZbG0+l7C4n4DKmy3eeFwKe2asSCBa9vjdnKe5AlrpvIeRyamXwKBy7wVo=
X-Received: by 2002:a02:58c3:: with SMTP id f186mr15047766jab.120.1589791927904;
 Mon, 18 May 2020 01:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200515072047.31454-1-cgxu519@mykernel.net> <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
 <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com> <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com>
In-Reply-To: <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 May 2020 11:51:56 +0300
Message-ID: <CAOQ4uxgfEBksbtLtPVA2L-JhRUQ5aEh9+W4dXGREuoMe40V8tQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, Chengguang Xu <cgxu519@mykernel.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > I also do really see the need for it because only hashed negative
> > > dentrys will be retained by the VFS so, if you see a hashed negative
> > > dentry then you can cause it to be discarded on release of the last
> > > reference by dropping it.
> > >
> > > So what's different here, why is adding an argument to do that drop
> > > in the VFS itself needed instead of just doing it in overlayfs?
> >
> > That was v1 patch. It was dealing with the possible race of
> > returned negative dentry becoming positive before dropping it
> > in an intrusive manner.
> >
> > In retrospect, I think this race doesn't matter and there is no
> > harm in dropping a positive dentry in a race obviously caused by
> > accessing the underlying layer, which as documented results in
> > "undefined behavior".
> >
> > Miklos, am I missing something?
>
> Dropping a positive dentry is harmful in case there's a long term
> reference to the dentry (e.g. an open file) since it will look as if
> the file was deleted, when in fact it wasn't.
>

I see. My point was that the negative->positive transition cannot
happen on underlying layers without user modifying underlying
layers underneath overlay, so it is fine to be in the "undefined" behavior
zone.

> It's possible to unhash a negative dentry in a safe way if we make
> sure it cannot become positive.  One way is to grab d_lock and remove
> it from the hash table only if count is one.
>
> So yes, we could have a helper to do that instead of the lookup flag.
> The disadvantage being that we'd also be dropping negatives that did
> not enter the cache because of our lookup.
>
> I don't really care, both are probably good enough for the overlayfs case.
>

There is another point to consider.
A negative underlying fs dentry may be useless for *this* overlayfs instance,
but since lower layers can be shared among many overlayfs instances,
for example, thousands of containers all testing for existence of file /etc/FOO
on startup.

It sounds like if we want to go through with DONTCACHE_NEGATIVE, that
it should be opt-in behavior for overlayfs.

Thanks,
Amir.
