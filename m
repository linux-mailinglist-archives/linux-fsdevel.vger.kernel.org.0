Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA51E69D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406043AbgE1S5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405981AbgE1S5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 14:57:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300CC08C5C6;
        Thu, 28 May 2020 11:57:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s18so17305291ioe.2;
        Thu, 28 May 2020 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=1WUnmileJ2hdwhJopOOZ097SsEZwGISBLeXRWZOX8Kw=;
        b=O5u/28JbMp8QjK3lUZ/R7ZQMXrdEDvj24BT8A4iwA80MkobNQm6KbVC7lsHwcRnM88
         CzK3hY3J7l4IpU+q1OOkOjfgysObGfUS1fE+OcWBeNTi+i3D57pSp34d/MEX65sofusR
         JFNCgJfFT31wAF15xsix2FLiUgr6Tr/JkpG2rKkOXBxPjo3uURhF1zCqsP7k637OtmTR
         30Dmdw7tZWU+0wB5iXHdeFkZdJxOalF8bJspvUB1ICb4BArg0Cu4YE/9+l+6b+a16CS4
         +gGU35X7ZXNt7beLPyIqXY4j+D3eJguupYKR4lqvFUESMIVl+sLMGqUZLtqCUfihXAf5
         bI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=1WUnmileJ2hdwhJopOOZ097SsEZwGISBLeXRWZOX8Kw=;
        b=NUS+8swYyUFK6Encnsesq0NX87D7MAybA4/pM4rj9/Hmkh6Noa47T8Pr+L5LYXtlLc
         8Kq9BJG/JX43D1bjLQXgxCp48ACtw6CqO5pO6uqUbIKX9mxJLEiBaJgFH8e3GgsDx+9e
         2GXbkgN5qU6mMHJZIlr0FCKo8b5VDK3qs+m2xmGNYNcY3D2I9llAlx6rzzwNDPC0wtSJ
         fRBUyvhy3Q2iMr9QMzB3969NQEKXtPx+shsEk+rrem2IDIgoP3K/IdhFbYchHY0sP+yI
         WKuMMlgR0IbMWoG2jKjhmKnqAcAGhcRlnZoj9bPRwZ564xLRV83aeL615SRQ65+sS4sH
         85aA==
X-Gm-Message-State: AOAM531RvR2KDYvOEJrfRNLR3xuZ7p+0JMNyQ9+oURLJRHSROmY/JDaX
        ijSJ+PTuFwJ4ISXMsaw5dN14atflnZaoWDqXXPg=
X-Google-Smtp-Source: ABdhPJyydn/pBJttOXEZiAfOKrvZXe6ygyWDRQj0iu7bX6aSzYU6voXuDYKa5Sz7GBL0WLH8kWoRliDkLAIZSpS49vU=
X-Received: by 2002:a02:ca18:: with SMTP id i24mr3888754jak.70.1590692224637;
 Thu, 28 May 2020 11:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de> <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
In-Reply-To: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 28 May 2020 20:57:06 +0200
Message-ID: <CA+icZUWO7UY3vquZsTq=8fQsLHWUtdzCh4HMq5uH+qetSP7CMg@mail.gmail.com>
Subject: Re: clean up kernel_{read,write} & friends v2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 8:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 27, 2020 at 10:40 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > this series fixes a few issues and cleans up the helpers that read from
> > or write to kernel space buffers, and ensures that we don't change the
> > address limit if we are using the ->read_iter and ->write_iter methods
> > that don't need the changed address limit.
>
> Apart from the "please don't mix irrelevant whitespace changes with
> other changes" comment, this looks fine to me.
>
> And a rant related to that change: I'm really inclined to remove the
> checkpatch check for 80 columns entirely, but it shouldn't have been
> triggering for old lines even now.
>
> Or maybe make it check for something more reasonable, like 100 characters.
>
> I find it ironic and annoying how "checkpatch" warns about that silly
> legacy limit, when checkpatch itself then on the very next few lines
> has a line that is 124 columns wide
>
> And yes, that 124 character line has a good reason for it. But that's
> kind of the point. There are lots of perfectly fine reasons for longer
> lines.
>
> I'd much rather check for "no deep indentation" or "no unnecessarily
> complex conditionals" or other issues that are more likely to be
> _real_ problems.  But do we really have 80x25 terminals any more that
> we'd care about?
>

Please kill that 80-columns-checkpatch-rule for more human-readability of code.

- Sedat -
