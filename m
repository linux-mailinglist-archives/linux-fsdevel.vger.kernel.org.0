Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE32A3DA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgKCH2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:28:07 -0500
Received: from verein.lst.de ([213.95.11.211]:35982 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCH2H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:28:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96A5C67373; Tue,  3 Nov 2020 08:28:05 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:28:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 02/17] mm/filemap: Use THPs in
 generic_file_buffered_read
Message-ID: <20201103072805.GB8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-3-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:57PM +0000, Matthew Wilcox (Oracle) wrote:
> +static unsigned mapping_get_read_thps(struct address_space *mapping,
> +		pgoff_t index, unsigned int nr_pages, struct page **pages)

This function could really use a comment describing it, as the name
isn't overly descriptive.

> +{
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	struct page *head;
> +	unsigned int ret = 0;

I'd rename ret to nr_found to be a little more descriptive.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
