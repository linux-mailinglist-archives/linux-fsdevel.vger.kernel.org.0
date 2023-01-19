Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5240F6742C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 20:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjAST0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 14:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjASTZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:25:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDC530ED;
        Thu, 19 Jan 2023 11:25:45 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s4so2378091qtx.6;
        Thu, 19 Jan 2023 11:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xamYJZSiEPy9Mjo2njH+JPn5/UHZCpsx0WYfjjoyGiY=;
        b=MrwOCC5ehcze1hpMjcT+s1KhKEgcE4YPuq3yqI1Cm5uRCIw1PUevaLEC6XkTcNhbT9
         Zw0OvgbmLEFdn1tUM2fjgufvEQCRxf9F5A/ADdKpwTfdOwWf/0FqKiy1RuuQeUDtT2r1
         WOQNX4WCd5xldt11cYOVTcAYa8grKYNOtlZuJLBY7Hqr8xr25RNCaSO7DWHMR1iJ2wZ4
         jILLDKWwZP8GiSLOga1KZkHZ1Quhj6gfAe4Q0cx1AezAz9Aw7s1aRjjoXenbgYqQO8nm
         QgeiFuARK8oNcrVywEUZQ78eB39jl9apcTRWslHRMXoRBD4K3HuCxamntvSxOTPxK4uE
         BODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xamYJZSiEPy9Mjo2njH+JPn5/UHZCpsx0WYfjjoyGiY=;
        b=tq+trOZ8NniRqlPpQ7ZVgULWMFj+94r3w+jkwm10HiVyr9mcUrJ1zM7eWM1RuvhA+J
         AyiD9Sa8Ldoz3wvlkRJkMH9300p0A/e0MFDMlnGHARDj/0+DlKPcagJ5bXYiWHSt+kzX
         PzMqIrIfRaPSrIXqtFGORt3MQ0WHbSNtmF4LMbsuAJYlmZD9OwNT4f8fKb18oTh4XFjI
         p87Dhz2pBuiTEuikcF4jj+o4nmt75pbcPai2AjYAgD/AVjjWH2aci8Nig3JnN4brCfTV
         Q89Kvvr62SK2CBdPhcxuKwgF2m7EKkdczO1pXLHPt2HOiJiOQeJZ5LlARTOz29kyPn8A
         SKJg==
X-Gm-Message-State: AFqh2ko8vWAYA3M0ykHLj3EZ8kOcTjd2Gh/vh+wqy610HCTwbnbroTIh
        9iKSTNRumdPDf0csLzDAu+SmksT/kbk=
X-Google-Smtp-Source: AMrXdXv6/5PtZaK3QzptagCsxzBPPETPDBX9eIEhj7kPWY4WuBsc33JbZzxeaNRbDyw281mOZy4DMg==
X-Received: by 2002:ac8:4446:0:b0:3b6:377b:e05c with SMTP id m6-20020ac84446000000b003b6377be05cmr12291034qtn.47.1674156344292;
        Thu, 19 Jan 2023 11:25:44 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ej4-20020a05622a4f8400b003b693fe4427sm727836qtb.90.2023.01.19.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:25:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 20B2C27C0054;
        Thu, 19 Jan 2023 14:25:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 14:25:43 -0500
X-ME-Sender: <xms:NZnJYwTxwYLfh8N7togMMPPYVeKdqLNSU6cBkqgYw1MVfb1Q7g283w>
    <xme:NZnJY9xSw9qvXrrAIJEbpvx12Y2TyP_RnRTmtBw-y1f1OYtEkrBMU_4YXAozbQqOh
    zbQZ0y4tj_ONrG2QQ>
X-ME-Received: <xmr:NZnJY91HzMP2Iy60XcV_ZcT4yKf2IQY3ocx0fpLzHGwRF2CeF0X43zzN0DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:NZnJY0CTKhGEBWy1veKc6w2hVzbwm1Rf2uZ1Xsyyk9_pC7SbEHDNOw>
    <xmx:NZnJY5j2rwpIuu1Rn9fBKWIyoQvQrI42uB43xg7d0VHM2TJ04SwWGA>
    <xmx:NZnJYworf0mYeiLAkASjr3os2e8ECpvW0MlaGgzHEya6_0aWJpdS2A>
    <xmx:NpnJY464YDfl0tqd71pt0eI__JWNhiE-bQVw-oxLk6HFFui_uQOFPuiI1T8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 14:25:40 -0500 (EST)
Date:   Thu, 19 Jan 2023 11:25:16 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        david@fromorbit.com, amir73il@gmail.com,
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
Message-ID: <Y8mZHKJV4FH17vGn@boqun-archlinux>
References: <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
 <1674109388-6663-1-git-send-email-byungchul.park@lge.com>
 <Y8lGxkBrls6qQOdM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lGxkBrls6qQOdM@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:33:58PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 19, 2023 at 03:23:08PM +0900, Byungchul Park wrote:
> > Boqun wrote:
> > > *	Looks like the DEPT dependency graph doesn't handle the
> > > 	fair/unfair readers as lockdep current does. Which bring the
> > > 	next question.
> > 
> > No. DEPT works better for unfair read. It works based on wait/event. So
> > read_lock() is considered a potential wait waiting on write_unlock()
> > while write_lock() is considered a potential wait waiting on either
> > write_unlock() or read_unlock(). DEPT is working perfect for it.
> > 
> > For fair read (maybe you meant queued read lock), I think the case
> > should be handled in the same way as normal lock. I might get it wrong.
> > Please let me know if I miss something.
> 
> From the lockdep/DEPT point of view, the question is whether:
> 
> 	read_lock(A)
> 	read_lock(A)
> 
> can deadlock if a writer comes in between the two acquisitions and
> sleeps waiting on A to be released.  A fair lock will block new
> readers when a writer is waiting, while an unfair lock will allow
> new readers even while a writer is waiting.
> 

To be more accurate, a fair reader will wait if there is a writer
waiting for other reader (fair or not) to unlock, and an unfair reader
won't.

In kernel there are read/write locks that can have both fair and unfair
readers (e.g. queued rwlock). Regarding deadlocks,

	T0		T1		T2
	--		--		--
	fair_read_lock(A);
			write_lock(B);
					write_lock(A);
	write_lock(B);
			unfair_read_lock(A);

the above is not a deadlock, since T1's unfair reader can "steal" the
lock. However the following is a deadlock:

	T0		T1		T2
	--		--		--
	unfair_read_lock(A);
			write_lock(B);
					write_lock(A);
	write_lock(B);
			fair_read_lock(A);

, since T'1 fair reader will wait.

FWIW, lockdep is able to catch this (figuring out which is deadlock and
which is not) since two years ago, plus other trivial deadlock detection
for read/write locks. Needless to say, if lib/lock-selftests.c was given
a try, one could find it out on one's own.

Regards,
Boqun
