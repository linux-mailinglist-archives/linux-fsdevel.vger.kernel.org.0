Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E666688E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 02:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjAMBK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 20:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjAMBKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:10:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9C103;
        Thu, 12 Jan 2023 17:10:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C82D4B82033;
        Fri, 13 Jan 2023 01:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E75C433EF;
        Fri, 13 Jan 2023 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673572250;
        bh=XjG0tJLnw6e6BwzsRY23cqQwSiXN5RtMYzj3WAIhllg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lx9fvr6FX1p7zN00Cb5+Is5PRX66Sm5W52bWEx7WdhNVLeBrFkejAw4uYXnO1o1pv
         o/EPR+8+PSWRl1SVjd5dDKlMbglxL2aTUsQayvT4zCEv7psLJ0ku5v4zcBW1vi4nLg
         ON9zUgI6V416Ly/zDTbI24elwUXvRhoyCffNP0cPlOVnwVDSkHw7i2wWBGRkF+0bB7
         RRI105FGtkBi27tf6aWzsq9iELQQyGJ2btVr2BElq/Q67KSIt7MEna9s9XYSJpsGDs
         tN1duGyQlnUl9ip0mRTRxCHS7x2xbHV7wIYNEYZqET1aN4/Xk8g6sM8BshAqzvv/4g
         QLaKEvIdPgbqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 186565C1C8C; Thu, 12 Jan 2023 17:10:50 -0800 (PST)
Date:   Thu, 12 Jan 2023 17:10:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH rcu v2 09/20] fs: Remove CONFIG_SRCU
Message-ID: <20230113011050.GV4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-9-paulmck@kernel.org>
 <2060f8d47dd0fd1999733b87b1919f6642b6e9e1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2060f8d47dd0fd1999733b87b1919f6642b6e9e1.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:03:48PM -0500, Jeff Layton wrote:
> On Thu, 2023-01-12 at 16:11 -0800, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in conditional compilation based on CONFIG_SRCU.
> > Therefore, remove the #ifdef and throw away the #else clause.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  fs/locks.c | 25 -------------------------
> >  1 file changed, 25 deletions(-)
> > 
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 8f01bee177159..1909a9de242c8 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -1889,7 +1889,6 @@ int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
> >  }
> >  EXPORT_SYMBOL(generic_setlease);
> >  
> > -#if IS_ENABLED(CONFIG_SRCU)
> >  /*
> >   * Kernel subsystems can register to be notified on any attempt to set
> >   * a new lease with the lease_notifier_chain. This is used by (e.g.) nfsd
> > @@ -1923,30 +1922,6 @@ void lease_unregister_notifier(struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(lease_unregister_notifier);
> >  
> > -#else /* !IS_ENABLED(CONFIG_SRCU) */
> > -static inline void
> > -lease_notifier_chain_init(void)
> > -{
> > -}
> > -
> > -static inline void
> > -setlease_notifier(long arg, struct file_lock *lease)
> > -{
> > -}
> > -
> > -int lease_register_notifier(struct notifier_block *nb)
> > -{
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL_GPL(lease_register_notifier);
> > -
> > -void lease_unregister_notifier(struct notifier_block *nb)
> > -{
> > -}
> > -EXPORT_SYMBOL_GPL(lease_unregister_notifier);
> > -
> > -#endif /* IS_ENABLED(CONFIG_SRCU) */
> > -
> >  /**
> >   * vfs_setlease        -       sets a lease on an open file
> >   * @filp:	file pointer
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul
