Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D861A343F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 14:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDIMke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 08:40:34 -0400
Received: from verein.lst.de ([213.95.11.211]:46535 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgDIMke (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:40:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1BB1D68C4E; Thu,  9 Apr 2020 14:40:32 +0200 (CEST)
Date:   Thu, 9 Apr 2020 14:40:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409124031.GA18171@lst.de>
References: <20200407182958.568475-1-ira.weiny@intel.com> <20200407182958.568475-7-ira.weiny@intel.com> <20200408020827.GI24067@dread.disaster.area> <20200408170923.GC569068@iweiny-DESK2.sc.intel.com> <20200408210236.GK24067@dread.disaster.area> <20200408220734.GA664132@iweiny-DESK2.sc.intel.com> <20200408232106.GO24067@dread.disaster.area> <20200409001206.GD664132@iweiny-DESK2.sc.intel.com> <20200409004921.GS24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409004921.GS24067@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 10:49:21AM +1000, Dave Chinner wrote:
> > Christoph did say:
> > 
> > 	"A reasonably smart application can try to evict itself."
> > 
> > 	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/
> 
> I'd love to know how an unprivileged application can force the
> eviction of an inode from cache.

Where did the "unprivileged" suddenly come from?
