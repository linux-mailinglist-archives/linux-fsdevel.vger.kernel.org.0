Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE722ACF37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 06:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgKJFki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 00:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbgKJFkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:40:37 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B6C0613CF;
        Mon,  9 Nov 2020 21:40:35 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id t13so10732553ilp.2;
        Mon, 09 Nov 2020 21:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DIOGE9LlJfJtD3ne03/o68pr8zjLYEzyNYyYIc6Te6s=;
        b=nnXsLtkk+qOhz7PGV3GgL0ccwL+HBtNQIsgUz6fjtoOT7L2RYjt7wjAk/ywWmCXsfK
         k92cGETnhGpa+eIl1d9rlR7Eg+EZni5/40l9eunTzUPaHAiWQzEt5o00hx6p3Bgrbu7X
         wUsUzq2vsea/fviXQZgLSNPO4DOVF6JJ2op+aOmObAoGvwymNjSCaQv4fbWZpbvVLA6+
         18C9HAwpWg0lqJ8sZViP10AUqECPHVUgf+CODx2zwP2pbfFV4ggy92wK+vgoLkEbo5bv
         FdA2WoWg3II29o3r9Mn9mDIQJt9LGwk+v8+j316s8/FFX9hW/Hpult4jFKzCQjsEnbn+
         lrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DIOGE9LlJfJtD3ne03/o68pr8zjLYEzyNYyYIc6Te6s=;
        b=NKNlSOfjNFIjGN4/o5BlUnGibgTl8B+oD99obPXKdiw0H4EdP8hWt0RV0eMc/2i/HW
         WfnmxSdU8Kysf7JOPO3BqF2vdzPdbVQmfHiklnY4McQlsHfyxuGNSTkSpt+1yZYNxHIg
         RKz7WI7Wap402zmbsczBybOAt5811CqBMlXL0Kjk6kMYaLBV2b6WsxZr0Ftq5ZxaePNy
         8qFNQZPVAi4P5Eu8mFCGdOzjhXZT56llcb8JjkuXTc2PKzjowegnN/PdofTwIGcbm3hi
         CkcSgqORPq7Y63UwM3oMp9ZnNx1+reccXzt6T5afV1sQxTPbVRdMUQjfmE5gOUyIOPoi
         k5aQ==
X-Gm-Message-State: AOAM532RorEMOQeJylX9F+kOBZCplZO0PlnPVxYx5bVM1b6WO95E4/++
        NgN+05mvuqL1YLTUicPtMQs=
X-Google-Smtp-Source: ABdhPJyW//4tY0sCmFcUb1x/6HHhHBFdsp6Q6x14MtBdrKQLpyvEj0n2JIpdnV3rHVhQHxmOWwuM/A==
X-Received: by 2002:a92:d9ca:: with SMTP id n10mr12275820ilq.21.1604986835139;
        Mon, 09 Nov 2020 21:40:35 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x5sm8135171ilc.15.2020.11.09.21.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 21:40:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4566E27C0054;
        Tue, 10 Nov 2020 00:40:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 10 Nov 2020 00:40:33 -0500
X-ME-Sender: <xms:zieqXx2joknb145Nu6w4WsJ4rbM9nletsSVciGbpxF9akH4wPztASQ>
    <xme:zieqX4GdfUXxkGI_EMb7n9BuAcT4eG_5QkhUu8kgCl1wgabropG_8EROXGNKLY3fT
    cEBgS2Wg15oaphd-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudefuddruddtjedrud
    egjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:zieqXx5OSnpS9wkIGZCf55bzyrkLLayGQBZdQaNdp48wSX-m8OGoug>
    <xmx:zieqX-2iXSAEL0vee4YTF00etc6y8aSfurD37e6qIfUKOOYQNdecug>
    <xmx:zieqX0ER_9ytS6z89VbixsdfTozlvCTk-YB4rukCgV2we-DDw1iUIw>
    <xmx:0SeqXyb6wH4MHEu4--Nmc_fkjDsDA6FaAzsSDaq0AbINvvcczNSBDeZxV64>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A29F3063067;
        Tue, 10 Nov 2020 00:40:30 -0500 (EST)
Date:   Tue, 10 Nov 2020 13:40:16 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC] fs: Avoid to use lockdep information if it's turned off
Message-ID: <20201110054016.GC286534@boqun-archlinux>
References: <20201110013739.686731-1-boqun.feng@gmail.com>
 <20201110014925.GB9685@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110014925.GB9685@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:49:25PM -0800, Darrick J. Wong wrote:
> On Tue, Nov 10, 2020 at 09:37:37AM +0800, Boqun Feng wrote:
> > Filipe Manana reported a warning followed by task hanging after attempts
> > to freeze a filesystem[1]. The problem happened in a LOCKDEP=y kernel,
> > and percpu_rwsem_is_held() provided incorrect results when
> > debug_locks == 0. Although the behavior is caused by commit 4d004099a668
> > ("lockdep: Fix lockdep recursion"): after that lock_is_held() and its
> > friends always return true if debug_locks == 0. However, one could argue
> 
> ...the silent trylock conversion with no checking of the return value is
> completely broken.  I already sent a patch to tear all this out:
> 
> https://lore.kernel.org/linux-fsdevel/160494580419.772573.9286165021627298770.stgit@magnolia/T/#t
> 

Thanks! That looks good to me. I'm all for removing that piece of code.

While we are at it, I have to ask, when you hit the original problem
(warning after trylock in __start_sb_write()), did you see any lockdep
splat happened previously? Or just like Filipe, you hit that without
seeing any lockdep splat happened before? Thanks! I'm trying to track
down the silent lockdep turn-off.

Regards,
Boqun

> --D
> 
> > that querying the lock holding information regardless if the lockdep
> > turn-off status is inappropriate in the first place. Therefore instead
> > of reverting lock_is_held() and its friends to the previous semantics,
> > add the explicit checking in fs code to avoid use the lock holding
> > information if lockdpe is turned off. And since the original problem
> > also happened with a silent lockdep turn-off, put a warning if
> > debug_locks is 0, which will help us spot the silent lockdep turn-offs.
> > 
> > [1]: https://lore.kernel.org/lkml/a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com/
> > 
> > Reported-by: Filipe Manana <fdmanana@gmail.com>
> > Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: Nikolay Borisov <nborisov@suse.com>
> > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > ---
> > Hi Filipe,
> > 
> > I use the slightly different approach to fix this problem, and I think
> > it should have the similar effect with my previous fix[2], except that
> > you will hit a warning if the problem happens now. The warning is added
> > on purpose because I don't want to miss a silent lockdep turn-off.
> > 
> > Could you and other fs folks give this a try?
> > 
> > Regards,
> > Boqun
> > 
> > [2]: https://lore.kernel.org/lkml/20201103140828.GA2713762@boqun-archlinux/
> > 
> >  fs/super.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index a51c2083cd6b..1803c8d999e9 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -1659,12 +1659,23 @@ int __sb_start_write(struct super_block *sb, int level, bool wait)
> >  	 * twice in some cases, which is OK only because we already hold a
> >  	 * freeze protection also on higher level. Due to these cases we have
> >  	 * to use wait == F (trylock mode) which must not fail.
> > +	 *
> > +	 * Note: lockdep can only prove correct information if debug_locks != 0
> >  	 */
> >  	if (wait) {
> >  		int i;
> >  
> >  		for (i = 0; i < level - 1; i++)
> >  			if (percpu_rwsem_is_held(sb->s_writers.rw_sem + i)) {
> > +				/*
> > +				 * XXX: the WARN_ON_ONCE() here is to help
> > +				 * track down silent lockdep turn-off, i.e.
> > +				 * this warning is triggered, but no lockdep
> > +				 * splat is reported.
> > +				 */
> > +				if (WARN_ON_ONCE(!debug_locks))
> > +					break;
> > +
> >  				force_trylock = true;
> >  				break;
> >  			}
> > -- 
> > 2.29.2
> > 
