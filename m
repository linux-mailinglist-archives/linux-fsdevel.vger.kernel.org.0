Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264D134EB21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhC3OxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 10:53:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhC3OxD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:53:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6F2AB317;
        Tue, 30 Mar 2021 14:53:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7A1E11E4353; Tue, 30 Mar 2021 16:53:02 +0200 (CEST)
Date:   Tue, 30 Mar 2021 16:53:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Mahoney <jeffm@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] reiserfs: update reiserfs_xattrs_initialized() condition
Message-ID: <20210330145302.GB30749@quack2.suse.cz>
References: <20210221050957.3601-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <bd7b3f61-8f79-d287-cbe5-c221a81a76ca@i-love.sakura.ne.jp>
 <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
 <35304c11-5f2e-e581-cd9d-8f079b5c198e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35304c11-5f2e-e581-cd9d-8f079b5c198e@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-03-21 23:47:11, Tetsuo Handa wrote:
> On 2021/03/22 4:20, Linus Torvalds wrote:
> > On Sun, Mar 21, 2021 at 7:37 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> syzbot is reporting NULL pointer dereference at reiserfs_security_init()
> > 
> > Whee. Both of the mentioned commits go back over a decade.
> > 
> > I guess I could just take this directly, but let's add Jeff Mahoney
> > and Jan Kara to the participants in case they didn't see it on the
> > fsdevel list. I think they might want to be kept in the loop.
> > 
> > I'll forward the original in a separate email to them.
> > 
> > Jeff/Jan - just let me know if I should just apply this as-is.
> > Otherwise I'd expect it to (eventually) come in through Jan's random
> > fs tree, which is how I think most of these things have come in ..
> > 
> 
> Linus, please just apply this as-is.

Yes, feel free to. I just wanted to do that today and send you the pull
request anyway.

								Honza


> 
> Jan says "your change makes sense" at https://lkml.kernel.org/m/20210322153142.GF31783@quack2.suse.cz
> and Jeff says "Tetsuo's patch is fine" at https://lkml.kernel.org/m/7d7a884a-5a94-5b0e-3cf5-82d12e1b0992@suse.com
> and I'm waiting for Jan/Jeff's reply to "why you think that my patch is incomplete" at
> https://lkml.kernel.org/m/fa9f373a-a878-6551-abf1-903865a9d21f@i-love.sakura.ne.jp .
> Since Jan/Jeff seems to be busy, applying as-is will let syzkaller answer to my question.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
