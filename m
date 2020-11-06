Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692212A9123
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgKFIVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:21:22 -0500
Received: from verein.lst.de ([213.95.11.211]:50592 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgKFIVV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:21:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 429D168B05; Fri,  6 Nov 2020 09:21:20 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:21:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 15/18] mm/filemap: Restructure filemap_get_pages
Message-ID: <20201106082119.GI31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-16-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:42:16PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove the got_pages label, remove indentation, rename find_page to retry,
> simplify error handling.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
