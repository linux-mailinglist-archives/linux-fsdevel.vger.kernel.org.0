Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187035553D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbhDFNeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbhDFNeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAD3C06174A;
        Tue,  6 Apr 2021 06:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=znOL7ioDGtnmyjiPOvEtDBDkmZPLJRoNmnt6uxg81Xk=; b=Y29lZVuGVQlcopk1iYJf8/qoO9
        jg6b48kEBF1iqvTL39gZ+zKKtE0zy4JrnZUnHExFvgvlEDeRIBD5RDgYQR06V4hzs78aRT0Er4g5k
        ImEd+n+CXEVUsghSiQEgSAgMrPjFZ9y1tTeYuxhjdPQbgg2LWyjTJ5e3XirLW9T1LJLt17Yx1P5h/
        etGTPFO8VtyV8AAGswECSvKdgsIy4CZGriv6SgTmCkBjIgf8qOZZwZtZwt2YVB1Y705Gyjt68otUx
        S+OjFyjz5TKdDQgTXvXZzgo5nIHlV/aw8MaYtqji6vDXJwrtH8PsSfseT3cxsBoo+ATU8IzsGWFXs
        j8Kb6qDA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlp8-00Creq-Bv; Tue, 06 Apr 2021 13:33:01 +0000
Date:   Tue, 6 Apr 2021 14:32:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v6 07/27] mm: Add get_folio
Message-ID: <20210406133254.GF3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:08PM +0100, Matthew Wilcox (Oracle) wrote:
> If we know we have a folio, we can call get_folio() instead
> of get_page() and save the overhead of calling compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
