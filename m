Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB093EE468
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 04:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhHQCfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 22:35:24 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57420 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233528AbhHQCfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:35:23 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id AFB4F869CF3;
        Tue, 17 Aug 2021 12:34:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mFow9-001ajs-JP; Tue, 17 Aug 2021 12:34:45 +1000
Date:   Tue, 17 Aug 2021 12:34:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2.1 11/30] iomap: add the new iomap_iter model
Message-ID: <20210817023445.GG3657114@dread.disaster.area>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-12-hch@lst.de>
 <20210811191720.GG3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811191720.GG3601443@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=MhDmnRu9jo8A:10 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=25Yfc8azc3NZfLh1rZQA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:17:20PM -0700, Darrick J. Wong wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The iomap_iter struct provides a convenient way to package up and
> maintain all the arguments to the various mapping and operation
> functions.  It is operated on using the iomap_iter() function that
> is called in loop until the whole range has been processed.  Compared
> to the existing iomap_apply() function this avoid an indirect call
> for each iteration.
> 
> For now iomap_iter() calls back into the existing ->iomap_begin and
> ->iomap_end methods, but in the future this could be further optimized
> to avoid indirect calls entirely.
> 
> Based on an earlier patch from Matthew Wilcox <willy@infradead.org>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [djwong: add to apply.c to preserve git history of iomap loop control]
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Looks like a straight translation of Christoph's original. Seems
fine to me as a simepl step towards preserving the git history.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
