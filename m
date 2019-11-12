Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86399F90BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 14:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKLNdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 08:33:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:50364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLNdv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:33:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64721B213;
        Tue, 12 Nov 2019 13:33:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC6B71E4AD2; Tue, 12 Nov 2019 14:33:48 +0100 (CET)
Date:   Tue, 12 Nov 2019 14:33:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ira.weiny@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Message-ID: <20191112133348.GJ1241@quack2.suse.cz>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-3-ira.weiny@intel.com>
 <20191111164320.80f814161469055b14f27045@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111164320.80f814161469055b14f27045@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 11-11-19 16:43:20, Andrew Morton wrote:
> On Mon, 11 Nov 2019 16:34:52 -0800 ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > swap_activate() and swap_deactivate() have nothing to do with
> > address spaces.  We want to eventually make the address space operations
> > dynamic to switch inode flags on the fly.
> 
> What does this mean?

See my reply to Christoph [1]. Ira wants to make switching inodes between
DAX and non-DAX mode work which means switching also
address_space_operations pointer in the mapping. 

								Honza

[1] lore.kernel.org/r/20191112133055.GI1241@quack2.suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
