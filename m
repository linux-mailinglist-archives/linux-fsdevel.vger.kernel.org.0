Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C12F318E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 14:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbhALNX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 08:23:59 -0500
Received: from verein.lst.de ([213.95.11.211]:55529 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbhALNX7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:23:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B37E067373; Tue, 12 Jan 2021 14:23:15 +0100 (CET)
Date:   Tue, 12 Jan 2021 14:23:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when needed in
 fat_update_time()
Message-ID: <20210112132315.GA13780@lst.de>
References: <20210109075903.208222-1-ebiggers@kernel.org> <20210109075903.208222-5-ebiggers@kernel.org> <20210111105201.GB2502@lst.de> <X/ysA8PuJ/+JXQYL@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/ysA8PuJ/+JXQYL@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:50:27AM -0800, Eric Biggers wrote:
> On Mon, Jan 11, 2021 at 11:52:01AM +0100, Christoph Hellwig wrote:
> > On Fri, Jan 08, 2021 at 11:58:55PM -0800, Eric Biggers wrote:
> > > +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > > +		dirty_flags |= I_DIRTY_SYNC;
> > 
> > fat does not support i_version updates, so this bit can be skipped.
> 
> Is that really the case?  Any filesystem (including fat) can be mounted with
> "iversion", which causes SB_I_VERSION to be set.
> 
> A lot of filesystems (including fat) don't store i_version to disk, but it looks
> like it will still get updated in-memory.  Could anything be relying on that?

As Dave pointed out i_version can't really work for fat.  But I guess
that is indeed out of scope for this series, so let's go ahead with this
version for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>
