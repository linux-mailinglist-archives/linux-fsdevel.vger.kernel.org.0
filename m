Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7B442818
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBHTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBHTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:19:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8066C061714;
        Tue,  2 Nov 2021 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bL8ZfuWb+zjIDH0O5SdyK9V15OEbRWOKPoBMcbtUXwY=; b=XrMw6wNxvczpRWUv5nckgKT/qY
        KSMigTHI8VPjzqK14yHrzjP7ott9zMMImgYPVB7ecowlqcbDDgMsty0/3YY17K6L5BLaEzc3Fw/BD
        12//cXMbrrZRlBKlfwwLywuTUejy34PpUvYtWIjDsE0tRYgETuIBBdrxZUSocjBNjkNITFjmn+LL3
        IlXIRyuYPIlukwGGgsaPWlWc2JH1GsN0fOlTxTgJxAMtPgcmT/Fd8+H1wMmzWjwX1m+At7kbQjvY4
        6X2jYNCj93RegPwqMXFegFNlNbY972NXLk8EHRrA2XyPpjEleqqk6db30K6TKtqVkG0eS/9swvfSx
        luvmxIpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho2a-000kcQ-Gl; Tue, 02 Nov 2021 07:17:04 +0000
Date:   Tue, 2 Nov 2021 00:17:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/21] iomap: Convert bio completions to use folios
Message-ID: <YYDl8Oywa3oektq7@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:18PM +0000, Matthew Wilcox (Oracle) wrote:
> Use bio_for_each_folio() to iterate over each folio in the bio
> instead of iterating over each page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
