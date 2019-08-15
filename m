Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B438EB59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 14:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfHOMQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 08:16:25 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42810 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbfHOMQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:16:25 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1916A43DAC5;
        Thu, 15 Aug 2019 22:16:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hyEeu-0002vC-19; Thu, 15 Aug 2019 22:15:12 +1000
Date:   Thu, 15 Aug 2019 22:15:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
Message-ID: <20190815121511.GR6129@dread.disaster.area>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-2-arnd@arndb.de>
 <20190814213753.GP6129@dread.disaster.area>
 <20190815071314.GA6960@infradead.org>
 <CAK8P3a2Hjfd49XY18cDr04ZpvC5ZBGudzxqpCesbSsDf1ydmSA@mail.gmail.com>
 <20190815080211.GA17055@infradead.org>
 <20190815102649.GA10821@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815102649.GA10821@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=jxn0Vpof_sybO78mxNEA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:26:49AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 15, 2019 at 01:02:11AM -0700, Christoph Hellwig wrote:
> > In many ways I'd actually much rather have a table driven approach.
> > Let me try something..
> 
> Ok, it seems like we don't even need a table containing native and
> compat as we can just fall back.  The tables still seem nicer to read,
> though.
> 
> Let me know what you think of this:
> 
> http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-ioctl-table

Lots to like in that handful of patches. :)

It can easily go before or after Arnd's patch, and the merge
conflict either way would be minor, so I'm not really fussed either
way this gets sorted out...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
