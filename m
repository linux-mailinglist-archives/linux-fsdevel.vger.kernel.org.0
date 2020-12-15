Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE572DAD28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgLOMYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:50546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbgLOMX5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:23:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608034987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LVHe81L5kggyWP1RUBaaKdbh2RBhNq1dLDe245ww7OI=;
        b=JnwID1lkt4ZofyQde3z42HCbAMxFv4+ftC7ZsaAR9kh9uWdn0kL9KUZmF3ybn/gbDjmuVb
        BGdmWTrChwZTZkkeS1yBHee+xr55Aw19wjFkTSFIn6q7daOAQyN5VX1YFuumMJvvHGFKXx
        YOA7nV54vj1v7JMRy8JKB/G5LGqGFGc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C856EAE66;
        Tue, 15 Dec 2020 12:23:07 +0000 (UTC)
Date:   Tue, 15 Dec 2020 13:23:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
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
Message-ID: <20201215122307.GN32193@dhcp22.suse.cz>
References: <fd5264ac-c84d-e1d4-01e2-62b9c05af892@toxicpanda.com>
 <20201212172957.GE2443@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212172957.GE2443@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 12-12-20 17:29:57, Matthew Wilcox wrote:
> On Fri, Dec 04, 2020 at 10:48:53AM -0500, Josef Bacik wrote:
> > We on the program committee hope everybody has been able to stay safe and
> > healthy during this challenging time, and look forward to being able to see
> > all of you in person again when it is safe.
> > 
> > The current plans for LSFMMBPF 2021 are to schedule an in person conference
> > in H2 (after June) of 2021.  The tentative plan is to use the same hotel
> > that we had planned to use for 2020, as we still have contracts with them.
> > However clearly that is not set in stone.  The Linux Foundation has done a
> > wonderful job of working with us to formulate a plan and figure out the
> > logistics that will work the best for everybody, I really can't thank them
> > enough for their help.
> 
> Thank you all for doing your best in the face of this disruption.  I
> really appreciate all the work you're putting in, and I can't wait to
> see you all again in person.
> 
> I hosted a Zoom call yesterday on the topic of Page Folios, and uploaded
> the video.

Thanks for organizing this. I couldn't attent directly but I have
watched the video. I think this was a useful meeting.

> There was interest expressed in the call on doing a follow-up
> call on the topic of GUP (get_user_pages and friends).  It would probably
> also be good to have meetings on other topics.

I hope I will have time to join this one.

> I don't want this to be seen in any way as taking away from LSFMMBPF.
> I see Zoom calls as an interim solution to not having face-to-face
> meetings.

Agreed!

> I'd like to solicit feedback from this group on:
> 
>  - Time of day.  There is no good time that suits everyone around
>    the world.  With developers in basically every inhabited time zone, the
>    call will definitely take place in the middle of somebody's night, and
>    during somebody else's normal family time.  Publishing the recordings
>    helps ameliorate some of this, but I feel we should shift the time
>    around.  Having it at the same time of day helps people fit it into
>    their schedule of other meetings (and meals), but I think the benefits
>    of allowing more people to participate live outweighs the costs.

Hard question without any good answer. You can rotate preferred timezone
which should spread the suffering.

>  - Schedule.  Friday's probably a bad day to have it, as it ends up
>    being Saturday for some people.  It can move around the week too.
>    Also, probably wise to not have it over Christmas as most developers
>    have that period as family time.

Yes, Friday tends to be not great. I think mid week should work better
as the overalap 

>  - Topics.  I'm sure there's no shortage of things to discuss!  I'm
>    happy to organise meetings for people even on topics I have no direct
>    interest in.

Thanks for organizing this. I am pretty sure poeple will land on topics
either in the call or over email.

> And most urgently, when should we have the GUP meeting? On the call,
> I suggested Friday the 8th of January, but I'm happy to set something
> up for next week if we'd like to talk more urgently.

I am unlikely to be able to join before the end of year so if you ask
me.

Thanks again and fingers crossed we can actually have a face to face
meeting sometimes during next year.
-- 
Michal Hocko
SUSE Labs
