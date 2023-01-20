Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8976B67494F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 03:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjATCYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 21:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATCYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:24:20 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96443A1007;
        Thu, 19 Jan 2023 18:24:19 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id x7so3159076qtv.13;
        Thu, 19 Jan 2023 18:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXmrGuDkn2/Eo83iFxWHgNA7AWXWKN7q1/fDzp0dVyE=;
        b=kDK20ncsOnJblkAwd0Y2Y59cRIL8dXnF51upa4ooOnHX1wQqX5ftBtnDYkiI/Ae06M
         O9EC9eif/MuMYtFZV1lv6hxt1qW/daZXI84Cfd3fVgwCF5++3HWYeNc8a4AQ1Msd2HgR
         0rUk339PKVfWEvaGynHDn/OXou0xTF8O6qWOli6Prs6phF8O6aI9W6ur6Q6wyAXPKq+K
         xksp6hoTxHm8qWWXSfxa68JNytzXV+AXbFHCcrxnkwiKgbOiNlO63r0xUhy3ZES1LXXy
         T2k9wPS8tOQGlrAQ9zTZXi98iBbGK+SxyQx/qM2oV0MH8GgY8jwHy7XC5e+3u9TwTHVK
         vKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXmrGuDkn2/Eo83iFxWHgNA7AWXWKN7q1/fDzp0dVyE=;
        b=eCr5SgwGK5hLoU05JzKZ6U7VzybvimJkQKL58In6G2fYNgZMZ9x9OJj7hcf+WJ5Mka
         w0aln9WtTXwSvjFk9Yq1pPUYDttQHlZ3f8L/9Wq++BzLXoUrMt3WRuvc9nYlN+qJxvJP
         ZSmO//HS6Tc1oogDQbIkdxkaZ+MvZDzCGebyaRdL7KxLYOedUFwLC97c1ZDFN+1jxj0w
         CdyGAic95v83xFB0ZXxahfwsENUKiCGfXCgeceINbJ+D/+nIP0e2owIOzKBhEn9fLoRo
         V0oPSC5xg4hhHRJcJYxA7gYNee21BubmJjP64t8ahBP+7ZeIv7B+CaIZMzHQUK43onBT
         a0oQ==
X-Gm-Message-State: AFqh2kqNmWkkwWpMuZlw0UpGdpAxI4hDkuVsHbXx3Z4zxi1xyaeAWOeo
        gk7Yv+AFG7g8et88YZW7BNFcpF6G1ThqFQ==
X-Google-Smtp-Source: AMrXdXuRJTYkO5Xq8fcDUzUWWm7txooBhHo39gDtPiGOOe5Xv1z+JrHpgHoezV9t7zVStSP5Jqhq1Q==
X-Received: by 2002:ac8:4c8e:0:b0:3b6:4998:67a1 with SMTP id j14-20020ac84c8e000000b003b6499867a1mr12358612qtv.37.1674181458642;
        Thu, 19 Jan 2023 18:24:18 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m20-20020ac866d4000000b003a6a7a20575sm19755088qtp.73.2023.01.19.18.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:24:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7026227C0054;
        Thu, 19 Jan 2023 21:24:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 21:24:17 -0500
X-ME-Sender: <xms:T_vJYzHnHDTMCt8jto_nWcNHcvjGpgV4RvXPMPNFrTftwxZEnGSO0g>
    <xme:T_vJYwWSJg8VNuVpXyE8E2reWX4XQdWPyjlmAe0rSjk1q18okkcj0DuHJBzrJMq-h
    2BHgZrbF3-2z5tXPw>
X-ME-Received: <xmr:T_vJY1ICmQQtrLyW94m-OCcuioCpWG_JQYMNIQrE8vXtpfI-eCbh1FtbvSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:T_vJYxEVt_E7yCBMkNlpdHT5QTmouUaZCHkbiwwgo9SMC9f1ypeHcg>
    <xmx:T_vJY5UC0c1dPYjN1YJ_6DhJnOJXFkqidaO7l8UjxcPRdnOLR2EW0w>
    <xmx:T_vJY8OTkoLcYoXpmUowRiLOhXTP7VGD0CwmQXGUfkwXJRtYYKhXQw>
    <xmx:UfvJYwNwPTJ1_44JcBxyGjDYBTUUeNqEoQQDIfCiiaDhhOipxIQ6KAhvHfQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 21:24:14 -0500 (EST)
Date:   Thu, 19 Jan 2023 18:23:49 -0800
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
Message-ID: <Y8n7NdFl9WEbGXH1@boqun-archlinux>
References: <Y8mZHKJV4FH17vGn@boqun-archlinux>
 <1674179505-26987-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674179505-26987-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:51:45AM +0900, Byungchul Park wrote:
> Boqun wrote:
> > On Thu, Jan 19, 2023 at 01:33:58PM +0000, Matthew Wilcox wrote:
> > > On Thu, Jan 19, 2023 at 03:23:08PM +0900, Byungchul Park wrote:
> > > > Boqun wrote:
> > > > > *Looks like the DEPT dependency graph doesn't handle the
> > > > > fair/unfair readers as lockdep current does. Which bring the
> > > > > next question.
> > > > 
> > > > No. DEPT works better for unfair read. It works based on wait/event. So
> > > > read_lock() is considered a potential wait waiting on write_unlock()
> > > > while write_lock() is considered a potential wait waiting on either
> > > > write_unlock() or read_unlock(). DEPT is working perfect for it.
> > > > 
> > > > For fair read (maybe you meant queued read lock), I think the case
> > > > should be handled in the same way as normal lock. I might get it wrong.
> > > > Please let me know if I miss something.
> > > 
> > > From the lockdep/DEPT point of view, the question is whether:
> > > 
> > >	read_lock(A)
> > >	read_lock(A)
> > > 
> > > can deadlock if a writer comes in between the two acquisitions and
> > > sleeps waiting on A to be released.  A fair lock will block new
> > > readers when a writer is waiting, while an unfair lock will allow
> > > new readers even while a writer is waiting.
> > > 
> > 
> > To be more accurate, a fair reader will wait if there is a writer
> > waiting for other reader (fair or not) to unlock, and an unfair reader
> > won't.
> 
> What a kind guys, both of you! Thanks.
> 
> I asked to check if there are other subtle things than this. Fortunately,
> I already understand what you guys shared.
> 
> > In kernel there are read/write locks that can have both fair and unfair
> > readers (e.g. queued rwlock). Regarding deadlocks,
> > 
> > 	T0		T1		T2
> > 	--		--		--
> > 	fair_read_lock(A);
> > 			write_lock(B);
> > 					write_lock(A);
> > 	write_lock(B);
> > 			unfair_read_lock(A);
> 
> With the DEPT's point of view (let me re-write the scenario):
> 
> 	T0		T1		T2
> 	--		--		--
> 	fair_read_lock(A);
> 			write_lock(B);
> 					write_lock(A);
> 	write_lock(B);
> 			unfair_read_lock(A);
> 	write_unlock(B);
> 	read_unlock(A);
> 			read_unlock(A);
> 			write_unlock(B);
> 					write_unlock(A);
> 
> T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
>     not doing either write_unlock(B) or read_unlock(B). In other words:
> 
>       1. read_unlock(A) happening depends on write_unlock(B) happening.
>       2. read_unlock(A) happening depends on read_unlock(B) happening.
> 
> T1: write_unlock(B) cannot happen if unfair_read_lock(A) is stuck by a A
>     owner not doing write_unlock(A). In other words:
> 
>       3. write_unlock(B) happening depends on write_unlock(A) happening.
> 
> 1, 2 and 3 give the following dependencies:
> 
>     1. read_unlock(A) -> write_unlock(B)
>     2. read_unlock(A) -> read_unlock(B)
>     3. write_unlock(B) -> write_unlock(A)
> 
> There's no circular dependency so it's safe. DEPT doesn't report this.
> 
> > the above is not a deadlock, since T1's unfair reader can "steal" the
> > lock. However the following is a deadlock:
> > 
> > 	T0		T1		T2
> > 	--		--		--
> > 	unfair_read_lock(A);
> > 			write_lock(B);
> > 					write_lock(A);
> > 	write_lock(B);
> > 			fair_read_lock(A);
> > 
> > , since T'1 fair reader will wait.
> 
> With the DEPT's point of view (let me re-write the scenario):
> 
> 	T0		T1		T2
> 	--		--		--
> 	unfair_read_lock(A);
> 			write_lock(B);
> 					write_lock(A);
> 	write_lock(B);
> 			fair_read_lock(A);
> 	write_unlock(B);
> 	read_unlock(A);
> 			read_unlock(A);
> 			write_unlock(B);
> 					write_unlock(A);
> 
> T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
>     not doing either write_unlock(B) or read_unlock(B). In other words:
> 
>       1. read_unlock(A) happening depends on write_unlock(B) happening.
>       2. read_unlock(A) happening depends on read_unlock(B) happening.
> 
> T1: write_unlock(B) cannot happen if fair_read_lock(A) is stuck by a A
>     owner not doing either write_unlock(A) or read_unlock(A). In other
>     words:
> 
>       3. write_unlock(B) happening depends on write_unlock(A) happening.
>       4. write_unlock(B) happening depends on read_unlock(A) happening.
> 
> 1, 2, 3 and 4 give the following dependencies:
> 
>     1. read_unlock(A) -> write_unlock(B)
>     2. read_unlock(A) -> read_unlock(B)
>     3. write_unlock(B) -> write_unlock(A)
>     4. write_unlock(B) -> read_unlock(A)
> 
> With 1 and 4, there's a circular dependency so DEPT definitely report
> this as a problem.
> 
> REMIND: DEPT focuses on waits and events.

Do you have the test cases showing DEPT can detect this?

Regards,
Boqun

> 
> > FWIW, lockdep is able to catch this (figuring out which is deadlock and
> > which is not) since two years ago, plus other trivial deadlock detection
> > for read/write locks. Needless to say, if lib/lock-selftests.c was given
> > a try, one could find it out on one's own.
> > 
> > Regards,
> > Boqun
> > 
