Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423B03A8764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhFORTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 13:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhFORTj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:19:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA48610A3;
        Tue, 15 Jun 2021 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623777453;
        bh=FvCM78FDA0nuQsM35syiDCkhAo8LGtjDyrtDMKFTAbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYrf+OahTLnIf3sYpBD4geUut9D6yd33TVGXNeiOJUr6tlh2z7h8PSDMpivSUOqm9
         eJSKJFU4KCLCdwF+wFnR3So6eBApK7DGAV2FFPvbToqJWaiGiCQdDp3fwZkO11xfNJ
         F2inAFGPaaf0W+RFPSBwcbisCIHBFHLP2WkkPlbM=
Date:   Tue, 15 Jun 2021 19:17:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/writeback: Move __set_page_dirty() to core mm
Message-ID: <YMjgq3QwL+pBcuth@kroah.com>
References: <20210615162342.1669332-1-willy@infradead.org>
 <20210615162342.1669332-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615162342.1669332-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:23:37PM +0100, Matthew Wilcox (Oracle) wrote:
> Nothing in __set_page_dirty() is specific to buffer_head, so
> move it to mm/page-writeback.c.  That removes the only caller of
> account_page_dirtied() outside of page-writeback.c, so make it static.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c         | 24 ------------------------
>  include/linux/mm.h  |  1 -
>  mm/page-writeback.c | 27 ++++++++++++++++++++++++++-
>  3 files changed, 26 insertions(+), 26 deletions(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
