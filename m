Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D434358E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF0WhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 18:37:08 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46803 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbfF0WhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:37:07 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5E47343C48F;
        Fri, 28 Jun 2019 08:37:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hgczl-0001yF-U3; Fri, 28 Jun 2019 08:35:57 +1000
Date:   Fri, 28 Jun 2019 08:35:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] iomap: add tracing for the address space operations
Message-ID: <20190627223557.GI7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-13-hch@lst.de>
 <20190624234921.GE7777@dread.disaster.area>
 <20190625101515.GL1462@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625101515.GL1462@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=rMA9bymeoucKrl8lURMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:15:15PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 09:49:21AM +1000, Dave Chinner wrote:
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM iomap
> > 
> > Can you add a comment somewhere here that says these tracepoints are
> > volatile and we reserve the right to change them at any time so they
> > don't form any sort of persistent UAPI that we have to maintain?
> 
> Sure.  Note that we don't have any such comment in xfs either..

Yes, but that is buries inside the xfs code where we largely set our
own rules. This, however, is generic code where people have a habit
of arguing that tracepoints are stable API and they can never be
changed because some random userspace application may have hard
coded a dependency on it...

Hence we need to be explicit here that this is diagnostic/debug code
and anyone who tries to rely on it as a stable API gets to keep all
the broken bits to themselves.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
