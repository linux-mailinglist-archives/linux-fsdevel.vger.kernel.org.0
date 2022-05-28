Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547E3536AFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiE1FwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiE1Fv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:51:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989086EB28
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UKjCnwgVjSAxgmvpOad1ohfyX8V2+jtLVHEkmdk8VFk=; b=bY8QS+QOOIWe6okmv+kTWj4jW9
        dv32lRhqw65UUhS2nZM7n2f6rWREVdX7ntBE+SSa8CW4DcG02rh3MVu1Wo+VBmbtYdN7DvueUECQD
        JC4Y53+1kThSd9h0Ay0TLgRrHICBKwfUUAaCCkSYa7MMKbo2n/TO6DscRUyMIT12xZEtWqzd9XTYz
        5ZmIPHkkQ2109OZM+6Pro6trB47OysHvsPGpa5rG/ZHMwaXs/GCqK2sXAfJfJmuQ6yHsIYVaiv3G1
        N10xbLPetKPWSlbYq85m6NooScWbQN216SZA+jZWaXyDIJtF/LKGFgsT9/SIerDgyQaZk5c7VKZod
        sLW/vYNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupMi-001VrA-9Z; Sat, 28 May 2022 05:51:56 +0000
Date:   Fri, 27 May 2022 22:51:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 11/24] ntfs3: Remove check for PageError
Message-ID: <YpG4fGpCtJEJ7JQ5@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:23PM +0100, Matthew Wilcox (Oracle) wrote:
> If read_mapping_page() encounters an error, it returns an errno, not a
> page with PageError set, so this is dead code.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
