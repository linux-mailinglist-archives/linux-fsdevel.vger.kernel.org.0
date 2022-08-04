Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D24589A96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiHDKwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 06:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiHDKwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:52:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F6649B4D;
        Thu,  4 Aug 2022 03:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69190B824E4;
        Thu,  4 Aug 2022 10:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F164C433D7;
        Thu,  4 Aug 2022 10:52:25 +0000 (UTC)
Date:   Thu, 4 Aug 2022 06:52:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <20220804065223.209ac060@gandalf.local.home>
In-Reply-To: <CAHk-=wiMFU1+pyG9AgbGSZfxNpoOzOEmjVyy87J6Q8aPKAJ7jQ@mail.gmail.com>
References: <YurA3aSb4GRr4wlW@ZenIV>
        <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
        <YuruqoGHJONpdZcK@home.goodmis.org>
        <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
        <20220803185936.228dc690@gandalf.local.home>
        <YusDmF39ykDmfSkF@casper.infradead.org>
        <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
        <YusV8cr382PeBNLM@casper.infradead.org>
        <20220803213255.3ab719e3@gandalf.local.home>
        <CAHk-=wiMFU1+pyG9AgbGSZfxNpoOzOEmjVyy87J6Q8aPKAJ7jQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 Aug 2022 19:16:12 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > I wonder if raw_preempt_disable() would be another name to use?  
> 
> NO!
> 
> The point is that normal non-RT code does *not* disable preemption at
> all, because it is already disabled thanks to the earlier spinlock.
> 
> So we definitely do *not* want to call this "raw_preempt_disable()",
> because it's actually not supposed to normally disable anything at
> all. Only for RT, where the spinlock code doesn't do it.

Yeah, I'm just brainstorming ideas on what we could use to make that name a
little shorter, and I'm not coming up with much.

OK, I'm becoming colorblind with this shed.

-- Steve
