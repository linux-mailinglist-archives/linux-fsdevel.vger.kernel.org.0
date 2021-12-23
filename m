Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9885E47E050
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbhLWIWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347112AbhLWIWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DF6C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h6zxa4KVZo2FdbbpsRRbAQnBSbFGahisZkxoNNZ7/NU=; b=Bh/X2ZVe0N+BcEcBXzwOXQMWFm
        TzHXm1wJgUUjqisRDsr8A/ph1EDQnEW2lM8GbUmNNscyyNTuz8Lyl8ZGw4CPCsstVFq0GrodeQtzS
        hEOxQcExu/UmkkPbz0cR8cvlSLMotI9UlgX6KpsYNCTO3hv+flbC9R98fv6UqgXpiNtizmE42epou
        S6lclDe3tfqIS7m+NzqrOUSayD1isydVWqJTDXcJB3NC2BO3KlPghxX6KX7ORzPVJYRjlLqi5lIwQ
        d8Zh8uILxIP1k4emRYp5MWPKWSIbp0E9icdPA9l8RF8k0dyvz7pecBxDCT4D/9j0PmfB9JWzNyHsG
        V2c9lJew==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMg-00CCqE-6U; Thu, 23 Dec 2021 08:22:18 +0000
Date:   Thu, 23 Dec 2021 09:22:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 41/48] filemap: Return only folios from find_get_entries()
Message-ID: <YcQxt33zWhEH51R9@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-42-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-42-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:49AM +0000, Matthew Wilcox (Oracle) wrote:
> The callers have all been converted to work on folios, so convert
> find_get_entries() to return a batch of folios instead of pages.
> We also now return multiple large folios in a single call.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
