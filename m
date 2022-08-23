Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6770D59EFB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 01:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiHWX2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHWX2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:28:35 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAAE98A1CA;
        Tue, 23 Aug 2022 16:28:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E209010E8C98;
        Wed, 24 Aug 2022 09:28:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oQdJw-00Gk9U-Qx; Wed, 24 Aug 2022 09:28:32 +1000
Date:   Wed, 24 Aug 2022 09:28:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
Message-ID: <20220823232832.GQ3600936@dread.disaster.area>
References: <20220822133309.86005-1-jlayton@kernel.org>
 <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
 <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
 <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
 <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
 <20220822233231.GJ3600936@dread.disaster.area>
 <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
 <166125468756.23264.2859374883806269821@noble.neil.brown.name>
 <df469d936b2e1c1a8c9c947896fa8a160f33b0e8.camel@kernel.org>
 <166129348704.23264.10381335282721356873@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166129348704.23264.10381335282721356873@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=630562a2
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=GcyzOjIWAAAA:8 a=uZvujYp8AAAA:8
        a=7-415B0cAAAA:8 a=P-QfJufZ_sklkARv_-sA:9 a=CjuIK1q_8ugA:10
        a=RWIgqKacCvQA:10 a=6xFH9qvm82wA:10 a=hQL3dl6oAZ8NdCsdz28n:22
        a=SLzB8X_8jTLwj6mN0q5r:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 08:24:47AM +1000, NeilBrown wrote:
> On Tue, 23 Aug 2022, Jeff Layton wrote:
> > On Tue, 2022-08-23 at 21:38 +1000, NeilBrown wrote:
> > > On Tue, 23 Aug 2022, Jeff Layton wrote:
> > > > So, we can refer to that and simply say:
> > > > 
> > > > "If the function updates the mtime or ctime on the inode, then the
> > > > i_version should be incremented. If only the atime is being updated,
> > > > then the i_version should not be incremented. The exception to this rule
> > > > is explicit atime updates via utimes() or similar mechanism, which
> > > > should result in the i_version being incremented."
> > > 
> > > Is that exception needed?  utimes() updates ctime.
> > > 
> > > https://man7.org/linux/man-pages/man2/utimes.2.html
> > > 
> > > doesn't say that, but
> > > 
> > > https://pubs.opengroup.org/onlinepubs/007904875/functions/utimes.html
> > > 
> > > does, as does the code.
> > > 
> > 
> > Oh, good point! I think we can leave that out. Even better!
> 
> Further, implicit mtime updates (file_update_time()) also update ctime.
> So all you need is
>    If the function updates the ctime, then i_version should be
>    incremented.
> 
> and I have to ask - why not just use the ctime?  Why have another number
> that is parallel?
> 
> Timestamps are updated at HZ (ktime_get_course) which is at most every
> millisecond.

Kernel time, and therefore timestamps, can go backwards.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
