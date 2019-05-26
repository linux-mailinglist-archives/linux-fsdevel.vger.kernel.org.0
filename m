Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAC2A967
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfEZLar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 07:30:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfEZLaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 07:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jw4RVjb44Rl/ijGMDvXlIocM4n+wpJ+gzkrVGf7lYHI=; b=B9RbYvX+BRYnxapubpxxADejO
        x66DQneKUCIAI1k9L+lDLC9ViSYCqJ/BatwnGD7a0pu9TzLVeiEfNw3idbXlvzBswV7SqthuEEAIx
        Gug0nME/T60pDeZvnIb91NaU4p+NdlQz/hKNrAbTYbomQJcntR3p8L4MN4ayKwjOUxNQaxF7BFlQ9
        3yFDRJB6uQ3Ezu7wghWk0H5Wy2JN8Bzl5/fQ0ht//A36yqfOwh+QxVBk3RI4xvRrwI1GRFmHg6Wb+
        Fpau3zojmKqj2m8LJPCcW77VqLs0A6eS3vSfp/oSN0Zs/asSp3mvW7Su4ojTsUCIYBh10TTMv8Ych
        fp2CzUbbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUrMR-0002Dx-L2; Sun, 26 May 2019 11:30:43 +0000
Date:   Sun, 26 May 2019 04:30:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] infiniband/mm: convert put_page() to put_user_page*()
Message-ID: <20190526113043.GA3518@infradead.org>
References: <20190525014522.8042-1-jhubbard@nvidia.com>
 <20190525014522.8042-2-jhubbard@nvidia.com>
 <20190526110631.GD1075@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526110631.GD1075@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 04:06:31AM -0700, Matthew Wilcox wrote:
> I thought we agreed at LSFMM that the future is a new get_user_bvec()
> / put_user_bvec().  This is largely going to touch the same places as
> step 2 in your list above.  Is it worth doing step 2?
> 
> One of the advantages of put_user_bvec() is that it would be quite easy
> to miss a conversion from put_page() to put_user_page(), but it'll be
> a type error to miss a conversion from put_page() to put_user_bvec().

FYI, I've got a prototype for get_user_pages_bvec.  I'll post a RFC
series in a few days.
