Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC535E054
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhDMNmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 09:42:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhDMNms (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:42:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9F2EAF75;
        Tue, 13 Apr 2021 13:42:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7320E1E37A2; Tue, 13 Apr 2021 15:42:27 +0200 (CEST)
Date:   Tue, 13 Apr 2021 15:42:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/7] xfs: Convert to use i_mapping_sem
Message-ID: <20210413134227.GC15752@quack2.suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-5-jack@suse.cz>
 <20210413130512.GC1366579@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413130512.GC1366579@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-04-21 14:05:12, Christoph Hellwig wrote:
> On Tue, Apr 13, 2021 at 01:28:49PM +0200, Jan Kara wrote:
> > Use i_mapping_sem instead of XFS internal i_mmap_lock. The intended
> > purpose of i_mapping_sem is exactly the same.
> 
> Might be worth mentioning here that the locking in __xfs_filemap_fault
> changes because filemap_fault already takes i_mapping_sem?

Sure, will add.

> 
> >   * mmap_lock (MM)
> >   *   sb_start_pagefault(vfs, freeze)
> > - *     i_mmaplock (XFS - truncate serialisation)
> > + *     i_mapping_sem (XFS - truncate serialisation)
> 
> This is sort of VFS now, isn't it?

Right, I'll update the comment.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
