Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0A536AFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiE1FwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiE1FwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:52:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4B2528F
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KmqNJ6E2qsxHF9GpvNIzcsovm7YlBdqPdFhTr3BZhlo=; b=oWM5PbXdfLYYrvc/5k8whG0dS7
        3JGdjRxHOfuO9uZT0Y6X+lC2A+xZ0qzKaX/EKjW5NRSDB/8pcWS2q/YGAE7fb7kvmPqG9p6vzXfMt
        9t9O6Pd2vaU4ni43ahiuMSrGVor4OMHIAAH+xxiyTwtBwB/ApOHS9iHnp8YeMQwhy5pm+NQZ3n/Nu
        Kcc/ezfokXacd0PIdz8gB98YM5zwB/zJwqR2E8Uj2zx2HAa5FEac1Mmm0xqi5rR/E5oEBQn69KtSV
        9RsWnGM79Ci22imJb+7XpdVALX/+4KfbckiYx5P3jHrykvoYP253LPuKCpKG3pmXpzPu+3Vv8RVa3
        qmDCBnUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupN1-001VuF-0q; Sat, 28 May 2022 05:52:15 +0000
Date:   Fri, 27 May 2022 22:52:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 12/24] reiserfs: Remove check for PageError
Message-ID: <YpG4j3gqbz01Cn0j@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:24PM +0100, Matthew Wilcox (Oracle) wrote:
> If read_mapping_page() encounters an error, it returns an errno, not a
> page with PageError set, so this is dead code.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
