Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766583A86A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFOQkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:40:03 -0400
Received: from verein.lst.de ([213.95.11.211]:50334 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFOQkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:40:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF64768AFE; Tue, 15 Jun 2021 18:37:56 +0200 (CEST)
Date:   Tue, 15 Jun 2021 18:37:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] fs: Remove anon_set_page_dirty()
Message-ID: <20210615163756.GD1600@lst.de>
References: <20210615162342.1669332-1-willy@infradead.org> <20210615162342.1669332-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615162342.1669332-5-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:23:40PM +0100, Matthew Wilcox (Oracle) wrote:
> Use __set_page_dirty_no_writeback() instead.  This will set the dirty
> bit on the page, which will be used to avoid calling set_page_dirty()
> in the future.  It will have no effect on actually writing the page
> back, as the pages are not on any LRU lists.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
