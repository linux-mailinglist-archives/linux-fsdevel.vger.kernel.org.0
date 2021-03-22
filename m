Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C483344974
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCVPnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 11:43:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhCVPnD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:43:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BCADACA8;
        Mon, 22 Mar 2021 15:43:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 663511F2B98; Mon, 22 Mar 2021 16:43:01 +0100 (CET)
Date:   Mon, 22 Mar 2021 16:43:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jeff Mahoney <jeffm@suse.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] reiserfs: update reiserfs_xattrs_initialized() condition
Message-ID: <20210322154301.GG31783@quack2.suse.cz>
References: <20210221050957.3601-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <bd7b3f61-8f79-d287-cbe5-c221a81a76ca@i-love.sakura.ne.jp>
 <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoa-F1mgQ8bFYhbyGCf+RP_WNrbciVqe42MYkjNjUMpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 21-03-21 12:20:21, Linus Torvalds wrote:
> On Sun, Mar 21, 2021 at 7:37 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > syzbot is reporting NULL pointer dereference at reiserfs_security_init()
> 
> Whee. Both of the mentioned commits go back over a decade.
> 
> I guess I could just take this directly, but let's add Jeff Mahoney
> and Jan Kara to the participants in case they didn't see it on the
> fsdevel list. I think they might want to be kept in the loop.
> 
> I'll forward the original in a separate email to them.
> 
> Jeff/Jan - just let me know if I should just apply this as-is.
> Otherwise I'd expect it to (eventually) come in through Jan's random
> fs tree, which is how I think most of these things have come in ..

Thanks Linus. I've replied to Tetsuo's patch. Honestly, I've seen the patch
when Tetsuo sent it but reiserfs fuzzing bugs are not high on my priority
list so I forgot about it before I found time to understand what's going on
there. I think his patch is safe but I'm not sure it is a complete solution
so let's wait a bit what he has to say.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
