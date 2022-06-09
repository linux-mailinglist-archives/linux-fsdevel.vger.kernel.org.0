Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9225450B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiFIPYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiFIPYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:24:24 -0400
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 08:24:22 PDT
Received: from outbound-smtp36.blacknight.com (outbound-smtp36.blacknight.com [46.22.139.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB61C4AE38
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 08:24:22 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 42E902067
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 16:15:18 +0100 (IST)
Received: (qmail 23872 invoked from network); 9 Jun 2022 15:15:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jun 2022 15:15:17 -0000
Date:   Thu, 9 Jun 2022 16:15:16 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, peterz@infradead.org,
        dhowells@redhat.com, willy@infradead.org, Liam.Howlett@oracle.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: sysctl: fix missing numa_stat when
 !CONFIG_HUGETLB_PAGE
Message-ID: <20220609151516.GA30825@techsingularity.net>
References: <20220609104032.18350-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220609104032.18350-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 06:40:32PM +0800, Muchun Song wrote:
> "numa_stat" should not be included in the scope of CONFIG_HUGETLB_PAGE, if
> CONFIG_HUGETLB_PAGE is not configured even if CONFIG_NUMA is configured,
> "numa_stat" is missed form /proc. Move it out of CONFIG_HUGETLB_PAGE to
> fix it.
> 
> Fixes: 4518085e127d ("mm, sysctl: make NUMA stats configurable")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
