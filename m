Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415CD3BA6B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 04:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGCC6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 22:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhGCC6B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 22:58:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C34F5613EB;
        Sat,  3 Jul 2021 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625280927;
        bh=KdTK+UeMQf79HP2aYkDeRCjrJpwTJT0tuqEScdh1Yms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0DvuIfc2CWeLzJnhJgtO/TkH0/iuO295xgSwcGSDwn4NJzhYqOy9QTEXv9CHGQn0
         M1Uwt7L6RnsyrW9qIw77JalPZIYAwvl//HhSfD2YP1R4iZCsWKCvTd9Xn5qgJf7sDW
         Y7lIsmVyVwkupymn2BUXj+pyeI7ew5Rqy1PuMBraTP9zBVjaNyJoOj/ivzriEFhuNC
         oS9lijNK5Yl1PZ8mp4GvsybLdcuEwV7/JmTYGnFRztako5k6GtO4Stx0cKV2BTOIZm
         yVHtOfkjUk/1bzKaRGk915UhCHq8JyOwYy/wTwEw/5YuZ3OOEfWl0v26UtG2JJ1ET1
         VX+B3Pc5iSxGQ==
Date:   Fri, 2 Jul 2021 19:55:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.14
Message-ID: <20210703025527.GA24788@locust>
References: <20210702201643.GA13765@locust>
 <CAHk-=wjaCmLbgtSXjVA19HZO6RS8rNePjUf6HuMa3PoDS9VuSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjaCmLbgtSXjVA19HZO6RS8rNePjUf6HuMa3PoDS9VuSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 02, 2021 at 02:39:46PM -0700, Linus Torvalds wrote:
> On Fri, Jul 2, 2021 at 1:16 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Please let me know if anything else strange happens during the merge
> > process.  The merge commits I made seem stable enough, but as it's the
> > first time I've ever accepted a pull request, we'd all be open to
> > feedback for improvements for next time.
> 
> It looks fine to me.
> 
> I *would* suggest editing the merge commit messages a bit when doing
> pull requests from other people.
> 
> It's by no means a big deal, but it looks a bit odd to see things like
> 
>     Hi all,
> 
>    ...
> 
>     Questions, comment and feedback appreciated!
> 
>     Thanks all!
>     Allison
> 
> in the merge message. All that text made a ton of sense in Allison's
> pull request, but as you actually then merge it, it doesn't make a lot
> of sense in the commit log, if you see what I mean..

Yep, got it.  I'll strip those out next time, thanks for helping me
figure these things out. :)

--D

> 
> But it's not a problem for this pull request, and I've merged it in my
> tree (pending my usual build tests etc, and I don't expect any
> issues).
> 
>             Linus
