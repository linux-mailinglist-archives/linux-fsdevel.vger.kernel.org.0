Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CBC15A234
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBLHiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:38:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wCE9+9k0cIj/sCEgJU+H6H7GdCKzt7M5XY5/XQbNPUA=; b=Oq56/2JHH+vK5Fu+coSALxwJ5O
        9hthi/u9zNHTKhqUM6DuR90r0F/w9KbR45QxdEic8spjJu9niMO3HsfxvyuMHM8717PMpfOUJqTMm
        v6n/lIOG8OqvDTp+sj6WiJ6iTyOSeITdpMKByZsDGIOTwIJi5MUh9IAj4TSwoCoBWFQ/+1Y5PkQ38
        0g1E0IPjZzexFXsJ0/szUSsQM1s4M/ZQOYHhR6wKxgLSsrASGogC1BxhRZPIjKphcffS9NCaEK4UO
        uua0q3/xkMk4po4gYfQ6VG2vH0+QtJz2fF37DCjGLu+JLe1o5+oNG/hQrfbfSdglwXZfr/8YTxph8
        HyQ5CTjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mb0-0006Hn-JY; Wed, 12 Feb 2020 07:38:06 +0000
Date:   Tue, 11 Feb 2020 23:38:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/25] mm: Use VM_BUG_ON_PAGE in
 clear_page_dirty_for_io
Message-ID: <20200212073806.GD7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:23PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Dumping the page information in this circumstance helps for debugging.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
