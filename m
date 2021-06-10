Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0343A2984
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFJKmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 06:42:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJKmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:42:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BB0721FD47;
        Thu, 10 Jun 2021 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623321648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e69p7cSpTPxrgycR/WxxaL+1l2Iy0njG9LV0PDer+c4=;
        b=WNzicnn9I9Uzi3rhrzU3g34rvVnvDxp/dzgOfJ8QelNeJaO+n3iduUNFK/9KFkm8z8EeQW
        NL1SjEN/b720E7re5xPsC8EubYb6b5KZXIu9/vLgcdL89PUhpyLXDk4QFY4xIwUI5aT9rc
        RHr+TtYt2pnBErVijdh7TG9nIRAFQQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623321648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e69p7cSpTPxrgycR/WxxaL+1l2Iy0njG9LV0PDer+c4=;
        b=ldzR16nIFLY7YSLUeT9j/700yV/caPCby06yFrv/SQbZy/V+JI6iP9FH6mfkFJSIwBuRfv
        KhEDZH21lxejVFDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 24988A3B8B;
        Thu, 10 Jun 2021 10:40:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E025A1F2CAB; Thu, 10 Jun 2021 12:40:47 +0200 (CEST)
Date:   Thu, 10 Jun 2021 12:40:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
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
        Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 01/14] mm: Fix comments mentioning i_mutex
Message-ID: <20210610104047.GA23539@quack2.suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
 <20210607145236.31852-1-jack@suse.cz>
 <YMHWIcbnLPW5AfiC@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMHWIcbnLPW5AfiC@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-06-21 17:06:41, Ming Lei wrote:
> On Mon, Jun 07, 2021 at 04:52:11PM +0200, Jan Kara wrote:
> > inode->i_mutex has been replaced with inode->i_rwsem long ago. Fix
> > comments still mentioning i_mutex.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> ...
> 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 693a610e181d..a35cbbbded0d 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -20,9 +20,9 @@
> >  /*
> >   * Lock ordering in mm:
> >   *
> > - * inode->i_mutex	(while writing or truncating, not reading or faulting)
> > + * inode->i_rwsem	(while writing or truncating, not reading or faulting)
> >   *   mm->mmap_lock
> > - *     page->flags PG_locked (lock_page)   * (see huegtlbfs below)
> > + *     page->flags PG_locked (lock_page)   * (see hugetlbfs below)
> >   *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
> >   *         mapping->i_mmap_rwsem
> >   *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> > @@ -41,7 +41,7 @@
> >   *                             in arch-dependent flush_dcache_mmap_lock,
> >   *                             within bdi.wb->list_lock in __sync_single_inode)
> >   *
> > - * anon_vma->rwsem,mapping->i_mutex      (memory_failure, collect_procs_anon)
> > + * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
> 
> This one looks a typo.

Actually it isn't a typo. Memory failure path doesn't touch inode->i_rwsem
at all. It uses mapping->i_mmap_rwsem in collect_procs_file(). So perhaps
the functions listed there should be updated to (collect_procs_anon(),
collect_procs_file()) but the lock name change is IMO correct.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
