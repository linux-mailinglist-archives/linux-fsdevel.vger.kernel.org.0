Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF76640FB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 22:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiLBVCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 16:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLBVCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:02:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE92DF9A;
        Fri,  2 Dec 2022 13:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FROLR2va9KKgL78wsFLZ/TVnf/jYGfOMh6G+tGx4yOs=; b=TBKeJKOcTxo8sFdqAgdjUyfbCu
        OCbp0Wa98Ia4T/So85xU8nT+fY867VbC6qq0y7D6kJdKbXv9H1W87aVRnlqBDieNrF4oolOa6eE8+
        KaGmmG/SGeBSCcRQo9YVBCiHATGJvdwiAA4bUvjuLJMWcvpFh1fQJVpXsPsXs3rZZeqyTWhDzsrg9
        iswdx7DY5Afw1U204NaevGd0r1gVyp1dWxkIVupkWOr8ktBzerJK+pp5Hy09LCQVbrihdbeW6G+lP
        Gtu6bwZL8jPQJtehAxUMZdEd9+vFvP3udBwsU/ZqCxRZ9YbmmDDCubeZPDbt7qyLQ8Z7f+v6gbUSj
        etA1QwQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1DAG-000WGe-GX; Fri, 02 Dec 2022 21:01:44 +0000
Date:   Fri, 2 Dec 2022 21:01:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aditya Garg <gargaditya08@live.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] hfsplus: Add module parameter to enable force writes
Message-ID: <Y4pnuBnoHvIS8UB6@casper.infradead.org>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
 <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:53:44PM -0800, Andrew Morton wrote:
> > +		if (force_journaled_rw) {
> > +			pr_warn("write access to a journaled filesystem is not supported, but has been force enabled.\n");
> > +		} else {
> > +			pr_warn("write access to a journaled filesystem is not supported, use the force option at your own risk, mounting read-only.\n");
> > +			sb->s_flags |= SB_RDONLY;
> > +		}
> 
> All these super long lines are an eyesore.  How about
> 
> 			pr_warn("write access to a journaled filesystem is "
> 				"not supported, but has been force enabled.\n");

Linus has asked us to not do that because it makes it hard to grep.

