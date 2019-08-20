Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DA996748
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfHTRRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 13:17:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTRRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:17:12 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i07kO-0003dS-KN; Tue, 20 Aug 2019 19:16:40 +0200
Date:   Tue, 20 Aug 2019 19:16:40 +0200
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 0/7] fs: Substitute bit-spinlocks for PREEMPT_RT and
 debugging
Message-ID: <20190820171640.elgrbetjivvk7zti@linutronix.de>
References: <20190801010126.245731659@linutronix.de>
 <20190802075612.GA20962@infradead.org>
 <alpine.DEB.2.21.1908021107090.2285@nanos.tec.linutronix.de>
 <20190806061119.GA17492@infradead.org>
 <alpine.DEB.2.21.1908080858460.2882@nanos.tec.linutronix.de>
 <20190808072807.GA25259@infradead.org>
 <alpine.DEB.2.21.1908080953170.2882@nanos.tec.linutronix.de>
 <20190810081834.GB30426@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190810081834.GB30426@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-08-10 01:18:34 [-0700], Christoph Hellwig wrote:
> > > Does SLUB work on -rt at all?
> > 
> > It's the only allocator we support with a few tweaks :)
> 
> What do you do about this particular piece of code there?

This part remains untouched. This "lock" is acquired within ->list_lock
which is a raw_spinlock_t and disables preemption/interrupts on -RT.

Sebastian
