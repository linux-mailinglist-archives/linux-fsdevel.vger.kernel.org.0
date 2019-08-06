Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD92A83BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 23:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfHFViR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 17:38:17 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33465 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728872AbfHFViQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:38:16 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0DF2C3611A0;
        Wed,  7 Aug 2019 07:38:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hv78m-0005E4-4F; Wed, 07 Aug 2019 07:37:08 +1000
Date:   Wed, 7 Aug 2019 07:37:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH 00/24] mm, xfs: non-blocking inode reclaim
Message-ID: <20190806213708.GK7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190806055744.GC25736@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806055744.GC25736@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=6Ra6EZb4IHi7eq9aHn8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:57:44PM -0700, Christoph Hellwig wrote:
> Hi Dave,
> 
> do you have a git tree available to look over the whole series?

Not yet, I'll get one up for the next version of the patchset and I
have done some page cache vs inode cache balance testing. That,
FWIW, is not looking good - the vanilla 5.3-rc3 kernel is unable to
maintain a balanced page cache/inode cache working set under steady
state tarball-extraction workloads. Memory reclaim looks to be have
been completely borked from a system balance perspective since I
last looked at it maybe a year ago....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
