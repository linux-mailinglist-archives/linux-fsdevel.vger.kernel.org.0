Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2C46609A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 10:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353545AbhLBJq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 04:46:59 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:43801 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353894AbhLBJq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:46:58 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 4C56EFAB00
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:43:35 +0000 (GMT)
Received: (qmail 438 invoked from network); 2 Dec 2021 09:43:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Dec 2021 09:43:34 -0000
Date:   Thu, 2 Dec 2021 09:43:32 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211202094332.GW3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <20211201010348.31e99637@mail.inbox.lv>
 <20211130172754.GS3366@techsingularity.net>
 <20211201033836.4382a474@mail.inbox.lv>
 <20211201140005.GU3366@techsingularity.net>
 <20211201172920.GA8492@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211201172920.GA8492@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 09:29:20AM -0800, Darrick J. Wong wrote:
> > Again 5.16-rc1 stuttered badly but the new patch was comparable to 5.15.
> > 
> > As my baseline figures are very different to yours due to differences in
> > storage, can you test the following please?
> 
> I don't know if this was directed at me, but I reran my swapfile
> testcase on 5.16-rc3 and found that it had nearly the same runtime as it
> did in 5.15.
> 

Thanks Darrick. Can I add the following?

Tested-by: Darrick J. Wong <djwong@kernel.org>

-- 
Mel Gorman
SUSE Labs
