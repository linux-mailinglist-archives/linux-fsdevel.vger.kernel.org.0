Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B7101B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfD3VVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 17:21:52 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50186 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbfD3VVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:21:52 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 77CA143A20F;
        Wed,  1 May 2019 07:21:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hLaCA-0004HS-TP; Wed, 01 May 2019 07:21:46 +1000
Date:   Wed, 1 May 2019 07:21:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/5] iomap and gfs2 fixes
Message-ID: <20190430212146.GL1454@dread.disaster.area>
References: <20190429220934.10415-1-agruenba@redhat.com>
 <20190430025028.GA5200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430025028.GA5200@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=UJetJGXy c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=JuDxSlhT3OO6blO4plAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:50:28PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 30, 2019 at 12:09:29AM +0200, Andreas Gruenbacher wrote:
> > Here's another update of this patch queue, hopefully with all wrinkles
> > ironed out now.
> > 
> > Darrick, I think Linus would be unhappy seeing the first four patches in
> > the gfs2 tree; could you put them into the xfs tree instead like we did
> > some time ago already?
> 
> Sure.  When I'm done reviewing them I'll put them in the iomap tree,
> though, since we now have a separate one. :)

I'd just keep the iomap stuff in the xfs tree as a separate set of
branches and merge them into the XFS for-next when composing it.
That way it still gets plenty of test coverage from all the XFS
devs and linux next without anyone having to think about.

You really only need to send separate pull requests for the iomap
and XFS branches - IMO, there's no really need to have a complete
new tree for it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
