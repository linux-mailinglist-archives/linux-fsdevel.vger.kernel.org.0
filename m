Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770B516602E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBTO6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 09:58:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44493 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgBTO6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:58:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so27756004oia.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpwkKx7E4F4iGPP1d6IgP9CAngaHu/jtsv9MUOt6i20=;
        b=rhM3j0x8usrirIjQD0qjSQ9jCCkuL46j6a4GYkPXKtnSgcJhk6Hx9Th+jZf4OPWbqZ
         EDZz3oWYIE9EiZWJqp2PUKigyRRw/t6Q8UH8RqgRNGsTWV2dv9mCr2DcH4z2bQQ+xk2z
         kYwaMe7GObMMSex4qojHOfzhjSgF0C0TaHxJYt1mQa7h1Ewq+OWpkkTj9lDdiomRk5M6
         rRTAz/AFKDZMNW7yS5X69XPQn0UBAe7qzflPdGZWJ08eh9do95UBp6tUxa/M6BwZpMHp
         3HF+uapICKyFdhOCgDzsKDrdTMOx5Xl1lWUMDmdY/3QoY8XGcpsi8+IoC8lTU4JBx+35
         OQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpwkKx7E4F4iGPP1d6IgP9CAngaHu/jtsv9MUOt6i20=;
        b=X2hRLS4jmW3B12XM3euNDXR1iyHz6TYFGEs5r4RL020sKCmHmXwToVvJ3nn+cDS12W
         lpQy5/6vjD/0yKYAIisY7o59JTPlvaK6OWoCzo80VnctT4EZ0C1e2LEXrpeJCrbnXV89
         +doA5OmHKTI7N8oLT7CtB6WTTTWA4NcYGq1UH6rRGMuJenIVYYjeklbBzbJ3kcjiZXsm
         /sWeyGQ3iABSzXtVbwGd+jOMdiCX6ezPM8jRxGT+OgAHDgHYzuZ39LH4TL/Xr0RY6Iow
         n+9ZnNADJVWNh7uRorGIYkMjriyiutOaWz48HKZ37406SvY6xhyXA3qNJEGHm7j6qhAU
         BU+A==
X-Gm-Message-State: APjAAAWuYWdruQyMfZpCW0SSmxqs9S1UbSLTIVHwgSxzzj8Hswzd1oGa
        Sf1e3UYH4CguO+YoJFk4PQRqHMWwtMcW97TNpDvxYg==
X-Google-Smtp-Source: APXvYqwLZrWv2noarPLEsgl5QTqzBVLNEume/NYspxHkGbrXT7XqrvirpoDtoOYD8R+IEePb15ICBTNX5VckUg08Qbg=
X-Received: by 2002:aca:b187:: with SMTP id a129mr2344580oif.175.1582210716581;
 Thu, 20 Feb 2020 06:58:36 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204558110.3299825.5080605285325995873.stgit@warthog.procyon.org.uk>
 <CAG48ez0fsB_XTmNfE-2tuabH7JHyQdih8bu7Qwu9HGWJXti7tQ@mail.gmail.com> <628199.1582203532@warthog.procyon.org.uk>
In-Reply-To: <628199.1582203532@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 20 Feb 2020 15:58:10 +0100
Message-ID: <CAG48ez03VMKEmJEmViSkxbF9J5dW=6vny9vKGdenBewtjF+nqQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] afs: Support fsinfo() [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 1:59 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > Ewww. So basically, having one static set of .fsinfo_attributes is not
> > sufficiently flexible for everyone, but instead of allowing the
> > filesystem to dynamically provide a list of supported attributes, you
> > just duplicate the super_operations? Seems to me like it'd be cleaner
> > to add a function pointer to the super_operations that can dynamically
> > fill out the supported fsinfo attributes.
> >
> > It seems to me like the current API is going to be a dead end if you
> > ever want to have decent passthrough of these things for e.g. FUSE, or
> > overlayfs, or VirtFS?
>
> Ummm...
>
> Would it be sufficient to have a function that returns a list of attributes?
> Or does it need to be able to call to vfs_do_fsinfo() if it supports an
> attribute?
>
> There are two things I want to be able to do:
>
>  (1) Do the buffer wrangling in the core - which means the core needs to see
>      the type of the attribute.  That's fine if, say, afs_fsinfo() can call
>      vfs_do_fsinfo() with the definition for any attribute it wants to handle
>      and, say, return -ENOPKG otherways so that the core can then fall back to
>      its private list.
>
>  (2) Be able to retrieve the list of attributes and/or query an attribute.
>      Now, I can probably manage this even through the same interface.  If,
>      say, seeing FSINFO_ATTR_FSINFO_ATTRIBUTES causes the handler to simply
>      append on the IDs of its own supported attributes (a helper can be
>      provided for that).
>
>      If it sees FSINFO_ATR_FSINFO_ATTRIBUTE_INFO, it can just look to see if
>      it has the attribute with the ID matching Nth and return that, else
>      ENOPKG - again a helper could be provided.
>
> Chaining through overlayfs gets tricky.  You end up with multiple contributory
> filesystems with different properties - and any one of those layers could
> perhaps be another overlay.  Overlayfs would probably needs to integrate the
> info and derive the lowest common set.

Hm - I guess just returning a list of attributes ought to be fine?
Then AFS can just return one of its two statically-allocated attribute
lists there, and a filesystem with more complicated circumstances
(like FUSE or overlayfs or whatever) can compute a heap-allocated list
on mount that is freed when the superblock goes away, or something
like that?
