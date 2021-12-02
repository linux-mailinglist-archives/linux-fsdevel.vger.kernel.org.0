Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D198466141
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 11:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356825AbhLBKQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 05:16:53 -0500
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:58289 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356851AbhLBKQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:16:50 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 5AC0FF8382
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 10:13:26 +0000 (GMT)
Received: (qmail 8972 invoked from network); 2 Dec 2021 10:13:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Dec 2021 10:13:26 -0000
Date:   Thu, 2 Dec 2021 10:13:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211202101324.GX3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <20211201010348.31e99637@mail.inbox.lv>
 <20211130172754.GS3366@techsingularity.net>
 <20211201033836.4382a474@mail.inbox.lv>
 <20211201140005.GU3366@techsingularity.net>
 <74248b525d5ee03bfd00aaa66cd08a4582998cd6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <74248b525d5ee03bfd00aaa66cd08a4582998cd6.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:11:38AM +0100, Mike Galbraith wrote:
> On Wed, 2021-12-01 at 14:00 +0000, Mel Gorman wrote:
> >
> > I've included another patch below against 5.16-rc1 but it'll apply to
> > 5.16-rc3. Using the same test I get
> 
> LTP testcases that stalled my box no longer do, nor can I manually
> trigger any unexpected behavior.
> 

Excellent, can I add the following?

Tested-by: Mike Galbraith <efault@gmx.de>

-- 
Mel Gorman
SUSE Labs
