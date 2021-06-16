Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB703AA057
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhFPPtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235829AbhFPPtM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE66F61027;
        Wed, 16 Jun 2021 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623858425;
        bh=OHnFfLs1QbSWuvd+00QSmxA7rj2+r71j9JxqIC1dccs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cm9BcOlm6gd25cL9Pa/hoPc8RYWVSw4N7Ny2T14PC0IS5cEEKEAGVJSkSivywsUMG
         u1I+5M+S3w4H9xm0XXvSaG/eYLypq966O1/gB/og7CP7v7LQfI0gmF81TfvWwHMulQ
         +8ZHAH7F+vVf9Jsx0tkuGVjciUErP0ANSrnHaR1QB7uXaz8hX8talAwZMqD/4nt/vg
         uXS6pjhRhAVPdC8/OKpqsAtGsOM3IHzZ4cHjKAt/AJrAXmYYUf4ECPGbYh3tScVu1X
         oAjQegVZuY98P7j8xq+U+nKaGh+CfwxlZjVcSTxYrIsY3RStpHq5x4KYVvrcVtoI1E
         c9FsYX78QhScg==
Date:   Wed, 16 Jun 2021 08:47:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Reichl <preichl@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Message-ID: <20210616154705.GE158209@locust>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-7-jack@suse.cz>
 <YMmOCK4wHc9lerEc@infradead.org>
 <20210616085304.GA28250@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616085304.GA28250@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:53:04AM +0200, Jan Kara wrote:
> On Wed 16-06-21 06:37:12, Christoph Hellwig wrote:
> > On Tue, Jun 15, 2021 at 11:17:57AM +0200, Jan Kara wrote:
> > > From: Pavel Reichl <preichl@redhat.com>
> > > 
> > > Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
> > > __xfs_rwsem_islocked() is a helper function which encapsulates checking
> > > state of rw_semaphores hold by inode.
> > 
> > __xfs_rwsem_islocked doesn't seem to actually existing in any tree I
> > checked yet?
> 
> __xfs_rwsem_islocked is introduced by this patch so I'm not sure what are
> you asking about... :)

The sentence structure implies that __xfs_rwsem_islocked was previously
introduced.  You might change the commit message to read:

"Introduce a new __xfs_rwsem_islocked predicate to encapsulate checking
the state of a rw_semaphore, then refactor xfs_isilocked to use it."

Since it's not quite a straight copy-paste of the old code.

--D

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
