Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A666BB667
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 15:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCOOqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCOOqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:46:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186B8F73B;
        Wed, 15 Mar 2023 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4S3XVxpATHJONpTD39rYznbyHkN4BWTWM3r05Ibro0k=; b=ZWHEtZ16w2+detW7cVl81jaxFC
        fs+chfLFoFcwTb49WuJNlAGUFz/m2YWyc5ZlPLwyWY8t74pMkdDBdQOiPvyCywKFAcTvWvzl6F2hT
        cPPzmSsDbgKavXOjcX1SnqkiUhPh5hpNZPHsAjeSk7JqONWGhjClRkFavct2WQxYdPozEZCUuvWex
        hvd8tK+HCxmfabDn/OKIzi4tqE8UqlHDmgjbbRJpJL45SDoRTED3m4fiLQKLGF+fh1InGw1vmu8Vg
        ew/DmNYm8NaVpWJ7/0S2ifbrZ1LTSanmcTVS1sbuVIayXvzaT9/BHSrmLXXzop1bJwhflgitEHkSt
        xCK7cimQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSOF-00DeFR-1q;
        Wed, 15 Mar 2023 14:46:07 +0000
Date:   Wed, 15 Mar 2023 07:46:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, devel@lists.orangefs.org
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Message-ID: <ZBHaL0eS95H0CIJQ@bombadil.infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
 <20230315123233.121593-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315123233.121593-2-p.raghav@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:32:31PM +0100, Pankaj Raghav wrote:
> page_endio() already works on folios by converting a page in to a folio as
> the first step. Convert page_endio to folio_endio by taking a folio as the
> first parameter.
> 
> Instead of doing a page to folio conversion in the page_endio()
> function, the consumers of this API do this conversion and call the
> folio_endio() function in this patch.
> The following patches will convert the consumers of this API to use native
> folio functions to pass to folio_endio().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Perhaps the hard thing is what tree would this go through?

  Luis
