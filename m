Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F839A469B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 02:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfIAAEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 20:04:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50047 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfIAAEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 20:04:49 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2957643D6F0;
        Sun,  1 Sep 2019 10:04:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i4DMI-00034W-TN; Sun, 01 Sep 2019 10:04:42 +1000
Date:   Sun, 1 Sep 2019 10:04:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190901000442.GF7777@dread.disaster.area>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
 <20190830215410.GD7777@dread.disaster.area>
 <295503.1567247505@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <295503.1567247505@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=xnCBgfmyHqVRtrSWEYsA:9 a=QEXdDO2ut3YA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 06:31:45AM -0400, Valdis Klētnieks wrote:
> On Sat, 31 Aug 2019 07:54:10 +1000, Dave Chinner said:
> 
> > The correct place for new filesystem review is where all the
> > experienced filesystem developers hang out - that's linux-fsdevel,
> > not the driver staging tree.
> 
> So far everything's been cc'ed to linux-fsdevel, which has been spending
> more time discussing unlikely() usage in a different filesystem.

That's just noise - you'll get whitespace and other trivial
review on any list you post a patch series for review. Go back and
look at what other people have raised w.r.t. to that filesystem -
on-disk format validation, re-implementation of largely generic
code, lack of namespacing of functions leading to conflicts with
generic/VFS functionality, etc.

Review bandwidth for things like on-disk format definition and
manipulation, consistency with other filesystems, efficient
integration into the generic infrastructure, etc is limited.
Everyone has to juggle that around the load they have for their own
filesystem maintenance, and there's usually only bandwidth for a
single filesystem at a time.

Just be patient - trying to force the merging of code before there's
even been consensus on fundamental architecture choices doesn't make
things better for anyone.  Merging incomplete filesystem code early
in the development cycle has -always- been something we've regretted
in the long run.  We've learn this lesson many times before, yet we
seem doomed to repeat it yet again...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
