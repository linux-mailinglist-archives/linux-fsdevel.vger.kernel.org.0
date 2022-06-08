Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9AB543B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 20:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiFHS1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiFHS1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:27:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9742C559A;
        Wed,  8 Jun 2022 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GLjbBQoi0nk2K651V8p8IClJJzyzafU6jr5TlcGFPGc=; b=nyGKYxUUBoZkL9Aa7zrFofOzeL
        u2vEHsFFoq5lI3EIMw2S7wETkwk6EDHMV5/xFyHon9IvHnMN7ZgQw/BCuWIexav3jzavmPxg89eaY
        5NKRyAebkgJQXlBuEQ+QydhnvtSWof6lMcanBiTi1A7VuxAc3n/aVjiXethjVGJNviipVmd0ud5Oz
        E/fWVUPfForUfFbNPZpURapju3VAXWnSmQt3HhFDQIl1CtCDbE1nJtvqh1LLzadWVcmmsYQPkJgQz
        zZjQI6K5FoYJkhuTHJ8VdpGR8rfWtQHsHamcOKrZE4ddAd/0y/Se0xVmMxEAwQDY+5dD4Pb9sFL6a
        XWtTrhWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz0Ou-00Crrj-LR; Wed, 08 Jun 2022 18:27:28 +0000
Date:   Wed, 8 Jun 2022 19:27:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     djwong@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        david@fromorbit.com
Subject: Re: [PATCH v2] iomap: skip pages past eof in iomap_do_writepage()
Message-ID: <YqDqEF9kbqDdRBW+@casper.infradead.org>
References: <20220608004228.3658429-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608004228.3658429-1-clm@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 05:42:29PM -0700, Chris Mason wrote:
> iomap_do_writepage() sends pages past i_size through
> folio_redirty_for_writepage(), which normally isn't a problem because
> truncate and friends clean them very quickly.
[...]
> Signed-off-by: Chris Mason <clm@fb.com>
> Co-authored-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
> Reported-by: Domas Mituzas <domas@fb.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
