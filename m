Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D56D6749BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 04:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjATDIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 22:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATDIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:08:31 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297DB6581;
        Thu, 19 Jan 2023 19:08:29 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id q15so3293861qtn.0;
        Thu, 19 Jan 2023 19:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aanStjkAuNpUGmIcpWYeimC/W8C86KKXi+3w0Ng+q0=;
        b=kDE+rXR01EnoawecBm30rGzEor4xuohJ701ZEaVGwRUm7JoEdHZolyafTevUbetpDc
         tLvHIJIthhOtFIMHc0zzCTjamUIlhGlqh50+F7yR1no86EQZuOM5AayUlaWEt7aVfEMX
         GuV8ECrvfDcZGLqC/VUpmHcigm7HUAC49t6cu5x1dhX5lgllCD7ln6/h+eSaPPRlWvQf
         uk2feFf3FX4LNxkCOkD0z5SRIW8uQinABZHtx/gI9HtiCSgJQGKYRihlPTCJunr6Ba0Q
         rl3BbiGTY7gecY//eoeWabviRkOod8r4+3UFt1UYkY/Uvq4OMOpKzOuFDbxeJieU2+AB
         K+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aanStjkAuNpUGmIcpWYeimC/W8C86KKXi+3w0Ng+q0=;
        b=p6Yh33+UQrhbYB+ixqkH+nblMRrWiw668yUN6Km2xERRbpoheTdNXe/NQVUOg27ijZ
         wiPRLrTxOM173hNra9I0ehzPLv0RdcnQoGFRpL8Wp2rzsWVrRsMXLL1h56tnl3LaRPDo
         q4+PDLO7huooXQvD3Q0Nb7nUqF+nUjkVtAqC+54eygYI3tctdMJCyZpfwPXr/czW/ziu
         1izupbEUFa6c86CbDoyZoro8tCxlFOoL/JSDfVRoBSWPKTR6VvUvbw14/7/d2sW2/dq+
         RACf/OSc+fPwgXxu+kVKpnPiLqV9yOGWPUD3ONzCy2DpmuJIcrVyAyIbSSZdp0bQOJfT
         hT9g==
X-Gm-Message-State: AFqh2kpVojr8ug4fclo4K0vkTiJ1K0Boc+Kdnzok6wT1Zvo3zOH7GAaF
        jNHmeVHYp4guUnRZj2uQmlLn1bKveycojQ==
X-Google-Smtp-Source: AMrXdXt94VVVwf3YtXCLnT/BYi9iMQMrhVqUI3n1Uey3D0XhFZCQgxjLM2xlFy9i1yabjaTwGFSrlg==
X-Received: by 2002:ac8:71c1:0:b0:3b6:3abd:fcc2 with SMTP id i1-20020ac871c1000000b003b63abdfcc2mr18321450qtp.46.1674184108290;
        Thu, 19 Jan 2023 19:08:28 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id do1-20020a05620a2b0100b00706284b74b5sm13047476qkb.52.2023.01.19.19.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:08:27 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0A08927C0054;
        Thu, 19 Jan 2023 22:08:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 19 Jan 2023 22:08:27 -0500
X-ME-Sender: <xms:qQXKY6G6fOUBFdZq_LkPiHgAXOARZyxJKMq80ko_9a2Acpx9tCFDAw>
    <xme:qQXKY7U4Krh-NRmxsOfgHo_-vODRCQnq7sBo1qh2QhSTGKWEmG96_OajpxnHN2ef7
    X8wItbjTZs4h9A0nw>
X-ME-Received: <xmr:qQXKY0IbKY2-3KHnM1ZfVXDL5flf482JLM9xuwACrsBP72PU1kaCNXq9zYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qQXKY0FTuary54h0mMqBFA6JvfQyEb9VY5riS7mJdqwEn022mN7vcw>
    <xmx:qQXKYwWd5Is28ECRwvyWyqGqiAyHcKic7-l-jKvsjChoWlo053EBvw>
    <xmx:qQXKY3P164yjCC1I0xvHcvkuZ8KDrWJ82bj59biGMeq4jCQ-xoT3TA>
    <xmx:qwXKY_P4J1ug_5oy-1C8F6dUi54YSLAfRCllowi-GLbK9VJG5P0lK9fdd3M>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 22:08:24 -0500 (EST)
Date:   Thu, 19 Jan 2023 19:07:59 -0800
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
Message-ID: <Y8oFj9A19cw3enHB@boqun-archlinux>
References: <Y8mZHKJV4FH17vGn@boqun-archlinux>
 <1674179505-26987-1-git-send-email-byungchul.park@lge.com>
 <Y8n7NdFl9WEbGXH1@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8n7NdFl9WEbGXH1@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 06:23:49PM -0800, Boqun Feng wrote:
> On Fri, Jan 20, 2023 at 10:51:45AM +0900, Byungchul Park wrote:
> > Boqun wrote:
> > > On Thu, Jan 19, 2023 at 01:33:58PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Jan 19, 2023 at 03:23:08PM +0900, Byungchul Park wrote:
> > > > > Boqun wrote:
> > > > > > *Looks like the DEPT dependency graph doesn't handle the
> > > > > > fair/unfair readers as lockdep current does. Which bring the
> > > > > > next question.
> > > > > 
> > > > > No. DEPT works better for unfair read. It works based on wait/event. So
> > > > > read_lock() is considered a potential wait waiting on write_unlock()
> > > > > while write_lock() is considered a potential wait waiting on either
> > > > > write_unlock() or read_unlock(). DEPT is working perfect for it.
> > > > > 
> > > > > For fair read (maybe you meant queued read lock), I think the case
> > > > > should be handled in the same way as normal lock. I might get it wrong.
> > > > > Please let me know if I miss something.
> > > > 
> > > > From the lockdep/DEPT point of view, the question is whether:
> > > > 
> > > >	read_lock(A)
> > > >	read_lock(A)
> > > > 
> > > > can deadlock if a writer comes in between the two acquisitions and
> > > > sleeps waiting on A to be released.  A fair lock will block new
> > > > readers when a writer is waiting, while an unfair lock will allow
> > > > new readers even while a writer is waiting.
> > > > 
> > > 
> > > To be more accurate, a fair reader will wait if there is a writer
> > > waiting for other reader (fair or not) to unlock, and an unfair reader
> > > won't.
> > 
> > What a kind guys, both of you! Thanks.
> > 
> > I asked to check if there are other subtle things than this. Fortunately,
> > I already understand what you guys shared.
> > 
> > > In kernel there are read/write locks that can have both fair and unfair
> > > readers (e.g. queued rwlock). Regarding deadlocks,
> > > 
> > > 	T0		T1		T2
> > > 	--		--		--
> > > 	fair_read_lock(A);
> > > 			write_lock(B);
> > > 					write_lock(A);
> > > 	write_lock(B);
> > > 			unfair_read_lock(A);
> > 
> > With the DEPT's point of view (let me re-write the scenario):
> > 
> > 	T0		T1		T2
> > 	--		--		--
> > 	fair_read_lock(A);
> > 			write_lock(B);
> > 					write_lock(A);
> > 	write_lock(B);
> > 			unfair_read_lock(A);
> > 	write_unlock(B);
> > 	read_unlock(A);
> > 			read_unlock(A);
> > 			write_unlock(B);
> > 					write_unlock(A);
> > 
> > T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
> >     not doing either write_unlock(B) or read_unlock(B). In other words:
> > 
> >       1. read_unlock(A) happening depends on write_unlock(B) happening.
> >       2. read_unlock(A) happening depends on read_unlock(B) happening.
> > 
> > T1: write_unlock(B) cannot happen if unfair_read_lock(A) is stuck by a A
> >     owner not doing write_unlock(A). In other words:
> > 
> >       3. write_unlock(B) happening depends on write_unlock(A) happening.
> > 
> > 1, 2 and 3 give the following dependencies:
> > 
> >     1. read_unlock(A) -> write_unlock(B)
> >     2. read_unlock(A) -> read_unlock(B)
> >     3. write_unlock(B) -> write_unlock(A)
> > 
> > There's no circular dependency so it's safe. DEPT doesn't report this.
> > 
> > > the above is not a deadlock, since T1's unfair reader can "steal" the
> > > lock. However the following is a deadlock:
> > > 
> > > 	T0		T1		T2
> > > 	--		--		--
> > > 	unfair_read_lock(A);
> > > 			write_lock(B);
> > > 					write_lock(A);
> > > 	write_lock(B);
> > > 			fair_read_lock(A);
> > > 
> > > , since T'1 fair reader will wait.
> > 
> > With the DEPT's point of view (let me re-write the scenario):
> > 
> > 	T0		T1		T2
> > 	--		--		--
> > 	unfair_read_lock(A);
> > 			write_lock(B);
> > 					write_lock(A);
> > 	write_lock(B);
> > 			fair_read_lock(A);
> > 	write_unlock(B);
> > 	read_unlock(A);
> > 			read_unlock(A);
> > 			write_unlock(B);
> > 					write_unlock(A);
> > 
> > T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
> >     not doing either write_unlock(B) or read_unlock(B). In other words:
> > 
> >       1. read_unlock(A) happening depends on write_unlock(B) happening.
> >       2. read_unlock(A) happening depends on read_unlock(B) happening.
> > 
> > T1: write_unlock(B) cannot happen if fair_read_lock(A) is stuck by a A
> >     owner not doing either write_unlock(A) or read_unlock(A). In other
> >     words:
> > 
> >       3. write_unlock(B) happening depends on write_unlock(A) happening.
> >       4. write_unlock(B) happening depends on read_unlock(A) happening.
> > 
> > 1, 2, 3 and 4 give the following dependencies:
> > 
> >     1. read_unlock(A) -> write_unlock(B)
> >     2. read_unlock(A) -> read_unlock(B)
> >     3. write_unlock(B) -> write_unlock(A)
> >     4. write_unlock(B) -> read_unlock(A)
> > 
> > With 1 and 4, there's a circular dependency so DEPT definitely report
> > this as a problem.
> > 
> > REMIND: DEPT focuses on waits and events.
> 
> Do you have the test cases showing DEPT can detect this?
> 

Just tried the following on your latest GitHub branch, I commented all
but one deadlock case. Lockdep CAN detect it but DEPT CANNOT detect it.
Feel free to double check.

Regards,
Boqun

------------------------------------------->8
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index cd89138d62ba..f38e4109e013 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2375,6 +2375,7 @@ static void ww_tests(void)
  */
 static void queued_read_lock_hardirq_RE_Er(void)
 {
+	// T0
 	HARDIRQ_ENTER();
 	read_lock(&rwlock_A);
 	LOCK(B);
@@ -2382,12 +2383,17 @@ static void queued_read_lock_hardirq_RE_Er(void)
 	read_unlock(&rwlock_A);
 	HARDIRQ_EXIT();
 
+	// T1
 	HARDIRQ_DISABLE();
 	LOCK(B);
 	read_lock(&rwlock_A);
 	read_unlock(&rwlock_A);
 	UNLOCK(B);
 	HARDIRQ_ENABLE();
+
+	// T2
+	write_lock_irq(&rwlock_A);
+	write_unlock_irq(&rwlock_A);
 }
 
 /*
@@ -2455,6 +2461,7 @@ static void queued_read_lock_tests(void)
 	dotest(queued_read_lock_hardirq_RE_Er, FAILURE, LOCKTYPE_RWLOCK);
 	pr_cont("\n");
 
+#if 0
 	print_testname("hardirq lock-read/read-lock");
 	dotest(queued_read_lock_hardirq_ER_rE, SUCCESS, LOCKTYPE_RWLOCK);
 	pr_cont("\n");
@@ -2462,6 +2469,7 @@ static void queued_read_lock_tests(void)
 	print_testname("hardirq inversion");
 	dotest(queued_read_lock_hardirq_inversion, FAILURE, LOCKTYPE_RWLOCK);
 	pr_cont("\n");
+#endif
 }
 
 static void fs_reclaim_correct_nesting(void)
@@ -2885,6 +2893,7 @@ void locking_selftest(void)
 	init_shared_classes();
 	lockdep_set_selftest_task(current);
 
+#if 0
 	DO_TESTCASE_6R("A-A deadlock", AA);
 	DO_TESTCASE_6R("A-B-B-A deadlock", ABBA);
 	DO_TESTCASE_6R("A-B-B-C-C-A deadlock", ABBCCA);
@@ -2967,6 +2976,7 @@ void locking_selftest(void)
 	DO_TESTCASE_6x2x2RW("irq read-recursion #3", irq_read_recursion3);
 
 	ww_tests();
+#endif
 
 	force_read_lock_recursive = 0;
 	/*
@@ -2975,6 +2985,7 @@ void locking_selftest(void)
 	if (IS_ENABLED(CONFIG_QUEUED_RWLOCKS))
 		queued_read_lock_tests();
 
+#if 0
 	fs_reclaim_tests();
 
 	/* Wait context test cases that are specific for RAW_LOCK_NESTING */
@@ -2987,6 +2998,7 @@ void locking_selftest(void)
 	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
 	pr_cont("\n");
 
+#endif
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;

