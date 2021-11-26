Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE1E45F1D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378398AbhKZQaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 11:30:01 -0500
Received: from shark3.inbox.lv ([194.152.32.83]:56260 "EHLO shark3.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236458AbhKZQ2A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:28:00 -0500
X-Greylist: delayed 708 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 11:28:00 EST
Received: from shark3.inbox.lv (localhost [127.0.0.1])
        by shark3-out.inbox.lv (Postfix) with ESMTP id 5B0352801A7;
        Fri, 26 Nov 2021 18:12:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1637943177; bh=TwIFssNIvXJ6jzXj4xg2DtQzCcD9xeNHMIWR/MW2OK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Cspyo0iS/t9692vdkNaHGPbrUbUV8yXtyFzjzz+1RPd8v6LXhpAjITj/zKKqsMQ+X
         eM34kH5hvytdnsF0GpoDcwrOiOamLK4G046QjPXfROeSDmHP8LtPrhgSfsfaq2Y5QD
         9jZCuEOZ9spLRYCO7sC3lFRoOCQjtCUb+umbJmqQ=
Received: from localhost (localhost [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 538FA2801A1;
        Fri, 26 Nov 2021 18:12:57 +0200 (EET)
Received: from shark3.inbox.lv ([127.0.0.1])
        by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 2YM-lk9sV_IA; Fri, 26 Nov 2021 18:12:57 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 1D86D280116;
        Fri, 26 Nov 2021 18:12:57 +0200 (EET)
Date:   Sat, 27 Nov 2021 01:12:46 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211127011246.7a8ac7b8@mail.inbox.lv>
In-Reply-To: <20211125151853.8540-1-mgorman@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJ2EQ38cmnBBsMa9LpgOlO7lx8rAKFdj4mfmvc49ixdFz9PMtNdrcW+QBYXuHxy7cWTD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>After the patch, the test gets killed after roughly 15 seconds which is
>the same length of time taken in 5.15.

In my tests, the 5.15 still performs much better.

New question: is timeout=1 has sense? Will it save CPU?
