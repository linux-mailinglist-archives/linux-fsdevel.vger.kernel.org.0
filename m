Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF93E5005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 01:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhHIXfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 19:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235510AbhHIXfq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:35:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39E3D60295;
        Mon,  9 Aug 2021 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628552124;
        bh=2IMhXDdQyftUpOsw+euuyuYULmBMSsJF35i5Ux8hEIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmwEpOjSwgmyLYJ9PA5nqsuxpiHvCQrIcH3Z/esEnMdUpSo6782NNb50nZwacsoLM
         RuoJFeXSKn0pOp0ElFHEepd/8lCZ/CvH57cemLuv8r2WPLyzKaxCtbJjG3/Qq/Qpgg
         Xw6nID1TOWmjHzkW72y+tHrWdhJdxmj2x+ghNrCrad88IzIOOegcjD1iMeWq+mB2qn
         JbP5i47687ONbpwx4YsBeSTcZ6p32gaxS/ic0XZsw392zpbVMJtVwc6R/yc4s5Pek2
         HeMWX3wi9BIq5HWfJ4ABFfhmytWE2CvYPGbQMZ745Cvd21Vk4aRjQGbAiqLSxOjjUu
         jQv5PPY9x7PuA==
Date:   Mon, 9 Aug 2021 16:35:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: pass writeback errors to the mapping
Message-ID: <20210809233523.GQ3601466@magnolia>
References: <20210805213154.GZ3601443@magnolia>
 <YQxiVxSWWwZwoqbZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQxiVxSWWwZwoqbZ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:12:39PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 05, 2021 at 02:31:54PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Modern-day mapping_set_error has the ability to squash the usual
> > negative error code into something appropriate for long-term storage in
> > a struct address_space -- ENOSPC becomes AS_ENOSPC, and everything else
> > becomes EIO.  iomap squashes /everything/ to EIO, just as XFS did before
> > that, but this doesn't make sense.
> > 
> > Fix this by making it so that we can pass ENOSPC to userspace when
> > writeback fails due to space problems.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> 
> I could have sworn I sent this patch in earlier.  Anyway,
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

It was an RFC that I then forgot about for a while.  I'll stuff this in
the iomap for-next branch the next time I do an update, which ... let's
see where the iomap iter series goes, review-wise.

--D
