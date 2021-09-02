Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA63FF187
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 18:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbhIBQgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346297AbhIBQgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:36:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28FDC061757
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 09:35:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s3so4651671ljp.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPrsMqCFWN5ib/jexjJbOwaX0GY7GM4LAYtcBkjQs5Q=;
        b=b3xI1nUr2/Mn5lXTe8nymD6u/TZbVZW+KxgxiDD6kyYY168iu2pTlL23fELvbHgCpN
         4Fj+7xzFU3A8C58jpF8+C+JtLfgp1XCOGuw0IiJgEozDRP+l/GRHkybpYixOynp9lv2/
         Y952+XTnIiHmfQ+eXPBncvGvwPdqXLKde1dnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPrsMqCFWN5ib/jexjJbOwaX0GY7GM4LAYtcBkjQs5Q=;
        b=l+VJH99Yd78fDxdfOH35P2HYezMJ8KURUZ2q4ya7RR6OHBxyr2S2siUQ2oBu7uu/Cf
         0kVMfj5aMORiABbvEI7lpKncmU/5GqRiv9HUw9E7dOsFNmM3sPzqtHIlR4y0xNpfH33f
         ZQaZh589McFJWRqoo08TUB9QyhBlmtHlFNCx8PituLM9Yy01rAQHTMxv9vCkxIlxX6Wg
         txEsi/luY8SedBm7kJEnAZ7iTa/ZoJaYtYk56+jv3/6sCjq1oHk3GorOseBFbgwJfhD4
         GASh3y4pR84cl11/f7f6HxX1jqjiWELVLQNnU0zzQScnk9Hn+Y094bvHTJYSukusGtVN
         rNlw==
X-Gm-Message-State: AOAM532CWNKKEEXF9KZf07JxoPCYaWiu/uJQkBH2p+n9RxUpIuG0t28Q
        gMUbFp7DUJa9BHlgwt3pMc2BDzK4bDJMOomo1Ls=
X-Google-Smtp-Source: ABdhPJyLbx6MdYE7QdgBF7YZ1bWWqJ2nEnUkNAfCHjL2f3TF1vPbKkoq1mPL12wT5vpG1kKsabr17A==
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr3392900ljp.154.1630600542613;
        Thu, 02 Sep 2021 09:35:42 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z7sm274466ljh.59.2021.09.02.09.35.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:35:41 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id t12so5445468lfg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 09:35:40 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr3194130lfp.41.1630600540703;
 Thu, 02 Sep 2021 09:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
In-Reply-To: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 09:35:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiYSSpmgLRaq+AXg5NjCh_02ShSXRxsa8CfoKa0OooEQ@mail.gmail.com>
Message-ID: <CAHk-=wiiYSSpmgLRaq+AXg5NjCh_02ShSXRxsa8CfoKa0OooEQ@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 5.15
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 2, 2021 at 6:51 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> The reason this touches so many files is that the ->get_acl() method now
> gets a "bool rcu" argument.  The ->get_acl() API was updated based on
> comments from Al and Linus:
>
>   https://lore.kernel.org/linux-fsdevel/CAJfpeguQxpd6Wgc0Jd3ks77zcsAv_bn0q17L3VNnnmPKu11t8A@mail.gmail.com/

That link might have been good in the individual commit message too,
but I did it in the merge commit instead.

I did notice that we now have a stale comment about ->get_acl() in fs/namei.c:

                acl = get_cached_acl_rcu(inode, ACL_TYPE_ACCESS);
                if (!acl)
                        return -EAGAIN;
                /* no ->get_acl() calls in RCU mode... */
                if (is_uncached_acl(acl))
                        return -ECHILD;

but we actually did the RCU-mode ->get_acl() call already in
get_cached_acl_rcu().

Of course, get_cached_acl_rcu() only does it for ACL_DONT_CACHE, not
for ACL_NOT_CACHED, so RCU mode is still a bit special.

At some point we probably should make get_cached_acl_rcu() do the
right thing for a successful lookup with ACL_NOT_CACHED set too, and
actually install the newly looked-up ACL. But I haven't thought much
about locking (but I think it would be ok, we use "cmpxchg" to update
the cached entry).

This is just a "maybe fixme for the future" note about that comment
and about get_cached_acl_rcu() behavior. I've pulled this, and I think
we're ok, it's just a small oddity.

                  Linus
