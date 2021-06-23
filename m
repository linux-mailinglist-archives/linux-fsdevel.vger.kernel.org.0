Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F83B1511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFWHtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWHtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:49:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB758C061574;
        Wed, 23 Jun 2021 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wUw1g0/VVyf211dDpWnMj9SGpNpwQj5eaZklh1OLBx8=; b=LfV+4IKhkaAjCYSU8QNQ669CRe
        U19YDuputEkXjh1Gw2yKG4vuXclY4Obnw05fsEBvAB6xHCmYBFvG68c/zB5lMe525eVsCEMmI/EbC
        E4WY3kuL+BxY7QTmOy2q3yN65gtEdRQfhmhXX6RcFRylIxdf5hGfD+e+31v5EImS+CXcywL0/wyTD
        Xy3ag9QOB6xixo00Th9spfkmqc8Xbf2Z7M7TCv+ZiOQseQrP3B+74nU0o7l+e7yplacYXyVLEi5/6
        nteXx2z4z9vR3kwMYbocgnJdAo9e0Gpv4bSmLxA45eZ2XmsgRH2W5TOds/d7o+sbDIvzaLnK4dskW
        SpCjH8Qw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxb5-00FAr9-8W; Wed, 23 Jun 2021 07:47:02 +0000
Date:   Wed, 23 Jun 2021 08:46:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/33] mm: Convert get_page_unless_zero() to return
 bool
Message-ID: <YNLm7wXtTHFjzce6@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:40:46PM +0100, Matthew Wilcox (Oracle) wrote:
> atomic_add_unless() returns bool, so remove the widening casts to int
> in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
> to produce slightly larger code in isolate_migratepages_block(), but
> it's not clear that it's worse code.  Net +19 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
