Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD77E1FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfHASMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 14:12:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbfHASMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:12:55 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htFYi-0006nw-Cj; Thu, 01 Aug 2019 20:12:12 +0200
Date:   Thu, 1 Aug 2019 20:12:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kara <jack@suse.cz>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        Theodore Tso <tytso@mit.edu>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>, linux-ext4@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 6/7] fs/jbd2: Make state lock a spinlock
In-Reply-To: <20190801175703.GH25064@quack2.suse.cz>
Message-ID: <alpine.DEB.2.21.1908012010020.1789@nanos.tec.linutronix.de>
References: <20190801010126.245731659@linutronix.de> <20190801010944.457499601@linutronix.de> <20190801175703.GH25064@quack2.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 1 Aug 2019, Jan Kara wrote:
> On Thu 01-08-19 03:01:32, Thomas Gleixner wrote:
> > As almost all functions which use this lock have a journal head pointer
> > readily available, it makes more sense to remove the lock helper inlines
> > and write out spin_*lock() at all call sites.
> > 
> 
> Just a heads up that I didn't miss this patch. Just it has some bugs and I
> figured that rather than explaining to you subtleties of jh lifetime it is
> easier to fix up the problems myself since you're probably not keen on
> becoming jbd2 developer ;)... which was more complex than I thought so I'm
> not completely done yet. Hopefuly tomorrow.

I'm curious where I was too naive :)

Thanks for having a look!

       tglx
