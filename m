Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5136C674A26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 04:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATD1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 22:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATD1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:27:11 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DD9F393;
        Thu, 19 Jan 2023 19:27:10 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g16so1216946qtu.2;
        Thu, 19 Jan 2023 19:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeWp3AI1idtCEb/tlL53bEeivC6lDxwyV5blCIKy/sI=;
        b=D95ICNhlrG/KdBynQggCzgLLAuHuGk8Mbpn0AL6BtzmVJuwt9WLmxuMoNSN3Y+XCMO
         A0aGLaI2i9Pb7TYV++tON7pfjMGVz6QtncDV6ZIxUJ7qAbl6riZ/0bLOUAHlynHjFGsz
         jgZVEcHtW3eKzavFDaTW+lcKQBpQIJV9juezWz9TH3ad/TrZxMpCU34vumJYYHMfRc1Y
         501UIWK6arIlIiH+yxvspE8eXr88BU8njgy1Qj1Xu6KYAiaysbSWJuyXE94KWodqZ+z9
         ClwOUM+ZlBc5IEY4fdogkJMblmn1q3LV1t8V45ul6R/ubPabPfsWrmHeu2wAKLk6BH4g
         OYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeWp3AI1idtCEb/tlL53bEeivC6lDxwyV5blCIKy/sI=;
        b=FoNPKVX/VOQ1XI3x3bdYE6kolzQt+S0rApHRv6k25bl6DQrMmUki470fGfmgKs47Gt
         B7Feu6d3kZM9UUF+uOvFcXnpxg0ZpK2tDpd8ey3HiLj6SemC83cGCVoWpMHBD3SM7OWS
         ww0kYJYCnaJtQdp/gzwq6+Polqmu7DkYsB07sroeWcvQf5ZWSq368x4oauSTPOa6l76B
         p0mcbCyRutM1LTfrlDPywp+wdedyPywpRZne/0gokeCA0r8LMpwWkzk6FluZ0qOplhLP
         5zbsVlcb5ohLi/RqqwX/9tBzKoNqaVVW84ZFiZbumn51/klvRLnwqULN7QjUqHkCrVMe
         P9fw==
X-Gm-Message-State: AFqh2kq9DY1EzRS2sZOHSYFyZKG1IxtlhcftowvWtosWXHlPZixdWZEa
        NDhmiAShvgcOs5o/iT9pooQ=
X-Google-Smtp-Source: AMrXdXspB/m3c11KId3S124GHsnd9AxQ5adO5FiPfDnJeirGNlXW53ODOB1roTWwhkoUmwBEK/xWzA==
X-Received: by 2002:ac8:7ec2:0:b0:3b4:7efb:36a7 with SMTP id x2-20020ac87ec2000000b003b47efb36a7mr31586928qtj.27.1674185229244;
        Thu, 19 Jan 2023 19:27:09 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a244400b00706adbdf8b8sm5427634qkn.83.2023.01.19.19.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:27:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2B70F27C0054;
        Thu, 19 Jan 2023 22:27:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 19 Jan 2023 22:27:08 -0500
X-ME-Sender: <xms:CArKY4-bWIS_PR3UkTdlBgbzrFKh-a3BgQXVxR-4DGNCnuvEhHPMsg>
    <xme:CArKYwvSRqclehgEJgn8cidZMbyNOtU0Tn6YfPcEuO-Src_b4RJpDVV-qS1m8ApV2
    JrIiHGouEI6Sig1EQ>
X-ME-Received: <xmr:CArKY-CoYf3q3kJtJ4B0WRwzPXpRcbiVfQn4OdWkmW4PaTbYODDaCJor5J8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:CArKY4eTsdPYtx5S1ulFKrSQeaZdUQa1lO9U0e9yyG9_84xEKglp0Q>
    <xmx:CArKY9Pe3vvEVsg-PyNqO1XydZ01qWcu3caKgaj5G9AchN-yBioRgA>
    <xmx:CArKYykOgV911d_EQKVFaz3nwEKdfUUzBnnqcAjytECsWnYWgE1GNg>
    <xmx:CwrKY5FUOhn0H6pQqE_DyQIe_hj2HlsjhMPJ4Ejkwf9YMmYSziyWkd6xWxE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 22:27:04 -0500 (EST)
Date:   Thu, 19 Jan 2023 19:26:39 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        longman@redhat.com
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Message-ID: <Y8oJ70iWpBmRuaGN@boqun-archlinux>
References: <Y8mZHKJV4FH17vGn@boqun-archlinux>
 <1674179505-26987-1-git-send-email-byungchul.park@lge.com>
 <Y8n7NdFl9WEbGXH1@boqun-archlinux>
 <Y8oFj9A19cw3enHB@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8oFj9A19cw3enHB@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 07:07:59PM -0800, Boqun Feng wrote:
> On Thu, Jan 19, 2023 at 06:23:49PM -0800, Boqun Feng wrote:
> > On Fri, Jan 20, 2023 at 10:51:45AM +0900, Byungchul Park wrote:
> > > Boqun wrote:
> > > > On Thu, Jan 19, 2023 at 01:33:58PM +0000, Matthew Wilcox wrote:
> > > > > On Thu, Jan 19, 2023 at 03:23:08PM +0900, Byungchul Park wrote:
> > > > > > Boqun wrote:
> > > > > > > *Looks like the DEPT dependency graph doesn't handle the
> > > > > > > fair/unfair readers as lockdep current does. Which bring the
> > > > > > > next question.
> > > > > > 
> > > > > > No. DEPT works better for unfair read. It works based on wait/event. So
> > > > > > read_lock() is considered a potential wait waiting on write_unlock()
> > > > > > while write_lock() is considered a potential wait waiting on either
> > > > > > write_unlock() or read_unlock(). DEPT is working perfect for it.
> > > > > > 
> > > > > > For fair read (maybe you meant queued read lock), I think the case
> > > > > > should be handled in the same way as normal lock. I might get it wrong.
> > > > > > Please let me know if I miss something.
> > > > > 
> > > > > From the lockdep/DEPT point of view, the question is whether:
> > > > > 
> > > > >	read_lock(A)
> > > > >	read_lock(A)
> > > > > 
> > > > > can deadlock if a writer comes in between the two acquisitions and
> > > > > sleeps waiting on A to be released.  A fair lock will block new
> > > > > readers when a writer is waiting, while an unfair lock will allow
> > > > > new readers even while a writer is waiting.
> > > > > 
> > > > 
> > > > To be more accurate, a fair reader will wait if there is a writer
> > > > waiting for other reader (fair or not) to unlock, and an unfair reader
> > > > won't.
> > > 
> > > What a kind guys, both of you! Thanks.
> > > 
> > > I asked to check if there are other subtle things than this. Fortunately,
> > > I already understand what you guys shared.
> > > 
> > > > In kernel there are read/write locks that can have both fair and unfair
> > > > readers (e.g. queued rwlock). Regarding deadlocks,
> > > > 
> > > > 	T0		T1		T2
> > > > 	--		--		--
> > > > 	fair_read_lock(A);
> > > > 			write_lock(B);
> > > > 					write_lock(A);
> > > > 	write_lock(B);
> > > > 			unfair_read_lock(A);
> > > 
> > > With the DEPT's point of view (let me re-write the scenario):
> > > 
> > > 	T0		T1		T2
> > > 	--		--		--
> > > 	fair_read_lock(A);
> > > 			write_lock(B);
> > > 					write_lock(A);
> > > 	write_lock(B);
> > > 			unfair_read_lock(A);
> > > 	write_unlock(B);
> > > 	read_unlock(A);
> > > 			read_unlock(A);
> > > 			write_unlock(B);
> > > 					write_unlock(A);
> > > 
> > > T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
> > >     not doing either write_unlock(B) or read_unlock(B). In other words:
> > > 
> > >       1. read_unlock(A) happening depends on write_unlock(B) happening.
> > >       2. read_unlock(A) happening depends on read_unlock(B) happening.
> > > 
> > > T1: write_unlock(B) cannot happen if unfair_read_lock(A) is stuck by a A
> > >     owner not doing write_unlock(A). In other words:
> > > 
> > >       3. write_unlock(B) happening depends on write_unlock(A) happening.
> > > 
> > > 1, 2 and 3 give the following dependencies:
> > > 
> > >     1. read_unlock(A) -> write_unlock(B)
> > >     2. read_unlock(A) -> read_unlock(B)
> > >     3. write_unlock(B) -> write_unlock(A)
> > > 
> > > There's no circular dependency so it's safe. DEPT doesn't report this.
> > > 
> > > > the above is not a deadlock, since T1's unfair reader can "steal" the
> > > > lock. However the following is a deadlock:
> > > > 
> > > > 	T0		T1		T2
> > > > 	--		--		--
> > > > 	unfair_read_lock(A);
> > > > 			write_lock(B);
> > > > 					write_lock(A);
> > > > 	write_lock(B);
> > > > 			fair_read_lock(A);
> > > > 
> > > > , since T'1 fair reader will wait.
> > > 
> > > With the DEPT's point of view (let me re-write the scenario):
> > > 
> > > 	T0		T1		T2
> > > 	--		--		--
> > > 	unfair_read_lock(A);
> > > 			write_lock(B);
> > > 					write_lock(A);
> > > 	write_lock(B);
> > > 			fair_read_lock(A);
> > > 	write_unlock(B);
> > > 	read_unlock(A);
> > > 			read_unlock(A);
> > > 			write_unlock(B);
> > > 					write_unlock(A);
> > > 
> > > T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
> > >     not doing either write_unlock(B) or read_unlock(B). In other words:
> > > 
> > >       1. read_unlock(A) happening depends on write_unlock(B) happening.
> > >       2. read_unlock(A) happening depends on read_unlock(B) happening.
> > > 
> > > T1: write_unlock(B) cannot happen if fair_read_lock(A) is stuck by a A
> > >     owner not doing either write_unlock(A) or read_unlock(A). In other
> > >     words:
> > > 
> > >       3. write_unlock(B) happening depends on write_unlock(A) happening.
> > >       4. write_unlock(B) happening depends on read_unlock(A) happening.
> > > 
> > > 1, 2, 3 and 4 give the following dependencies:
> > > 
> > >     1. read_unlock(A) -> write_unlock(B)
> > >     2. read_unlock(A) -> read_unlock(B)
> > >     3. write_unlock(B) -> write_unlock(A)
> > >     4. write_unlock(B) -> read_unlock(A)
> > > 
> > > With 1 and 4, there's a circular dependency so DEPT definitely report
> > > this as a problem.
> > > 
> > > REMIND: DEPT focuses on waits and events.
> > 
> > Do you have the test cases showing DEPT can detect this?
> > 
> 
> Just tried the following on your latest GitHub branch, I commented all
> but one deadlock case. Lockdep CAN detect it but DEPT CANNOT detect it.
> Feel free to double check.
> 

In case anyone else want to try, let me explain a little bit how to
verify the behavior of the detectors. With the change, the only test
that runs is 

	dotest(queued_read_lock_hardirq_RE_Er, FAILURE, LOCKTYPE_RWLOCK);

"FAILURE" indicates selftests think lockdep should report a deadlock,
therefore for lockdep if all goes well, you will see:

	[...]       hardirq read-lock/lock-read:  ok  |

If you expect lockdep to print a full splat in the test (lockdep is
silent by default), you can add "debug_locks_verbose=2" in the kernel
command line, "2" mean RWLOCK testsuite.

Regards,
Boqun

> Regards,
> Boqun
