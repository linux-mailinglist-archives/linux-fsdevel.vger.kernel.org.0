Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4991F7114
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFKXzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 19:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgFKXzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:55:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8360CC08C5C1;
        Thu, 11 Jun 2020 16:55:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g28so7458694qkl.0;
        Thu, 11 Jun 2020 16:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F5v636w1U2r9faKtpDeWzBpWJiuE/GmNaYKlismlA8U=;
        b=HyPFX0Dbl/lvpUQZOju2xEIns4jas8JFofOmGF46iajecbOcOMCerAYq/cbCcrvLNw
         K4pktP2zZl5zFZSJjFEWXEp8owkTrkL/Fz0zgce2JkQ8bWJPDhu5h9uhmRP9VSMStnL3
         QHzB7pNv3q9ppH7YH66NKNUHiROeAjCeR6BzyK5KGPOwaqgk4BMqqD6n5w2cpsqPLz20
         vENNadkxflli0r1TtyWD89BmvN56PhouGxLPYFfpZG1dgTDFgiw5SuQqpB+UacB7RzYI
         PWgIY3c/9I7eUUnXZRVj8ZxD4+2cq0xHNsAZ3LX2Ir+jGFZ/Zn0b/AQyzvkUVBp154cw
         +PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F5v636w1U2r9faKtpDeWzBpWJiuE/GmNaYKlismlA8U=;
        b=s67JQxetp4+QdKLGj3/Xeh84nIz/eXE3b7vqzdb00Rhm/LptfFCMRFgL3ivgNc9vUj
         AuTbf7H2WJM4j/KBIVcBWjLxF0TTCc10IBtvZZgV+Racv5o2UMbfvCc7r1/RlQgJ9Sa2
         WKHY91amoBziTV88mVrQJtD6r/LNpqEXAXGNbIEO5KNvpnPyfcMSnHfli1duTd5FdlHf
         hq1WeF4IaSt1HJwBpA2C3PL+p/u2T9Or/uzm6MpO+ZZe+SYbekSppe84meZ1gMsf+sWi
         iG4qK/CxQryEsH44SGgdzK7XR0DkJBZ5otI1quQYFcUGqfH7sk4dTJVrMe5eJSI6IsXA
         kuEw==
X-Gm-Message-State: AOAM53246v0pWTNQJaT80ABUaPOiM0XSSn8/INm7+M2RJ/guw0v6GwJO
        gVc2AOAWFwJYf4MOhOOHUvQ=
X-Google-Smtp-Source: ABdhPJxCOrnRf8nwSUdwmtMf/rNeZwmr77UMJdROHZPgjMCqlypfCoJaxxWEnO5jkLoK/YqVG3jC2g==
X-Received: by 2002:a37:a7c5:: with SMTP id q188mr492287qke.384.1591919738575;
        Thu, 11 Jun 2020 16:55:38 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q32sm3859272qtf.36.2020.06.11.16.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 16:55:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 339CB27C0054;
        Thu, 11 Jun 2020 19:55:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Jun 2020 19:55:36 -0400
X-ME-Sender: <xms:b8TiXjdZZ4Whi3jp7-wUgmKt6dvRH52VirY_52Zwz9JKIqOWK7s9Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeitddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduud
    durdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:b8TiXpOC0t-CX5R13OqK3l6eVl1IwaDANwjDfZGQec9tu6tDhjg-4A>
    <xmx:b8TiXsgC1j4rj4iHTxZEzCW2qOaYtl3QOCheHGKf3x3969WhFE1lGg>
    <xmx:b8TiXk9L4kwY0kTu-Ug1YaqZqTU8qZPOOpeqNkmMynhlOogtvHqFig>
    <xmx:eMTiXjBMfBoZmvXPo3IDNoIf4Skm7XgWifSDGFzNUyoeBpLZxKbGleum4go>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4AB2D3060FE7;
        Thu, 11 Jun 2020 19:55:27 -0400 (EDT)
Date:   Fri, 12 Jun 2020 07:55:26 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in send_sigio
Message-ID: <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <000000000000760d0705a270ad0c@google.com>
 <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
 <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter and Waiman,

On Thu, Jun 11, 2020 at 12:09:59PM -0400, Waiman Long wrote:
> On 6/11/20 10:22 AM, Peter Zijlstra wrote:
> > On Thu, Jun 11, 2020 at 09:51:29AM -0400, Waiman Long wrote:
> > 
> > > There was an old lockdep patch that I think may address the issue, but was
> > > not merged at the time. I will need to dig it out and see if it can be
> > > adapted to work in the current kernel. It may take some time.
> > Boqun was working on that; I can't remember what happened, but ISTR it
> > was shaping up nice.
> > 
> Yes, I am talking about Boqun's patch. However, I think he had moved to
> another company and so may not be able to actively work on that again.
> 

I think you are talking about the rescursive read deadlock detection
patchset:

	https://lore.kernel.org/lkml/20180411135110.9217-1-boqun.feng@gmail.com/

Let me have a good and send a new version based on today's master of tip
tree.

Regards,
Boqun

> Cheers,
> Longman
> 
