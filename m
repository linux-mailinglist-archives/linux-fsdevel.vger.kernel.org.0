Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1374B4EC77C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiC3Ozq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiC3Ozn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:55:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3514A93F
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u95Z4eGSLOUPfxdl1nUkB2snGcH09BQn7u4oXfCTlqM=; b=BQ7XlgVy5bgJvC9I9F3RGvfk//
        L5dWiWhounpmi/0kTRjt3hKpS5Lrz9LVEYOJDuOs+7xGXzVke1++Wn4mpTDu6RmLdFw6Ur1pBcedS
        WUXkTym1QAV+wL6ZZ1wxxhzgjxfm7CQ0nz6KlVhkeiYqCZ/e9op0apjW9Jswj03OFX57qcuz2nhwG
        tXEfSfvRBFAqGUGmie904wab1WLvOAcijEMjXnmqytonjsGqoNae2fD1+s0VkJfdjjArLh4u7Zl/2
        9VpGOSdtMxx1G6hTzePpQxRjjONl2PlRWRiF2wBku12JTImOyxCv+Vj1Jw9xt1nfXYHwAIOJtWG76
        cgIdrdww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZhs-00GKWT-FX; Wed, 30 Mar 2022 14:53:56 +0000
Date:   Wed, 30 Mar 2022 07:53:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/12] btrfs: Remove a use of PAGE_SIZE in
 btrfs_invalidate_folio()
Message-ID: <YkRvBHmmNZU2StKQ@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
 <20220330144930.315951-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330144930.315951-13-willy@infradead.org>
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

On Wed, Mar 30, 2022 at 03:49:30PM +0100, Matthew Wilcox (Oracle) wrote:
> While btrfs doesn't use large folios yet, this should have been changed
> as part of the conversion from invalidatepage to invalidate_folio.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
