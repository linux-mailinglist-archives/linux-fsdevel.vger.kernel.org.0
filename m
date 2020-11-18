Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F92B87A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 23:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKRWVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 17:21:42 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55553 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbgKRWVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:21:42 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C171058C3C7;
        Thu, 19 Nov 2020 09:21:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kfVpZ-00Caed-ES; Thu, 19 Nov 2020 09:21:37 +1100
Date:   Thu, 19 Nov 2020 09:21:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
Message-ID: <20201118222137.GT7391@dread.disaster.area>
References: <20201118071941.GN7391@dread.disaster.area>
 <9ef0f890-f115-41f3-15fc-28f21810379f@kernel.dk>
 <20201118203723.GP7391@dread.disaster.area>
 <95d51836-9dc0-24c3-9aad-678d68613907@kernel.dk>
 <20201118211506.GQ7391@dread.disaster.area>
 <83997a78-7662-42ba-1e0d-9b543d3e3194@kernel.dk>
 <20201118213341.GR7391@dread.disaster.area>
 <83c8c94e-0d70-bd9a-d5b2-0621c1d977ac@kernel.dk>
 <20201118214805.GS7391@dread.disaster.area>
 <b218ddea-798c-b6a1-9039-e4279e6ce490@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b218ddea-798c-b6a1-9039-e4279e6ce490@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=4nh3Vl8zE6TwQiGzgKkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:55:06PM -0700, Jens Axboe wrote:
> On 11/18/20 2:48 PM, Dave Chinner wrote:
> > On Wed, Nov 18, 2020 at 02:36:47PM -0700, Jens Axboe wrote:
> >> On 11/18/20 2:33 PM, Dave Chinner wrote:
> >>> On Wed, Nov 18, 2020 at 02:19:30PM -0700, Jens Axboe wrote:
> >>>>>>> Can you provide an actual event trace of the IOs in question that
> >>>>>>> are failing in your tests (e.g. from something like `trace-cmd
> >>>>>>> record -e xfs_file\* -e xfs_i\* -e xfs_\*write -e iomap\*` over the
> >>>>>>> sequential that reproduces the issue) so that there's no ambiguity
> >>>>>>> over how this problem is occurring in your systems?
> >>>>>>
> >>>>>> Let me know if you still want this!
> >>>>>
> >>>>> No, it makes sense now :)
> >>>>
> >>>> What's the next step here? Are you working on an XFS fix for this?
> >>>
> >>> I'm just building the patch now for testing.
> >>
> >> Nice, you're fast...
> > 
> > Only when I understand exactly what is happening :/
> 
> That certainly helps...
> 
> > Patch below.
> 
> Thanks, ran it through the test case 20 times (would always fail before
> in one run), and no issues observed.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>

Thanks. It's running through fstests right now, once that's done
I'll repost it for review/inclusion in a new thread.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
