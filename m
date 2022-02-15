Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64B4B7291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 17:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiBOOzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 09:55:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiBOOzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:55:09 -0500
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 06:54:59 PST
Received: from outbound-smtp30.blacknight.com (outbound-smtp30.blacknight.com [81.17.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60435237
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 06:54:59 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 2821ABAB04
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 14:49:27 +0000 (GMT)
Received: (qmail 6599 invoked from network); 15 Feb 2022 14:49:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Feb 2022 14:49:26 -0000
Date:   Tue, 15 Feb 2022 14:49:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Shuang Zhai <szhai2@cs.rochester.edu>
Cc:     akpm@linux-foundation.org, djwong@kernel.org, efault@gmx.de,
        hakavlad@inbox.lv, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        regressions@lists.linux.dev, riel@surriel.com, vbabka@suse.cz
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20220215144924.GS3366@techsingularity.net>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <20220214211050.31049-1-szhai2@cs.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220214211050.31049-1-szhai2@cs.rochester.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 04:10:50PM -0500, Shuang Zhai wrote:
> Hi Mel,
> 
> Mel Gorman wrote:
> >
> > Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> > problems due to reclaim throttling for excessive lengths of time.
> > In Alexey's case, a memory hog that should go OOM quickly stalls for
> > several minutes before stalling. In Mike and Darrick's cases, a small
> > memcg environment stalled excessively even though the system had enough
> > memory overall.
> >
> 
> I recently found a regression when I tested MGLRU with fio on Linux
> 5.16-rc6 [1]. After this patch was applied, I re-ran the test with Linux
> 5.16, but the regression has not been fixed yet. 
> 

Am I correct in thinging that this only happens with MGLRU?

-- 
Mel Gorman
SUSE Labs
