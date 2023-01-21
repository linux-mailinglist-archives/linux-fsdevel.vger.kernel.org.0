Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118E67637F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 04:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAUDoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 22:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAUDoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:44:09 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA0B40F6;
        Fri, 20 Jan 2023 19:44:08 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id o5so5755877qtr.11;
        Fri, 20 Jan 2023 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQMqPUw9hwIL711N+3/JISEhbTkZf60Reascbm6VQQ4=;
        b=P5gDUR0TzntSFmhj0dmJ+CaeXwQJd30S3yEAe4HnfSMmiBvzi6l7uY+FP3JRNJ9K2H
         77XYekwOcuPbJzIlLI3UwvU/JCUdb1ivZr70QVzsRTRdR7ZzUQhBYFs7PHS6h+m1xIK9
         ffl7FTa9Mvlv93Yp+90v61XOn40XGl8xz2OoM7uuqXhgRXj7DwRWjuS/s7dCP4eIHW2I
         IWWpCYitqzGsOerU+oQPSDKkDuNwABQAoGLuwlPKRb3ZZ5udriGCXtmDupYRsLn4/s4z
         sulW8DoVUCbnR+WP9Ek7y/AVAgfqNnFY1U7vBD/gOiJYg6u0RnsXLH6djqobHls0e7aE
         8miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQMqPUw9hwIL711N+3/JISEhbTkZf60Reascbm6VQQ4=;
        b=OK42JRbmsDTWfWooHOzM8yOPevUpt6vgT8xefVAIKvz+CJ0dxFb4kNDyWhgC4jAex6
         SxBgYPg/vcngaiz3TF2pkGJERTXm4acrkoRnLTlChhghA3TB5xgw3yj5v+vhNmg1FD9D
         B6GRojpqBahbYrP6cajgFMYwDM671qLw8f6aIGwX6XHzUEN/PFBzVoWeDGzqDTDXufh+
         gLqjoHRuq9c9LAKEH5t3IysQAGjWbcG8kigt7XyI5iYDsU4g5c1q9Y7B6icNqqLGPf6t
         JUDvCUM1frHrk3zCNdMVOwr1b+/4lcqF4iru6obFT8Sx2n4LxQ2JS5PKjO4Nilh/mozB
         m6+w==
X-Gm-Message-State: AFqh2krVYWpQESnY2nYfmV4oENF0yJUpo/K18lyJv6RQ+YQK8PV0ww0E
        E4GdyRGVqO0V4mUnMwHyiuc=
X-Google-Smtp-Source: AMrXdXtvm2O2YHcIWKwHFjTW05nzBD8gYLtK/seCVEVm0nBHLiINGTluwezKn4Om3kW/3Z9FKc/mwQ==
X-Received: by 2002:a05:622a:1b02:b0:3a7:eb3d:9e75 with SMTP id bb2-20020a05622a1b0200b003a7eb3d9e75mr25934460qtb.16.1674272647123;
        Fri, 20 Jan 2023 19:44:07 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w25-20020a05620a0e9900b006fcab4da037sm4120859qkm.39.2023.01.20.19.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 19:44:06 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 09C4627C005B;
        Fri, 20 Jan 2023 22:44:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 20 Jan 2023 22:44:06 -0500
X-ME-Sender: <xms:g1_LYxJBn6Xd7XL-U6p_DwUFEuGWut2yulsEcMlGld8gFgBwznt0cQ>
    <xme:g1_LY9L80nlpQ3vsCVBm8V8dcoCezBZBkS8gAwH66LXvRTUotwZQCbcXXgwZYnQ32
    HJK8r8o6NnKtCUY6A>
X-ME-Received: <xmr:g1_LY5up8pJaYFWNBQgck_HD55GkjtXhSVilhdZT8_--d05x5mebe2iTljvDz1DNCnj7tpT37Xv4b1GwNK3JM7Qp9xIrnnVIOF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddufedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:g1_LYyblep8vLXU8X_XZbBWVjM0ODY7nES_2KaakN2vJIBz3UpxkCA>
    <xmx:g1_LY4Z5f8D0Tv-ulO8ISYcLbGS5SrO9OqxHZDAY8FfqotjtP3Nb5g>
    <xmx:g1_LY2C-4zm5euFl4Fhj4dhLGWA8jWIzcCllSVEjl-iqw2tiAp-ohA>
    <xmx:hV_LY0wIIsj4kAnW951fzRTsebUsUwoVezIV4pOnr7TpfXMJo9pVjO55vh0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 22:44:02 -0500 (EST)
Date:   Fri, 20 Jan 2023 19:44:01 -0800
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
Message-ID: <Y8tfgYNZ//feEDvC@Boquns-Mac-mini.local>
References: <Y8oFj9A19cw3enHB@boqun-archlinux>
 <1674271694-18950-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674271694-18950-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:28:14PM +0900, Byungchul Park wrote:
> On Thu, Jan 19, 2023 at 07:07:59PM -0800, Boqun Feng wrote:
> > On Thu, Jan 19, 2023 at 06:23:49PM -0800, Boqun Feng wrote:
> > > On Fri, Jan 20, 2023 at 10:51:45AM +0900, Byungchul Park wrote:
> 
> [...]
> 
> > > > T0		T1		T2
> > > > --		--		--
> > > > unfair_read_lock(A);
> > > >			write_lock(B);
> > > >					write_lock(A);
> > > > write_lock(B);
> > > >			fair_read_lock(A);
> > > > write_unlock(B);
> > > > read_unlock(A);
> > > >			read_unlock(A);
> > > >			write_unlock(B);
> > > >					write_unlock(A);
> > > > 
> > > > T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
> > > >     not doing either write_unlock(B) or read_unlock(B). In other words:
> > > > 
> > > >       1. read_unlock(A) happening depends on write_unlock(B) happening.
> > > >       2. read_unlock(A) happening depends on read_unlock(B) happening.
> > > > 
> > > > T1: write_unlock(B) cannot happen if fair_read_lock(A) is stuck by a A
> > > >     owner not doing either write_unlock(A) or read_unlock(A). In other
> > > >     words:
> > > > 
> > > >       3. write_unlock(B) happening depends on write_unlock(A) happening.
> > > >       4. write_unlock(B) happening depends on read_unlock(A) happening.
> > > > 
> > > > 1, 2, 3 and 4 give the following dependencies:
> > > > 
> > > >     1. read_unlock(A) -> write_unlock(B)
> > > >     2. read_unlock(A) -> read_unlock(B)
> > > >     3. write_unlock(B) -> write_unlock(A)
> > > >     4. write_unlock(B) -> read_unlock(A)
> > > > 
> > > > With 1 and 4, there's a circular dependency so DEPT definitely report
> > > > this as a problem.
> > > > 
> > > > REMIND: DEPT focuses on waits and events.
> > > 
> > > Do you have the test cases showing DEPT can detect this?
> > > 
> > 
> > Just tried the following on your latest GitHub branch, I commented all
> > but one deadlock case. Lockdep CAN detect it but DEPT CANNOT detect it.
> > Feel free to double check.
> 
> I tried the 'queued read lock' test cases with DEPT on. I can see DEPT
> detect and report it. But yeah.. it's too verbose now. It's because DEPT
> is not aware of the test environment so it's just working hard to report
> every case.
> 
> To make DEPT work with the selftest better, some works are needed. I
> will work on it later or you please work on it.
> 
> The corresponding report is the following.
> 
[...]
> [    4.593037] context A's detail
> [    4.593351] ---------------------------------------------------
> [    4.593944] context A
> [    4.594182]     [S] lock(&rwlock_A:0)
> [    4.594577]     [W] lock(&rwlock_B:0)
> [    4.594952]     [E] unlock(&rwlock_A:0)
> [    4.595341] 
> [    4.595501] [S] lock(&rwlock_A:0):
> [    4.595848] [<ffffffff814eb244>] queued_read_lock_hardirq_ER_rE+0xf4/0x170
> [    4.596547] stacktrace:
> [    4.596797]       _raw_read_lock+0xcf/0x110
> [    4.597215]       queued_read_lock_hardirq_ER_rE+0xf4/0x170
> [    4.597766]       dotest+0x30/0x7bc
> [    4.598118]       locking_selftest+0x2c6f/0x2ead
> [    4.598602]       start_kernel+0x5aa/0x6d5
> [    4.599017]       secondary_startup_64_no_verify+0xe0/0xeb
> [    4.599562] 
[...]
> [    4.608427] [<ffffffff814eb3b4>] queued_read_lock_hardirq_RE_Er+0xf4/0x170
> [    4.609113] stacktrace:
> [    4.609366]       _raw_write_lock+0xc3/0xd0
> [    4.609788]       queued_read_lock_hardirq_RE_Er+0xf4/0x170
> [    4.610371]       dotest+0x30/0x7bc
> [    4.610730]       locking_selftest+0x2c41/0x2ead
> [    4.611195]       start_kernel+0x5aa/0x6d5
> [    4.611615]       secondary_startup_64_no_verify+0xe0/0xeb
> [    4.612164] 
> [    4.612325] [W] lock(&rwlock_A:0):
> [    4.612671] [<ffffffff814eb3c0>] queued_read_lock_hardirq_RE_Er+0x100/0x170
> [    4.613369] stacktrace:
> [    4.613622]       _raw_read_lock+0xac/0x110
> [    4.614047]       queued_read_lock_hardirq_RE_Er+0x100/0x170
> [    4.614652]       dotest+0x30/0x7bc
> [    4.615007]       locking_selftest+0x2c41/0x2ead
> [    4.615468]       start_kernel+0x5aa/0x6d5
> [    4.615879]       secondary_startup_64_no_verify+0xe0/0xeb
> [    4.616607] 
[...]

> As I told you, DEPT treats a queued lock as a normal type lock, no
> matter whether it's a read lock. That's why it prints just
> 'lock(&rwlock_A:0)' instead of 'read_lock(&rwlock_A:0)'. If needed, I'm
> gonna change the format.
> 
> I checked the selftest code and found, LOCK(B) is transformed like:
> 
> 	LOCK(B) -> WL(B) -> write_lock(&rwlock_B)
> 
> That's why '&rwlock_B' is printed instead of just 'B', JFYI.
> 

Nah, you output shows that you've run at least both function

	queued_read_lock_hardirq_RE_Er()
	queued_read_lock_hardirq_ER_rE()

but if you apply my diff

	https://lore.kernel.org/lkml/Y8oFj9A19cw3enHB@boqun-archlinux/

you should only run

	queued_read_lock_hardirq_RE_Er()

one test.

One of the reason that DEPT "detect" this is that DEPT doesn't reset
between tests, so old dependencies from previous run get carried over.


> Plus, for your information, you should turn on CONFIG_DEPT to use it.
> 

Yes I turn that config on.

Regards,
Boqun

> 	Byungchul
