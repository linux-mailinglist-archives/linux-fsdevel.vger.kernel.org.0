Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F02A3D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCH1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:27:03 -0500
Received: from verein.lst.de ([213.95.11.211]:35975 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCH1D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:27:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD71B67373; Tue,  3 Nov 2020 08:27:00 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:27:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 01/17] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201103072700.GA8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:56PM +0000, Matthew Wilcox (Oracle) wrote:
> The recent split of generic_file_buffered_read() created some very
> long function names which are hard to distinguish from each other.
> Rename as follows:
> 
> generic_file_buffered_read_readpage -> filemap_read_page
> generic_file_buffered_read_pagenotuptodate -> filemap_update_page
> generic_file_buffered_read_no_cached_page -> filemap_create_page
> generic_file_buffered_read_get_pages -> filemap_get_pages

Find with me, although I think filemap_find_get_pages would be a better
name for filemap_get_pages.
