Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B847DF38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhLWG6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346675AbhLWG6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:58:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12ECC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8CUiZzL/L040visV11dhw+lZCg+0MaFaN3+fI20SPHc=; b=xmqhtvGvU9EF9QKXjUZVbiMrMM
        zWQsQMWgmTiUSFx2YQ6/AYWERpUNJtIvCBFFdoXj+NNQLeFnnCMX32rVeWpPugtH56S962nCXi/Kn
        b7mm0E2ooB4kervLR3WwK8yLmrF5hgu719N/mY0RgtC9tBEjy2KAi6ryAqdh6+tEJPDDUnOEVzZEY
        yfqJ944S2AktyM5RrSQ7OQG/hlY8qqURcN3iB4ZSMpqNYzLt4DVMi8k8KJoItQXbmCyOvxEKpYaG4
        pn4R54DRolOLSe/IlFUAvTrbef6B6C0vXKRBQWup5mkTidYtT28HqaBLK+sP5YPwS4967p/q5FaNA
        tUkpiN9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0I3I-00Bx0y-Ks; Thu, 23 Dec 2021 06:58:12 +0000
Date:   Wed, 22 Dec 2021 22:58:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/48] mm: Add folio_test_pmd_mappable()
Message-ID: <YcQeBEtJJ+yMSPdM@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:16AM +0000, Matthew Wilcox (Oracle) wrote:
> Add a predicate to determine if the folio might be mapped by a PMD entry.
> If CONFIG_TRANSPARENT_HUGEPAGE is disabled, we know it can't be, even
> if it's large enough.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
