Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530C71D705A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 07:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgERF1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 01:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERF1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 01:27:32 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19650C061A0C;
        Sun, 17 May 2020 22:27:32 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l20so8607824ilj.10;
        Sun, 17 May 2020 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QR4aGtyUsOayVjV8xb4dtdBzcBW2eWKNOlzdZZnoWY=;
        b=bvvX8594ZBJJr+iHr2Mq99oq8+A1Ih/2X1vPajRR5sXKOLqjbxtTO1P3kztLMHrwoB
         WGClO+0gHivdYz7+6Ed3+RrztYBwFhyFmaVdmKZSgDn5CzVNAWYxz46/QT3NJQcs+jTj
         SI9diF507sth34u2wCW3+Ct3l6TeiF2wjMUjb6giX7I3juxOQ0TguJp9Oa/SylgAUFKm
         5Mh4n1daU1pbYaSl/gQckYzrtfy1IdZaX9hKo5+UeoYNHytXxsfJBZd3qKIBuCjUNXIW
         882iV58Zz5xC8f2INKEW1NwtCAiklT3mWdtIpTSkdHW/cLOmdB3lTruYVTW1jY7/8Es/
         WOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QR4aGtyUsOayVjV8xb4dtdBzcBW2eWKNOlzdZZnoWY=;
        b=ufAE0CZbYmJxzgQCNPYe7ag3eXDESKLuhIzqFrZDVU6DJTj3iOni9cupHqCbImxfv3
         91gipXOMU0sPQQ6oVlImnn7bQEV3UmWBnF+m5YInq+zNWKScxT1Y5d68MWoxsW5/beGP
         HO91Ejd/PbQdRoXoHxDLcu3n6Zyku+lK5pzsbIITp0Xk6D7/CqiK4biS998W1Ish2x4c
         QFk7iAGXB0dYrPl7zAEesabHGfrS4cenNplfiHPaxmjjzh9QDkbtz11c9nceUYOutNiw
         biDdnaGOe15bD+UWjs3NBaJZiuz79NxU7zkp1o/GwVmhXqofHYfE1lrB3P99NWyEsbRo
         07pA==
X-Gm-Message-State: AOAM530Ti60BdR9n5e1SsKI482V9ZIj61X/6Dc7ziEXWQ0S6o+sSqZSc
        BGtuFt+A7xgNAAGOJxvhE0ZgOatnbutN3zRZP2rSTA==
X-Google-Smtp-Source: ABdhPJwmavOHQKDeN7rY0YMd9Je5obkFVfVstvV4BG0S/nWkjc07gLymnvuEt17jO70OKPem27dDg2eoYUQuZsXYxok=
X-Received: by 2002:a92:495d:: with SMTP id w90mr14742485ila.275.1589779651179;
 Sun, 17 May 2020 22:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200515072047.31454-1-cgxu519@mykernel.net> <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
In-Reply-To: <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 May 2020 08:27:19 +0300
Message-ID: <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Ian Kent <raven@themaw.net>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 3:53 AM Ian Kent <raven@themaw.net> wrote:
>
> On Fri, 2020-05-15 at 15:20 +0800, Chengguang Xu wrote:
> > This series adds a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
> > to indicate to drop negative dentry in slow path of lookup.
> >
> > In overlayfs, negative dentries in upper/lower layers are useless
> > after construction of overlayfs' own dentry, so in order to
> > effectively reclaim those dentries, specify LOOKUP_DONTCACHE_NEGATIVE
> > flag when doing lookup in upper/lower layers.
>
> I've looked at this a couple of times now.
>
> I'm not at all sure of the wisdom of adding a flag to a VFS function
> that allows circumventing what a file system chooses to do.

But it is not really a conscious choice is it?
How exactly does a filesystem express its desire to cache a negative
dentry? The documentation of lookup() in vfs.rst makes it clear that
it is not up to the filesystem to make that decision.
The VFS needs to cache the negative dentry on lookup(), so
it can turn it positive on create().
Low level kernel modules that call the VFS lookup() might know
that caching the negative dentry is counter productive.

>
> I also do really see the need for it because only hashed negative
> dentrys will be retained by the VFS so, if you see a hashed negative
> dentry then you can cause it to be discarded on release of the last
> reference by dropping it.
>
> So what's different here, why is adding an argument to do that drop
> in the VFS itself needed instead of just doing it in overlayfs?

That was v1 patch. It was dealing with the possible race of
returned negative dentry becoming positive before dropping it
in an intrusive manner.

In retrospect, I think this race doesn't matter and there is no
harm in dropping a positive dentry in a race obviously caused by
accessing the underlying layer, which as documented results in
"undefined behavior".

Miklos, am I missing something?

Thanks,
Amir.
