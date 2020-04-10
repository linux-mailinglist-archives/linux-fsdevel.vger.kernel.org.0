Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C031A3D51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 02:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDJA1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 20:27:43 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54089 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgDJA1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:27:43 -0400
Received: from dread.disaster.area (pa49-180-167-53.pa.nsw.optusnet.com.au [49.180.167.53])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4E4F63A2DB2;
        Fri, 10 Apr 2020 10:27:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jMhWD-00061P-Vl; Fri, 10 Apr 2020 10:27:37 +1000
Date:   Fri, 10 Apr 2020 10:27:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200410002737.GT24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
 <20200408232106.GO24067@dread.disaster.area>
 <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
 <20200409004921.GS24067@dread.disaster.area>
 <20200409124031.GA18171@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409124031.GA18171@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=2xmR08VVv0jSFCMMkhec0Q==:117 a=2xmR08VVv0jSFCMMkhec0Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=QVMKFbu1P_vDNoMgm84A:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 02:40:31PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 09, 2020 at 10:49:21AM +1000, Dave Chinner wrote:
> > > Christoph did say:
> > > 
> > > 	"A reasonably smart application can try to evict itself."
> > > 
> > > 	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/
> > 
> > I'd love to know how an unprivileged application can force the
> > eviction of an inode from cache.
> 
> Where did the "unprivileged" suddenly come from?

I'm assuming that applications are being run without the root
permissions needed to run drop_caches. i.e. the apps are
unprivileged, and therefore can't brute force inode cache eviction.
That's why I'm asking what mechanism these applications are using to
evict inodes on demand without requiring elevated privileges,
because I can't see how they'd acheive this...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
