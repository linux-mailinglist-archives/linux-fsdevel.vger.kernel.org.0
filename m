Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9151F7D81F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 11:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfHAJAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 05:00:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729580AbfHAJAp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:00:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04A16AF5D;
        Thu,  1 Aug 2019 09:00:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A09A81E3F4D; Thu,  1 Aug 2019 11:00:42 +0200 (CEST)
Date:   Thu, 1 Aug 2019 11:00:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, linux-ext4@vger.kernel.org,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 4/7] fs/jbd2: Remove jbd_trylock_bh_state()
Message-ID: <20190801090042.GE25064@quack2.suse.cz>
References: <20190801010126.245731659@linutronix.de>
 <20190801010944.268628059@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801010944.268628059@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-08-19 03:01:30, Thomas Gleixner wrote:
> No users.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-ext4@vger.kernel.org
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Jan Kara <jack@suse.com>

Right.

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/jbd2.h |    5 -----
>  1 file changed, 5 deletions(-)
> 
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -347,11 +347,6 @@ static inline void jbd_lock_bh_state(str
>  	bit_spin_lock(BH_State, &bh->b_state);
>  }
>  
> -static inline int jbd_trylock_bh_state(struct buffer_head *bh)
> -{
> -	return bit_spin_trylock(BH_State, &bh->b_state);
> -}
> -
>  static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
>  {
>  	return bit_spin_is_locked(BH_State, &bh->b_state);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
