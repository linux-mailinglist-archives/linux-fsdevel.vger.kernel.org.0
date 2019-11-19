Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BF11023BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 13:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKSL74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 06:59:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:43522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSL74 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:59:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DB5FBE03;
        Tue, 19 Nov 2019 11:59:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A9E11E47E5; Tue, 19 Nov 2019 12:59:53 +0100 (CET)
Date:   Tue, 19 Nov 2019 12:59:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Theodore Tso <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH v3] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a
 regular spinlock_t
Message-ID: <20191119115953.GF25605@quack2.suse.cz>
References: <20190820170818.oldsdoumzashhcgh@linutronix.de>
 <20190820171721.GA4949@bombadil.infradead.org>
 <alpine.DEB.2.21.1908201959240.2223@nanos.tec.linutronix.de>
 <20191011112525.7dksg6ixb5c3hxn5@linutronix.de>
 <20191115145638.GA5461@quack2.suse.cz>
 <20191115175420.cotwwz5tmcwvllsq@linutronix.de>
 <20191118093845.GB17319@quack2.suse.cz>
 <20191118132824.rclhrbujqh4b4g4d@linutronix.de>
 <20191119093001.GA25605@quack2.suse.cz>
 <20191119100022.xjvwxwepa4xqcr7q@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119100022.xjvwxwepa4xqcr7q@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-11-19 11:00:22, Sebastian Siewior wrote:
> On 2019-11-19 10:30:01 [+0100], Jan Kara wrote:
> > OK, how do we push this? Do you plan to push this through tip tree?
> 
> Is it reasonable to push this via the ext4 tree?

I don't know and I don't think it largely matters. That code is rarely
touched. Lately changes to that code have been flowing through block tree
(Jens Axboe) or iomap tree (Darrick Wong) because those were the people
needing the changes in...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
