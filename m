Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D124B6420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiBOHQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:16:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiBOHQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:16:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86623C2E77
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rCLWEOZIWxt9LKEf3abFS6lCPWMAX6uZAZ7yw6FyVzI=; b=O7petTukc3UzZLlPSQIoji4Q8d
        eO4+jzLJupEI6h6lOKrpX9aaDlXxZdLwGg2OmF4Xxm5Am63eDsh7Wu8dxrJn7lGywlcjSn/9rHycL
        DvKUgw9RNgbZerUsdvnsEPS3c5Y6Wb0ZZSaVfv1wZNTWCBwBere1lINe6WkPy/v8RE1W3rSH19pOk
        ieyA710xXC7GaWxlVJ5yFb3sAfYnJ5ulLPQcILlpqUQqd4BPCYdTqwVGrTn2nY713y2IVUCwYEHYM
        7dzU/3M+4udPZa2P6Wx+MLEhiM5hMxXbAEuCcTedjEALof2tN8l8GrPFiXy7gg895n1KU4bco+VGN
        +ZpXPsuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJs40-0015NK-4D; Tue, 15 Feb 2022 07:15:52 +0000
Date:   Mon, 14 Feb 2022 23:15:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/10] splice: Use a folio in
 page_cache_pipe_buf_try_steal()
Message-ID: <YgtTKJuiIXGKdP5p@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 08:00:08PM +0000, Matthew Wilcox (Oracle) wrote:
> This saves a lot of calls to compound_head().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
