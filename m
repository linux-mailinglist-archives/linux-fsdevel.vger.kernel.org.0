Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1922DB74C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 01:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLPAB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:28 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:57275 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgLOXsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:48:52 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 6D656766CFF;
        Wed, 16 Dec 2020 10:48:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kpK2z-004Ncx-TW; Wed, 16 Dec 2020 10:48:01 +1100
Date:   Wed, 16 Dec 2020 10:48:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
Message-ID: <20201215234801.GT3913616@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-7-shy828301@gmail.com>
 <20201215024637.GM3913616@dread.disaster.area>
 <CAHbLzkpgFO_WmxRwmSa_eb4KrQ3WXmHT0kOfn85HJAsfqvyC1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpgFO_WmxRwmSa_eb4KrQ3WXmHT0kOfn85HJAsfqvyC1Q@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8 a=pGLkceISAAAA:8
        a=5GS3g15B5MoVROEbUKkA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 02:27:18PM -0800, Yang Shi wrote:
> On Mon, Dec 14, 2020 at 6:46 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Dec 14, 2020 at 02:37:19PM -0800, Yang Shi wrote:
> > > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > > will be used in the following cases:
> > >     1. Non memcg aware shrinkers
> > >     2. !CONFIG_MEMCG
> > >     3. memcg is disabled by boot parameter
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> >
> > Lots of lines way over 80 columns.
> 
> I thought that has been lifted to 100 columns.

Documentation/process/coding-style.rst still says:

"The preferred limit on the length of a single line is 80 columns."

checkpatch might not warn about > 80 columns anymore, but if the
file you are modifying is almost entirely 80 columns in width, then
by default changes to that file should also stay within 80 columns.

I mostly consider using checkpatch to enforce coding styles to be
harmful....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
