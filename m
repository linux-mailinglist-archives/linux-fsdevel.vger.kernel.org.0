Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA96536B0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 08:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiE1GGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiE1GGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 02:06:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8C10F8
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikgu9SvRIibqXizppF6tmD+Q1abJ18DzQavcED7bHFU=; b=LQ26/G84G8OH6uhNcfpGi/XO2q
        /0ieiKTGykinEHPGm/w66SXN1mpBRrwaCtrrZKcm5+PSqnk7RG7wy/n12XnWGPWtylYj3HFfRXebG
        zg05gcOUPOxJ3BL32bPxdXPGR+zP4SJGxJ/qhPRmKB7Hy4yYNj4YjveZfECpQBsrgYcf8uMb1IjRv
        dcEywPaSww/H4Nt1rJOQPtj5jMTVCARMwJrYJGtn+koa6s3XXmQ4Bubam0Pz3q8ygEEpq9jKeRMZ7
        WP7xFobLREorVezkfXGiw0cU+/sZ/hHy1ec1qN0Mx9u/6UGUD/84ZDtot3Suu3z69fRr6zu02XXT7
        akVDlPfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupaU-001XFu-U4; Sat, 28 May 2022 06:06:10 +0000
Date:   Fri, 27 May 2022 23:06:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 22/24] squashfs: Return the actual error from
 squashfs_read_folio()
Message-ID: <YpG70qrO8syRu66E@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-23-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:34PM +0100, Matthew Wilcox (Oracle) wrote:
> Since we actually know what error happened, we can report it instead
> of having the generic code return -EIO for pages that were unlocked
> without being marked uptodate.  Also remove a test of PageError since
> we have the return value at this point.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
