Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CA2DBF14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 11:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgLPK6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 05:58:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgLPK6N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:58:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E9D1AD89;
        Wed, 16 Dec 2020 10:57:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 293E41E135E; Wed, 16 Dec 2020 11:57:32 +0100 (CET)
Date:   Wed, 16 Dec 2020 11:57:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] writeback: don't warn on an unregistered BDI in
 __mark_inode_dirty
Message-ID: <20201216105732.GF21258@quack2.suse.cz>
References: <20200928122613.434820-1-hch@lst.de>
 <20201209163536.GA2587@quack2.suse.cz>
 <20201209174750.GA20352@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209174750.GA20352@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-12-20 18:47:50, Christoph Hellwig wrote:
> On Wed, Dec 09, 2020 at 05:35:36PM +0100, Jan Kara wrote:
> > > I have a vague memory someone else sent this patch alredy, but couldn't
> > > find it in my mailing list folder.  But given that my current NVMe
> > > tests trigger it easily I'd rather get it fixed ASAP.
> > 
> > Did this patch get lost? I don't see it upstream or in Jens' tree. FWIW I
> > agree the warning may result in false positive so I'm OK with removing it.
> > So feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Yes, it looks like this patch got lost somewhere again.

Since Jens didn't reply, I've just picked up the patch to my tree and will
push it to Linus tomorrow.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
