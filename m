Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EB1DAFCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETKO3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 06:14:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0CDC061A0E;
        Wed, 20 May 2020 03:14:29 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jbLjZ-0004in-6g; Wed, 20 May 2020 12:13:57 +0200
Date:   Wed, 20 May 2020 12:13:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] radix-tree: Use local_lock for protection
Message-ID: <20200520101357.y4unmdqvztjllqy3@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-3-bigeasy@linutronix.de>
 <20200519204545.GA16070@bombadil.infradead.org>
 <20200519165453.0a795ca1@gandalf.local.home>
 <20200520020516.GB16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200520020516.GB16070@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-05-19 19:05:16 [-0700], Matthew Wilcox wrote:
> >  https://lore.kernel.org/r/20200519201912.1564477-1-bigeasy@linutronix.de
> > 
> > With lore and b4, it should now be easy to get full patch series.
> 
> Thats asking too much of the random people cc'd on random patches.

Well, other complain that they don't care about the other 20 patches
just because one patch affects them. And they can look it up if needed
so you can't make everyone happy.

> What is b4 anyway?

  git://git.kernel.org/pub/scm/utils/b4/b4.git

It is a tool written by Konstantin which can grab a whole series giving
the message-id of one patch in series, save the series as mbox, patch
series and collect all the tags (like replies with acked/tested/…-by)
and fold those tags it into the right patches.

Sebastian
