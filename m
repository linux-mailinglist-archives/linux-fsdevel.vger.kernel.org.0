Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111C841C51A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbhI2NC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 09:02:27 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:39869 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343982AbhI2NCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:02:25 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 08D9C1C3E81
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 14:00:43 +0100 (IST)
Received: (qmail 13619 invoked from network); 29 Sep 2021 13:00:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Sep 2021 13:00:42 -0000
Date:   Wed, 29 Sep 2021 14:00:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Remove dependency on congestion_wait in mm/ v2
Message-ID: <20210929130040.GJ3959@techsingularity.net>
References: <20210929100914.14704-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210929100914.14704-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:09:09AM +0100, Mel Gorman wrote:
> This is a series that removes all calls to congestion_wait
> in mm/ and deletes wait_iff_congested. It's not a clever
> implementation but congestion_wait has been broken for a long time
> (https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).
> Even if it worked, it was never a great idea. While excessive
> dirty/writeback pages at the tail of the LRU is one possibility that
> reclaim may be slow, there is also the problem of too many pages being
> isolated and reclaim failing for other reasons (elevated references,
> too many pages isolated, excessive LRU contention etc).
> 

Don't send series after taking time off. This is the completely wrong
set of patches, it's v1 again, sorry. I'll fix up a v3.

-- 
Mel Gorman
SUSE Labs
