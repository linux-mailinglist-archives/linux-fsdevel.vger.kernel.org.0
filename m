Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C9FD170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 00:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNXT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 18:19:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:23450 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfKNXT0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:19:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 15:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,306,1569308400"; 
   d="scan'208";a="207950534"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2019 15:19:24 -0800
Date:   Thu, 14 Nov 2019 15:19:24 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH V2 0/2] Move swap functions out of address space
 operations
Message-ID: <20191114231924.GA4370@iweiny-DESK2.sc.intel.com>
References: <20191113004244.9981-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113004244.9981-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 04:42:42PM -0800, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> As suggested by Jan Kara, move swap_[de]activate to file_operations to simplify
> address space operations for coming changes.
> 
> I'm not sure if this should go through Al Viro or Andrew Morton so I'm sending
> it to both of you.  Sorry if this is a problem.  Let me know if there is
> something else I should do.
> 
> Ira Weiny (2):
>   fs: Clean up mapping variable
>   fs: Move swap_[de]activate to file_operations

There should have been an update to the documentation with this.

I have a 3rd patch which I'm sending separately.

Ira

> 
>  fs/btrfs/file.c     | 341 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/inode.c    | 340 -------------------------------------------
>  fs/f2fs/data.c      | 123 ----------------
>  fs/f2fs/file.c      | 122 ++++++++++++++++
>  fs/iomap/swapfile.c |   3 +-
>  fs/nfs/file.c       |   4 +-
>  fs/xfs/xfs_aops.c   |  13 --
>  fs/xfs/xfs_file.c   |  12 ++
>  include/linux/fs.h  |  10 +-
>  mm/swapfile.c       |  12 +-
>  10 files changed, 488 insertions(+), 492 deletions(-)
> 
> -- 
> 2.21.0
> 
