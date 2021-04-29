Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C442936E3A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 05:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhD2DWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 23:22:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55396 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229805AbhD2DWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:22:00 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13T3Kvh8028190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 23:20:59 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 78C8115C39C4; Wed, 28 Apr 2021 23:20:57 -0400 (EDT)
Date:   Wed, 28 Apr 2021 23:20:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, pakki001@umn.edu,
        gregkh@linuxfoundation.org, arnd@arndb.de
Subject: Re: [PATCH] ics932s401: fix broken handling of errors when word
 reading fails
Message-ID: <YIomGeKBiGr95aJB@mit.edu>
References: <20210428222534.GJ3122264@magnolia>
 <20210428224624.GD1847222@casper.infradead.org>
 <20210429010351.GI1251862@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429010351.GI1251862@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 06:03:51PM -0700, Darrick J. Wong wrote:
> I had half expected them all to get reverted immediately, but since 5.12
> went out with this still included, I thought it worth pointing out that
> despite UMN claims that none of their junk patches made it to Linus,
> this (mostly benign) one did.  Granted, maybe 18 Jan 2019 was earlier
> than that, but who knows and who cares? :P

The claim was none of their "hypocrite commits" made it to Linus.
That said nothing about any of their other patches that had been
developed using some of their other research efforts.

Greg isn't planning on sending any of the reverts until the 5.13 merge
window, after doing a lot of reviews to determine which of the 190
commits were actually incorrect, and of those, how many may have
actually introduced security vulnerabilities.  "Good faith hypocrite
commits", if you will.  (Hey, we're all human; I know I've sent my
share of buggy commits where I unintentionally introduced a bug.  :-)

If they can look at the buggy-yet-accepted commits, and map them to
the research efforts in their previous papers, and then do feature
analysis on the bad commits, maybe it will be possible for them to
rework their "hypocrite commit" paper, and perhaps give us some
insights about how to better find buggy commits in our code reviews
--- that is, besides "try harder" and changing the Code of Conduct to
prohibit intentionally introducing bugs (as they had proposed in their
now-withdrawn paper).

Also of interest is of the 68 UMN commits that did not cleanly revert;
it may have been because they were incorrect, but were later fixed
and/or reverted.  In which case, we can probably learn about how long
it takes for problems introduced by "good faith hypocrite commits" to
get fixed naturally, without needing to do an emergency code review of
all UMN patches sent in the past three years or so.

						- Ted
