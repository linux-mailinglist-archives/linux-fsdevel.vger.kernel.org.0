Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27080589495
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 01:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiHCW7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 18:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiHCW7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:59:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45321759F;
        Wed,  3 Aug 2022 15:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 805A3B8227F;
        Wed,  3 Aug 2022 22:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B09C433D6;
        Wed,  3 Aug 2022 22:59:38 +0000 (UTC)
Date:   Wed, 3 Aug 2022 18:59:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git pile 3 - dcache
Message-ID: <20220803185936.228dc690@gandalf.local.home>
In-Reply-To: <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
References: <YurA3aSb4GRr4wlW@ZenIV>
        <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
        <YuruqoGHJONpdZcK@home.goodmis.org>
        <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
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

On Wed, 3 Aug 2022 15:09:23 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Admittedly I think "preempt_enable_under_spinlock()" may be a bit
> *too* cumbersome as a name. It does explain what is going on - and
> both the implementation and the use end up being fairly clear (and the
> non-RT case could have some debug version that actually tests that
> preemption has already been disabled).

	preempt_disable_inlock() ?

-- Steve
