Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484C7355632
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbhDFOOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbhDFOOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:14:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5875C06174A;
        Tue,  6 Apr 2021 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sW2y093nFNEIVmRMn1QkeEs0LwLNK5xSldsHE5h9ZOM=; b=oVysegC+dFydqmBJ0Byn5gAzg+
        A4X43UInM3ZxUMbOYHtO0IGNAQBlWH4n3ELfVtf1pSU8lVt3e+FXqu1ONsj+6ZScylr8v5YiyI1IZ
        QmvJ23g0LstpSSoZ6nK2ELlIc2r+XqVVhZeG6zS2eYg4tAyA9bE95Em6nCYtj2s9B5a+h1liXzIRn
        zAX9NPiOHzPHEbnCHUme0KSwP4206wkrvBogXBtY/SHNjssg+gHmME/e9Pn82HJ4EbuqpN8jwPWoK
        S2Y8GIaz9bqQc3Ubeie3q9oNwBWIMnfnHNjUNVsuFwIuFZQqkdFODJsT82gKylHGnN8cbItx2dvBj
        bz8tASKg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmSM-00Cuq9-3M; Tue, 06 Apr 2021 14:13:31 +0000
Date:   Tue, 6 Apr 2021 15:13:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 22/27] mm/filemap: Add end_folio_writeback
Message-ID: <20210406141326.GU3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-23-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:23PM +0100, Matthew Wilcox (Oracle) wrote:
> Add an end_page_writeback() wrapper function for users that are not yet
> converted to folios.
> 
> end_folio_writeback() is less than half the size of end_page_writeback()
> at just 105 bytes compared to 213 bytes, due to removing all the
> compound_head() calls.  The 30 byte wrapper function makes this a net
> saving of 70 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
