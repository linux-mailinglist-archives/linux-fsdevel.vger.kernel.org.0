Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B918536AFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349008AbiE1FtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbiE1FtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:49:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D75561631
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sNf6V5APhdWYjUjlBBfjBB6dn815d19Xny6vDUcgK1g=; b=VN2kHnfx9HLxEk+Vd2IcT0Q6xY
        E77xSCJQ+pDrL5sQwy1+rsFepkYeVe4/8y/W5Q/m9uUwbeN8SQ73hphsCjHBFqhN9oH+z9Tq7Mzub
        SZ9aOKKIpkftnxGvcCdmp6ggbmh7smt4RUXwBdWztJfQLvom4lmetzwgRQHRhqq8dsbumf2Jys8LN
        b312KTYmCvXZTcKeMEkyqINJSeMij+TBnHIg1IMPfCb6A8x5FH2S8xvXYwWzepQVjB9R81poynfsT
        Khv6i+7dVzNM7cg9MjNMOTKsMVtiwR8KEb3sV82b8fgwAc8JMHRLrJ1F/BokN9sDGP5vD9xcWmS44
        MsKycPaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupKC-001VV1-6s; Sat, 28 May 2022 05:49:20 +0000
Date:   Fri, 27 May 2022 22:49:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/24] nilfs2: Remove check for PageError
Message-ID: <YpG34JMjWs3nJN7q@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:21PM +0100, Matthew Wilcox (Oracle) wrote:
> If read_mapping_page() encounters an error, it returns an errno, not a
> page with PageError set, so this test is not needed.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
