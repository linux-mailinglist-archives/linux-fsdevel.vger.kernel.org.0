Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498AF3A8767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFORUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 13:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhFORUa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:20:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39D8E610A3;
        Tue, 15 Jun 2021 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623777504;
        bh=OTeIpnlbmEOuRgRThJIc88vJl58mB6IWNEX0RuqGK60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdBrPg3aibA0JngjxDs++a4xepIPRU8hfGmxtEmHBNIvxL2I9+27wUIJ7yMjESldn
         meAr5TJOB1Gfo8mPlTe4adizyiqD283YwwSj8Vu+nEqZfoafTGbHBAF26l06VC/OQw
         9Mm6rYvAkoCIe9arYQ5X2TPgkwNjQNTEJ5QTNQp0=
Date:   Tue, 15 Jun 2021 19:18:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/writeback: Use __set_page_dirty in
 __set_page_dirty_nobuffers
Message-ID: <YMjg3skhw0hBSg8f@kroah.com>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615162342.1669332-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:23:38PM +0100, Matthew Wilcox (Oracle) wrote:
> This is fundamentally the same code, so just call it instead of
> duplicating it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/page-writeback.c | 10 +---------

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
