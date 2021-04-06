Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFA3555A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhDFNrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhDFNru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:47:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBDC06174A;
        Tue,  6 Apr 2021 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ni6B9KzrCyheOPsEho1ki6QWZDMFl2x0E/J0ShltZWg=; b=t9GEyFGtKuxePLD/ZN6jdIH0u3
        ybog8zN64hyLPKb6Du3rUufWStax3XJ9rqZun090Jh7JjLOOSqTB6KTzCNVCgyqpv99tswQxYs+rd
        d5SAjG2Ma8z/WdraPHAnOf9OJnOxP1RpBN8kyXXG6h4HHOuyAvq4rGUqq+EuHKnUlYNu/nPBIKu4Q
        hMtHNy49NNdBoym18f9a1LdAbmD40FuJLG3LTWumxKsZQhzpHpBHvkwIq2CRzfGQMa/vm+aEDxKpM
        U0cwBr1dKqnILgxV4FZMrGL8MYDySeDIB+m+VUexU87pk7vRHH5NNRzrfJ/y6kMpr2u8CEGt2cyuP
        P/sL1KOw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTm2i-00Csw1-G2; Tue, 06 Apr 2021 13:47:07 +0000
Date:   Tue, 6 Apr 2021 14:46:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 14/27] mm: Add folio_mapcount
Message-ID: <20210406134656.GM3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:15PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_mapcount().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
