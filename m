Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6E6F226B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 04:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbjD2CeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjD2CeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 22:34:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B73584;
        Fri, 28 Apr 2023 19:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1iexicmoztAP+5Hf8Lqwr0lRj/jMsATNA0KJyvZiutQ=; b=NoLqAU46Xpcu//+X62xlgK35ho
        bWgUR2W9V/o2j4l68ARy4nyqyyDkeajIrGEnBNH08rQ2Pq0ZOCq6Drcl4ewOeJLdG3BzsoV52sQhU
        tWh0hY65zBvGeecR4NCVevSemM2DYf8I9qI0xdkV3NNfxGaAT3nZw9+CHjbpzawVVAob5EmnTLsMt
        +MpdV4az8tWOm0fVb9mxxgzNJQLnzFMO9ieKunXRaIQ3MZQthz+uthPwGsvI92ZS//uncCw6OZS8L
        tdbDoSfNOJMYx+mHTQP2W/ZYTRy4s/oKdXNtqUksXA7cyhQXlaDCoFAIeHocLGwZbgMlbK7tsPpfX
        fegABVyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psaPF-005CRG-O6; Sat, 29 Apr 2023 02:33:49 +0000
Date:   Sat, 29 Apr 2023 03:33:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v3] migrate_pages: Avoid blocking for IO in
 MIGRATE_SYNC_LIGHT
Message-ID: <ZEyCDWaiyI9uQr5n@casper.infradead.org>
References: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:54:38PM -0700, Douglas Anderson wrote:
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Most of the actual code in this patch came from emails written by
> Matthew Wilcox and I just cleaned the code up to get it to compile.
> I'm happy to set authorship to him if he would like, but for now I've
> credited him with Suggested-by.

This all looks good to me.  I don't care about getting credit for it.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

