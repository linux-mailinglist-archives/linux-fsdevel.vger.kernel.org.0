Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB11D35BA03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 08:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhDLGJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 02:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhDLGJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:09:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F345AC061574;
        Sun, 11 Apr 2021 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GywHkOLrasVBNoqe3gfhRiHwBQaMUJxlYFZFdFLZaXE=; b=uCwo7vYqo28RSa2F6lR63xbLj0
        w8cO21ZeLzAwi2gbRHbBFaafXZb3gSD0WWVn+GofK9LWm7xZXtlCPOG4G47dQgDGVFgdpijOvGAbP
        Fbh9mxn/qetjiVxmPXXvEekobLUGkCIVQWm/KA1hPCZleTksPO6RJRZXkbpzPYvReZzMtdNz2io30
        ZcEvqg8o9AuIwwLb+yLyCA9kcdCt8AdzPzhncctBL9PPV0gzYqPaG4mhUMTbuf6V3UY10NZj9Dcma
        EX6zMheUy6vgTKTJ8y0vH/qPTa6q5wUvSEQJT1/o8tlT471aw21dIPA8rCUix/djNQVG+HomJHT60
        F28IY5cw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVpkX-003s0z-6U; Mon, 12 Apr 2021 06:08:42 +0000
Date:   Mon, 12 Apr 2021 07:08:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v7 01/28] mm: Optimise nth_page for contiguous memmap
Message-ID: <20210412060841.GA922513@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
 <20210409185105.188284-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409185105.188284-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:50:38PM +0100, Matthew Wilcox (Oracle) wrote:
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
