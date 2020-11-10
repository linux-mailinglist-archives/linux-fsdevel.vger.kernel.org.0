Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E3B2ADE29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKJSXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:23:18 -0500
Received: from verein.lst.de ([213.95.11.211]:36899 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJSXS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:23:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8089367373; Tue, 10 Nov 2020 19:23:16 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:23:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v3 14/18] mm/filemap: Split filemap_readahead out of
 filemap_get_pages
Message-ID: <20201110182316.GE28701@lst.de>
References: <20201110033703.23261-1-willy@infradead.org> <20201110033703.23261-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110033703.23261-15-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:36:59AM +0000, Matthew Wilcox (Oracle) wrote:
> This simplifies the error handling.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
