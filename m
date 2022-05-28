Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635B536B0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiE1GHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiE1GHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:07:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A323151
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=X+KgCjQ1W3Rj1o8+P5XTfae3Cw
        nITUO/uyMe8/+Fxb2WbM4TFLZFdZtO9EE8qewOcAxqdpqN8kLub5FVNdugCQq8z+u/SRbPpbXr7g3
        5nhM5l80X4WuV3cOFzEU6xksPScF5YftFvk1kXitNYHV3Qt8j0cnO0F8SsETCbqJ/RuSuWVDsYY5J
        3pzEnP11kYz2vegTRxLuhorEEGjUAC+TrKgBtHcEKDY1pQj6taDbXhgXhrbgz83LJLi9SBkQs5+pK
        A+v7bQMhvxzkTou2jzhqDY5j1BGXjwF16OX771z6TfNwR2l4Tn2wGcMy3rbMxf6FJSsHSF8jRojEG
        8qTLYsLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupc4-001XOZ-FM; Sat, 28 May 2022 06:07:48 +0000
Date:   Fri, 27 May 2022 23:07:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 24/24] ocfs2: Use filemap_write_and_wait_range() in
 ocfs2_cow_sync_writeback()
Message-ID: <YpG8NDSWZuHWAERk@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-25-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
