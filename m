Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA232D483D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgLIRsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 12:48:32 -0500
Received: from verein.lst.de ([213.95.11.211]:50942 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgLIRsc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:48:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB3C868B02; Wed,  9 Dec 2020 18:47:50 +0100 (CET)
Date:   Wed, 9 Dec 2020 18:47:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] writeback: don't warn on an unregistered BDI in
 __mark_inode_dirty
Message-ID: <20201209174750.GA20352@lst.de>
References: <20200928122613.434820-1-hch@lst.de> <20201209163536.GA2587@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209163536.GA2587@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 05:35:36PM +0100, Jan Kara wrote:
> > I have a vague memory someone else sent this patch alredy, but couldn't
> > find it in my mailing list folder.  But given that my current NVMe
> > tests trigger it easily I'd rather get it fixed ASAP.
> 
> Did this patch get lost? I don't see it upstream or in Jens' tree. FWIW I
> agree the warning may result in false positive so I'm OK with removing it.
> So feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Yes, it looks like this patch got lost somewhere again.
