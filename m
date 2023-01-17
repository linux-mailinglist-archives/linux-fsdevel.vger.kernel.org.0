Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3948166E689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjAQTE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 14:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjAQS7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:59:47 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF510A97;
        Tue, 17 Jan 2023 10:18:56 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id l185so12014232vke.2;
        Tue, 17 Jan 2023 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2US1+cWQFyCqkm5gKb2Imr+dyizxQQ6oWxz42m5c2U=;
        b=QOQZ9L6N6v89yP61QhODEIyBSxsPTBrfKXtHZgwBntOCl5ljk7i4UY0j9I1YrcUxWc
         ub2W9V1gWuQMcIwfl0IJJbHn1UFH1WToeORRalBsyw1US3hfGRcdzofEgLfuW92aVI+5
         PwhM+jtdgnlG4zrB2uHd/qblDBP59zJAwi1i4Amb8XssPk7p0eUTutXWGl/G6u2TjIo6
         baTo1PEGYQNLRS/k3y5NFaea9lAc9EJOtVg22tc04ALD7s2fItXi5fUFMvdqQRPYj4gL
         jrseFJqAAtFnNlDPqUevWkUie1GRsm1SONzlKxD3LY+STVP5fKzHr11q1El/ogronKmz
         +G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2US1+cWQFyCqkm5gKb2Imr+dyizxQQ6oWxz42m5c2U=;
        b=1UaebWMPoRAsHcKv6557qzdWD18gNLd5j3Hdbhk3zQsrJs7ywYVV7cX20kRKHDc385
         e6kJug3UmG6ARNY3IgiyOGhCuq04hPPO9ei8iHXMMs2s4BD63CXYI/tngBStdkk4jC3k
         hVoavQvTjJvN2vtPVmhob7tGUzWb2fvNuFnV9lTSTIzcBJfWtxGgfDOCkvfyNCepxqD2
         elM2Xok4nXYXFK7XwRJ2dcx1KshyUyNAbxMAjBWEVHAwd6tx8ksMdbneVX8kGYW70PpG
         x1uxDIcMHeyeKbIP9sFrR39Ivq99awkEiu9HTeOESeGi/pi86kWsXXCvJofjtPcqTMt6
         xUHQ==
X-Gm-Message-State: AFqh2kr0lbYMG6pP8/Di49d+HGXPBWLCgNnfwwe8sSB8hNeaV/o4cAhO
        1iw+Mha1sIDvehGequYhpNqQOLHzjn5QeA==
X-Google-Smtp-Source: AMrXdXuecM6TMvZUe2LrmDRIr7NaeTlmuaQwsyy+ICsvZ8NkCU/D0oFzBl18C0uumNZrYLaNk1TvJA==
X-Received: by 2002:a1f:26c8:0:b0:3d8:d594:58e3 with SMTP id m191-20020a1f26c8000000b003d8d59458e3mr13683689vkm.14.1673979535694;
        Tue, 17 Jan 2023 10:18:55 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05622a1bab00b003a5c6ad428asm1218943qtb.92.2023.01.17.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:18:54 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 175C227C0054;
        Tue, 17 Jan 2023 13:18:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 17 Jan 2023 13:18:54 -0500
X-ME-Sender: <xms:i-bGY-9E-mdJVWX4CCVeei-14Vfb5RM2bcefYAEY9jwujyAQLuat9A>
    <xme:i-bGY-svyDVjSENnZ4SYmye9MHEwAc_xdmBCugrRgiIhupK8t0XJHANZqE2XS0HWX
    FpMruCHrdoK16v3nw>
X-ME-Received: <xmr:i-bGY0DhTa8VmWDhetI1q1U1WNpJSFZDda6XC60Ija7SMvOXij7igrtiPxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeeg
    vddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:i-bGY2fUawivGHAWm6LLeaxzKnn5qemkPlKYx612rxwWBBv2e4x76w>
    <xmx:i-bGYzO-9dNabAYWURztzdQoTUyDu19pqteWeMRsf0ysGOocee_9Lw>
    <xmx:i-bGYwlqbhoDstgPUi4Gv8RjGKqizzlTMulosaLuOcD6kHFgVW66eA>
    <xmx:jebGY20d10aTWJlV5fAGRmnugZO0WqcRtaEBaGcyqdUXbdjlcOmh6i2i0g8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 13:18:51 -0500 (EST)
Date:   Tue, 17 Jan 2023 10:18:33 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Message-ID: <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
 <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Waiman]

On Mon, Jan 16, 2023 at 10:00:52AM -0800, Linus Torvalds wrote:
> [ Back from travel, so trying to make sense of this series.. ]
> 
> On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
> >
> > I've been developing a tool for detecting deadlock possibilities by
> > tracking wait/event rather than lock(?) acquisition order to try to
> > cover all synchonization machanisms. It's done on v6.2-rc2.
> 
> Ugh. I hate how this adds random patterns like
> 
>         if (timeout == MAX_SCHEDULE_TIMEOUT)
>                 sdt_might_sleep_strong(NULL);
>         else
>                 sdt_might_sleep_strong_timeout(NULL);
>    ...
>         sdt_might_sleep_finish();
> 
> to various places, it seems so very odd and unmaintainable.
> 
> I also recall this giving a fair amount of false positives, are they all fixed?
> 

From the following part in the cover letter, I guess the answer is no?

	...
        6. Multiple reports are allowed.
        7. Deduplication control on multiple reports.
        8. Withstand false positives thanks to 6.
	...

seems to me that the logic is since DEPT allows multiple reports so that
false positives are fitlerable by users?

> Anyway, I'd really like the lockdep people to comment and be involved.

I never get Cced, so I'm unware of this for a long time...

A few comments after a quick look:

*	Looks like the DEPT dependency graph doesn't handle the
	fair/unfair readers as lockdep current does. Which bring the
	next question.

*	Can DEPT pass all the selftests of lockdep in
	lib/locking-selftests.c?

*	Instead of introducing a brand new detector/dependency tracker,
	could we first improve the lockdep's dependency tracker? I think
	Byungchul also agrees that DEPT and lockdep should share the
	same dependency tracker and the benefit of improving the
	existing one is that we can always use the self test to catch
	any regression. Thoughts?

Actually the above sugguest is just to revert revert cross-release
without exposing any annotation, which I think is more practical to
review and test.

I'd sugguest we 1) first improve the lockdep dependency tracker with
wait/event in mind and then 2) introduce wait related annotation so that
users can use, and then 3) look for practical ways to resolve false
positives/multi reports with the help of users, if all goes well,
4) make it all operation annotated.

Thoughts?

Regards,
Boqun

> We did have a fairly recent case of "lockdep doesn't track page lock
> dependencies because it fundamentally cannot" issue, so DEPT might fix
> those kinds of missing dependency analysis. See
> 
>     https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/
> 
> for some context to that one, but at teh same time I would *really*
> want the lockdep people more involved and acking this work.
> 
> Maybe I missed the email where you reported on things DEPT has found
> (and on the lack of false positives)?
> 
>                Linus
> 
