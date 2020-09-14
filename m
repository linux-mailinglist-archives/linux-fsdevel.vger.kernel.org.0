Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D03268878
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgINJdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 05:33:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgINJdJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:33:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC4B1AE85;
        Mon, 14 Sep 2020 09:33:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BC1581E12EF; Mon, 14 Sep 2020 11:33:03 +0200 (CEST)
Date:   Mon, 14 Sep 2020 11:33:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200914093303.GA7347@quack2.suse.cz>
References: <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
 <c1970d94-52c7-5b8b-bf35-42f285ae6a3d@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1970d94-52c7-5b8b-bf35-42f285ae6a3d@ime.usp.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 12-09-20 17:32:41, Rogério Brito wrote:
> Now, to the subject: is this that you describe (RCU or VFS), in some sense,
> related to, say, copying a "big" file (e.g., a movie) to a "slow" media (in
> my case, a USB thumb drive, so that I can watch said movie on my TV)?
> 
> I've seen backtraces mentioning "task xxx hung for yyy seconds" and a
> non-reponsive cp process at that... I say RCU or VFS because I see this
> with the thumb drives with vfat filesystems (so, it wouldn't be quite
> related to ext4, apart from the fact that all my Linux-specific
> filesystems are ext4).

This is very likely completely different problem. I'd need to see exact
messages and kernel traces but usually errors like these happen when the IO
is very slow and other things (such as grabbing some locks or doing memory
allocation) get blocked waiting for that IO.

In the case Linus speaks about this is really more about CPU bound tasks
that heavily hammer the same cached contents.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
