Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938062EEF4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbhAHJPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 04:15:21 -0500
Received: from verein.lst.de ([213.95.11.211]:43180 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbhAHJPU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:15:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 63E6767373; Fri,  8 Jan 2021 10:14:37 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:14:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/13] fs: add a lazytime_expired method
Message-ID: <20210108091436.GC2587@lst.de>
References: <20210105005452.92521-1-ebiggers@kernel.org> <20210105005452.92521-12-ebiggers@kernel.org> <20210107140228.GF12990@quack2.suse.cz> <X/eFxSh3ac6EGdYI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/eFxSh3ac6EGdYI@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:05:57PM -0800, Eric Biggers wrote:
> The XFS developers might have a different opinion though, as they were the ones
> who requested it originally:
> 
> 	https://lore.kernel.org/r/20200312143445.GA19160@infradead.org
> 	https://lore.kernel.org/r/20200325092057.GA25483@infradead.org
> 	https://lore.kernel.org/r/20200325154759.GY29339@magnolia
> 	https://lore.kernel.org/r/20200312223913.GL10776@dread.disaster.area
> 
> Any thoughts from anyone about whether we should still introduce a separate
> notification for lazytime expiration, vs. just using ->dirty_inode(I_DIRTY_SYNC)
> with I_DIRTY_TIME in i_state?

I still find the way ->dirty_inode is used very confusing, but with this
series and Jan's first patch I think we have a good enough state for now
and don't need to add a method just for XFS.  I still think it might make
sense to eventually revisit how file systems are notified about dirtying.
