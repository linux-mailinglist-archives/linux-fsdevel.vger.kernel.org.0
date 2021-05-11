Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF7B379C08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 03:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhEKB1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 21:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEKB1v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 21:27:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 459D461108;
        Tue, 11 May 2021 01:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620696406;
        bh=Jr6glsp2GgFeevHxsJRLdUL/RKN3/WIcKZ0Ug9pPH5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6dWsyJ37bgMtM34s41A6tgGY5uc5l7m7woYiGP4vDTgO1a4pcE/acZ13ORRJQ2aQ
         c1htvuHn3GELAq+98iFA9U5A5Bqd7pWqhG8YceyfQoAg9pmmSdTL8yPOukJbYUSI4W
         xd0IBEco+XaTq05r4mMT6cNxujgw6M/zl/76Wtlm6eLq+Tjy8c/u59pUNexSzYndpX
         UsKXW+pLoEG7ZOudjSrSkdoiomj+EoaD4mqJqdYoODOpNRlUxF9vhO4FV0Q+cUvKwX
         gQp6tdtdF7N8uSUcfyu1jmzWKnVYlHjburge3Tzz5EJ02eDuTdqkB86h5/AP2WhFuP
         vI16/fc6xEj8Q==
Date:   Mon, 10 May 2021 18:26:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eryu Guan <guan@eryu.me>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 0/3] bcachefs support
Message-ID: <20210511012645.GD8558@magnolia>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <YJfvtvBCqA4zU0xf@desktop>
 <20210510231446.GO1872259@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510231446.GO1872259@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 09:14:46AM +1000, Dave Chinner wrote:
> On Sun, May 09, 2021 at 10:20:38PM +0800, Eryu Guan wrote:
> > On Tue, Apr 27, 2021 at 12:44:16PM -0400, Kent Overstreet wrote:
> > > A small patch adding bcachefs support, and two other patches for consideration:
> > 
> > As bcachefs is not upstream yet, I think we should re-visit bcachefs
> > support after it's in upstream.
> 
> I disagree completely. I've been waiting for this to land for some
> time so I can actually run fstests against bcachefs easily to
> evaluate it's current state of stability and support.  The plans are
> to get bcachefs merged upstream, and so having support already in
> fstests makes it much easier for reviewers and developers to
> actually run tests and find problems prior to merging.
> 
> As an upstream developer and someone who will be reviewing bcachefs
> when it is next proposed for merge,  I would much prefer to see
> extensive and long term fstests coverage *before* the code is even
> merged upstream. Given that filesystems take years to develop to the
> point where they are stable and ready for merge, saying "can't
> enable the test environment until it is merged upstream" is not very
> helpful.
> 
> As a general principle, we want developers of new filesystems to
> start using fstests early in the development process of their
> filesystem. We should be encouraging new filesystems to be added to
> fstests, not saying "we only support upstream filesystems". If the
> filesystem plans to be merged upstream, then fstests support for
> that filesystem should be there long before the filesytsem is even
> proposed for merge.  We need to help people get new filesystems
> upstream, not place arbitrary "not upstream so not supported"
> catch-22s in their way...
> 
> Hence I ask that you merge bcachefs support to help the process of
> getting bcachefs suport upstream.

/me notes that both Eryu and Dave have been willing to merge
surprisingly large quantities of code for XFS reflink and online fsck
long before either of those features landed in mainline, so I think it's
perfectly fine to merge Kent's relatively small changes to enable
'FSTYP=bcachefs'.

(With all of Eryu's review comments fixed, obviously...)

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
