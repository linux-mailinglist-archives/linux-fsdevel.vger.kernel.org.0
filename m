Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC813DF30B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhHCQnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 12:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234641AbhHCQnC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B34B60555;
        Tue,  3 Aug 2021 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628008971;
        bh=N0oTYHMTVW2k9vPS5WIst0KtjPixQzHdv0Q5QPH55gQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=C7avMTCs5wZQCjqYXkwgc3Kqdv5QPvC2J6cvrltEV+IVUY7W/PHp0006NOgsZL/Tv
         5bNcjlo9Hw7CNW4RavkB7WIH6Ad5dYL96mV7Atg1cdBzT63p+lfM9ASJ8rbm4PM3zH
         R1SSsQpdA7isYPoubeNo/AAFkrbgdWazDzrs79moxQpfKy+Wi3BXLxjueurv1WFTGF
         xqg8+00PRzmOdUr13zRILWrHBYSb5ht6GHdX/EoowKhu1uVo78Mox+piuq587/ozT7
         sS5ttqz4Zyl1bxfijnbDoD2ecE3nS+wDYKUURgYE/BZQP5zPrY4saONEyGUx90jWuC
         N56wK6YNXoCXg==
Date:   Tue, 3 Aug 2021 09:42:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap 5.15 branch construction ...
Message-ID: <20210803164251.GD3601405@magnolia>
References: <20210802221114.GG3601466@magnolia>
 <YQiMFsO5DQouSPs/@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQiMFsO5DQouSPs/@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:21:42AM +0800, Gao Xiang wrote:
> On Mon, Aug 02, 2021 at 03:11:14PM -0700, Darrick J. Wong wrote:
> > Hi everyone!
> > 
> > iomap has become very popular for this cycle, with seemingly a lot of
> > overlapping patches and whatnot.  Does this accurately reflect all the
> > stuff that people are trying to send for 5.15?
> > 
> > 1. So far, I think these v2 patches from Christoph are ready to go:
> > 
> > 	iomap: simplify iomap_readpage_actor
> > 	iomap: simplify iomap_add_to_ioend
> > 
> > 2. This is the v9 "iomap: Support file tail packing" patch from Gao,
> > with a rather heavily edited commit:
> > 
> > 	iomap: support reading inline data from non-zero pos
> > 
> > Should I wait for a v10 patch with spelling fixes as requested by
> > Andreas?  And if there is a v10 submission, please update the commit
> > message.
> 
> I've already sent out v10 with these changes:
> https://lore.kernel.org/r/20210803001727.50281-1-hsiangkao@linux.alibaba.com

Applied, thanks.

--D

> 
> Thanks,
> Gao Xiang
