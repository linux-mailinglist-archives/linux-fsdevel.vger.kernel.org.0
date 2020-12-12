Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2152D88A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407688AbgLLRav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 12:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLLRak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 12:30:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F30C0613CF;
        Sat, 12 Dec 2020 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OS3WrB4ugpp1U/aXEmCX3ul3flmQslrlc4KkVZvbGZg=; b=EXmO+rQ0GyMYewmeVqsVxUEeQP
        gpCAq5CzMPaK7QNb2aHIaQGMqVK4u0GvMCFCKXISPdeKE0T2oJRgsn47/LIByR4IdqRiGI47snIwR
        FVagUbAnrOvRIrzTdSjI+8MJkYRBnoS1LDvOc5GTbVhSuByBd5st374mkzApcbKteaXOiMusRw+H6
        U/XnQ4s6ELZ7SLGPtTwomKyBtinZlQX2wsnO3aetNEfWfCtoIdhPnpzrMZnOwlK+O760mW5Lvnve3
        V1Khqe0pu2p4juqZnRrA1lIu/sUam7A1o4/Fwm3Mpvj7I31/CFuQa7ppyK8Nnc5bMYkRjIlksrvwI
        gHmsVcQw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ko8iT-0003a2-Qm; Sat, 12 Dec 2020 17:29:57 +0000
Date:   Sat, 12 Dec 2020 17:29:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvme@vger.kernel.org" <linux-nvme@vger.kernel.org>
Subject: Re: [LSFMMBPF 2021] A status update
Message-ID: <20201212172957.GE2443@casper.infradead.org>
References: <fd5264ac-c84d-e1d4-01e2-62b9c05af892@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd5264ac-c84d-e1d4-01e2-62b9c05af892@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04, 2020 at 10:48:53AM -0500, Josef Bacik wrote:
> We on the program committee hope everybody has been able to stay safe and
> healthy during this challenging time, and look forward to being able to see
> all of you in person again when it is safe.
> 
> The current plans for LSFMMBPF 2021 are to schedule an in person conference
> in H2 (after June) of 2021.  The tentative plan is to use the same hotel
> that we had planned to use for 2020, as we still have contracts with them.
> However clearly that is not set in stone.  The Linux Foundation has done a
> wonderful job of working with us to formulate a plan and figure out the
> logistics that will work the best for everybody, I really can't thank them
> enough for their help.

Thank you all for doing your best in the face of this disruption.  I
really appreciate all the work you're putting in, and I can't wait to
see you all again in person.

I hosted a Zoom call yesterday on the topic of Page Folios, and uploaded
the video.  There was interest expressed in the call on doing a follow-up
call on the topic of GUP (get_user_pages and friends).  It would probably
also be good to have meetings on other topics.

I don't want this to be seen in any way as taking away from LSFMMBPF.
I see Zoom calls as an interim solution to not having face-to-face
meetings.

I'd like to solicit feedback from this group on:

 - Time of day.  There is no good time that suits everyone around
   the world.  With developers in basically every inhabited time zone, the
   call will definitely take place in the middle of somebody's night, and
   during somebody else's normal family time.  Publishing the recordings
   helps ameliorate some of this, but I feel we should shift the time
   around.  Having it at the same time of day helps people fit it into
   their schedule of other meetings (and meals), but I think the benefits
   of allowing more people to participate live outweighs the costs.
 - Schedule.  Friday's probably a bad day to have it, as it ends up
   being Saturday for some people.  It can move around the week too.
   Also, probably wise to not have it over Christmas as most developers
   have that period as family time.
 - Topics.  I'm sure there's no shortage of things to discuss!  I'm
   happy to organise meetings for people even on topics I have no direct
   interest in.

And most urgently, when should we have the GUP meeting?  On the call,
I suggested Friday the 8th of January, but I'm happy to set something
up for next week if we'd like to talk more urgently.  Please propose a
date & time.  I know we have people in Portugal and Nova Scotia who need
to be involved live, so a time friendly to UTC+0 and UTC-4 would be good.

Thanks!
