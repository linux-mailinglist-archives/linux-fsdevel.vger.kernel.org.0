Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643A17C283
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 17:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCFQFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 11:05:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFQFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MCy5PVJA1LqfKEGKug6+vwwbKtmwegQjfwoCyvkuwpg=; b=YPnYkRwDxrIY7aX9Pks8yzBxq8
        2348RSs0mYLJsknXKpJTxWp8tX7StRZl7C8HbKylSHWCgB8HeeOUo9jFtPvxq2UkO2JUmqj6ghf2R
        cahDTKExYXg1h9VGurYFzeIOmKPvviU7iP7w2iQE9LHZi7libyjGMoFuBSGNA5ZX2W/WuEvMnf+vD
        8Y2kvUZb605fCj00Z+BdWy0ilh6SFMwAIOgcbAVsFg9LgyFgI5/ndujzni7Pp1OgqXTRHul3429mh
        ur363T6Ba+MObKLhB3NEV+CUgrHEmYhYpISEn99BgOTQ1J9QWw49qA/2IsQ7qS3rjuvDbfFvzg7bV
        pT8C57Qw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAFTw-0004mS-Jr; Fri, 06 Mar 2020 16:05:48 +0000
Date:   Fri, 6 Mar 2020 08:05:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200306160548.GB25710@bombadil.infradead.org>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:35:41AM -0500, Josef Bacik wrote:
> [a lot of stuff I agree with]

> 4) Presentations.  90% of the conference is 1-2 people standing at the front
> of the room, talking to a room of 20-100 people, with only a few people in
> the audience who cares.  We do our best to curate the presentations so we're
> not wasting peoples time, but in the end I don't care what David Howells is
> doing with mount, I trust him to do the right thing and he really just needs
> to trap Viro in a room to work it out, he doesn't need all of us.

... and allow the other 3-5 people who're interested or affected the
opportunity to sit in.  Like a mailing list, but higher bandwidth.

> So what do I propose?  I propose we kill LSFMMBPF.

I come not to bury LSFMMBPF but to reform it.

As Jason noted, Plumbers is already oversubscribed.  I think having two
Plumbers conferences per year (one spring, one autumn), preferably on
two different continents, would make a lot of sense.

Here's my proposal, and obviously I'm not seeking _permission_ to do
this, but constructive feedback would be useful.

1. Engage an event organiser to manage the whole thing.  I have a friend
who recently took up event organising as her full-time job, and I've
started talking to her about this.  It's a rather different skill-set
from writing kernel patches.

2. Charge attendees $300 for a 3-day conference.  This seems to be the
going rate (eg BSDCan, PGCon).  This allows the conference to be self-
funding without sponsors, and any sponsorship can go towards evening
events, food, travel bursaries, etc.

3. Delegate organising the sessions to the track chairs.  Maybe get rid
of shared sessions altogether -- while there are plenty of times where
"I need fs and mm people in the room", it's rarely "I need everybody in
the room", and scheduling BOFs opposite such a general session would be
a good use of peoples time.

