Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E254667A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359347AbhLBQM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 11:12:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53846 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359345AbhLBQMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:12:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEEB6268F;
        Thu,  2 Dec 2021 16:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86FEC00446;
        Thu,  2 Dec 2021 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638461370;
        bh=pIo5eiwP+Dtx+LxnVanei0w9hk4uYILZ609rHZrcAdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iFPrk4rtYAf+Rx4IKVph3SNlRQDmzxLr4kBwk3DdYPsd7+4WyvpLfVw3gY0J8tqFE
         gAIM3Gt9UlRs0yDRiSDml+wTdofUpjN26Hj43gBmJCISV2UVsGWG46sxVXtMkqEIOd
         40JbY005yCQiB8BH9Rjm1psgDLlpzyZS1eOgSwyiLb1tN91LZcHBZluM5A3w7OOlzE
         /Q+2yooCOST9j28KNJ/8Fl5Bq6Bw287Laa9U68lSIhU2iHUBnz226tMqqLTV5X0G6o
         zNuGukctfv6FFtDT+CTxTYAxSMLFSwq9r5CVFa40/+7FGFxcLiBGI2Z89hPASenblC
         1S7V3HvJMyPkA==
Date:   Thu, 2 Dec 2021 08:09:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <20211202160930.GC8492@magnolia>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <20211201010348.31e99637@mail.inbox.lv>
 <20211130172754.GS3366@techsingularity.net>
 <20211201033836.4382a474@mail.inbox.lv>
 <20211201140005.GU3366@techsingularity.net>
 <20211201172920.GA8492@magnolia>
 <20211202094332.GW3366@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202094332.GW3366@techsingularity.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:43:32AM +0000, Mel Gorman wrote:
> On Wed, Dec 01, 2021 at 09:29:20AM -0800, Darrick J. Wong wrote:
> > > Again 5.16-rc1 stuttered badly but the new patch was comparable to 5.15.
> > > 
> > > As my baseline figures are very different to yours due to differences in
> > > storage, can you test the following please?
> > 
> > I don't know if this was directed at me, but I reran my swapfile
> > testcase on 5.16-rc3 and found that it had nearly the same runtime as it
> > did in 5.15.
> > 
> 
> Thanks Darrick. Can I add the following?
> 
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Yes, please! :)

--D

> -- 
> Mel Gorman
> SUSE Labs
