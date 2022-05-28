Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36772536AF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiE1Fr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiE1Fr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:47:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4407613DD7
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mONrJIgsC+ftVFSvdH1KiA8xTtfiFd2tBeS46w9EXC4=; b=k0rmMFDk31kEqtqq3nrJCaXpDq
        s3Dql5xGlltV5WjEdwBaK7h1OltYEM/6ysHUHI7mHfLStY6bEK9Yeio3jZyFp03OhFwQNTFQgEXVe
        cB0UiUfW4j7wtB+ZQkmqobIjHHq9qgpAtybExT0NhNcG4yEPXCWFL1JvDXuqQI5lFLn3zsmqYrCMi
        LmDf1OxaHysZohmHUrTESVyuCOPyTHfKBiucrNQomko3gJjqcNLmxCPG6ylAVm+CmqFXtrscT5S6Z
        yMlBrtrYaNtH/khEDLBEnPK0Ea2F8YnkfsH7DiZyrxEFmQu1CUk0Vuxp7KP9xUFQwyu0xKt17RSc0
        gbJPHcjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupIK-001VCm-KV; Sat, 28 May 2022 05:47:24 +0000
Date:   Fri, 27 May 2022 22:47:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/24] block: Remove check of PageError
Message-ID: <YpG3bFFsuPnpaQIa@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:13PM +0100, Matthew Wilcox (Oracle) wrote:
> If read_mapping_page() sees a page with PageError set, it returns a
> PTR_ERR().  Checking PageError again is simply dead code.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
